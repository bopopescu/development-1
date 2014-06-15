<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="functions/timenow.cfm">

<!--- get /root categories for front page --->
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total
      FROM categories
     WHERE parent = 0
       AND active = 1
       AND require_login = 0
     ORDER BY name ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#">
    SELECT name, list_type, sire, buynow_price, reserve_bid, date_end, picture1, pri_breed, year_foaled, color
      FROM items
     WHERE category = 'G'
       AND status = 1
       AND date_end > #TIMENOW#
     ORDER BY date_end ASC
</cfquery>


<cfoutput>
<html>
<head>
	<title>Stallions Page</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>
<cfinclude template="includes/menu_bar.cfm"> 

<body>
<table border='0' width='1000' style="background-image: url('images/bg_table.jpg')" cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
		<!--- Start: Main Body --->
		<div align="center">
		<table border='1' width='980' cellpadding="0" cellspacing="0">
		  <tr>
		  <td width=160 valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
	             <tr><td>&nbsp;</td></tr>
		         <tr><td align="center"><font color="CDC8AB"><b>Categories</b></font></td></tr>
	             <tr><td>&nbsp;</td></tr>
	             <tr><td>
	             <center>
   		         <table width='90%' cellpadding="0" cellspacing="0">
    		     <cfloop query="get_Categories">
				    <cfquery username="#db_username#" password="#db_password#" name="get_totals" datasource="#DATASOURCE#">
					   SELECT count(itemnum) as total_items
					   FROM items
					   WHERE category1 = #category# AND status = 1
                    </cfquery>
		            <tr><td align="left"><li><font size=2 color="CDC8AB"><a href="under_const.cfm">#name#&nbsp;(<b>#get_totals.total_items#</b>)</b></a></font></li></td></tr>
    		     </cfloop>
	             <tr><td>&nbsp;</td></tr>
	             <tr><td><font color="CDC8AB" size=2>Note: Lisiting may exist in sub-categories.<br></font></td></tr>
    		     </table>
    		     </center>
    		     </td></tr>
              </table>
		  </td>
		  <td width=740 valign="top">
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr><td colspan=13 align="left"><font size=6 color="CDC8AB"><b>&nbsp;Geldings</b></font><font size=5 color="CDC8AB"> - General Listings</font></td></tr>
		         <tr><td colspan=13 align="left"><font size=3 color="CDC8AB">&nbsp;&nbsp;&nbsp;You may browse <b>Categories</b> for a more definite results or use <a href="under_const.cfm"><b>Search</b></a> to find a specific listing.</font></td></tr>
		         <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
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
		               <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	                   <tr>
	                   <td align="left">&nbsp;<a href="under_const.cfm"><img src="../fullsize_thumbs/#picture1#" border=1 height=80 width=76></a></td>
		               <td>&nbsp;&nbsp;</td>
	                   <td align="left">#name#<br><a href="under_const.cfm"><i><b>BUYNOW</b> Available</i></a><br><font size=2>#trim(pri_breed)#&nbsp;#trim(year_foaled)#&nbsp;#trim(color)#;</font></td>
		               <td>&nbsp;</td>
	                   <td align="center">#list_type#</td>
		               <td>&nbsp;</td>
	                   <td align="center">#sire#</td>
		               <td>&nbsp;</td>
	                   <td align="center"> - </td>
		               <td>&nbsp;</td>
	                   <td align="center">#dollarformat(price)# USD</td>
		               <td>&nbsp;</td>
		               <td align="center"><b>#timeleft#</b></td>
   		            </cfloop>
		         <cfelse>
 		           <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	               <tr><td colspan=13>&nbsp;</td></tr>
   		           <tr><td colspan=13 align="center"><br><b>SORRY NO ACTIVE AUCTIONS FOUND!</b></td></tr>
		         </cfif>
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
				<cfinclude template="includes/copyrights.cfm">
			</td>
		</tr>
	</td>
</tr>
<table>

</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
