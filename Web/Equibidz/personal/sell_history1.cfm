 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 
<cfparam name="sortorder" default="title">
<cfparam name="sortorder1" default="title">
<cfparam name="sortorder2" default="title">
<cfparam name="sortorder3" default="title">
<cfparam name="sortorder4" default="title">



<cfquery username="#db_username#" password="#db_password#" name="click_status" datasource="#DATASOURCE#">
select * from status
</cfquery>

<cfif click_status.recordcount eq 0>
<cfparam name="clicklink" default="">
<cfparam name="clicklink1" default="">
<cfparam name="clicklink2" default=""> 
<cfparam name="clicklink3" default="">
<cfparam name="clicklink4" default="">
<cfparam name="clicklink5" default="">
<cfelse>
<cfparam name="clicklink" default="#click_status.default#">
<cfparam name="clicklink1" default="#click_status.default1#">
<cfparam name="clicklink2" default="#click_status.default2#"> 
<cfparam name="clicklink3" default="#click_status.default3#">
<cfparam name="clicklink4" default="#click_status.default4#">
<cfparam name="clicklink5" default="#click_status.default5#"> 
</cfif>


 
 <cfif auction_mode is 0> 
<html>
 <head>
  <title>Personal Page: View All</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 

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
    <tr><td><center><font size=2><cfinclude template="../includes/menu_bar.cfm"></font></center><br><br></td></tr>
    <tr><td><font size=4 color="000000"><b>View Your Selling History</b></font><font size=2> (Click on the plus <b>(+) sign</b> to view your selling history</font>) <br><br><b>Note:</b> After clicking on the <b>+ sign</b>, it could take several minutes depending on how many items you have listed.</td></tr>

	<tr><td>         <hr size=1 color=#heading_color# width=100%></td></tr>

	<!--- +++++++++++++++ I'm Selling ++++++++++++++++ --->
	
<cfif sortorder2 is "title">
  <cfset sortorder2 = "items.title ASC">
<cfelseif sortorder2 is "start_price">
  <cfset sortorder2 = "items.minimum_bid ASC">
<cfelseif sortorder2 is "current_price2">
  <cfset sortorder2 = "items.current_price2 asc">
<cfelseif sortorder2 IS "date_start">
  <cfset sortorder2 = "items.date_start DESC">
<cfelseif sortorder2 IS "totalbids2">
  <cfset sortorder2 = "items.totalbids2 asc">
<cfelseif sortorder2 IS "quantity">
  <cfset sortorder2 = "items.quantity DESC">
<cfelse>
  <cfset sortorder2 = "items.date_end DESC">
</cfif>

<cfset countgroup = Trim(get_PageGroup.itemsperpage)>

	<cfquery username="#db_username#" password="#db_password#" name="cnt_auctions4" datasource="#DATASOURCE#">
  SELECT items.*
    FROM items
   WHERE user_id = #session.user_id#
     AND date_end > #TIMENOW#
  order by #sortorder2#
 </cfquery>

<cfif cnt_auctions4.recordcount IS 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling((cnt_auctions4.recordcount) / countgroup)>
</cfif>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>

	<cfquery username="#db_username#" password="#db_password#" name="getselling_results" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
  SELECT items.*
    FROM items
   WHERE user_id = #session.user_id#
     AND date_end > #TIMENOW#
  order by #sortorder2#
 </cfquery>
	<tr><td><table border=1 cellspacing=2 cellpadding=0 width=100%>
	<tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=3><b>Items I'm Selling</b></font></td></tr>
	<tr><td align=right><a href="sell_history1.cfm?&clicklink3=close3"><img src="../images/min.gif" border=0></a> <a href="sell_history1.cfm?&clicklink3=open3"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink3 is "open3">  
	 <cfquery username="#db_username#" password="#db_password#" name="get_status3" datasource="#DATASOURCE#">
       update  status  set  clicklink3 = 1 , default3='open3'
     </cfquery>
	<!--- **************** --->
	<tr><td>
	<cfif #getselling_results.recordcount# GT 0>
         <b>You have posted a total of #cnt_auctions4.recordcount# Auction(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing5.cfm"
           featured_studio="#getselling_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getselling_results" startrow=#startrow#>
        
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
 <cfquery username="#db_username#" password="#db_password#" name="temp2" datasource="#DATASOURCE#">
   update items
   set totalbids2=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>      
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing5.cfm"
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
            totalbids="#Countbids.total#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
            featured_studio="#getselling_results.featured_studio#"
			quantity="#getselling_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing5.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif> 
	</td></tr> 
	<cfelseif clicklink3 is "close3"> 
    <cfset clicklink3 ="close3">
    <cfquery username="#db_username#" password="#db_password#" name="get_status4" datasource="#DATASOURCE#">
      update  status  set  clicklink3 = 0 ,default3='close3'
    </cfquery>
	</cfif>   

<br><cfif cnt_auctions4.recordcount IS not 0>
      <table border=1 cellspacing=0 cellpadding=0 noshade width=100%>
        <tr>
          <td>
           <!---  <center>
              <font size=2>
                Page: 
<cfmodule template="../functions/pagelinks.cfm"				  link="#VAROOT#/personal/sell_history1.cfm?clicklink3=open3"

thispage="#group#"
totalpages="#total_pages#"
                 >
              </font>
            </center> --->

</cfif>
      <br>
	
	<!--- ++++++++++++++ I've Sold ++++++++++++++ --->
<cfif sortorder3 is "title">
  <cfset sortorder3 = "items.title ASC">
<cfelseif sortorder3 is "start_price">
  <cfset sortorder3 = "items.minimum_bid ASC">
<cfelseif sortorder3 is "current_price3">
  <cfset sortorder3 = "items.current_price3 ASC">
<cfelseif sortorder3 IS "date_start">
  <cfset sortorder3 = "items.date_start DESC">
<cfelseif sortorder3 IS "totalbids3">
  <cfset sortorder3 = "items.totalbids3 asc">
<cfelseif sortorder3 IS "quantity">
  <cfset sortorder3 = "items.quantity DESC">
<cfelse>
  <cfset sortorder3 = "items.date_end DESC">
</cfif>


<cfset countgroup = Trim(get_PageGroup.itemsperpage)>



	<!--- Get all items they've sold --->
 <cfquery username="#db_username#" password="#db_password#" name="cnt_auctions" datasource="#DATASOURCE#" >
      SELECT i.itemnum, i.status, i.title, i.picture, i.sound, i.minimum_bid, i.maximum_bid, i.bold_title, i.featured_cat, i.featured_studio, i.banner, i.banner_line, i.date_start, i.date_end, i.auction_mode,i.quantity
    FROM items I, Bids b
   WHERE I.user_id = #session.user_id#
AND i.itemnum=b.itemnum
AND i.hide = 0
     AND (i.status = 0
          OR i.date_end < #TIMENOW#)
and B.winner=1
 order by i.title ASC
 </cfquery>
 


<cfif cnt_auctions.recordcount IS 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling((cnt_auctions.recordcount) / countgroup)>
</cfif>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>

 <cfquery username="#db_username#" password="#db_password#" name="getsold_results" datasource="#DATASOURCE#" maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#">
    SELECT i.itemnum, i.status, i.title, i.picture, i.sound, i.minimum_bid, i.maximum_bid, i.bold_title, i.featured_cat, i.featured_studio, i.banner, i.banner_line, i.date_start, i.date_end, i.auction_mode,i.quantity
    FROM items I, Bids b
   WHERE I.user_id = #session.user_id#
AND i.itemnum=b.itemnum
AND i.hide = 0
     AND (i.status = 0
          OR i.date_end < #TIMENOW#)
and B.winner=1
 order by i.title ASC
 </cfquery>


 
	<tr bgcolor="#heading_color#"><td align=center width=100%><font color="FFFFFF" size=3><b>Items I've Sold</b></font></td></tr>
	<tr><td align=right><a href="sell_history1.cfm?&clicklink4=close4"><img src="../images/min.gif" border=0></a> <a href="sell_history1.cfm?&clicklink4=open4"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink4 is "open4"> 
	 <cfquery username="#db_username#" password="#db_password#" name="get_status4" datasource="#DATASOURCE#">
       update  status  set  clicklink4 = 1 , default4='open4'
     </cfquery>

	<!--- **************** --->
	<tr><td>
	<cfif #getsold_results.recordcount# GT 0>
         <b>You have posted a total of #cnt_auctions.recordcount# Auction(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing6.cfm"
           featured_studio="#getsold_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getsold_results" startrow=#startrow#>
        
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
 <cfquery username="#db_username#" password="#db_password#" name="temp3" datasource="#DATASOURCE#">
   update items
   set totalbids3=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>   


  <cfquery name="getBidder" datasource="#DATASOURCE#">
    select  B.user_id,U.user_id,U.nickname,U.email
	from bids B,users U
	where B.bid =  <cfif #highestbid.recordcount# neq 0 and #highestbid.price#  neq ""  >#HighestBid.price#<cfelseif #lowestbid.recordcount# neq 0 and #lowestbid.price#  neq "">#lowestbid.price#</cfif>
	and   B.itemnum = #itemnum#
and b.user_id=u.user_id

</cfquery>

  
        
          <cfmodule template="../functions/prnt_listing6.cfm"
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
            featured_studio="#getsold_results.featured_studio#"
			quantity="#getsold_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#"
email="#getbidder.email#"
bidder="#getbidder.nickname#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing6.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif>     
	</td></tr>
	<cfelseif clicklink4 is "close4"> 
    <cfset clicklink4 ="close4">
    <cfquery username="#db_username#" password="#db_password#" name="get_status4" datasource="#DATASOURCE#">
      update  status  set  clicklink3 = 0 ,default4='close4'
    </cfquery>
	</cfif>


<br>
<cfif cnt_auctions.recordcount IS not 0>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- <center>
              <font size=2>
                Page: 
<cfmodule template="../functions/pagelinks.cfm"				  link="#VAROOT#/personal/sell_history1.cfm?clicklink4=open4"

thispage="#group#"
totalpages="#total_pages#"
                 >
              </font>
            </center> --->


</cfif>
	

	<!--- ************* --->
	</table>
	
	</td></tr>
	<tr><td>
	<!--- ******************************************************** --->
	
	 
 <cfquery username="#db_username#" password="#db_password#" name="getunsold_results" datasource="#DATASOURCE#">
  SELECT distinct i.itemnum, i.status, i.title, i.picture, i.sound, i.minimum_bid, i.maximum_bid, i.bold_title, i.featured_cat, i.featured_studio, i.banner, i.banner_line, i.date_start, i.date_end, i.auction_mode,i.quantity,i.totalbids5
    FROM items I, Bids b
   WHERE I.user_id = #session.user_id#
  and b.winner=0 

     AND i.hide = 0 

     and i.quantity > 0
 AND i.status=0
 AND i.hide = 0

<!---and i.totalbids5 = '' --->
 	      
   ORDER BY i.title ASC
 </cfquery>
 
 
	<table border=1 cellspacing=2 cellpadding=0 width=100%>
	<tr bgcolor="#heading_color#">
	<td align=center><font color="FFFFFF" size=3><b>Unsold Items</b></font></td>
	
	</tr>
	<tr><td align=right><a href="sell_history1.cfm?&clicklink5=close5"><img src="../images/min.gif" border=0></a> <a href="sell_history1.cfm?&clicklink5=open5"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink5 is "open5"> 
	 <cfquery username="#db_username#" password="#db_password#" name="get_status5" datasource="#DATASOURCE#">
       update  status  set  clicklink5 = 1 , default5='open5'
     </cfquery>
	 <!--- **************** --->
	<tr><td>
	<cfif #getunsold_results.recordcount# GT 0>
         <b>You have posted a total of #getunsold_results.recordcount# Auction(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing10.cfm"
           featured_studio="#getunsold_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getunsold_results" startrow=#startrow#>
        
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
   
  <!--- ************** --->

<cftry>
 <cfquery username="#db_username#" password="#db_password#" name="temp5" datasource="#DATASOURCE#">
   update items
   set totalbids5=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>   
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing10.cfm"
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
            featured_studio="#getunsold_results.featured_studio#"
			quantity="#getunsold_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing10.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif>     
	</td></tr>
	<cfelseif clicklink5 is "close5"> 
    <cfset clicklink5 ="close5">
    <cfquery username="#db_username#" password="#db_password#" name="get_status5" datasource="#DATASOURCE#">
      update  status  set  clicklink4 = 0 ,default5='close5'
    </cfquery>
	</cfif>
	</table>
	<!--- ******************************************************** --->
	</td></tr>
    <tr><td>
     <br><br>
     <center>

 <cfinclude template="nav.cfm">

     </center>
     <br>         <hr size=1 color=#heading_color# width=100%></td></tr>
    <tr><td><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td></tr>
   </table>
   </center>
  </cfoutput>
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

 

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 <cfinclude template="../includes/bodytag.html">

 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>
 
<!--- 
<cfparam name="sortorder" default="title">
<cfparam name="sortorder1" default="title">
<cfparam name="sortorder2" default="title">
<cfparam name="sortorder3" default="title">



<cfquery username="#db_username#" password="#db_password#" name="click_status" datasource="#DATASOURCE#">
select * from status
</cfquery>

<cfparam name="clicklink" default="#click_status.default#">
<cfparam name="clicklink1" default="#click_status.default1#">
<cfparam name="clicklink2" default="#click_status.default2#"> 
<cfparam name="clicklink3" default="#click_status.default3#">
<cfparam name="clicklink4" default="#click_status.default4#">
 --->

 
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
    <tr><td><font size=4 color="000000"><b>View Your Selling History</b></font></td></tr>

	<tr><td>         <hr size=1 color=#heading_color# width=100%></td></tr>
	
	<!--- +++++++++++++++ I'm Selling ++++++++++++++++ --->
	
<cfif sortorder2 is "title">
  <cfset sortorder2 = "items.title ASC">
<cfelseif sortorder2 is "start_price">
  <cfset sortorder2 = "items.minimum_bid ASC">
<cfelseif sortorder2 is "current_price2">
  <cfset sortorder2 = "items.current_price2 asc">
<cfelseif sortorder2 IS "date_start">
  <cfset sortorder2 = "items.date_start DESC">
<cfelseif sortorder2 IS "totalbids2">
  <cfset sortorder2 = "items.totalbids2 asc">
<cfelseif sortorder2 IS "quantity">
  <cfset sortorder2 = "items.quantity DESC">
<cfelse>
  <cfset sortorder2 = "items.date_end DESC">
</cfif>
	<cfquery username="#db_username#" password="#db_password#" name="getselling_results" datasource="#DATASOURCE#">
  SELECT items.*
    FROM items
   WHERE user_id = #session.user_id#
     AND date_end > #TIMENOW#
  order by #sortorder2#
 </cfquery>
	<tr><td><table border=1 cellspacing=2 cellpadding=0 width=640>
	<tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=5><b>Items I'm Selling</b></font></td></tr>
	<tr><td align=right><a href="sell_history1.cfm?&clicklink3=close3"><img src="../images/min.gif" border=0></a> <a href="sell_history1.cfm?&clicklink3=open3"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink3 is "open3">  
	 <cfquery username="#db_username#" password="#db_password#" name="get_status3" datasource="#DATASOURCE#">
       update  status  set  clicklink3 = 1 , default3='open3'
     </cfquery>
	<!--- **************** --->
	<tr><td>
	<cfif #getselling_results.recordcount# GT 0>
         <b>You have posted a total of #getselling_results.recordcount# Auction(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing5.cfm"
           featured_studio="#getselling_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getselling_results">
        
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
 <cfquery username="#db_username#" password="#db_password#" name="temp2" datasource="#DATASOURCE#">
   update items
   set totalbids2=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>      
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing5.cfm"
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
            totalbids="#Countbids.total#"
            hotbids="#HotAuction.bids#"
            TIMENOW="#TIMENOW#"
            listingnew="#ListingNew.days#"
            date_start="#date_start#"
            date_end="#date_end#"
            listingending="#HrsEnding.hours#"
            endingcolor="#HrsEndingColor.color#"
            VAROOT="#VAROOT#"
            featured_studio="#getselling_results.featured_studio#"
			quantity="#getselling_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing5.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif> 
	</td></tr> 
	<cfelseif clicklink3 is "close3"> 
    <cfset clicklink3 ="close3">
    <cfquery username="#db_username#" password="#db_password#" name="get_status4" datasource="#DATASOURCE#">
      update  status  set  clicklink3 = 0 ,default3='close3'
    </cfquery>
	</cfif>   
	
	<!--- ++++++++++++++ I've Sold ++++++++++++++ --->
<cfif sortorder3 is "title">
  <cfset sortorder3 = "items.title ASC">
<cfelseif sortorder3 is "start_price">
  <cfset sortorder3 = "items.minimum_bid ASC">
<cfelseif sortorder3 is "current_price3">
  <cfset sortorder3 = "items.current_price3 ASC">
<cfelseif sortorder3 IS "date_start">
  <cfset sortorder3 = "items.date_start DESC">
<cfelseif sortorder3 IS "totalbids3">
  <cfset sortorder3 = "items.totalbids3 asc">
<cfelseif sortorder3 IS "quantity">
  <cfset sortorder3 = "items.quantity DESC">
<cfelse>
  <cfset sortorder3 = "items.date_end DESC">
</cfif>
	<!--- Get all items they've sold --->
 <cfquery username="#db_username#" password="#db_password#" name="getsold_results" datasource="#DATASOURCE#">
  SELECT items.*
    FROM items
   WHERE user_id = #session.user_id#
     AND (status = 0
          OR date_end < #TIMENOW#)
	 AND hide = 0
   order by #sortorder3#
 </cfquery>
 
	<tr bgcolor="#heading_color#"><td align=center><font color="FFFFFF" size=5><b>Items I've Sold</b></font></td></tr>
	<tr><td align=right><a href="sell_history1.cfm?&clicklink4=close4"><img src="../images/min.gif" border=0></a> <a href="sell_history1.cfm?&clicklink4=open4"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink4 is "open4"> 
	 <cfquery username="#db_username#" password="#db_password#" name="get_status4" datasource="#DATASOURCE#">
       update  status  set  clicklink4 = 1 , default4='open4'
     </cfquery>

	<!--- **************** --->
	<tr><td>
	<cfif #getsold_results.recordcount# GT 0>
         <b>You have posted a total of #getsold_results.recordcount# Auction(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing6.cfm"
           featured_studio="#getsold_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getsold_results">
        
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
   
  <!--- ************** --->

<cftry>
 <cfquery username="#db_username#" password="#db_password#" name="temp3" datasource="#DATASOURCE#">
   update items
   set totalbids3=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>   
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing6.cfm"
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
            featured_studio="#getsold_results.featured_studio#"
			quantity="#getsold_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing6.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif>     
	</td></tr>
	<cfelseif clicklink4 is "close4"> 
    <cfset clicklink4 ="close4">
    <cfquery username="#db_username#" password="#db_password#" name="get_status4" datasource="#DATASOURCE#">
      update  status  set  clicklink3 = 0 ,default4='close4'
    </cfquery>
	</cfif>
	<!--- ************* --->
	</table></td></tr>
	
	
	
	<tr><td>
	<!--- ******************************************************** --->
	
	 
 <cfquery username="#db_username#" password="#db_password#" name="getunsold_results" datasource="#DATASOURCE#">
  SELECT distinct i.itemnum, i.status, i.title, i.picture, i.sound, i.minimum_bid, i.maximum_bid, i.bold_title, i.featured_cat, i.featured_studio, i.banner, i.banner_line, i.date_start, i.date_end, i.auction_mode,i.quantity,i.totalbids5
    FROM items I, Bids b
   WHERE I.user_id = #session.user_id#
<!---   and b.winner=0 
and b.buynow=0--->
     AND i.hide = 0 

     and i.quantity > 0
 AND (i.status=0
  ) 

and i.totalbids5 = '0'
 	      
   ORDER BY i.title ASC
 </cfquery>
 
 
	<table border=1 cellspacing=2 cellpadding=0 width=100%>
	<tr bgcolor="#heading_color#">
	<td align=center><font color="FFFFFF" size=3><b>Unsold Items</b></font></td>
	
	</tr>
	<tr><td align=right><a href="sell_history1.cfm?&clicklink5=close5"><img src="../images/min.gif" border=0></a> <a href="sell_history1.cfm?&clicklink5=open5"><img src="../images/max.gif" border=0></a></td></tr>
	 <cfif clicklink5 is "open5"> 
	 <cfquery username="#db_username#" password="#db_password#" name="get_status5" datasource="#DATASOURCE#">
       update  status  set  clicklink5 = 1 , default5='open5'
     </cfquery>
	 <!--- **************** --->
	<tr><td>
	<cfif #getunsold_results.recordcount# GT 0>
         <b>You have posted a total of #getunsold_results.recordcount# Auction(s) on our site:</b><br><br>

         <cfmodule template="../functions/prnt_listing10.cfm"
           featured_studio="#getunsold_results.featured_studio#"
           show_thumbs="#get_thumbsMode.show_thumbs#"
           part="HEADER"
           datasource="#DATASOURCE#">
           
         <cfset item_count = 0>
         <cfloop query="getunsold_results" startrow=#startrow#>
        
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
   
  <!--- ************** --->

<cftry>
 <cfquery username="#db_username#" password="#db_password#" name="temp5" datasource="#DATASOURCE#">
   update items
   set totalbids5=#countbids.total#
   WHERE itemnum = #itemnum#
    
 </cfquery>

<cfcatch></cfcatch>
</cftry>   
        
          <!--- output listing --->
          <cfmodule template="../functions/prnt_listing10.cfm"
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
            featured_studio="#getunsold_results.featured_studio#"
			quantity="#getunsold_results.quantity#"
     	    show_thumbs="#get_thumbsMode.show_thumbs#">
         </cfloop>  
         <cfmodule template="../functions/prnt_listing10.cfm" part="FOOTER">
         <br>
        <cfelse>
         <b>No items currently appear within this section.</b><br><br>
        </cfif>     
	</td></tr>
	<cfelseif clicklink5 is "close5"> 
    <cfset clicklink5 ="close5">
    <cfquery username="#db_username#" password="#db_password#" name="get_status5" datasource="#DATASOURCE#">
      update  status  set  clicklink4 = 0 ,default5='close5'
    </cfquery>
	</cfif>
	</table>
	<!--- ******************************************************** --->
	</td></tr>
	
    <tr><td>
     <br><br>
     <center>

 <cfinclude template="nav.cfm">

     </center>
     <br>         <hr size=1 color=#heading_color# width=100%></td></tr>
    <tr><td><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td></tr>
   </table>
   </center>
  </cfoutput>
 </body>
</html></cfif>














