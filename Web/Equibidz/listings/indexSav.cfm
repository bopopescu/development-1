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

<cfif #curr_cat# is "S">
  <cfset catname = "Stallions">
<cfelseif #curr_cat# is "M">
  <cfset catname = "Mares">
<cfelseif #curr_cat# is "G">
  <cfset catname = "Geldings">
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

<cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#">
    SELECT itemnum, category1, name, list_type, sire, buynow_price, reserve_bid, date_end, picture1, pri_breed, year_foaled, color
      FROM items
     WHERE status = 1
       AND date_end > #TIMENOW#
     <cfif #curr_lvl# EQ 0>
       AND category = '#curr_cat#'
     <cfelse>
       AND category1 = #curr_cat#
     </cfif>
     ORDER BY date_end ASC
</cfquery>

<cfoutput>
<html>
<head>
	<title>Equibidz-Listing</title>
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
		      <font size=4><b>#catname#</b></font><br>
		      <font size=2>You may browse <b>Categories</b> for a more definite results or use <a href="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0"><b>Search</b></a> to find a specific listing.</font>
	      </td></tr>
		  <td width=160 valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td align="center"><font color="CDC8AB"><b>Categories</b></font></td></tr>
		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='99%' cellpadding="0" cellspacing="0">
   		         <cfif get_Categories.RecordCount>
   		            <ul>
    		        <cfloop query="get_Categories">
				       <cfquery username="#db_username#" password="#db_password#" name="get_totals" datasource="#DATASOURCE#">
					      SELECT count(itemnum) as total_items
					      FROM items
					      WHERE category1 = #category# AND status = 1
                       </cfquery>
		               <li>
		                  <font size=2 color="CDC8AB"><a href="index.cfm?curr_cat=#category#&curr_lvl=#this_lvl#&from_search=#from_search#">#name#
		                  <cfif #child_count# GT 0>
		                     <img src="#VAROOT#/images/folder.gif" width=18 height=18 border=0 align=top alt="Folder">
		                  </cfif>
                          (<b>#get_totals.total_items#</b>)</a></font>		                
		               </li>
    		        </cfloop>
    		        </ul>
	                <tr><td>&nbsp;</td></tr>
	                <tr><td align="center"><font size=1><a href="">VIEW ALL CATEGORIES</a></td></tr>
	                <tr><td>&nbsp;</td></tr>
	                <tr><td align="center"><font color="CDC8AB" size=2>Note: Lisiting may exist in sub-categories.</font></td></tr>
    		     <cfelse>
 	                <tr><td>&nbsp;</td></tr>
	                <tr><td align="center"><font color="CDC8AB" size=2>No sub-categories found.</font></td></tr>
	             </cfif>   
                 <tr><td>&nbsp;</td></tr>
                 <form name="listings" action="index.cfm">
                   <input type="hidden" name="curr_cat" value="#curr_cat#">
                   <input type="hidden" name="curr_lvl" value="#curr_lvl#">
                   <input type="hidden" name="from_search" value="#from_search#">
                   <cfif #curr_lvl# GT 0>
	                  <tr><td align="center"><input type="submit" name="submit" value="Back"></td></tr>
	               </cfif>   
	             </form>
                 <tr><td>&nbsp;</td></tr>
    		     </table>
    		     </td></tr>
              </table>
		  </td>
		  <td width=20></td>
		  <td width=720 valign="top">
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362">
		         <td width=80 align="center"><font color="CDC8AB"><b>Photo</b></font></td>
		         <td>&nbsp;</td>
		         <td width=200 align="center"><font color="CDC8AB"><b>Title</b></font></td>
		         <td>&nbsp;</td>
		         <td width=120 align="center"><font color="CDC8AB"><b>Type</b></font></td>
		         <td>&nbsp;</td>
		         <td width=120 align="center"><font color="CDC8AB"><b>Sire</b></font></td>
		         <td>&nbsp;</td>
		         <td width=60 align="center"><font color="CDC8AB"><b>Bids</b></font></td>
		         <td>&nbsp;</td>
		         <td width=70 align="center"><font color="CDC8AB"><b>Price</b></font></td>
		         <td>&nbsp;</td>
		         <td width=90 align="center"><font color="CDC8AB"><b>Time Left</b></font></td>
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
                          SELECT COUNT(bid) AS total_bids
                          FROM bids
                          WHERE itemnum = #itemnum#
                       </cfquery>					   
		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#"><img src="../fullsize_thumbs/#picture1#" border=0 height=80 width=76></a></td>
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left"><font size=3><a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#">#name# (Entry:#itemnum#)</a></font><br><a href="../listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#"><i><b>BUYNOW</b> Available</i></a><br><font size=2>#trim(pri_breed)#&nbsp;#trim(year_foaled)#&nbsp;#trim(color)#</font></td>
		               <td>&nbsp;</td>
	                   <td align="center">#list_type#</td>
		               <td>&nbsp;</td>
	                   <td align="center">#sire#</td>
		               <td>&nbsp;</td>
	                   <td align="center"><a href="#VAROOT#/listings/details/bidhistory.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#"><b>#get_bids.total_bids#</b></a></td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(price)# USD</td>
		               <td>&nbsp;</td>
		               <td align="center"><b>#timeleft#</b></td>
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
