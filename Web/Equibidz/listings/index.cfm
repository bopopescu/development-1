<!--- 
Modified 11/09/11 - JM adding new sort button
  corrected tables to reflect current high bid instead of list type
 --->

<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



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

<!---Post New Horse Button at the top of Page--->
<cfif #trim(submit)# is "Post New Horse">
     <cflocation url="#VAROOT#/sell/index.cfm?gencat=S&curr_cat=&curr_lvl=&from_search=0">
</cfif>

<!---All Auctions Button at the top of Page--->
<cfif #trim(submit)# is "All Auctions">
     <cflocation url="#VAROOT#/listings/index.cfm?gencat=E&curr_cat=S&curr_lvl=0&from_search=0">
</cfif>

<!---Top 10 Auctions Button at the top of Page--->
<cfif #trim(submit)# is "Auctions Ending Soon">
     <cflocation url="#VAROOT#/listings/index.cfm?gencat=S&curr_cat=S&curr_lvl=0&from_search=0">
</cfif>

<!--- Ended Not Sold and Sold Auctions Button at the top of Page--->
<cfif #trim(submit)# is "Ended And Sold">
     <cflocation url="#VAROOT#/listings/index.cfm?gencat=A&curr_cat=S&curr_lvl=0&from_search=0">
</cfif>

<!--- Back Button--->     
<cfif #trim(submit)# is "Back">
  <cfif #curr_lvl# EQ 1>
     <cfif #from_search# EQ 1>
        <cflocation url="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0">
     </cfif>
     <cfset curr_cat = #session.prev_cat0#>
     <cfset curr_lvl = #session.prev_lvl0#>
  <cfelseif #curr_lvl# EQ 2>
     <cfset curr_cat = #session.prev_cat1#>
     <cfset curr_lvl = #session.prev_lvl1#>
  <cfelseif #curr_lvl# EQ 3>
     <cfset curr_cat = #session.prev_cat2#>
     <cfset curr_lvl = #session.prev_lvl2#>
  <cfelseif #curr_lvl# EQ 3>
     <cfset curr_cat = #session.prev_cat3#>
     <cfset curr_lvl = #session.prev_lvl3#>
  </cfif>
<cfelse>
  <cfif #curr_lvl# EQ 0>
     <cfset session.prev_cat0 = #curr_cat#>
     <cfset session.prev_lvl0 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 1>
     <cfset session.prev_cat1 = #curr_cat#>
     <cfset session.prev_lvl1 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 2>
     <cfset session.prev_cat2 = #curr_cat#>
     <cfset session.prev_lvl2 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 3>
     <cfset session.prev_cat3 = #curr_cat#>
     <cfset session.prev_lvl3 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 4>
     <cfset session.prev_cat4 = #curr_cat#>
     <cfset session.prev_lvl4 = #curr_lvl#>
  </cfif>
</cfif>

<cfif isDefined("gencat")>
  <cfset gencat = #gencat#>
<cfelse>
  <cfset gencat = "S">
</cfif>

<cfif #curr_cat# is "S">
  <cfif #gencat# EQ "S">
     <cfset catname = "Top 10 Auctions ending soon...">
  <cfelseif #gencat# EQ "E">  <!---Added these two lines for new sort--->
  	 <cfset catname = "All Auctions"> 
  <cfelse>      
    <cfset catname = "Ended And Sold">
	 </cfif>   
<cfelse>
   <cfquery username="#db_username#" password="#db_password#" name="get_CatName" datasource="#DATASOURCE#">
     SELECT name
       FROM categories
      WHERE category = #curr_cat#
   </cfquery>
   <cfset catname = #get_CatName.name#>
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total, this_lvl
      FROM categories
     WHERE active = 1
     <cfif #curr_lvl# EQ 0>
       AND parent = 0
     <cfelseif #curr_lvl# EQ 1>
       AND lvl_1 = #curr_cat# AND category <> #curr_cat#
     <cfelseif #curr_lvl# EQ 2>
       AND lvl_2 = #curr_cat# AND category <> #curr_cat#
     <cfelseif #curr_lvl# EQ 3>
       AND lvl_3 = #curr_cat# AND category <> #curr_cat#
     <cfelseif #curr_lvl# EQ 4>
       AND lvl_4 = #curr_cat# AND category <> #curr_cat#
     </cfif>
     ORDER BY name ASC
</cfquery>

<cfset showClosedAuction_dateLimit = #dateAdd("d",1,TIMENOW)#>
<cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#">
    SELECT itemnum, category1, name, list_type, sire, buynow_price, minimum_bid, date_end, picture1, pri_breed, year_foaled, color
      FROM items WHERE
     <cfif #gencat# EQ "S">
        status = 1 AND date_end > #TIMENOW#
     <cfelseif #gencat# EQ "E">
        status = 1 AND date_end > #TIMENOW#     
     <cfelse>
        <!---(status = 1 AND date_end > #TIMENOW#) OR --->(status = 1 AND date_end <= #showClosedAuction_dateLimit#)
         OR (status = 0 AND date_end <= #showClosedAuction_dateLimit#)
     </cfif> 
     <cfif #curr_lvl# EQ 0>
       AND category = '#curr_cat#'
     <cfelse>
       AND category1 = #curr_cat# 
     </cfif>
     ORDER BY date_end ASC    <!---ORDER BY status DESC--->
     <cfif #gencat# EQ "S">
		LIMIT 10     <!---Limits the auction on the screen. No Ended (Not Sold ) or Sold--->
	 <cfelseif #gencat# EQ "E"> 
	 </cfif> 
</cfquery>

<cfoutput>
<html>
<head>
	<title>Equibidz Auction Listing</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>
<cfinclude template="../includes/menu_bar.cfm"> 

<body>
<div align="center">
<table border='0' width='1000' style="background-image: url('images/bg_table.jpg')" cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
		
<!---Beginning of Top Sub Menu--->
			<tr><td>
			<td width='1000' valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td align="center"><font color="CDC8AB"><b>LIVE AUCTIONS</b></font></td></tr>
		     <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='100%' cellpadding="0" cellspacing="0">
			<tr>
		    <td>&nbsp;</td>
		    		
		<!--- JM Post New Horse Top Button--->
	                
                 <form name="listings" action="index.cfm">
                   <cfif #curr_lvl# EQ 0>
	                  <tr><td colspan=3  align="Center"><cfinclude template="../includes/post_new_horse.cfm">
					   								 <input type="submit" name="submit" value="Auctions Ending Soon">
													 <input type="submit" name="submit" value="All Auctions">
													 <input type="submit" name="submit" value="Ended And Sold"></td></tr>
	               </cfif>  
	             </form>
		 <td>&nbsp;</td>
		
		<!--- Start: Main Body --->
		<div align="center">
		<table width='100%' cellpadding="0" cellspacing="0">
		  
		  
		  
		  
		  
		  
		  <tr bgcolor="616362" height="26"><td align="center"><b>Time: #dateformat(TIMENOW,"mm/dd/yyyy")#&nbsp;#timeformat(TIMENOW,"h:mm:ss tt")#&nbsp;&nbsp;<a href="#VAROOT#/listings/index.cfm?curr_cat=S&curr_lvl=0">&nbsp;Refresh Top 10 Ending Soon Page&nbsp;</b></a></td></tr>
		  </tr><td>&nbsp;</td></tr>		
		<table width='100%' cellpadding="0" cellspacing="0" style="border-color: CDC8AB; border-width: 1px:">
		  <tr><td colspan=13 align="center">
		      <font size=4><b>#catname#</b></font><br>
		      <font size=2>For more Auctions click on the <b>Categories</b> or use <a href="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0"><b>Search</b></a> to find a specific listing. Click on Item to see details.</font>
	      </td></tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr><td colspan=3>&nbsp;</td></tr>
		  <tr><td width="200" valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0" class="tblAuction">
		         <tr class="hdrAuction"><th>Category</th>
		         </tr>
		         <tr height="30"><td><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='99%' cellpadding="0" cellspacing="0">
   		         <cfif get_Categories.RecordCount>
    		        <cfloop query="get_Categories">
				       <cfquery username="#db_username#" password="#db_password#" name="get_totals" datasource="#DATASOURCE#">
					      SELECT count(itemnum) as total_items
					      FROM items
					      WHERE category1 = #category# AND status = 1 AND date_end > #TIMENOW#
                       </cfquery>
                       <tr height=10>
					   	  <td width="12">&nbsp;</td>
                          <td width="20" align="left" valign="middle">
		                    <a href="index.cfm?gencat=#gencat#&curr_cat=#category#&curr_lvl=#this_lvl#&from_search=#from_search#"><img src="#VAROOT#/images/folder.gif" border="0" width="10" height="10"></a>
		                  </td>     
 		                  <td class="tdAuctionCategory">
		                    <a href="index.cfm?gencat=#gencat#&curr_cat=#category#&curr_lvl=#this_lvl#&from_search=#from_search#">#name#
		                    <cfif #child_count# GT 0>
		                       <img src="#VAROOT#/images/folder.gif" width=18 height=18 border=0 align=top alt="Folder" title="Click to view Sub-Categories">
		                    </cfif>
                            <span class="auctionItemCount">(#get_totals.total_items#)</span></a>&nbsp;
                          </td>  
                          </tr>   
                       <tr><td colspan=3>&nbsp;</td></tr>
    		        </cfloop>
    		        <!--- JM Body Button---> 
						
						
						<!---<cfif #gencat# EQ "S">
						<tr><td colspan=3><a href="index.cfm?gencat=A&curr_cat=S&curr_lvl=0&from_search=0"><input type="submit" name="buynow_yes" value="View All Auctions"></a></td></tr>
					<cfelse>
						<tr><td colspan=3><a href="index.cfm?gencat=S&curr_cat=S&curr_lvl=0&from_search=0"><input type="submit" name="buynow_yes" value="View Top 10 Auctions"></a></td></tr>
    		        </cfif>
	                <tr><td colspan=3>&nbsp;</td></tr>
	                <tr><td colspan=3 align="center"><font color="CDC8AB" size=2>Note: Items may exist<br>in sub-categories.</font></td></tr>
    		     <cfelse>
 	                <tr><td colspan=3>&nbsp;</td></tr>
	                <tr><td colspan=3 align="center"><font color="CDC8AB" size=2>No sub-categories found.</font></td></tr>
	             </cfif> --->
	             
	             <!--- JM Old No Body Button---> 
	             
	             
	             	<!--- Removed at request of customer.  There are top buttons now for these.
					 <cfif #gencat# EQ "S">
						<tr><td colspan=3 align="center"><a href="index.cfm?gencat=A&curr_cat=S&curr_lvl=0&from_search=0"><font size=4>Click to View All Auctions</font></a></td></tr>
					<cfelse>
						<tr><td colspan=3 align="center"><a href="index.cfm?gencat=S&curr_cat=S&curr_lvl=0&from_search=0"><font size=4>Click to View Auctions Ending Soon</font></a></td></tr>
    		        </cfif>
					--->
	               <tr><td colspan=3>&nbsp;</td></tr>
				   <td>&nbsp;</td>
	               <tr><td colspan=3 align="center"><font color="CDC8AB" size=2>Note: Items may exist<br>in sub-categories.</font></td></tr>
    		     <cfelse>
 	                <tr><td colspan=3>&nbsp;</td></tr>
	                <tr><td colspan=3 align="center"><font color="CDC8AB" size=2>No sub-categories found.</font></td></tr>
	             </cfif> 
	             
	                     
	                <tr><td colspan=2>&nbsp;</td></tr>
                 <form name="listings" action="index.cfm">
                   <input type="hidden" name="curr_cat" value="#curr_cat#">
                   <input type="hidden" name="curr_lvl" value="#curr_lvl#">
                   <input type="hidden" name="from_search" value="#from_search#">
                   <cfif #curr_lvl# GT 0>
	                  <tr><td colspan=3 align="center"><input type="submit" name="submit" value="Back"></td></tr>
	               </cfif>   
	             </form>
				 
                 <tr><td colspan=3>&nbsp;</td></tr>
    		     </table>
    		     </td></tr>
              </table>
		  </td>
		  <td width=645 valign="top">
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr class="hdrAuction">
		         <th width=60>Photo</th>
		         <th>&nbsp;</th>
		         <th width=250>Title</th>
		         <th>&nbsp;</th>
		         <th width=70>Current Bid</th>
		         <th>&nbsp;</th>
		         <!---<th width=70><font color="CDC8AB"><b>Sire</b></font></th>
		         <th>&nbsp;</th>--->
		         <th width=30>Bids</th>
		         <th>&nbsp;</th>
		         <th width=95>Buy Now</th>
		         <th>&nbsp;</th>
		         <th width=180>Time</th>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
    		           <cfif #buynow_price# GT 0>
    		              <cfset price = #buynow_price#>
    		           <cfelse>
					   	   <!---<td align="center"><font size=5 color="5688b9"><b>No Buy Now</b></font></td>--->
    		              <cfset price = "0">
    		           <!---<b>Buy Now Not Available</b>--->
    		           </cfif>
					   <cfset timeleft = date_end - TIMENOW >
					   <!--- JM <cfif timeleft GT 1>
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
					   </cfif>--->
					   <cfif timeleft GT 1>
  					<cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
  					<cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
  					<cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
  					<cfset dayslabel = IIf(daysleft IS 1, DE("d"), DE("d"))>
  					<cfset hrslabel = IIf(hrsleft IS 1, DE("h"), DE("h"))>
  					<cfset minslabel = IIf(minsleft IS 1, DE("m"), DE("m"))> 
  					<cfset timeleft = daysleft & "" & dayslabel & " " & hrsleft & "" & hrslabel & " " & minsleft & "" & minslabel>
				<cfelse>
  					<cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
  					<cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
  					<cfset hrslabel = IIf(hrsleft IS 1, DE("h"), DE("h"))>
  					<cfset minslabel = IIf(minsleft IS 1, DE("m"), DE("m"))>
  					<cfset timeleft = hrsleft & "" & hrslabel & " " & minsleft & "" & minslabel & " +">
				</cfif>  
                       <cfquery username="#db_username#" password="#db_password#" name="get_Bids" datasource="#DATASOURCE#">
                          SELECT bid, winner, buynow
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>		
                       <cfquery username="#db_username#" password="#db_password#" name="get_maxbid" datasource="#DATASOURCE#">
                          SELECT max(bid) as max_bid
                          FROM bids
                          WHERE itemnum = #itemnum#                      
                       </cfquery>		                       			   
		               <tr height="30"><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#&fromList=0"><img src="../fullsize_thumbs/#picture1#" border=0 width="112"></a></td><!--- JM border=0 height=60 width=56 Original settings--->
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left"><font size=3><a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#&from_list=0">#name# <br><font size=2> (Entry:#itemnum#)<br>
						            <font size=2> #trim(pri_breed)#<br>
						            #trim(color)#</font></a><br><br>
							  <cfif #get_Bids.winner# NEQ 1 AND #get_Bids.buynow# NEQ 1 AND #buynow_price# GT 0 AND #buynow_price# GT get_maxbid.max_bid >
                               <font size=2 color=FF0000><i><b>BUY NOW</b>&nbsp;<b>AVAILABLE</b></i><br>
							  <cfelseif #buynow_price# EQ 0> 
							   <font size=2 color=FF0000><i><b>NO BUY NOW</b></i><br> 							    
							   <cfelse>
							   	    <font size=2 color="8B008B"><b>BID ABOVE BUY NOW</b></font><br>
							  </cfif>	                   </td>
		               <td>&nbsp;</td>
 	        <!---           <td align="center"><font size=2>#list_type#</font></td> --->
 	         	       <td align="center"><font size=2>#dollarformat(get_maxbid.max_bid)# USD</font></td>
		               <td>&nbsp;</td>
	                   <!---<td align="center"><font size=2>#sire#</font></td>
		               <td>&nbsp;</td>--->
                       <td align="center"><font size=2><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#&from_list=0"><b>#get_bids.RecordCount#</b></a></td>
		               <td>&nbsp;</td>
   		               <cfif #get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1>
	                      <td align="center"><font size=2>#dollarformat(get_Bids.bid)# USD</font></td>   		               
   		               <cfelse>
	                      <td align="center"><font size=2>#dollarformat(price)# USD</font></td>
	                   </cfif>   
		               <td>&nbsp;</td>
		               <cfif #get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1>
 		                  <td align="center"><font size=3 color="5688b9"><b>SOLD</b></font></td>
 <!---Test for Not sold---> <cfelseif #timeleft# EQ "0h 0m +"  > 
					   	  <td align="center"><font size=2 color="5688b9"><b>ENDED (NOT SOLD)</b></font></td>
						<cfelse>  
						  <td align="center"><font size=3><b>#timeleft#</b></td>
 		               </cfif>
					 </cfloop>
		         <cfelse>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ACTIVE AUCTIONS FOUND!</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
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
