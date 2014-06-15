<cfsilent>

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
  where news is not NULL
  order by date_posted DESC
</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="get_topsellers" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='top_seller'
</cfquery>
<cfset #top_seller# = #get_topsellers.pair#>

<cfquery username="#db_username#" password="#db_password#" name="get_sellers" datasource="#DATASOURCE#" maxrows=5>
  SELECT user_id, count(user_id) as counted from items
  where status = 1
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
<cfquery username="#db_username#" password="#db_password#" name="get_Featured" datasource="#DATASOURCE#" maxrows="#featitemspage#">
    SELECT itemnum, title, featured, bold_title, auction_mode
      FROM items
     WHERE featured = 1
       AND status = 1
       AND date_start < #TIMENOW#
       AND date_end > #TIMENOW#
     ORDER BY itemnum DESC
</cfquery>

<!--- get number of bids required for hot auction --->
<cfquery username="#db_username#" password="#db_password#" name="HotAuction" datasource="#DATASOURCE#">
    SELECT pair AS bids
      FROM defaults
     WHERE name = 'bids4hot'
</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="get_hotauctions" datasource="#DATASOURCE#" maxrows="#featitemspage#">
  SELECT B.itemnum, count(B.itemnum) as total_items from bids B, items I
  WHERE B.itemnum = I.itemnum
  AND I.status = 1
  GROUP BY B.itemnum HAVING count(B.itemnum) >= #hotauction.bids#
  ORDER BY count(B.itemnum) DESC
</cfquery>

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

<cfquery username="#db_username#" password="#db_password#" name="get_counter" datasource="#DATASOURCE#">
      select hit
      from stats
      WHERE id=1
</cfquery>
    
<cfquery username="#db_username#" password="#db_password#" name="get_ads" datasource="#DATASOURCE#">
	SELECT picture, webaddress
	FROM adv_info
	WHERE status = 1 AND paused = 0 AND date_end > #TIMENOW#
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


<!----------------------------- End all required queries --------------------------->
</cfsilent>

<cfoutput>
<html>
  <head>
    <title>Visual Auction</title>
    <meta name="keywords" content="#get_layout.keywords#">
    <meta name="description" content="#get_layout.descriptions#">
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylenew.css" type="text/css">
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
  <body>
  <center>
  <table border="0" align="center" cellpadding="0" cellspacing="0" width="#get_layout.page_width#">
  <tr>
  <td width="150" valign="top" style="background-image: url('/images/bg_side1.jpg'); background-repeat: yes;">
    <cfinclude template="includes/menu_bg1.cfm"> 
    <div style="border-right:1px; height:1400px; width:150px;">
       <table width="100%" cellspacing="0" cellpadding="5" border="0">
          <tr height=4><td></td></tr>
          <cfset ctr = 1>
          <cfloop query="get_ads">          
             <cfif #ctr# MOD 2>
                <tr><td align="left">
                    &nbsp;<a href="#webaddress#" target="_blank" title="#webaddress#"><img src="/advertise/images/#picture#" height=150 width=130 border=0></a>  
                </td></tr>
             </cfif>  
             <cfset ctr = ctr + 1>
          </cfloop>   
       </table>
    </div>   
  </td>
  <td width="700" align="left" valign="top">
     <cfinclude template="includes/menu_main.cfm"> 
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	    <tr>
	    <td>
		   <div class="site-text">
	  	       A WEBSITE DEDICATED TO BRINGING THE HORSE AUCTION TO A COMPUTER NEAR YOU. WE HAVE LIVE AUCTIONS GOING ON CONTINUOUSLY SO YOU CAN BID ON YOUR NEXT PERFORMANCE HORSE WITHOUT HAVING TO WAIT ON THE NEXT HORSE AUCTION TO COME AROUND.
       	   </div>
	    </td>
	    </tr>			
        <tr>
       	<td>
		   <table cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
		 	  <tr>
			  
				  <td width="20">&nbsp;</td>
				<cfquery username="#db_username#" password="#db_password#" name="getBanners" datasource="#DATASOURCE#">
						SELECT file_name
						FROM banners
						WHERE banner_enable = '1'
				</cfquery>
				<cfset pic_file = #getBanners.file_name#>
				<cfloop query="getBanners">
				  
				  <cfoutput>
 				  <td>#pic_file#</td>
			</cfoutput>
				  </cfloop>
				  <td width="20">&nbsp;</td>
			  </tr>
		   </table>
	    </td>
	    </tr>
	    <tr>
	    <td>
   	      <font size="3" color="orange"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NOTE: This Site is under-development. All images, photos, names and characters 
   	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;depicted in this site are for testing purposes only.</b></font>
	    </td>
	    </tr>			
	    <tr>
	    <td>   	   
		   <div class="body-text">
			  <table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="390" valign="top">
								<p class="p1">
									EQUIBIDZ FOUNDERS
								</p>
								<p class="p2">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nibh eros, sollicitudin quis tempus eu, dapibus vel 
									massa. Duis luctus mollis hendrerit. Nulla in dui non diam posuere fringilla in vel mauris. Cras a diam in nulla 
									consectetur iaculis. Fusce sit amet tellus nisl. Nullam laoreet lobortis aliquam. Ut est ligula, ultrices non vulputate 
									nec, tempus ut turpis. Donec id fringilla nisl. Nullam libero nisi, pellentesque vitae sodales mollis, fringilla vitae 
									justo. Nulla facilisi. Vestibulum in nisi ac libero sollicitudin consectetur nec nec odio. Aliquam erat volutpat.
									Maecenas luctus laoreet dignissim. Suspendisse pulvinar tellus id sapien euismod tincidunt.
								</p>
								<p class="p2">
									Phasellus gravida libero sed urna consequat porta. Maecenas vitae ante porta nunc dapibus sagittis. Vestibulum hendrerit 
									congue mauris, vel commodo orci rutrum at. Ut pulvinar condimentum lectus at molestie. Cras ante nulla, luctus sit amet 
									egestas vitae, pretium dictum ante. Curabitur euismod pulvinar purus, nec malesuada lorem pulvinar non. Cum sociis 
									natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam in odio justo. Quisque vulputate 
									volutpat magna, sit amet vehicula nunc tincidunt eget. Fusce sed vulputate erat. Aliquam sed iaculis felis. Nunc eu 
									rhoncus magna.
								</p>
							</td>
							<td width="10">&nbsp;</td>
							<td width="300" valign="top">
								<p class="p3">
									Quisque ut purus mi, et ultrices tellus. Pellentesque vitae vulputate quam. In viverra euismod quam, in tincidunt quam 
									accumsan volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In non massa 
									turpis. Aenean sodales vehicula gravida. Phasellus mollis tellus neque, ac tristique diam. Vestibulum pellentesque lorem 
									eu diam pharetra tempus. 
								</p>
								<p class="p3">
									Quisque ut purus mi, et ultrices tellus. Pellentesque vitae vulputate quam. In viverra euismod quam, in tincidunt quam 
									accumsan volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In non massa 
									turpis. Aenean sodales vehicula gravida. Phasellus mollis tellus neque, ac tristique diam. Vestibulum pellentesque lorem 
									eu diam pharetra tempus. 
								</p>
							</td>
						</tr>
			  </table>
		   </div>
		</td>
        </tr>
  	    <tr>
		  <td align="center">
            <cfinclude template="inc_footer.cfm">
		  </td>
	    </tr>
     </table>
  </td>
  <td width="150" valign="top" style="background-image: url('/images/bg_side2.jpg'); background-repeat: yes;">
  <cfinclude template="includes/menu_bg2.cfm"> 
  <div style="border-right:1px; height:1400px; width:150px;">
       <table width="100%" cellspacing="0" cellpadding="5" border="0">
          <tr height=4><td></td></tr>
          <cfset ctr = 1>
          <cfloop query="get_ads">          
             <cfif not #ctr# MOD 2>
                <tr><td align="right">
                    <a href="#webaddress#" target="_blank" title="#webaddress#"><img src="/advertise/images/#picture#" height=150 width=130 border=0></a>&nbsp;
                </td></tr>
             </cfif>  
             <cfset ctr = ctr + 1>
          </cfloop>   
       </table>
  </div>   
  </td>
  </tr>
  </table>
  
  </body>
  <!--- END Content Table consisting of 3 Columns --->
  <script language="javascript">
			function stoperror() {
				return true
			}
			window.onerror=stoperror();
  </script>    
</html>
</cfoutput>
