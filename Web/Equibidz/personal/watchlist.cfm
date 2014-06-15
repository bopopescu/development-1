<cfsetting enablecfoutputonly="yes">
<!---

watchlist.cfm
Phillip Nguyen 1/17/01

--->

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

 <!--- Check for self-submission --->
 <cfif #isDefined ("limit_results")# is 0>
  <cfset #limit_results# = "pending">
 </cfif>

 <!--- Get watch list --->
 <cfquery username="#db_username#" password="#db_password#" name="get_watchlist" datasource="#DATASOURCE#">
 	SELECT watch_list
	FROM users
	WHERE user_id = #session.user_id#
 </cfquery>
 <cfset watchlist = #Trim(get_watchlist.watch_list)#>

<cfif #watchlist# eq "">
<cfset watchlist = "0">
</cfif>

 <!--- Get all items they've sold --->
 <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">
  SELECT *
    FROM items
   WHERE itemnum in(#watchlist#)
   <cfif #limit_results# is "sold">
     AND (status = 0
          OR date_end < #TIMENOW#)
   <cfelse>
     AND date_end > #TIMENOW#
   </cfif>
   
 </cfquery>

 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>

 <!--- get listing ending hours color --->
 <cfquery username="#db_username#" password="#db_password#" name="HrsEndingColor" datasource="#DATASOURCE#">
     SELECT pair AS color
       FROM defaults
      WHERE name = 'hrsending_color'
 </cfquery>

 <!--- get # of days item is new --->
 <cfquery username="#db_username#" password="#db_password#" name="ListingNew" datasource="#DATASOURCE#">
     SELECT pair AS days
       FROM defaults
      WHERE name = 'listing_new'
 </cfquery>

 <!--- get number of bids required for hot auction --->
 <cfquery username="#db_username#" password="#db_password#" name="HotAuction" datasource="#DATASOURCE#">
     SELECT pair AS bids
       FROM defaults
      WHERE name = 'bids4hot'
 </cfquery>

 <!--- get listing ending hours value --->
 <cfquery username="#db_username#" password="#db_password#" name="HrsEnding" datasource="#DATASOURCE#">
     SELECT pair AS hours
       FROM defaults
      WHERE name = 'hrsending'
 </cfquery>

 <!--- get listing ending hours color --->
 <cfquery username="#db_username#" password="#db_password#" name="HrsEndingColor" datasource="#DATASOURCE#">
     SELECT pair AS color
       FROM defaults
      WHERE name = 'hrsending_color'
 </cfquery>

 <!--- define listing row color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_ListingColor" datasource="#DATASOURCE#">
     SELECT pair AS color
       FROM defaults
      WHERE name = 'listing_bgcolor'
 </cfquery>
 
  <!--- get thumbs mode settings (Thumbnail display outside studio) --->
<cfquery username="#db_username#" password="#db_password#" name="get_thumbsMode" datasource="#DATASOURCE#">
    SELECT pair AS show_thumbs
      FROM defaults
     WHERE name = 'enable_thumbs'
</cfquery>

<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Personal Page: View Watch List</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfoutput>
 <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">

  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><center></center><br><br></td></tr>
    <tr><td><font size=4 color="000000"><b>Personal Page: View Watch List</b></font></td></tr>
    <tr><td>         <hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
	 	<cfif #get_results.recordcount# GT 0>
      <font size=3>
       The following a list of all watch list you have added into your watch list.
       <br><br>

         <b>You have added a total of #get_results.recordcount# Auction(s) into your watch list:</b><br><br>

         <cfmodule template="../functions/prnt_listing.cfm"
           featured_studio="#get_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#"
		   db_username="#db_username#"
		   db_password="#db_password#"
			heading_color="#heading_color#"
			heading_fcolor="#heading_fcolor#"
			heading_font="#heading_font#">
           
         <cfset item_count = 0>
         <cfloop query="get_results">
        
          <!--- increment item_count --->
          <cfset item_count = IncrementValue(item_count)>
        
          <!--- get bids --->
          <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
              SELECT COUNT(itemnum) AS total
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
        
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
    		  <!--- get lowest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
          
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing.cfm"
            part="LISTING"
            itemnum="#itemnum#"
            itemtitle="#title#"
            currentrow="#item_count#"
            rowcolor="#get_ListingColor.color#"
            boldtitle="#bold_title#"
            picture="#picture#"
            sound="#sound#"
            banner="#banner#"
            banner_line="#banner_line#"
            highest="#HighestBid.price#"
            lowest="#LowestBid.price#"
            minimum_bid="#minimum_bid#"
            maximum_bid="#maximum_bid#"
            totalbids="#CountBids.total#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
			datasource="#DATASOURCE#"
			db_username="#db_username#"
			db_password="#db_password#"
            featured_studio="#get_results.featured_studio#"
     	      show_thumbs="#get_thumbsMode.show_thumbs#"
			  numbermask="#numbermask#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>Sorry, no items in your watch list.</b><br><br>
        </cfif>     
         <!--- <form action="sell_history.cfm" method="post">
                  <hr size=1 color=#heading_color# width=100%>
          <table border=0 cellspacing=0 cellpadding=3>
           <tr>
            <td><b>Limit results to:</b></td>
            <td><input type="radio" name="limit_results" value="sold"<cfif #limit_results# is "sold"> checked</cfif>>Expired Auctions</td>
            <td><input type="radio" name="limit_results" value="pending"<cfif #limit_results# is "pending"> checked</cfif>>Pending Items</td>
            <td width=100 align="right"><input type="submit" name="submit" value="Refresh"></td>
           </tr>
          </table>
         </form> --->
        <form action="main_page.cfm" method="post">
                 <hr size=1 color=#heading_color# width=100%>
         <input type="submit" name="submit" value="Done" width=75>
        </form>
      </font>
     </td>
    </tr></table>
   
     <br><br>
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
