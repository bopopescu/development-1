<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">




 <!--- get billing type --->
<cfquery username="#db_username#" password="#db_password#" name="get_billing_type" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='billing_type'
  </cfquery>
  <cfset #billing_type# = #get_billing_type.pair#>

 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>

 <!--- Verify their username and password --->
 <cfif (isDefined("submit") is 1)>
  <cfif trim(submit) is "Next >>">
   <cfquery username="#db_username#" password="#db_password#" name="verify_login" datasource="#DATASOURCE#">
    SELECT user_id, nickname, confirmation
      FROM users
     WHERE nickname = '#user_id#'
     <cfif isNumeric(user_id) is 1>
        OR user_id = #user_id#
     </cfif>
       AND password = '#password#'
	   AND is_active = 1
   </cfquery>
   <cfif verify_login.recordCount is 0>
    <cflocation url="index.cfm?failed=1">
   <cfelse>
   	<cfif verify_login.confirmation eq 0><cflocation url="index.cfm?failed=2"></cfif>
    <cfset session.user_id = verify_login.user_id>
    <cfset session.password = password>
    <cfset session.nickname = verify_login.nickname>
   </cfif>
  </cfif>
 </cfif>

 <!--- check login --->
 <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
 	<cfset session.user_id = session.user_id>
	<cfset session.password = session.password>
 <cfelse>
	<cflocation url="index.cfm" addtoken="No">
 </cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_CategoryInfo" DATASOURCE="#DATASOURCE#">
	SELECT categories.parent, categories.name, categories.category,categories.date_created,categories.allow_sales, categories.user_id,users.nickname
	  FROM categories,users
	 WHERE categories.user_id=#session.user_id# and categories.user_id =users.user_id
</cfquery>


<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Main Index</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">
 <cfoutput>

  <!--- The main table --->
<table border='0' width='1000' style="background-image: url('images/bg_table.jpg')" cellpadding="0" cellspacing="0">
   <tr><td>  
   <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><br><br><b>My Account - Personal Page</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       This section of our site allows you to change and update your personal information,
       as well as view statistics such as your bidding history, feedback you've left, and
       items you've auctioned.<br><br>
       <b>Please select a section from the list:</b><br>
       <menu>
        <li><a href="personal_info.cfm">View/edit your personal information</a><br>
        <li><a href="feedback.cfm">My Auctions</a><br>
        
        <li><a href="feedback.cfm">Leave feedback</a><br>
        
        <li><a href="selling.cfm">View your active items for sale.</a><br>
        <li><a href="sold_items.cfm">View your sold items.</a><br>
		<li><a href="unsold_items.cfm">View your unsold items.</a><br>
        <li><a href="bid_history1.cfm">View your bidding history</a><br>
        
        <li><a href="feeds_left.cfm">See feedback you've left regarding others</a><br>
        <li><a href="feeds_recvd.cfm">Read feedback people have left regarding you</a><br>
        <li><a href="futurewatch.cfm">FutureWatch settings</a>
        <!---<li><a href="relistitem.cfm">Relist your expired auction items</a>--->
        <!---<li><a href="edititem.cfm">Edit/Delete/Cancel your auction items</a>--->
        <!---<li><a href="bulksell/index2.cfm">Online BulkLoader</a>--->
        <!---<li><a href="editmypage.cfm">Edit About Me page</a>--->
		<li><a href="watchlist.cfm">My watch list</a>
		<li><a href="blockedlist.cfm">Blocked bidders list</a>
		<cfif billing_type eq "monthly">
		<li><a href="../bill_monthly/member_bal.cfm">Balance</a>
		</cfif>
		<cfif classified_valid is "Yes">
		<li><a href="editad.cfm">Edit your classified ads</a>
		</cfif>

<cfif get_categoryinfo.recordcount neq 0 >
<li><a href="##blah">Post items into your exclusive category</a>
	</menu>
</cfif>

</cfoutput>  






<cfif get_categoryinfo.recordcount neq 0 >
<a name="blah">

<form action =exc.cfm method =post>
<tr><td align=center>
<select name="category">
<cfoutput query ="get_categoryinfo">

<option value ="#category#">#category#.............#name#</option>

</cfoutput>

</select>

<input type=submit value="Post items into your exclusive category">
</td></tr>
</form>

</cfif>

       <br>
      </font>
     </td>
    </tr>
<cfoutput>
</table>
</div>
</td></tr>
    <tr><td><br><br><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr><td><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td></tr>
   </table>

</cfoutput>





 </body>
</html>
