<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 <!---<cfinclude template="../includes/menu_bar_bid.cfm"> --->


 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>
 <!--- Check for new message --->


<cfparam name="seller_userid" default = "">

<cfif isDefined('New')>
  <cflocation url="send_message.cfm">
</cfif>


 <!--- Check for page submit --->
 <cfif (#isDefined ("submit")# is 0)>
  <cfset #submit# = "">
   <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>

 <!--- Verify their username and password --->
 <cfif #submit# is "Next >>">
  <cfquery username="#db_username#" password="#db_password#" name="verify_login" datasource="#DATASOURCE#">
   SELECT user_id, confirmation
     FROM users
    WHERE nickname = '#user_id#'
    <cfif #isNumeric (user_id)# is 1>
       OR user_id = #user_id#
    </cfif>
      AND password = '#password#'
	  and is_active = 1
  </cfquery>
  <cfif #verify_login.recordCount# is 0>
   <cfoutput><cflocation url="#cgi.http_referer#index.cfm?failed=1"></cfoutput>
   <cfelse>
   	<cfif verify_login.confirmation eq 0><cflocation url="index.cfm?failed=2"></cfif>
   <cfset #session.user_id# = #verify_login.user_id#>
   <cfset #session.password# = #password#>
  </cfif>
 </cfif>

 <!--- Check for invalid access --->
 <cfif #isDefined ("session.user_id")# is 0>
  <cflocation url="index.cfm">
 </cfif>

 <!--- Delete messages if needed --->
 <cfset #error_msg# = "">
 <cfif #submit# is "delete">
  <cfif #isDefined ("flagged")# is 0>
   <cfset #error_msg# = "Please flag one or more messages before clicking 'delete'.">
  <cfelse>
   <cfloop list="#flagged#" index="idx">
    <cfquery username="#db_username#" password="#db_password#" name="delete_message" datasource="#DATASOURCE#">
     DELETE FROM messages
      WHERE message_id = #idx#
    </cfquery>
    
    <!--- log message deleted --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Message Deleted"
      details="ID: #idx#"
      user_id="#Session.user_id#">
      
   </cfloop>
  </cfif>
 </cfif>

 <!--- Check for their messages --->
 <cfquery username="#db_username#" password="#db_password#" name="check_messages" datasource="#DATASOURCE#">
  SELECT messages.from_user_id as from_user_id,
         messages.message_id as message_id,
         messages.message as message,
         messages.is_read as is_read,
         messages.is_new as is_new,
         messages.is_flagged as is_flagged,
         messages.subject as subject,
         messages.to_user_id as to_user_id,
         messages.ref_message_id as ref_message_id,
         messages.priority as priority,
         messages.when_sent as when_sent,
         users.nickname as nickname
    FROM messages, users
   WHERE messages.to_user_id = #session.user_id#
     AND users.user_id = messages.from_user_id    
 </cfquery>

 <!--- Count new messages --->
 <cfquery username="#db_username#" password="#db_password#" name="check_new" datasource="#DATASOURCE#">
  SELECT message_id
    FROM messages
   WHERE to_user_id = #session.user_id#
     AND is_new = 1
 </cfquery>


<cfset message_id = "">
<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Personal Message Center: Main Page</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

<cfoutput>
<cfinclude template="../includes/bodytag.html">
<!--- <body onLoad="popupWindow ('send_message.cfm?seller_userid=#seller_userid#', 'sendMsgWindow', 500, 320)"> --->
<body onLoad="msg2seller()" onUnload="">



 <!--- Some JavaScript for the "send message" button --->
 <script language="JavaScript">


var opened = false
var popup,parm
function msg2seller(){
  if ("#seller_userid#" != ""){ 
     openPopup()
  }
}


function openPopup(parm){
  if (!opened) {
    opened = true
    if (("#seller_userid#" != "")&&(parm != "new")){
	  <cfif isdefined("itemnum")>    
      openWindow ('send_message.cfm?seller_userid=#seller_userid#&itemnum=#itemnum#', 'sendMsgWindow', 500, 320)
	  <cfelse>
	  openWindow ('send_message.cfm?seller_userid=#seller_userid#', 'sendMsgWindow', 500, 320)
	  </cfif>
    }else{
      openWindow ('send_message.cfm', 'sendMsgWindow', 500, 320)
    }      
  }else{
    if (popup.closed){
      if (("#seller_userid#" != "")&&(parm != "new")){
	    <cfif isdefined("itemnum")>
        openWindow ('send_message.cfm?seller_userid=#seller_userid#&itemnum=#itemnum#', 'sendMsgWindow', 500, 320)
		<cfelse>
	  	openWindow ('send_message.cfm?seller_userid=#seller_userid#', 'sendMsgWindow', 500, 320)
	  	</cfif>
      }else{
        openWindow ('send_message.cfm', 'sendMsgWindow', 500, 320)
      }        
    }else{
      popup.focus()
    }
  }
}


function readMsgPopup(message_id){
  if (!opened) {
    opened = true
    if (message_id != ""){ 
      theString = "openWindow('read_message.cfm?message_id="+message_id+"', 'readMsgWindow', 500, 320)"
      eval(theString)
    }      
  }else {
    if (popup.closed){
    if (message_id != ""){ 
      theString = "openWindow('read_message.cfm?message_id="+message_id+"', 'readMsgWindow', 500, 320)"
      eval(theString)
    }        
    }else{
      popup.focus()
    }
  }
}

function openWindow (URL, name, width, height) {
  popup = window.open (URL, name, "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
}     
  
 
 </script>
<cfinclude template="../includes/menu_bar.cfm">
  <!--- The main table --->
  <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4 color="000000"><b>Personal Message Center</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       <b>Inbox (#check_messages.recordcount# message<cfif #check_messages.recordcount# GT 1>s</cfif>, #check_new.recordcount# new):</b><br><br>
       <cfif #error_msg# is not "">
        <font color="ff0000">#error_msg#</font><br><br>
       <cfelseif #submit# is "Delete">
        <font color="0000ff">#listLen (flagged)# message<cfif #listLen (flagged)# GT 1>s</cfif> deleted.</font><br><br>
       </cfif>
       <form action="main_page.cfm" method="post">
   
       
       
       
       
        <table border=1 bordercolor=000080 cellspacing=0 cellpadding=3>
         <tr bgcolor=#header_bg#>
          <td width=75><font size=2 color="0C2454"><b>Message ID</b></font></td>
          <td width=200><font size=2 color="0C2454"><b>Subject</b></font></td>
          <td width=150><font size=2 color="0C2454"><b>From</b></font></td>
          <td width=75><font size=2 color="0C2454"><b>Date Sent</b></font></td>
          <td width=60><font size=2 color="0C2454"><b>Priority</b></font></td>
          <td><font size=2 color="0C2454"><b>Flag</b></font></td>
         </tr>
         <cfloop query="check_messages">
          <tr>
<!---      <td><a href="##" onClick="openWindow ('read_message.cfm?message_id=#message_id#', 'readMsgWindow', 500, 320);">#message_id#</a></td> --->
           <td><a href="##" onClick="readMsgPopup(#message_id#)">#message_id#</a></td>

           <td>#subject#</td>
           <td>#nickname#</td>
           <td>#dateFormat (when_sent, "dd-mmm-yyyy")#</td>
           <td>#priority#</td>
           <td align="center"><input type="checkbox" name="flagged" value="#message_id#"></td>
          </tr>
         </cfloop>
        </table>
        <br>
        <table border=0 cellspacing=0 cellpadding=0>
         <tr>
          <td><input type="button" name="New" value="New..." width=80 onClick="openPopup('new')"></td>
          <td width=5>&nbsp;</td>
          <td><input type="submit" name="submit" value="Refresh" width=80></td>
         <cfif #check_messages.recordcount# GT 0>
          <td width=5>&nbsp;</td>
          <td><input type="submit" name="submit" value="Delete" width=80></td>
         </cfif>
         </tr>
        </table>
       </form>
      </font>
     </td>
    </tr></table>
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>
  
  
  
 </body>
</html>