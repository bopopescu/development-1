<cfsetting enablecfoutputonly="yes">
<!---

sell_history.cfm
with studio
walter 12/06/99

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

 <!--- hide auctions --->
 <cfif isdefined("remove")>
 	<cfquery username="#db_username#" password="#db_password#" name="remove_auctions" datasource="#DATASOURCE#">
    	UPDATE items
		SET hide = 1
		WHERE user_id = #session.user_id#
		AND status = 0
		AND date_end < #timenow#
		AND hide = 0
		<cfif period neq "All">
		AND date_end <= #dateadd("d",period,timenow)#
		</cfif>
	</cfquery>
 </cfif>
 <!--- Check for self-submission --->
 <cfif #isDefined ("limit_results")# is 0>
  <cfset #limit_results# = "active">
 </cfif>
 <cfparam name="PgNum" default="1">      <!--- def page number to disp, 1 for first page --->
 <!--- def listings per page --->
<cfset bUseDefPerPg = 0>
<cfset iListPerPg = 25>

<cfquery username="#db_username#" password="#db_password#" name="getListPerPg" datasource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'itemsperpage'
</cfquery>

<cfif getListPerPg.RecordCount>
  <cfif IsNumeric(getListPerPg.pair)>
    <cfset bUseDefPerPg = 1>
  </cfif>
</cfif>

<cfif Variables.bUseDefPerPg>
  <cfset iListPerPg = getListPerPg.pair>
</cfif>

<!--- def startrow/endrow --->
<cfset iStartRow = 0>
<cfset iEndRow = iListPerPg>

<cfif IsNumeric(PgNum)>
  <cfif PgNum GT 1>
    
    <cfset iStartRow = (PgNum * iListPerPg) - iListPerPg>
    <cfset iEndRow = PgNum * iListPerPg>
  </cfif>
</cfif>

<cfset iStartRow = iStartRow + 1>

 <!--- Get all items they've sold --->
 <cfif #limit_results# is "sold">
 <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">
  SELECT I.*
    FROM items I, bids B
   WHERE I.user_id = #session.user_id#
   AND I.itemnum = B.itemnum
   AND I.hide = 0
     AND (I.status = 0
          OR I.date_end < #TIMENOW#)
   AND B.winner = 1
 </cfquery>
 <cfelse>
 <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">
  SELECT *
    FROM items
   WHERE user_id = #session.user_id#
   AND hide = 0
   <cfif #limit_results# is "expire">
     AND (status = 0
          OR date_end < #TIMENOW#)
   <cfelse>
     AND date_end > #TIMENOW#
   </cfif>
 </cfquery>
 </cfif>

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
  <title>Personal Page: View Your Selling History</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfoutput>
<cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">
  <!--- The main table --->
  <center>
   <table border=0 cellspacing=0 cellpadding=2 width=640>
    <tr><td><font size=4 color="000000"><b>Personal Page - View Your Selling History</b></font></td></tr>
    <tr><td><hr size=1 noshade></td></tr>
    <tr>
     <td>
      <font size=3>
       The following a list of all completed sales you have made through our site.
       You can use the options below to change which information is displayed.
       <br><br>

        <cfif #get_results.recordcount# GT 0>
         <b>You have posted a total of #get_results.recordcount# Auction(s) on our site:</b><br><br>

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
         <cfloop query="get_results" startrow="#Variables.iStartRow#" endrow="#Variables.iEndRow#">
        
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
		 <center>
                    <cfif IsNumeric(PgNum)>
                      <cfif PgNum GT 1>
                        [<a href="sell_history.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum - 1)#&limit_results=#limit_results#">Previous</a>]
                      </cfif>
                    </cfif>
                    
                    <cfset sDspPgNum = IIf(IsNumeric(PgNum), "PgNum", "1")>
                    
                    Viewing Page #Variables.sDspPgNum#.
                    
                    <cfif IsDefined("Variables.sql_code2")
                      AND Variables.iEndRow LT Evaluate(get_results.RecordCount + get_results2.RecordCount)
                      OR not IsDefined("Variables.sql_code2")
                      AND Variables.iEndRow LT get_results.RecordCount>
                      
                      <cfif IsNumeric(PgNum)>
                        [<a href="sell_history.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum + 1)#&limit_results=#limit_results#">Next</a>]
                      </cfif>
                    </cfif>
                  </center>
				  <br>
        <cfelse>
         <b>Sorry, no items matching your search criteria were found.</b><br><br>
        </cfif>     
         <form action="sell_history.cfm" method="post">
         <hr size=1 noshade>
          <table border=0 cellspacing=0 cellpadding=3>
           <tr>
            <td><b>Limit results to:</b></td>
			<td><input type="radio" name="limit_results" value="active"<cfif #limit_results# is "active"> checked</cfif>>Active Auctions</td>
            <td><input type="radio" name="limit_results" value="expire"<cfif #limit_results# is "expire"> checked</cfif>>Expired Auctions</td>
			<td><input type="radio" name="limit_results" value="sold"<cfif #limit_results# is "sold"> checked</cfif>>Completed Auctions</td>
            <td width=100 align="right"><input type="submit" name="submit" value="Refresh"></td>
           </tr>
          </table>
         </form>
		 <!--- <cfif limit_results eq "expire"> --->
		 <cfform action="sell_history.cfm" method="post">
		 <input type="hidden" name="limit_results" value="#limit_results#">
         <hr size=1 noshade>
          <table border=0 cellspacing=0 cellpadding=3>
		   <tr><td colspan="5">Note*: Any item that has been removed it cannot be viewed or relisted.</td></tr>
           <tr>
            <td><b>Remove expire auctions in:</b></td>
			<td><cfinput type="radio" name="period" value="-30" required="Yes"  message="Please select period">30 Days and up</td>
            <td><cfinput type="radio" name="period" value="-60" required="Yes" message="Please select period">60 Days and up</td>
			<td><cfinput type="radio" name="period" value="All" required="Yes" message="Please select period">All</td><!---  <cfif #period# is "61"> checked</cfif> --->
            <td width=100 align="right"><input type="submit" name="remove" value="Remove"></td>
           </tr>
          </table>
         </cfform>
		 <!--- </cfif> --->
        <form action="main_page.cfm" method="post">
        <hr size=1 noshade>
         <input type="submit" name="submit" value="Done" width=75>
        </form>
      </font>
     </td>
    </tr>
    <tr><td>
     <br><br>
     <center>

 <cfinclude template="nav.cfm">

     </center>
     <br><hr size=1 noshade></td></tr>
    <tr><td><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td></tr>
   </table>
   </center>
  </cfoutput>
 </body>
</html>
