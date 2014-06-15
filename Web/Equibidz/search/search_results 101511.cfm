<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total, this_lvl
      FROM categories
     WHERE active = 1
       AND parent = 0
     ORDER BY name ASC
</cfquery>
<cfset name = #session.name#>
<cfset showClosedAuction_dateLimit = #dateAdd("d",10,TIMENOW)#>
<cfset sdate = #dateAdd("yyyy",-session.age_max,TIMENOW)#>
<cfset ldate = #dateAdd("yyyy",-session.age_min,TIMENOW)#>
<cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#">
    SELECT itemnum, dob, category1, name, list_type, sire, buynow_price, reserve_bid, date_end, picture1, pri_breed, year_foaled, color
       FROM items
       <cfif #session.chk_sold# EQ 0>
          WHERE ((status = 1 AND date_end > #TIMENOW#) OR (status = 0 AND date_end <= #showClosedAuction_dateLimit#))
       <cfelse>
          WHERE status = 1 AND date_end > #TIMENOW#
       </cfif>
       <cfif #session.name# NEQ "">
         AND UCASE(name) LIKE '%#UCASE(name)#%' 
       </cfif>
       <cfif #session.list_type# NEQ "">
         AND list_type = '#session.list_type#' 
       </cfif>
       <cfif #session.category1# NEQ 0>
         AND category1 = #session.category1# 
       </cfif>
       <cfif #session.location# NEQ "">
         AND location = '#session.location#' 
       </cfif>
       <cfif #session.state# NEQ "">
         AND state = '#session.state#' 
       </cfif>
       <cfif #session.country# NEQ "">
         AND country= '#session.country#' 
       </cfif>
       <cfif #session.city# NEQ "">
         AND UCASE(city) = '%#UCASE(session.city)#%' 
       </cfif>
       <cfif #session.province# NEQ "">
         AND UCASE(province) = '%#UCASE(session.province)#%' 
       </cfif>
       <cfif #session.zipcode# NEQ "">
         AND zipcode = '#session.zipcode#' 
       </cfif>
       <cfif #session.pri_breed# NEQ "">
         AND pri_breed = '#session.pri_breed#' 
       </cfif>
       <cfif #session.pure_breed# EQ 1>
          AND pure_breed = 1
       </cfif>    
       <cfif #session.sec_breed# NEQ "">
         AND sec_breed = '#session.sec_breed#' 
       </cfif>
       <cfif #session.sex# NEQ "">
         AND sex = '#session.sex#' 
       </cfif>
       AND dob >= #sdate# AND dob <= #ldate#
       <cfif #session.height_min# NEQ "" AND #session.height_max#>       
         AND height >= '#session.height_min#' AND height <= '#session.height_max#'
       </cfif>  
       <cfif #session.color# NEQ "">
         AND color = '#session.color#' 
       </cfif>
       <cfif #session.price_min# NEQ 0>
         AND buynow_price >= #session.price_min# 
       </cfif>
       <cfif #session.price_max# NEQ 0>
         AND buynow_price <= #session.price_max# 
       </cfif>
       <cfif #session.discipline# NEQ "">
         AND discipline = '#session.discipline#' 
       </cfif>
       <cfif #session.experience# NEQ "">
         AND experience = '#session.experience#' 
       </cfif>
       <cfif #session.attributes# NEQ "">
         AND attributes = '#session.attributes#' 
       </cfif>
       <cfif #session.temperament_min# NEQ "" AND #session.temperament_max#>       
         AND temperament >= '#session.temperament_min#' AND temperament <= '#session.temperament_max#'
       </cfif>  
       <cfif #session.chk_registered# EQ 1>
          AND registration <> ""
       </cfif>    
       <cfif #session.chk_withphoto# EQ 1>
          AND picture1 <> ""
       </cfif>    
       <cfif #session.chk_withvideo# EQ 1>
          AND youtube <> ""
       </cfif>          
    ORDER BY date_end ASC
</cfquery>

<cfoutput>
<html>
<head>
	<title>Equibidz-Search Results</title>
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
		<!--- Start: Main Body --->
		<div align="center">
		<table width='900' cellpadding="0" cellspacing="0" style="border-color: CDC8AB; border-width: 1px:">
		  <tr><td colspan=13 align="left">
		      <font size=4><b>Search Results</b></font><br>
		      <font size=2>You may browse <b>Categories</b> to get a short-list results.</font>
	      </td></tr>
		  <td width=250 valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td align="center"><font color="CDC8AB"><b>Categories</b></font></td></tr>
                 <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='99%' cellpadding="0" cellspacing="0">
   		         <cfif get_Categories.RecordCount>
    		        <cfloop query="get_Categories">
				       <cfquery username="#db_username#" password="#db_password#" name="get_totals" datasource="#DATASOURCE#">
					      SELECT count(itemnum) as total_items
					      FROM items
					      WHERE category1 = #category# AND status = 1
                       </cfquery>
                       <tr>
                          <td width="6%" align="left" valign="middle">
 		                     <a href="#VAROOT#/listings/index.cfm?curr_cat=#category#&curr_lvl=#this_lvl#&from_search=1"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a>
 		                  </td>
 		                  <td width="94%" align="left">   
 		                     <a href="#VAROOT#/listings/index.cfm?curr_cat=#category#&curr_lvl=#this_lvl#&from_search=1"><font size=3><b>#name#</b></a>
		                     <cfif #child_count# GT 0>
		                         <img src="#VAROOT#/images/folder.gif" width=18 height=18 border=0 align=top title="Click to view sub-categories">
		                     </cfif>
                             <font size=1>(#get_totals.total_items#)</font>		                
                          </td>
                       </tr>   
                       <tr><td colspan=2>&nbsp;</td></tr>
    		        </cfloop>
	                <tr><td colspan=2>&nbsp;</td></tr>
	                <tr><td colspan=2 align="center"><font color="CDC8AB" size=2>Note: Items may exist<br>in sub-listings.</font></td></tr>
    		     <cfelse>
 	                <tr><td colspan=2>&nbsp;</td></tr>
	                <tr><td colspan=2align="center"><font color="CDC8AB" size=2>No sub-categories found.</font></td></tr>
	             </cfif>   
                 <tr><td>&nbsp;</td></tr>
    		     </table>
    		     </td></tr>
              </table>
		  </td>
		  <td width=5></td>
		  <td width=645 valign="top">
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=60 align="center"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=250 align="center"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=70 align="center"><font color="CDC8AB"><b>Type</b></font></td>
		         <td>&nbsp;</td>
		         <td width=70 align="center"><font color="CDC8AB"><b>Sire</b></font></td>
		         <td>&nbsp;</td>
		         <td width=30 align="center"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=80 align="center"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=140 align="center"><font color="CDC8AB"><b>Time</b></font></td>
		         </tr>
		         <cfif get_Items.RecordCount>
    		        <cfloop query="get_Items">
    		           <cfif #buynow_price# GT 0>
    		              <cfset price = #buynow_price#>
    		           <cfelse>
    		              <cfset price = #reserve_bid#>
    		           </cfif>
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
                          SELECT bid, winner, buynow
                          FROM bids
                          WHERE itemnum = #itemnum#
                          ORDER BY bid DESC
                       </cfquery>					   
		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=S&curr_lvl=0&from_list=1"><img src="../fullsize_thumbs/#picture1#" border=0 height=60 width=56></a></td>
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left"><font size=2><a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=S&curr_lvl=0&from_list=1">#name# (Entry:#itemnum#)<br>
						   <cfif #get_Bids.winner# NEQ 1 AND #get_Bids.buynow# NEQ 1 AND #buynow_price# GT 0>
                              <i><b>BUYNOW</b>&nbsp;Available</i><br>
	                       </cfif>	                          
	                       #trim(pri_breed)#&nbsp;#trim(color)#</font></a>
	                   </td>
		               <td>&nbsp;</td>
	                   <td align="center"><font size=2>#list_type#</font></td>
		               <td>&nbsp;</td>
	                   <td align="center"><font size=2>#sire#</font></td>
		               <td>&nbsp;</td>
	                   <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=S&curr_lvl=0&from_list=1"><b>#get_bids.RecordCount#</b></a></td>
		               <td>&nbsp;</td>
   		               <cfif #get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1>
	                      <td align="center"><font size=2>#dollarformat(get_Bids.bid)# USD</font></td>   		               
   		               <cfelse>
	                      <td align="center"><font size=2>#dollarformat(price)# USD</font></td>
	                   </cfif>   
		               <td>&nbsp;</td>
		               <cfif #get_Bids.winner# EQ 1 OR #get_Bids.buynow# EQ 1>
 		                  <td align="center"><font size=5 color="5688b9"><b>SOLD</b></font></td>
		               <cfelse>
 		                  <td align="center"><b>#timeleft#</b></td>
 		               </cfif>
   		            </cfloop>
		         <cfelse>
    		       <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY! NO DATAS FOUND.</b></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
		         </cfif>
   		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
		      </table> 		  
		  </td></tr>
		  <tr><td colspan=3>&nbsp;</td></tr>
		  <tr>
		    <td colspan=2>&nbsp;</td>
		    <td colspan=1 align="center">
  		      <form name="search_results" action="index.cfm" method="post">		  
		          <input type="submit" name="submit" value="Go Back">
		       </form>   
		    </td>
		  </tr>
		  <tr><td colspan=3>&nbsp;</td></tr>
		</table>
		</div>
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
