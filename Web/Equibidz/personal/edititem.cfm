 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  


 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
 
 <cfset structdelete(session, "category1")>
 <cfset structdelete(session, "category2")>

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 

 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>

 <!--- Verify their username and password --->
 <cfif (#isDefined ("submit")# is 1)>
  <cfif #trim (submit)# is "Next >>">
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
 </cfif>

 <!--- Resolves a nickname into a userid --->
 <cfif #isDefined ("session.user_id")# is 0>
  <cflocation url="index.cfm">
 </cfif>
 
 <!--- Get a list of their expired auctions --->
 <cfquery username="#db_username#" password="#db_password#" name="get_items" datasource="#DATASOURCE#">
  SELECT itemnum, title
    FROM items
   WHERE user_id = #session.user_id#
     AND status=1
	 AND date_end > #CreateODBCDate (now ())#
   ORDER BY title
 </cfquery>
 


<cfquery username="#db_username#" password="#db_password#" name="get_control" datasource="#DATASOURCE#">
  SELECT full_control
    FROM users
   WHERE user_id = #session.user_id#

and is_active=1
and confirmation =1

 </cfquery>
<cfset error_message="">


<cfif isdefined("delete")>
<cfquery username="#db_username#" password="#db_password#" name="delete_items" datasource="#DATASOURCE#">
delete
    FROM items
   WHERE itemnum= #itemnum#


 </cfquery>
<cfset #error_message# ="<font color=red> Auction deleted</font>">

</cfif>

<cfif isdefined("endauction")>
<cfquery username="#db_username#" password="#db_password#" name="end_items" datasource="#DATASOURCE#">
update
 items

set status = 0
   WHERE itemnum= #itemnum#


 </cfquery>

<cfset #error_message# ="<font color=red> Auction ended.</font>">

</cfif>



<cfif isdefined("deletebids")>
<cflocation url="bidhistory.cfm?itemnum=#itemnum#">
</cfif>

<cfif isdefined("endauction")>
<cfquery username="#db_username#" password="#db_password#" name="end_items" datasource="#DATASOURCE#">
update
 items

set status = 0
   WHERE itemnum= #itemnum#


 </cfquery>

<cfset #error_message# ="<font color=red> Auction ended.</font>">

</cfif>

<html>
 <head>
  <title>Personal Page: Edit an Item</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">

 <cfoutput>

  <!--- The main table --->
  <<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4 color="000000"><b>Personal Page - Edit, delete, or cancel Your Active Auction Items</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>


    <tr><td>#error_message#</td></tr>
    <tr>
     <td>
      <font size=3>
	   This page will allow you to edit an item you currently have up for
       auction.  Just select an item from the list below and click the "Continue"
       button.  You will then see the page you saw when you originally
       listed your item, where you may change most of the information about your
       item.  Please note that you will not be able to change some information such as the item number and title.
       <br><br>
       <b>Please select an item from the following list (#get_items.recordcount# items found):</b><br>
       </cfoutput>
       <form action="edit_info.cfm" method="post">
        <select name="itemnum" size=10 width=300>         
         <cfoutput query="get_items">
          <option value="#itemnum#"<cfif #currentrow# is 1> selected</cfif>>#title#&nbsp;&nbsp;(#itemnum#)<!---<cfset #itemnum#=#itemnum#><cfset #session.title#=#title#>---> </option>
         </cfoutput>
		</select>
		<cfif #get_items.recordcount# GT 0>
         <br><br>
		<!---<cfset session.itemnum = "#itemnum#">--->
		<input type="submit" name="submit" value="Edit">  

        </cfif>
       </form>

<cfif #get_control.full_control# eq 1>  
<br>

<form action="edititem.cfm" name="blah" method="post">
        <select name="itemnum" size=10 width=300>         
         <cfoutput query="get_items">
          <option value="#itemnum#"<cfif #currentrow# is 1> selected</cfif>>#title#&nbsp;&nbsp;(#itemnum#)<!---<cfset #itemnum#=#itemnum#><cfset #session.title#=#title#>---> </option>
         </cfoutput>
		</select>
		<cfif #get_items.recordcount# GT 0>
         <br><br>
		<!---<cfset session.itemnum = "#itemnum#">--->

   
		<input type="submit" name="delete" value="Delete Auction">
		<input type="submit" name="deletebids" value="Delete Bids">  
		<input type="submit" name="endauction" value="End Auction">

        </cfif>
       </form>
</cfif></font>
       <div align="center"><cfoutput>

 <cfinclude template="nav.cfm">
</div>
      </td></tr></table>
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
