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
  <cfinclude template="../../includes/app_globals.cfm">
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
<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">
<!--- <cfinclude template="setdefaults.cfm"> --->
<cfparam name="studio" default="0">
<cfparam name="picture_studio" default="">
<cfparam name="sound_studio" default="">
<cfparam name="picture_file" default="http://">
<cfparam name="sound" default="http://">
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
<cfif ListFindNoCase(defaultlist,"date_end") eq 0>
	<cfif isDefined ("end_time")>
	  <cfset end_time = "#end_time##end_time_s#">
	  <cfset end_hour = timeFormat (end_time, 'H')>
	  <cfset end_min = timeFormat (end_time, 'm')>
	  <cfset date_end = createDateTime (end_year, end_month, end_day, end_hour, end_min, Second(Now()))>
	</cfif>
</cfif>
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
	
	<cfif ListFindNoCase(defaultlist,"increment_valu") eq 0>
			<cfif Form.increment_valu is "">
	      <cfset increment_valu = "0">
	    <cfelse>
				<cfset increment_valu = form.increment_valu>
			</cfif>
				<cfset increment = 1>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"minimum_bid") eq 0>
  <cfif IsDefined("Form.minimum_bid")>
    <cfset defaulted_minimum_bid = Form.minimum_bid>
    <cfif defaulted_minimum_bid is "">
		   <cfset minimum_bid = REReplace("#form.minimum_bid#", "[^0123456789.]", "", "ALL")>
      <cfset defaulted_minimum_bid = "0">
	    </cfif>
  <cfelse>
    <cfset defaulted_minimum_bid = "0">     
	</cfif>
	<cfif ListFindNoCase(defaultlist,"maximum_bid") eq 0>
		 <cfif Form.maximum_bid is "">
	      <cfset maximum_bid = "0">
		  <cfelse>
		   <cfset maximum_bid = REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
	    </cfif>
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
  	 	    <cfset #reserve_bid# =REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
   	 <cfelse>
    	    <cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
   	  </cfif>
    </cfif>
	</cfif> 
	
	<!--- Check URL paths --->
	<cfif ListFindNoCase(defaultlist,"picture_file") eq 0>
		<cfif (#picture_file# is "") or (#left (picture_file, 7)# is not "http://")>
    	<cfset #picture_file# = "http://#picture_file#">
  	</cfif>
		<cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
	    <cfset #picture_studio# = "http://#picture_studio#">
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
	<cfif ListFindNoCase(defaultlist,"desc_languages") eq 0>
			<cfset desc_languages = form.desc_languages>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"location") eq 0>
			<cfset location = form.location>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"country") eq 0>
			<cfset country = form.country>
	</cfif>
	<!--- <cfif ListFindNoCase(defaultlist,"duration") eq 0>
			<cfset date_end = dateAdd ("d", "#duration#", date_end)> 
	</cfif>--->
	<cfif ListFindNoCase(defaultlist,"category1") eq 0>
			<cfset category1 = form.category1>
			<cfset category2 = form.category2>
	</cfif>

	<!--- Start of thumb upload code --->
	<cfif ListFindNoCase(session.defaultlist,"thumb") eq 0>
<!--- Auto Thumb resizing  --->

<cfif isdefined("form.thumb") and form.thumb is not "">
	<cfset #studio# = "1">
 <cfset #curPath# = GetTemplatePath()>
 <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"personal\bulksell\","thumbs\")> 

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
      <!---<CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="110"> --->
     <cfelse>
<!---      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="124"> --->
    </cfif>
  </cfif>
  <cfset incoming = #URLEncodedFormat(File.ServerFile)#>
  <cfset serverfile = #File.ServerFile#>
</cfif>  


 
<cfif #isDefined("incoming")# is 0>
  <cfset #incoming# = "">
</cfif>   
<cfif #isDefined("theMsg")# is 0>
  <cfset #theMsg# = "">
</cfif>  


  <!--- Rename thumbnail with item number ---> 

<cfif #isDefined("incoming")#>
<cfoutput>incoming = #incoming#<br></cfoutput>
<cfoutput>itemnum = #itemnum#<br></cfoutput>
</cfif>
  
  <cfif IsDefined("incoming") and IsDefined("directory")>
    <!---    <cfset #curPath# = GetTemplatePath()>
 <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"sell","thumbs")> --->
    <cfif IsDefined("serverfile") and #serverfile# NEQ "">      
      <cfif fileExists("#directory##serverfile#")>
        <cffile action="rename"
          SOURCE = "#directory##serverfile#"  
          DESTINATION = "#directory##itemnum##right(serverfile,4)#">
      </cfif>
    <cfelse>
      <cfif fileExists("#directory##incoming#")>
        <cffile action="rename"
          SOURCE = "#directory##incoming#"  
          DESTINATION = "#directory##itemnum##right(incoming,4)#">
      </cfif>
    </cfif>  
  </cfif>
<cfelse>
		<cfset #studio# = "0">	
</cfif>
<!--- End thumb upload code --->

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
	<cfif ListFindNoCase(defaultlist,"featured_studio") eq 0>
			<cfif isdefined("form.featured_studio")>
				<cfset featured_studio = 1>
			<cfelse>
				<cfset featured_studio = 0>
			</cfif>
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
	<cfif ListFindNoCase(defaultlist,"orig_cost") eq 0>
			<cfif orig_cost eq "">
				<cfset orig_cost = "0">
			<cfelse>	
				<cfset orig_cost = form.orig_cost>
			</cfif>
	</cfif>
	
	<cfif ListFindNoCase(defaultlist,"wh_location") eq 0>
				<cfset wh_location = form.wh_location>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"consignor") eq 0>	
				<cfset consignor = form.consignor>
	</cfif>
	
  <!--- Make sure they specified a bid increment only if the quantity is 1 --->
	<cfif #increment# is "1">
	      <cfif #quantity# GT 1>
	        <cfset #increment# = "0">
				<cfelseif (#increment_valu# is 0) or (#isNumeric (increment_valu)# is 0)>
	        <cfset increment = "0">
	      </cfif>
	 </cfif>

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
            picture_file,
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
						orig_cost,
						wh_location,
						consignor)
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
             '#picture_file#',
             '#sound#',
             #quantity#,
			       #minimum_bid#,
             #maximum_bid#,
             #increment#,
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
						 '#orig_cost#',
						 '#wh_location#',
						 '#consignor#')
  </cfquery>
	

 <!--- log new auction --->
  <cfmodule template="../../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Auction Started"
    itemnum="#itemnum#"
    details="#title#"
    user_id="#cookie.user_id#">

  <!--- Rename thumbnail with item number ---> 
  <cfif #isDefined ("form.incoming")#>  
    <cfset #curPath# = GetTemplatePath()>
    <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"sell","thumbs")>
    <cfif fileExists("#directory##form.incoming#")>
      <cffile action="rename"
       SOURCE = "#directory##session.incoming#"  
       DESTINATION = "#directory##form.itemnum##right(session.incoming,4)#">
    </cfif>
  </cfif>

	  <!--- Erase the session info
	<cflock timeout="15" throwontimeout="No" name="#form.sessionID#">
	  <cfset form.held_item = "0"> 
		 <cfset form.itemnum = "0">
	</cflock> --->
  <!--- Redirect them to the final sell page
  <cflocation url="bulksell.cfm?itemnum=#form.itemnum#"> --->
	<cfinclude template="bulksell.cfm">>
