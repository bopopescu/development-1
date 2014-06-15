<!--- SourceSafe $Logfile: /Visual-Auction-4/sell/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
<cfelse>
   <cflocation url="#VAROOT#/login.cfm?login=1" addtoken="No">
</cfif>

<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif #trim(submit)# is "Back">
   <cflocation url="my_auctions.cfm?my_No=17">
</cfif>

<!-------------upload image #1---------------->
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","fullsize_thumbs")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture1 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture1#")>
        <cffile action="rename"
          SOURCE = "#directory##picture1#"  
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture1 = "#itemnum#.jpg">
</cfif>
<!-------------upload image #2---------------->
<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","fullsize_thumbs1")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture2 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture2#")>
        <cffile action="rename"
          SOURCE = "#directory##picture2#"  
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture2 = "#itemnum#.jpg">
</cfif>
<!-------------upload image #3---------------->
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","fullsize_thumbs2")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture3 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture3#")>
        <cffile action="rename"
          SOURCE = "#directory##picture3#"  
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture3 = "#itemnum#.jpg">
</cfif>
<!-------------upload image #4---------------->
<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","fullsize_thumbs3")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture4 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture4#")>
        <cffile action="rename"
          SOURCE = "#directory##picture4#"  
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture4 = "#itemnum#.jpg">
</cfif>
<!-------------upload image #5---------------->
<cfif isdefined("form.picture5") and form.picture5 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","fullsize_thumbs4")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture5"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture5"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture5 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture5#")>
        <cffile action="rename"
          SOURCE = "#directory##picture5#"  
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture5 = "#itemnum#.jpg">      
</cfif>
<!-------------upload image #6---------------->
<cfif isdefined("form.picture6") and form.picture6 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","fullsize_thumbs5")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture6"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture6"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture6 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture6#")>
        <cffile action="rename"
          SOURCE = "#directory##picture6#"  
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture6 = "#itemnum#.jpg">
</cfif>

<cfif isDefined("pure_breed")>
    <cfset pure_breed = #pure_breed#>
<cfelse>
    <cfset pure_breed = 0>
</cfif>
<cfif isDefined("pay_morder_ccheck")>
    <cfset pay_morder_ccheck = 1>
<cfelse>
    <cfset pay_morder_ccheck = 0>
</cfif>
<cfif isDefined("pay_am_express")>
    <cfset pay_am_express = 1>
<cfelse>
    <cfset pay_am_express = 0>
</cfif>
<cfif isDefined("pay_cod")>
    <cfset pay_cod = 1>
<cfelse>
    <cfset pay_cod = 0>
</cfif>
<cfif isDefined("pay_discover")>
    <cfset pay_discover = 1>
<cfelse>
    <cfset pay_discover = 0>
</cfif>
<cfif isDefined("pay_pcheck")>
    <cfset pay_pcheck = 1>
<cfelse>
    <cfset pay_pcheck = 0>
</cfif>
<cfif isDefined("pay_ol_escrow")>
    <cfset pay_ol_escrow = 1>
<cfelse>
    <cfset pay_ol_escrow = 0>
</cfif>
<cfif isDefined("pay_visa_mc")>
    <cfset pay_visa_mc = 1>
<cfelse>
    <cfset pay_visa_mc = 0>
</cfif>
<cfif isDefined("pay_other")>
    <cfset pay_other = 1>
<cfelse>
    <cfset pay_other = 0>
</cfif>
<cfif isDefined("pay_see_desc")>
    <cfset pay_see_desc = 1>
<cfelse>
    <cfset pay_see_desc = 0>
</cfif>
<cfif isDefined("ship_sell_pays")>
    <cfset ship_sell_pays = 1>
<cfelse>
    <cfset ship_sell_pays = 0>
</cfif>
<cfif isDefined("ship_buy_pays_act")>
    <cfset ship_buy_pays_act = 1>
<cfelse>
    <cfset ship_buy_pays_act = 0>
</cfif>
<cfif isDefined("ship_buy_pays_fxd")>
    <cfset ship_buy_pays_fxd = 1>
<cfelse>
    <cfset ship_buy_pays_fxd = 0>
</cfif>
<cfif isDefined("ship_international")>
    <cfset ship_international = 1>
<cfelse>
    <cfset ship_international = 0>
</cfif>
<cfif isDefined("ship_see_desc")>
    <cfset ship_see_desc = 1>
<cfelse>
    <cfset ship_see_desc = 0>
</cfif>

<cfif #trim(submit)# is "Save">
    <cfoutput>
    <cfif #buynow_price# EQ 0>
       <cfset #buynow_price# = #reserve_bid#>
    </cfif>
    <cfset #start_time# = "#start_time##start_time_s#">
    <cfset #start_hour# = #timeFormat (start_time, 'H')#>
    <cfset #start_min# = #timeFormat (start_time, 'm')#>
    <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
    <cfset #date_end# = #dateAdd ("d", "#selected_duration#", date_start)#>
    <cfset #dob# = #createDateTime (dob_year, dob_month, start_day, start_hour, start_min, 0)#>    
    <cfquery username="#db_username#" password="#db_password#" name="update_item" datasource="#DATASOURCE#">
        UPDATE items
         SET category = 'S',
             category1 = #category1#,
             list_type = '#selected_list_type#',
             name = '#name#',
             title = '#name#',
             registration = '#registration#',
             sire = '#sire#',
             dam = '#dam#',
             pri_breed = '#selected_pri_breed#',
             sec_breed = '#selected_sec_breed#',
             pure_breed = #pure_breed#,
             bloodline = '#selected_bloodline#',             
             year_foaled = 0,
             color = '#selected_color#',
             dob = #dob#,
             sex = '#selected_sex#',
             height = '#selected_height#',
             discipline = '#selected_discipline#',
             experience = '#selected_experience#',
             attributes = '#selected_attributes#',
             temperament = '#selected_temperament#',
             nominations = '#nominations#',
             comments = '#comments#',
             performance = '#performance#',
             produce = '#produce#',
             sire_performance = '#sire_performance#',
             dam_performance = '#dam_performance#',
             stallion_incentive = '#stallion_incentive#',
             earnings = #earnings#,
             weblink = '#weblink#',
             ped4 ='#ped4#',
             ped5 = '#ped5#',
             ped6 = '#ped6#',
             ped7 = '#ped7#',
             ped8 = '#ped8#',
             ped9 = '#ped9#',
             ped10 = '#ped10#',
             ped11 = '#ped11#',
             ped12 = '#ped12#',
             ped13 = '#ped13#',
             ped14 = '#ped14#',
             ped15 = '#ped15#',
             isfoal = '#selected_isfoal#',
             last_bred_date = '#last_bred_date#',
             regular_fee = #regular_fee#,
             shipped_semen = '#selected_shipped_semen#',
             frozen_semen = '#selected_frozen_semen#',
             shipped_semen_fee = #shipped_semen_fee#,
             intl_shipped_semen_fee = #intl_shipped_semen_fee#,
             counter_fee = #counter_fee#,
             booking_fee = #booking_fee#,
             mare_care_fee = #mare_care_fee#,
 		     <cfif #picture1# NEQ "">picture1 = '#itemnum#.jpg',</cfif>
			 <cfif #picture2# NEQ "">picture2 = '#itemnum#.jpg',</cfif>
			 <cfif #picture3# NEQ "">picture3 = '#itemnum#.jpg',</cfif>
			 <cfif #picture4# NEQ "">picture4 = '#itemnum#.jpg',</cfif>
			 <cfif #picture5# NEQ "">picture5 = '#itemnum#.jpg',</cfif>
			 <cfif #picture6# NEQ "">picture6 = '#itemnum#.jpg',</cfif>
             youtube = '#youtube#',
             location = '#selected_location#',
             city = '#city#',
             state = '#state#',
             province = '#province#',
             country = '#country#',
             zipcode = '#zipcode#',
             date_start = #createODBCDateTime (date_start)#,
             date_end = #createODBCDateTime (date_end)#,
             duration = #selected_duration#,
             auto_relist = #selected_auto_relist#,
             minimum_bid = #minimum_bid#,
             maximum_bid = 0,
             reserve_bid = #reserve_bid#,
             buynow_price = #buynow_price#,
             increment_valu = #selected_increment_valu#,
             pay_morder_ccheck = #pay_morder_ccheck#,
             pay_am_express = #pay_am_express#,
             pay_cod = #pay_cod#,
             pay_discover = #pay_discover#,
             pay_pcheck = #pay_pcheck#,
             pay_ol_escrow = #pay_ol_escrow#,
             pay_visa_mc = #pay_visa_mc#,
             pay_other = #pay_other#,
             pay_see_desc = #pay_see_desc#,
             ship_sell_pays = #ship_sell_pays#,
             ship_buy_pays_act = #ship_buy_pays_act#,
             ship_buy_pays_fxd = #ship_buy_pays_fxd#,
             ship_international = #ship_international#,
             ship_see_desc = #ship_see_desc#,
             shipping_fee = #shipping_fee#,
             salestax = #salestax#,
             terms = '#terms#'
        WHERE itemnum = #itemnum#     
    </cfquery>
    </cfoutput>
    <cflocation url="my_auctions.cfm?my_No=17">
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_item_info" datasource="#DATASOURCE#">
    SELECT * , (SELECT nickname FROM users WHERE items.user_id = users.user_id) AS nickname           		  
    FROM items
    WHERE itemnum = #itemnum#
</cfquery> 
<cfset category1 = #get_item_info.category1#>
<cfset selected_item = #get_item_info.itemnum#>
<cfset auction_type = #get_item_info.auction_type#>
<cfset auction_mode = #get_item_info.auction_mode#>    
<cfset nickname = #get_item_info.nickname#>
<cfset title = #get_item_info.title#>
<cfset name = #get_item_info.name#>
<cfset registration = #get_item_info.registration#>
<cfset sire = #get_item_info.sire#>
<cfset dam = #get_item_info.dam#>
<cfset pri_breed = #get_item_info.pri_breed#>
<cfset sec_breed = #get_item_info.sec_breed#>
<cfset pure_breed = #get_item_info.pure_breed#>
<cfset bloodline = #get_item_info.bloodline#>    
<cfset year_foaled = #get_item_info.year_foaled#>
<cfset color = #get_item_info.color#>
<cfset dob = #get_item_info.dob#>
<cfset sex = #get_item_info.sex#>
<cfset height = #get_item_info.height#>
<cfset discipline = #get_item_info.discipline#>
<cfset experience = #get_item_info.experience#>
<cfset attributes = #get_item_info.attributes#>
<cfset temperament = #get_item_info.temperament#>
<cfset nominations = #get_item_info.nominations#>
<cfset location = #get_item_info.location#>
<cfset city = #get_item_info.city#>
<cfset state = #get_item_info.state#>
<cfset province = #get_item_info.province#>
<cfset country = #get_item_info.country#>
<cfset zipcode = #get_item_info.zipcode#>
<cfset comments = #get_item_info.comments#>
<cfset isfoal = #get_item_info.isfoal#>
<cfset last_bred_date = #get_item_info.last_bred_date#>
<cfset regular_fee = #get_item_info.regular_fee#>
<cfset shipped_semen = #get_item_info.shipped_semen#>
<cfset frozen_semen = #get_item_info.frozen_semen#>
<cfset shipped_semen_fee = #get_item_info.shipped_semen_fee#>
<cfset intl_shipped_semen_fee = #get_item_info.intl_shipped_semen_fee#>
<cfset booking_fee = #get_item_info.booking_fee#>
<cfset counter_fee = #get_item_info.counter_fee#>
<cfset mare_care_fee = #get_item_info.mare_care_fee#>
<cfset performance = #get_item_info.performance#>
<cfset produce = #get_item_info.produce#>
<cfset sire_performance = #get_item_info.sire_performance#>
<cfset dam_performance = #get_item_info.dam_performance#>
<cfset stallion_incentive = #get_item_info.stallion_incentive#>
<cfset date_start = #get_item_info.date_start#>
<cfset date_end = #get_item_info.date_end#>
<cfset duration = #get_item_info.duration#>
<cfset auto_relist = #get_item_info.auto_relist#>
<cfset minimum_bid = #get_item_info.minimum_bid#>
<cfset maximum_bid = #get_item_info.maximum_bid#>
<cfset reserve_bid = #get_item_info.reserve_bid#>
<cfset increment_valu = #get_item_info.increment_valu#>
<cfset buynow_price = #get_item_info.buynow_price#>
<cfset shipping_fee = #get_item_info.shipping_fee#>
<cfset salestax = #get_item_info.salestax#>
<cfset picture1 = #get_item_info.picture1#>
<cfset picture2 = #get_item_info.picture2#>
<cfset picture3 = #get_item_info.picture3#>
<cfset picture4 = #get_item_info.picture4#>
<cfset picture5 = #get_item_info.picture5#>
<cfset picture6 = #get_item_info.picture6#>
<cfset youtube = #get_item_info.youtube#>
<cfset status = #get_item_info.status#>
<cfset category = #get_item_info.category#>
<cfset list_title = #get_item_info.list_title#>
<cfset list_type = #get_item_info.list_type#>    
<cfset selected_user = #get_item_info.user_id#>
<cfset earnings = #get_item_info.earnings#>
<cfset weblink = #get_item_info.weblink#>
<cfset ped4 = #get_item_info.ped4#>
<cfset ped5 = #get_item_info.ped5#>
<cfset ped6 = #get_item_info.ped6#>
<cfset ped7 = #get_item_info.ped7#>
<cfset ped8 = #get_item_info.ped8#>
<cfset ped9 = #get_item_info.ped9#>
<cfset ped10 = #get_item_info.ped10#>
<cfset ped11 = #get_item_info.ped11#>
<cfset ped12 = #get_item_info.ped12#>
<cfset ped13 = #get_item_info.ped13#>
<cfset ped14 = #get_item_info.ped14#>
<cfset ped15 = #get_item_info.ped15#>
<cfset pay_morder_ccheck = #get_item_info.pay_morder_ccheck#>
<cfset pay_am_express = #get_item_info.pay_am_express#>
<cfset pay_cod = #get_item_info.pay_cod#>
<cfset pay_discover = #get_item_info.pay_discover#>
<cfset pay_pcheck = #get_item_info.pay_pcheck#>
<cfset pay_ol_escrow = #get_item_info.pay_ol_escrow#>
<cfset pay_visa_mc = #get_item_info.pay_visa_mc#>
<cfset pay_other = #get_item_info.pay_other#>
<cfset pay_see_desc = #get_item_info.pay_see_desc#>
<cfset ship_sell_pays = #get_item_info.ship_sell_pays#>
<cfset ship_buy_pays_act = #get_item_info.ship_buy_pays_act#>
<cfset ship_buy_pays_fxd = #get_item_info.ship_buy_pays_fxd#>
<cfset ship_international = #get_item_info.ship_international#>
<cfset ship_see_desc = #get_item_info.ship_see_desc#>
<cfset terms = #get_item_info.terms#>

<cfquery username="#db_username#" password="#db_password#" name="get_breed" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'breed'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_bloodline" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'bloodline'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'color'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_height" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'height'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_discipline" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'discipline'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_experience" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'experience'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_attributes" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'attributes'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_temperament" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'temperament'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_location" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'location'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_list_type" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'list_type'
   ORDER BY pair ASC
</cfquery>
<cfif isDefined("cat")>
   <cfset cat = #cat#>
<cfelse>
   <cfset cat = "S">
</cfif>    

<html>
<head>
   <title>Equibidz-Post Auction</title>
   <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
</head>

<script language="JavaScript">
	function get_terms(vShow){
		if (vShow == 0) {
		    tr = document.getElementById( "tr1" );
		    tr.style.display = "table-row";
  	        tr = document.getElementById( "tr2" );
	        tr.style.display = "none";
			
		} else {
			tr = document.getElementById( "tr1" );
			tr.style.display = "none";
			tr = document.getElementById( "tr2" );
			tr.style.display = "table-row";		
		}	
        return true;        
	}

	function val_entries() {
        var xAuction = 0;
        var xname = document.listForm.name.value;
        var xregistration = document.listForm.registration.value;
        var xcity = document.listForm.city.value;
        //var xyear_foaled = document.listForm.year_foaled.value;
        var xreserve_bid = document.listForm.reserve_bid.value;
        var xminimum_bid = document.listForm.minimum_bid.value;
        
        var pic1 = document.listForm.picture1.value;
        var pic2 = document.listForm.picture2.value;
        var pic3 = document.listForm.picture3.value;
        var pic4 = document.listForm.picture4.value;
        var pic5 = document.listForm.picture5.value;
        var pic6 = document.listForm.picture6.value;         
        var pay1 = document.listForm.pay_morder_ccheck;
        var pay2 = document.listForm.pay_am_express;
        var pay3 = document.listForm.pay_cod;
        var pay3 = document.listForm.pay_discover;
        var pay4 = document.listForm.pay_pcheck;
        var pay5 = document.listForm.pay_ol_escrow;
        var pay6 = document.listForm.pay_visa_mc;
        var pay7 = document.listForm.pay_other;
        var pay8 = document.listForm.pay_see_desc;
        var shp1 = document.listForm.ship_sell_pays;
        var shp2 = document.listForm.ship_buy_pays_act;
        var shp3 = document.listForm.ship_buy_pays_fxd;
        var shp4 = document.listForm.ship_international;
        var shp5 = document.listForm.ship_see_desc;

        if (xname == "") {
           alert("Please input Horse Name!");
           return false;        
        } 
        if (xregistration == "") {
           alert("Please input Registration Number!");
           return false;        
        } 
        if (xcity == "") {
           alert("Please input City!");
           return false;        
        } 
        //if (xyear_foaled == "") {
        //   alert("Please input Year Foaled!");
        //   return false;        
        //} 
        if (xreserve_bid == 0) {
           alert("Please input Reserve Bid!");
           return false;        
        } 
        if (xAuction == 0) {
           var xminimum_bid = document.listForm.minimum_bid.value;
           if (xminimum_bid == 0) {
              alert("Please input Minimuum Bid!");
              return false;        
           } 
           if (parseInt(xreserve_bid) < parseInt(xminimum_bid)) {
              alert("Reserve Bid must be greater than Minimum Bid  in a REGULAR Auction!");
              return false;        
           }
        } else {
           var xmaximum_bid = document.listForm.maximum_bid.value;
           if (xmaximum_bid == 0) {
              alert("Please input Maximum Bid!");
              return false;        
           } 
           if (parseInt(xreserve_bid) > parseInt(xmaximum_bid)) {
              alert("Reserve Bid must be less than Maximum Bid in a REVERSE Auction!");
              return false;        
           }
           
        } 
        if (pay1.checked || pay2.checked || pay3.checked || pay4.checked || pay5.checked || pay6.checked || pay7.checked || pay8.checked) {
        } else {
           alert ("You must select at least one payment method.");                
           return false;
        }	     
         
        if (shp1.checked || shp2.checked || shp3.checked || shp4.checked || shp5.checked) {
        } else {
           alert ("You must select at least one shipping arrangement.");                
           return false;
        }	     
    }		
</script>

<cfinclude template="../includes/menu_bar.cfm">
<body>
<cfoutput>
<table border='0' width="100%" style="background-image: url('#VAROOT#/images/bg_table.jpg')" cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">	
	<!--- Start: Main Body --->
	<div align="center">
	<table border=0 width=800 cellpadding="0" cellspacing="0">
	<form name="listForm" action="edit_item.cfm" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="itemnum" value="#itemnum#">
	    <tr><td colspan=3>&nbsp;</td></tr>
	    <tr><td colspan=3><font size=4><b>Edit Auction Item</b></font></td></tr>
		<tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
		<tr>
		   <td colspan=3><font size=3>
              This page allows you to edit an item up for online auction.  Please
              fill out the following form to place your item(s) up for auction, remembering
              to be as accurate and honest as possible when describing your items, as set
              forth in the <a href="../terms.cfm">Terms & Conditions</a>.  You must be a <a href="#VAROOT#/registration/index.cfm">registered user</a> 
              to sell an item.
           </font></td>
		</tr>
	    <tr><td colspan=3>&nbsp;</td></tr>
		<tr><td><font size=3><b>* Indicates a required item; all others are optional.</b></font></td></tr>
		<tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
	    <tr><td colspan=3>&nbsp;</td></tr>
	    <tr><td>
 	    <table border=0 width=800 cellpadding="2" cellspacing="2">      
           <tr>
               <td><font size=3><b>*Listing Title:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#category1#">
               </td>
           </tr>
           <tr>
               <td><font size=3><b>*Listing Type:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_list_type">
                   <cfloop query="get_list_type">
                    <option value="#pair#"<cfif #list_type# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>            
           <tr><td><font size=3><b>*Horse Name:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="name" value="#name#" size=40></td> 
           </tr>
           <tr><td><font size=3><b>Registration Number:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="registration" value="#registration#" size=30></td> 
           </tr>
           <tr><td><font size=3><b>Lifetime Earnings:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="earnings" value="#earnings#" size=15>&nbsp;<font size=3>in USD</font></td> 
           </tr>
           <tr>
               <td><font size=3><b>Primary Breed:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_pri_breed">
                   <cfloop query="get_breed">
                    <option value="#pair#"<cfif #pri_breed# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=3><b>Secondary Breed:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_sec_breed">
                   <cfloop query="get_breed">
                    <option value="#pair#"<cfif #sec_breed# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=3><b>Pure Bred:</b></font></td>
              <td>&nbsp;</td>
              <td><input type="checkbox" name="pure_breed" value="1"<cfif #pure_breed# is "1"> checked</cfif>><font size=3>&nbsp;Cheked -  Pure Bred</font></td> 
           </tr>
           <tr style="display:none;">
               <td><font size=3><b>Bloodline:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_bloodline">
                   <cfloop query="get_bloodline">
                    <option value="#pair#"<cfif #bloodline# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr style="display:none;"><td><font size=3><b>Year Foaled:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="year_foaled" value="#year_foaled#" size=10></td> 
           </tr>
           <tr>
               <td><font size=3><b>Color:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_color">
                   <cfloop query="get_color">
                    <option value="#pair#"<cfif #color# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=3><b>Date of Birth:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                   <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfset #the_month# = #datePart ("m", "#dob#")#>
                      <cfset #the_year# = #datePart ("yyyy", "#dob#")#>
                      <td>
                         <select name="dob_month">
                          <option value="1"<cfif #the_month# is "1"> selected</cfif>>Jan</option>
                          <option value="2"<cfif #the_month# is "2"> selected</cfif>>Feb</option>
                          <option value="3"<cfif #the_month# is "3"> selected</cfif>>Mar</option>
                          <option value="4"<cfif #the_month# is "4"> selected</cfif>>Apr</option>
                          <option value="5"<cfif #the_month# is "5"> selected</cfif>>May</option>
                          <option value="6"<cfif #the_month# is "6"> selected</cfif>>Jun</option>
                          <option value="7"<cfif #the_month# is "7"> selected</cfif>>Jul</option>
                          <option value="8"<cfif #the_month# is "8"> selected</cfif>>Aug</option>
                          <option value="9"<cfif #the_month# is "9"> selected</cfif>>Sep</option>
                          <option value="10"<cfif #the_month# is "10"> selected</cfif>>Oct</option>
                          <option value="11"<cfif #the_month# is "11"> selected</cfif>>Nov</option>
                          <option value="12"<cfif #the_month# is "12"> selected</cfif>>Dec</option>
                         </select></td>
                      <td><input name="dob_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
                     </tr>
                   </table>
                 </td>  
           </tr>
           <tr>
               <td><font size=3><b>Sex:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_sex">
                      <option value="S"<cfif #sex# is "S"> selected</cfif>>Stallion</option>
                      <option value="M"<cfif #sex# is "M"> selected</cfif>>Mare</option>
                      <option value="G"<cfif #sex# is "G"> selected</cfif>>Gelding</option>
                     </select>
               </td>
           </tr>
           <tr><td><font size=3><b>Height:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                 <select name="selected_height">
                   <cfloop query="get_height">
                    <option value="#pair#"<cfif #height# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td> 
           </tr>
           <tr>
               <td><font size=3><b>Discipline:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_discipline">
                   <cfloop query="get_discipline">
                    <option value="#pair#"<cfif #discipline# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=3><b>Experience:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_experience">
                   <cfloop query="get_experience">
                    <option value="#pair#"<cfif #experience# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=3><b>Attributes:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_attributes">
                   <cfloop query="get_attributes">
                    <option value="#pair#"<cfif #attributes# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=3><b>Temperament:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_temperament">
                   <cfloop query="get_temperament">
                    <option value="#pair#"<cfif #temperament# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>           
           <tr><td><font size=3><b>Nominations & Enrollments:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="nominations" rows=3 cols=50>#nominations#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Comments:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="comments" rows=3 cols=50>#comments#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Performance Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="performance" rows=3 cols=50>#performance#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Produce Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="produce" rows=3 cols=50>#produce#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Sire's Performace<br>and Produce Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="sire_performance" rows=3 cols=50>#sire_performance#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Dam's Performance<br>and Produce Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="dam_performance" rows=3 cols=50>#dam_performance#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Incentive Enrollment<br>Program:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="stallion_incentive" rows=3 cols=50>#stallion_incentive#</textarea></td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>            
           <tr><td valign="top"><font size=3><b>Pedigree:</b></font></td>
               <td>&nbsp;</td>              
               <td valign="top">
                  <table cellspacing=1 cellpadding=1 border=0>
                    <tr>
                    <td valign="middle">
                       Sire:&nbsp;<input type="text" name="sire" value="#sire#" size=23><br>
                    </td>
                    <td valign="middle">
                       <input type="text" name="ped4" value="#ped4#" size=23><br><br>
                       <input type="text" name="ped5" value="#ped5#" size=23><br>
                    </td>
                    <td valign="top">
                       <input type="text" name="ped8" value="#ped8#" size=23><br>
                       <input type="text" name="ped9" value="#ped9#" size=23><br>
                       <input type="text" name="ped10" value="#ped10#" size=23><br>
                       <input type="text" name="ped11" value="#ped11#" size=23><br>
                    </td>
                    </tr>
                  </table>  
                  <br>
                  <table cellspacing=1 cellpadding=1 border=0>
                    <tr>
                    <td valign="middle">
                       Dam:&nbsp;<input type="text" name="dam" value="#dam#" size=23>
                    </td>
                    <td valign="middle">
                       <input type="text" name="ped6" value="#ped6#" size=23><br><br>
                       <input type="text" name="ped7" value="#ped7#" size=23><br>
                    </td>
                    <td valign="top">
                       <input type="text" name="ped12" value="#ped12#" size=23><br>
                       <input type="text" name="ped13" value="#ped13#" size=23><br>
                       <input type="text" name="ped14" value="#ped14#" size=23><br>
                       <input type="text" name="ped15" value="#ped15#" size=23><br>
                    </td>
                    </tr>
                  </table>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr>
               <td align="left"><font size=3><b>If this listing is for MARE<br>will need this additional<br>information:</b></font></td>
               <td>&nbsp;</td>
               <td align="left" valign="top">
               <table width="100%" cellspacing=0 cellpadding=0>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;In Foal:</font></td>
                   <td>
                     <select name="selected_isfoal">
                      <option value="Y"<cfif #isfoal# is "Y"> selected</cfif>>Yes</option>
                      <option value="N"<cfif #isfoal# is "N"> selected</cfif>>No</option>
                    </select>
                  </td>
                  <td width=150>&nbsp;</td>
                 </tr>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;Last Bred Date:</font></td>
                   <td><input type="text" name="last_bred_date" value="#last_bred_date#" size=20></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
               </table>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr><td align="left" valign="top"><font size=3><b>If this listing is for<br>STALLION STUD SERVICE<br>will need this additional<br>information:</b></font></td>
               <td>&nbsp;</td>
               <td align="left" valign="top">
               <table width="100%" cellspacing=0 cellpadding=0>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;Shipped Semen:</font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_shipped_semen">
                      <option value="A"<cfif #shipped_semen# is "A"> selected</cfif>>Available</option>
                      <option value="N"<cfif #shipped_semen# is "N"> selected</cfif>>Not Available</option>
                    </select>
                   </td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;Frozen Semen:</font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_frozen_semen">
                      <option value="A"<cfif #frozen_semen# is "A"> selected</cfif>>Available</option>
                      <option value="N"<cfif #frozen_semen# is "N"> selected</cfif>>Not Available</option>
                    </select>
                   </td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Regualar Fee:</font></td>
                   <td>&nbsp;</td>                   
                   <td><input type="text" name="regular_fee" value="#regular_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Shipped Semen Fee:</font></td>
                   <td>&nbsp;</td>                   
                   <td><input type="text" name="shipped_semen_fee" value="#shipped_semen_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Int'l Shipped Semen Fee:</font></td>
                   <td>&nbsp;</td>                   
                   <td><input type="text" name="intl_shipped_semen_fee" value="#intl_shipped_semen_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Counter-to-Counter Fee:</font></td>
                   <td>&nbsp;</td>                   
                   <td><input type="text" name="counter_fee" value="#counter_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Booking Fee:</font></td>
                   <td>&nbsp;</td>                   
                   <td><input type="text" name="booking_fee" value="#booking_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Mare Care per day:</font></td>
                   <td>&nbsp;</td>                   
                   <td><input type="text" name="mare_care_fee" value="#mare_care_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
                   <td width=150>&nbsp;</td>
                 </tr>
               </table>
               </td>
           </tr>    
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr><td colspan=3><font size=2>Only JPG (not progressive) and GIF images are supported. (Height:300 by Width:380)</font></td></tr>
           <cfif #picture1# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs/#picture1#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 1:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture1" type="file" value="#picture1#" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture2# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs1/#picture2#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 2:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture2" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture3# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs2/#picture3#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 3:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture3" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture4# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs3/#picture4#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 4:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture4" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture5# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs4/#picture5#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 5:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture5" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture6# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs5/#picture6#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 6:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture6" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <tr><td><font size=3><b>Youtube/Video:</b></font><br><font size=1>(Paste your Youtube<br>embedded code here)</font><br></td>
               <td>&nbsp;</td>                   
               <td><textarea name="youtube" rows=3 cols=50>#youtube#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Web Link:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="weblink" value="#weblink#" size=40>&nbsp;<font size=3>(Horse Website Link)</font></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr>
               <td><font size=3><b>*Location:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_location">
                   <cfloop query="get_location">
                    <option value="#pair#"<cfif #location# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=3><b>*City:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="city" value="#city#" size=30></td> 
           </tr>
           <tr>
               <td><font size=3><b>*State:</font></td>
               <td>&nbsp;</td>
               <td>
          		  <CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                  SELECTNAME="state"
                  SELECTED="#state#"
                  MULTIPLE="0"
                  SIZE="1">
               </td>
           </tr>
           <tr><td><font size=3><b>Province (Non US):</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="province" value="#province#" size=30></td> 
           </tr>
           <tr>
               <td><font size=3><b>*Country:</font></td>
               <td>&nbsp;</td>
               <td>
                  <CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1">
               </td>
           </tr>
           <tr><td><font size=3><b>Zip Code:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="zipcode" value="#zipcode#" size=10>&nbsp;(US Only)</td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr style="display:none;">
               <td><font size=3><b>*Auction Type:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <select name="selected_auction_type">
                      <option value="E"<cfif #auction_type# is "E"> selected</cfif>>English (Normal)</option>
                      <option value="D"<cfif #auction_type# is "D"> selected</cfif>>Dutch</option>
                      <option value="Y"<cfif #auction_type# is "Y"> selected</cfif>>Yankee</option>
                      <option value="V"<cfif #auction_type# is "V"> selected</cfif>>Vickrey</option>
                    </select>
               </td>
           </tr>
           <tr style="display:none;">
               <td><font size=3><b>*Auction Mode:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
	                <select name="selected_auction_mode" onChange="getAuctionMode( this.value)">
                      <option value="0"<cfif #auction_mode# is "0"> selected</cfif>>Normal  - Seller's Auction </option>
                      <option value="1"<cfif #auction_mode# is "1"> selected</cfif>>Reverse - Buyer's Auction </option>
                    </select>
                    <cfif #auction_mode# is 0>
                       <img src = "../images/r_reverse_blank.gif" name="theFlag" width=22 height=17 border=0">
                    <cfelse>
                       <img src = "../images/r_reverse.gif" name="theFlag" width=22 height=17 border=0">
                    </cfif>              
               </td>
           </tr>
           <tr><td><font size=3><b>*Start Date:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                   <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfset #the_month# = #datePart ("m", "#date_start#")#>
                      <cfset #the_day# = #datePart ("d", "#date_start#")#>
                      <cfset #the_year# = #datePart ("yyyy", "#date_start#")#>
                      <cfset #the_time# = #timeFormat ("#date_start#", 'hh:mm')#>
                      <cfset #the_time_s# = #timeFormat ("#date_start#", 'tt')#>
                      <td>
                       <select name="start_month">
                        <option value="1"<cfif #the_month# is "1"> selected</cfif>>Jan</option>
                        <option value="2"<cfif #the_month# is "2"> selected</cfif>>Feb</option>
                        <option value="3"<cfif #the_month# is "3"> selected</cfif>>Mar</option>
                        <option value="4"<cfif #the_month# is "4"> selected</cfif>>Apr</option>
                        <option value="5"<cfif #the_month# is "5"> selected</cfif>>May</option>
                        <option value="6"<cfif #the_month# is "6"> selected</cfif>>Jun</option>
                        <option value="7"<cfif #the_month# is "7"> selected</cfif>>Jul</option>
                        <option value="8"<cfif #the_month# is "8"> selected</cfif>>Aug</option>
                        <option value="9"<cfif #the_month# is "9"> selected</cfif>>Sep</option>
                        <option value="10"<cfif #the_month# is "10"> selected</cfif>>Oct</option>
                        <option value="11"<cfif #the_month# is "11"> selected</cfif>>Nov</option>
                        <option value="12"<cfif #the_month# is "12"> selected</cfif>>Dec</option>
                       </select></td>
                      <td><input name="start_day" type="text" size=3 maxlength=2 value="#the_day#">,</td>
                      <td><input name="start_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
                      <td><font face="helvetica" size=3>&nbsp;at&nbsp;</font></td>
                      <td><input name="start_time" type="text" size=5 maxlength=5 value="#the_time#"></td>
                      <td>
                       <select name="start_time_s">
                        <option value="AM"<cfif #the_time_s# is "AM"> selected</cfif>>AM</option>
                        <option value="PM"<cfif #the_time_s# is "PM"> selected</cfif>>PM</option>
                       </select>
                      </td>
                     </tr>
                   </table>
                 </td>  
           </tr>
           <tr>
               <td><font size=3><b>*Auction Duration:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_duration">
                      <option value=30<cfif #duration# is 30> selected</cfif>>30 Days</option>
                      <option value=60<cfif #duration# is 60> selected</cfif>>60 Days</option>
                      <option value=90<cfif #duration# is 90> selected</cfif>>90 Days</option>
                      <option value=120<cfif #duration# is 120> selected</cfif>>120 Days</option>
                      <option value=150<cfif #duration# is 150> selected</cfif>>130 Days</option>
                      <option value=180<cfif #duration# is 180> selected</cfif>>150 Days</option>
                    </select>
               </td>
           </tr>
           <tr>
               <td><font size=3><b>Auto Relist:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_auto_relist">
                      <option value=0<cfif #auto_relist# is 0> selected</cfif>>Do not Relist</option>
                      <option value=1<cfif #auto_relist# is 1> selected</cfif>>(1) Time</option>
                      <option value=2<cfif #auto_relist# is 2> selected</cfif>>(2) Times</option>
                      <option value=3<cfif #auto_relist# is 3> selected</cfif>>(3) Times</option>
                      <option value=4<cfif #auto_relist# is 4> selected</cfif>>(4) Times</option>
                      <option value=5<cfif #auto_relist# is 5> selected</cfif>>(5) Times</option>
                      <option value=6<cfif #auto_relist# is 6> selected</cfif>>(6) Time</option>
                      <option value=7<cfif #auto_relist# is 7> selected</cfif>>(7) Times</option>
                      <option value=8<cfif #auto_relist# is 8> selected</cfif>>(8) Times</option>
                      <option value=9<cfif #auto_relist# is 9> selected</cfif>>(9) Times</option>
                      <option value=10<cfif #auto_relist# is 10> selected</cfif>>(10) Times</option>
                    </select>&nbsp;<font size=3>(Times to Relist if not sold)</font>
               </td>
           </tr>           
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr>
               <td><font size=3><b>*Unit Price:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="buynow_price" value="#buynow_price#" size=10>&nbsp;<font size=3>in USD</td> 
           </tr>
           <tr><td><font size=3><b>*Reserve Bid:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="reserve_bid" value="#reserve_bid#" size=10>&nbsp;<font size=3>in USD</td> 
           </tr>
           <tr>
               <td><font size=3><b>*Minimum Bid:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="minimum_bid" value="#minimum_bid#" size=10>&nbsp;<font size=3>in USD</td> 
           </tr>
           <tr style="display: none;">
               <td><font size=3><b>*Maximum Bid:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="maximum_bid" value="#maximum_bid#" size=10>&nbsp;<font size=3>in USD</td> 
           </tr>
           <tr><td><font size=3><b>*Bid Increment:</b></font></td>
               <td>&nbsp;</td>                   
                   <td>
                     <select name="selected_increment_valu">
                      <option value=1.00<cfif #increment_valu# is 1.00> selected</cfif>>1.00</option>
                      <option value=2.00<cfif #increment_valu# is 2.00> selected</cfif>>2.00</option>
                      <option value=5.00<cfif #increment_valu# is 5.00> selected</cfif>>5.00</option>
                      <option value=10.00<cfif #increment_valu# is 10.00> selected</cfif>>10.00</option>
                      <option value=20.00<cfif #increment_valu# is 20.00> selected</cfif>>20.00</option>
                      <option value=50.00<cfif #increment_valu# is 50.00> selected</cfif>>50.00</option>
                      <option value=100.00<cfif #increment_valu# is 100.00> selected</cfif>>100.00</option>
                      <option value=500.00<cfif #increment_valu# is 500.00> selected</cfif>>500.00</option>
                      <option value=1000.00<cfif #increment_valu# is 1000.00> selected</cfif>>1,000.00</option>
                      <option value=0.00<cfif #increment_valu# is 0.00> selected</cfif>>0.00</option>
                    </select>&nbsp;<font size=3>in USD <i>(Decrement for Reverse Auction)</i></font>
               </td> 
           </tr>
           <!--------------terms-of-sale--------------->
           <tr id="tr1" style="display:table-row;"><td><font size=3><b>Terms of Sales:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="button" name="submit" value=" Input Terms of Sales " onClick="get_terms(1)"></td>
           </tr>
           <tr id="tr2" style="display:none;">
              <td colspan=3 align="center">
				<table width="100%" border=0 cellspacing=0 cellpadding=0>
				    <tr><td><hr size=1 color="616362"></td></tr>
					<tr><td><font size=3><b>Terms of Sales</b>&nbsp;(You can paste/type document here)</font></td></tr>
					<tr><td><textarea name="terms" value="#terms#" cols=96 rows=24>#terms#</textarea></td></tr>    
					<tr height=10><td></td></tr>    
					<tr><td align="center"><input type="button" name="terms" value=" Close & Continue " onClick="get_terms(0)"></td></tr>
				</table>
              </td>
           </tr>           
           <!--------------end-terms-of-sale----------->
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr>
           <td valign="top"><font size=3><b>*Accepted<br>Payment<br>Methods:</b></font></td>
           <td>&nbsp;</td>
           <td valign="top" colspan=2>
              <table border=0 cellspacing=0 cellpadding=1>
                <tr>
                  <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>><font size=3>&nbsp;Cashier's Check, Money Order, Bank Transfer</font></td>
                  <td width=25>&nbsp;</td>
                  <td><input name="pay_am_express" type="checkbox" value="1"<cfif #pay_am_express# is "1"> checked</cfif>><font size=3>&nbsp;American Express card</font></td>
                </tr>
                <tr>
                  <td><input name="pay_cod" type="checkbox" value="1"<cfif #pay_cod# is "1"> checked</cfif>><font size=3>&nbsp;Collect-on-delivery (COD)</font></td>
                  <td>&nbsp;</td>
                  <td><input name="pay_discover" type="checkbox" value="1"<cfif #pay_discover# is "1"> checked</cfif>><font size=3>&nbsp;Discover card</font></td>
                </tr>
                <tr>
                  <td><input name="pay_pcheck" type="checkbox" value="1"<cfif #pay_pcheck# is "1"> checked</cfif>><font size=3>&nbsp;Personal check</font></td>
                  <td>&nbsp;</td>
                  <td><input name="pay_ol_escrow" type="checkbox" value="1"<cfif #pay_ol_escrow# is "1"> checked</cfif>><font size=3>&nbsp;PayPal</font></td>
                </tr>
                <tr>
                  <td><input name="pay_visa_mc" type="checkbox" value="1"<cfif #pay_visa_mc# is "1"> checked</cfif>><font size=3>&nbsp;VISA/MasterCard</font></td>
                  <td>&nbsp;</td>
                  <td><input name="pay_other" type="checkbox" value="1"<cfif #pay_other# is "1"> checked</cfif>><font size=3>&nbsp;Other/Not listed here</font></td>
                </tr>
                <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>><font size=3>&nbsp;See item comments for payment information</font></td></tr>
              </table>
           </td>
           </tr>
           <tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr>
              <td valign="top"><font size=3><b>*Shipping<br>Info:</b></font></td>
              <td>&nbsp;</td>
              <td valign="top" colspan=2>
              <table border=0 cellspacing=0 cellpadding=1>
                <tr>
                  <td><input name="ship_sell_pays" type="checkbox" value="1"<cfif #ship_sell_pays# is "1"> checked</cfif>><font size=3>&nbsp;Seller pays shipping costs</font></td>
                </tr>
                <tr>
                  <td><input name="ship_buy_pays_act" type="checkbox" value="1"<cfif #ship_buy_pays_act# is "1"> checked</cfif>><font size=3>&nbsp;Buyer pays actual shipping costs</font></td>
                </tr>
                <tr>
                  <td><input name="ship_buy_pays_fxd" type="checkbox" value="1"<cfif #ship_buy_pays_fxd# is "1"> checked</cfif>><font size=3>&nbsp;Buyer pays fixed shipping costs</font></td>
                </tr>
                <tr>
                  <td><input name="ship_international" type="checkbox" value="1"<cfif #ship_international# is "1"> checked</cfif>><font size=3>&nbsp;Allow international shipping</font></td>
                </tr>
                <tr>
                  <td><input name="ship_see_desc" type="checkbox" value="1"<cfif #ship_see_desc# is "1"> checked</cfif>><font size=3>&nbsp;See item description for shipping information</font></td>
                </tr>
              </table>
              </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
           <tr><td><font size=3><b>Shipping Fee:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="shipping_fee" value="#shipping_fee#" size=10>&nbsp;<font size=3>in USD</font></td> 
           </tr>
           <tr style="display:none;"><td><font size=3><b>Sales Tax:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="salestax" value="#salestax#" size=10>&nbsp;<font size=3>%</font></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr> 
        </table>
        </td></tr>
        <tr><td colspan=3 align="center"><br>
            <input type="submit" name="submit" value=" Save " onClick="return val_entries()">
            <input type="submit" name="submit" value=" Back ">
            <br><br><br><br>
        </td></tr>          
    </form>
    </table>  
    </td>
    </div>
</tr>
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
</table>
</body>
</cfoutput>  
</html>
