<!---
  leavefeedback.cfm
  
  form used for leaving feedback on a user...
  will run stand alone...
  or excepting either or both... (Session.nickname, URL.user_id, Form.user_id)
  
--->
<cfset current_page="feedback">
<cfsetting enablecfoutputonly="Yes">

<cftry>
  <!--- include globals --->
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<!--- enable Session state management --->
<cfset mins_until_timeout = 60>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">

<cfparam name="tone" default="1">
<!---
<!--- define nickname --->
<cfif IsDefined("Session.nickname")>
  <cfset nickname = Trim(Session.nickname)>
<cfelseif IsDefined("Form.nickname")>
  <cfset nickname = Trim(Form.nickname)>
<cfelseif IsDefined("URL.nickname")>
  <cfset nickname = Trim("URL.nickname")>
<cfelse>
  <cfset nickname = "">
</cfif>

<!--- define user_id of receiver --->
<cfif IsDefined("Form.user_id")>
  <cfset user_id = Trim(Form.user_id)>
<cfelseif IsDefined("URL.user_id")>
  <cfset user_id = Trim(URL.user_id)>
<cfelse>
  <cfset user_id = "">
</cfif>

<cfif Len(user_id)>
  <cfset tempId = REReplace(user_id, "[^0123456789]", "", "ALL")>
  <cfset tempId = IIf(not Len(tempId), DE("0"), "tempId")>
  
  <cfquery username="#db_username#" password="#db_password#" name="getUser" datasource="#DATASOURCE#">
      SELECT nickname
        FROM users
       WHERE user_id = #tempId#
  </cfquery>
  
  <cfif not getUser.RecordCount>
    <cfquery username="#db_username#" password="#db_password#" name="getUser" datasource="#DATASOURCE#">
        SELECT nickname
          FROM users
         WHERE nickname = '#user_id#'
    </cfquery>
  </cfif>
  
  <cfif getUser.RecordCount>
    <cfset user_id = Trim(getUser.nickname)>
  </cfif>
</cfif>

<!--- define itemnum comment refers to --->
<cfif IsDefined("Form.itemnum")>
  <cfset itemnum = Trim(Form.itemnum)>
<cfelseif IsDefined("URL.itemnum")>
  <cfset itemnum = Trim(URL.itemnum)>
<cfelse>
  <cfset itemnum = "">
</cfif>

<!--- define tone of comment --->
<cfif IsDefined("Form.tone")>
  <cfset tone = Trim(Form.tone)>
<cfelseif IsDefined("URL.tone")>
  <cfset tone = Trim(URL.tone)>
<cfelse>
  <cfset tone = "positive">
</cfif>

<!--- define comment --->
<cfif IsDefined("Form.comment")>
  <cfset comment = Trim(Form.comment)>
<cfelse>
  <cfset comment = "">
</cfif>

<!--- define highlights start/end --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getHighLight" datasource="#DATASOURCE#">
      SELECT pair AS alink_color
        FROM defaults
       WHERE name = 'alink_color'
  </cfquery>
 <cfset error_message=""> 
  <cfset theColor = Trim(getHighLight.alink_color)>
  
  <cfset hlightStart = '<font color="' & theColor & '">'>
  <cfset hlightEnd = '</font>'>
  
  <cfcatch>
    <cfset hlightStart = '<font color="ff0000">'>
    <cfset hlightEnd = '</font>'>
  </cfcatch>
</cftry>
--->
<!--- define default check values --->
<cfset chkNickname = "TRUE">
<cfset chkPassword = "TRUE">
<cfset chkUserID = "TRUE">
<cfset chkItemnum = "TRUE">
<cfset chkTone = "TRUE">
<cfset chkComment = "FALSE">
<cfset chkSubmit = "TRUE">
<cfset chkSelf = "FALSE">
<cfset chkSecond = "FALSE">

<!--- if submit verify information --->




<cfif IsDefined("leave_comment")>

<cfif #trim(form.comment)# is not "">
  


      <!--- determine if feedback already exists --->
      <cfquery username="#db_username#" password="#db_password#" name="getPrevious" datasource="#DATASOURCE#">
          SELECT COUNT(user_id) AS found
            FROM feedback
           WHERE user_id = #session.user_Id#
             AND user_id_from = #user_id_from#
			 AND itemnum = #itemnum#
      </cfquery>
      
      <!--- if previous, update.. else insert --->
      <cfif #getPrevious.found# eq 0>
        <cfquery username="#db_username#" password="#db_password#" name="insFeedback" datasource="#DATASOURCE#">
            INSERT INTO feedback
              (user_id, user_id_from, date_placed, rating, comment, itemnum, remote_ip)
            VALUES
              (

#user_id#,#user_id_from#, #timenow#, #tone#, '#Comment#', #Itemnum#, '#CGI.remote_ADDR#')


<!---
(<cfif #buyer# eq 1>#user_Id_from#<cfelse>

#session.user_id#</cfif>, <cfif #buyer# eq 1>#session.user_Id#<cfelse>#user_id_from#</cfif>, #timenow#, #tone#, '#Comment#', #Itemnum#, '#CGI.remote_ADDR#')
--->
        </cfquery>




        <cfquery username="#db_username#" password="#db_password#" name="update_feedback" datasource="#DATASOURCE#">

update items set feedback_left=1 where itemnum=#itemnum#
        </cfquery>


      <cfelse>
        <cfset chksubmit = "FALSE">



        <cfset IsGoodSubmit = "FALSE">
        <cfset chkSecond = "TRUE">
        <cfset chkComment = "TRUE">
</cfif>
      
      <!--- log feedback --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Feedback Left (On User: #User_Id_from#)"
        itemnum="#Itemnum#"
        details="TONE: #Tone#     COMMENT: #Comment#"
        user_id="#User_Id#">
      
      <cfset IsGoodSubmit = "TRUE">
<cftry>

  <cfquery username="#db_username#" password="#db_password#" name="getBgcolor" datasource="#DATASOURCE#">
              SELECT pair AS listing_bgcolor
                FROM defaults
               WHERE name = 'listing_bgcolor'
          </cfquery>
          
          <cfset tempBgcolor = getBgcolor.listing_bgcolor>
          
          <cfcatch>
            <cfset tempBgcolor = "d3d3d3">
          </cfcatch>
        </cftry>
 

<cfelse>

 <cfset chksubmit = "FALSE">



        <cfset IsGoodSubmit = "FALSE">
       
        <cfset chkComment = "TRUE">
 
  </cfif>

  </cfif>

<!---
<!--- get SSL on/off --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="SSL" datasource="#DATASOURCE#">
      SELECT pair AS enable_ssl
        FROM defaults
       WHERE name = 'enable_ssl'
  </cfquery>
  
  <cfset sslOn = SSL.enable_ssl>
  
  <cfcatch>
    <cfset sslOn = "FALSE">
  </cfcatch>
</cftry>
--->
<!--- output page --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>User Feedback</title>
    
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
    <center>


    <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=4>
              <b>Leave Feedback for a User</b>
            </font>
<hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade>


            <cfif not chkSubmit>
              <cfif chkSelf>
                <cfoutput><center><b>INVALID:</b> You may not place feedback about yourself.</center></cfoutput><br>

<cfelseif  chkComment>

                <cfoutput><center><font color=red size=2><b>INVALID:</b> You must enter a comment to proceed.</font><form action="http://www.mightybids.com/personal/feedback.cfm" method="post" onsubmit="history-back()"><input type="Submit" value="Back"></form></center></cfoutput><br>
              <cfelseif chkSecond>

                <cfoutput><font color=red size=2><b>INVALID:</b> You already left a feedback to this user.</font></cfoutput><br>
              <cfelse>

                <cfoutput><center><b>INCOMPLETE:</b> Please verify that the highlighted items are correct.</center></cfoutput><br>
              </cfif>
              <br>
            </cfif>
          </td>
        </tr>
      </table>
      <!--- display completed submit message, else form --->
      <cfif IsDefined("Variables.IsGoodSubmit")>
        <cfsetting enablecfoutputonly="Yes">
        
        <cftry>
          <cfquery username="#db_username#" password="#db_password#" name="getBgcolor" datasource="#DATASOURCE#">
              SELECT pair AS listing_bgcolor
                FROM defaults
               WHERE name = 'listing_bgcolor'
          </cfquery>
          
          <cfset tempBgcolor = getBgcolor.listing_bgcolor>
          
          <cfcatch>
            <cfset tempBgcolor = "d3d3d3">
          </cfcatch>
        </cftry>
        
        <cfsetting enablecfoutputonly="No">

<cfif chksubmit>
        <cfmodule template="submitcomplete1.cfm"
          success="#Variables.IsGoodSubmit#"
          bgcolor="#tempBgcolor#"
          userFrom="#session.nickname#"
          userTo="#user_id_from#"
          datePlaced="#timenow#"
          itemNumber="#Itemnum#"
          tone="#Tone#"
          comment="#comment#"
          VAROOT="#VAROOT#">

<cfelse>

</cfif>

</cfif>

      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td align=left valign=top>
             <font size=2>
               <cfinclude template="../includes/copyrights.cfm">
               <br>
               <br>
               <br>
            </font>
          </td>
        </tr>
      </table>

    </center>
  </body>
</html>
