<cfsetting enablecfoutputonly="yes">

<!--- define cache control page --->
<cfset current_page = "indexhome">
<cfinclude template = "./includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="./functions/timenow.cfm">

<!--- get days category considered new --->
<cfquery username="#db_username#" password="#db_password#" name="CategoryNew" datasource="#DATASOURCE#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'category_new'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_featcolspage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='featcolspage'
</cfquery>


<cfset #featcolspage# = #get_featcolspage.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_featitemspage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='featitemspage'
</cfquery>
<cfset #featitemspage# = #get_featitemspage.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_limitcat_frontpage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='application.limitCategoryFrontPage'
</cfquery>
<cfset #application.limitCategoryFrontPage# = #get_limitcat_frontpage.pair#>
<cfquery  name="get_news" datasource="#DATASOURCE#" maxrows=1>

select  * from news
where news is not null
order by date_posted DESC
</cfquery>



<cfquery username="#db_username#" password="#db_password#" name="get_topsellers" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='top_seller'
</cfquery>
<cfset #top_seller# = #get_topsellers.pair#>


<cfquery username="#db_username#" password="#db_password#" name="get_sellers" datasource="#DATASOURCE#" maxrows=5>
<!--- access query 
SELECT DISTINCTROW First(users.nickname) AS nickname,
First(items.user_id) AS [user_id Field], Count(items.user_id) AS moonpie
FROM items

   INNER JOIN users ON items.user_id = users.user_id
where items.status=1

GROUP BY items.user_id
HAVING (((Count(items.user_id)) > #top_seller#))



ORDER BY Count(items.user_id) DESC
--->

SELECT user_id, count(user_id) as counted from items
where status = 1
GROUP BY user_id HAVING count(user_id) > #top_seller#
ORDER BY count(user_id) DESC


</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="new_users" datasource="#DATASOURCE#" maxrows=5>
    SELECT nickname,date_registered
      FROM users
     WHERE is_active= 1 
order by date_registered DESC
</cfquery>

<!--- get /root categories for front page --->
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#" maxrows="#application.limitCategoryFrontPage#">
    SELECT category, name, date_created, child_count, count_total
      FROM categories
     WHERE parent = 0
       AND active = 1
       AND require_login = 0
     ORDER BY name ASC
</cfquery>

<!--- get category that require login --->
<cfquery username="#db_username#" password="#db_password#" name="LoginCategories" datasource="#DATASOURCE#">
    SELECT category
      FROM categories
     WHERE active = 1
       AND require_login = 1
</cfquery>

<!--- get newest featured --->
<cfif #get_layout.template# eq 4>
<cfquery username="#db_username#" password="#db_password#" name="get_Featured" datasource="#DATASOURCE#" maxrows="3">
    SELECT itemnum, title, featured, bold_title, auction_mode,description,minimum_bid
      FROM items
     WHERE featured = 1
       AND status = 1
       AND date_start < #TIMENOW#
       AND date_end > #TIMENOW#
  <!--- <cfloop query="LoginCategories">
       AND category1 <> #LoginCategories.category#
       AND category2 <> #LoginCategories.category#
  </cfloop> --->
order by newid()
</cfquery>
<cfelse>
<cfquery username="#db_username#" password="#db_password#" name="get_Featured" datasource="#DATASOURCE#" maxrows="#featitemspage#">
    SELECT itemnum, title, featured, bold_title, auction_mode,description,minimum_bid
      FROM items
     WHERE featured = 1
       AND status = 1
       AND date_start < #TIMENOW#
       AND date_end > #TIMENOW#
  <!--- <cfloop query="LoginCategories">
       AND category1 <> #LoginCategories.category#
       AND category2 <> #LoginCategories.category#
  </cfloop> --->
order by newid()
</cfquery>

</cfif>

<!--- get number of bids required for hot auction --->
<cfquery username="#db_username#" password="#db_password#" name="HotAuction" datasource="#DATASOURCE#">
    SELECT pair AS bids
      FROM defaults
     WHERE name = 'bids4hot'
</cfquery>


<cfif #get_layout.template# eq 4>

<cfquery username="#db_username#" password="#db_password#" name="get_hotauctions" datasource="#DATASOURCE#" maxrows="3">
<!---
SELECT B.itemnum, count(B.itemnum) as total_items from bids B, items I
WHERE B.itemnum = I.itemnum
AND I.status = 1
GROUP BY B.itemnum HAVING count(B.itemnum) >= #hotauction.bids#
ORDER BY count(B.itemnum) DESC
 Access query
    SELECT count(B.id) as total_items, I.itemnum, I.bold_title, I.title
      FROM items I, bids B

	  WHERE I.itemnum = B.itemnum

	  AND I.status = 1



   GROUP BY I.itemnum, I.title, I.bold_title

HAVING  (((count(b.id))) > #hotauction.bids#)


--->
SELECT     COUNT(b.itemnum) AS total, b.itemnum 
      FROM items I, bids B

	  WHERE I.itemnum = B.itemnum

	  AND I.date_end > #timenow#



GROUP BY b.itemnum
HAVING      (COUNT(b.itemnum) >= #hotauction.bids#)
order by newid()
</cfquery>
<cfelse>

<cfquery username="#db_username#" password="#db_password#" name="get_hotauctions" datasource="#DATASOURCE#" maxrows="#featitemspage#">
<!---
SELECT B.itemnum, count(B.itemnum) as total_items from bids B, items I
WHERE B.itemnum = I.itemnum
AND I.status = 1
GROUP BY B.itemnum HAVING count(B.itemnum) >= #hotauction.bids#
ORDER BY count(B.itemnum) DESC
 Access query
    SELECT count(B.id) as total_items, I.itemnum, I.bold_title, I.title
      FROM items I, bids B

	  WHERE I.itemnum = B.itemnum

	  AND I.status = 1



   GROUP BY I.itemnum, I.title, I.bold_title

HAVING  (((count(b.id))) > #hotauction.bids#)


--->
SELECT     COUNT(b.itemnum) AS total, b.itemnum 
      FROM items I, bids B

	  WHERE I.itemnum = B.itemnum

	  AND I.date_end > #timenow#



GROUP BY b.itemnum
HAVING      (COUNT(b.itemnum) >= #hotauction.bids#)
order by newid()
</cfquery>

</cfif>



<!--- get total number items for sale,categories,bids and total auctions ever --->
<cfquery username="#db_username#" password="#db_password#" name="get_stats" datasource="#DATASOURCE#">
    SELECT auctions,bids,categories,total_auctions,tracking
      FROM stats
     WHERE id = 1
</cfquery>



<!--- get thumbs mode settings (Thumbnail display outside studio) --->
<cfquery username="#db_username#" password="#db_password#" name="get_thumbsMode" datasource="#DATASOURCE#">
    SELECT pair AS show_thumbs
      FROM defaults
     WHERE name = 'enable_thumbs'
</cfquery>





<!--- get bool iescrow enabled 
<cfmodule template="./functions/iescrow.cfm"
  sOpt="ChkStatus">
--->
<!--- if iescrow enabled, get current vals 
<cfif hIEscrow.bEnabled>
  
  <cfmodule template="./functions/IEscrowIcons.cfm"
    sOpt="DISP/FRONTPAGE">
</cfif>
--->
<cfsetting enablecfoutputonly="No">

<!----------------------------- End all required queries --------------------------->

<html>
  <head>
    <title>Visual Auction</title>
    
    <meta name="keywords" content="<cfoutput>#get_layout.keywords#</cfoutput>">
    <meta name="description" content="<cfoutput>#get_layout.descriptions#</cfoutput>">
    
    <cfoutput><link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css"></cfoutput>
  </head>

  <script language = "javascript">
  function popup(){

var popup = window.open("","picWin","height=400,width=370,top=110,left=407")
popup.document.write('<B><font face=Arial size=2>Reverse Auctions!</FONT></B><BR>')

    popup.document.write("<font face='Arial' size='2'><br>You've seen it used on top auction sites, now you can use it too - a Reverse Auction! Build a state-of-the-art marketplace on the web where everyone gets what they want. Buyers get the best prices and sellers make quick profits!<br><br>With a ")
    popup.document.write("<img src='images/r_reverse.gif' border='0'>")
    popup.document.write("\"reverse\" auction, prospective buyers can list any item that they wish to buy and then sellers bid to provide the best price. This concept is much more consumer oriented than a regular auction. The consumer decides the exact specifications of each item, instead of the specifications being dictated by the seller.<br><br>Buyers can find sellers who will offer the best prices on virtually any item. Sellers have access to an unlimited number of buyers who can compete for their business in an auction environment.<br><br>Reverse auctions can help corporate purchasing departments find the best deals for industrial parts and components, for example. No matter what the item is - tickets, raw material, services, etc. the reverse auction opens a gate to the world market for those who need merchandise and those willing to provide it.</font>")
    popup.document.close()
  }
  
  </script>  

  <!--- Page body start here --->



<!--- add your site to favorites folder . Replace 'Beyond solutions auction software with your own description --->

<!---

<body onload="window.external.AddFavorite('http://<cfoutput>#cgi.server_name##VAROOT#</cfoutput>/','Beyond Solutions Auction Software')";>


--->
<!--- Border Table --->
<center>

<cfinclude template="./includes/bodytag.html">

<!--- Top menu bar start here --->



<cfinclude template="./includes/menu_bar.cfm">


<cfif #get_layout.template# eq 4>
<cfinclude template="main.cfm">
</cfif>

<!---<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="5" BORDER="2"> --->

<cfif #get_layout.template# eq 1>


<TABLE WIDTH="640" CELLSPACING="0" CELLPADDING="2" BORDER="0">
   <tr>
   	<td>
   
<!--- START Content Table consisting of 3 Columns --->
<TABLE border="0" align=left>
	<tr valign="top">
		
	<!--- START COLUMN 1 --->
	<td width="256">qwerty

	     <!--- What's new --->



<cfif #get_layout.news# eq 1>
		 <cfinclude template="inc_news.cfm">
		
</cfif>		
	<!--- Categories --->
		<cfinclude template="inc_categories.cfm">
<cfif #get_layout.statistic# eq 1>

		<cfinclude template="inc_statistic.cfm">
</cfif>

<cfif #get_layout.tellafriend# eq 1>
		<cfinclude template="inc_email.cfm">
</cfif>

	</td>
	<!---  end column 1 categories --->

	<!--- START COLUMN 2 --->
	<td width=100%>
		
		<!--- The studio graphic display --->

<cfif #get_layout.gallery# eq 1>

		<cfinclude template="inc_studio_graphic.cfm">
</cfif>

		
		<!--- Featured Auctions --->

<cfif #get_layout.featured# eq 1>
        <cfinclude template="inc_featured_auc.cfm">
</cfif>



<cfif #get_layout.hotauctions# eq 1>
        <cfinclude template="inc_hot_auc.cfm">
</cfif>

	</td>
	<!---  end column 2 categories --->

	<!--- START COLUMN 3 --->
	<td width="256">
	
		<!--- statistic --->

<cfif #get_layout.login# eq 1>
		<cfinclude template="inc_login.cfm">
</cfif>
<cfif #get_layout.topseller# eq 1>
		<cfinclude template="inc_top_sellers.cfm">
</cfif>




		<!--- Promotion --->


<cfif #get_layout.promotion# eq 1>
		<cfinclude template="inc_promotion.cfm">
</cfif>
		
		<!--- welcome users --->
<cfif #get_layout.welcome# eq 1>
		<cfinclude template="inc_welcome.cfm">
		
		<!--- Links --->
		<cfinclude template="inc_links.cfm">

</cfif>
	</td>
	<!---  end column 3 categories --->
	</tr>
</table>
<!--- END Content Table consisting of 3 Columns --->

		</TD>
	</TR>
</TABLE>


</cfif>

<!--- end border table --->






<cfif #get_layout.template# eq 2>


<TABLE WIDTH="640" CELLSPACING="0" CELLPADDING="2" BORDER="0">
   <tr>
   	<td>
   
<!--- START Content Table consisting of 3 Columns --->
<TABLE border="0" align=left>
	<tr valign="top">
		
	<!--- START COLUMN 1 --->
	<td width="256">

	     <!--- What's new --->



<cfif #get_layout.news# eq 1>
		 <cfinclude template="inc_news1.cfm"><br>
		
</cfif>		
	<!--- Categories --->
		<cfinclude template="inc_categories1.cfm"><br>
<cfif #get_layout.statistic# eq 1>

		<cfinclude template="inc_statistic1.cfm"><br>
</cfif>

<cfif #get_layout.tellafriend# eq 1>
		<cfinclude template="inc_email1.cfm"><br>
</cfif>

	</td>
	<!---  end column 1 categories --->

	<!--- START COLUMN 2 --->
	<td width=100%>
		
		<!--- The studio graphic display --->

<cfif #get_layout.gallery# eq 1>

		<cfinclude template="inc_studio_graphic1.cfm">
<br>
</cfif>

		
		<!--- Featured Auctions --->

<cfif #get_layout.featured# eq 1>
        <cfinclude template="inc_featured_auc1.cfm">
<br>
</cfif>



<cfif #get_layout.hotauctions# eq 1>
        <cfinclude template="inc_hot_auc1.cfm">
<br>
</cfif>

	</td>
	<!---  end column 2 categories --->

	<!--- START COLUMN 3 --->
	<td width="256">
	
		<!--- statistic --->

<cfif #get_layout.login# eq 1>
		<cfinclude template="inc_login1.cfm">
<br>
</cfif>
<cfif #get_layout.topseller# eq 1>
		<cfinclude template="inc_top_sellers1.cfm">
<br>
</cfif>




		<!--- Promotion --->


<cfif #get_layout.promotion# eq 1>
		<cfinclude template="inc_promotion1.cfm">

<br>
</cfif>
		
		<!--- welcome users --->
<cfif #get_layout.welcome# eq 1>
		<cfinclude template="inc_welcome1.cfm">
<br>		
<!---		<!--- Links --->
		<cfinclude template="inc_links.cfm">

--->
</cfif>
	</td>
	<!---  end column 3 categories --->
	</tr>
</table>
<!--- END Content Table consisting of 3 Columns --->

		</TD>
	</TR>
</TABLE>


</cfif>




















<cfif #get_layout.template# eq 3>


<TABLE WIDTH="640" CELLSPACING="0" CELLPADDING="2" BORDER="0">
   <tr>
   	<td>
   
<!--- START Content Table consisting of 3 Columns --->
<TABLE border="0" align=left>
	<tr valign="top">
		
	<!--- START COLUMN 1 --->
	<td width="256">

	     <!--- What's new --->



<cfif #get_layout.news# eq 1>
		 <cfinclude template="inc_news2.cfm"><br>
		
</cfif>		
	<!--- Categories --->
		<cfinclude template="inc_categories2.cfm"><br>
<cfif #get_layout.statistic# eq 1>

		<cfinclude template="inc_statistic2.cfm"><br>
</cfif>

<cfif #get_layout.tellafriend# eq 1>
		<cfinclude template="inc_email2.cfm"><br>
</cfif>

	</td>
	<!---  end column 1 categories --->

	<!--- START COLUMN 2 --->
	<td width=100%>
		
		<!--- The studio graphic display --->

<cfif #get_layout.gallery# eq 1>

		<cfinclude template="inc_studio_graphic2.cfm">
<br>
</cfif>

		
		<!--- Featured Auctions --->

<cfif #get_layout.featured# eq 1>
        <cfinclude template="inc_featured_auc2.cfm">
<br>
</cfif>



<cfif #get_layout.hotauctions# eq 1>
        <cfinclude template="inc_hot_auc2.cfm">
<br>
</cfif>

	</td>
	<!---  end column 2 categories --->

	<!--- START COLUMN 3 --->
	<td width="256">
	
		<!--- statistic --->

<cfif #get_layout.login# eq 1>
		<cfinclude template="inc_login2.cfm">
<br>
</cfif>
<cfif #get_layout.topseller# eq 1>
		<cfinclude template="inc_top_sellers2.cfm">
<br>
</cfif>




		<!--- Promotion --->


<cfif #get_layout.promotion# eq 1>
		<cfinclude template="inc_promotion2.cfm">

<br>
</cfif>
		
		<!--- welcome users --->
<cfif #get_layout.welcome# eq 1>
		<cfinclude template="inc_welcome2.cfm">
<br>		
<!---		<!--- Links --->
		<cfinclude template="inc_links.cfm">

--->
</cfif>
	</td>
	<!---  end column 3 categories --->
	</tr>
</table>
<!--- END Content Table consisting of 3 Columns --->

		</TD>
	</TR>
</TABLE>


</cfif>



	<cfquery username="#db_username#" password="#db_password#" name="get_counter" datasource="#DATASOURCE#">
	select hit
from stats
		WHERE id=1
	</cfquery>


<cfparam name="cookie.site_counter" default="0">
<cfif ListContains(cookie.site_counter, cr_set) is "FALSE">
	<cfset hits = #IncrementValue(get_counter.hit)#>
	<cfquery username="#db_username#" password="#db_password#" name="get_hits" datasource="#DATASOURCE#">
		UPDATE stats
		SET hit = #hits#
		WHERE id=1
	</cfquery>
	<cfset item_cnt_list = listappend(cookie.site_counter, cr_set)>
	<cfcookie name="site_counter" value="#item_cnt_list#" expires="1">
<cfelse>
	<cfset hits = get_counter.hit>
</cfif>

<cfif #get_layout.hits# eq 1>
<cfoutput>


			<font color=green size=1>This page has been viewed</font> <font size="3" color="Red"><b>#hits#</b></font><font color=green size=1>&nbsp;times.</font></td>
</cfoutput>
</cfif>




<!--- Start footer in seperate table--->
<cfinclude template="inc_footer.cfm">
<!--- end footer --->
</body>
</html>

