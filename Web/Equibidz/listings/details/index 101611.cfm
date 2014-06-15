<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">



<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif isDefined("from_list")>
    <cfset from_list = #from_list#>
<cfelse>
    <cfset from_list = 0>
</cfif>
<cfif #trim(submit)# is "Go Back">
    <cfif #from_list# EQ 0>
       <cfif #curr_lvl# EQ 0>
          <cfset curr_cat = "S">
       </cfif>
       <cflocation url="#VAROOT#/listings/index.cfm?curr_cat=#curr_cat#&curr_lvl=#curr_lvl#">
    <cfelseif  #from_list# EQ 1>
       <cflocation url="#VAROOT#/search/index.cfm?curr_cat=#curr_cat#&curr_lvl=#curr_lvl#">
    <cfelse>
       <cflocation url="#VAROOT#/personal/my_auctions.cfm?my_No=#from_list#">
    </cfif> 
</cfif>

<CFSET BROWSER = CGI.HTTP_USER_AGENT>
<cfset MSexplorer = find("MSIE",browser)>

<cfparam name="itemnum" default="0">
<cfif isnumeric(itemnum) eq false>
	<cfset itemnum = 0>
</cfif>
<!--- define userNickname if Session available --->
<cftry>
    <cfif IsDefined("Session.nickname")>
      <cfset userNickname = Session.nickname>
    <cfelse>
      <cfset userNickname = "">
    </cfif>
    
    <cfcatch>
      <cfset userNickname = "">
    </cfcatch>
</cftry>

<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="get_Item" datasource="#DATASOURCE#">
    SELECT *, (SELECT nickname FROM users WHERE items.user_id = users.user_id) AS nickname,
  		      (SELECT phone1 FROM users WHERE items.user_id = users.user_id) AS user_phone,
  		      (SELECT address1 FROM users WHERE items.user_id = users.user_id) AS user_addr,
  		      (SELECT city FROM users WHERE items.user_id = users.user_id) AS user_city,
  		      (SELECT state FROM users WHERE items.user_id = users.user_id) AS user_state,
   		      (SELECT country FROM users WHERE items.user_id = users.user_id) AS user_country
      FROM items
     WHERE itemnum = #itemnum#
  </cfquery>
  <!--- define found/not found --->
  <cfset isvalid = IIf(get_ItemInfo.RecordCount, DE("TRUE"), DE("FALSE"))>
  
  <cfcatch>
    <cfset isvalid = "FALSE">
  </cfcatch> 
</cftry>

<cftry>
  	<!--- get number of buynow --->
    <cfquery username="#db_username#" password="#db_password#" name="get_buynow_cnt" datasource="#DATASOURCE#">
        SELECT COUNT(buynow) AS buynow_cnt
          FROM bids
         WHERE itemnum = #get_ItemInfo.itemnum#
		 AND buynow = 1
    </cfquery>

  <cfquery username="#db_username#" password="#db_password#" name="bid_find" datasource="#DATASOURCE#">
        SELECT max(bid) as total
          FROM proxy_bids
         WHERE itemnum = #get_ItemInfo.itemnum#
		 
    </cfquery>

    <!--- get current bid, number of bids, define reserve met --->
    <cfquery username="#db_username#" password="#db_password#" name="get_HighBid" datasource="#DATASOURCE#">
        SELECT MAX(bid) AS highest, COUNT(bid) AS bidcount
          FROM bids
         WHERE itemnum = #get_ItemInfo.itemnum#
		 AND buynow = 0
    </cfquery>
    
    <cfset bid_currently = IIf(get_HighBid.bidcount, "get_HighBid.highest", "get_ItemInfo.minimum_bid")>
    <cfset bid_count = get_HighBid.bidcount>
    
    <cfif get_ItemInfo.auction_type IS "V">
      <cfquery name="getSecondBid" datasource="#DATASOURCE#" maxrows=2>
          SELECT bid
            FROM bids
           WHERE itemnum = #get_ItemInfo.itemnum#
           ORDER BY bid DESC
      </cfquery>
      
      <cfloop query="getSecondBid">
        <cfset secondBidder = getSecondBid.bid>
      </cfloop>
      
      <!--- if bids on item --->
      <cfif getSecondBid.RecordCount>
        
        <cfset reserve_met = IIf(secondBidder LT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
      <cfelse>
        
        <cfset reserve_met = IIf(bid_currently LT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
      </cfif>
      
    <cfelse>
      <cfset reserve_met = IIf(bid_currently LT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
    </cfif>
    <cfcatch>
      <cfset bid_currently = "Not Available">
      <cfset reserve_met = "not available">
      <cfset bid_count = "Not Available">
    </cfcatch>
</cftry>
<cfif not isDefined("curr_cat")>
    <cfset curr_cat = #get_Item.category1#>
</cfif>
<cfif not isDefined("curr_lvl")>
    <cfset curr_lvl = 0>
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_CatName" datasource="#DATASOURCE#">
    SELECT name
      FROM categories
     WHERE category = #get_Item.category1#
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_seller_email" datasource="#DATASOURCE#">
    SELECT email
      FROM users
     WHERE user_id = #get_Item.user_id#
</cfquery>

<cfif #get_Item.buynow_price# GT 0>
  <cfset price = #get_Item.buynow_price#>
<cfelse>
  <cfset price = #get_Item.reserve_bid#>
</cfif>
<cfset timeleft = get_Item.date_end - TIMENOW >
<cfif timeleft GT 1>
  <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
  <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
  <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
  <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
  <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
  <cfset minslabel = IIf(minsleft IS 1, DE("mins"), DE("mins"))> 
  <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
<cfelse>
  <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
  <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
  <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
  <cfset minslabel = IIf(minsleft IS 1, DE("mins"), DE("mins"))>
  <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
</cfif>
<cfif #get_Item.sire# is "">
   <cfset sire = "N/A">
<cfelse>
   <cfset sire = #get_Item.sire#>
</cfif>
<cfif #get_Item.dam# is "">
   <cfset dam = "N/A">
<cfelse>
   <cfset dam = #get_Item.dam#>
</cfif>
<cfif #get_Item.ped4# is "">
   <cfset ped4 = "N/A">
<cfelse>
   <cfset ped4 = #get_Item.ped4#>
</cfif>
<cfif #get_Item.ped5# is "">
   <cfset ped5 = "N/A">
<cfelse>
   <cfset ped5 = #get_Item.ped5#>
</cfif>
<cfif #get_Item.ped6# is "">
   <cfset ped6 = "N/A">
<cfelse>
   <cfset ped6 = #get_Item.ped6#>
</cfif>
<cfif #get_Item.ped7# is "">
   <cfset ped7 = "N/A">
<cfelse>
   <cfset ped7 = #get_Item.ped7#>
</cfif>
<cfif #get_Item.ped8# is "">
   <cfset ped8 = "N/A">
<cfelse>
   <cfset ped8 = #get_Item.ped8#>
</cfif>
<cfif #get_Item.ped9# is "">
   <cfset ped9 = "N/A">
<cfelse>
   <cfset ped9 = #get_Item.ped9#>
</cfif>
<cfif #get_Item.ped10# is "">
   <cfset ped10 = "N/A">
<cfelse>
   <cfset ped10 = #get_Item.ped10#>
</cfif>
<cfif #get_Item.ped11# is "">
   <cfset ped11 = "N/A">
<cfelse>
   <cfset ped11 = #get_Item.ped11#>
</cfif>
<cfif #get_Item.ped12# is "">
   <cfset ped12 = "N/A">
<cfelse>
   <cfset ped12 = #get_Item.ped12#>
</cfif>
<cfif #get_Item.ped13# is "">
   <cfset ped13 = "N/A">
<cfelse>
   <cfset ped13 = #get_Item.ped13#>
</cfif>
<cfif #get_Item.ped14# is "">
   <cfset ped14 = "N/A">
<cfelse>
   <cfset ped14 = #get_Item.ped14#>
</cfif>
<cfif #get_Item.ped15# is "">
   <cfset ped15 = "N/A">
<cfelse>
   <cfset ped15 = #get_Item.ped15#>
</cfif>
<cfset terms = Replace(#get_Item.terms#,  chr(13) & chr(10), "<br>", "ALL")>

<!--- sum seller rating --->
<cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getSellerRate" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS rate, COUNT(rating) AS found
          FROM feedback
         WHERE user_id = #get_Item.user_id#
    </cfquery>
    
    <cfif getSellerRate.found>
      <cfset ratingSeller = Round(getSellerRate.rate)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset ratingSeller = 0>
    </cfcatch>
</cftry>

<cfparam name="cookie.auction_cntr" default="0">
<cfif ListContains(cookie.auction_cntr, itemnum) is 0>
	<cfset hit_cnts = #IncrementValue(get_Item.hit_counter)#>
	<cfquery username="#db_username#" password="#db_password#" name="update_hitcount" datasource="#DATASOURCE#">
		UPDATE items
		SET hit_counter = #hit_cnts#
		WHERE itemnum = #itemnum#
	</cfquery>
	<cfset item_cnt_list = listappend(cookie.auction_cntr, itemnum)>
	<cfcookie name="auction_cntr" value="#item_cnt_list#" expires="1">
<cfelse>
	<cfset hit_cnts = get_Item.hit_counter>
</cfif>

<cfset defBidType = "REGULAR">
<cfset currentBid = #get_Item.minimum_bid#>
<cfset minimumBid = #get_Item.minimum_bid#>
<cfquery username="#db_username#" password="#db_password#" name="get_HighBid" datasource="#DATASOURCE#">
    SELECT bid, winner, buynow, time_placed
      FROM bids
     WHERE itemnum = #itemnum#
     ORDER BY bid DESC
</cfquery>
<cfif #get_HighBid.RecordCount#>
   <cfset currentBid = #get_HighBid.bid#>
   <cfset minimumBid = #get_HighBid.bid# + #get_Item.increment_valu#>
</cfif>
<cfset minimum_Bid = #minimumBid#>
<cfset minimumBid = #decimalformat(minimumBid)#>

<!---temporary
<cfif #get_HighBid.winner# EQ 1 OR #get_HighBid.buynow# EQ 1>
   <cfquery username="#db_username#" password="#db_password#" name="temp" datasource="#DATASOURCE#">
      UPDATE items 
         SET date_end = #createODBCDateTime(get_HighBid.time_placed)#,
             status = 0
        WHERE itemnum = #itemnum#
   </cfquery>
</cfif>
--->

<cfoutput>
<html>
<head>
	<title>Equibidz-Listing</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>

<script language="JavaScript">
	function showAddWatch(itemnum) {
        var xname = document.bidForm.nickname.value;
        if (xname != "") {
			w = 250;
			h = 360;
			left = 600;
			top = 30;
			specs = 'toolbar=no, location=no, directories=no, status=no, menubar=no, ' + 
					'scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', ' +
					'height=' + h + ', top=' + top + ', left=' + left;

			window.open( 'index_sub.cfm?itemnum=' + itemnum, '_blank', specs );		
        } else {
			alert("You must be logged-in before you can add this item to your Watchlist. You can login from the top Menu.");
			return false;
		}	
	}

	function showSalesTerms() {
        var xterms = document.bidForm.terms.value;
        if (xterms == "") {
			alert("No Terms of Sales entered by Seller.");
			return false;
		}	
	}

</script>

<cfinclude template="../../includes/menu_bar.cfm"> 
<body>
<table border='0' width=1000 <!--- JM style="background-image: url('#VAROOT#/images/bg_table.jpg')" ---> cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
	
	<!--- Start: Main Body --->
	<div align="center">
	<table border='1' width=980 cellpadding="0" cellspacing="0">
	  <tr><td>
  		<table border='0' width='980' cellpadding="0" cellspacing="0">
		  <tr bgcolor="616362" height="26"><td align="center"><b>Time: #dateformat(TIMENOW,"mm/dd/yyyy")#&nbsp;#timeformat(TIMENOW,"h:mm:ss tt")#&nbsp;&nbsp;<a href="./index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#">&nbsp;Refresh Page&nbsp;</b></a></td></tr>
          <tr><td>&nbsp;</td></tr>
          <tr><td align="center">
          <form name="bidForm" action="#VAROOT#/bid/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="POST">
          <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
            <cfquery name="getuser" datasource="#datasource#">
               select nickname, password from users where user_id = #session.user_id# and password='#session.password#'
            </cfquery>
            <input type=hidden name="password" value="#session.password#">
            <input type=hidden name="nickname" value="#getuser.nickname#">
            <cfset #session.nickname# = #getuser.nickname#>
          <cfelse>
            <input type=hidden name="password" value="">
            <input type=hidden name="nickname" value="">    
          </cfif>
          <input type="hidden" name="curr_cat" value="#curr_cat#">
          <input type="hidden" name="curr_lvl" value="#curr_lvl#">
          <input type="hidden" name="itemnum" value="#itemnum#">
          <input type="hidden" name="quantity" value="#get_Item.quantity#">
	      <input type="hidden" name="requiredBid" value="#REReplace(minimumBid, "[^0123456789.]", "", "ALL")#">
          <input type="hidden" name="terms" value="#terms#">
	      <table border='1' width='900' cellpadding="0" cellspacing="0">
	      <tr><td align="center"><br>
	          <font size=3 <!--- JM color="CDC8AB"--->><b>&nbsp;Category:&nbsp;&nbsp;&nbsp;#get_CatName.name#</b></font><br>
 		      <font size=4 <!--- JM color="CDC8AB"--->><b>#get_Item.name#&nbsp;(Entry: #get_Item.itemnum#)&nbsp;&nbsp;#get_Item.list_type#</b></font><br><br>
	          <table width='850' cellpadding="0" cellspacing="0">
	             <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr>
  		           <td width="540" align="center" valign="top">
  		              <table width='100%' cellpadding="0" cellspacing="0">
  		                 <tr><td align="center">
  		                    <table width='500' cellpadding="0" cellspacing="0">
  		                       <tr><td align="center" valign="center"><img src="#VAROOT#/fullsize_thumbs/#get_Item.picture1#" border=1 height=300 width=380></td></tr>
  		                    </table>    
  		                 </td></tr>
  		                 <tr><td>&nbsp;</td></tr>
  		                 <!--- JM <tr><td align="center"><b>#trim(get_Item.name)#,&nbsp;#trim(get_Item.pri_breed)#&nbsp;#trim(get_Item.color)#</b></td></tr>
  		                 <tr><td>&nbsp;</td></tr>--->   
  		                 <tr><td>
  		                     <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                        <tr bgcolor="616362"><td colspan=2 align="left"><font size=4><b>&nbsp;&nbsp;Auction Info</b></font></td></tr>
  		                        <tr><td>
   		                           <table width='100%' border="0" cellpadding="3" cellspacing="3">
  		                              <tr>
  		                                 <td width="35%"><b>&nbsp;&nbsp;Bidding Opens:</b></td>
  		                                 <td width="65%">#dateformat(get_Item.date_start,"mm/dd/yyyy")#&nbsp;#timeformat(get_Item.date_start,"h:mm tt")#</td>
  		                              </tr>
  		                              <tr>
  		                                 <td width="35%"><b>&nbsp;&nbsp;Bidding Ends:</b></td>
  		                                 <td width="65%">#dateformat(get_Item.date_end,"mm/dd/yyyy")#&nbsp;#timeformat(get_Item.date_end,"h:mm tt")#</td>
  		                              </tr>
  		                              <tr>
  		                                 <td width="35%"><b>&nbsp;&nbsp;Time Remaining:</b></td>
  		                                 <td width="65%">#timeleft#</td>
  		                              </tr>
  		                           </table>
  		                        </td></tr>   
  		                     </table>      
  		                 </td></tr>   
  		              </table>   
  		              <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
                        <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Details</b></font></td></tr>
                        <tr><td>
                          <table width='100%' border="0" cellpadding="3" cellspacing="5">
                             <tr>
                                <td width="45%"><b>&nbsp;&nbsp;Horse Name:</b></td>
                                <td width="55%">#get_Item.name#</td>
  		                     </tr>
                             <tr>
                                <td width="35%"><b>&nbsp;&nbsp;Location:</b></td>
                                <td width="65%">#get_Item.city#,&nbsp;#get_Item.state#</td>
								<!--- <td width="65%">#get_Item.province#,&nbsp;#get_Item.country#</td>--->
  		                     </tr>  		            
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Country:</b></td>
  		                        <td width="65%">#get_Item.province#,&nbsp;#get_Item.country#</td>
  		                     </tr>  		                     
  		                     <tr><!--- JM <td width="35%"><b>&nbsp;&nbsp;Registration Number:</b></td>
  		                        <td width="65%">#get_Item.registration#</td>
  		                     </tr>  		                     
  		                     <tr>--->  		                     
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Lifetime Earnings:</b></td>
  		                        <td width="65%">#dollarformat(get_Item.earnings)#&nbsp;USD</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Primary Breed:</b></td>
  		                        <td width="65%">#get_Item.pri_breed#</td>
  		                     </tr>
  		                     <cfif #get_Item.sec_breed# NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Secondary Breed:</b></td>
  		                          <td width="65%">#get_Item.sec_breed#</td>
  		                       </tr>  		                      
  		                     </cfif>  
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Pure Bred:</b></td>
  		                        <td width="65%">
  		                            <cfif #get_Item.pure_breed# EQ 1>Yes<cfelse>No</cfif>
  		                        </td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Sex:</b></td>
  		                        <td width="65%">
  		                            <cfif #get_Item.sex# EQ "S">Stallion<cfelseif #get_Item.sex# EQ "M">Mare<cfelse>Gelding</cfif>
  		                        </td>
  		                     </tr>
  		                     <cfif #get_item.height# NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Height:</b></td>
  		                          <td width="65%">#get_Item.height#</td>
  		                       </tr>  		                      
  		                     </cfif>  
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Color:</b></td>
  		                        <td width="65%">#get_Item.color#</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Birthday:</b></td>
  		                        <td width="65%">#dateformat(get_Item.dob,"mm/yyyy")#</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Discipline:</b></td>
  		                        <td width="65%">#get_Item.discipline#</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Experience:</b></td>
  		                        <td width="65%">#get_Item.experience#</td>
  		                     </tr>
  		                     <cfif #get_Item.attributes# NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Attributes:</b></td>
  		                          <td width="65%">#get_Item.attributes#</td>
  		                       </tr>
  		                     </cfif>  
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Temperament:</b></td>
  		                        <td width="65%">#get_Item.temperament#</td>
  		                     </tr>  		                     
  		                     <!----mare----->
  		                     <cfif #get_Item.isfoal# EQ "Y">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;In Foal:</b></td>
  		                          <td width="65%">Yes</td>
  		                       </tr>  		                     
  		                     </cfif>  
  		                     <cfif #get_Item.last_bred_date# NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Last Bred Date:</b></td>
  		                          <td width="65%">#get_Item.last_bred_date#</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <!----stallion----->
  		                     <cfif #get_Item.shipped_semen# EQ "A">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Shipped Semen:</b></td>
  		                          <td width="65%">Available</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.frozen_semen# EQ "A">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Frozen Semen:</b></td>
  		                          <td width="65%">Available</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.regular_fee# GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Regular Fee:</b></td>
  		                          <td width="65%">#dollarformat(get_Item.regular_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.shipped_semen_fee# GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Shipped Semen Fee:</b></td>
  		                          <td width="65%">#dollarformat(get_Item.shipped_semen_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.intl_shipped_semen_fee# GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Int'l Shipped Semen Fee:</b></td>
  		                          <td width="65%">#dollarformat(get_Item.intl_shipped_semen_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.counter_fee# GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Counter-to-Counter Fee:</b></td>
  		                          <td width="65%">#dollarformat(get_Item.counter_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.booking_fee# GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Booking Fee:</b></td>
  		                          <td width="65%">#dollarformat(get_Item.booking_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif #get_Item.mare_care_fee# GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Mare Care Fee:</b></td>
  		                          <td width="65%">#dollarformat(get_Item.mare_care_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                  </table>
  		                </td></tr>   
  		              </table>      
  		           </td>
  		           
  		           
 		           <td width="9">&nbsp;</td>
 		           
 		           
  		           <td width="351" valign="top">
                      <table width='351' border="1" cellpadding="0" cellspacing="0">
  		                 <tr><td align="center"><b><br>
		                    <cfif #get_HighBid.winner# EQ 1 OR #get_HighBid.buynow# EQ 1>
                               <font size=10 color="5688b9"><b>SOLD</b></font><br>
                               <font size=5 color="5688b9">at #dollarformat(get_HighBid.bid)#&nbsp;USD</font>   
		                    <cfelseif #get_Item.status# EQ 1 AND #get_Item.date_end# GT #TIMENOW#>
							   <font color="CDC8AB"><img src="#VAROOT#/images/clock.gif" height=18 width=18>&nbsp;&nbsp;Time Remaining:</font><br>		                    
		                       <font size=4><b>#timeleft#</b></font>
                            <cfelse>
                               <font size=6 color="red"><b>EXPIRED<br>(NOT SOLD)</b></font><br>
		                    </cfif>   
  		                    <br><br>
  		                 </td></tr>
 	                  </table>   
  		              <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="center"><font size=4><b>Buy  Now</b></font></td></tr>
                        <tr><td>
                        <table width='100%' border="0" cellpadding="5" cellspacing="5">
                           <cfif #get_Item.buynow_price# GT 0>
  		                      <tr><td align="center">Buy Now Price:&nbsp;<b>#dollarformat(get_Item.buynow_price)#&nbsp;USD</b></td></tr>
	                          <cfif #get_HighBid.winner# NEQ 1 AND #get_HighBid.buynow# NEQ 1 AND #from_list# LTE 1>
     		                      <tr><td align="center"><input type="submit" name="buynow_yes" value="Buy Now">
  		                      </cfif>
  		                   <cfelse>
	                          <tr><td align="center"><b>Buy Now not offered</b></td></tr>
  		                   </cfif>   
	                    </table>   
  		                </td></tr>
  		              </table>
  		              <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="center"><font size=4><b>Bid Now</b></font><td></tr>
                        <tr><td>
                        <table width='100%' border="0" cellpadding="3" cellspacing="3">
  		                  <tr>
  		                    <td>&nbsp;&nbsp;<cfif #get_Item.auction_mode# EQ 0>Current High Bid:<cfelse>Current Lowest Bid:</cfif></td>
  		                    <td><b>#dollarformat(currentBid)#&nbsp;USD</b></td>
  		                  </tr>
	                      <tr>
  		                    <td>&nbsp;&nbsp;Bid Increment:</td>
  		                    <td><b>#dollarformat(get_Item.increment_valu)#&nbsp;USD</b></td>
  		                  <tr>
  		                    <td>&nbsp;&nbsp;Minimum Bid:</td>
  		                    <td><b>#dollarformat(minimum_Bid)#&nbsp;USD</b></td>
  		                  </tr>  
  		                  <tr><td colspan=2 align="center"><a href="bidhistory.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#"><font size=1></font>Click to View Bid History</font>&nbsp;(#get_HighBid.RecordCount#)</a></td></tr>
		                  <tr><td colspan=2><hr size=1 color="#heading_color#" noshade></td></tr>
                          <tr>
                            <td>&nbsp;&nbsp;Select Bid Type:</td>
                            <td>
                              <cfif #get_HighBid.winner# NEQ 1 AND #get_HighBid.buynow# NEQ 1 AND #from_list# LTE 1>		                  
                                 <select name="bidType">
                                    <option value="REGULAR" <cfif defBidType IS "REGULAR"> selected</cfif>>Regular Bid</option>
                                    <option value="PROXY" <cfif defBidType IS "PROXY"> selected</cfif>>Auto Bid</option>
                                 </select>
                              <cfelse>
                                 <select name="bidType">
                                    <option value="" selected>--Disabled--</option>
                                 </select>
                              </cfif>   
                            </td>   
		                  </tr>
  		                  <tr>
  		                    <td>&nbsp;&nbsp;Your Bid:</td>
  		                    <td>
                              <cfif #get_HighBid.winner# NEQ 1 AND #get_HighBid.buynow# NEQ 1 AND #from_list# LTE 1>		                  
  		                        <input type=text name="bid" value="#REReplace(minimumBid, "[^0123456789.]", "", "ALL")#" size="11">
  		                      <cfelse>
  		                        <input type=text readonly="true" name="bid" value="--Disabled--" size="11">
  		                      </cfif>   
  		                    </td>  
  		                  </tr>  
		                  <tr><td colspan=2 align="left"><font size=2>Please enter only numerals and the decimal point.  Do not include currency symbols such as a dollar sign ('$') or commas (',').  Unless otherwise noted.</font></td></tr>
		                  <tr><td colspan=2 align="left"><font size=2><b>Binding contract.</b> Placing a bid is a binding contract in many states and provinces. Do not bid unless you intend to buy this item at the amount of your bid.</font></td></tr>
                          <cfif #get_HighBid.winner# NEQ 1 AND #get_HighBid.buynow# NEQ 1 AND #from_list# LTE 1>		                  
  		                     <tr><td colspan=2 align="center"><input type="submit" name="reviewBid" value="Submit Bid"></td></tr>
  		                  </cfif>   
  		                </table>   
  		                </td></tr>
  		              </table>
  		              <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                 <tr><td align="center">
  		                     <br>
  		                     <cfset body = "Thought you might be interested on #get_Item.name# currently on auction at #DOMAIN#. Just follow this link http://#DOMAIN#/listings/details/index.cfm?itemnum=#itemnum#">
                             <table width='80%' border="0" cellpadding="0" cellspacing="0">
  		                        <tr><td><img src="#VAROOT#/images/share.gif" height=18 width=18>&nbsp;&nbsp;<a href="##" onClick="return showAddWatch('#itemnum#')"><b>Add to Watchlist</b></a></td></tr>
  		                        <tr><td><img src="#VAROOT#/images/friend.gif" height=18 width=18>&nbsp;&nbsp;<a href="mailto:your friend email?subject=#get_Item.name#&body=#body#"><b>Tell a friend</b></a></td></tr>
  		                        <tr><td align="left">
									<div class="addthis_toolbox addthis_default_style ">
									   <font color="ffffff"><b><a class="addthis_button_compact">&nbsp;Share This</a></b></font>						
									</div>   				
									<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pubid=xa-4dfc8e65615aa08c"></script>
  		                        </td></tr>
  		                     </table>   
  		                     <br>
  		                 </td></tr>
 	                  </table>   
 	                  <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="center"><font size=4><b>Additional Information</b></font></td></tr>
                        <tr><td>
                        <table width='100%' border="0" cellpadding="0" cellspacing="5">
  		                  <!--- JM <tr><td align="center"><b>#get_Item.nickname#</b><a href="#VAROOT#/feedback/index.cfm?user_id=#get_Item.user_id#&itemnum=#get_Item.itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#">&nbsp;(<b>#ratingSeller#</b>)</a></td></tr>
  		                  <tr><td align="center"><! --->
                             <table width='90%' border="0" cellpadding="0" cellspacing="0">
                                <tr><td><a href="#VAROOT#/feedback/legend.cfm?">
 							       <cfif ratingSeller LTE 9><img align="center" border="0" src="/legends/#get_layout.legend1#" height="18" width="18" title="Feedback Legend">
							       <cfelseif ratingSeller LTE 49><img align="center" border="0" src="/legends/#get_layout.legend2#" height="18" width="18">
							       <cfelseif ratingSeller LTE 99><img align="center" border="0" src="/legends/#get_layout.legend3#" height="18" width="18">
							       <cfelseif ratingSeller LTE 499><img align="center" border="0" src="/legends/#get_layout.legend4#" height="18" width="18">
							       <cfelseif ratingSeller LTE 999><img align="center" border="0" src="/legends/#get_layout.legend5#" height="18" width="18">
							       <cfelseif ratingSeller LTE 4999><img align="center" border="0" src="/legends/#get_layout.legend6#" height="18" width="18">
							       <cfelseif ratingSeller LTE 9999><img align="center" border="0" src="/legends/#get_layout.legend7#" height="18" width="18">
							       <cfelseif ratingSeller LTE 24999><img align="center" border="0" src="/legends/#get_layout.legend8#" height="18" width="18">
							       <cfelseif ratingSeller LTE 49999><img align="center" border="0" src="/legends/#get_layout.legend9#" height="18" width="18">
							       <cfelseif ratingSeller LTE 99999><img align="center" border="0" src="/legends/#get_layout.legend10#" height="18" width="18">
							       <cfelse><img align="center" border="0" src="/legends/#get_layout.legend11#"></cfif></a>
                                   <a href="#VAROOT#/feedback/index.cfm?user_id=#get_Item.user_id#&itemnum=#get_Item.itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#"><b>Sellers Feedback Profile</b></a>
                                </td></tr>
  		                        <tr><td><img src="#VAROOT#/images/contact.gif" height=18 width=18>&nbsp;&nbsp;<a href="#VAROOT#/contactus.cfm"><b>More Information Needed</b></a></td></tr>
  		                        <tr><td><img src="#VAROOT#/images/terms.gif" height=18 width=18>&nbsp;&nbsp;<a href="index.cfm?curr_cat=#curr_cat#&curr_lvl=#curr_lvl#&fromList=0&itemnum=#itemnum###TERMS_A" onClick="return showSalesTerms()"><b>View Seller's Terms & Shipping Info</b></a></td></tr>
  		                     </table>   
  		                     <br>
  		                  </td></tr>            
  		                </table>   
  		                </td></tr>
  		              </table>
  		           </td>
  		         </tr>
  		         
  		         <cfif #get_Item.nominations# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Nominations & Enrollments</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.nominations#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.comments# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Comments</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.comments#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.performance# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Performance</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.performance#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.produce# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Produce Record</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.produce#</td></tr>
	                       </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.sire_performance# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Sire's Performance & Produce Record</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.sire_performance#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.dam_performance# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Dam's Performance & Produce Record</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.dam_performance#</td></tr>
	                       </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.stallion_incentive# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Stallion Incentive Enrollment Program</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#get_Item.stallion_incentive#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif #get_Item.weblink# is not "">
 	                <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3><img src="#VAROOT#/images/web.gif" height=14 width=14>&nbsp;&nbsp;<a href="#get_Item.weblink#" target="_blank"><b>Visit the Horse Web Site for More Information About This Horse</b></a></td></tr>
  		            <tr><td colspan=3>If you have questions about this horse, please contact the horse owner through their web site.</td></tr>
  		         </cfif>   
		         <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr><td colspan=3 align="center">
                            <table width='100%' border="1" cellpadding="0" cellspacing="0">
                               <tr>
                                 <td rowspan="8" align="center" valign="middle">#get_Item.name#</td>
                                 <td rowspan="4" align="center" valign="middle">#sire#</td>
                                 <td rowspan="2" align="center" valign="middle">#ped4#</td>
                                 <td align="center" valign="middle">#ped8#</td>
                               </tr>
                               <tr>
                                 <td align="center" valign="middle">#ped9#</td>
                               </tr>
                               <tr>
                                 <td rowspan="2" align="center" valign="middle">#ped5#</td>
                                 <td align="center" valign="middle">#ped10#</td>
                               </tr>
                               <tr>
                                 <td align="center" valign="middle">#ped11#</td>
                               </tr>
                               <tr>
                                 <td rowspan="4" align="center" valign="middle">#dam#</td>
                                 <td rowspan="2" align="center" valign="middle">#ped6#</td>
                                 <td align="center" valign="middle">#ped12#</td>
                               </tr>
                               <tr>
                                 <td align="center" valign="middle">#ped13#</td>
                               </tr>
                               <tr>
                                 <td rowspan="2" align="center" valign="middle">#ped7#</td>
                                 <td align="center" valign="middle">#ped14#</td>
                               </tr>
                               <tr><td align="center" valign="middle">#ped15#</td></tr>
 	                        </table>
  		         </td></tr>  		         
		         <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr><td colspan=3>
                     <table width='100%' border="1" cellpadding="0" cellspacing="0">
                        <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Video & Photos</b></font></td></tr>
                        <tr><td align="center">
                            <table width='98%' border="0" cellpadding="5" cellspacing="5">
                               <cfif #get_Item.youtube# is not "">
                                   <tr><td colspan=3 align="center">#get_Item.youtube#</td></tr>
                               </cfif>    
                               <tr align="center">
                                 <td><cfif #get_Item.picture1# is not ""><img src="#VAROOT#/fullsize_thumbs/#get_Item.picture1#" border=1 height=200 width=250><cfelse>&nbsp;</cfif></td>
                                 <td><cfif #get_Item.picture2# is not ""><img src="#VAROOT#/fullsize_thumbs1/#get_Item.picture2#" border=1 height=200 width=250><cfelse>&nbsp;</cfif></td>
                                 <td><cfif #get_Item.picture3# is not ""><img src="#VAROOT#/fullsize_thumbs2/#get_Item.picture3#" border=1 height=200 width=250><cfelse>&nbsp;</cfif></td>
                               </tr>  
                               <tr align="center">
                                 <td><cfif #get_Item.picture4# is not ""><img src="#VAROOT#/fullsize_thumbs3/#get_Item.picture4#" border=1 height=200 width=250><cfelse>&nbsp;</cfif></td>
                                 <td><cfif #get_Item.picture5# is not ""><img src="#VAROOT#/fullsize_thumbs4/#get_Item.picture5#" border=1 height=200 width=250><cfelse>&nbsp;</cfif></td>
                                 <td><cfif #get_Item.picture6# is not ""><img src="#VAROOT#/fullsize_thumbs5/#get_Item.picture6#" border=1 height=200 width=250><cfelse>&nbsp;</cfif></td>
                               </tr>  
  		                    </table>
                        </td></tr>
  		             </table>      
  		         </td></tr>  		     
  		         <cfif #terms# is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3><a name="TERMS_A">
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="center"><font size=4><b>Terms of Sales & Shipping Info</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#terms#</td></tr>
	                       </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  	
  		         </cfif>
  		         <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr><td colspan=3>
                     <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Other Info</b></font></td></tr>
                        <tr><td>
                        <table width='100%' border="0" cellpadding="0" cellspacing="5">
                           <tr><td>
							   <ul>
								  <li>The end time of this listing will extend as long as active bidding continues.</li>
								  <cfif #get_Item.pay_morder_ccheck# EQ 1>
								     <li>Seller accepts Cashier's Check, Money Order, Bank Transfer.</li>
								  </cfif>
								  <cfif #get_Item.pay_am_express# EQ 1>
								     <li>Seller accepts payment thru American Express Card.</li>
								  </cfif>
								  <cfif #get_Item.pay_cod# EQ 1>
								     <li>Seller accepts payment thru Collect-On-Delivery(COD).</li>
								  </cfif>
								  <cfif #get_Item.pay_discover# EQ 1>
								     <li>Seller accepts payment thru Discover Card.</li>
								  </cfif>
								  <cfif #get_Item.pay_pcheck# EQ 1>
								     <li>Seller accepts payment by Personal Check.</li>
								  </cfif>
								  <cfif #get_Item.pay_visa_mc# EQ 1>
								     <li>Seller accepts payment thru VISA/MasterCard.</li>
								  </cfif>
								  <cfif #get_Item.pay_ol_escrow# EQ 1>
								     <li>Seller accepts payment thru PayPal.</li>
								  </cfif>
								  <cfif #get_Item.pay_other# EQ 1 OR #get_Item.pay_see_desc# EQ 1>
								     <li>Please check on Comments portion of this listing for further payment methods.</li>
								  </cfif>
								  <cfif #get_Item.ship_sell_pays# EQ 1>
								     <li>Seller pays shipping costs.</li>
								  </cfif>
								  <cfif #get_Item.ship_buy_pays_act# EQ 1>
								     <li>Buyer pays actual shipping costs.</li>
								  </cfif>
								  <cfif #get_Item.ship_buy_pays_fxd# EQ 1>
								     <li>Buyer pays fixed shipping costs.</li>
								  </cfif>
								  <cfif #get_Item.ship_international# EQ 1>
								     <li>Seller allows International Shipping.</li>
								  </cfif>
								  <cfif #get_Item.ship_see_desc# EQ 1>
								     <li>Check on Comments portion of this listing for further shipping details.</li>
								  </cfif>
								  <li>Payments must be made to Seller within two weeks of the end of the sale.</li>
								  <li>Complete payment information will be sent to the winning bidder by email when the bidding closes.</li>
								  <li>Unsold listings are now available for immediate purchase through this website.</li>
							   </ul>
                           </td></tr>
  		                </table>   
  		                </td></tr>
  		             </table>
  		         </td></tr>
  		         <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr><td colspan=3>
                     <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="center"><font size=3><b>Number of Times Viewed:</b>&nbsp;#hit_cnts#</font></td></tr>
  		             </table>
  		         </td></tr>
  		         <tr><td colspan=3>&nbsp;</td></tr>
              </table>
		  </td></tr>
		  </table>
 	      </form>		  
          </td></tr>
		  <tr><td>&nbsp;</td></tr>
 	      <tr><td align="center">
              <form name="details" action="index.cfm" method="post">
                 <input type="hidden" name="curr_cat" value="#curr_cat#">
                 <input type="hidden" name="curr_lvl" value="#curr_lvl#">
                 <input type="hidden" name="from_list" value="#from_list#">
	             <input type="submit" name="submit" value="Go Back">
	          </form>   
	      </td></tr>
		  <tr><td>&nbsp;</td></tr>
		</table>
	  </td></tr>
    </table>	
	</div>
	
	<tr>
		<td>
			<hr width='#get_layout.page_width#' size=1 color="#heading_color#" noshade>
		</td>
	</tr>			
	
	<tr>
		<td align="left">
			<cfinclude template="../../includes/copyrights.cfm">
		</td>
	</tr>
	
	</td>	
</tr>
</table>
</body>
</html>
</cfoutput>
