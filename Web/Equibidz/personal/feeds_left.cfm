<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">

 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>

 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>





<!---
 <!--- Get all feedback they've left on --->
 <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">
  SELECT *, nickname
    FROM feedback, users
   WHERE user_id_from = #session.user_id#
     AND users.user_id = feedback.user_id
 </cfquery>
--->



 <!--- Get all feedback they've left on --->
 <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">
  SELECT a.*, b.nickname, c.name 
    FROM feedback a, users b, items c
   WHERE a.user_id_from = #session.user_id#
     AND b.user_id = a.user_id
     AND a.itemnum = c.itemnum
 </cfquery>
 


<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Personal Page: Feedback You've Left</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfoutput>

  <!--- The main table --->
  <div align="left">
   <table border=0 cellspacing=0 cellpadding=2 width=600>
    <tr>
     <td><br>
      <font size=3>
       The following is a list of the feedback you've left for other users of this site.
       <br><br>

        <cfif #get_results.recordcount# GT 0>
         <b>You left a total of #get_results.recordcount# feedback<cfif #get_results.recordcount# GT 1>s</cfif> on our site:</b><br><br>

         <table border=1 cellspacing=0 cellpadding=3>
          <tr bgcolor=#header_bg#><th align="left">##</th><th align="center">Nickname</th><th align="center">Date Placed</th><th align="center">Rating</th><th align="center">Comment</th><th align="center">Regarding Item</th></tr>
         <cfloop query="get_results">
          <tr><td>#currentRow#</td><td>#nickname#</td><td>#dateFormat (date_placed, "dd-mmm-yyyy")#</td><td align="center">#rating#</td><td>#comment#</td><td>#name#</td></tr>
         </cfloop>
         </table>
         <br>
        <cfelse>
         <b>Sorry, you haven't left any feedback on anybody yet.</b><br><br>
        </cfif>     
      </font>
     </td>
    </tr>
    <tr><td>
     <br><br>
</td></tr></table>
</div>
</cfoutput>
</body>
</html>
