<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">



<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_Seller" datasource="#DATASOURCE#">
    SELECT email
      FROM users
     WHERE user_id = #session.user_id#
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_CatName" datasource="#DATASOURCE#">
    SELECT name
      FROM categories
     WHERE category = #session.category1#
</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="chk_duplicate" datasource="#DATASOURCE#">
    SELECT itemnum
      FROM items
     WHERE itemnum = #itemnum#
</cfquery>
<cfif #chk_duplicate.RecordCount# EQ 0>
   <cfquery username="#db_username#" password="#db_password#" name="insert_item" datasource="#DATASOURCE#">
        INSERT INTO items
            (status,
             category,
             category1,
             auction_type,
             auction_mode,
             list_type,
             itemnum,
             user_id,
             name,
             registration,
             sire,
             dam,
             pri_breed,
             sec_breed,
             title,
             year_foaled,
             color,
             dob,
             sex,
             height,
             discipline,
             experience,
             attributes,
             temperament,
             nominations,
             comments,
             performance,
             produce,
             sire_performance,
             dam_performance,
             stallion_incentive,
             earnings,
             weblink,
             ped4,
             ped5,
             ped6,
             ped7,
             ped8,
             ped9,
             ped10,
             ped11,
             ped12,
             ped13,
             ped14,
             ped15,
             isfoal,
             last_bred_date,
             regular_fee,
             shipped_semen,
             frozen_semen,
             shipped_semen_fee,
             intl_shipped_semen_fee,
             counter_fee,
             booking_fee,
             mare_care_fee,
             picture1,
             picture2,
             picture3,
             picture4,
             picture5,
             picture6,
             youtube,
             <!--- JM location,--->
             city,
             state,
             province,
             country,
             zipcode,
             date_start,
             date_end,
             duration,
             auto_relist,
             dollar_type,
             minimum_bid,
             maximum_bid,
             reserve_bid,
             buynow_price,
             increment_valu,
             increment,
             shipping_fee,
             salestax,
             pay_morder_ccheck,
             pay_am_express,
             pay_cod,
             pay_discover,
             pay_pcheck,
             pay_ol_escrow,
             pay_visa_mc,
             pay_other,
             pay_see_desc,
             ship_sell_pays,
             ship_buy_pays_act,
             ship_buy_pays_fxd,
             ship_international,
             ship_see_desc,
             terms,
             quantity)
        VALUES (0,
             'S',
             #session.category1#,
             'E',
             0,
             '#session.list_type#',
             #itemnum#,
             #session.user_id#,
             '#session.name#',
             '#session.registration#',
             '#session.sire#',
             '#session.dam#',
             '#session.pri_breed#',
             '#session.sec_breed#',
             '#session.name#',
             0,
             '#session.color#',
             #session.dob#,
             '#session.sex#',
             '#session.height#',
             '#session.discipline#',
             '#session.experience#',
             '#session.attributes#',
             '#session.temperament#',
             '#session.nominations#',
             '#session.comments#',
             '#session.performance#',
             '#session.produce#',
             '#session.sire_performance#',
             '#session.dam_performance#',
             '#session.stallion_incentive#',
             #session.earnings#,
             '#session.weblink#',
             '#session.ped4#',
             '#session.ped5#',
             '#session.ped6#',
             '#session.ped7#',
             '#session.ped8#',
             '#session.ped9#',
             '#session.ped10#',
             '#session.ped11#',
             '#session.ped12#',
             '#session.ped13#',
             '#session.ped14#',
             '#session.ped15#',
             '#session.isfoal#',
             '#session.last_bred_date#',
             #session.regular_fee#,
             '#session.shipped_semen#',
             '#session.frozen_semen#',
             #session.shipped_semen_fee#,
             #session.intl_shipped_semen_fee#,
             #session.counter_fee#,
             #session.booking_fee#,
             #session.mare_care_fee#,
			 <cfif #session.picture1# NEQ "">'#itemnum#.jpg'<cfelse>'#session.picture1#'</cfif>,
			 <cfif #session.picture2# NEQ "">'#itemnum#.jpg'<cfelse>'#session.picture2#'</cfif>,
			 <cfif #session.picture3# NEQ "">'#itemnum#.jpg'<cfelse>'#session.picture3#'</cfif>,
			 <cfif #session.picture4# NEQ "">'#itemnum#.jpg'<cfelse>'#session.picture4#'</cfif>,
			 <cfif #session.picture5# NEQ "">'#itemnum#.jpg'<cfelse>'#session.picture5#'</cfif>,
			 <cfif #session.picture6# NEQ "">'#itemnum#.jpg'<cfelse>'#session.picture6#'</cfif>,
             '#session.youtube#',
             <!--- JM '#session.location#',--->
             '#session.city#',
             '#session.state#',
             '#session.province#',
             '#session.country#',
             '#session.zipcode#',
             #createODBCDateTime(session.date_start)#,
             #createODBCDateTime(session.date_end)#,
             #session.duration#,
             #session.auto_relist#,
             'USD',
             #session.minimum_bid#,
             #session.maximum_bid#,
             #session.reserve_bid#,
             #session.buynow_price#,
             #session.increment_valu#,
             1,
             #session.shipping_fee#,
             0,
             #session.pay_morder_ccheck#,
             #session.pay_am_express#,
             #session.pay_cod#,
             #session.pay_discover#,
             #session.pay_pcheck#,
             #session.pay_ol_escrow#,
             #session.pay_visa_mc#,
             #session.pay_other#,
             #session.pay_see_desc#,
             #session.ship_sell_pays#,
             #session.ship_buy_pays_act#,
             #session.ship_buy_pays_fxd#,
             #session.ship_international#,
             #session.ship_see_desc#,
             '#session.terms#',
             1)
   </cfquery>
   <cfset new_item = "TRUE">
   <cfmail to = "#get_Seller.email#"
         from = "registration@#DOMAIN#"
         subject = "Auction item information">
         Thank you for submitting your ad for , "#session.name#", under the listing section of "#get_CatName.name#".
         
         Since we have to approve all new ads before the are posted, your ad will not be viewable until we have received payment and approved it for posting. 
         If you did not pay with PayPal, please Equibidz.com , 111 Feturity Lane, Winner Only, Al 35806. Once we have received your payment, either by USPS or PayPal your ad will be approved and the auction will begin.
         It will be up for auction <!--- Jm 4/9/2013 starting #dateFormat(session.date_start)#,---> and will run for #session.duration# days<!--- Jm 4/09/2013 <cfif #session.duration# GT 1>s</cfif>--->, 
         <!---closing on #dateFormat(session.date_end)#.---> For your reference, the item number #itemnum# automatically assigned to your auctions ad.  
         Use this number for future reference to your auction ad.
         We hope you enjoy the new Equibidz.com and will come back often.
         
         When your auction is approved, you may view this auction in progress at http://#SITE_ADDRESS##VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=0&from_search=0.
         
         Thank you for using our services,
         #COMPANY_NAME#
   </cfmail>
<cfelse>
   <cfset new_item = "FALSE">
</cfif>
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
<table border='0' width=1000 <!--- JM style="background-image: url('#VAROOT#/images/bg_table.jpg')" ---> cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
	
	<!--- Start: Main Body --->
	<div align="center">
  	<table border='0' width="800" cellpadding="0" cellspacing="0">
      <tr><td>&nbsp;</td></tr>
  	  <cfif #new_item# is "TRUE">
 	     <tr><td><font size=4><b>Auction Posting Comfirmation</b></font></td></tr>
	     <tr><td><hr size=1 color="616362" width=100%></td></tr>
         <tr><td>&nbsp;</td></tr>
         <tr><td>
            Thank you for submitting your ad for, "#session.name#", under the listing section of "#get_CatName.name#".<br><br>
            <!---JM 4/09/2013 It will be up for auction starting #dateFormat(session.date_start)#, and will run for #session.duration# day<cfif #session.duration# GT 1>s</cfif>, closing on #dateFormat(session.date_end)#.<br><br>
            For your reference, the item number&nbsp;<a href="#varoot#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=0&from_search=0"><b>#itemnum#</b></a> has been
            automatically assigned to your item.  It would be a good idea to write this number down for future
            reference to your item.<br><br>--->
            
			Since we have to approve all new ads before the are posted, your ad will not be viewable until we have received payment and approved it for posting. 
         Use the PAY NOW button below to make your payment. If you would like to mail your payment , please send it to the following address  Equibidz.com , PO Box 101 New Horse Lane, Winner Only, Al 35806. Once we have received your payment, either by USPS or PayPal your ad will be approved and the auction will begin.
         It will be up for auction <!--- Jm 4/9/2013 starting #dateFormat(session.date_start)#,---> and will run for #session.duration# days<!--- Jm 4/09/2013 <cfif #session.duration# GT 1>s</cfif>--->, 
         <!---closing on #dateFormat(session.date_end)#.---> For your reference, the item number #itemnum# automatically assigned to your auctions ad.  
         Use this number for future reference to your auction ad.
         We hope you enjoy the new Equibidz.com and will come back often.
			
			
			A copy of this message has been e-mailed to you at <b>#get_Seller.email#</b> for your records.<br><br>
            Thank you for using our services,<br>
            <b>#COMPANY_NAME#</b><br><br><br>
         <!---</td></tr>--->
	  
	  <!---Add Paypal Button 04/11/2013--->
	  
	  <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="NSJ8EW63FSZ2Y">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>

	  </td></tr>
	  
	  <cfelse>
 	     <tr><td><font size=4><b>Duplicate Posting</b></font></td></tr>
	     <tr><td><hr size=1 color="616362" width=100%></td></tr>
         <tr><td><br><br></td></tr>
         <tr><td align="left">
         This item has been summitted. To check you may follow this link: <a href="#varoot#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=0&from_search=0">/listings/details/index.cfm?itemnum=#itemnum#</a><br><br>
         Thank you for using our services,<br>
         <b>#COMPANY_NAME#</b><br><br><br>
         </td></tr>
	  </cfif>
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
