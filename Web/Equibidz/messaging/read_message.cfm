<html>
 <head>
  <title>Message Reader</title>
  <link rel=stylesheet href="../includes/stylesheet.css" type="text/css">
 </head>


<body bgcolor='dddddd'>
 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Load this module for creating unique IDs --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">

 <!--- Check for submission --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>

 <!--- Read the message --->
 <cfquery username="#db_username#" password="#db_password#" name="get_message" datasource="#DATASOURCE#">
  SELECT from_user_id,
         message_id,
         message,
         is_read,
         is_new,
         is_flagged,
         subject,
         to_user_id,
         ref_message_id,
         priority,
         when_sent,
         users.nickname
    FROM messages, users
   WHERE to_user_id = #session.user_id#
     AND message_id = #message_id#
     AND users.user_id = from_user_id   
  </cfquery>

<!---  
  <!--- log message read --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Message Read"
    details="ID: #get_message.message_id#     FROM: #get_message.from_user_id#     SUBJECT: #get_message.subject#     PRIORITY: #get_message.priority#     MESSAGE: #get_message.message#"
    user_id="#Session.user_id#">
--->
  
 <!--- Update the message as being READ and turn off the NEW flag. --->
 <cfquery username="#db_username#" password="#db_password#" name="mark_read" datasource="#DATASOURCE#">
  UPDATE messages
     SET is_read = 0,
         is_new = 0
   WHERE message_id = #message_id#
  </cfquery>

  <!--- Get the listing background color --->
  <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name = 'listing_bgcolor'
  </cfquery>
  <cfset #header_bg# = #get_listing_bgcolor.pair#>
  <cfoutput>
   <form action="reply_message.cfm" method="post">
    <table border=0 cellspacing=0 cellpadding=0>
<!---     <tr>
      <td><b>To:</b></td>
      <td width=5>&nbsp;</td>
      <td><input type="text" name="mail_to" size=30></td>
     </tr> --->
     <tr>
      <td><b>From:</b></td>
      <td width=5>&nbsp;</td>
      <td>#get_message.nickname#</td>
     </tr>
     <tr>
      <td><b>Subject:</b></td>
      <td width=5>&nbsp;</td>
      <td>#get_message.subject#</td>
     </tr>
     <tr>
      <td><b>Sent:</b></td>
      <td width=5>&nbsp;</td>
      <td>#dateFormat (get_message.when_sent, "dd-mmm-yyyy")# at #lcase (timeFormat (get_message.when_sent, "h:mmt"))#</td>
     </tr>
     <tr>
      <td><b>Priority:</b></td>
      <td width=5>&nbsp;</td>
      <td>#get_message.priority#</td>
     </tr>
     <tr>
      <td colspan=3><hr size=1 color=#heading_color# width=100%></td>
     </tr>
     <tr>
      <td valign="top"><b>Message:</b></td>
      <td width=5>&nbsp;</td>
      <td><!--- <textarea name="message" rows=8 cols=48> --->#get_message.message#<!--- </textarea> ---></td>
     </tr>
     <tr>
      <td colspan=3><hr size=1 color=#heading_color# width=100%></td>
     </tr>
     <tr>
<!---      <td colspan=3><input type="button" name="submit" value="Close" width=75 onClick="window.opener.location='main_page.cfm'; window.close ();"></td> --->
     <td><input type="button" name="submit" value="Close" width=75 onClick="window.close ();"></td>
     <td><input type="submit" value="Reply"></td>
	 <td>&nbsp;</td>
     </tr>
	 <input type="hidden" name="message_id" VALUE="#message_id#">
    </table>
   </form>
  </cfoutput>
 </body>
</html>
