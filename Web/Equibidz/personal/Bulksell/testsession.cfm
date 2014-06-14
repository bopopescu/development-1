<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">
<!--- Include session tracking template, mostly disabled, using hidden form fields and cookies --->
<cfinclude template="../../includes/session_include.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Test Checkbox</title>
</head>

<body>





<cfoutput>
cookie.user_id: #cookie.user_id#<br>
cookie.password: #cookie.password#
  #cookie.user_id#,
           category1  #session.category1#,<BR>
          category2   #session.category2#,<BR>
           <!--- title  '#session.title#',<BR> --->
            location '#session.location#',<BR>
           country  '#session.country#',<BR>
        pay_morder_ccheck     #session.pay_morder_ccheck#,<BR>
           pay_cod  #session.pay_cod#,<BR>
           pay_see_desc  #session.pay_see_desc#,<BR>
          pay_pcheck   #session.pay_pcheck#,<BR>
           pay_ol_escrow  #session.pay_ol_escrow#,<BR>
           pay_other  #session.pay_other#,<BR>
        pay_visa_mc     #session.pay_visa_mc#,<BR>
          pay_am_express   #session.pay_am_express#,<BR>
        pay_discover     #session.pay_discover#,<BR>
           ship_sell_pays  #session.ship_sell_pays#,<BR>
            ship_buy_pays_act #session.ship_buy_pays_act#,<BR>
           ship_see_desc  #session.ship_see_desc#,<BR>
       ship_buy_pays_fxd      #session.ship_buy_pays_fxd#,<BR>
      ship_international       #session.ship_international#,<BR>
       <!---  description     '#session.description#',<BR> --->
            desc_languages '#session.desc_languages#',<BR>
           picture  '#session.picture#',<BR>
           sound  '#session.sound#',<BR>
            quantity #session.quantity#,<BR>
			  minimum_bid     #session.minimum_bid#,<BR>
      <!---     maximum_bid   #session.maximum_bid#,<BR> --->
     increment        #session.increment#,<BR>
            increment_valu #session.increment_valu#,<BR>
           dynamic  #session.dynamic#,<BR>
            dynamic_valu #session.dynamic_valu#,<BR>
          reserve_bid   #session.reserve_bid#,<BR>
          <!--- bold_title   #session.bold_title#,<BR> --->
          featured   #session.featured#,<BR>
            featured_cat #session.featured_cat#,<BR>
           private  #session.private#,<BR>
       banner      #session.banner#,<BR>
        banner_line     '#session.banner_line#',<BR>
         studio    #session.studio#,<BR>
      featured_studio       #session.featured_studio#,<BR>
        picture_studio     '#session.picture_studio#',<BR>
         sound_studio    '#session.sound_studio#',<BR>
       date_start     #createODBCDateTime (session.date_start)#,<BR>
         date_end    #createODBCDateTime (session.date_end)#,<BR>
     <!--- itemnum        #session.itemnum#,<BR> --->
     billmeth        '#session.billmeth#',<BR>
           remote_ip  '#session.remote_ip#',<BR>
      auction_type       '#session.auction_type#',<BR>
      auction_mode       '#session.auction_mode#',<BR>
     auto_relist        #session.auto_relist#,<BR>
					<!--- orig_cost	 #session.orig_cost#)<BR> --->
</cfoutput>











	

</body>
</html>
