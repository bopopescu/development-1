<cfsetting enablecfoutputonly="yes">
<!--- 
	Search Results Page:
	modified for studio integration
	Walter 11/24/99
 --->

<!--- def vals --->
<cfset current_page = "search_results">
<cfparam name="search_type" default="title_search">
<cfparam name="search_name" default="Title & Description Search">
<cfparam name="phrase_match" default="all">
<cfparam name="PgNum" default="1">      <!--- def page number to disp, 1 for first page --->

<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">

<!--- Check for unauthorized entry into the page --->
 <cfif #isDefined ("search_text")# is 0>
  <cflocation url="index.cfm">
<cfelseif #trim (search_text)# is "">
  <cflocation url="index.cfm">
</cfif> 

<!--- Check for passed-in params --->
<cfif #isDefined ("search_type")# is 0>
  <cfset #search_type# = "title_search">
</cfif>
<cfif #isDefined ("search_name")# is 0>
  <cfset #search_name# = "Title &amp Description Search">
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

<!--- Reset the SQL statement string --->
<cfset #sql_code# = "">
<cfset #error_string# = "">

<!--- Handle various search types individually --->
<cfswitch expression=#search_type#>
  
  <!--- *** TITLE/DESCRIPTION SEARCH CODE --->
  <cfcase value="title_search">
    
    <!--- Trim their search string --->
 <cftry> 
      <!--- strip trailing spaces --->
      <cfset #sql_code# = #Trim(search_text)#>
      
      <!--- strip double spaces --->
  <cfset #sql_code# = REReplace(sql_code, "( ){2,}", " ", "ALL")> 
      
      <!--- escape '%' with '%%',
            replace all '*' wildcards with the SQL '%' equivalent,
            replace all '?' wildcards with the SQL '_' equivalent --->
      <cfset #sql_code# = #Replace(sql_code, "%", "%%", "ALL")#>
      <cfset #sql_code# = #Replace(sql_code, "*", "%", "ALL")#>
      <cfset #sql_code# = #Replace(sql_code, "?", "_", "ALL")#> 
      
      <!--- if exact phrase match --->
      <cfif phrase_match IS NOT "exact">
        
        <!--- strip 1 letter words --->
        <cfset #sql_code# = REReplace(sql_code, " [a-zA-Z] ", " ", "ALL")>
        
        <!--- strip 2 letter words --->
        <cfset temp = "as,be,do,if,in,is,it,no,of,or,to">
        <cfloop index="l" list="#temp#" delimiters=",">
          <cfset #sql_code# = #ReplaceNoCase(sql_code, " #l# ", " ", "ALL")#>
        </cfloop>
        
        <!--- strip noise words --->
        <cfset temp = "all,and,has,not,the,was">
        <cfloop index="l" list="#temp#" delimiters=",">
          <cfset #sql_code# = #ReplaceNoCase(sql_code, " #l# ", " ", "ALL")#>
        </cfloop>
      </cfif>
      
      <!--- define search field --->
      <cfset #field# = #search_span#>
      
      <!--- define logical opperator --->
      <cfset logOperator = IIf(phrase_match IS "any", DE("OR"), DE("AND"))>
      
      <!--- build search query --->
      <cfif phrase_match IS NOT "exact">
        <cfset temp = sql_code>
        <cfset sql_code = "">
        <cfset sql_code2 = "">
        <cfset counter = 1>
        <cfloop index="l" list="#temp#" delimiters=" ">
          <cfset logOp = IIf(counter LT ListLen(temp, " "), "logOperator", DE(""))>
          <cfset sql_code = "#sql_code# #field# LIKE '% #l# %' #logOp#">
          <cfset sql_code2 = "#sql_code2# #field# LIKE '%#l#%' #logOp#">
          <cfset counter = counter + 1>
        </cfloop>
      <cfelse>
        <cfset temp = sql_code>
        <cfset sql_code = "#field# LIKE '% #temp# %'">
        <cfset sql_code2 = "#field# LIKE '%#temp#%'">
      </cfif>
      
      <!--- Finalize the query --->
      <cfset sql_code = "SELECT * FROM ad_info WHERE (#sql_code#)">
      <cfif IsDefined("Variables.sql_code2")>
        <cfset sql_code2 = "SELECT * FROM ad_info WHERE (#sql_code2#)">
      </cfif>
      <cfif #search_category# is not "">
        <cfset sql_code = "#sql_code# AND (category1 = #search_category# or category2 = #search_category#)">
        <cfif IsDefined("Variables.sql_code2")>
          <cfset sql_code2 = "#sql_code2# AND (category1 = #search_category# or category2 = #search_category#)">
        </cfif>
      </cfif>
      <cfif #country# is not "">
        <cfif #country_type# is "in">
          <cfset #sql_code# = "#sql_code# AND (country LIKE '#country#')">
          <cfif IsDefined("Variables.sql_code2")>
            <cfset sql_code2 = "#sql_code2# AND (country LIKE '#country#')">
          </cfif>
        <cfelse>
          <cfset #sql_code# = "#sql_code# AND (country LIKE '#country#' OR ship_international = 1)">
          <cfif IsDefined("Variables.sql_code2")>
            <cfset sql_code2 = "#sql_code2# AND (country LIKE '#country#' OR ship_international = 1)">
          </cfif>
        </cfif>
      </cfif>
      <cfif #category# is not "-1">
        <cfset #sql_code# = "#sql_code# AND (category1 = #category# OR category2 = #category#)">
        <cfif IsDefined("Variables.sql_code2")>
          <cfset sql_code2 = "#sql_code2# AND (category1 = #category# OR category2 = #category#)">
        </cfif>
      </cfif>
      <cfif #search_limit# is "active">
        <cfset #sql_code# = "#sql_code# AND (status = 1 AND date_start < #TIMENOW# AND date_end > #TIMENOW#) ORDER BY #order_by# #sort_order#">
        <cfif IsDefined("Variables.sql_code2")>
          <cfset sql_code2 = "#sql_code2# AND (status = 1 AND date_start < #TIMENOW# AND date_end > #TIMENOW#) ORDER BY #order_by# #sort_order#">
        </cfif>
      <cfelseif #search_limit# is "inactive">
        <cfset #sql_code# = "#sql_code# AND (status = 0 AND date_end < #TIMENOW#) ORDER BY #order_by# #sort_order#">
        <cfif IsDefined("Variables.sql_code2")>
          <cfset sql_code2 = "#sql_code2# AND (status = 0 AND date_end < #TIMENOW#) ORDER BY #order_by# #sort_order#">
        </cfif>
      <cfelse>
        <cfset #sql_code# = "#sql_code# ORDER BY #order_by# #sort_order#">
        <cfif IsDefined("Variables.sql_code2")>
          <cfset sql_code2 = "#sql_code2# ORDER BY #order_by# #sort_order#">
        </cfif>
      </cfif>
      
      <!--- Check the query for potentially dangerous elements (e.g., DELETE FROM, SELECT FROM, DROP FROM, INSERT INTO) --->
      <cfif (#findNoCase ("DELETE FROM", search_text)# GT 0) or
            (#findNoCase ("INSERT INTO", search_text)# GT 0) or
            (#findNoCase ("DROP FROM", search_text)# GT 0) or
            (#findNoCase ("SELECT *", search_text)# GT 0)>
        <cfset #error_string# = "Invalid search query.  Please double-check your search text for correct placement of parenthesis (&nbsp;) and correct usage of search keywords 'and', 'or', and 'not'.">
      </cfif> 
      
      <!--- Catch any exceptions --->
   <cfcatch type="ANY">
        <cfset #error_string# = "Invalid search query.  Please double-check your search text for correct placement of parenthesis (&nbsp;) and correct usage of search keywords 'and', 'or', and 'not'. ">
      </cfcatch>  
      
   </cftry> 
  </cfcase>
  
  <!--- *** ITEM LOOKUP SEARCH CODE --->
  <cfcase value="item_search">  
    
    <!--- Strip out invalid characters --->
    <cfset #temp# = #search_text#>
    <cfset #temp# = #trim (temp)#>
    <cfset #temp# = #replace (temp, " ", "", "ALL")#>
    
    <!--- Handle multiple IDs --->
    <cfset #temp# = #replaceNoCase (temp, ",", " OR adnum =", "ALL")#>
    
    <!--- Build a SQL query --->
    <cfset #sql_code# = "SELECT * FROM ad_info WHERE">
    <cfset #sql_code# = "#sql_code# adnum = #temp#"> 
    <cfset #sql_code# = "#sql_code# ORDER BY #order_by# #sort_order#">
  </cfcase>
  
  <!--- *** SELLER LOOKUP SEARCH CODE --->
  <cfcase value="seller_search">  
    
    <!--- Strip out invalid characters --->
    <cfset #temp# = #search_text#>
   <cfset #temp# = #Trim(temp)#>
    <cfset #temp# = REReplace(temp, "( ){1,}", " ", "ALL")>
    
    <!--- First, resolve the search string into a user ID --->
    <cfquery username="#db_username#" password="#db_password#" name="resolve_user" datasource="#datasource#">
       SELECT user_id
         FROM users
        WHERE nickname LIKE '#temp#'
      <cfif #IsNumeric(temp)# is 1>
           OR user_id = #temp#
      </cfif>
    </cfquery>
    
	
	<!--- Build a query --->
    <cfif #resolve_user.recordcount# GT 0>
      <cfset #sql_code# = "SELECT * FROM ad_info WHERE user_id = #resolve_user.user_id# AND status = 1 ORDER BY #order_by# #sort_order#">
    <cfelse>
      <cfset #error_string# = "Sorry, no user was found in the database with the nickname or user ID you specified.  Please verify that you have the correct ID or nickname, and try your search again.">
    </cfif>
  </cfcase>
  
  <!--- The default case --->
  <cfdefaultcase>
    <cfset #error_string# = "Invalid search type specified, aborting...">
  </cfdefaultcase>
</cfswitch>

<!--- Run the query --->
<cftry>
  <cfif #error_string# is "">
    <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">
        #PreserveSingleQuotes(sql_code)#
    </cfquery>
    
    <cfif IsDefined("Variables.sql_code2")>
      <cfquery username="#db_username#" password="#db_password#" name="get_results2" datasource="#DATASOURCE#">
          #PreserveSingleQuotes(sql_code2)#
      </cfquery>
    </cfif>
  </cfif>
  
  <cfcatch type="ANY">
    <cfset #error_string# = "Invalid search query.  Please double-check your search text for correct placement of parenthesis (&nbsp;) and correct usage of search keywords 'and', 'or', and 'not'.">
  </cfcatch>
</cftry>
 
<cfoutput>

<html>
  <head>
    <title>Search Results</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../../includes/bodytag.html">
                <cfinclude template="../../includes/menu_bar.cfm">
  
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
          <td><hr width=100% size=1 color="#heading_color#" noshade></td>
        </tr>
        <tr>
          <td>
            <font size=3>
              <cfif #error_string# is "">
                <cfif IsDefined("Variables.sql_code2")>
                  <cfset resultsFound = IIf(get_results.RecordCount OR get_results2.RecordCount, DE("TRUE"), DE("FALSE"))>
                <cfelse>
                  <cfset resultsFound = IIf(get_results.RecordCount, DE("TRUE"), DE("FALSE"))>
                </cfif>
                
                <cfif Variables.resultsFound>
                  <cfif IsDefined("Variables.sql_code2")>
                    <b>#Evaluate(get_results.RecordCount + get_results2.RecordCount)# ad(s) matching your search criteria were found:</b>
                  <cfelse>
                    <b>#get_results.RecordCount# ad(s) matching your search criteria were found:</b>
                  </cfif>
                  
                  <br>
                  <center>
                    <cfif IsNumeric(PgNum)>
                      <cfif PgNum GT 1>
                        [<a href="search_results.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum - 1)#">Previous</a>]
                      </cfif>
                    </cfif>
                    
                    <cfset sDspPgNum = IIf(IsNumeric(PgNum), "PgNum", "1")>
                    
                    Viewing Page #Variables.sDspPgNum#.
                    
                    <cfif IsDefined("Variables.sql_code2")
                      AND Variables.iEndRow LT Evaluate(get_results.RecordCount + get_results2.RecordCount)
                      OR not IsDefined("Variables.sql_code2")
                      AND Variables.iEndRow LT get_results.RecordCount>
                      
                      <cfif IsNumeric(PgNum)>
                        [<a href="search_results.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum + 1)#">Next</a>]
                      </cfif>
                    </cfif>
                  </center>
                  <br>
                  <br>
                  
                  <cfmodule template="prnt_adlisting.cfm"
                    part="HEADER"
                       datasource="#DATASOURCE#">
                  
                  <cfset item_count = 0>
                  <cfset loopTo = IIf(IsDefined("Variables.sql_code2"), DE("2"), DE("1"))>
                  <cfset queryName = "get_results">
                  
                  <cfloop index="i" from=1 to=#loopTo#>
                    <cfloop query="#queryName#" startrow="#Variables.iStartRow#" endrow="#Variables.iEndRow#">
                      
                      <!--- increment item_count --->
                      <cfset item_count = IncrementValue(item_count)>
                      
                      <!--- get bids --->
                      <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
                          SELECT COUNT(adnum) AS total
                            FROM ad_offers
                           WHERE adnum = #adnum#
                      </cfquery>
                      
                      <!--- get highest bid --->
                      <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
                          SELECT MAX(offer) AS price
                            FROM ad_offers
                           WHERE adnum = #adnum#
                      </cfquery>
                     <cfif auction_mode is 1> 
					  <!-- get lowest bid -->
					   <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
                          SELECT MIN(offer) AS price
                            FROM ad_offers
                           WHERE adnum = #adnum#
                      </cfquery>
					  </cfif>
					  <!--- Get asking price --->
					<cfquery username="#db_username#" password="#db_password#" name="get_askingPrice" datasource="#datasource#">
    					SELECT ask_price as price
						FROM ad_info
						WHERE adnum = #adnum#
					</cfquery>	
                      <!--- output listing --->
					  <cfif isDefined('url.auction_mode')>
					  <cfif auction_mode is 0>
                      <cfmodule template="prnt_adlisting.cfm"
                        price="#get_askingPrice.price#"
						part="LISTING"
                        itemnum="#adnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="0"
                        picture=""
                        sound=""
                        banner="0"
                        banner_line=""
									lowest="#LowestBid.price#"
            						highest="#HighestBid.price#"
                        minimum_bid=""
				                totalbids="#CountBids.total#"
                        hotbids="0"
                        TIMENOW="#TIMENOW#"
						featured_studio=""
                 	      show_thumbs=""
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        VAROOT="#VAROOT#">
						<cfelse>
						<cfmodule template="prnt_adlisting.cfm"
                        price="#get_askingPrice.price#"
					    part="LISTING"
                        itemnum="#adnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="0"
                        picture=""
                        sound=""
                        banner="0"
                        banner_line=""
            						lowest="#LowestBid.price#"
									highest="#HighestBid.price#"
                        maximum_bid=""
				                totalbids="#CountBids.total#"
                        hotbids="0"
                        TIMENOW="#TIMENOW#"
						featured_studio=""
                 	      show_thumbs=""
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        VAROOT="#VAROOT#">
						</cfif><cfelseif auction_mode is not 1>
						<cfmodule template="prnt_adlisting.cfm"
                        price="#get_askingPrice.price#"
						part="LISTING"
                        itemnum="#adnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="0"
                        picture=""
                        sound=""
                        banner="0"
                        banner_line=""
									lowest=""
            						highest="#HighestBid.price#"
                        minimum_bid=""
						maximum_bid=""
				                totalbids="#CountBids.total#"
                        hotbids="0"
                        TIMENOW="#TIMENOW#"
						featured_studio=""
                 	      show_thumbs=""
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                         VAROOT="#VAROOT#"><cfelse>
							<cfmodule template="prnt_adlisting.cfm"
                        price="#get_askingPrice.price#"
						part="LISTING"
                        itemnum="#adnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="0"
                        picture=""
                        sound=""
                        banner="0"
                        banner_line=""
            						lowest="#LowestBid.price#"
									highest="#HighestBid.price#"
                        maximum_bid=""
				                totalbids="#CountBids.total#"
                        hotbids="0"
                        TIMENOW="#TIMENOW#"
						 listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio=""
                 	      show_thumbs=""
                        VAROOT="#VAROOT#">
                      </cfif>
                    </cfloop>
                    <cfset queryName = "get_results2">
                  </cfloop>
                  
                  <cfmodule template="prnt_adlisting.cfm" part="FOOTER">
                  
                <cfelse>
                  <b>Sorry, no ads matching your search criteria were found.  You may want to go back and modify your search.</b><br>
                  <br>
                </cfif>
                
              <cfelse>
                <font size=3 color="ff0000">
                  <b>#error_string#</b>
                </font>
              </cfif>
              <br>
  <hr width=100% size=1 color="#heading_color#" noshade>
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
                <input type="submit" value="<< Back" width=75>
              </form>
            </font>
          </td>
        </tr>
        <tr>
          <td>
           </table></div><div align="center">
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="center">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>

