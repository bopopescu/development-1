<cfsetting enablecfoutputonly="yes">

<!--- define cache control page --->
<cfset current_page = "indexhome">
<cfinclude template = "./includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="./includes/session_include.cfm">

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
    WHERE name='limitcat_frpage'
</cfquery>
<cfset #limitcat_frpage# = #get_limitcat_frontpage.pair#>
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
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#" maxrows="#limitcat_frpage#">
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
  <!--- <cfloop query="LoginCategories">
       AND category1 <> #LoginCategories.category#
       AND category2 <> #LoginCategories.category#
  </cfloop> --->
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
<!--- Access query
    SELECT count(B.id) as total_items, I.itemnum, I.bold_title, I.title
      FROM items I, bids B

	  WHERE I.itemnum = B.itemnum

	  AND I.status = 1



   GROUP BY I.itemnum, I.title, I.bold_title

HAVING  (((count(b.id))) > #hotauction.bids#)


--->
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



<cfinclude template="./includes/menu_bar1.cfm">



<CFQUERY NAME="GetRandProd1" datasource="#datasource#"  >
SELECT *
FROM games
WHERE game_active=1


order by newid()
</CFQUERY>
<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="500" align="center" height="25" background="">
<tr>
	<td>
<table border="0" cellpadding="0" cellspacing="0" background="" bgcolor="FFFFFF">
<tr>
	<td><img src="images/e04.gif" width="21" height="21" alt="" border="0" align="left"></td>
	<td><p class="bar01" style="color: 3466DE; font-size: 18px;">Games&nbsp;</p></td>
</tr>
</table>
	</td>
</tr>
</table>

<!--- start 
<table border="0" cellpadding="2" cellspacing="0" align="center" width=500>
                  <cfset counter=1>
<tr valign="top">

<!--- start here --->

<cfif #getrandprod1.recordcount#>

<cfloop query ="getrandprod1">

	<td <cfif #getrandprod1.recordcount# eq 1>align=center</cfif>>
<!-- left -->
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><img src="images/t_11.gif" width="10" height="9" alt="" border="0"></td>
	<td background="images/t_13.gif"><img src="images/t_12.gif" width="6" height="9" alt="" border="0"></td>
	<td background="images/t_13.gif" align="right"><img src="images/t_14.gif" width="6" height="9" alt="" border="0"></td>
	<td><img src="images/t_15.gif" width="10" height="9" alt="" border="0"></td>
</tr>
<tr valign="top">
	<td background="images/t_fon_left.gif"><img src="images/t_21.gif" width="10" height="6" alt="" border="0"></td>
	<td rowspan="2" colspan="2">
<!-- in -->



<table border="0" cellpadding="0" cellspacing="0" width="160">
<tr>
	<td>



<a href="#varoot#/listings/details/game_detail.cfm?game_id=#game_id#<cfif isdefined("mode") and mode>mode=1</cfif>">
     
<cfif #trim(thumb)# is not "">
<img src="thumbs/#thumb#" alt="" width="58" height="54" border="0">
<cfelse>
<img src="images/default.gif" alt="" width="58" height="54" border="0">
</cfif>
</a></td>
	<td>
<p style="color: 1F86DE; font-size: 15px; padding-bottom: 0px;"><b>#left(trim(game_title),5)#...</b></p>
<p>#left(trim(game_description),6)#...</p>
<p style="color: DA0008; font-size: 12px; padding-bottom: 5px;"><b>#hit# plays</b></p>
	</td>
</tr>
</table>
<!-- /in -->
	</td>
	<td background="images/t_fon_right.gif"><img src="images/t_23.gif" width="10" height="6" alt="" border="0"></td>
</tr>
<tr valign="bottom">
	<td background="images/t_fon_left.gif"><img src="images/t_31.gif" width="10" height="7" alt="" border="0"></td>
	<td background="images/t_fon_right.gif"><img src="images/t_33.gif" width="10" height="7" alt="" border="0"></td>
</tr>
<tr>
	<td><img src="images/t_41.gif" width="10" height="10" alt="" border="0"></td>
	<td background="images/t_fon_bot.gif"><img src="images/t_42.gif" width="6" height="10" alt="" border="0"></td>
	<td background="images/t_fon_bot.gif" align="right"><img src="images/t_44.gif" width="6" height="10" alt="" border="0"></td>
	<td ><img src="images/t_45.gif" width="10" height="10" alt="" border="0"></td>
</tr>
</table>
<!-- /left -->
	</td>


</cfloop>


<cfelse>
<td>&nbsp;No featured products available</td>
</cfif>
<!--- end 1 --->


</tr>
</table>

end --->
</cfoutput>
<!---
<table cellpadding=0 cellspacing=0  border=1 valign="top" width="100%" bordercolor=<cfoutput>#heading_color#</cfoutput>>
--->
<table border="0" cellpadding="3" cellspacing="0" align="center">

<tr><td>

            <!--- output featured auctions --->
           <!---  <cfsetting enablecfoutputonly="No"> --->
              <cfif getrandprod1.RecordCount IS 0>
                <cfoutput>
                  <br>
                  <br>
                  <center>
                    <font size=2>Sorry, no featured auctions at this time.</font>
                  </center>
                </cfoutput>
              <cfelse>
                <cfif #get_thumbsMode.show_thumbs# IS 1>
                  <cfoutput>
			<!--- Featured Auctions Table --->
			<table border=0 cellspacing=0 cellpadding=5 noshade width="100%"></cfoutput>
                  <cfset counter=1>
                  <cfoutput><tr>
                  <cfloop query="getrandprod1">

                    <td valign="bottom" <cfif featcolspage gt 1>align=center</cfif>>
                    

                    <cfset thePath = #GetDirectoryFromPath(GetTemplatePath())#&"Thumbs\">





		<cfif 3 gt 1>
		<table><tr><td align=center ><table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><img src="images/t_11.gif" width="10" height="9" alt="" border="0"></td>
	<td background="images/t_13.gif"><img src="images/t_12.gif" width="6" height="9" alt="" border="0"></td>
	<td background="images/t_13.gif" align="right"><img src="images/t_14.gif" width="6" height="9" alt="" border="0"></td>
	<td><img src="images/t_15.gif" width="10" height="9" alt="" border="0"></td>
</tr>
<tr valign="top">
	<td background="images/t_fon_left.gif"><img src="images/t_21.gif" width="10" height="6" alt="" border="0"></td>
	<td rowspan="2" colspan="2">
<!-- in -->



<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
<a href="#varoot#/listings/details/game_detail.cfm?game_id=#game_id#<cfif isdefined("demo") and demo>&demo=1</cfif>">
   
<cfif #trim(thumb)# is not "">
<img src="thumbs/#thumb#" alt="" width="58" height="54" border="0">
<cfelse>
<img src="images/default.gif" alt="" width="58" height="54" border="0">
</cfif>
</a></td>
<td>
<p style="color: 1F86DE; font-size: 12px; padding-bottom: 0px;"><b><a href="#varoot#/listings/details/game_detail.cfm?game_id=#game_id#<cfif isdefined("demo") and demo>&demo=1</cfif>">#left(trim(game_title),5)#...</a></b></p>
<p>#left(trim(game_description),6)#...</p>
<p style="color: DA0008; font-size: 8px; padding-bottom: 5px;"><b>#hit# plays</b></p>
	</td>
</tr>
</table>
<!-- /in -->
	</td>
	<td background="images/t_fon_right.gif"><img src="images/t_23.gif" width="10" height="6" alt="" border="0"></td>
</tr>
<tr valign="bottom">
	<td background="images/t_fon_left.gif"><img src="images/t_31.gif" width="10" height="7" alt="" border="0"></td>
	<td background="images/t_fon_right.gif"><img src="images/t_33.gif" width="10" height="7" alt="" border="0"></td>
</tr>
<tr>
	<td><img src="images/t_41.gif" width="10" height="10" alt="" border="0"></td>
	<td background="images/t_fon_bot.gif"><img src="images/t_42.gif" width="6" height="10" alt="" border="0"></td>
	<td background="images/t_fon_bot.gif" align="right"><img src="images/t_44.gif" width="6" height="10" alt="" border="0"></td>
	<td ><img src="images/t_45.gif" width="10" height="10" alt="" border="0"></td>
</tr>
</table>
<!-- /left -->


</td></tr></table>
		
 </cfif>


<!---
                      <a href="#VAROOT#/listings/details/index.cfm?game_id=#game_id#">
#Trim(game_title)#</a>---></font>


                    <cfif counter eq featcolspage>
                      <cfset counter=1>
                      </td></tr>
					  <tr>
                    <cfelse>
					  <td>
                      <cfset counter=counter+1>
                      </td>
                    </cfif>
                  </cfloop>
				  </tr>
				  	<!---<cfif featcolspage gt 1><cfset featcolspan = featcolspage * 2></cfif>
                    <tr><td <cfif featcolspage gt 1>colspan="#featcolspan#"</cfif>>&nbsp;<a href="#VAROOT#/listings/featured/index.cfm"><font size=1><b>View All Featured Auctions</b></font></a></td></tr>--->
                    </table>
                  </cfoutput>
                <cfelse>
                          </cfif>
              </cfif>
			  
			 
</td></tr></table>





<!--- Start footer in seperate table--->
<cfinclude template="./includes/copyrights2.cfm">
<!--- end footer --->
</body>
</html>

