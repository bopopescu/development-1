<cfinclude template="validate_include.cfm">

<!--- edit feedback --->
<cfif isdefined("edit_feedback")>
	  <cfquery username="#db_username#" password="#db_password#" name="edit_selected_feedback" datasource="#DATASOURCE#">
          UPDATE feedback
		  SET comment = '#comment#',
		  	  rating = #tone#
           WHERE id = #id#
      </cfquery>
	  <cflocation url="feedback_list.cfm?user_id=#user_id#&itemnum=#itemnum#" addtoken="No">
</cfif>

<!--- delete feedback --->
<cfif isdefined("del_feedback")>
	  <cfquery username="#db_username#" password="#db_password#" name="del_selected_feedback" datasource="#DATASOURCE#">
          DELETE *
            FROM feedback
           WHERE id = #id#
      </cfquery>
	  <cflocation url="feedback_list.cfm?user_id=#user_id#&itemnum=#itemnum#" addtoken="No">
</cfif>
  
  	  <cfquery username="#db_username#" password="#db_password#" name="get_selected_feedback" datasource="#DATASOURCE#">
          SELECT *
            FROM feedback
           WHERE id = #id#
      </cfquery>
	  
	  <cfquery username="#db_username#" password="#db_password#" name="get_userfrom" datasource="#DATASOURCE#">
          SELECT user_id, nickname
            FROM users
           WHERE user_id = #get_selected_feedback.user_id_from#
      </cfquery>

<html>
 <head>
  <title>Edit/Delete feedback</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 
 <cfoutput>   
  <!--- The main table --->
  <center>
<table border=0 cellspacing=0 cellpadding=2 width=640>
<form action="feedback_edit.cfm" method="post">
<input type=hidden name="id" value="#id#">
<input type=hidden name="user_id" value="#get_selected_feedback.user_id#">
<input type=hidden name="itemnum" value="#get_selected_feedback.itemnum#">
    <tr><td colspan="2"><font size=4><b>Selected Feedback</b></font>            <hr size=1 color=#heading_color# width=100%> </td></tr>
    <tr>
		<td><b>User:</b></td>
		<td>#get_userfrom.nickname#</td>
	</tr>
	<tr>
		<td><b>Date:</b></td>
		<td>#DateFormat(get_selected_feedback.date_placed, "mm/dd/yyyy")# #TimeFormat(get_selected_feedback.date_placed, "HH:mm:ss")#</td>
	</tr>
	<tr>
		<td><b>Item:</b></td>
		<td>#get_selected_feedback.itemnum#</td>
	</tr>
	<tr>
		<td><b>Tone of your comment:</b></td>
		<td>
			<input type=radio name="tone" value="1"<cfif get_selected_feedback.rating IS "1"> checked</cfif>> Positive&nbsp;&nbsp;
            <input type=radio name="tone" value="0"<cfif get_selected_feedback.rating IS "0"> checked</cfif>> Neutral&nbsp;&nbsp;
            <input type=radio name="tone" value="-1"<cfif get_selected_feedback.rating IS "-1"> checked</cfif>> Negative
		</td>
	</tr>
	<tr>
		<td><b>Comment:</b></td>
		<td><input type="Text" name="comment" value="#get_selected_feedback.comment#" size="70" maxlength="160"></td>
	</tr>
	<tr><td>&nbsp;</td><td><input type="Submit" name="edit_feedback" value="Edit">&nbsp;<input type="Submit" name="del_feedback" value="Delete"></td></tr>
</form>
</table>
</center>
</cfoutput>
</body>
</html>
