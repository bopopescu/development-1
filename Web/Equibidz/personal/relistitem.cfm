<cfsetting enablecfoutputonly="yes">

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
  SELECT itemnum, title,category1
    FROM items
   WHERE user_id=#session.user_id#
     AND hide = 0
	 AND auto_relist = 0
     AND (status=0
      OR date_end < #CreateODBCDate (now () )#)      
   ORDER BY title ASC, itemnum DESC;
 </cfquery>

 <cfset session.orig_itemnum = "">

<cfsetting enablecfoutputonly="no">
   
<html>
 <head>
  <title>Personal Page: Relist an Item</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <cfinclude template="../includes/bodytag.html">


<cfinclude template="../includes/menu_bar.cfm">
 <cfoutput>

  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td colspan=3><font size=4 color="000000"><b>Personal Page - Relist Your Expired Auction Items</b></font></td></tr>
    <tr><td colspan=3><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td valign=top>
      <font size=3>
       This page will allow you to relist an item you've previously put up for auction, but did not sell.  Just select an item from the list below and click the "Continue" button.  You will then see the page you saw when you originally listed your item, wh       ere you may change any information you like.<br><br>
       <b>To relist an item please select an item from the following list and click Continue. (#get_items.recordcount# items found):</b><br><br>
	     <b>To Delete expired auctions, Click the remove button first then when the page reloads select the items you want deleted and click "Delete Items".
       </cfoutput>
      </td>
      <td width=20>&nbsp;</td>
      <td align=right> 
       <form action="relist_info.cfm" method="post">

	   <cfif isDefined('url.delete')>
        <select name="itemlist" size=14 width=300 MULTIPLE>
		 <cfelse>
        <select name="itemnum" size=14 width=300>         
      </cfif>
      
         <cfoutput query="get_items">

          <option value="#itemnum#"<cfif #currentrow# is 1> selected</cfif>>#title#&nbsp;&nbsp;(#itemnum#)(#category1#)</option>
         </cfoutput>
        </select>
        <table height=4 width=100% border=0 cellpadding=0 cellspacing=0><tr><td></td></tr></table>
        <cfif #get_items.recordcount# GT 0 AND NOT isDefined('url.delete')>
          <input type="submit" name="submit" value="Continue"> <input type="submit" name="remove" value="Remove"> 
        <cfelseif #get_items.recordcount# GT 0 AND isDefined('url.delete')>
          <input type="submit" name="update" value="Delete Items">
        </cfif>
       </form>
       <cfoutput>
      </font>
     </td>
    </tr></table>
    <div align="center">

 <cfinclude template="nav.cfm">
</div>
      </td></tr></table></div><div align="center">
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
