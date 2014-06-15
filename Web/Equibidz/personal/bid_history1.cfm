 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 <cfif auction_mode is 0> 
<html>
 <head>
  <title>Personal Page: View All</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 <cfinclude template="../includes/bodytag.html">

 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_PageGroup" datasource="#DATASOURCE#">
    SELECT pair AS itemsperpage
      FROM defaults
     WHERE name = 'itemsperpage'
</cfquery>
<cfparam name="group" default="1">

<cfif int(group) lt 1>
	<cfset group = 1>
</cfif>

<!---
<cfparam name="sortorder" default="title">
<cfparam name="sortorder1" default="title">
<cfparam name="sortorder2" default="title">
<cfparam name="sortorder3" default="title">
<cfparam name="sortorder4" default="title">
--->

<cfparam name="sortorder" default="date_end">
<cfparam name="sortorder1" default="date_end">
<cfparam name="sortorder2" default="date_end">
<cfparam name="sortorder3" default="date_end">
<cfparam name="sortorder4" default="date_end">




<!--- <cfquery username="#db_username#" password="#db_password#" name="click_status" datasource="#DATASOURCE#">
select * from status
</cfquery> --->
<!--- <cfif click_status.recordcount eq 0> --->
<cfparam name="clicklink" default="">
<cfparam name="clicklink1" default="">
<cfparam name="clicklink2" default="">
<cfparam name="clicklink3" default="">
<cfparam name="clicklink4" default="">
<cfparam name="clicklink6" default="">
<!--- <cfelse>
<cfparam name="clicklink" default="#click_status.default#">
<cfparam name="clicklink1" default="#click_status.default1#">
<cfparam name="clicklink2" default="#click_status.default2#"> 
<cfparam name="clicklink3" default="#click_status.default3#">
<cfparam name="clicklink4" default="#click_status.default4#">
<cfparam name="clicklink6" default="#click_status.default6#">

</cfif> --->
 
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

 <cfoutput>

  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><center><font size=2><cfinclude template="../includes/menu_bar.cfm"></font></center><br><br></td></tr>
    <tr><td><font size=4 color="000000"><b>View Your Bidding History</b></font><font size=2> (Click on the plus <b>(+) sign</b>  to view your bidding history</font>) <br><br><b>Note:</b> After clicking on the <b>+ sign</b>, it could take several minutes depending on how many items you have listed.</td></tr>

	<tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
	
    <tr>
     <td>
        <table border=1 cellspacing=2 cellpadding=0 width=100%>
		<!--- +++++++++++++++++I've Bid++++++++++++++++ --->
		
		    <!--- define sort order --->
<cfif sortorder is "title">
  <cfset sortorder = "items.title ASC">
<cfelseif sortorder is "start_price">
  <cfset sortorder = "items.minimum_bid ASC">
<cfelseif sortorder is "current_price">
  <cfset sortorder = "items.current_price ASC">
<cfelseif sortorder IS "date_start">
  <cfset sortorder = "items.date_start DESC">
<cfelseif sortorder IS "totalbids">
  <cfset sortorder = "items.totalbids asc">
<cfelseif sortorder IS "quantity">
  <cfset sortorder = "items.quantity DESC">
<cfelse>
  <cfset sortorder = "items.date_end DESC">
</cfif>

	<cfquery username="#db_username#" password="#db_password#" name="cnt_auctions" datasource="#DATASOURCE#">
        SELECT DISTINCT items.itemnum, items.title, items.bold_title, items.picture, items.sound, items.banner, items.banner_line, items.minimum_bid, items.maximum_bid, items.date_start, items.date_end, items.studio, items.featured_studio, items.quantity
        FROM items, bids
        WHERE bids.user_id = #session.user_id#
        AND bids.itemnum = items.itemnum 
	    order by #sortorder#
        </cfquery>



<cfset countgroup = Trim(get_PageGroup.itemsperpage)>



<cfif cnt_auctions.recordcount IS 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling((cnt_auctions.recordcount) / countgroup)>
</cfif>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>




		<tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=3><b>Items I'm Bidding On</b></font></td></tr>
		<tr><td align=right><a href="bid_history1.cfm?&clicklink=close"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink=open"><img src="../images/max.gif" border=0></a></td></tr>
		<cfif clicklink is "open"> 
		<!---  <cfquery username="#db_username#" password="#db_password#" name="get_status" datasource="#DATASOURCE#">
           update  status  set  clicklink = 1 , default ='open'
         </cfquery> --->

		<tr><td>
		<cfquery username="#db_username#" password="#db_password#" name="getbid_results" datasource="#DATASOURCE#">
        SELECT DISTINCT items.itemnum, items.title, items.bold_title, items.picture, items.sound, items.banner, items.banner_line, items.minimum_bid, items.maximum_bid, items.date_start, items.date_end, items.studio, items.featured_studio, items.quantity
        FROM items, bids
        WHERE bids.user_id = #session.user_id#
        AND bids.itemnum = items.itemnum 
		and items.date_end > #TIMENOW#
	    	    order by date_end desc
        </cfquery>

        <cfif #getbid_results.recordcount# GT 0>
         <b>You have bid for a total of #getbid_results.recordcount# item(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing3.cfm"
   	       show_thumbs="#get_thumbsMode.show_thumbs#"
           featured_studio="#getbid_results.featured_studio#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getbid_results" startrow=#startrow#>
        
          <!--- increment item_count --->
          <cfset item_count = IncrementValue(item_count)>
        
          <!--- get bids --->
          <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
              SELECT COUNT(itemnum) AS total
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
		  <cfif CountBids.recordcount>
		  <cfset countbids_total=#countbids.total#>
		  <cfelse>
		   <cfset countbids_total=0>
		  </cfif>
        
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
		 





		  <cfset totalbids=#countbids_total#>
 <!---      
<cftry> 
 <cfquery username="#db_username#" password="#db_password#" name="temp" datasource="#DATASOURCE#">
   update items 
   set totalbids=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry> 
	--->	   
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing3.cfm"
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
         	totalbids="#totalbids#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
            featured_studio="#getbid_results.featured_studio#"
			quantity = "#getbid_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#"
>
         </cfloop>  
         <cfmodule template="../functions/prnt_listing3.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>Sorry, no item was found.</b><br><br>
        </cfif>
       
      </font>
	 </td></tr>
	 <cfelseif clicklink is "close"> 
     <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status1" datasource="#DATASOURCE#">
       update  status  set  clicklink = 0 , default ='close'
     </cfquery>
     <cfset clicklink="close"> --->
     </cfif> 
	

<cfif cnt_auctions.recordcount IS not  0>
<br>
      <table border=1 cellspacing=0 cellpadding=0 noshade width=100%>
        <tr>
          <td>
            <!--- <center>
              <font size=2>
                Page: 
<cfmodule template="../functions/pagelinks.cfm"				  link="#VAROOT#/personal/bid_history1.cfm?clicklink=open"

thispage="#group#"
totalpages="#total_pages#"
                 >
              </font>
            </center> --->


      <br>

</cfif>



	<!--- ++++++++++++I've Won+++++++++++++ --->
<cfif sortorder1 is "title">
  <cfset sortorder1 = "items.title ASC">
<cfelseif sortorder1 is "start_price">
  <cfset sortorder1 = "items.minimum_bid ASC">
<cfelseif sortorder1 is "current_price1">
  <cfset sortorder1 = "items.current_price1 ASC">
<cfelseif sortorder1 IS "date_start">
  <cfset sortorder1 = "items.date_start DESC">
<cfelseif sortorder1 IS "totalbids1">
  <cfset sortorder1 = "items.totalbids1 asc">
<cfelseif sortorder1 IS "quantity">
  <cfset sortorder1 = "items.quantity asc">
<cfelseif sortorder1 IS "seller">
  <cfset sortorder1 = "items.seller asc">
<cfelse>
  <cfset sortorder1 = "items.date_end DESC">
</cfif>
	





<cfset countgroup = Trim(get_PageGroup.itemsperpage)>



	 <tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=3><b>Items I've Won</b></font></td></tr>
	 <tr><td align=right><a href="bid_history1.cfm?&clicklink1=close1"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink1=open1"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink1 is "open1">  
	 <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status1" datasource="#DATASOURCE#">
       update  status  set  clicklink1 = 1 , default1='open1'
     </cfquery> --->
	  <!--- *************************** --->
	 

 <cfquery username="#db_username#" password="#db_password#" name="get_maxbid_item" datasource="#DATASOURCE#">
    SELECT DISTINCT bids.itemnum, items.itemnum, items.reserve_bid
      FROM bids, items
     WHERE bids.user_id = #session.user_id#
     AND bids.itemnum = items.itemnum
	 AND bids.winner = 1
<!---	 AND bids.buynow = 0 
	  order by #sortorder1# --->
 </cfquery>
 <cfif get_maxbid_item.recordcount gt 0>
 	<cfset maxbid_items = valuelist(get_maxbid_item.itemnum)>
 <cfelse>
 	<cfset maxbid_items = 0>
 </cfif>
 <!--- ************************ --->

 <cfif get_maxbid_item.recordcount gt 0>

    <tr>
	<td><table border=1 cellspacing=1 cellpadding=1 width=100%><tr>
      <td width=120 align=center valign=top><font size=2><!--- <a href="bid_history1.cfm?&sortorder1=title"> ---><b>Item</b><!--- </a> ---></font></td>
	  <td width=80 align=center valign=top><font size=2><!--- <a href="bid_history1.cfm?&sortorder1=date_end"> ---><b>End Date</b><!--- </a> ---></font></td>
      <td width=80 align=center valign=top><font size=2><!--- <a href="bid_history1.cfm?&sortorder1=current_price1"> ---><b>End Price</b><!--- </a> ---></font></td>
      <td width=80 align=center valign=top><font size=2><!--- <a href="bid_history1.cfm?&sortorder1=quantity"> ---><b>Qty</b><!--- </a> ---></font></td>
	  <td width=80 align=center valign=top><font size=2><!--- <a href="bid_history1.cfm?&sortorder1=seller"> ---><b>Seller</b><!--- </a> ---></font></td>
<!--- <td width=52 align=center valign=top><font size=2><a href="/feedback/leavefeedback.cfm"><b>Feed<br>back</b></a></font></td> --->
	 </tr></table></td>
    </tr>

</cfif>

	 <tr><td>
	

<!---

	 <cfquery username="#db_username#" password="#db_password#" name="cnt_auctions" datasource="#DATASOURCE#">
     SELECT items.itemnum, items.title, items.studio, items.featured_studio, bids.id, bids.bid, bids.time_placed, items.quantity, items.*
     FROM items, bids
     WHERE items.itemnum in ( SELECT DISTINCT bids.itemnum, items.itemnum
      FROM bids, items
     WHERE bids.user_id = #session.user_id#
     AND bids.itemnum = items.itemnum
	 AND bids.buynow = 0)
	 AND items.itemnum = bids.itemnum
	 AND bids.user_id = #session.user_id#
	 AND bids.bid = (select max(bid) from bids where itemnum in ( SELECT DISTINCT bids.itemnum, items.itemnum
      FROM bids, items
     WHERE bids.user_id = #session.user_id#
     AND bids.itemnum = items.itemnum
	 AND bids.buynow = 0) and buynow = 0)
 	 order by #sortorder1#
	</cfquery>
	



<cfif cnt_auctions.recordcount IS 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling((cnt_auctions.recordcount) / countgroup)>
</cfif>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>


--->		   
	 <cfloop index="i" list="#maxbid_items#">
	 <cfquery username="#db_username#" password="#db_password#" name="getwon_results" datasource="#DATASOURCE#" maxrows="20">
     SELECT items.itemnum, items.title, items.studio, items.featured_studio, bids.id, bids.bid, bids.time_placed, items.quantity, items.*
     FROM items, bids
     WHERE items.itemnum = #i#
	 AND items.itemnum = bids.itemnum
	 AND bids.user_id = #session.user_id#
	 AND bids.bid = (select max(bid) from bids where itemnum = #i# )

                    and date_end < #timenow#
 	 	    order by date_end desc
	</cfquery>
	<cfif #getwon_results.recordcount# GT 0>
       
         <cfmodule template="../functions/prnt_listing4.cfm"
   	       show_thumbs="#get_thumbsMode.show_thumbs#"
           featured_studio="#getwon_results.featured_studio#"
           part="HEADER"
           datasource="#DATASOURCE#"> 
	<cfset item_count = 0>
        <!--- <cfloop query="getwon_results" startrow=#startrow#>--->
         <cfloop query="getwon_results" >
         	
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
			   AND user_id = #session.user_id#	   
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>

 <cftry>
 <cfquery username="#db_username#" password="#db_password#" name="temp1" datasource="#DATASOURCE#">
   update items
   set totalbids1=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry> 
 
		   <!--- ************************ --->
		  <!--- output listing --->
          <cfmodule template="../functions/prnt_listing4.cfm"
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
            featured_studio="#getwon_results.featured_studio#"
			quantity = "#getwon_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
		  <!--- ************************ --->
		 
		  
		  <!--- <tr>
		  <td align="left"><a href="../listings/details/index.cfm?itemnum=#itemnum#">#title#</a>
				#numberformat(HighestBid.price, '999999999.99')#
				#dateformat(time_placed, 'mm/dd/yy')#
		  </td>
		  </tr> --->
		  
	 </cfloop>
	
	     <cfmodule template="../functions/prnt_listing4.cfm" part="FOOTER">
	   
         <br>
         <cfelse>
       <b>Sorry, no item was found.</b><br><br>  
        </cfif> 
		
	 </cfloop>
	
		</td></tr>
		<cfelseif clicklink1 is "close1"> 
        <!--- <cfset clicklink1 ="close1">
        <cfquery username="#db_username#" password="#db_password#" name="get_status2" datasource="#DATASOURCE#">
          update  status  set  clicklink1 = 0 ,default1='close1'
        </cfquery> --->

		</cfif> 

<!---
<cfif cnt_auctions.recordcount IS not 0>
<br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <center>
              <font size=2>
                Page: 
<cfmodule template="../functions/pagelinks.cfm"				  link="#VAROOT#/personal/bid_history1.cfm?clicklink1=open1"

thispage="#group#"
totalpages="#total_pages#"
                 >
              </font>
            </center>


      <br>

</cfif>

--->



		<!--- +++++++++++++++++I'm Watching++++++++++++++++ --->
<cfif sortorder4 is "title">
  <cfset sortorder4 = "items.title ASC">
<cfelseif sortorder4 is "start_price">
  <cfset sortorder4 = "items.minimum_bid ASC">
<cfelseif sortorder4 is "current_price4">
  <cfset sortorder4 = "items.current_price4 ASC">
<cfelseif sortorder3 IS "date_start">
  <cfset sortorder4 = "items.date_start DESC">
<cfelseif sortorder4 IS "totalbids4">
  <cfset sortorder4 = "items.totalbids4 asc">
<cfelseif sortorder4 IS "quantity">
  <cfset sortorder4 = "items.quantity DESC">
<cfelse>
  <cfset sortorder4 = "items.date_end DESC">
</cfif>
		<!--- Get watch list --->
		<!--- Check for self-submission --->
 <cfif #isDefined ("limit_results")# is 0>
  <cfset #limit_results# = "pending">
 </cfif>
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



<cfset countgroup = Trim(get_PageGroup.itemsperpage)>

 <cfquery username="#db_username#" password="#db_password#" name="cnt_auctions" datasource="#DATASOURCE#">
  SELECT *
    FROM items
   WHERE itemnum in(#watchlist#)
  <cfif #limit_results# is "sold">
     AND (status = 0
          OR date_end < #TIMENOW#)
   <cfelse> 
     AND date_end > #TIMENOW#
   </cfif>  
     <!--- sortby #sortorder4# --->  
 </cfquery>


<cfif cnt_auctions.recordcount IS 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling((cnt_auctions.recordcount) / countgroup)>
</cfif>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>





 <cfquery username="#db_username#" password="#db_password#" name="get_watchingresults" datasource="#datasource#" maxrows="20">
  SELECT *
    FROM items
   WHERE itemnum in(#watchlist#)
  <cfif #limit_results# is "sold">
     AND (status = 0
          OR date_end < #TIMENOW#)
   <cfelse> 
     AND date_end > #TIMENOW#
   </cfif>  
     <!--- sortby #sortorder4# --->  
 </cfquery>
	 <!--- *************************** --->
	 <tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=3><b>Items I'm Watching</b></font></td></tr>
	 <tr><td align=right><a href="bid_history1.cfm?&clicklink2=close2"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink2=open2"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink2 is "open2"> 
	 <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status2" datasource="#DATASOURCE#">
       update  status  set  clicklink2 = 1 , default2='open2'
     </cfquery> --->
	 <tr><td>
	 <cfif #get_watchingresults.recordcount# GT 0>
      <font size=3>
      
         <b>You have  a total of #get_watchingresults.recordcount# Auction(s) into your watch list:</b><br><br>

         <cfmodule template="../functions/prnt_listing7.cfm"
           featured_studio="#get_watchingresults.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="get_watchingresults" startrow=#startrow#>
        
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
     <cftry>
 <cfquery username="#db_username#" password="#db_password#" name="temp4" datasource="#DATASOURCE#">
   update items
   set totalbids4=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>      
          
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing7.cfm"
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
            featured_studio="#get_watchingresults.featured_studio#"
			quantity="#get_watchingresults.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing7.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif>     
	 
	 </td></tr>
	 
     <cfelseif clicklink2 is "close2"> 
     <!--- <cfset clicklink2 ="close2">
     <cfquery username="#db_username#" password="#db_password#" name="get_status3" datasource="#DATASOURCE#">
       update  status  set  clicklink2 = 0,default2='close2'
     </cfquery> --->
	 </cfif>



	</table> 
     </td>
    </tr>






	<tr><td><!--- <hr size=1 noshade> --->
<cfif cnt_auctions.recordcount IS not 0>
<br>
      <table border=1 cellspacing=0 cellpadding=0 noshade width=100%>
        <tr>
          <td>
            <!--- <center>
              <font size=2>
                Page: 
<cfmodule template="../functions/pagelinks.cfm"				  link="#VAROOT#/personal/bid_history1.cfm?clicklink2=open2"

thispage="#group#"
totalpages="#total_pages#"
                 >
              </font>
            </center> --->
</cfif>
</td></tr>
	
	<!--- ************************* Didn't win ****************************** --->
	<tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=3><b>Items I didn't Win</b></font></td></tr>
		<tr><td align=right><a href="bid_history1.cfm?&clicklink6=close6"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink6=open6"><img src="../images/max.gif" border=0></a></td></tr>
		<cfif clicklink6 is "open6"> 
		<!---  <cfquery username="#db_username#" password="#db_password#" name="get_status6" datasource="#DATASOURCE#">
           update  status  set  clicklink6 = 1 , default6 ='open6'
         </cfquery> --->

		<tr><td>
		<cfquery username="#db_username#" password="#db_password#" name="getdidnotwin_results" datasource="#DATASOURCE#">
        SELECT DISTINCT items.itemnum, items.title, items.bold_title, items.picture, items.sound, items.banner, items.banner_line, items.minimum_bid, items.maximum_bid, items.date_start, items.date_end, items.studio, items.featured_studio, items.quantity
        FROM items, bids
        WHERE bids.user_id = #session.user_id#
        AND bids.itemnum = items.itemnum 
		and bids.winner = 0
and date_end < #timenow#
	    order by date_end desc
        </cfquery>

        <cfif #getdidnotwin_results.recordcount# GT 0>
         <b>You have bid for a total of #getdidnotwin_results.recordcount# item(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing9.cfm"
   	       show_thumbs="#get_thumbsMode.show_thumbs#"
           featured_studio="#getdidnotwin_results.featured_studio#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getdidnotwin_results" startrow=#startrow#>
        
          <!--- increment item_count --->
          <cfset item_count = IncrementValue(item_count)>
        
          <!--- get bids --->
          <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
              SELECT COUNT(itemnum) AS total
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>

          <cfquery username="#db_username#" password="#db_password#" name="getseller" datasource="#DATASOURCE#">
              SELECT U.nickname,U.user_id,I.user_id from users U, items I
                
               WHERE I.itemnum = #itemnum#
and U.user_id=I.user_id

          </cfquery>

		  <cfif CountBids.recordcount>
		  <cfset countbids_total=#countbids.total#>
		  <cfelse>
		   <cfset countbids_total=0>
		  </cfif>
        
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
		 

 <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>

		  <cfset totalbids=#countbids_total#>
 <!---      
<cftry> 
 <cfquery username="#db_username#" password="#db_password#" name="temp" datasource="#DATASOURCE#">
   update items 
   set totalbids=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry> 
	--->	   
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing9.cfm"
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
         	totalbids="#totalbids#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
            featured_studio="#getdidnotwin_results.featured_studio#"
			quantity = "#getdidnotwin_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#"
seller="#getseller.nickname#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing9.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>Sorry, no item was found.</b><br><br>
        </cfif>
       
      </font>
	 </td></tr>
	 <cfelseif clicklink6 is "close6"> 
     <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status6" datasource="#DATASOURCE#">
       update  status  set  clicklink6 = 0 , default6 ='close6'
     </cfquery>
     <cfset clicklink6="close6"> --->
     </cfif> 
	 
	<!---  *************************************************************** --->


	<!--- ************* --->
	</table><tr><td>
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
<!--------------------------------------------------------------->
<cfelse>
<!-- Reverse Auction -->
<html>
 <head>
  <title>Personal Page: View All</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 <cfinclude template="../includes/bodytag.html">

 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>
 

<cfparam name="sortorder" default="title">
<cfparam name="sortorder1" default="title">
<cfparam name="sortorder2" default="title">
<cfparam name="sortorder3" default="title">


<!--- 
<cfquery username="#db_username#" password="#db_password#" name="click_status" datasource="#DATASOURCE#">
select * from status
</cfquery> 

<cfparam name="clicklink" default="#click_status.default#">
<cfparam name="clicklink1" default="#click_status.default1#">
<cfparam name="clicklink2" default="#click_status.default2#"> 
<cfparam name="clicklink3" default="#click_status.default3#">
<cfparam name="clicklink4" default="#click_status.default4#">

--->
<cfparam name="clicklink" default="">
<cfparam name="clicklink1" default="">
<cfparam name="clicklink2" default=""> 
<cfparam name="clicklink3" default="">
<cfparam name="clicklink4" default="">
 
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

 <cfoutput>

  <!--- The main table --->
  <center>
   <table border=0 cellspacing=0 cellpadding=2 width=640>
    <tr><td><center><IMG SRC="#VAROOT#/images/logohere.gif"> &nbsp; &nbsp; &nbsp; <font size=2><cfinclude template="../includes/menu_bar.cfm"></font></center><br><br></td></tr>
    <tr><td><font size=4 color="000000"><b>View Your Bidding History</b></font></td></tr>

	<tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
	
    <tr>
     <td>
        <table border=1 cellspacing=2 cellpadding=0 width=100%>
		<!--- +++++++++++++++++I've Bid++++++++++++++++ --->
		
		    <!--- define sort order --->
<cfif sortorder is "title">
  <cfset sortorder = "items.title ASC">
<cfelseif sortorder is "start_price">
  <cfset sortorder = "items.minimum_bid ASC">
<cfelseif sortorder is "current_price">
  <cfset sortorder = "items.current_price ASC">
<cfelseif sortorder IS "date_start">
  <cfset sortorder = "items.date_start DESC">
<cfelseif sortorder IS "totalbids">
  <cfset sortorder = "items.totalbids asc">
<cfelseif sortorder IS "quantity">
  <cfset sortorder = "items.quantity DESC">
<cfelse>
  <cfset sortorder = "items.date_end DESC">
</cfif>
		<tr bgcolor="008000"><td align=center><font color="FFFFFF" size=5><b>Items I've Bid On</b></font></td></tr>
		<tr><td align=right><a href="bid_history1.cfm?&clicklink=close"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink=open"><img src="../images/max.gif" border=0></a></td></tr>
		<cfif clicklink is "open"> 
		 <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status" datasource="#DATASOURCE#">
           update  status  set  clicklink = 1 , default ='open'
         </cfquery> --->
		<tr><td>
		<cfquery username="#db_username#" password="#db_password#" name="getbid_results" datasource="#DATASOURCE#">
        SELECT DISTINCT items.itemnum, items.title, items.bold_title, items.picture, items.sound, items.banner, items.banner_line, items.minimum_bid, items.maximum_bid, items.date_start, items.date_end, items.studio, items.featured_studio, items.quantity, items.*
        FROM items, bids
        WHERE bids.user_id = #session.user_id#
        AND bids.itemnum = items.itemnum 
	    order by #sortorder#
        </cfquery>

        <cfif #getbid_results.recordcount# GT 0>
         <b>You have bid for a total of #getbid_results.recordcount# item(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing3.cfm"
   	       show_thumbs="#get_thumbsMode.show_thumbs#"
           featured_studio="#getbid_results.featured_studio#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getbid_results">
        
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
			   AND user_id = #session.user_id#
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
      
<cftry> 
 <cfquery username="#db_username#" password="#db_password#" name="temp" datasource="#DATASOURCE#">
   update items
   set totalbids=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry> 
		   
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing3.cfm"
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
         	totalbids="#totalbids#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
            featured_studio="#getbid_results.featured_studio#"
			quantity = "#getbid_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing3.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>Sorry, no item was found.</b><br><br>
        </cfif>
       
      </font>
	 </td></tr>
	 <cfelseif clicklink is "close"> 
    <!---  <cfquery username="#db_username#" password="#db_password#" name="get_status1" datasource="#DATASOURCE#">
       update  status  set  clicklink = 0 , default ='close'
     </cfquery>
     <cfset clicklink="close"> --->
     </cfif> 
	
	<!--- ++++++++++++I've Won+++++++++++++ --->
<cfif sortorder1 is "title">
  <cfset sortorder1 = "items.title ASC">
<cfelseif sortorder1 is "start_price">
  <cfset sortorder1 = "items.minimum_bid ASC">
<cfelseif sortorder1 is "current_price1">
  <cfset sortorder1 = "items.current_price1 ASC">
<cfelseif sortorder1 IS "date_start">
  <cfset sortorder1 = "items.date_start DESC">
<cfelseif sortorder1 IS "totalbids1">
  <cfset sortorder1 = "items.totalbids1 asc">
<cfelseif sortorder1 IS "quantity">
  <cfset sortorder1 = "items.quantity asc">
<cfelseif sortorder1 IS "seller">
  <cfset sortorder1 = "items.seller asc">
<cfelse>
  <cfset sortorder1 = "items.date_end DESC">
</cfif>
	
	 <tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=5><b>Items I've Won</b></font></td></tr>
	 <tr><td align=right><a href="bid_history1.cfm?&clicklink1=close1"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink1=open1"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink1 is "open1">  
	 <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status1" datasource="#DATASOURCE#">
       update  status  set  clicklink1 = 1 , default1='open1'
     </cfquery> --->
	  <!--- *************************** --->
	 
    <tr>
	<td><table border=1 cellspacing=1 cellpadding=1 width=100%><tr>
      <td width=120 align=center valign=top><font size=2><a href="bid_history1.cfm?&sortorder1=title"><b>Item</b></a></font></td>
	  <td width=80 align=center valign=top><font size=2><a href="bid_history1.cfm?&sortorder1=date_end"><b>End Date</b></a></font></td>
      <td width=80 align=center valign=top><font size=2><a href="bid_history1.cfm?&sortorder1=current_price1"><b>End Price</b></a></font></td>
      <td width=80 align=center valign=top><font size=2><a href="bid_history1.cfm?&sortorder1=quantity"><b>Qty</b></a></font></td>
	  <td width=80 align=center valign=top><font size=2><a href="bid_history1.cfm?&sortorder1=seller"><b>Seller</b></a></font></td>
	 </tr></table></td>
    </tr>

	 <tr><td>
	 <!--- ************************ --->
 <cfquery username="#db_username#" password="#db_password#" name="get_maxbid_item" datasource="#DATASOURCE#">
    SELECT DISTINCT bids.itemnum, items.itemnum
      FROM bids, items
     WHERE bids.user_id = #session.user_id#
     AND bids.itemnum = items.itemnum
	 AND bids.buynow = 0
	 order by #sortorder1#
 </cfquery>
 <cfif get_maxbid_item.recordcount gt 0>
 	<cfset maxbid_items = valuelist(get_maxbid_item.itemnum)>
 <cfelse>
 	<cfset maxbid_items = 0>
 </cfif>
 <!--- ************************ --->
		   
	 <cfloop index="i" list="#maxbid_items#">
	 <cfquery username="#db_username#" password="#db_password#" name="getwon_results" datasource="#DATASOURCE#">
     SELECT items.itemnum, items.title, items.studio, items.featured_studio, bids.id, bids.bid, bids.time_placed, items.quantity, items.*
     FROM items, bids
     WHERE items.itemnum = #i#
	 AND items.itemnum = bids.itemnum
	 AND bids.user_id = #session.user_id#
	 AND bids.bid = (select max(bid) from bids where itemnum = #i# and buynow = 0)
 	 order by #sortorder1#
	</cfquery>
	<cfif #getwon_results.recordcount# GT 0>
       
         <cfmodule template="../functions/prnt_listing4.cfm"
   	       show_thumbs="#get_thumbsMode.show_thumbs#"
           featured_studio="#getwon_results.featured_studio#"
           part="HEADER"
           datasource="#DATASOURCE#"> 
	<cfset item_count = 0>
         <cfloop query="getwon_results">
         	
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
			   AND user_id = #session.user_id#	   
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>

 <cftry>
 <cfquery username="#db_username#" password="#db_password#" name="temp1" datasource="#DATASOURCE#">
   update items
   set totalbids1=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry> 
 
		   <!--- ************************ --->
		  <!--- output listing --->
          <cfmodule template="../functions/prnt_listing4.cfm"
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
            featured_studio="#getwon_results.featured_studio#"
			quantity = "#getwon_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
		  <!--- ************************ --->
		 
		  
		  <!--- <tr>
		  <td align="left"><a href="../listings/details/index.cfm?itemnum=#itemnum#">#title#</a>
				#numberformat(HighestBid.price, '999999999.99')#
				#dateformat(time_placed, 'mm/dd/yy')#
		  </td>
		  </tr> --->
		  
	 </cfloop>
	
	     <cfmodule template="../functions/prnt_listing4.cfm" part="FOOTER">
	   
         <br>
        <!--- <cfelse>
         <b>Sorry, no item was found.</b><br><br> ---> 
        </cfif> 
		
	 </cfloop>

	
		</td></tr>
		<cfelseif clicklink1 is "close1"> 
       <!---  <cfset clicklink1 ="close1">
        <cfquery username="#db_username#" password="#db_password#" name="get_status2" datasource="#DATASOURCE#">
          update  status  set  clicklink1 = 0 ,default1='close1'
        </cfquery> --->

		</cfif> 
	 <!--- *************************** --->
	 <tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=5><b>Items I'm Watching</b></font></td></tr>
	 <tr><td align=right><a href="bid_history1.cfm?&clicklink2=close2"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink2=open2"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink2 is "open2"> 
	<!---  <cfquery username="#db_username#" password="#db_password#" name="get_status2" datasource="#DATASOURCE#">
       update  status  set  clicklink2 = 1 , default2='open2'
     </cfquery> --->
     <cfelseif clicklink2 is "close2"> 
     <!--- <cfset clicklink2 ="close2">
     <cfquery username="#db_username#" password="#db_password#" name="get_status3" datasource="#DATASOURCE#">
       update  status  set  clicklink2 = 0,default2='close2'
     </cfquery> --->
	 </cfif>
	</table> 
     </td>
    </tr>
	<tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
	<!--- +++++++++++++++ I'm Selling ++++++++++++++++ --->
	
	
	<!--- ************************* Didn't wind ****************************** --->
	<tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=3><b>Items I didn't Win</b></font></td></tr>
		<tr><td align=right><a href="bid_history1.cfm?&clicklink6=close6"><img src="../images/min.gif" border=0></a> <a href="bid_history1.cfm?&clicklink6=open6"><img src="../images/max.gif" border=0></a></td></tr>
		<cfif clicklink6 is "open6"> 
		<!---  <cfquery username="#db_username#" password="#db_password#" name="get_status6" datasource="#DATASOURCE#">
           update  status  set  clicklink6 = 1 , default6 ='open6'
         </cfquery> --->

		<tr><td>
		<cfquery username="#db_username#" password="#db_password#" name="getdidnotwin_results" datasource="#DATASOURCE#">
        SELECT DISTINCT items.itemnum, items.title, items.bold_title, items.picture, items.sound, items.banner, items.banner_line, items.minimum_bid, items.maximum_bid, items.date_start, items.date_end, items.studio, items.featured_studio, items.quantity
        FROM items, bids
        WHERE bids.user_id = #session.user_id#
        AND bids.itemnum = items.itemnum 
		and bids.winner = 0
	    order by #sortorder#
        </cfquery>

        <cfif #getdidnotwin_results.recordcount# GT 0>
         <b>You have bid for a total of #getdidnotwin_results.recordcount# item(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing9.cfm"
   	       show_thumbs="#get_thumbsMode.show_thumbs#"
           featured_studio="#getdidnotwin_results.featured_studio#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getdidnotwin_results" startrow=#startrow#>
        
          <!--- increment item_count --->
          <cfset item_count = IncrementValue(item_count)>
        
          <!--- get bids --->
          <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
              SELECT COUNT(itemnum) AS total
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
		  <cfif CountBids.recordcount>
		  <cfset countbids_total=#countbids.total#>
		  <cfelse>
		   <cfset countbids_total=0>
		  </cfif>
        
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND user_id = #session.user_id#
          </cfquery>
		 
		  <cfset totalbids=#countbids_total#>
 <!---      
<cftry> 
 <cfquery username="#db_username#" password="#db_password#" name="temp" datasource="#DATASOURCE#">
   update items 
   set totalbids=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry> 
	--->	  
	 
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing9.cfm"
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
         	totalbids="#totalbids#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
            featured_studio="#getdidnotwin_results.featured_studio#"
			quantity = "#getdidnotwin_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing9.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>Sorry, no item was found.</b><br><br>
        </cfif>
       
      </font>
	 </td></tr>
	 <cfelseif clicklink6 is "close6"> 
     <!--- <cfquery username="#db_username#" password="#db_password#" name="get_status6" datasource="#DATASOURCE#">
       update  status  set  clicklink6 = 0 , default6 ='close6'
     </cfquery>
     <cfset clicklink6="close6"> --->
     </cfif> 
	 
	<!---  *************************************************************** --->
	
	
    <tr><td>
     <br><br>
     <center>

 <cfinclude template="nav.cfm">

     </center>
     <br><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr><td><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td></tr>
   </table>
   </center>
  </cfoutput>
 </body>
</html></cfif>














