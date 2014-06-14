

<html>
 <head>
  <title>Message Composer</title>
  <link rel=stylesheet href="../includes/stylesheet.css" type="text/css">
 </head>

 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
<!--- 
<cfif isDefined('form.user_id')>
<cfset session.user_id = form.user_id>
</cfif> --->
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  <!--- local variables --->
  <cfparam name="flagsubjectcount" default="0">
  <cfparam name="flagbodycount" default="0">
  

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Load this module for creating unique IDs --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">
 
 
 <!--- Verify their username and password --->
 <cfif isDefined('submit')>
 <cfif #submit# is "Next >>">
  <cfquery username="#db_username#" password="#db_password#" name="verify_login" datasource="#DATASOURCE#">
   SELECT user_id
     FROM users
    WHERE nickname = '#user_id#'
    <cfif #isNumeric (user_id)# is 1>
       OR user_id = #user_id#
    </cfif>
      AND password = '#password#'
	  and is_active = 1
  </cfquery>
  <cfif #verify_login.recordCount# is 0>
   <cflocation url="index.cfm?failed=1">
  <cfelse>
   <cfset #session.user_id# = #verify_login.user_id#>
   <cfset #session.password# = #password#>
  </cfif>
 </cfif>
 <cfelse>
 
 </CFIF>











 <!--- Check for invalid access --->
 <cfif #isDefined ("session.user_id")# is 0>
  <cflocation url="index.cfm">
 </cfif>


 <!--- Check for submission --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>


 <cfif #submit# is "Send">
 



 <cfif #len(subject)# is 0>
   <cfset #subject# = "No subject">
 </cfif>
 
 
 
 
 
  <cfquery username="#db_username#" password="#db_password#" name="write_message" datasource="#DATASOURCE#">
   INSERT INTO messages (from_user_id,
                         message_id,
                         message,
                         is_read,
                         is_new,
                         is_flagged,
                         subject,
                         to_user_id,
                         ref_message_id,
                         priority,
                         when_sent)
    VALUES ('#session.user_id#',
            #EPOCH#,
            '#message#',
            0,
            1,
            0,
            '#subject#',
            '#mail_to#',
            0,
            '#priority#',
            #NOW ()#)
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" NAME="get_from" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
    SELECT email, nickname FROM users
     WHERE user_id = #session.user_id#
     <cfif isDefined('url.from')>
        OR nickname = '#url.from#'
     </CFIF>
  </CFQUERY>
  
  <cfquery username="#db_username#" password="#db_password#" NAME="get_to" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
    SELECT email,nickname FROM users
     WHERE user_id = #mail_to#
     <cfif isDefined('url.send_to')>
        OR nickname = '#url.send_to#'
     </CFIF>
  </CFQUERY>
  
  <CFMAIL TO="#get_to.email#" FROM="customer_service@#domain#" SUBJECT="#subject#">
  You have a message from #get_from.nickname#<cfif isdefined("itemnum") and itemnum gt 0> regarding auction item (#itemnum#)</cfif>. Priority: #priority#
  
 Click here to view message.
 http://#site_address#/messaging/index.cfm?from=#get_from.nickname#&send_to=#get_to.nickname#

 <cfif isdefined("itemnum") and itemnum gt 0>
  Click here to view item.
  http://#site_address#/listings/details/index.cfm?itemnum=#itemnum#
 </cfif>

</CFMAIL>
<cfif isdefined("itemnum") and itemnum gt 0><cfset itemnum = 0></cfif>
<!---
  <!--- log message sent --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Message Sent"
    details="ID: #EPOCH#     TO: #mail_to#     SUBJECT: #subject#     PRIORITY: #priority#     MESSAGE: #message#"
    user_id="#Session.user_id#">
--->
   </cfif>
   

<!---  <body bgcolor='dddddd' onBlur='self.focus()'> --->
<body bgcolor='dddddd'>

  <!--- Get a list of users --->


  <cfif isDefined('seller_userid')>
  <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
   SELECT user_id,
          nickname
     FROM users
    WHERE is_active = 1 AND
	user_id = #seller_userid#
    ORDER BY nickname
  </cfquery> 
  <cfelseif isDefined('url.to_user_id')>
   <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
   SELECT user_id,
          nickname
     FROM users
    WHERE is_active = 1 AND
	user_id = #url.to_user_id#
    ORDER BY nickname
  </cfquery>
<cfelse>
<cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
   SELECT user_id,
          nickname
     FROM users
    WHERE is_active = 1
    ORDER BY nickname
  </cfquery> 
</CFIF>
  <!--- Get the listing background color --->
  <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name = 'listing_bgcolor'
  </cfquery>
  <cfset #header_bg# = #get_listing_bgcolor.pair#>
  <cfoutput>
   <form action="send_message.cfm" method="post">
	<cfif isDefined('itemnum') and  itemnum gt 0>
    	 <input type="hidden" name="itemnum" value="#itemnum#">
    </cfif>
    <table border=0 cellspacing=0 cellpadding=0>

<!---     <tr>
      <td><b>To:</b></td>
      <td width=5>&nbsp;</td>
      <td><input type="text" name="mail_to" size=30></td>
     </tr> --->
     <tr>
     
     
      <td><b>To:</b></td>
      <td width=5>&nbsp;</td>
	 
      <td><select name="mail_to"><cfloop query="get_users"><option value="#user_id#">#nickname#</option></cfloop></select></td>
     </tr>
	  <tr>
      <td><b>Subject:</b></td>
      <td width=5>&nbsp;</td>
      <td><input type="text" name="subject" size=30></td>
     </tr>
     <tr>
      <td><b>Priority:</b></td>
      <td width=5>&nbsp;</td>
      <td>
       <select name="priority">
        <option value="Normal">Normal</option>
        <option value="Important">Important</option>
        <option value="Urgent">Urgent</option>
       </select>
      </td>
     </tr>
     <tr>
      <td colspan=3><hr size=1 color=#heading_color# width=100%></td>
     </tr>
     <tr>
      <td valign="top"><b>Message:</b></td>
      <td width=5>&nbsp;</td>
      <td><textarea name="message" rows=8 cols=48></textarea></td>
     </tr>
     <tr>
      <td colspan=3><hr size=1 color=#heading_color# width=100%></td>
     </tr>
     <tr>
      <td colspan=3><input type="submit" name="submit" value="Send" width=75>&nbsp;&nbsp;&nbsp;<input type="button" name="submit" value="Cancel" width=75 onClick="window.close ();">
<input type="hidden" name="from" VALUE="#session.user_id#">
</td>
     </tr>
    </table>
   </form>
  </cfoutput>
  
  
 </body>
</html>
