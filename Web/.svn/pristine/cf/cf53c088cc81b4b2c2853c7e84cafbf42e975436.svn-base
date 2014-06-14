<!---
  gen_listings.cfm
  builds a current listings page using given category & group

--->
<cfsetting enablecfoutputonly="Yes">

<cfinclude template="../../includes/app_globals.cfm">


<!--- define values --->
<cfparam name="group" default="1">
<cfparam name="listing" default="current">
<cfparam name="sortby" default="default">
<cfparam name="category" default="-1">

<!--- define info --->
<cfif listing IS "current">
  <cfset headtitle = "Current Listings:">
  <cfset pageLink = "&sortby=#sortby#">
  <cfset current_page = "current">
  <cfset sortByAction = "category=#category#">
  
<cfelseif listing IS "new">
  <cfset headtitle = "New Today:">
  <cfset pageLink = "&listing=new&sortby=#sortby#">
  <cfset current_page = "new">
  <cfset sortByAction = "category=#category#&listing=new">
  
<cfelseif listing IS "ending">
  <cfset headtitle = "Ending Today:">
  <cfset pageLink = "&listing=ending&sortby=#sortby#">
  <cfset current_page = "ending">
  <cfset sortByAction = "category=#category#&listing=ending">
  
<cfelseif listing IS "completed">
  <cfset headtitle = "Completed:">
  <cfset pageLink = "&listing=completed&sortby=#sortby#">
  <cfset current_page = "completed">
  <cfset sortByAction = "category=#category#&listing=completed">
  
<cfelseif listing IS "going">
  <cfset headtitle = "Going Soon:">
  <cfset pageLink = "&listing=going&sortby=#sortby#">
  <cfset current_page = "going">
  <cfset sortByAction = "category=#category#&listing=going">
</cfif>

<cfinclude template="../../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">

<!--- get this category's info --->
<cfquery username="#db_username#" password="#db_password#" name="get_CategoryInfo" datasource="#DATASOURCE#">
    SELECT name, date_created, child_count, user_id
      FROM categories
     WHERE category = #category#
</cfquery>


<!--- if invalid category, redirect --->
<cfif not get_CategoryInfo.RecordCount>
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
</cfif>

<!--- define number of pages for category --->
<cfquery username="#db_username#" password="#db_password#" name="get_PageGroup" datasource="#DATASOURCE#">
    SELECT pair AS itemsperpage
      FROM defaults
     WHERE name = 'itemsperpage'
</cfquery>

<cfset countgroup = Trim(get_PageGroup.itemsperpage)>

<!--- define total num of pages --->
<cfmodule template="../../functions/countauctions.cfm"
  category="#category#"
  listings="#listing#"
  datasource="#DATASOURCE#"
  timenow="#TIMENOW#"
  return="total_auctions">

<cfif total_auctions IS 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling(total_auctions / countgroup)>
</cfif>

<!--- get # of days category is new --->
<cfquery username="#db_username#" password="#db_password#" name="CategoryNew" datasource="#DATASOURCE#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'category_new'
</cfquery>

<!--- get # of days item is new --->
<cfquery username="#db_username#" password="#db_password#" name="ListingNew" datasource="#DATASOURCE#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'listing_new'
</cfquery>
<!--- get if category is exclusive listing only --->

<CFIF #get_CategoryInfo.user_id# is 0 OR #get_CategoryInfo.user_id# is "">

<cfelse>
<cfquery username="#db_username#" password="#db_password#" name="Exclusive" datasource="#DATASOURCE#">
SELECT user_id,nickname,password
      FROM users
     WHERE user_id = #get_CategoryInfo.user_id#
	 </cfquery>
	 
	 </CFIF>
	  
	 
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

<cfquery username="#db_username#" password="#db_password#" name="get_colorInfo" datasource="#DATASOURCE#">
select bg_color, heading_color, font_color, font_style,cat_image
from categories
where category = #category#
</cfquery>

<!--- get listing ending hours color --->
<cfquery username="#db_username#" password="#db_password#" name="HrsEndingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'hrsending_color'
</cfquery>

<!--- get parents of this category --->
<cfmodule template="../../functions/parentlookup.cfm"
  CATEGORY="#category#"
  DATASOURCE="#DATASOURCE#"
  RETURN="parents_array">

<!--- define EPOCH --->
<cfmodule template="../../functions/epoch.cfm">

<!--- define listing row color --->
<cfquery username="#db_username#" password="#db_password#" name="get_ListingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'listing_bgcolor'
</cfquery>

<!--- define sort order --->
<cfif sortby EQ "date_asc">
  <cfset orderby = "itemnum ASC">
<cfelseif sortby EQ "title_desc">
  <cfset orderby = "title DESC">
<cfelseif sortby EQ "title_asc">
  <cfset orderby = "title ASC">
<cfelse>
  <cfset orderby = "itemnum DESC">
</cfif>

<!--- get thumbs mode settings (Thumbnail display outside studio) --->
<cfquery username="#db_username#" password="#db_password#" name="get_thumbsMode" datasource="#DATASOURCE#">
    SELECT pair AS show_thumbs
      FROM defaults
     WHERE name = 'enable_thumbs'
</cfquery>

<!--- get all active auctions --->
<cfquery username="#db_username#" password="#db_password#" name="get_all_auctions" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
      SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end, auction_mode
        FROM items
       WHERE category1 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
          OR category2 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
       ORDER BY #orderby#
  </cfquery>

<!--- get info for all auctions on this page --->
<cfif listing IS "current">
  <cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
      SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end, auction_mode
        FROM items
       WHERE category1 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
          OR category2 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
       ORDER BY #orderby#
  </cfquery>
  
<cfelseif listing IS "new">
  <cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
      SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end, auction_mode
        FROM items
       WHERE category1 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_start >= #DateAdd("d", -1, TIMENOW)#
         AND date_end > #TIMENOW#
          OR category2 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_start >= #DateAdd("d", -1, TIMENOW)#
         AND date_end > #TIMENOW#
       ORDER BY #orderby#
  </cfquery>

<cfelseif listing IS "ending">
  <cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
      SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end, auction_mode
        FROM items
       WHERE category1 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
         AND date_end <= #DateAdd("d", 1, TIMENOW)#
          OR category2 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
         AND date_end <= #DateAdd("d", 1, TIMENOW)#
       ORDER BY #orderby#
  </cfquery>

<cfelseif listing IS "completed">
  <cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
      SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end, auction_mode
        FROM items
       WHERE category1 = #category#
         AND status = 0
         AND date_end < #TIMENOW#
         AND date_end >= #DateAdd("d", -30, TIMENOW)#
          OR category2 = #category#
         AND status = 0
         AND date_end < #TIMENOW#
         AND date_end >= #DateAdd("d", -30, TIMENOW)#
       ORDER BY #orderby#
  </cfquery>

<cfelseif listing IS "going">
  <cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
      SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end, auction_mode
        FROM items
       WHERE category1 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
         AND date_end <= #DateAdd("h", HrsEnding.hours, TIMENOW)#
          OR category2 = #category#
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
         AND date_end <= #DateAdd("h", HrsEnding.hours, TIMENOW)#
       ORDER BY #orderby#
  </cfquery>

</cfif>

<!--- output listings --->
<cfsetting enablecfoutputonly="No">
<cfif get_all_auctions.recordcount>
<!--- <html>
  <head>
    <title><cfoutput>#headtitle# #Trim(get_CategoryInfo.name)#</cfoutput></title>
        <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  <cfinclude template="../../includes/bodytag.html"> --->
  
  
    <!--- <center> --->
      <!--- <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <IMG SRC="<cfoutput>#VAROOT#</cfoutput>/images/logohere.gif"> &nbsp; &nbsp; &nbsp; 
              <font size=2>
                <cfinclude template="../../includes/menu_bar.cfm">
              </font>
              <br>
            </center>
          </td>
        </tr>
      </table>
      <br> --->
	       <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <font size=-1>
              <br>
              <cfmodule template="../../functions/sortorderlinks.cfm"
                sortby="#sortby#"
                action="#VAROOT#/listings/categories/index.cfm"
                addVars="#sortByAction#">
            </font>
          </td>
        </tr>
      </table>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <font size=3>
              <b>
                <cfsetting enablecfoutputonly="Yes">
                <!--- output parents --->
                <!--- <cfloop index="i" from="#ArrayLen(parents_array)#" to="1" step="-1">
                  <cfif i IS ArrayLen(parents_array)>
                    <cfset link = "#VAROOT#/listings/categories/index.cfm">
                  <cfelse>
                    <cfset link = "#VAROOT#/listings/categories/index.cfm?category=#parents_array[i][2]#">
                  </cfif>
                  <cfoutput><cfif #parents_array[i][2]# neq "0"><a href="#link#">#parents_array[i][1]#</a>: </cfif></cfoutput>
                </cfloop> --->
                <cfsetting enablecfoutputonly="No">
                <cfoutput>#get_CategoryInfo.name#</cfoutput>
                <!--- <cfif #get_categoryInfo.child_count# GT 0><cfoutput>:<a href="#VAROOT#/listings/categories/index.cfm?category=#category#">Subcategories</a></cfoutput></cfif> --->
              </b>
            </font>
			<br><b><cfoutput>#get_items.recordcount#</cfoutput></b> item(s) found<br>
            <!--- <hr width=100% size=1 noshade> --->
            <!--- <center> --->
			<font size=2>
                <cfsetting enablecfoutputonly="Yes">
                  <!--- output listing links --->
                  <cfmodule template="../../functions/listinglinks.cfm"
                    listingtype="#listing#"
                    category="#category#"
                    VAROOT="#VAROOT#">
                <cfsetting enablecfoutputonly="No">
                <!--- <br>
                Click here for more items: 
                <cfmodule template="../../functions/pagelinks.cfm"
                  thispage="#group#"
                  totalpages="#total_pages#"
                  link="#VAROOT#/listings/categories/index.cfm?category=#category##pageLink#"> --->
              </font>
            <!--- </center> --->
          </td>
        </tr>
      </table>
      <cfsetting enablecfoutputonly="Yes">
      
	  <cfif get_Items.recordcount>
      <!--- FEATURED AUCTIONS --->
      <cfoutput>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td bgcolor="#get_colorInfo.heading_color#">
            <font size=3 color="#get_colorInfo.font_color#" face="#get_colorInfo.font_style#">
              <b>
                Featured Auctions:<!---  #Trim(get_CategoryInfo.name)# --->
              </b>
            </font>
            <!--- <hr width=100% size=1 noshade> --->
          </td>
        </tr>
      </table>
      </cfoutput>
      
      <cfmodule template="../../functions/prnt_listing.cfm"
        part="HEADER"
	      featured_studio="#get_Items.featured_studio#"
	      show_thumbs="#get_thumbsMode.show_thumbs#"
        datasource="#DATASOURCE#"
		db_username="#db_username#"
		db_password="#db_password#"
		heading_color="#get_colorInfo.bg_color#"
		heading_fcolor="000000"
		heading_font="#get_colorInfo.font_style#">
      
      <cfset item_count = 0>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>
      
      <cfloop query="get_Items" startrow=#startrow#>
        
        <!--- if meets criteria of group --->
        <cfif featured_cat>
          
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
			   AND buynow = 0
          </cfquery>
		  
		  <!--- get lowest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
          <!--- output listing --->
          <cfmodule template="../../functions/prnt_listing.cfm"
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
      			lowest="#LowestBid.price#"
            highest="#HighestBid.price#"
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
      	    auction_mode="#get_Items.auction_mode#"
			      featured_studio="#featured_studio#"
    	      show_thumbs="#get_thumbsMode.show_thumbs#"
            status = "#status#"
            VAROOT="#VAROOT#"
			datasource="#DATASOURCE#"
			db_username="#db_username#"
			db_password="#db_password#"
			numbermask="#numbermask#">
        </cfif>
      </cfloop>
      
      <!--- if no listings show blank --->
      <cfif not item_count>
        <cfmodule template="../../functions/prnt_listing.cfm"
          part="BLANK"
          rowcolor="#get_ListingColor.color#">
      </cfif>
      
      <cfmodule template="../../functions/prnt_listing.cfm" 
      part="FOOTER">
      <!--- /FEATURED AUCTIONS --->
      

      <!--- ALL AUCTIONS --->      
      <cfoutput>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td bgcolor="#get_colorInfo.heading_color#">
            <font size=3 color="#get_colorInfo.font_color#" face="#get_colorInfo.font_style#">
              <b>
                All Auctions:<!---  #Trim(get_CategoryInfo.name)#  --->
              </b>
            </font>
            <!--- <hr width=100% size=1 noshade> --->
          </td>
        </tr>
      </table>
      </cfoutput>
      
      <cfmodule template="../../functions/prnt_listing.cfm"
        part="HEADER"
	      featured_studio="#get_Items.featured_studio#"
 	      show_thumbs="#get_thumbsMode.show_thumbs#"
        datasource="#DATASOURCE#"
		db_username="#db_username#"
		db_password="#db_password#"
		heading_color="#get_colorInfo.bg_color#"
		heading_fcolor="000000"
		heading_font="#get_colorInfo.font_style#">
      
      <cfset item_count = 0>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>
      
      <cfloop query="get_Items" startrow=#startrow#>
        
        <!--- if meets criteria of group --->

          
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
			   AND buynow = 0
          </cfquery>
		  
		  <!--- get lowest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
          <!--- output listing --->
          <cfmodule template="../../functions/prnt_listing.cfm"
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
      			lowest="#LowestBid.price#"
            highest="#HighestBid.price#"
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
      			auction_mode="#get_Items.auction_mode#"
      			featured_studio="#featured_studio#"
			      show_thumbs="#get_thumbsMode.show_thumbs#"
            status = "#status#"
            VAROOT="#VAROOT#"
			datasource="#DATASOURCE#"
			db_username="#db_username#"
			db_password="#db_password#"
			numbermask="#numbermask#">
        
      </cfloop>
      
      <!--- if no listings show blank --->
      <cfif not item_count>
        <cfmodule template="../../functions/prnt_listing.cfm"
          part="BLANK"
          rowcolor="#get_ListingColor.color#">
      </cfif>
      
      <cfmodule template="../../functions/prnt_listing.cfm" 
      part="FOOTER">
      <!--- /ALL AUCTIONS --->
	  





      <!--- HOT AUCTIONS --->
      <!--- <cfoutput>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=4>
              <b>
                HOT Auctions: #Trim(get_CategoryInfo.name)#
              </b>
            </font>
                        <hr size=2 color=#heading_color# width=100%>
          </td>
        </tr>
      </table>
      </cfoutput>
      
      <cfmodule template="../../functions/prnt_listing.cfm"
        part="HEADER"
        featured_studio="#get_Items.featured_studio#"
 	      show_thumbs="#get_thumbsMode.show_thumbs#"        
        datasource="#DATASOURCE#">
      
      <cfset item_count = 0>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>

      <cfloop query="get_Items" startrow=#startrow#>
        
        <!--- get bids --->
        <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
            SELECT COUNT(itemnum) AS total
              FROM bids
             WHERE itemnum = #itemnum#
        </cfquery>
        
        <!--- if meets criteria of group --->
        <cfif CountBids.total GTE HotAuction.bids>
          
          <!--- increment item_count --->
          <cfset item_count = IncrementValue(item_count)>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND buynow = 0
          </cfquery>
		  
		  <!--- get lowest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
          <!--- output listing --->
          <cfmodule template="../../functions/prnt_listing.cfm"
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
      			lowest="#LowestBid.price#"
            highest="#HighestBid.price#"
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
      			auction_mode="#get_Items.auction_mode#"
      			featured_studio="#featured_studio#"
    	      show_thumbs="#get_thumbsMode.show_thumbs#"      			
            status = "#status#"
            VAROOT="#VAROOT#"
			numbermask="#numbermask#">
        </cfif>
      </cfloop>
      
      <!--- if no listings show blank --->
      <cfif not item_count>
        <cfmodule template="../../functions/prnt_listing.cfm"
          part="BLANK"
          rowcolor="#get_ListingColor.color#">
      </cfif>
      
      <cfmodule template="../../functions/prnt_listing.cfm" 
      part="FOOTER"> --->
      <!--- /HOT AUCTIONS --->
      
      <cfsetting enablecfoutputonly="No">
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- <br>
            <br> --->
            <center>
              <font size=2>
                <!--- <cfsetting enablecfoutputonly="Yes">
                  <!--- output listing links --->
                  <cfmodule template="../../functions/listinglinks.cfm"
                    listingtype="#listing#"
                    category="#category#"
                    VAROOT="#VAROOT#"> --->
                <cfsetting enablecfoutputonly="No">
                <br>
                Page: 
                <cfmodule template="../../functions/pagelinks.cfm"
                  thispage="#group#"
                  totalpages="#total_pages#"
                  link="#VAROOT#/listings/categories/index.cfm?category=#category##pageLink#">
              </font>
            </center>
            <br>
            <!--- <font size=-1>
              <cfmodule template="../../functions/sortorderlinks.cfm"
                sortby="#sortby#"
                action="#VAROOT#/listings/categories/index.cfm"
                addVars="#sortByAction#">
            </font> --->
            <font size=2>
              Click on any item title to see the auctions complete information and to place 
              a bid.  If an auction's ending time is highlighted it will be ending in 
              less then <cfoutput>#HrsEnding.hours#</cfoutput> hours.  None of the above 
              items have been verified... caveat emptor.  Please remember to reload this 
              page regularly.
            </font>
            <cfsetting enablecfoutputonly="Yes">
              
            
            <cfsetting enablecfoutputonly="No">
          </td>
        </tr>
      </table>
      <br>
	  <cfelse>
	  <cfsetting enablecfoutputonly="No">
	  <br><b>No auctions</b>
      </cfif>
      <!--- <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <IMG SRC="<cfoutput>#VAROOT#</cfoutput>/images/logohere.gif"> &nbsp; &nbsp; &nbsp; 
              <font size=2>
                <cfinclude template="../../includes/menu_bar.cfm">
              </font>
            </center>
            <br>
          </td>
        </tr>
      </table>
      <br> --->
     
    <!--- </center> --->
	<cfelse>
		<cfif category neq 0><br><br><b>No auctions in this category</b></cfif>
	</cfif>
	
