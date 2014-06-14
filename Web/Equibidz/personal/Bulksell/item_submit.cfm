<!---
    Bulk sell/item_submit.cfm
    The submit to page for items coming from the bulksell page;
    this inserts the data into the database from the session variables.
    08-Apr-1999 Jason Johnson, modified 07/09/00 Robert Oleinik
    Reverse auction and studio included.
    11/29/99 Walter Conti

--->

<cftry>
  <!--- include globals --->
  <!--- <cfinclude template="../../includes/app_globals.cfm"> --->
  <!--- Include session tracking template, mostly disabled, using hidden form fields and cookies --->
<cfinclude template="../../includes/session_include.cfm">
  <!--- define TIMENOW --->
  <cfmodule template="../../functions/timenow.cfm">
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>
<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>

<!--- <cfinclude template="setdefaults.cfm"> --->
<cfparam name="studio" default="0">
<cfparam name="picture_studio" default="">
<cfparam name="sound_studio" default="">
<cfparam name="picture" default="">
<cfparam name="pic_incoming" default="">
<cfparam name="sound" default="http://">
<!--- <cfparam name="end_time" default="#session.end_time#"> --->
<!--- Begin form validation/cleanup check if items are in defaultlist,
if not, process to session variables --->
<!--- If defined, merge the seperate date and time objects into 1 object --->
<cfif ListFindNoCase(defaultlist,"date_start") eq 0>
	<cfif isDefined ("start_time")>
	  <cfset start_time = "#start_time##start_time_s#">
	  <cfset start_hour = timeFormat (start_time, 'H')>
	  <cfset start_min = timeFormat (start_time, 'm')>
	  <cfset date_start = createDateTime (start_year, start_month, start_day, start_hour, start_min, Second(Now()))>
	</cfif>
</cfif>
<!--- <cfif ListFindNoCase(defaultlist,"date_end") eq 0>
<!-- defaultlist did not have "date_end" -->
	<cfif isDefined ("end_time")>
	  <cfset end_time = "#end_time##end_time_s#">
	  <cfset end_hour = timeFormat (end_time, 'H')>
	  <cfset end_min = timeFormat (end_time, 'm')>
	  <cfset date_end = createDateTime (end_year, end_month, end_day, end_hour, end_min, Second(Now()))>
	</cfif>
</cfif> --->

<!--- 
	
	<cfif ListFindNoCase(defaultlist,"increment_valu") eq 0>
			<cfif Form.increment_valu is "">
	      <cfset increment_valu = "0">
	    <cfelse>
				<cfset increment_valu = form.increment_valu>
			</cfif>
				<cfset increment = 1>
	</cfif> --->
 
  <!--- Set fixed values for increment, increment_valu, and dynamic_valu --->
		<cfset increment = 1>
  <!--- <cfset increment_valu = "5"> --->
<cfif ListFindNoCase(defaultlist,"dynamic_valu") eq 0>
		<cfif Form.dynamic_valu is "">
	    		<cfset dynamic_valu = "0">
		<cfelse>
				<cfset dynamic_valu = form.dynamic_valu>
		</cfif>
		<cfif isdefined("form.dynamic")>
				<cfset dynamic = 1>
		<cfelse>
				<cfset dynamic = 0>
		</cfif>
 </cfif>
  
  <cfif IsDefined("Form.minimum_bid")>
    <cfset defaulted_minimum_bid = REReplace("#Form.minimum_bid#", "[^0123456789.]", "", "ALL")>
    <cfif defaulted_minimum_bid is "">
      <cfset defaulted_minimum_bid = "0">
    </cfif>
  <cfelse>
    <cfset defaulted_minimum_bid = "0">     
  </cfif>
 
  <cfif IsDefined("Form.maximum_bid")>
    <cfset defaulted_maximum_bid = REReplace("#Form.maximum_bid#", "[^0123456789.]", "", "ALL")>
    <cfif defaulted_maximum_bid is "">
      <cfset defaulted_maximum_bid = "0">
    </cfif>
  <cfelse>
    <cfset defaulted_maximum_bid = "0">     
  </cfif>
	
  <cfif ListFindNoCase(defaultlist,"reserve_bid") eq 0>
		<cfif auction_mode is 0><!--- normal --->
 			<cfif Form.reserve_bid is "">
  					<cfset reserve_bid = "0">
			<cfelse>
					<cfset reserve_bid = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
 			</cfif>
	  <cfelse><!--- reverse --->
    	<cfif #Form.reserve_bid# is "" or #form.reserve_bid# is 0>
  	 	    <cfset #reserve_bid# = defaulted_maximum_bid>
   	 <cfelse>
    	    <cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
   	  </cfif>
    </cfif>
  </cfif> 
	

	
	<cfif ListFindNoCase(defaultlist,"sound") eq 0>
	  <cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
	    <cfset #sound# = "http://#sound#">
	  </cfif>
		<cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
	    <cfset #sound_studio# = "http://#sound_studio#">
	  </cfif>
	</cfif>
	  
	  <cfset billmeth = "BM">
	  <cfset remote_ip = cgi.remote_addr>
		<cfset itemnum = form.itemnum>
 

		 	

	<cfif ListFindNoCase(defaultlist,"title") eq 0>
			<cfset title = form.title>
			<cfif isdefined("form.bold_title")>
				<cfset bold_title = 1>
			<cfelse>
				<cfset bold_title = 0>
			</cfif>
	</cfif>
  <cfif ListFindNoCase(defaultlist,"banner") eq 0>
			<cfif isdefined("form.banner")>
				<cfset banner = 1>
			<cfelse>
				<cfset banner = 0>
			</cfif>
			<cfset banner_line = form.banner_line>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"quantity") eq 0>
			<cfset quantity = form.quantity>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"auction_type") eq 0>
			<cfset auction_type = form.auction_type>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"description") eq 0>
			<cfset description = form.description>
	</cfif>
	<!--- <cfif ListFindNoCase(defaultlist,"high_est") eq 0>
			<cfset high_est = form.high_est>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"low_est") eq 0>
			<cfset low_est = form.low_est>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"condition") eq 0>
			<cfset condition = form.condition>
	</cfif> --->
	<cfif ListFindNoCase(defaultlist,"desc_languages") eq 0>
			<cfset desc_languages = form.desc_languages>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"location") eq 0>
			<cfset location = form.location>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"country") eq 0>
			<cfset country = form.country>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"duration") eq 0>
			<cfset date_end = dateAdd ("d", "#duration#", date_start)> 
	</cfif>
	<cfif ListFindNoCase(defaultlist,"category1") eq 0>
			<cfset category1 = form.category1>
			<cfset category2 = form.category2>
	</cfif>

	<!--- Start of thumb upload code --->
	<cfif ListFindNoCase(defaultlist,"thumb") eq 0>
<!--- Auto Thumb resizing  --->

<cfif isdefined("form.thumb") and form.thumb is not "">
  <cfset #curPath# = GetTemplatePath()>
 <!--- <cfset directory = "d:\inetpub\wwwroot\#site_address#\thumbs\">  --->
	<cfset directory = Replace("#curPath#","personal\Bulksell\","thumbs\")> 
	<cfset #directory# = GetDirectoryFromPath(#directory#)>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.thumb"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.thumb"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
<cfset Img_width=124>
<cfset Img_height=110>
  
<!---  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#"> --->
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_height GT 110 or Img_width GT 124>
    <cfif Img_height/Img_width*100 GT 88>
<!---      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="110"> --->
     <cfelse>
<!---      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="124"> --->
    </cfif>
  </cfif>
  <cfset incoming = #URLEncodedFormat(File.ServerFile)#>
  <cfset serverfile = #File.ServerFile#>
</cfif>  

  
<cfif #isDefined("theMsg")# is 0>
  <cfset #theMsg# = "">
</cfif>  


  <!--- Rename thumbnail with item number ---> 
  
  <cfif IsDefined("incoming") and IsDefined("directory")>
    <cfif IsDefined("serverfile") and #serverfile# NEQ "">      
      <cfif fileExists("#directory##serverfile#")>
        <cffile action="rename"
          SOURCE = "#directory##serverfile#"  
          DESTINATION = "#directory##form.itemnum##right(serverfile,4)#">
      </cfif>
    <cfelse>
      <cfif fileExists("#directory##incoming#")>
        <cffile action="rename"
          SOURCE = "#directory##incoming#"  
          DESTINATION = "#directory##form.itemnum##right(incoming,4)#">
      </cfif>
    </cfif>  
  </cfif>

 
</cfif>
<!--- End thumb upload code --->

<!--- upload full size image --->
<cfif ListFindNoCase(defaultlist,"picture1") eq 0>
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"personal\Bulksell\","fullsize_thumbs\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture1 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory2##picture1#")>
        <cffile action="rename"
          SOURCE = "#directory2##picture1#"  
          DESTINATION = "#directory2##form.itemnum##right(picture1,4)#">
      </cfif>
</cfif>
</cfif>
<!--- end full size image upload --->

<!--- upload full size image2 --->
<cfif ListFindNoCase(defaultlist,"picture2") eq 0>
<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"personal\Bulksell\","fullsize_thumbs1\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture2 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory2##picture2#")>
        <cffile action="rename"
          SOURCE = "#directory2##picture2#"  
          DESTINATION = "#directory2##form.itemnum##right(picture2,4)#">
      </cfif>
</cfif>
</cfif>
<!--- end full size image2 upload --->

<!--- upload full size image3 --->
<cfif ListFindNoCase(defaultlist,"picture3") eq 0>
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"personal\Bulksell\","fullsize_thumbs2\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture3 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory2##picture3#")>
        <cffile action="rename"
          SOURCE = "#directory2##picture3#"  
          DESTINATION = "#directory2##form.itemnum##right(picture3,4)#">
      </cfif>
</cfif>
</cfif>
<!--- end full size image3 upload --->

<!--- upload full size image3 --->
<cfif ListFindNoCase(defaultlist,"picture4") eq 0>
<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"personal\Bulksell\","fullsize_thumbs3\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture4 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory2##picture4#")>
        <cffile action="rename"
          SOURCE = "#directory2##picture4#"  
          DESTINATION = "#directory2##form.itemnum##right(picture4,4)#">
      </cfif>
</cfif>
</cfif>
<!--- end full size image3 upload --->

	<cfif ListFindNoCase(defaultlist,"paymethod") eq 0>
			<cfif isdefined("form.pay_morder_ccheck")>
				<cfset pay_morder_ccheck = 1>
			<cfelse>
				<cfset pay_morder_ccheck = 0>
			</cfif>
			<cfif isdefined("form.pay_cod")>
				<cfset pay_cod = 1>
			<cfelse>
				<cfset pay_cod = 0>
			</cfif>
			<cfif isdefined("form.pay_see_desc")>
				<cfset pay_see_desc = 1>
			<cfelse>
				<cfset pay_see_desc = 0>
			</cfif>
			<cfif isdefined("form.pay_pcheck")>
				<cfset pay_pcheck = 1>
			<cfelse>
				<cfset pay_pcheck = 0>
			</cfif>
			<cfif isdefined("form.pay_ol_escrow")>
				<cfset pay_ol_escrow = 1>
			<cfelse>
				<cfset pay_ol_escrow = 0>
			</cfif>
			<cfif isdefined("form.pay_other")>
				<cfset pay_other = 1>
			<cfelse>
				<cfset pay_other = 0>
			</cfif>
			<cfif isdefined("form.pay_visa_mc")>
				<cfset pay_visa_mc = 1>
			<cfelse>
				<cfset pay_visa_mc = 0>
			</cfif>
			<cfif isdefined("form.pay_am_express")>
				<cfset pay_am_express = 1>
			<cfelse>
				<cfset pay_am_express = 0>
			</cfif>
			<cfif isdefined("form.pay_discover")>
				<cfset pay_discover = 1>
			<cfelse>
				<cfset pay_discover = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"shipping") eq 0>
			<cfif isdefined("form.ship_sell_pays")>
				<cfset ship_sell_pays = 1>
			<cfelse>
				<cfset ship_sell_pays = 0>
			</cfif>
			<cfif isdefined("form.ship_buy_pays_act")>
				<cfset ship_buy_pays_act = 1>
			<cfelse>
				<cfset ship_buy_pays_act = 0>
			</cfif>
			<cfif isdefined("form.ship_see_desc")>
				<cfset ship_see_desc = 1>
			<cfelse>
				<cfset ship_see_desc = 0>
			</cfif>
			<cfif isdefined("form.ship_buy_pays_fxd")>
				<cfset ship_buy_pays_fxd = 1>
			<cfelse>
				<cfset ship_buy_pays_fxd = 0>
			</cfif>
			<cfif isdefined("form.ship_international")>
				<cfset ship_international = 1>
			<cfelse>
				<cfset ship_international = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured") eq 0>
			<cfif isdefined("form.featured")>
				<cfset featured = 1>
			<cfelse>
				<cfset featured = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured_cat") eq 0>
			<cfif isdefined("form.featured_cat")>
				<cfset featured_cat = 1>
			<cfelse>
				<cfset featured_cat = 0>
			</cfif>
	</cfif>
	<!--- <cfif ListFindNoCase(defaultlist,"featured_studio") eq 0>
			<cfif isdefined("form.featured_studio")>
				<cfset #studio# = "1">
				<cfset featured_studio = 1>
			<cfelse>
				<cfset #studio# = "0">
				<cfset featured_studio = 0>
			</cfif>
	</cfif> --->
	<cfif #isDefined ("Form.thumb")#>
    	<cfif #form.thumb# IS NOT "" and #form.thumb# IS NOT "http://">
			<cfset #studio# = "1">
		<cfelse>
    		<cfset #studio# = "0">
  		</cfif>
	</cfif>
	<cfif isDefined("Form.featured_studio")>
		<cfset featured_studio = 1>
	<cfelse>
		<cfset featured_studio = 0>
	</cfif>
	
	<cfif ListFindNoCase(defaultlist,"auto_relist") eq 0>
			<cfif auto_relist eq "">
				<cfset auto_relist = "0">
			<cfelse>	
				<cfset auto_relist = form.auto_relist>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"private") eq 0>
			<cfif isdefined("form.private")>
				<cfset private = 1>
			<cfelse>
				<cfset private = 0>
			</cfif>
	</cfif>
	<!--- <cfif ListFindNoCase(defaultlist,"orig_cost") eq 0>
			<cfif orig_cost eq "">
				<cfset orig_cost = "0">
			<cfelse>	
				<cfset orig_cost = form.orig_cost>
			</cfif>
	</cfif> --->
	
	<!--- <cfif ListFindNoCase(defaultlist,"wh_location") eq 0>
				<cfset wh_location = form.wh_location>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"consignor") eq 0>	
				<cfset consignor = form.consignor>
	</cfif> --->
	
  <!--- Make sure they specified a bid increment only if the quantity is 1 --->
	<!--- <cfif #increment# is "1">
	      <cfif #quantity# GT 1>
	        <cfset #increment# = "0">
				<cfelseif (#increment_valu# is 0) or (#isNumeric (increment_valu)# is 0)>
	        <cfset increment = "0">
	      </cfif>
	 </cfif> --->

<!--- End form validation --->

  
    <cfset description = REReplacenocase(description,"JavaScript","Java Script")>
  

  <cfif #isDefined ("incoming")#>
    <cfif #incoming# IS "">
      <cfset studio = 0>
      <cfset featured_studio = 0>      
    </cfif>
  </cfif>  

  
  <cfif #banner_line# is "">
    <cfset #banner_line# = " ">
  </cfif>    

  <!--- Insert the item into the database --->

  <cfquery username="#db_username#" password="#db_password#" name="insert_item" datasource="#DATASOURCE#">
    INSERT INTO items
           (status,
            user_id,
            category1,
            category2,
            title,
            location,
            country,
            pay_morder_ccheck,
            pay_cod,
            pay_see_desc,
            pay_pcheck,
            pay_ol_escrow,
            pay_other,
            pay_visa_mc,
            pay_am_express,
            pay_discover,
            ship_sell_pays,
            ship_buy_pays_act,
            ship_see_desc,
            ship_buy_pays_fxd,
            ship_international,
            description,
            desc_languages,
            picture,
			picture1,
			picture2,
			picture3,
			picture4,
            <!--- picture_file, --->
            sound,
            quantity,
            minimum_bid,
            maximum_bid,
            increment,
            increment_valu,
            dynamic,
            dynamic_valu,
            reserve_bid,
            bold_title,
            featured,
            featured_cat,
            private,
            banner,
            banner_line,
            studio,
            featured_studio,
            picture_studio,
            sound_studio,
            date_start,
            date_end,
            itemnum,
            billmeth,
            remote_ip,
            auction_type,
            auction_mode,
	    			auto_relist,
						buynow_price,
						buynow,
						org_quantity<!--- ,
						orig_cost,
						wh_location,
						consignor,
						high_est,
						low_est,
						condition --->)
          VALUES (1,
             #cookie.user_id#,
             #category1#,
             #category2#,
             '#title#',
             '#location#',
             '#country#',
             #pay_morder_ccheck#,
             #pay_cod#,
             #pay_see_desc#,
             #pay_pcheck#,
             #pay_ol_escrow#,
             #pay_other#,
             #pay_visa_mc#,
             #pay_am_express#,
             #pay_discover#,
             #ship_sell_pays#,
             #ship_buy_pays_act#,
             #ship_see_desc#,
             #ship_buy_pays_fxd#,
             #ship_international#,
             '#description#',
             '#desc_languages#',
             '#picture#',
			 <cfif picture1 neq "">'#form.itemnum##right(picture1,4)#'<cfelse>'#picture1#'</cfif>,
            <cfif picture2 neq "">'#form.itemnum##right(picture2,4)#'<cfelse>'#picture2#'</cfif>,
            <cfif picture3 neq "">'#form.itemnum##right(picture3,4)#'<cfelse>'#picture3#'</cfif>,
			<cfif picture4 neq "">'#form.itemnum##right(picture4,4)#'<cfelse>'#picture4#'</cfif>,
             <!--- '#pic_incoming#', --->
             '#sound#',
             #quantity#,
             #defaulted_minimum_bid#,
             #defaulted_maximum_bid#,
             #Variables.increment#,
             #increment_valu#,
             #dynamic#,
             #dynamic_valu#,
             #reserve_bid#,
             #bold_title#,
             #featured#,
             #featured_cat#,
             #private#,
             #banner#,
             '#banner_line#',
             #studio#,
             #featured_studio#,
             '#picture_studio#',
             '#sound_studio#',
             #createODBCDateTime (date_start)#,
             #createODBCDateTime (date_end)#,
             #itemnum#,
             '#billmeth#',
             '#remote_ip#',
             '#auction_type#',
             '#auction_mode#',
             #auto_relist#,
			 #buynow_price#,
			 #buynow#,
			 #quantity#<!--- ,
						 '#orig_cost#',
						 '#wh_location#',
						 '#consignor#',
						 #high_est#,
						 #low_est#,
						 '#condition#' --->)
  </cfquery>
  
	<!--- Reset the picture_studio value to prevent duplication value --->
	<cfset picture_studio="http://">
	
	<cfset theMsg = "Your item no. " & itemnum & " has been added to the auction. You may add another item using the same defaults below.">
	 <!---<cfset error_trap = "no">
 <cflocation url="bulksell.cfm?themsg=#themsg#&error_trap=#error_trap#">  --->
	<!--- 
	<cfcatch>
		<cfset theMsg = "Your item no. " & itemnum & " can not be added to the auction. You may readd the item using the same defaults below.">
	</cfcatch>
</cftry> --->
 <!--- log new auction --->
  <cfmodule template="../../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Auction Started"
    itemnum="#itemnum#"
    details="#title#"
    user_id="#cookie.user_id#">

	<!--- Get their e-mail address --->
 <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
  SELECT email
    FROM users
   WHERE user_id = #cookie.user_id#
 </cfquery>
 
 <cfquery username="#db_username#" password="#db_password#" name="get_category1" datasource="#DATASOURCE#">
  SELECT name
    FROM categories   
   WHERE category = #category1# AND #category1# <> -1
 </cfquery>
 <cfquery username="#db_username#" password="#db_password#" name="get_category2" datasource="#DATASOURCE#">
  SELECT name
    FROM categories   
   WHERE category = #category2# AND #category2# <> -1
 </cfquery>
 
 <cfset #days# = #dateDiff ('d', date_start, date_end)#>
	
	<!--- Send them an e-mail message confirming their added item --->
 <cfmail to="#get_user_info.email#"
         from="Listings@#DOMAIN#"
         subject="Auction item information">
  Your item, "#title#", has been added to our item database
  under the categor<cfif #get_category2.recordcount# GT 0>ies<cfelse>y</cfif> "#get_category1.name#"<cfif #get_category2.recordcount# GT 0> and "#get_category2.name#"</cfif>.

  It will be up for auction starting #dateFormat (date_start)#, and will
  run for #days# day<cfif #days# GT 1>s</cfif>, closing on #dateFormat (dateAdd ('d', days, date_start))#.


<cfif auto_relist is not 0>
  If your item does not sell it will automatically relist #auto_relist# times.
</cfif>

  For your reference, the item number #itemnum# has been
  automatically assigned to your item.  It would be a good
  idea to write this number down for future reference to
  your item.
  
  You may view this auction in progress at http://#SITE_ADDRESS##VAROOT#/listings/details/index.cfm?itemnum=#itemnum#. 
  
  Please note that it may take as long as two hours for the item to appear in the listings.

  Thank you for using our services,
  #COMPANY_NAME#
 </cfmail>

	  <!--- Erase the session info --->
	<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
	  <cfset session.held_item = "0">
	</cflock>
	
  <!--- Redirect them to the final sell page
  <cflocation url="bulksell.cfm?itemnum=#form.itemnum#"> --->

 
<!--- Include this module to obtain a unique item number --->
<CFMODULE TEMPLATE="../../functions/epoch.cfm">


<!--- Check to see if the EPOCH value has been used before ---> 
<!--- Set the Condition of the loop to true --->
<cfset #loop_again2# = "1">
<cfloop condition="loop_again2 IS 1">
  <cfquery username="#db_username#" password="#db_password#" name="EPOCH_check" DATASOURCE="#DATASOURCE#">
       SELECT itemnum
         FROM items
        WHERE itemnum = #EPOCH#
  </cfquery>
  <cfif EPOCH_check.recordcount GT 0>
    <cfset #EPOCH#=#EPOCH# + 1>
  <cfelse>
    <cfset #loop_again2#=0>
  </cfif>
</cfloop>
<cfset itemnum = epoch>
  <cfset entered = "Yes">

  <!--- Redirect them to the final sell page
  <cflocation url="bulksell.cfm?itemnum=#form.itemnum#"> --->
  <cfif not isDefined('entered')>
<cfinclude template="bulksell.cfm">  
</CFIF>

