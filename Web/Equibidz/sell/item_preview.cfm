<cfprocessingdirective suppresswhitespace="yes">

<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfif isDefined("submit") is 0>
   <cfset submit = 0>
</cfif>

<cfif trim(submit) EQ "Submit Item">
    <cflocation url="item_submit.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=0&from_search=0">
</cfif>

<!--- Remove '$ and ,' from all currency fields.  These will cause errors on subsequent pages. --->
<cfset session.regular_fee = reReplace(session.regular_fee, "[$,]", "", "all")>
<cfset session.shipped_semen_fee = reReplace(session.shipped_semen_fee, "[$,]", "", "all")>
<cfset session.intl_shipped_semen_fee = reReplace(session.intl_shipped_semen_fee, "[$,]", "", "all")>
<cfset session.counter_fee = reReplace(session.counter_fee, "[$,]", "", "all")>
<cfset session.booking_fee = reReplace(session.booking_fee, "[$,]", "", "all")>
<cfset session.mare_care_fee = reReplace(session.mare_care_fee, "[$,]", "", "all")>
<cfset session.buynow_price = reReplace(session.buynow_price, "[$,]", "", "all")>
<cfset session.increment_valu = reReplace(session.increment_valu, "[$,]", "", "all")>
<cfset session.minimum_bid = reReplace(session.minimum_bid, "[$,]", "", "all")>
<cfset session.earnings = reReplace(session.earnings, "[$,]", "", "all")>
<cfset session.reserve_bid = reReplace(session.minimum_bid, "[$,]", "", "all")>

<cfquery username="#db_username#" password="#db_password#" name="get_CatName" datasource="#DATASOURCE#">
    SELECT name
      FROM categories
     WHERE category = #session.category1#
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_seller" datasource="#DATASOURCE#">
    SELECT email, nickname, address1, city, state, phone1, country
      FROM users
     WHERE user_id = #session.user_id#
</cfquery>

<!--- Run queries to find fee settings --->
<cfquery username="#db_username#" password="#db_password#" name="get_fee_listing" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_listing'
</cfquery>
<cfset fee_listing = #get_fee_listing.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture1" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture1'
</cfquery>
<cfset Variables.fee_picture1 = get_fee_picture1.pair> 
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture2" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture2'
</cfquery>
<cfset Variables.fee_picture2 = get_fee_picture2.pair>  
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture3" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture3'
</cfquery>
<cfset Variables.fee_picture3 = get_fee_picture3.pair>  
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture4" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture4'
</cfquery>
<cfset Variables.fee_picture4 = get_fee_picture4.pair>  
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture5" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture5'
</cfquery>
<cfset Variables.fee_picture5 = get_fee_picture5.pair>  
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture6" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture6'
</cfquery>
<cfset Variables.fee_picture6 = get_fee_picture6.pair>

<cfif session.buynow_price GT 0>
  <cfset price = #session.buynow_price#>
<cfelse>
  <cfset price = #session.reserve_bid#>
</cfif>
<cfset newtime = #dateAdd("d", session.duration, session.date_start)#>
<cfset timeleft = newtime - TIMENOW>
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
<cfif session.sire is "">
   <cfset sire = "N/A">
<cfelse>
   <cfset sire = #session.sire#>
</cfif>
<cfif session.dam is "">
   <cfset dam = "N/A">
<cfelse>
   <cfset dam = #session.dam#>
</cfif>
<cfif session.ped4 is "">
   <cfset ped4 = "N/A">
<cfelse>
   <cfset ped4 = #session.ped4#>
</cfif>
<cfif session.ped5 is "">
   <cfset ped5 = "N/A">
<cfelse>
   <cfset ped5 = #session.ped5#>
</cfif>
<cfif session.ped6 is "">
   <cfset ped6 = "N/A">
<cfelse>
   <cfset ped6 = #session.ped6#>
</cfif>
<cfif session.ped7 is "">
   <cfset ped7 = "N/A">
<cfelse>
   <cfset ped7 = #session.ped7#>
</cfif>
<cfif session.ped8 is "">
   <cfset ped8 = "N/A">
<cfelse>
   <cfset ped8 = #session.ped8#>
</cfif>
<cfif session.ped9 is "">
   <cfset ped9 = "N/A">
<cfelse>
   <cfset ped9 = #session.ped9#>
</cfif>
<cfif session.ped10 is "">
   <cfset ped10 = "N/A">
<cfelse>
   <cfset ped10 = #session.ped10#>
</cfif>
<cfif session.ped11 is "">
   <cfset ped11 = "N/A">
<cfelse>
   <cfset ped11 = #session.ped11#>
</cfif>
<cfif session.ped12 is "">
   <cfset ped12 = "N/A">
<cfelse>
   <cfset ped12 = #session.ped12#>
</cfif>
<cfif session.ped13 is "">
   <cfset ped13 = "N/A">
<cfelse>
   <cfset ped13 = #session.ped13#>
</cfif>
<cfif session.ped14 is "">
   <cfset ped14 = "N/A">
<cfelse>
   <cfset ped14 = #session.ped14#>
</cfif>
<cfif session.ped15 is "">
   <cfset ped15 = "N/A">
<cfelse>
   <cfset ped15 = #session.ped15#>
</cfif>
<cfset terms = Replace(#session.terms#,  chr(13) & chr(10), "<br>", "ALL")>

<!--- sum seller rating --->
<cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getSellerRate" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS rate, COUNT(rating) AS found
          FROM feedback
         WHERE user_id = #session.user_id#
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
<cfset hit_cnts = 0>

<cfset defBidType = "REGULAR">
<cfset currentBid = #session.minimum_bid#>
<cfset minimumBid = #session.minimum_bid#>

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
	function get_terms( itemnum ) {
		w = 1020;
		h = 500;
		left = ( screen.width / 2 )-( w / 2 );
		top = ( screen.height / 2 )-( h / 2 );
		specs = 'toolbar=no, location=no, directories=no, status=no, menubar=no, ' + 
				'scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', ' +
				'height=' + h + ', top=' + top + ', left=' + left;
			
		window.open( 'index_sub.cfm?itemnum=' + itemnum, '_blank', specs );		
	}

	function load_submit() {
        tr = document.getElementById( "trLOD" );
        tr.style.display = "table-row";        
	} 
		
</script>

<cfinclude template="../includes/menu_bar.cfm"> 
<body>
<!--- JM style="background-image: url('#VAROOT#/images/bg_table.jpg')" --->
<table border='0' width=1000 cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
	
	<!--- Start: Main Body --->
	<div align="center">
	<table border='0' width="900" cellpadding="0" cellspacing="0">
      <tr><td>&nbsp;</td></tr>
	  <tr><td><font size=4><b>Auction Item Preview</b></font></td></tr>
	  <tr><td><hr size=1 color="616362" width=100%></td></tr>
	  <table border='0' width='900' cellpadding="0" cellspacing="0">
	    <tr>
	    <td width="50%" valign="top">This is a preview of how your item will look like onced it is posted. Please make sure that all information shown are correct before comitting to submit this item.<br><br>Note: This Auction is subject to the  <a href="../terms.cfm">Terms & Conditions</a> of &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;equibidz.com as well as the fee charges.</font></td>
	    <td width="15%">&nbsp;</td>
	    <td width="35%" valign="top">
      	  <table border='0' width="100%" cellpadding="0" cellspacing="0">
      	    <tr><td colspan=2><font size=3><b>CURRENT FEES</b></font></td></tr>
      	    <ul>
      	    <tr>
      	      <td><font size=2><li>Listing Fee:</li></font></td>      	      
      	      <td><font size=2><cfif fee_listing gt 0>#numberformat(fee_listing, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
   		      <cfset total_fee = fee_listing>
      	    </tr>
      	    <cfif session.picture1 is not "">
      	      <tr>
      	        <td><font size=2><li>Image[1] Upload Fee:</li></font></td>      	      
      	        <td><font size=2><cfif fee_picture1 gt 0>#numberformat(fee_picture1, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
      	      </tr>
 		      <cfset total_fee = total_fee + fee_picture1>
            </cfif>
      	    <cfif session.picture2 is not "">
      	      <tr>
      	        <td><font size=2><li>Image[2] Upload Fee:</li></font></td>      	      
      	        <td><font size=2><cfif fee_picture2 gt 0>#numberformat(fee_picture2, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
      	      </tr>
 		      <cfset total_fee = total_fee + fee_picture2>
            </cfif>
      	    <cfif session.picture3 is not "">
      	      <tr>
      	        <td><font size=2><li>Image[3] Upload Fee:</li></font></td>      	      
      	        <td><font size=2><cfif fee_picture3 gt 0>#numberformat(fee_picture3, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
      	      </tr>
 		      <cfset total_fee = total_fee + fee_picture3>
            </cfif>
      	    <cfif session.picture4 is not "">
      	      <tr>
      	        <td><font size=2><li>Image[4] Upload Fee:</li></font></td>      	      
      	        <td><font size=2><cfif fee_picture4 gt 0>#numberformat(fee_picture4, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
      	      </tr>
 		      <cfset total_fee = total_fee + fee_picture4>
            </cfif>
      	    <cfif session.picture5 is not "">
      	      <tr>
      	        <td><font size=2><li>Image[5] Upload Fee:</li></font></td>      	      
      	        <td><font size=2><cfif fee_picture5 gt 0>#numberformat(fee_picture5, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
      	      </tr>
              <cfif fee_picture5 gt 0>      	      
 		          <cfset total_fee = total_fee + fee_picture5>
 		      </cfif>    
            </cfif>
      	    <cfif session.picture6 is not "">
      	      <tr>
      	        <td><font size=2><li>Image[6] Upload Fee:</li></font></td>      	      
      	        <td><font size=2><cfif fee_picture6 gt 0>#numberformat(fee_picture6, numbermask)# <font size=1>USD</font><cfelse>FREE</cfif></font></td>
      	      </tr>
              <cfif fee_picture5 gt 0>      	      
 		          <cfset total_fee = total_fee + fee_picture6>
 		      </cfif>    
            </cfif>
            </ul>
   	        <tr>
      	      <td><font size=3><b>TOTAL CURRENT FEES:</b></font></td>      	      
      	      <td><font size=3><b>#numberformat(total_fee, numbermask)# USD</b></font></td>
      	    </tr>
	      </table>
	    </td>
	    </tr>
	  </table>
      <tr><td>&nbsp;</td></tr>
	  </td></tr>
	  <tr><td align="center">
  		<table border='0' width="900" cellpadding="0" cellspacing="0">
          <tr><td align="center">
          <form name="item_preview" action="" method="POST">
          <input type="hidden" name="itemnum" value="#itemnum#">
          <input type="hidden" name="quantity" value="1">
	      <table border='1' width='900' cellpadding="0" cellspacing="0">
          <tr bgcolor="616362" height="26"><td align="center"><b>Time: #dateformat(TIMENOW,"mm/dd/yyyy")#&nbsp;#timeformat(TIMENOW,"h:mm:ss tt")#</b></a></td></tr>
	      <tr><td align="center"><br>
	          <!--- JM color="CDC8AB"---><font size=3><b>&nbsp;Category:&nbsp;&nbsp;&nbsp;#get_CatName.name#</b></font><br>
 		      <!--- JM color="CDC8AB"---><font size=4><b>#session.name#&nbsp;(Entry: #itemnum#)&nbsp;&nbsp;#session.list_type#</b></font><br><br>
	          <table width='850' cellpadding="0" cellspacing="0">
	             <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr>
  		           <td width="545" align="center" valign="top">
  		              <table width='100%' cellpadding="0" cellspacing="0">
  		                 <tr><td align="center">
  		                    <table width='500' cellpadding="0" cellspacing="0">  	
  		                       <cfif session.picture1 is not "">
  		                          <tr><td align="center" valign="center"><img src="#VAROOT#/fullsize_thumbs/#session.picture1#" border=1 width="#resizedImageWidth#"></td></tr>
  		                       <cfelse>
  		                          <tr><td align="center" valign="center"><img src="#VAROOT#/images/default.gif" border=1 height=100 width=100></td></tr>
  		                       </cfif>   
  		                    </table>    
  		                 </td></tr>
  		                 <tr><td>&nbsp;</td></tr>
  		                 <tr><td align="center"><b>#trim(session.name)#&nbsp;#trim(session.pri_breed)#&nbsp;#trim(session.color)#</b></td></tr>
  		                 <tr><td>&nbsp;</td></tr>   
  		                 <tr><td>
  		                     <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                        <tr bgcolor="616362"><td colspan=2 align="left"><font size=4><b>&nbsp;&nbsp;Auction Info</b></font></td></tr>
  		                        <tr><td>
   		                           <table width='100%' border="0" cellpadding="3" cellspacing="3">
  		                              <tr>
  		                                 <td width="35%"><b>&nbsp;&nbsp;Bidding Opens:</b></td>
  		                                 <td width="65%">#dateformat(session.date_start,"mm/dd/yyyy")#&nbsp;#timeformat(session.date_start,"h:mm tt")#</td>
  		                              </tr>
  		                              <tr>
  		                                 <td width="35%"><b>&nbsp;&nbsp;Bidding Ends:</b></td>
  		                                 <td width="65%">#dateformat(session.date_end,"mm/dd/yyyy")#&nbsp;#timeformat(session.date_end,"h:mm tt")#</td>
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
                                <td width="55%">#session.name#</td>
  		                     </tr>  		                     
                             <tr>
                                <td width="35%"><b>&nbsp;&nbsp;Location:</b></td>
                                <td width="65%">#session.city#,&nbsp;#session.state#</td>
								<!---<td width="65%">#session.province#,&nbsp;#session.country#</td>--->
  		                     </tr>  		            
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Country:</b></td>
  		                        <td width="65%"><cfif session.province neq "">#session.province#,&nbsp;</cfif>#session.country#</td>
  		                     </tr>  		                     
  		                     <tr><!--- JM <td width="35%"><b>&nbsp;&nbsp;Registration Number:</b></td>
  		                        <td width="65%">#session.registration#</td>
  		                     </tr>  		                     
  		                     <tr>--->
  		                        <td width="35%"><b>&nbsp;&nbsp;Lifetime Earnings:</b></td>
  		                        <td width="65%">#dollarFormat(session.earnings)#&nbsp;USD</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Primary Breed:</b></td>
  		                        <td width="65%">#session.pri_breed#</td>
  		                     </tr>
  		                     <cfif session.sec_breed NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Secondary Breed:</b></td>
  		                          <td width="65%">#session.sec_breed#</td>
  		                       </tr>  		                      
  		                     </cfif>
							 <!--- Remove per clients request
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Pure Bred:</b></td>
  		                        <td width="65%">
  		                            <cfif session.pure_breed EQ 1>Yes<cfelse>No</cfif>
  		                        </td>
  		                     </tr>
							 --->
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Sex:</b></td>
  		                        <td width="65%">
  		                           #session.sex#
  		                        </td>
  		                     </tr>
  		                     <cfif session.height NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Height:</b></td>
  		                          <td width="65%">#session.height#</td>
  		                       </tr>  		                      
  		                     </cfif>  
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Color:</b></td>
  		                        <td width="65%">#session.color#</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Birthday:</b></td>
  		                        <td width="65%">#dateformat(session.dob,"mm/yyyy")#</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Discipline:</b></td>
  		                        <td width="65%">#session.discipline#</td>
  		                     </tr>
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Experience:</b></td>
  		                        <td width="65%">#session.experience#</td>
  		                     </tr>
  		                     <cfif session.attributes NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Attributes:</b></td>
  		                          <td width="65%">#session.attributes#</td>
  		                       </tr>
  		                     </cfif>  
  		                     <tr>
  		                        <td width="35%"><b>&nbsp;&nbsp;Temperament:</b></td>
  		                        <td width="65%">#session.temperament#</td>
  		                     </tr>  		                     
  		                     <!----mare----->
  		                     <cfif session.isfoal EQ "Y">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;In Foal:</b></td>
  		                          <td width="65%">Yes</td>
  		                       </tr>  		                     
  		                     </cfif>  
  		                     <cfif session.last_bred_date NEQ "">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Last Bred Date:</b></td>
  		                          <td width="65%">#session.last_bred_date#</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <!----stallion----->
  		                     <cfif session.shipped_semen EQ "A">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Shipped Semen:</b></td>
  		                          <td width="65%">Available</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.frozen_semen EQ "A">
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Frozen Semen:</b></td>
  		                          <td width="65%">Available</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.regular_fee GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Regular Fee:</b></td>
  		                          <td width="65%">#dollarFormat(session.regular_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.shipped_semen_fee GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Shipped Semen Fee:</b></td>
  		                          <td width="65%">#dollarFormat(session.shipped_semen_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.intl_shipped_semen_fee GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Int'l Shipped Semen Fee:</b></td>
  		                          <td width="65%">#dollarFormat(session.intl_shipped_semen_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.counter_fee GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Counter-to-Counter Fee:</b></td>
  		                          <td width="65%">#dollarFormat(session.counter_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.booking_fee GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Booking Fee:</b></td>
  		                          <td width="65%">#dollarFormat(session.booking_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>
  		                     <cfif session.mare_care_fee GT 0>
  		                       <tr>
  		                          <td width="35%"><b>&nbsp;&nbsp;Mare Care Fee:</b></td>
  		                          <td width="65%">#dollarFormat(session.mare_care_fee)#&nbsp;USD</td>
  		                       </tr>  		                     
  		                     </cfif>  		                     
  		                  </table>
  		                </td></tr>   
  		              </table>      
  		           </td>
  		           
  		           
 		           <td width="5">&nbsp;</td>
 		           
 		           
  		           <td width="350" valign="top">
                      <table width='351' border="1" cellpadding="0" cellspacing="0">
  		                 <tr><td align="center"><b><br>
  		                    <font color="5688b9"><img src="#VAROOT#/images/Clock.gif" height=16 width=16>&nbsp;&nbsp;Time Remaining:</font><br>
  		                    <font size=4><b>#timeleft#</b></font><br><br>
  		                 </td></tr>
 	                  </table>   
  		              <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="center"><font size=4><b>Buy Now</b></font></td></tr>
                        <tr><td>
                        <table width='100%' border="0" cellpadding="5" cellspacing="5">
                           <cfif session.buynow_price GT 0>
  		                      <tr><td align="center">Buy Now Price:&nbsp;<b>#dollarFormat(session.buynow_price)#&nbsp;USD</b></td></tr>
	                          <tr><td align="center"><input type="reset" value="Buy Now"></td></tr>
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
  		                    <td>&nbsp;&nbsp;<cfif session.auction_mode EQ 0>Current High Bid:<cfelse>Current Lowest Bid:</cfif></td>
  		                    <td><b>#dollarFormat(currentBid)#&nbsp;USD</b></td>
  		                  </tr>
	                      <tr>
  		                    <td>&nbsp;&nbsp;Bid Increment:</td>
  		                    <td><b>#dollarFormat(session.increment_valu)#&nbsp;USD</b></td>
  		                  <tr>
  		                    <td>&nbsp;&nbsp;Minimum Bid:</td>
  		                    <td><b>#dollarFormat(minimumBid)#&nbsp;USD</b></td>
  		                  </tr>  
  		                  <tr><td colspan=2 align="center">View Bid History (0)</td></tr>
		                  <tr><td colspan=2><hr size=1 color="#heading_color#" noshade></td></tr>
                          <tr>
                            <td>&nbsp;&nbsp;Select Bid Type:</td>
                            <td>
                               <select name="bidType">
                                  <option value="REGULAR" <cfif defBidType IS "REGULAR"> selected</cfif>>Regular Bid</option>
                                  <option value="PROXY" <cfif defBidType IS "PROXY"> selected</cfif>>Auto Bid</option>
                            </select>
		                  </tr>
  		                  <tr>
  		                    <td>&nbsp;&nbsp;Your Bid:</td>
  		                    <td>
  		                      <input type=text readonly="true" name="bid" value="#minimumBid#" size="11">
  		                    </td>  
  		                  </tr>  
		                  <tr><td colspan=2 align="left"><font size=2>Please enter only numerals and the decimal point.  Do not include currency symbols such as a dollar sign ('$') or commas (',').  Unless otherwise noted.</font></td></tr>
		                  <tr><td colspan=2 align="left"><font size=2><b>Binding contract.</b> Placing a bid is a binding contract in many states and provinces. Do not bid unless you intend to buy this item at the amount of your bid.</font></td></tr>
	                      <tr><td colspan=2 align="center"><input type="reset" value="Review Bid"></td></tr>
  		                </table>   
  		                </td></tr>
  		              </table>
  		              <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                 <tr><td align="center">
  		                     <br>
                             <table width='80%' border="0" cellpadding="0" cellspacing="0">
  		                        <tr><td><img src="#VAROOT#/images/List.gif" height=14 width=14>&nbsp;&nbsp;<b>Add to watch list</b></td></tr>
  		                        <tr><td><img src="#VAROOT#/images/friend.gif" height=14 width=14>&nbsp;&nbsp;<b>Tell a friend</b></td></tr>
  		                        <tr><td><img src="#VAROOT#/images/share.gif" height=14 width=14>&nbsp;&nbsp;<b>Share this</b></td></tr>
  		                     </table>   
  		                     <br>
  		                 </td></tr>
 	                  </table>   
 	                  <br>
                      <table width='100%' border="1" cellpadding="0" cellspacing="0">
  		                <tr bgcolor="616362"><td align="center"><font size=4><b>Seller Info From Your Account</b></font></td></tr>
                        <tr><td>
                        <table width='100%' border="0" cellpadding="0" cellspacing="0">
  		                  <tr><td align="center"><b>#get_seller.nickname#</b></td></tr>
  		                  
  		                  <tr><td align="center"><font size=2>Phone:&nbsp;#get_seller.phone1#</font></td></tr>
  		                  <tr><td align="center"><font size=2>#get_seller.address1#</font></td></tr>
  		                  <tr><td align="center"><font size=2>#get_seller.city#&nbsp;#session.state#</font></td></tr>
  		                  <tr><td align="center"><font size=2>#get_seller.country#</font></td></tr>
		                  <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
		                  
  		                  <tr><td align="center">
                             <table width='90%' border="0" cellpadding="0" cellspacing="0">
                                <tr><td>
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
							       <cfelse><img align="center" border="0" src="/legends/#get_layout.legend11#"></cfif>
                                   <!---<b>Sellers Feedback Profile</b></a>--->
                                </td></tr>
  		                        <!---<tr><td><img src="#VAROOT#/images/contact.gif" height=14 width=14>&nbsp;&nbsp;<b>Contact Seller</b></td></tr>--->
  		                        <!--- JM <tr><td><img src="#VAROOT#/images/web.gif" height=14 width=14>&nbsp;&nbsp;<b>Web Site</b></td></tr>--->
  		                        <!---<tr><td><img src="#VAROOT#/images/terms.gif" height=14 width=14>&nbsp;&nbsp;<b>View Seller's Terms</b></td></tr>--->
  		                     </table>   
  		                     <br>
  		                  </td></tr>            
  		                </table>   
  		                </td></tr>
  		              </table>
  		           </td>
  		         </tr>
  		         
  		         <cfif session.nominations is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='850' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Nominations & Enrollments</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                           <tr><td>#session.nominations#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif session.comments is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Comments</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#session.comments#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif session.performance is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Performance</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#session.performance#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif session.produce is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Produce Record</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#session.produce#</td></tr>
	                       </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif session.sire_performance is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Sire's Performance & Produce Record</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#session.sire_performance#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif session.dam_performance is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Dam's Performance & Produce Record</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#session.dam_performance#</td></tr>
	                       </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <cfif session.stallion_incentive is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="left"><font size=4><b>&nbsp;&nbsp;Stallion Incentive Enrollment Program</b></font></td></tr>
                           <tr><td align="center">
                           <table width='98%' border="0" cellpadding="5" cellspacing="5">
                              <tr><td>#session.stallion_incentive#</td></tr>
  		                   </table>
  		                   </td></tr>   
  		                </table>      
  		            </td></tr>  		         
  		         </cfif>
  		         <!--- JM <cfif session.weblink is not "">
 	                <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3><img src="#VAROOT#/images/web.gif" height=14 width=14>&nbsp;&nbsp;<a href="#session.weblink#" target="_blank"><b>Visit the Horse Web Site for More Information About This Horse</b></a></td></tr>
  		            <tr><td colspan=3>If you have questions about this horse, please contact the horse owner through their web site.</td></tr>
  		         </cfif>--->   
		         <tr><td colspan=3>&nbsp;</td></tr>
  		         <tr><td colspan=3 align="center">
                            <table width='100%' border="1" cellpadding="0" cellspacing="0">
                               <tr>
                                 <td rowspan="8" align="center" valign="middle">#session.name#</td>
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
                               <cfif session.youtube is not "">
                                   <tr><td colspan=3 align="center">#session.youtube#</td></tr>
                               </cfif>    
                               <tr align="center">
                                 <td><cfif session.picture1 is not ""><img src="#VAROOT#/fullsize_thumbs/#session.picture1#" border="1" width="#resizedImageWidth#"><cfelse>&nbsp;</cfif></td>
                                 <td><cfif session.picture2 is not ""><img src="#VAROOT#/fullsize_thumbs1/#session.picture2#" border="1" width="#resizedImageWidth#"><cfelse>&nbsp;</cfif></td>
                                 <td><cfif session.picture3 is not ""><img src="#VAROOT#/fullsize_thumbs2/#session.picture3#" border="1" width="#resizedImageWidth#"><cfelse>&nbsp;</cfif></td>
                               </tr>  
                               <tr align="center">
                                 <td><cfif session.picture4 is not ""><img src="#VAROOT#/fullsize_thumbs3/#session.picture4#" border="1" width="#resizedImageWidth#"><cfelse>&nbsp;</cfif></td>
                                 <td><cfif session.picture5 is not ""><img src="#VAROOT#/fullsize_thumbs4/#session.picture5#" border="1" width="#resizedImageWidth#"><cfelse>&nbsp;</cfif></td>
                                 <td><cfif session.picture6 is not ""><img src="#VAROOT#/fullsize_thumbs5/#session.picture6#" border="1" width="#resizedImageWidth#"><cfelse>&nbsp;</cfif></td>
                               </tr>  
  		                    </table>
                        </td></tr>
  		             </table>      
  		         </td></tr>  		         
  		         <cfif terms is not "">
   		            <tr><td colspan=3>&nbsp;</td></tr>
  		            <tr><td colspan=3>
                        <table width='100%' border="1" cellpadding="0" cellspacing="0">
                           <tr bgcolor="616362"><td align="center"><font size=4><b>Terms of Sale and Shipping</b></font></td></tr>
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
								  <cfif session.pay_morder_ccheck EQ 1>
								     <li>Seller accepts Cashier's Check, Money Order, Bank Transfer.</li>
								  </cfif>
								  <cfif session.pay_am_express EQ 1>
								     <li>Seller accepts payment thru American Express Card.</li>
								  </cfif>
								  <cfif session.pay_cod EQ 1>
								     <li>Seller accepts payment thru Collect-On-Delivery(COD).</li>
								  </cfif>
								  <cfif session.pay_discover EQ 1>
								     <li>Seller accepts payment thru Discover Card.</li>
								  </cfif>
								  <cfif session.pay_pcheck EQ 1>
								     <li>Seller accepts payment by Personal Check.</li>
								  </cfif>
								  <cfif session.pay_visa_mc EQ 1>
								     <li>Seller accepts payment thru VISA/MasterCard.</li>
								  </cfif>
								  <cfif session.pay_ol_escrow EQ 1>
								     <li>Seller accepts payment thru PayPal.</li>
								  </cfif>
								  <cfif session.pay_other EQ 1 OR session.pay_see_desc EQ 1>
								     <li>Please check on Comments portion of this listing for further payment methods.</li>
								  </cfif>
								  <cfif session.ship_sell_pays EQ 1>
								     <li>Seller pays shipping costs.</li>
								  </cfif>
								  <cfif session.ship_buy_pays_act EQ 1>
								     <li>Buyer pays actual shipping costs.</li>
								  </cfif>
								  <cfif session.ship_buy_pays_fxd EQ 1>
								     <li>Buyer pays fixed shipping costs.</li>
								  </cfif>
								  <cfif session.ship_international EQ 1>
								     <li>Seller allows International Shipping.</li>
								  </cfif>
								  <cfif session.ship_see_desc EQ 1>
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
          </td></tr>
		  <tr><td>&nbsp;</td></tr>
 	      <tr><td>
             <table width='100%' border="0" cellpadding="0" cellspacing="0">
				<tr id="trLOD" style="display:none;">
					<td align="center"><img src="/images/loader.gif" width="220" height="19" border="0"></td>
			   </tr>        
               <tr>
 	           <td align="center">
	               <input type="submit" name="submit" value="Submit Item" OnClick="load_submit()">
	               <input type="button" name="back" value="Go Back" onClick="JavaScript:history.back(1)">
	           </td> 
	           </tr>
	         </table>
	      </td></tr>
		  <tr><td>&nbsp;</td></tr>
          </form>   
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
			<cfinclude template="../includes/copyrights.cfm">
		</td>
	</tr>
	
	</td>	
</tr>
</table>
</body>
</html>
</cfoutput>
</cfprocessingdirective>