<cfsetting enablecfoutputonly="yes">
<!--- 
	Search Results Page:
	modified for studio integration
	Walter 11/24/99
 --->
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- def vals --->
<cfset current_page = "search_results">
<cfparam name="search_type" default="zipcode_search">
<cfparam name="search_name" default="Search by zipcode.">
<cfparam name="phrase_match" default="all">
<cfparam name="PgNum" default="1">      <!--- def page number to disp, 1 for first page --->
<cfset itemnum_list = "">
<!--- Reset the SQL statement string --->
<cfset #sql_code2# = "">
<cfset #error_string# = "">
<cfif VAROOT eq "">
	<cfset go_back = "../">
<cfelse>
	<cfset go_back = "../../">
</cfif>


<!--- Check for unauthorized entry into the page --->
<cfif #trim (from_zipcode)# is "">
  <cfset error_string = "Please enter your zipcode">
<cfelseif len(from_zipcode) lt 5 or len(from_zipcode) gt 5>
  <cfset error_string = "Your zipcode is invalid.  Please reenter your zipcode">
</cfif>
<cfif #trim (search_text)# is "">
  <cfset search_text = "%">
</cfif>
<cfset search_text = #Replace(search_text, "*", "%", "ALL")#>
<cfif #measure_type# eq "MI">
	<cfset measure_text = "Miles">
<cfelseif #measure_type# eq "KM">
	<cfset measure_text = "Kilometers">
</cfif>

<!--- Check for passed-in params --->
<cfif #isDefined ("search_type")# is 0>
  <cfset #search_type# = "zipcode_search">
</cfif>
<cfif #isDefined ("search_name")# is 0>
  <cfset #search_name# = "Search by zipcode">
</cfif>
<cfif #isDefined ("search_category")# is 0>
  <cfset #search_category# = "">
</cfif>

<cfif #isDefined ("search_span")# is 0>
  <cfset #search_span# = "title">
</cfif>
<cfif #isDefined ("search_limit")# is 0>
  <cfset #search_limit# = "active">
</cfif>
<cfif #isDefined ("order_by")# is 0>
  <cfset #order_by# = "title">
</cfif>
<cfif #isDefined ("sort_order")# is 0>
  <cfset #sort_order# = "ASC">
</cfif>
<cfif #isDefined ("country")# is 0>
  <cfset #country# = "">
</cfif>
<cfif #isDefined ("country_type")# is 0>
  <cfset #country_type# = "in">
</cfif>
<cfif #isDefined ("category")# is 0>
  <cfset #category# = "-1">
</cfif>

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


<!--- Get their info if they're logged in --->
<cfif #isDefined ("session.nickname")#>
  <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
      SELECT user_id,
             nickname,
             name,
             password,
             email
        FROM users
       WHERE nickname = '#session.nickname#'
  </cfquery>
  
  <cfset temp_var = find (" ", get_user_info.name) - 1>
  <cfif temp_var lt 0>
    <cfset not_less_than_one = 1>
  <cfelse>
    <cfset not_less_than_one = temp_var>
  </cfif>
  
  <cfset user_fname = left (get_user_info.name, not_less_than_one)>
<cfelse>
  <cfset user_fname = "">
</cfif>


<!--- Handle various search types individually --->
<cfif #error_string# is "">
<cfswitch expression=#search_type#>
  
  <!--- *** ZIPCODE LOOKUP SEARCH CODE --->
  <cfcase value="zipcode_search">  
    
    <!--- Strip out invalid characters --->
    <cfset #temp# = #Trim(search_text)#>
    <!--- <cfset #temp# = REReplace(temp, "( ){1,}", "", "ALL")> --->
    
	<!--- search keyword in items --->
    <cfquery username="#db_username#" password="#db_password#" name="get_kw_items" datasource="#datasource#">
       SELECT I.itemnum, U.user_id, U.postal_code
         FROM items I, users U
        WHERE I.title LIKE '%#temp#%'
		  AND I.date_end > #TIMENOW#
		  AND I.user_id = U.user_id
           OR I.description LIKE '%#temp#%'
		  AND I.date_end > #TIMENOW#
		  AND I.user_id = U.user_id
    </cfquery>
	
	<cfloop query="get_kw_items">
		<!--- check distance --->
		<cfmodule template="#go_back#zipcodes/BetweenZips.cfm"
		zipCode1 = #from_zipcode#
		zipCode2 = #postal_code#
		unit = "#measure_type#">
		<cfif LatLonDistance lte radius>
			<cfset itemnum_list = listappend(itemnum_list,#itemnum#)>
		</cfif>
	</cfloop>
	
		<cfif itemnum_list eq "">
			<cfset itemnum_list = 0>
		</cfif>
    
    <!--- Build a query --->
    <cfif #get_kw_items.recordcount# GT 0>
      <cfset #sql_code2# = "SELECT * FROM items WHERE itemnum in (#itemnum_list#) AND hide = 0 ORDER BY #order_by# #sort_order#">
    <cfelse>
      <cfset #error_string# = "Sorry, no items matching your keyword were found.  You may want to go back and modify your search.">
    </cfif>
  </cfcase>
  
  <!--- The default case --->
  <cfdefaultcase>
    <cfset #error_string# = "Invalid search type specified, aborting...">
  </cfdefaultcase>
</cfswitch>
</cfif>

<!--- Run the query --->
<cftry>
  <cfif #error_string# is "">
    
    <cfif IsDefined("Variables.sql_code2")>
      <cfquery username="#db_username#" password="#db_password#" name="get_results2" datasource="#DATASOURCE#">
          #PreserveSingleQuotes(sql_code2)#
      </cfquery>
    </cfif>
  </cfif>
  
  <cfcatch type="ANY">
    <cfset #error_string# = "Invalid search query.  Please double-check your search text for correct placement of parenthesis (&nbsp;) and correct usage of search keywords 'and', 'or', and 'not'.test">
  </cfcatch>
</cftry>
 
<cfoutput>

<html>
  <head>
    <title>Search Results</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
    <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            <font size=4 color="000000">
              <b>Search Results Page - #search_name#</b>
            </font>
          </td>
        </tr>
        <tr>
          <td>         <hr size=1 color=#heading_color# width=100%></td>
        </tr>
        <tr>
          <td>
           
              <cfif #error_string# is "">
                <cfif IsDefined("Variables.sql_code2")>
                  <cfset resultsFound = IIf(get_results2.RecordCount, DE("TRUE"), DE("FALSE"))>
                <cfelse>
                  <cfset resultsFound = IIf(get_results2.RecordCount, DE("TRUE"), DE("FALSE"))>
                </cfif>
                
                <cfif Variables.resultsFound>
                  <cfif IsDefined("Variables.sql_code2")>
                    <b>#Evaluate(get_results2.RecordCount)# item(s) matching your search criteria were found:</b>
                  <cfelse>
                    <b>#get_results2.RecordCount# item(s) matching your search criteria were found:</b>
                  </cfif>
                  
                  <br>
                  <center>
                    <cfif IsNumeric(PgNum)>
                      <cfif PgNum GT 1>
                        [<a href="search_zipcode.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&search_type=zipcode_search&radius=#radius#&measure_type=#measure_type#&search_name=Search+by+zipcode&from_zipcode=#from_zipcode#&search_text=#search_text#&order_by=title&sort_order=ASC&PgNum=#Evaluate(PgNum - 1)#">Previous</a>]
                      </cfif>
                    </cfif>
                    
                    <cfset sDspPgNum = IIf(IsNumeric(PgNum), "PgNum", "1")>
                    
                    Viewing Page #Variables.sDspPgNum#.
                    
                    <cfif IsDefined("Variables.sql_code2")
                      AND Variables.iEndRow LT Evaluate(get_results2.RecordCount)
                      OR not IsDefined("Variables.sql_code2")>
                      <!--- AND Variables.iEndRow LT get_results.RecordCount> --->
                      
                      <cfif IsNumeric(PgNum)>
                        [<a href="search_zipcode.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&search_type=zipcode_search&radius=#radius#&measure_type=#measure_type#&search_name=Search+by+zipcode&from_zipcode=#from_zipcode#&search_text=#search_text#&order_by=title&sort_order=ASC&PgNum=#Evaluate(PgNum + 1)#">Next</a>]
                      </cfif>
                    </cfif>
                  </center>
                  <br>
                  <br>
                  
                  <cfmodule template="../functions/prnt_listing.cfm"
                    part="HEADER"
                    featured_studio="#get_results2.featured_studio#"
             	    show_thumbs="#get_thumbsMode.show_thumbs#"
                    VAROOT="#VAROOT#"
					datasource="#DATASOURCE#"
					db_username="#db_username#"
					db_password="#db_password#"
					heading_color="#heading_color#"
					heading_fcolor="#heading_fcolor#"
					heading_font="#heading_font#">
                  
                  <cfset item_count = 0>
                  <cfset loopTo = IIf(IsDefined("Variables.sql_code2"), DE("1"), DE("1"))>
                  <cfset queryName = "get_results2">
                  
                  <cfloop index="i" from=1 to=#loopTo#>
                    <cfloop query="#queryName#" startrow="#Variables.iStartRow#" endrow="#Variables.iEndRow#">
                      <!--- get distance to display --->
					  <!--- resolve the search string into a user ID --->
    					<cfquery username="#db_username#" password="#db_password#" name="zipcode_from_item2" datasource="#datasource#">
       						SELECT postal_code
         					FROM users
        					WHERE user_id = #user_id#
    					</cfquery>
						<!--- check distance --->
						<cfmodule template="#go_back#zipcodes/BetweenZips.cfm"
						zipCode1 = #from_zipcode#
						zipCode2 = #zipcode_from_item2.postal_code#
						unit = "#measure_type#">
						<cfset LatLonDistance = numberformat(LatLonDistance)>
						<cfset distance = "<font color=Green>(#LatLonDistance# #measure_text#)</font>">
					  
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
                     <cfif auction_mode is 1> 
					  <!-- get lowest bid -->
					   <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
                          SELECT MIN(bid) AS price
                            FROM bids
                           WHERE itemnum = #itemnum#
                      </cfquery>
					  </cfif>
                      <!--- output listing --->
					  <cfif isDefined('url.auction_mode')>
					  <cfif auction_mode is 0>
                      <cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title# #distance#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						highest="#HighestBid.price#"
                        minimum_bid="#minimum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#get_results.featured_studio#"
                 	    show_thumbs="#get_thumbsMode.show_thumbs#"
						numbermask="#numbermask#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#">
						<cfelse>
						<cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title# #distance#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						lowest="#LowestBid.price#"
                        maximum_bid="#maximum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#featured_studio#"
                 	    show_thumbs="#get_thumbsMode.show_thumbs#"
						numbermask="#numbermask#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#">
						</cfif><cfelseif auction_mode is not 1>
						<cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title# #distance#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						highest="#HighestBid.price#"
                        minimum_bid="#minimum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#featured_studio#"
                 	    show_thumbs="#get_thumbsMode.show_thumbs#"
						numbermask="#numbermask#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#"><cfelse>
							<cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title# #distance#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						lowest="#LowestBid.price#"
                        maximum_bid="#maximum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#featured_studio#"
                 	    show_thumbs="#get_thumbsMode.show_thumbs#"
						numbermask="#numbermask#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#">
                      </cfif>
                    </cfloop>
                    <cfset queryName = "get_results2">
                  </cfloop>
                  
                  <cfmodule template="../functions/prnt_listing.cfm" part="FOOTER">
                  <br>
                  <center>
                    <cfif IsNumeric(PgNum)>
                      <cfif PgNum GT 1>
                        [<a href="search_zipcode.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&search_type=zipcode_search&radius=#radius#&measure_type=#measure_type#&search_name=Search+by+zipcode&from_zipcode=#from_zipcode#&search_text=#search_text#&order_by=title&sort_order=ASC&PgNum=#Evaluate(PgNum - 1)#">Previous</a>]
                      </cfif>
                    </cfif>
                    
                    <cfset sDspPgNum = IIf(IsNumeric(PgNum), "PgNum", "1")>
                    
                    Viewing Page #Variables.sDspPgNum#.
                    
                    <cfif IsDefined("Variables.sql_code2")
                      AND Variables.iEndRow LT Evaluate(get_results2.RecordCount)
                      OR not IsDefined("Variables.sql_code2")>
                      <!--- AND Variables.iEndRow LT get_results.RecordCount> --->
                     
                      <cfif IsNumeric(PgNum)>
                        [<a href="search_zipcode.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&search_type=zipcode_search&radius=#radius#&measure_type=#measure_type#&search_name=Search+by+zipcode&from_zipcode=#from_zipcode#&search_text=#search_text#&order_by=title&sort_order=ASC&PgNum=#Evaluate(PgNum + 1)#">Next</a>]
                      </cfif>
                    </cfif>
                  </center>
                <cfelse>
                  <b>Sorry, no item was found in the database in #radius# #measure_text# from #from_zipcode#.</b><br>
                  <br>
                </cfif>
                
              <cfelse>
                <font size=2 color="ff0000">
                  <b>#error_string#</b>
                </font>
              </cfif>
              <br>
              
			  <cfif trim(search_text) eq "%">
			  	<cfset search_text = "">
			  </cfif>
              <form name="blah" action="index.cfm" method="get">
                <input type="hidden" name="search_type" value="#search_type#">
                <input type="hidden" name="search_text" value="#search_text#">
                <input type="hidden" name="search_span" value="#search_span#">
                <input type="hidden" name="search_limit" value="#search_limit#">
                <input type="hidden" name="order_by" value="#order_by#">
                <input type="hidden" name="sort_order" value="#sort_order#">
                <input type="hidden" name="country" value="#country#">
                <input type="hidden" name="country_type" value="#country_type#">
                <input type="hidden" name="category" value="#category#">
				<input type="hidden" name="from_zipcode" value="#from_zipcode#">
				<input type="hidden" name="radius" value="#radius#">
				<input type="hidden" name="measure_type" value="#measure_type#">
                <input type="submit" id="submit" value="<< Back" width=75>
              </form>
            </font>
          </td>
        </tr>
        </table>
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
      </table></div>
  </body>
</html>
</cfoutput>
<cfsetting enablecfoutputonly="no">
