<!---
	--- HomePageRenderer
	--- ----------------
	---
	--- Page renderer for home page.
	---
	--- author: bsterner
	--- date:   6/14/14
	--->
<cfcomponent displayname="Home Page Renderer" hint="Page renderer for home page."
	extends="/CF-INF/cfc/AbstractPageRenderer" accessors="true" output="false" persistent="false">


	<cffunction name="getPageModel" hint="Overrides default page model rendering method." returntype="struct">
		<cfset var pageModel = structNew()>
		<cfset var getCategoryNew = "">
		<cfset var getFeatcolspage = "">
		<cfset var getFeaturedItemsPage = "">
		<cfset var getLimitCategoryFrontPage = "">
		<cfset var getNews = "">
		<cfset var getTopSellers = "">
		<cfset var getSellers = "">
		<cfset var getNewUsers = "">
		<cfset var getCategories = "">
		<cfset var getLoginCategories = "">
		<cfset var getFeatured = "">
		<cfset var getHotAuction = "">
		<cfset var getHotauctions = "">
		<cfset var getStats = "">
		<cfset var getThumbsMode = "">
		<cfset var getCounter = "">
		<cfset var getAds = "">
		<cfset var getBanners = "">
		<cfset var dateUtil = createObject("component", "/CF-INF/cfc/DateUtil")>
		<cfset var timeNow = dateUtil.getTimeNow()>
		<!--- get days category considered new --->
		<cfquery name="getCategoryNew" datasource="#application.datasource#">
		    SELECT pair AS days
		    FROM defaults
		    WHERE name = 'category_new'
		</cfquery>
		<cfquery name="getFeatcolspage" datasource="#application.datasource#">
		    SELECT pair
		    FROM defaults
		    WHERE name='featcolspage'
		</cfquery>
		<!---<cfset #featcolspage# = #get_featcolspage.pair#> --->
		<cfquery name="getFeaturedItemsPage" datasource="#application.datasource#">
		    SELECT pair
		    FROM defaults
		    WHERE name='featitemspage'
		</cfquery>
		<cfquery  name="getNews" datasource="#application.datasource#" maxrows=1>
		   SELECT  *
            FROM news
		   WHERE news IS NOT NULL
		   ORDER BY date_posted DESC
		</cfquery>
		<cfquery name="getTopSellers" datasource="#application.datasource#">
		   SELECT pair
		     FROM defaults
		    WHERE name='top_seller'
		</cfquery>
		<!---<cfset #top_seller# = #get_topsellers.pair#> --->
		<cfquery name="getSellers" datasource="#application.datasource#" maxrows=5>
		  SELECT user_id, count(user_id) as counted from items
		  where status = 1
		  ORDER BY count(user_id) DESC
		</cfquery>
		<cfquery name="getNewUsers" datasource="#application.datasource#" maxrows=5>
		    SELECT nickname,date_registered
		      FROM users
		     WHERE is_active= 1
		order by date_registered DESC
		</cfquery>
		<cfquery name="getLimitCategoryFrontPage" datasource="#application.datasource#">
			SELECT pair
			FROM defaults
			WHERE name='limitcat_frpage'
		</cfquery>
		<!--- get /root categories for front page --->
		<cfquery name="getCategories" datasource="#application.datasource#" maxrows="#getLimitCategoryFrontPage.pair#">
		    SELECT category, name, date_created, child_count, count_total
		      FROM categories
		     WHERE parent = 0
		       AND active = 1
		       AND require_login = 0
		     ORDER BY name ASC
		</cfquery>
		<!--- get category that require login --->
		<cfquery name="getLoginCategories" datasource="#application.datasource#">
		    SELECT category
		      FROM categories
		     WHERE active = 1
		       AND require_login = 1
		</cfquery>
		<!--- get newest featured --->
		<cfquery name="getFeatured" datasource="#application.datasource#" maxrows="#getFeaturedItemsPage.pair#">
		    SELECT itemnum, title, featured, bold_title, auction_mode
		      FROM items
		     WHERE featured = 1
		       AND status = 1
		       AND date_start < #application.timenow#
		       AND date_end > #application.timenow#
		     ORDER BY itemnum DESC
		</cfquery>
		<!--- get number of bids required for hot auction --->
		<cfquery name="getHotAuction" datasource="#application.datasource#">
		    SELECT pair AS bids
		      FROM defaults
		     WHERE name = 'bids4hot'
		</cfquery>
		<cfquery name="getHotauctions" datasource="#application.datasource#" maxrows="#getFeaturedItemsPage.pair#">
			SELECT B.itemnum, count(B.itemnum) as total_items from bids B, items I
			WHERE B.itemnum = I.itemnum
				AND I.status = 1
			GROUP BY B.itemnum HAVING count(B.itemnum) >= #getHotAuction.bids#
			ORDER BY count(B.itemnum) DESC
		</cfquery>
		<!--- get total number items for sale,categories,bids and total auctions ever --->
		<cfquery name="getStats" datasource="#application.datasource#">
		    SELECT auctions,bids,categories,total_auctions,tracking
		    FROM stats
		    WHERE id = 1
		</cfquery>
		<!--- get thumbs mode settings (Thumbnail display outside studio) --->
		<cfquery name="getThumbsMode" datasource="#application.datasource#">
		    SELECT pair AS show_thumbs
		      FROM defaults
		     WHERE name = 'enable_thumbs'
		</cfquery>
		<cfquery name="getCounter" datasource="#application.datasource#">
			SELECT hit
			FROM stats
			WHERE id=1
		</cfquery>
		<cfquery name="getAds" datasource="#application.datasource#">
			SELECT picture, webaddress
			FROM adv_info
			WHERE status = 1 AND paused = 0 AND date_end > #TIMENOW#
		</cfquery>
		<!--- Get Banner Pictures Updated  August 09,2011 Sylvester --->
		<cfquery name="getBanners" datasource="#application.datasource#">
			SELECT *
			FROM banners
			WHERE banner_enable = '1'
		</cfquery>
		<!--- Add query results to page model --->
		<cfset pageModel.getCategoryNew = getCategoryNew>
		<cfset pageModel.getFeatcolspage = getFeatcolspage>
		<cfset pageModel.getFeaturedItemsPage = getFeaturedItemsPage>
		<!--- <cfset pageModel.getLimitCategoryFrontPage = getLimitcatFrontpage> --->
		<cfset pageModel.getNews = getNews>
		<cfset pageModel.getTopSellers = getTopSellers>
		<cfset pageModel.getSellers = getSellers>
		<cfset pageModel.getNewUsers = getNewUsers>
		<cfset pageModel.getCategories = getCategories>
		<cfset pageModel.getLoginCategories = getLoginCategories>
		<cfset pageModel.getFeatured = getFeatured>
		<cfset pageModel.getHotAuction = getHotAuction>
		<cfset pageModel.getHotauctions = getHotauctions>
		<cfset pageModel.getStats = getStats>
		<cfset pageModel.getThumbsMode = getThumbsMode>
		<cfset pageModel.getCounter = getCounter>
		<cfset pageModel.getAds = getAds>
		<cfset pageModel.getBanners = getBanners>
		<cfreturn pageModel>
	</cffunction>


</cfcomponent>
