<!--- 
Modified 09/30/11 - bob huff 
  corrected tables to reflect current high bid instead of list type
 --->

<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


<cfif #isDefined ("from_search")#>
   <cfset from_search = #from_search#>
<cfelse>
   <cfset from_search = 0>
</cfif>
<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif #isDefined ("my_No")#>
   <cfset my_No = #my_No#>
<cfelse>
   <cfset my_No = 11>
</cfif>
<cfif #isDefined ("my_Action")#>
   <cfset my_Action = #my_Action#>
<cfelse>
   <cfset my_Action = 0>
</cfif>

<cfif #my_Action# EQ 18>
  <cfquery username="#db_username#" password="#db_password#" name="add_watchlist" datasource="#DATASOURCE#">
    INSERT INTO watchlist (itemnum, user_id) VALUES (#itemnum#, #session.user_id#)       
  </cfquery> 
</cfif>

<cfif #my_Action# EQ 19>
  <cfquery username="#db_username#" password="#db_password#" name="del_watchlist" datasource="#DATASOURCE#">
    DELETE FROM watchlist WHERE itemnum = #itemnum# AND user_id = #session.user_id#       
  </cfquery> 
</cfif>

<cfif #my_No# EQ 11>
  <cfset my_Title = "My Active Items for Sale">
<cfelseif #my_No# is 12>
  <cfset my_Title = "My Sold Items">
<cfelseif #my_No# is 13>
  <cfset my_Title = "My Unsold/Expired Items">
<cfelseif #my_No# is 14>
  <cfset my_Title = "Items I'm Bidding">
<cfelseif #my_No# is 15>
  <cfset my_Title = "Items I've Won">
<cfelseif #my_No# is 16>
  <cfset my_Title = "Items I did not Win">
<<!--- JM 04/11/2013 cfelseif #my_No# is 17>
  <cfset my_Title = "Edit/Delete Auction">--->
<cfelseif #my_No# is 18>
  <cfset my_Title = "Create Watchlist">
<cfelseif #my_No# is 19>
  <cfset my_Title = "My Watchlist">
<cfelseif #my_No# is 20>
  <cfset my_Title = "My FutureWatch">
</cfif>
<cfif #my_No# LT 19>
  <cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#">
    SELECT itemnum, category1, name, list_type, sire, buynow_price, reserve_bid, date_end, picture1, pri_breed, year_foaled, color, quantity, auto_relist
      FROM items
     <cfif #my_No# EQ 11 OR #my_No# EQ 17>
        WHERE status = 1 AND date_end > #TIMENOW# AND user_id = #session.user_id#
     </cfif>   
     <cfif #my_No# EQ 12>
        WHERE status = 0 AND date_end < #TIMENOW#  AND user_id = #session.user_id#
     </cfif>   
     <cfif #my_No# EQ 13>
        WHERE status = 0 AND auto_relist = 0 AND date_end < #TIMENOW#  AND user_id = #session.user_id#
     </cfif>   
     <cfif #my_No# EQ 14 OR #my_No# EQ 18>
        WHERE status = 1 AND date_end > #TIMENOW#  AND user_id <> #session.user_id#
     </cfif>   
     <cfif #my_No# EQ 15 OR #my_No# EQ 16>
        WHERE status = 0 AND date_end < #TIMENOW#  AND user_id <> #session.user_id#
     </cfif>        
     ORDER BY date_start DESC
  </cfquery>
</cfif>

<cfif #my_No# EQ 19>
  <cfquery username="#db_username#" password="#db_password#" name="get_watchList" datasource="#DATASOURCE#">
     SELECT itemnum
     FROM watchlist
     WHERE user_id = #session.user_id#
  </cfquery>					   
</cfif>

<cfif #my_No# EQ 20>
  <cfif #submit# is "Submit">
     <cfif (#trim (keywords)# is "") and (#enabled# eq 1)>
        <cfset #stat_message# = "<font color='red'>You must specify one or more keywords to use this feature.</font>">
     <cfelse>
        <cfif isDefined("enabled")>
           <cfset enabled = 1>
        <cfelse>
           <cfset enabled = 0>
        </cfif>
        <cfquery username="#db_username#" password="#db_password#" name="check_futurewatch" datasource="#DATASOURCE#">
          SELECT keywords
          FROM futurewatch
          WHERE user_id = #Session.user_id#
        </cfquery>   
        <cfif #check_futurewatch.recordcount# is 0>
           <cfquery username="#db_username#" password="#db_password#" name="insert_futurewatch" datasource="#DATASOURCE#">
              INSERT INTO futurewatch (user_id, keywords, enabled) VALUES (#session.user_id#, '#keywords#', #enabled#);
           </cfquery>
        <cfelse>
           <cfquery username="#db_username#" password="#db_password#" name="update_futurewatch" datasource="#DATASOURCE#">
              UPDATE futurewatch SET keywords = '#keywords#', enabled = #enabled# WHERE user_id = #session.user_id#
           </cfquery>
        </cfif>
        <cfset #stat_message# = "Your FutureWatch keywords was successfully submitted.">
     </cfif>       
  <cfelse>
     <cfquery username="#db_username#" password="#db_password#" name="check_futurewatch" datasource="#DATASOURCE#">
        SELECT keywords, enabled
          FROM futurewatch
         WHERE user_id = #session.user_id#
         ORDER BY id DESC
     </cfquery>   
     <cfset keywords = #check_futurewatch.keywords#>
     <cfset enabled = #check_futurewatch.enabled#>  
     <cfset stat_message = "">
  </cfif>
</cfif>

<cfset rec_ctr = 0>
<cfset tot_qty = 0>
<cfset tot_bids = 0>
<cfset tot_price = 0>

<cfoutput>
<html>
<head>
	<title>Equibidz-My Auctions</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>
<cfinclude template="../includes/menu_bar.cfm"> 

<body>
<div align="center">
<table border='0' width='1000' style="background-image: url('images/bg_table.jpg')" cellpadding="0" cellspacing="0">
<tr valign="top">
	<td align="center">
		<!--- Start: Main Body --->
		<div align="center">
		<table width='900' cellpadding="0" cellspacing="0" style="border-color: CDC8AB; border-width: 1px:">
          <tr><td colspan=3><font size=4><br><br><b>My Auction</b></font></td></tr>
          <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
          <tr><td colspan=3><font size=3>
              This section of our site allows you to monitor & update your Auction Items as well as view statistics such as your bidding history
              and auctions history. This Page is exclusive to your account and accessible only by your username & password.
          </td></tr>
          <tr><td colspan=3>&nbsp;</td></tr>
          <tr><td colspan=3>&nbsp;</td></tr>
		  <tr><td colspan=3 align="left">
		      <font size=4><b>#my_Title#</b></font><br>
		      <font size=2  color="aaaaaa">Select an item from the Menu to update your Auction Account or use <a href="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0"><b>Search</b></a> to find a specific listing.</font>
	      </td></tr>
		  <td width=210 valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td align="center"><font color="CDC8AB"><b>M e n u</b></font></td></tr>
		         <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='99%' cellpadding="1" cellspacing="1">
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=11"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 11>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=11">Active Items for Sale</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=12"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 12>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=12">Sold Items</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=13"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 13>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=13">Unsold/Expired Items</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=14"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 14>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=14">Items I'm Bidding</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=15"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 15>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=15">Items I've Won</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=16"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 16>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=16">Items I did not Win</a></b></font></td>
                    </tr>   
                    
					<!--- JM 04/11/2013 <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=17"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 17>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=17">Edit/Delete Auction</a></b></font></td>
                    </tr> --->  
                    
					<tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=18"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 18>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=18">Create Watchlist</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=19"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 19>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=19">View Watchlist</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_auctions.cfm?my_No=20"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 20>style="color:ffffff;"</cfif> href="my_auctions.cfm?my_No=20">FutureWatch</a></b></font></td>
                    </tr>   
                    <tr><td colspan=2>&nbsp;</td></tr>
                    <tr><td colspan=2 align="left"><a href="my_accounts.cfm"><font size=1><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10">&nbsp;&nbsp;<b>GO TO MY ACCOUNT</b></font></a></td></tr>
    		     </table>
    		     </td></tr>
              </table>
		  </td>
		  <td width=5></td>
		  <td width=685 valign="top">
		    <!---------Active-items-for-sale---------------->
		    <cfif #my_No# EQ 11>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=260 align="center"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=100 align="center"><font color="CDC8AB"><b>Current Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=100 align="center"><font color="CDC8AB"><b>Sire</b></font></td>
		         <td>&nbsp;</td>
		         <td width=60 align="center"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=70 align="center"><font color="CDC8AB"><b>Reserver Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center"><font color="CDC8AB"><b>Time</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
    		           <cfif #buynow_price# GT 0>
    		              <cfset price = #buynow_price#>
    		           <cfelse>
    		              <cfset price = #reserve_bid#>
    		           </cfif>
   		               <cfset tot_price = tot_price + #price#>    		              
					   <cfset timeleft = date_end - TIMENOW >
					   <cfif timeleft GT 1>
						  <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
						  <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
						  <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
						  <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
						  <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
						  <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & " +">
					   <cfelse>
						  <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
						  <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
						  <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
						  <cfset minslabel = IIf(minsleft IS 1, DE("min"), DE("mins"))>
						  <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
					   </cfif>
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT COUNT(bid) AS total_bids, max(bid) as max_bid
                          FROM bids
                          WHERE itemnum = #itemnum#
                       </cfquery>					   
		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)</font><br><font size=2>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		               <td>&nbsp;</td>
					   <td align="center">#dollarformat(get_bids.max_bid)# USD</td>
						<!--- <td align="center">#list_type#</td> --->
		               <td>&nbsp;</td>
	                   <td align="center">#sire#</td>
		               <td>&nbsp;</td>
	                   <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><b>#get_Bids.total_bids#</b></a></td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(price)#</td>
		               <td>&nbsp;</td>
		               <td align="center"><b>#timeleft#</b></td>
   		            </cfloop>
                    <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
                    <tr>
		            <td colspan=10>&nbsp;</td>
	                <td align="center">#dollarformat(tot_price)#</td>
		            <td colspan=2>&nbsp;</td>
		         <cfelse>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
            <!-------------sold-items----------------------->
		    <cfelseif #my_No# EQ 12>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=360 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Qty</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, buynow, winner
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount# AND (#get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1)>
    		              <cfif #buynow_price# GT 0>
    		                 <cfset price = #buynow_price#>
    		              <cfelse>
    		                 <cfset price = #reserve_bid#>
    		              </cfif>
    		              <cfif #quantity# EQ 0>
    		                 <cfset qty = 1>
    		              <cfelse>
    		                 <cfset qty = #quantity#>
    		              </cfif>    		              
		                  <cfset rec_ctr = rec_ctr + 1>
    		              <cfset tot_qty = tot_qty + qty>
    		              <cfset tot_bids = tot_bids + #get_Bids.bid#>
    		              <cfset tot_price = tot_price + #price#>    		              
 		                  <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
	                      <tr>
	                      <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		                  <td>&nbsp;&nbsp;</td>
	                      <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#qty#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(get_Bids.bid)#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(price)#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">#dateFormat(date_end, "dd-mmm-yyyy")#</td>
		               </cfif>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# GT 0>
                    <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
                    <tr>
		            <td colspan=4>&nbsp;</td>
	                <td align="center">#tot_qty#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_bids)#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_price)#</td>
		            <td colspan=2>&nbsp;</td>
		         <cfelse>
    		       <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=11>&nbsp;</td></tr>
   		           <tr><td colspan=11 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=11>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    <!---------------unsold/expired-items----------->
		    <cfelseif #my_No# EQ 13>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=300 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Qty</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         <td>&nbsp;</td>
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Action</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, buynow, winner
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount# EQ 0 OR #get_Bids.winner# EQ 0>
                          <cfif #get_Bids.RecordCount#>
                             <cfset current_bid = #get_Bids.bid#>
                          <cfelse>
                             <cfset current_bid = 0>
                          </cfif>   
    		              <cfif #buynow_price# GT 0>
    		                 <cfset price = #buynow_price#>
    		              <cfelse>
    		                 <cfset price = #reserve_bid#>
    		              </cfif>
    		              <cfif #quantity# EQ 0>
    		                 <cfset qty = 1>
    		              <cfelse>
    		                 <cfset qty = #quantity#>
    		              </cfif>    		              
		                  <cfset rec_ctr = rec_ctr + 1>
    		              <cfset tot_qty = tot_qty + qty>
    		              <cfset tot_bids = tot_bids + #current_bid#>
    		              <cfset tot_price = tot_price + #price#>    		              
 		                  <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                      <tr>
	                      <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		                  <td>&nbsp;&nbsp;</td>
	                      <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#qty#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(current_bid)#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(price)#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">#dateFormat(date_end, "dd-mmm-yyyy")#</td>
		                  <td>&nbsp;</td>
		                  <td align="center"><a href="" style="text-decoration: underline;"><font size=1><b>RELIST</b></a><br>or<br><a href="" style="text-decoration: underline;"><font size=1><b>DELETE</b></a></td>
		               </cfif>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# GT 0>
                    <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
                    <tr>
		            <td colspan=4>&nbsp;</td>
	                <td align="center">#tot_qty#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_bids)#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_price)#</td>
		            <td colspan=4>&nbsp;</td>
		         <cfelse>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    <!------------items-I'm bidding----------------->
		    <cfelseif #my_No# EQ 14>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=280 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Max Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Last Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>High Bid</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, buynow, winner
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount# AND #get_Bids.winner# EQ 0>
		                  <cfset rec_ctr = rec_ctr + 1>
                          <cfset current_bid = #get_Bids.bid#>
    		              <cfif #buynow_price# GT 0>
    		                 <cfset price = #buynow_price#>
    		              <cfelse>
    		                 <cfset price = #reserve_bid#>
    		              </cfif>
    		              <cfif #quantity# EQ 0>
    		                 <cfset qty = 1>
    		              <cfelse>
    		                 <cfset qty = #quantity#>
    		              </cfif>    		              
    		              <!---get my MaxBid/Proxy---->
                          <cfquery username="#db_username#" password="#db_password#" name="get_MyProxy" datasource="#DATASOURCE#">
                             SELECT bid
                             FROM proxy_bids
                             WHERE itemnum = #itemnum# AND user_id = #session.user_id#
                             ORDER BY bid DESC
                          </cfquery>			
                          <cfif #get_MyProxy.RecordCount#>
                             <cfset mymax_bid = #get_MyProxy.bid#>
                          <cfelse>
                             <cfset mymax_bid = 0>
                          </cfif>   
    		              <!---get my LastBid---->
                          <cfquery username="#db_username#" password="#db_password#" name="get_MyLastBid" datasource="#DATASOURCE#">
                             SELECT bid
                             FROM bids
                             WHERE itemnum = #itemnum# AND user_id = #session.user_id#
                             ORDER BY bid DESC
                          </cfquery>			
                          <cfif #get_MyLastBid.RecordCount#>
                             <cfset mylast_bid = #get_MyLastBid.bid#>
                          <cfelse>
                             <cfset mylast_bid = 0>
                          </cfif>   
 		                  <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                      <tr>
	                      <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		                  <td>&nbsp;&nbsp;</td>
	                      <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(price)#</td>
		                  <td>&nbsp;</td>
	                      <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#">#get_Bids.RecordCount#</a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(mymax_bid)#<cfif #mymax_bid# GT 0><br><font size=1><b>(AUTO-BID)</b></font></cfif></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(mylast_bid)#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">#dollarformat(current_bid)#</td>
		               </cfif>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# EQ 0>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    <!--------------items-I've-won----------------->
		    <cfelseif #my_No# EQ 15>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=360 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Qty</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, buynow, winner
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount# AND (#get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1)>
    		              <cfif #buynow_price# GT 0>
    		                 <cfset price = #buynow_price#>
    		              <cfelse>
    		                 <cfset price = #reserve_bid#>
    		              </cfif>
    		              <cfif #quantity# EQ 0>
    		                 <cfset qty = 1>
    		              <cfelse>
    		                 <cfset qty = #quantity#>
    		              </cfif>    		              
		                  <cfset rec_ctr = rec_ctr + 1>
    		              <cfset tot_qty = tot_qty + qty>
    		              <cfset tot_bids = tot_bids + #get_Bids.bid#>
    		              <cfset tot_price = tot_price + #price#>    		              
 		                  <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
	                      <tr>
	                      <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		                  <td>&nbsp;&nbsp;</td>
	                      <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#qty#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(get_Bids.bid)#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(price)#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">#dateFormat(date_end, "dd-mmm-yyyy")#</td>
		               </cfif>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# GT 0>
                    <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
                    <tr>
		            <td colspan=4>&nbsp;</td>
	                <td align="center">#tot_qty#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_bids)#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_price)#</td>
		            <td colspan=2>&nbsp;</td>
		         <cfelse>
    		       <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=11>&nbsp;</td></tr>
   		           <tr><td colspan=11 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=11>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    <!--------------items-I-did-not-won------------->
		    <cfelseif #my_No# EQ 16>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=360 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Qty</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Bid</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, buynow, winner, user_id,
                   		         (SELECT nickname FROM users WHERE bids.user_id = users.user_id) AS nickname
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount# AND (#get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1) AND #get_Bids.user_id# NEQ #session.user_id#>
    		              <cfif #buynow_price# GT 0>
    		                 <cfset price = #buynow_price#>
    		              <cfelse>
    		                 <cfset price = #reserve_bid#>
    		              </cfif>
    		              <cfif #quantity# EQ 0>
    		                 <cfset qty = 1>
    		              <cfelse>
    		                 <cfset qty = #quantity#>
    		              </cfif>    		              
		                  <cfset rec_ctr = rec_ctr + 1>
    		              <cfset tot_qty = tot_qty + qty>
    		              <cfset tot_bids = tot_bids + #get_Bids.bid#>
    		              <cfset tot_price = tot_price + #price#>    		              
 		                  <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
	                      <tr>
	                      <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		                  <td>&nbsp;&nbsp;</td>
	                      <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#&nbsp;(#get_Bids.nickname#)</font></a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#qty#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(get_Bids.bid)#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(price)#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">#dateFormat(date_end, "dd-mmm-yyyy")#</td>
		               </cfif>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# GT 0>
                    <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
                    <tr>
		            <td colspan=4>&nbsp;</td>
	                <td align="center">#tot_qty#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_bids)#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_price)#</td>
		            <td colspan=2>&nbsp;</td>
		         <cfelse>
    		       <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=11>&nbsp;</td></tr>
   		           <tr><td colspan=11 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=11>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=11><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    
			<!--------------edit/delete-auction------------->
		    <!--- JM 04/11/2013  <cfelseif #my_No# EQ 17>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=300 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Current</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         <td>&nbsp;</td>
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Action</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount#>
                          <cfset current_bid = #get_Bids.bid#>
                       <cfelse>
                          <cfset current_bid = 0>
                       </cfif>   
  		               <cfif #buynow_price# GT 0>
    		              <cfset price = #buynow_price#>
    		           <cfelse>
    		              <cfset price = #reserve_bid#>
    		           </cfif>
		               <cfset rec_ctr = rec_ctr + 1>
    		           <cfset tot_bids = tot_bids + #current_bid#>
    		           <cfset tot_price = tot_price + #price#>    		              
 		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		               <td>&nbsp;</td>
	                   <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#">#get_Bids.RecordCount#</a></td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(current_bid)#</td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(price)#</td>
		               <td>&nbsp;</td>
		               <td align="center">#dateFormat(date_end, "dd-mmm-yyyy")#</td>
		               <td>&nbsp;</td>
		               <td align="center">
		                  <cfif #get_Bids.RecordCount# EQ 0>
		                     <a href="edit_item.cfm?itemnum=#itemnum#" style="text-decoration: underline;"><font size=1><b>EDIT</b></a>
		                     <br><br>
		                     <a href="delete_item.cfm?itemnum=#itemnum#" onClick="return confirm('Please Confirm Action?')" style="text-decoration: underline;"><font size=1><b>DELETE</b></a>
		                  <cfelse>
		                     Active
		                  </cfif>   		                  
                       </td>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# GT 0>
                    <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
                    <tr>
		            <td colspan=5>&nbsp;</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_bids)#</td>
		            <td>&nbsp;</td>
	                <td align="center">#dollarformat(tot_price)#</td>
		            <td colspan=4>&nbsp;</td>
		         <cfelse>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table>---> 	
			  
			  	  
		    <!-----------create-watchlist------------------->
		    <cfelseif #my_No# EQ 18>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=300 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Current</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         <td>&nbsp;</td>
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Action</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfquery username="#db_username#" password="#db_password#" name="chk_Item" datasource="#DATASOURCE#">
                          SELECT itemnum
                          FROM watchlist
                          WHERE itemnum = #itemnum#
                       </cfquery>			
                       <cfif #chk_Item.RecordCount# EQ 0>
		                  <cfset rec_ctr = rec_ctr + 1>                       
                          <cfif #get_Bids.RecordCount#>
                             <cfset current_bid = #get_Bids.bid#>
                          <cfelse>
                             <cfset current_bid = 0>
                          </cfif>   
  		                  <cfif #buynow_price# GT 0>
    		                 <cfset price = #buynow_price#>
    		              <cfelse>
    		                 <cfset price = #reserve_bid#>
    		              </cfif>
 		                  <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                      <tr>
	                      <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#picture1#" border=0 height=50 width=50></a></td>
		                  <td>&nbsp;&nbsp;</td>
	                      <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#name# (Entry:#itemnum#)<br>#trim(pri_breed)#&nbsp;#trim(color)#</font></a></td>
		                  <td>&nbsp;</td>
	                      <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#category1#&curr_lvl=0&from_list=#my_No#">#get_Bids.RecordCount#</a></td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(current_bid)#</td>
		                  <td>&nbsp;</td>
	                      <td align="center">#dollarformat(price)#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">#dateFormat(date_end, "dd-mmm-yyyy")#</td>
		                  <td>&nbsp;</td>
		                  <td align="center">
	                         <a href="my_auctions.cfm?my_No=19&my_Action=18&itemnum=#itemnum#" style="text-decoration: underline;"><font size=1><b>ADD TO WATCHLIST</b></a>
                          </td>
                       </cfif>
   		            </cfloop>
		         </cfif>
		         <cfif #rec_ctr# EQ 0>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    <!------------my-watchlist---------------------->
		    <cfelseif #my_No# EQ 19>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=300 align="center" valign="bottom"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center" valign="bottom"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Current</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center" valign="bottom"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=110 align="center" valign="bottom"><font color="CDC8AB"><b>Closing</b></font></td>
		         <td>&nbsp;</td>
		         <td width=60 align="center" valign="bottom"><font color="CDC8AB"><b>Action</b></font></td>
		         </tr>
		         <cfif #get_watchList.RecordCount#>
    		        <cfloop query="get_watchList">
                       <cfquery username="#db_username#" password="#db_password#" name="get_Item" datasource="#DATASOURCE#">
                          SELECT status, name, category1, buynow_price, reserve_bid, date_end, picture1, pri_breed, year_foaled, color
                          FROM items
                          WHERE itemnum = #itemnum#
                       </cfquery>			
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, winner, buynow
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>			
                       <cfif #get_Bids.RecordCount#>
                          <cfset current_bid = #get_Bids.bid#>
                       <cfelse>
                          <cfset current_bid = 0>
                       </cfif>   
  		               <cfif #get_Item.buynow_price# GT 0>
    		              <cfset price = #get_Item.buynow_price#>
    		           <cfelse>
    		              <cfset price = #get_Item.reserve_bid#>
    		           </cfif>
 		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#get_Item.category1#&curr_lvl=0&from_List=#my_No#"><img src="#VAROOT#/fullsize_thumbs/#get_Item.picture1#" border=0 height=50 width=50></a></td>
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#get_Item.category1#&curr_lvl=0&from_list=#my_No#"><font size=3>#get_Item.name# (Entry:#itemnum#)<br>#trim(get_Item.pri_breed)#&nbsp;#trim(get_Item.color)#</font></a></td>
		               <td>&nbsp;</td>
	                   <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#get_Item.category1#&curr_lvl=0&from_list=#my_No#">#get_Bids.RecordCount#</a></td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(current_bid)#</td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(price)#</td>
		               <td>&nbsp;</td>
		               <td align="center">
		                  <cfif #get_Item.status# EQ 1 AND #get_Item.date_end# GT #TIMENOW#>
		                     #dateFormat(get_Item.date_end, "dd-mmm-yyyy")#
		                  <cfelseif #get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1>
		                     <font color="red"><b>SOLD</b></font>
		                  <cfelse>
		                     <font color="red"><b>UNSOLD</b></font>
		                  </cfif>   
		               </td>
		               <td>&nbsp;</td>
		               <td align="center">
                          <a href="my_auctions.cfm?my_No=19&my_Action=19&itemnum=#itemnum#" onClick="return confirm('Please Confirm?')" style="text-decoration: underline;"><font size=1><b>DELETE</b></a>
                       </td>   
   		            </cfloop>
		         <cfelse>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ITEMS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		    <!--------------my-future-watch----------------->
		    <cfelseif #my_No# EQ 20>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td>&nbsp;<font color="CDC8AB"><b>FutureWatch</b></font></td></tr>
                 <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
                 <tr><td>&nbsp;</td></tr>
                 <tr><td>Our <b>FutureWatch</b> feature allows you to be automatically notified via email when certain items are placed up for auction.  You simply specify a list of keywords to look for in the title and description of new items, and we'll automatically notify you when items containing these keywords are added anywhere on the site.</td></tr>
                 <tr><td>&nbsp;</td></tr>
                 <tr><td>&nbsp;</td></tr>
                 <cfif #stat_message# is not "">
                    <tr><td><b>#stat_message#</b></td></tr>
                 </cfif>
                 <tr><td>
                 <form action="my_auctions.cfm?my_No=20" method="post">
   		         <table border='0' width='100%' cellpadding="3" cellspacing="0">
                   <tr>
                     <td><b>Keywords:</b></td>
                     <td><input type="text" name="keywords" size=50 maxlength=255 value="#keywords#">&nbsp;(Separated by commas)</td>
                   </tr>
                   <tr>
                     <td><b>Enabled:</b></td>
                     <td><input type="checkbox" name="enabled" value="#enabled#" <cfif #enabled# is 1>checked</cfif>>&nbsp;Check this box to enable the FutureWatch feature.</td>
                   </tr>
                   <tr>
                     <td><b>Example:</b></td>
                     <td>Sofa, Chair, Loveseat</td>
                   </tr>
                   <tr><td>&nbsp;</td><td>Do not begin or end the list with a comma or use commas together. Also, do not use apostrophes or quotes.</td></tr>
                   <tr><td colspan=2>&nbsp;</td></tr>
                   <tr><td colspan=2 align="center"><input type="submit" name="submit" value="Submit">&nbsp;<input type="submit" name="submit" value="Reset"></td></tr>
                 </table>    
                 </form>
                 </td></tr>
              </table>    
		    </cfif>  
		  </td>
		  </tr>
		</table>
		</div>
		<br><br><br><br>
		<tr>
			<td>
				<hr width='#get_layout.page_width#' size=1 color="#heading_color#" noshade>
			</td>
		</tr>			
		<tr>
			<td align="left">
				<cfinclude template="../includes/copyrights.cfm">
			</td>
		</tr>
	</td>
</tr>
<table>
</div>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
