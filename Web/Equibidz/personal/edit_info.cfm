

 <cfsetting enablecfoutputonly="Yes">

  
 
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 
 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>
 
<!--- Get selected category from session or link --->
<cfif isDefined('url.cat') or isDefined('session.category1')>
<cfif isDefined('url.cat')>

<cflock timeout="30" name="#session.sessionid#" type="exclusive">
	<cfset structdelete(session, "category2")>
	
</cflock>

<cfset selected_category = url.cat>
<cfset session.category1 = url.cat>
<cfelseif isDefined('session.category1')>
<cfset selected_category = session.category1>
 
</cfif></cfif>
 


  <!--- def vals --->
  <cfset sDescAddendumNote = '<br><br><hr size=1 color=#heading_color# width=100%><font face="helvetica">On #DateFormat(Now(), "mm/dd/yyyy")# at #TimeFormat(Now(), "HH:mm:ss")#, seller added the following information:</font><br><br>'>
 
 <!--- Load this module for creating unique IDs --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">

  <!--- ********** --->
<cfif #isDefined("directory")#>
  <cffile action="delete"	file="#directory##incoming#">  
</cfif>

<!--- upload full size image --->
<cfif isdefined("form.picture1") and form.picture1 is not "" >

  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/jpg, image/jpeg, image/png, image/gif">
  <cfelse>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/*">
  </cfif>
<cfset picture1 = #File.serverFile#>
	<!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture1#")>
        <cffile action="rename"
          SOURCE = "#directory##picture1#"  
          DESTINATION = "#directory##selected_item##right(picture1,4)#">
      </cfif>

</cfif> 

<cfif isdefined("form.picture2") and form.picture2 is not "" >

  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs1\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/jpg, image/jpeg, image/png, image/gif">
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/*">
  </cfif>
<cfset picture2 = #File.serverFile#>
	<!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture2#")>
        <cffile action="rename"
          SOURCE = "#directory##picture2#"  
          DESTINATION = "#directory##selected_item##right(picture2,4)#">
      </cfif>

</cfif> 


<!--- upload full size image #3--->
<cfif isdefined("form.picture3") and form.picture3 is not "" >

  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs2\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/jpg, image/jpeg, image/png, image/gif">
  <cfelse>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/*">
  </cfif>
<cfset picture3 = #File.serverFile#>
	<!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture3#")>
        <cffile action="rename"
          SOURCE = "#directory##picture3#"  
          DESTINATION = "#directory##selected_item##right(picture3,4)#">
      </cfif>

</cfif> 





<cfif isdefined("form.picture4") and form.picture4 is not "" >

  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs3\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/jpg, image/jpeg, image/png, image/gif">
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/*">
  </cfif>
<cfset picture4 = #File.serverFile#>
	<!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture4#")>
        <cffile action="rename"
          SOURCE = "#directory##picture4#"  
          DESTINATION = "#directory##selected_item##right(picture4,4)#">
      </cfif>

</cfif> 



<cfif #isDefined("incoming")# is 0>
  <cfset #incoming# = "">
</cfif>  
<!--- ********** --->

 
 <cfif #isDefined ("selected_category")# is 0>
  <cfset #selected_category# = "0">
 </cfif>

 <cfif not isDefined("theThumb")>
 <cfparam name="theThumb" default="">
 </cfif>
 
<cfif  not isDefined("country")>
<cfparam name="country" default="USA">
</cfif>

 <!--- If they're not selecting an item, set a default one --->
 <!---<cfif #isDefined ("selected_item")# is "0">
  <cfset #selected_item# = "#EPOCH#">
 </cfif>
--->

  <!--- Set a default value for "submit2" and "submit3" if nonexistent --->
 <cfif #isDefined ("submit2")# is 0>
  <cfset #submit2# = "enter">
 <cfelse>
  <cfset #submit2# = #trim (submit2)#>
 </cfif>
 <cfif #isDefined ("submit3")# is 1>
  <cfset #submit3# = #trim (submit3)#>
 <cfelse>
  <cfset #submit3# = "enter">
 </cfif>
 <cfif #submit2# is "enter">
  <cfset #session.query_done# = "not">
 </cfif>




 <!--- Check to see if they're cancelling. --->
 <cfif #submit2# is "Cancel">
  <cfoutput><cflocation url="main_page.cfm"></cfoutput>
 </cfif>
 <!--- Check to see if they're editing Another Item. --->
 <cfif #submit3# is "Edit Another">
  <cfoutput><cflocation url="edititem.cfm"></cfoutput>
 </cfif>
 
 <cfif #isDefined ("selected_item")# is 0>
<cfset #selected_item# = "#itemnum#">
</cfif>
<cfif #isDefined ("the_item")# is 0>
  <cfset #the_item# = "#selected_item#">
 </cfif>
 
 <cfif #isDefined ("desc_languages")# is 0>
  <cfset #desc_languages# = "">
 </cfif>

<!--- Set a default value for "User ID" if nonexistent --->
 <cfif #isDefined ("user_id")# is 0>
  <cfset #user_id# = "session.user_id">
 <cfelse>
  <cfset #user_id# = #trim (user_id)#>
 </cfif> 
 

<!--- Set a default value for the missing submit button --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "Edit">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>
 
<!--- Check for a value on the Session.itemnum variable --->
<!---<cfset #selected_item# = "#itemnum#">--->
<!--- <cfif #isDefined ("session.itemnum")# is 0>
  <cfset #session.itemnum# = "itemnum">
 <cfelse>
  <cfset #session.itemnum# = #trim (session.itemnum)#>
  </cfif>
<cfset #selected_item#="#session.itemnum#">--->
 <!--- Set defaults depending on whether we're editing or adding --->



 <cfif (#submit# is "Edit") and (#submit2# is "Enter")>
  <cfset #itemnum#="#itemnum#">
 <cfelseif #submit# is "Add">
  <cfset #itemnum#="#EPOCH#">
 </cfif> 
 
 <!--- Get a list of active users --->
 <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
  SELECT user_id, name, nickname
    FROM users
   WHERE user_id = #session.user_id#
   ORDER BY nickname
 </cfquery>



 <!--- Get the last user they chose as the seller --->
 <cfquery username="#db_username#" password="#db_password#" name="get_seller" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'last_seller'
 </cfquery>


 <!--- Check to see if we need to delete an item. --->
 <cfif #submit2# is "Delete" or #submit# is "Delete">
  <cfquery username="#db_username#" password="#db_password#" name="delete_item" datasource="#DATASOURCE#">
   DELETE FROM items
    WHERE itemnum = #selected_item#
  </cfquery>
  <cfoutput><cflocation url="main_page.cfm"></cfoutput>
 </cfif>

 <!--- If defined, merge the seperate date and time objects into 1 object --->
 <cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
 </cfif>

 <cfif #isDefined ("dynamic_valu")#>
  <cfif #dynamic_valu# is "">
   <cfset #dynamic_valu# = "0">
  </cfif>
 </cfif>
 <cfif #isDefined ("increment_valu")#>
  <cfif #increment_valu# is "">
   <cfset #increment_valu# = "0">
   <cfelse>
   <cfset #increment_valu# = REReplace("#form.increment_valu#", "[^0123456789.]", "", "ALL")>
  </cfif>
 </cfif>
 <cfif #isDefined ("Form.minimum_bid")#>
   <cfif #Form.minimum_bid# is "">
    <cfset #minimum_bid# = "0">
	<cfelse>
	<cfset #minimum_bid# = REReplace("#form.minimum_bid#", "[^0123456789.]", "", "ALL")>
   </cfif>
  </cfif>
 
  <cfif #isDefined ("Form.maximum_bid")#>
   <cfif #Form.maximum_bid# is "">
    <cfset #maximum_bid# = "0">
	<cfelse>
	<cfset #maximum_bid# = REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
   </cfif>
 </cfif>
 
 <cfif #isDefined ("Form.shipping_fee")#>  
    <cfset #shipping_fee# = REReplace("#form.shipping_fee#", "[^0123456789.]", "", "ALL")>
 <cfelse>
	<cfset #shipping_fee# = 0> 
 </cfif>
 
 <cfif #isDefined ("Form.salestax")#>  
    <cfset #salestax# = REReplace("#form.salestax#", "[^0123456789.]", "", "ALL")>
 <cfelse>
	<cfset #salestax# = 0> 
 </cfif>
 
 <cfif #isDefined ("reserve_bid")#>
  <cfif #reserve_bid# is "">
   <cfset #reserve_bid# = "0">
   <cfelse>
	<CFOUTPUT><cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")></CFOUTPUT>
	
  </cfif>
 </cfif>

<cfif NOT isDefined("category1")>
<cfif isDefined("form.category1")>
<cfset category1 = #form.category1#>
<cfelse>
<cfset category1 = "">
</cfif></cfif>

<cfif NOT isDefined("category2")>
<cfif isDefined("form.category2")>
<cfset category2 = #form.category2#>
<cfelseif isDefined('get_iteminfo.category2')>
<cfset category2=#get_iteminfo.category2#>
<cfelse>
<cfset category2 = "">
</cfif></cfif>
 <cfif #isDefined ("status")#>
  <cfset #status# = "1">
 <cfelse>
  <cfset #status# = "0">
 </cfif>
 <cfif #isDefined ("bold_title")#>
  <cfset #bold_title# = "1">
 <cfelse>
  <cfset #bold_title# = "0">
 </cfif>
 <cfif #isDefined ("pay_morder_ccheck")#>
  <cfset #pay_morder_ccheck# = "1">
 <cfelse>
  <cfset #pay_morder_ccheck# = "0">
 </cfif>
 <cfif #isDefined ("pay_cod")#>
  <cfset #pay_cod# = "1">
 <cfelse>
  <cfset #pay_cod# = "0">
 </cfif>
 <cfif #isDefined ("pay_see_desc")#>
  <cfset #pay_see_desc# = "1">
 <cfelse>
  <cfset #pay_see_desc# = "0">
 </cfif>
 <cfif #isDefined ("pay_pcheck")#>
  <cfset #pay_pcheck# = "1">
 <cfelse>
  <cfset #pay_pcheck# = "0">
 </cfif>
 <cfif #isDefined ("pay_ol_escrow")#>
  <cfset #pay_ol_escrow# = "1">
 <cfelse>
  <cfset #pay_ol_escrow# = "0">
 </cfif>
 <cfif #isDefined ("pay_other")#>
  <cfset #pay_other# = "1">
 <cfelse>
  <cfset #pay_other# = "0">
 </cfif>
 <cfif #isDefined ("pay_visa_mc")#>
  <cfset #pay_visa_mc# = "1">
 <cfelse>
  <cfset #pay_visa_mc# = "0">
 </cfif>
 <cfif #isDefined ("pay_am_express")#>
  <cfset #pay_am_express# = "1">
 <cfelse>
  <cfset #pay_am_express# = "0">
 </cfif>
 <cfif #isDefined ("pay_discover")#>
  <cfset #pay_discover# = "1">
 <cfelse>
  <cfset #pay_discover# = "0">
 </cfif>
 <cfif #isDefined ("ship_sell_pays")#>
  <cfset #ship_sell_pays# = "1">
 <cfelse>
  <cfset #ship_sell_pays# = "0">
 </cfif>
 <cfif #isDefined ("ship_buy_pays_act")#>
  <cfset #ship_buy_pays_act# = "1">
 <cfelse>
  <cfset #ship_buy_pays_act# = "0">
 </cfif>
 <cfif #isDefined ("ship_see_desc")#>
  <cfset #ship_see_desc# = "1">
 <cfelse>
  <cfset #ship_see_desc# = "0">
 </cfif>
 <cfif #isDefined ("ship_buy_pays_fxd")#>
  <cfset #ship_buy_pays_fxd# = "1">
 <cfelse>
  <cfset #ship_buy_pays_fxd# = "0">
 </cfif>
 <cfif #isDefined ("ship_international")#>
  <cfset #ship_international# = "1">
 <cfelse>
  <cfset #ship_international# = "0">
 </cfif>
 <cfif #isDefined ("increment")#>
  <cfset #increment# = "1">
 <cfelse>
  <cfset #increment# = "0">
 </cfif>
 <cfif #isDefined ("dynamic")#>
  <cfset #dynamic# = "1">
 <cfelse>
  <cfset #dynamic# = "0">
 </cfif> 
 <cfif #isDefined ("featured")#>
  <cfset #featured# = "1">
 <cfelse>
  <cfset #featured# = "0">
 </cfif>
 <cfif #isDefined ("featured_cat")#>
  <cfset #featured_cat# = "1">
 <cfelse>
  <cfset #featured_cat# = "0">
 </cfif>
 <cfif #isDefined ("private")#>
  <cfset #private# = "1">
 <cfelse>
  <cfset #private# = "0">
 </cfif> 
 <cfif #isDefined ("banner")#>
  <cfset #banner# = "1">
 <cfelse>
  <cfset #banner# = "0">
 </cfif>

 <cfif #isDefined ("studio")#>
  <cfset #studio# = studio>
 <cfelse>
  <cfset #studio# = "0">
 </cfif>

 <cfif #isDefined ("featured_studio")#>
  <cfset #featured_studio# = featured_studio>
 <cfelse>
  <cfset #featured_studio# = "0">
 </cfif>  
 
 <cfif NOT isDefined("selected_user")>
 <cfset selected_user = #session.user_id#>
 </cfif>
  
 <cfif #isDefined ("selected_auction_type")# is 0>
  <cfset #selected_auction_type# = "E">
 </cfif>

 <cfif #isDefined ("buynow_price")#>
  <cfset #buynow_price# = #buynow_price#>
 <cfelse>
  <cfset #buynow_price# = 0>
 </cfif>



 <!--- Set defaults for all the form variables --->
 <cfif ((#submit# is "Edit") or (#submit# is "Add")) and (#submit2# is "enter")> 
  
  <cfif #submit# is "Add">
  <cfset #selected_item# = "#EPOCH#">
  <cfset #selected_user# = "#get_seller.pair#">
  </cfif>
  <cfset #status# = "">
  <cfset #user_id# = "">
  <cfset #category1# = "#selected_category#">
  <cfparam name="category2" default="-1">
  <cfset #title# = "">
  <cfset #location# = "">
  <cfset #country# = "USA">
  <cfset #description# = "">
  <cfset #desc_languages# = "">
  <cfset #picture# = "http://">
<!---  <cfset #picture1# = "">--->
  <cfset #sound# = "http://">
  <cfset #picture_studio# = "http://">
  <cfset #sound_studio# = "http://">
  <cfset #quantity# = "1">
  <cfset #minimum_bid# = "">
  <cfset #maximum_bid# = "">
  <cfset #increment_valu# = "0">
  <cfset #dynamic_valu# = "0">
  <cfset #reserve_bid# = "0">
  <cfset #banner_line# = "">
  <cfset #date_start# = "#now ()#">
  <cfset #date_end# = "#now ()#">
  <cfset #seller_email# = "">
  <cfset #featured# = "0">
  <cfset #private# = "0">
  <cfset #shipping_fee# = "0">
  <cfset #sales_tax# = "0">
 <!--- <cfset #auction_mode# = get_item.auction_mode> 
   --->

 </cfif>

 <!--- Check to see if we're editing an auction item --->
 <cfif ((#submit2# is "enter") OR (#submit2# is "Save")) and (#session.query_done# is "not")>

  <cfquery username="#db_username#" password="#db_password#" name="get_item" dataSource="#DATASOURCE#">
   SELECT itemnum,
          status,
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
          auction_type,
		    auction_mode,
			auto_relist,
			private,
			buynow_price,
			buynow,
			shipping_fee,
			salestax
     FROM items
    WHERE itemnum = #selected_item#
  </cfquery>
  <cfset #selected_category# = #get_item.category1#>

<!--- Security Check 
<CFIF #get_item.user_id# neq #get_users.user_id#>
<CFABORT>
</CFIF>
--->

  <!--- Get the seller's email address --->
  <cfquery username="#db_username#" password="#db_password#" name="get_seller_email" datasource="#DATASOURCE#">
   SELECT email
     FROM users
    WHERE user_id = #get_item.user_id#
  </cfquery>
  <cfset #seller_email# = "#get_seller_email.email#">
  <cfset #session.seller_email# = "#get_seller_email.email#">

  <cfset #itemnum# = "#get_item.itemnum#">
  <cfset #session.itemnum# = "#get_item.itemnum#">
  <cfset #the_item# = "#get_item.itemnum#">
  <cfset #session.the_item# = "#get_item.itemnum#">
  <cfset #status# = "#get_item.status#">
  <cfset #user_id# = "#get_item.user_id#">
  <cfset #session.user_id# = "#get_item.user_id#">
  <cfset #category1# = "#get_item.category1#">
  <cfset #category2# = "#get_item.category2#">
  <cfset #title# = "#get_item.title#">
  <cfset #session.title# = "#get_item.title#">
  <cfset #location# = "#get_item.location#">
  <cfset #country# = "#get_item.country#">
  <cfset #pay_morder_ccheck# = "#get_item.pay_morder_ccheck#">
  <cfset #pay_cod# = "#get_item.pay_cod#">
  <cfset #pay_see_desc# = "#get_item.pay_see_desc#">
  <cfset #pay_pcheck# = "#get_item.pay_pcheck#">
  <cfset #pay_ol_escrow# = "#get_item.pay_ol_escrow#">
  <cfset #pay_other# = "#get_item.pay_other#">
  <cfset #pay_visa_mc# = "#get_item.pay_visa_mc#">
  <cfset #pay_am_express# = "#get_item.pay_am_express#">
  <cfset #pay_discover# = "#get_item.pay_discover#">
  <cfset #ship_sell_pays# = "#get_item.ship_sell_pays#">
  <cfset #ship_buy_pays_act# = "#get_item.ship_buy_pays_act#">
  <cfset #ship_see_desc# = "#get_item.ship_see_desc#">
  <cfset #ship_buy_pays_fxd# = "#get_item.ship_buy_pays_fxd#">
  <cfset #ship_international# = "#get_item.ship_international#">
  <cfset #description# = "#get_item.description#">
  <cfset #desc_languages# = "#get_item.desc_languages#">
  <cfset #picture# = #trim ("#get_item.picture#")#>
  <cfset #picture1# = #trim ("#get_item.picture1#")#>
  <cfset #picture2# = #trim ("#get_item.picture2#")#>
  <cfset #picture3# = #trim ("#get_item.picture3#")#>
  <cfset #picture4# = #trim ("#get_item.picture4#")#>
  <cfset #sound# = #trim ("#get_item.sound#")#>
  <cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
   <cfset #picture# = "http://#picture#">
  </cfif>
  <cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
   <cfset #sound# = "http://#sound#">
  </cfif>
  <cfset #quantity# = "#get_item.quantity#">
  <cfset #minimum_bid# = "#get_item.minimum_bid#">
  <cfset #maximum_bid# = "#get_item.maximum_bid#">
  <cfset #increment# = "#get_item.increment#">
  <cfset #increment_valu# = "#get_item.increment_valu#">
  <cfset #dynamic# = "#get_item.dynamic#">
  <cfset #dynamic_valu# = "#get_item.dynamic_valu#">
  <cfset #reserve_bid# = "#get_item.reserve_bid#">
  <cfset #bold_title# = "#get_item.bold_title#">
  <cfset #featured# = "#get_item.featured#">
  <cfset #featured_cat# = "#get_item.featured_cat#">
  <cfset #private# = "#get_item.private#">
  <cfset #banner# = "#get_item.banner#">
  <cfset #banner_line# = "#get_item.banner_line#">
  <cfset #studio# = "#get_item.studio#">
  <cfset #featured_studio# = "#get_item.featured_studio#">
  <cfset #picture_studio# = #trim ("#get_item.picture_studio#")#>
  <cfset #sound_studio# = #trim ("#get_item.sound_studio#")#>
  <cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
   <cfset #picture_studio# = "http://#picture_studio#">
  </cfif>
  <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
   <cfset #sound_studio# = "http://#sound_studio#">
  </cfif>
  <cfset #date_start# = "#get_item.date_start#">
  <cfset #date_end# = "#get_item.date_end#">
  <cfset #selected_user# = "#get_item.user_id#">
  <cfset #selected_auction_type# = "#get_item.auction_type#">
  <cfset #session.query_done# = "done">
  <cfset auction_mode = get_item.auction_mode>
  <cfset auto_relist = get_item.auto_relist>
  <cfset private = get_item.private>
  <cfset buynow = get_item.buynow>
  <cfset buynow_price = get_item.buynow_price>
  <cfif get_item.shipping_fee eq ""><cfset shipping_fee = 0><cfelse><cfset shipping_fee = get_item.shipping_fee></cfif>
  <cfif get_item.salestax eq ""><cfset salestax = 0><cfelse><cfset salestax = get_item.salestax></cfif>
</cfif> 




 <!--- Run a query to find all active categories --->
 <cfquery username="#db_username#" password="#db_password#" name="get_cats" dataSource="#DATASOURCE#">
  SELECT name, category, user_id
    FROM categories
   WHERE active = 1
     AND parent > -1
   ORDER by name
 </cfquery>

 <!--- Run a query to find all increments --->
  <cfquery username="#db_username#" password="#db_password#" name="get_increments" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'increment'
       AND pair <> '0000'
     ORDER BY pair
  </cfquery>
 
 <!--- Run a query to find all durations --->
 <cfquery username="#db_username#" password="#db_password#" name="get_durations" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'duration'
   ORDER BY pair
 </cfquery>
 <!--- Run queries to find cat_fee enable --->
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_cat_fee" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_cat_fee'
  </cfquery>
  <cfset #enable_cat_fee# = #get_enable_cat_fee.pair#>
 <!--- Run a query to find the default duration --->
 <cfquery username="#db_username#" password="#db_password#" name="get_def_duration" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'def_duration'
   ORDER BY pair
 </cfquery>
 <cfquery username="#db_username#" password="#db_password#" name="get_fee_banner" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_banner'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_bold" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_bold'
</cfquery>
 <cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_cat" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_feat_cat'
</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="get_fee_featured" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_featured'
</cfquery>
 
 <cfquery username="#db_username#" password="#db_password#" name="get_fee_second_cat" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
    WHERE name = 'fee_second_cat'
 </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_studio" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_studio'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_studio" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_feat_studio'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture1" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture1'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture2" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture2'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture3" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture3'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture4" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture4'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_reserve_bid" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'fee_reserve_bid'
  </cfquery>
  
  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <!--- get bid count --->
<cfquery username="#db_username#" password="#db_password#" name="get_bid_cnt" datasource="#DATASOURCE#">
	SELECT id
	FROM bids
	WHERE itemnum = #selected_item#
</cfquery>
 
  <!--- Get user_id from new category selection --->

 <cfif isDefined("form.category1")>
 <cfquery username="#db_username#" password="#db_password#" NAME="getcat1_user_id" DATASOURCE="#Datasource#">
SELECT user_id FROM categories
WHERE category = #form.category1#
</CFQUERY></cfif>
  
   <cfquery username="#db_username#" password="#db_password#" NAME="getcat2_user_id" DATASOURCE="#Datasource#">
        SELECT category,user_id,name FROM categories
		<CFIF isDefined('form.category2')>
         WHERE category = #form.category2#
		 <cfelseif isDefined('get_item.category2')>
		 WHERE category = #get_item.category2#
		 <cfelse>
		  WHERE category = -1
		 </CFIF></CFQUERY>
<!--- <cfif isDefined("form.category2")>
 <cfquery username="#db_username#" password="#db_password#" NAME="getcat2_user_id" DATASOURCE="#Datasource#">
SELECT user_id,name FROM categories
WHERE category = #form.category2#
</CFQUERY>

<cfif #getcat2_user_id.recordcount# gt 0>
<cfset cat2user_id = "#getcat2_user_id.user_id#">
    <cfelse>
   <cfset cat2user_id = 0>
  </cfif></cfif> --->
  

 <!--- Reset the error message string --->
 	<!--- <cfset #error_message# = ""> --->
 <cfparam name="error_message" default="">

 <!--- Check the form for valid data --->
 <cfif #submit2# is "Save">

<!--- Corrected blank Page --->

 	<cfif auction_mode eq 0>
 		<cfif buynow_price gt 0>
      		<cfset buynow = 1>
 		<cfelse>
 			<cfset buynow = 0>
  		</cfif>
	</cfif>


  <cfif #trim (title)# is "">
   <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
  <cfelseif (#trim (quantity)# is "") or (#isNumeric (quantity)# is 0)>
   <cfset #error_message# = "<font color=ff0000>Please enter a valid quantity for this item.</font>">
  <cfelseif not isNumeric(buynow_price) or #buynow_price# eq "">
		<cfset #error_message# = "<font color=ff0000>Please double check the buy now price the default is 0 and required to be numeric.</font>">
  <cfelseif auction_mode eq 0 and buynow eq 1 and (not isNumeric(buynow_price) or #buynow_price# lt #minimum_bid#)>
		<cfset #error_message# = "<font color=ff0000>Please double check the buy now price for this item.</font>">
  <cfelseif auction_mode eq 0 and buynow eq 1 and #buynow_price# lt #reserve_bid#>
		<cfset #error_message# = "<font color=ff0000>The buynow option does not allow reserve bid greater than buynow price.</font>">
  <cfelseif form.auction_mode is 0 and (#selected_auction_type# is "D" or #selected_auction_type# is "Y") and #trim (reserve_bid)# gt 0>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">
	<cfelseif form.auction_mode is 1 and #trim (reserve_bid)# gt 0 and #trim (reserve_bid)# lt maximum_bid>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">
   <!--- 
  <cfelseif #trim (description)# is "">
   <cfset #error_message# = "<font color=ff0000>Please enter a description of this item.</font>"> 
   --->
  <cfelseif #isDefined ("desc_languages")# is "0">
   <cfset #error_message# = "<font color=ff0000>Please specify the language(s) the description is in.</font>"> 
   <cfset #desc_languages# = "">
  <cfelseif #trim (location)# is "">
   <cfset #error_message# = "<font color=ff0000>Please enter a location where this item will be shipped from.</font>"> 
  <cfelseif #trim (country)# is "">
   <cfset #error_message# = "<font color=ff0000>Please specify a country where this item will be shipped from.</font>"> 
  <cfelseif isDefined("category1") AND isDefined("category2")>
  <cfif (#category1# is "-1") and (#category2# is "-1")>
   <cfset #error_message# = "<font color=ff0000>Please specify at least 1 auction category for this item.</font>"> 
   </cfif>

<!--check for exclusive category and match logon user_id with category user_id -->
<cfelseif isDefined("getcat1_user_id.user_id")>
<CFIF #getcat1_user_id.user_id# is not 0>
<cfif (#selected_user# is not #getcat1_user_id.user_id#)>
<cfset #error_message# = "You are not authorized to enter items in this auction. Please contact the site administrator to list items in your own exclusive category.">
</CFIF></cfif>

<CFELSEIF (#getcat2_user_id.user_id# is not 0) and (#cat2user_id# is not 0)>
<cfif (#selected_user# is not #getcat2_user_id.user_id#) or (#selected_user# is not #cat2user_id#)>
<cfset #error_message# = "You are not authorized to enter items in this auction. Please contact the site administrator to list items in your own exclusive category.">
</CFIF> 
 <!-- end check --->

  
<!---
  <cfelseif (#trim (minimum_bid)# is "") or (#minimum_bid# is "0") or (#isNumeric (minimum_bid)# is "0")>
   <cfset #error_message# = "<font color=ff0000>Please specify a minimum bid value for this item.</font>"> 
--->
   
  </cfif>
 </cfif>

  <!--- Check to see if we're saving an auction item --->
  <cfif #submit2# is "Save">
    <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
  </cfif>
  
  <cfif (#submit2# is "Save") and (#error_message# is "")>
    
    <cfif #submit# is "Edit">
	
<!--- Upload thumb --->
	<cfif isdefined('form.thumb') and form.thumb is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","thumbs")>
  <cfif fileexists("#directory##selected_item#.jpg")>
	<cffile action="delete"	file="#directory##selected_item#.jpg">
	<cfelseif fileexists("#directory##selected_item#.gif")>
	<cffile action="delete"	file="#directory##selected_item#.gif">
	</cfif>
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

<!--- New Defaults --->
<cfset Img_Height = 124>
<cfset Img_width = 110>

<!---  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#"> --->
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_height GT 124>
<!--- <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="124"> --->
  </cfif>
  <cfif Img_width GT 110>
  <!--- <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="110"> --->
  </cfif>
  
  <cfset incoming = #URLEncodedFormat(File.ServerFile)#>
  <cfset serverfile = #File.ServerFile#>
  <cfset studio = 1>
  <cfif isDefined('form.featured_studio')>
  <cfset featured_studio = 1>
  <cfelse>
  <cfset featured_studio = 0>
  </cfif>
</cfif>

<!--- Rename thumbnail with item number ---> 
  <cfif #isDefined ("incoming")#>  
    <cfset #curPath# = GetTemplatePath()>
    <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal","thumbs")>
    <cfif IsDefined("serverfile") and #serverfile# NEQ "">      
     <cfif fileExists("#directory##serverfile#")>
      <cffile action="rename"
       SOURCE = "#directory##serverfile#"  
       DESTINATION = "#directory##form.selected_item##right(serverfile,4)#">
      </cfif>
    <cfelse>
      <cfif fileExists("#directory##incoming#")>
        <cffile action="rename"
          SOURCE = "#directory##incoming#"  
          DESTINATION = "#directory##form.selected_item##right(incoming,4)#">
      </cfif>
    </cfif>
  </cfif>
 
      <!--- Make sure images and sounds begin with http:// --->
      <cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
        <cfset #picture# = "http://#picture#">
      </cfif>


	  <cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
        <cfset #sound# = "http://#sound#">
      </cfif>
      <cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
        <cfset #picture_studio# = "http://#picture_studio#">
      </cfif>
      <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
        <cfset #sound_studio# = "http://#sound_studio#">
      </cfif>

	<cfif auction_mode eq 0>
		<cfif buynow_price gt 0 and buynow_price gte #minimum_bid#>
			<cfset buynow = 1>
		<cfelse>
			<cfset buynow = 0>
		</cfif>
	</cfif>



<cfquery name="getlvls" datasource="#datasource#">

select lvl_1,lvl_2,lvl_3,lvl_4,lvl_5,lvl_6,lvl_7,lvl_8 from categories where category =
             #category1# 
			 and category > 0
</cfquery>


<cfquery name="getlvls2" datasource="#datasource#">

select lvl_1,lvl_2,lvl_3,lvl_4,lvl_5,lvl_6,lvl_7,lvl_8 from categories where category =
            <CFIF isDefined('form.category2')>#form.category2#<CFELSE>#category2#</CFIF>
			 AND category > 0
</cfquery>

 
      <!--- update auction info --->


      <cfquery username="#db_username#" password="#db_password#" name="update_item" datasource="#DATASOURCE#"> 
          UPDATE items
             SET status = #status#,
                 user_id = #selected_user#,
                 category1 = #category1#,
				 <CFIF isDefined('form.category2')>category2 = #form.category2#,<CFELSE>category2 = #category2#,</CFIF>
                 title = '#title#',
                 location = '#location#',
                 country = '#country#',
                 pay_morder_ccheck = #pay_morder_ccheck#,
                 pay_cod = #pay_cod#,
                 pay_see_desc = #pay_see_desc#,
                 pay_pcheck = #pay_pcheck#,
                 pay_ol_escrow = #pay_ol_escrow#,
                 pay_other = #pay_other#,
                 pay_visa_mc = #pay_visa_mc#,
                 pay_am_express = #pay_am_express#,
                 pay_discover = #pay_discover#,
                 ship_sell_pays = #ship_sell_pays#,
                 ship_buy_pays_act = #ship_buy_pays_act#,
                 ship_see_desc = #ship_see_desc#,
                 ship_buy_pays_fxd = #ship_buy_pays_fxd#,
                 ship_international = #ship_international#,
                 desc_languages = '#desc_languages#',
                 picture = '#picture#',
				 <cfif picture1 neq "">picture1 = '#selected_item##right(picture1,4)#',</cfif>
				 <cfif picture2 neq "">picture2 = '#selected_item##right(picture2,4)#',</cfif>
				 <cfif picture3 neq "">picture3 = '#selected_item##right(picture3,4)#',</cfif>
				 <cfif picture4 neq "">picture4 = '#selected_item##right(picture4,4)#',</cfif>
				 sound = '#sound#',
                 quantity = #quantity#,
                 minimum_bid = #minimum_bid#,
				 maximum_bid = #maximum_bid#,
                 increment = #increment#,
                 increment_valu = #increment_valu#,
                 dynamic = #dynamic#,
                 dynamic_valu = #dynamic_valu#,
				 <cfif auction_mode eq 1>
                 reserve_bid = #maximum_bid#,
				 <cfelse>
				 reserve_bid = #reserve_bid#,
				 </cfif>
                 bold_title = #bold_title#,
				 banner = #banner#,
                 banner_line = '#banner_line#',
                 studio = #studio#,
                 featured_studio = #featured_studio#,
				 featured = #featured#,
				 featured_cat = #featured_cat#,
                 picture_studio = '#picture_studio#',
                 sound_studio = '#sound_studio#',
                 date_start = #createODBCDateTime (date_start)#,
                 date_end = #createODBCDateTime (date_end)#,
				 auto_relist = #auto_relist#,
				 private = #private#,
				 auction_mode = #auction_mode#,
				 shipping_fee = '#shipping_fee#',
				 salestax = '#salestax#'
				 <cfif auction_mode eq 0>,
				 buynow_price = #buynow_price#,
				 buynow = #buynow#</cfif>
				 <cfif getlvls.recordcount>
 ,lvl_1 = #getlvls.lvl_1#,
 lvl_2 = #getlvls.lvl_2#,
 lvl_3 = #getlvls.lvl_3#,
 lvl_4 = #getlvls.lvl_4#,
 lvl_5 = #getlvls.lvl_5#,
 lvl_6 = #getlvls.lvl_6#,
 lvl_7 = #getlvls.lvl_7#,
 lvl_8 = #getlvls.lvl_8#
</cfif><cfif getlvls2.recordcount>
 ,cat2_lvl_1 = #getlvls2.lvl_1#,
 cat2_lvl_2 = #getlvls2.lvl_2#,
 cat2_lvl_3 = #getlvls2.lvl_3#,
 cat2_lvl_4 = #getlvls2.lvl_4#,
 cat2_lvl_5 = #getlvls2.lvl_5#,
 cat2_lvl_6 = #getlvls2.lvl_6#,
 cat2_lvl_7 = #getlvls2.lvl_7#,
 cat2_lvl_8 = #getlvls2.lvl_8# 
</cfif>
           WHERE itemnum = #selected_item#
      </cfquery>

      
      <!--- if should append to desc --->
      <cfif Len(Trim(description))>
        
        <!--- get old desc --->
        <cfquery username="#db_username#" password="#db_password#" name="getOldDesc" datasource="#DATASOURCE#">
            SELECT description
              FROM items
             WHERE itemnum = #selected_item#
        </cfquery>
        
        <!--- def desc --->
        <cfset sNewDesc = Trim(getOldDesc.description) & Variables.sDescAddendumNote & Trim(description)>
        
        <!--- append desc --->
        <cfquery username="#db_username#" password="#db_password#" name="update_item" datasource="#DATASOURCE#"> 
            UPDATE items
			   <!--- <cfif #get_bid_cnt.recordcount# gt 0>
               SET description = '#Variables.sNewDesc#'
			   <cfelseif #get_bid_cnt.recordcount# eq 0>
			   SET description = '#description#'
			   </cfif> --->
			   SET description = '#description#'
             WHERE itemnum = #selected_item#
        </cfquery>
      </cfif>
      
      <!--- log update to transactions --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Auction Updated"
        itemnum="#selected_item#"
        details="#title#"
        user_id="#selected_user#">
        

      
      <!--- Keep track of who they used as the seller --->
      <cfquery username="#db_username#" password="#db_password#" name="update_last_seller" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#selected_user#'
           WHERE name = 'last_seller'
      </cfquery>
      
    </cfif>

<!--- NEW cflocation --->
 <cfoutput><cflocation url="main_page.cfm"></cfoutput>

<!---    
    <cfoutput><cflocation url="edit_info.cfm?selected_category=#selected_category#&submit=expand&selected_item=#selected_item#&submit3=Another"></cfoutput>--->

  <cfelseif (#submit2# is "Save") and (#error_message# neq "")>

  	<cfoutput><cflocation url="edit_info.cfm?selected_item=#selected_item#&itemnum=#selected_item#&submit=edit&error_message=#error_message#"></cfoutput>
  </cfif>



  <cfif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "listings">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\","thumbs\")#>
  </cfif>
  <cfif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "search">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"search\","thumbs\")#>
  </cfif>  
  <cfif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "personal">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"personal\","thumbs\")#>
  </cfif>
  
     
  <cfif #studio# is 1>
    <cfif fileExists("#thePath##itemnum#.jpg")>
      <cfset theThumb = "<IMG width=124 height=110 src=../thumbs/#itemnum#.jpg>">
    <cfelseif fileExists("#thePath##itemnum#.gif")>
      <cfset theThumb = "<IMG width=124 height=110 src=../thumbs/#itemnum#.gif>">
    </cfif>
  </cfif>      


<cfquery name="selected_cat" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">
SELECT category, name
FROM categories
<cfif isDefined('selected_cat')>where category = #selected_category#<cfelseif isDefined('session.category1')> where category = #session.category1#<cfelseif isDefined('get_item.category1')> where category = #get_item.category1#<cfelse> </cfif>
</cfquery>
<!---
<cfquery name="selected_cat_subs" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT category, name
FROM categories
where parent = #session.category1#
</cfquery>

--->





  
  <cfsetting EnableCFOutputOnly="NO">
  
   <html>
 <head>
  <title>Personal Page: Item Edit </title>
  <cfoutput><link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css"></cfoutput>
 </head>

 <!--- Main page body --->
 <cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
 
  <!--- Some JavaScript for the "Preview" buttons --->
  <script language="JavaScript">

   // Opens a new browser window with no titlebar and the given size, and
   // loads the given URL into it.
   function openWindow (URL, width, height) {
//alert(URL, width, height)
      window.open (URL, "previewWindow", "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
   }
   
   function doThis(){
  if (document.item_input.thumb.value=="" && document.item_input.studio.value==0){
    document.item_input.featured_studio.checked=false
    alert("Thumbnail Source above is empty.\nPlease browse to the thumbnail on your local system.")
  } 
} 
  </script>
  <font face="helvetica" size=2>
   <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><b>Edit Item Page</b></font></td></tr>
	<tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
	<tr>
     <td>
      <font size=3>
       This page will allow you to edit an item you currently have up for
       auction.  You may change most of the information about your
       item, but please note that some of the information such as the
       item's price and bidding type/increment cannot be changed.
      </font>
     <tr>
     <tr>
      <td colspan=5 bgcolor=ffffff>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
       <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
            <td colspan=2>
             <font face="helvetica" size=2 color=000000>
              Please fill out or modify the following form for this auction item. Click "Save" to save your<br>
              changes in the database, or click "Cancel" to ignore changes and return to the previous page.
              <hr size=1 color=#heading_color# width=100%>
             </font>
            </td>
           </tr>
           <tr>
            <td valign="top"><!-- This is a test Comment, Top of form  -->
             <form name="item_input" enctype="multipart/form-data" action="edit_info.cfm" method="post">          
              &nbsp;<font face="Helvetica" size=2 color=000080><b>AUCTION ITEM INFORMATION:</b><br></font>
              &nbsp;<font color="000000">(Fields in <font color="0000ff">blue</font> are required)</font>
              <cfif #error_message# is not "">
               <cfoutput><font face="Helvetica" size=2 color=ff0000><br><br><b>ERROR:</b> #error_message#</font></cfoutput>
              </cfif>
              <cfoutput>
               <cfif #isDefined ("submit")#>
                <input type="hidden" name="submit" value="#submit#">
               </cfif>
               <input type="hidden" name="user_id" value="#user_id#">
               <input type="hidden" name="selected_category" value="#selected_category#">
               <input type="hidden" name="studio" value="#Studio#">
               
                
               <cfif #submit# is "Edit">
                <input type="hidden" name="selected_item" value="#selected_item#">
               <cfelseif #submit# is "Add">
                <input type="hidden" name="selected_item" value="#EPOCH#">
               </cfif>
              <table border=0 bordercolor=0 cellspacing=0 cellpadding=2>
               <tr>
                <td>
                 <table border=0 cellspacing=0 cellpadding=2>
                  <tr>
                   <td><font face="helvetica" size=2 color="000000"><b>Item ID ##:</b></font></td>
                   <td>&nbsp;</td>
                   <td><!--- #itemnum# --->#selected_item#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Seller:</b></font></td>
                   <td>&nbsp;</td>
                   <td>#get_users.nickname# (#get_users.name#)&nbsp;&nbsp;&nbsp;</td>
                  </tr>
                  <tr>

              <cfif auction_mode is 1>
                <cfset reverse_icon = '<IMG SRC="../../images/R_reverse.gif" width=22 height=17 border=0 alt="This is a Reverse Auction">'>
              <cfelse>
                <cfset reverse_icon = "">               
              </cfif>


                   <td><font face="helvetica" size=2 color="0000ff"><b>Title:</b></font></td>
                   <td>&nbsp;&nbsp;</td>
                  
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="text" size=35 maxlength=255 value="#session.title#">#reverse_icon#</td>
                   <td>
                     <cfif #bold_title# is "1">
                       &nbsp;[Bold Title is Selected]<cfset #bold_title#="1">
                       <input name="bold_title" type="hidden" value="1">
                     <cfelse>
                       <input name="bold_title" type="checkbox" value="1"<cfif #bold_title# is "1">checked</cfif>><font face="helvetica" size=2>&nbsp;Bold title<cfif #get_fee_bold.pair# GT 0> <font face="helvetica" size=1>(a #numberformat(get_fee_bold.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font>
                     </cfif>
                   </td>
                 </tr>
               </table>
               </td>
                 </tr>
                 <tr>
                   <td><font face="helvetica" size=2><b>Banner:</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="banner_line" type="text" size=35 maxlength=45 value="#banner_line#"></td><td><cfif #banner# is "1"><input name="banner" type="hidden" value="1"><font face="helvetica" size=2>&nbsp;[Banner is active]</font><cfelse><input name="banner" type="checkbox" value="1"<cfif #banner# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enable banner<cfif #get_fee_banner.pair# GT 0> <font face="helvetica" size=1>(a #numberformat(get_fee_banner.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></cfif></td></tr><td></td><td></td></table></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Quantity:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><input name="quantity" type="hidden" size=5 maxlength=6 value="#quantity#">#quantity#</td>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Description<br>Addendum:</font><br><font face="helvetica" size=1 color="0000ff">Will replace current description<br>if no bids have been placed</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><textarea name="description" rows=5 cols=50>#description#</textarea></td>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Description<br>Languages:</b></font></td>
                   <td>&nbsp;</td>

                   <td colspan=2>
                    <cfmodule template="..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="desc_languages" selected="#desc_languages#" size=5 multiple="yes">
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Location:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><input name="location" type="text" size=35 maxlength=100 value="#location#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Country:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                 	<CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1">
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr> 
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Start Date/Time:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfif #submit# is "Edit">
                       <cfset #the_month# = #datePart ("m", "#date_start#")#>
                       <cfset #the_day# = #datePart ("d", "#date_start#")#>
                       <cfset #the_year# = #datePart ("yyyy", "#date_start#")#>
                       <cfset #the_time# = #timeFormat ("#date_start#", 'hh:mm')#>
                       <cfset #the_time_s# = #timeFormat ("#date_start#", 'tt')#>
                      <cfelse>
                       <cfset #the_month# = #datePart ("m", "#now ()#")#>
                       <cfset #the_day# = #datePart ("d", "#now ()#")#>
                       <cfset #the_year# = #datePart ("yyyy", "#now ()#")#>
                       <cfset #the_time# = #timeFormat ("#now ()#", 'hh:mm')#>
                       <cfset #the_time_s# = #timeFormat ("#now ()#", 'tt')#>
                      </cfif>
                      <td>
                       <input name="start_month" type=hidden size=3 maxlength=3 value="#the_month#">
                      <cfif #the_month# is "1">Jan </cfif>
					  <cfif #the_month# is "2">Feb </cfif>
					  <cfif #the_month# is "3">Mar </cfif>
					  <cfif #the_month# is "4">Apr </cfif>
					  <cfif #the_month# is "5">May </cfif>
					  <cfif #the_month# is "6">Jun </cfif>
					  <cfif #the_month# is "7">Jul </cfif>
					  <cfif #the_month# is "8">Aug </cfif>
					  <cfif #the_month# is "9">Sep </cfif>
					  <cfif #the_month# is "10">Oct </cfif>
					  <cfif #the_month# is "11">Nov </cfif>
					  <cfif #the_month# is "12">Dec </cfif>
					  </td>
                      <td><input name="start_day" type="hidden" size=2 maxlength=2 value="#the_day#">#the_day#, </td>
                      <td><input name="start_year" type="hidden" size=4 maxlength=4 value="#the_year#">#the_year# </td>
                      <td><font face="helvetica" size=2>&nbsp;at&nbsp;</font></td>
                      <td><input name="start_time" type="hidden" size=5 maxlength=5 value="#the_time#">#the_time#</td>
                      <td>
                       <input name="start_time_s" type="hidden" size=2 maxlength=2 value="#the_time_s#"> #the_time_s#
                      </td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Auction Duration:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0>
                     <tr>
                      <cfset #the_duration# = #dateDiff ("d", date_start, date_end)#>
                      <td><input name="duration" type="hidden" value="#the_duration#">#the_duration#                 
                      
                       </select></td>
                      <td><font face="helvetica" size=2>&nbsp;day(s)</font></td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                 <cfif #submit# is "Add">
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Auction Type:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <select name="selected_auction_type">
                     <option value="E"<cfif #selected_auction_type# is "E"> selected</cfif>>English (Normal)</option>
                     <option value="D"<cfif #selected_auction_type# is "D"> selected</cfif>>Dutch</option>
                     <option value="Y"<cfif #selected_auction_type# is "Y"> selected</cfif>>Yankee</option>
                     <option value="V"<cfif #selected_auction_type# is "V"> selected</cfif>>Vickrey</option>
                    </select>
                   </td>
                  </tr>
                 <cfelse>
                  <tr>
                   <td><font face="helvetica" size=2 color="000000"><b>Auction Type:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <font face="helvetica" size=2>
                     <cfif #selected_auction_type# is "E">English</cfif>
                     <cfif #selected_auction_type# is "D">Dutch</cfif>
                     <cfif #selected_auction_type# is "Y">Yankee</cfif>
                     <cfif #selected_auction_type# is "V">Vickrey</cfif>
					 <input type=hidden name="selected_auction_type" value="#selected_auction_type#">
                    </font>
                   </td>
                  </tr>
                 </cfif>
				 <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Categories<br>Auctioned In:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2 valign="top">
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#get_item.category1#">
                    <br>
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category2"
                              show_none="yes"
                              selected="#get_item.category2#">
                   </td>
                  </tr> 
				 
				 
				 
	<!---			 
  <tr>
       <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Current Category:<br><BR>2nd Category:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top"> </cfoutput>
	   
<cfoutput query="selected_cat"><BR><font size=3 color=000000><b>#name#</b></font> (<a href="/listings/categories/top_cats.cfm?from=edit_info&itemnum=#itemnum#">Click Here</A> to select a new category.)<BR>
		<input type=hidden name="category1" value="#category#">
	</cfoutput>


	   
		
	    <br>
        <table border=0 cellspacing=0 cellpadding=0><tr><td><BR>
		<select name="category2">
		<option value="-1"> None </option>
		<cfif getcat2_user_id.recordcount gt 0>
		<cfoutput><option value="#category2#" selected>#getcat2_user_id.name#</option></cfoutput>
		</cfif>
		<cfinclude template = "../sell/options.txt">
		</select><cfoutput>
		</td><td valign="bottom"><cfif enable_cat_fee eq 1><font size=2>(<a href="../listings/categories/cat_fees.cfm" target="_blank">Click Here</a> to see fee for listing in a second category)</font><cfelse><cfif #get_fee_second_cat.pair# GT 0><font face="helvetica" size=1>(a #numberFormat(get_fee_second_cat.pair,numbermask)# #Trim(getCurrency.type)# fee for 2nd category)</font><cfelse>&nbsp;</cfif></cfif></td>
</tr></table>
       </td>
      </tr> --->
<!---                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Categories<br>Auctioned In:</b></font></td>
                   <td>&nbsp;</td>
                  </tr>
				   <cfif #get_bid_cnt.recordcount# gt 0>
				   <!--- get cat name --->
        			<cfquery username="#db_username#" password="#db_password#" name="get_catname" datasource="#DATASOURCE#">
            			SELECT name
              			FROM categories
             			WHERE category = #category1#
        			</cfquery>
                    #get_catname.name#<input name="category1" type="hidden" value="#category1#">
					<cfelse>
					<cfmodule template="..\functions\cf_category_tree.cfm"
                  		datasource="#DATASOURCE#"
                  		parent="0"
                  		type="SELECT"
                  		selectname="category1"
                  		selected="#category1#">
					</cfif>
				    <br>
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category2"
                              show_none="yes"
                              selected="#category2#"><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a #numberFormat(get_fee_second_cat.pair,numbermask)# #Trim(getCurrency.type)# fee for 2nd category)</font><cfelse>&nbsp;</cfif>
                   </td>
                  </tr>--->
				 <!---   <tr>
        <td><font size=3><b>Picture URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#" >
            </td><td align=center>

<input type="button" name="previewImage" value="Preview" onClick="if (document.item_input.picture.value != 'http://')
            openWindow('preview_image.cfm?image=' + escape(document.item_input.picture.value) 
            + '&title=' + escape(document.item_input.title.value), 450, 300);">
            </td></tr>
          </table>
         </td>
      </tr>  ---> 
                 <tr>
        <td><font face="helvetica" size=2><b>Picture URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#" >
            </td><td align=center>
<!---
<input type="button" name="previewImage" value="*Preview*" onClick="alert(document.item_input.picture.value)">
--->

<input type="button" name="previewImage" value="Preview" onClick="if (document.item_input.picture.value != 'http://')

Win1 = open('preview_image.cfm?image=' + escape(document.item_input.picture.value)+'&title='+escape(document.item_input.title.value),'','height=300,width=450')
;">
            </td></tr>
          </table>
         </td>
      </tr> 
	  <!--- ******** --->
	  
      <tr><td>&nbsp;</td><td>&nbsp;</td>


		<td><cfif picture1 neq ""><img src="../fullsize_thumbs/#picture1#" width=100 height=100><cfelse>&nbsp;</cfif></td>
	  </tr>

		<tr><td><font face="helvetica" size=2><b>Image1<br>Upload</b></font></td><td>&nbsp;</td><td><input  type="file" name="picture1" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture1.pair# GT 0>A #numberformat(get_fee_picture1.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>

		<tr><td>&nbsp;</td><td>&nbsp;</td>


		<td><cfif picture2 neq ""><img src="../fullsize_thumbs1/#picture2#" width=100 height=100><cfelse>&nbsp;</cfif></td>
	  </tr>

		<tr><td><font face="helvetica" size=2><b>Image2<br>Upload</b></font></td><td>&nbsp;</td><td><input  type="file" name="picture2" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture2.pair# GT 0>A #numberformat(get_fee_picture2.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
		
		<tr><td>&nbsp;</td><td>&nbsp;</td>


		<td><cfif picture3 neq ""><img src="../fullsize_thumbs2/#picture3#" width=100 height=100><cfelse>&nbsp;</cfif></td>
	  </tr>

		<tr><td><font face="helvetica" size=2><b>Image3<br>Upload</b></font></td><td>&nbsp;</td><td><input  type="file" name="picture3" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture3.pair# GT 0>A #numberformat(get_fee_picture3.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>

        <tr><td>&nbsp;</td><td>&nbsp;</td>
		<td><cfif picture4 neq ""><img src="../fullsize_thumbs3/#picture4#" width=100 height=100><cfelse>&nbsp;</cfif></td>
	  </tr>

		<tr><td><font face="helvetica" size=2><b>Image4<br>Upload</b></font></td><td>&nbsp;</td><td><input  type="file" name="picture4" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture4.pair# GT 0>A #numberformat(get_fee_picture4.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>


	  <!--- ******** --->
                  <tr>
                   <td><font face="helvetica" size=2><b>Sound URL:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                    <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="sound" type="text" size=43 maxlength=250 value="#sound#"></td><td>&nbsp;</td><td>&nbsp;<!--- <input type="button" name="previewSound" value="Preview"> ---></td></tr></table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr>



               
                  
                  
                  <cfif #studio# is 1>
   
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>


                       <td colspan=2>#theThumb#</td>

    
                    </tr>
					<tr><td valign="top"><font face="helvetica" size=2><b>The Studio<br>Thumbnail:</b></font></td><td>&nbsp;</td><td><input  type="file" name="thumb" size=43 maxlength=250><br><font size="2">Please make sure that the file to be thumbnailed exists either in your local drive or LAN. .JPG, and .GIF images are supported. Files larger than 600x400 do not resize nicely.
        <cfif #get_fee_studio.pair# GT 0>A #numberFormat(get_fee_studio.pair,numbermask)# #Trim(getCurrency.type)# fee for Studio Thumbnail Upload.</cfif></font></td></tr>
				  <cfelse>
				    <tr>
                      <td valign="top"><font face="helvetica" size=2><b>The Studio<br>Thumbnail:</b></font></td>
                      <td>&nbsp;</td>


                       <td colspan="2"><input  type="file" name="thumb" size=43 maxlength=250><br><font face="helvetica" size="2">Please make sure that the file to be thumbnailed exists either in your local drive or LAN. .JPG, and .GIF images are supported. Files larger than 600x400 do not resize nicely.
        <cfif #get_fee_studio.pair# GT 0>A #numberFormat(get_fee_studio.pair,numbermask)# #Trim(getCurrency.type)# fee for Studio Thumbnail Upload.</cfif></font></td>

    
                    </tr>
					
                  </cfif>
                            

 <input name="picture_studio" type=hidden value="#picture_studio#">
 <input name="sound_studio" type=hidden value="#sound_studio#">

                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr> 
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Accepted<br>Payment<br>Methods:</b></font></td>
                   <td>&nbsp;</td>
                   <td valign="top" colspan=2>
                    <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Cashier's Check/Money Order</font></td>
                      <td width=25>&nbsp;</td>
                      <td><input name="pay_am_express" type="checkbox" value="1"<cfif #pay_am_express# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;American Express card</font></td>
                     </tr>
                     <tr>
                      <td><input name="pay_cod" type="checkbox" value="1"<cfif #pay_cod# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Collect-on-delivery (COD)</font></td>
                      <td>&nbsp;</td>
                      <td><input name="pay_discover" type="checkbox" value="1"<cfif #pay_discover# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Discover card</font></td>
                     </tr>
                     <tr>
                      <td><input name="pay_pcheck" type="checkbox" value="1"<cfif #pay_pcheck# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Personal check</font></td>
                      <td>&nbsp;</td>
                      <td><input name="pay_ol_escrow" type="checkbox" value="1"<cfif #pay_ol_escrow# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;PayPal</font></td>
                     </tr>
                     <tr>
                      <td><input name="pay_visa_mc" type="checkbox" value="1"<cfif #pay_visa_mc# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;VISA/MasterCard</font></td>
                      <td>&nbsp;</td>
                      <td><input name="pay_other" type="checkbox" value="1"<cfif #pay_other# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Other/Not listed here</font></td>
                     </tr>
                     <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;See item description for payment information</font></td></tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr> 
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Shipping<br>Info:</b></font></td>
                   <td>&nbsp;</td>
                   <td valign="top" colspan=2>
                    <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <td><input name="ship_sell_pays" type="checkbox" value="1"<cfif #ship_sell_pays# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Seller pays shipping costs</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_buy_pays_act" type="checkbox" value="1"<cfif #ship_buy_pays_act# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Buyer pays actual shipping costs</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_buy_pays_fxd" type="checkbox" value="1"<cfif #ship_buy_pays_fxd# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Buyer pays fixed shipping costs</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_international" type="checkbox" value="1"<cfif #ship_international# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Allow international shipping</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_see_desc" type="checkbox" value="1"<cfif #ship_see_desc# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;See item description for shipping information</font></td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr>
				  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Shipping Fee:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input name="shipping_fee" type="text" size=10 maxlength=10 value="#trim(numberformat(shipping_fee,'#numbermask#'))#"></td>
                  </tr>
				  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr>
				   <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Sales Tax Rate:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input name="salestax" type="text" size=10 maxlength=10 value="#salestax#">% <em style="font-size:0.75em; color:##CC3333;">(Do not enter value with % sign)</em> &nbsp;<input type="button" name="btnSalesTax" value="Get Sales Tax Rate" onclick="openWindow ('../sell/salestaxcalculator.cfm', 750, 400);"/></td>
                  </tr>
				  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr>
				  <cfif auction_mode is 0>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Minimum Bid:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input name="maximum_bid" type="hidden" size=10 maxlength=10 value="#maximum_bid#">
				       <cfif #get_bid_cnt.recordcount# gt 0><input name="minimum_bid" type="hidden" size=10 maxlength=10 value="#minimum_bid#">#numberformat(minimum_bid, numbermask)#<cfelse><input name="minimum_bid" type="text" size=10 maxlength=10 value="#minimum_bid#"></cfif>
                   </td>
                  </tr>
				  <tr>
       				<td><font face="helvetica" size=2><b>Buy Now:</b></font></td>
       				<td>&nbsp;</td>
       				<td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input type="text" name="buynow_price" size=10 maxlength=10  value="#buynow_price#"></td></tr></table></td> 
    			  </tr><input type="hidden" name="buynow" value="#buynow#">
				  <tr>
					<td colspan="2">&nbsp;</td>
					<td><font face="helvetica" size=2>&nbsp;&nbsp;(Buy now function allow users buy at the setting price without bidding process)</font></td>
				  </tr>
				  <cfelse>
				  <tr>
                   	<td><font face="helvetica" size=2 color="0000ff"><b>Maximum Bid:</b></font></td><td>&nbsp;</td><td><input name="minimum_bid" type="hidden" size=10 maxlength=10 value="#minimum_bid#">
						<cfif #get_bid_cnt.recordcount# gt 0><input name="maximum_bid" type="hidden" size=10 maxlength=10 value="#maximum_bid#">#numberformat(maximum_bid, numbermask)#<cfelse><input name="maximum_bid" type="text" size=10 maxlength=10 value="#maximum_bid#"></cfif>
					</td>
                  </tr>
				  </CFIF>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Reserve Bid:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input name="reserve_bid" type="text" size=10 maxlength=10 value="#reserve_bid#"><cfif #get_fee_reserve_bid.pair# GT 0> <font size=2>(a #numberFormat(get_fee_reserve_bid.pair,numbermask)# #Trim(getCurrency.type)# fee)</font><br></cfif><font face="helvetica" size=2>&nbsp; &nbsp;<b>(For single-quantity items only that are not reverse or buyer's auctions)</b></font></td>
                  </tr>
			 	  <tr>
        			<td><font face="helvetica" size=2><b>Bid Increment:</b></font></td>
        			<td>&nbsp;</td>
        			<td><table border=0 cellspacing=0 cellpadding=0><tr><td><select name="increment_valu" size=1><cfloop query="get_increments"><option value="#pair#"<cfif #increment_valu# is #pair#> selected</cfif>>#numberFormat (pair,numbermask)#</option></cfloop></select></td>
					<!--- <td><font color=blue>Attention:  Bid Increment must  evenly divide into <cfif auction_mode is 0>Minimum Bid. <cfelse>Maximum Bid.</CFIF>   Error checking for this has not been installed on this page yet.</FONT></td> --->
					<td>&nbsp;</TD>
					<input type="hidden" name="increment" value="1"></td></tr></table></td> 
      			 </tr>
                 <tr>
                   <td><font face="helvetica" size=2><b>Dynamic Bid<br>Time (minutes):</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="dynamic_valu" type="text" size=7 maxlength=9 value="#dynamic_valu#"></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"<cfif #dynamic# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enabled</font></td></tr></table></td> 
                 </tr>
				 <tr><td colspan=3><hr size=1 color=#heading_color# width=100%></td></tr>
				 <tr>
       			   <td valign=top><font face="helvetica" size=2><b>Other Settings:</b></font></td>
       			   <td>&nbsp;</td>
       			   <td colspan=2>
				   <cfif featured is 1><input type="hidden" name="featured" value="#featured#"><font face="helvetica" size=2>[Feature this item on the front page is selected]</font><cfelse><input type="checkbox" name="featured" value="1"<cfif #featured# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Feature this item on the front page<cfif #get_fee_featured.pair# GT 0> <font face="helvetica" size=1>(a #numberformat(get_fee_featured.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></cfif>
	               <br><cfif featured_cat is 1><input type="hidden" name="featured_cat" value="#featured_cat#"><font face="helvetica" size=2>[Feature this item in its category(s) is selected]</font><cfelse><input type="checkbox" name="featured_cat" value="1"<cfif #featured_cat# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Feature this item in its category(s)<cfif #get_fee_feat_cat.pair# GT 0> <font face="helvetica" size=1>(a #numberformat(get_fee_feat_cat.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></cfif>
	               <br><cfif featured_studio is 1><input type="hidden" name="featured_studio" value="1"><font face="helvetica" size=2>[Feature this item in Studio is selected]</font><cfelse><input type="checkbox" name="featured_studio" value="1" <cfif #featured_studio# is "1"> checked</cfif> onClick="doThis()"><font face="helvetica" size=2>&nbsp;Feature this item in Studio<cfif #get_fee_feat_studio.pair# GT 0> <font face="helvetica" size=1>(a #numberformat(get_fee_feat_studio.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></cfif>
      			 </tr>
				 <tr>
       				<td><font face="helvetica" size=2><B>Auto Relist</B></font></td>
       				<td>&nbsp;</td>
	   				<TD>
					<font face="helvetica" size=2>
					<select name="auto_relist">
						<option value="0"<cfif auto_relist eq 0>selected</cfif>>0
						<option value="1"<cfif auto_relist eq 1>selected</cfif>>1
						<option value="2"<cfif auto_relist eq 2>selected</cfif>>2
						<option value="3"<cfif auto_relist eq 3>selected</cfif>>3
						<option value="4"<cfif auto_relist eq 4>selected</cfif>>4
						<option value="5"<cfif auto_relist eq 5>selected</cfif>>5
						<option value="6"<cfif auto_relist eq 6>selected</cfif>>6
						<option value="7"<cfif auto_relist eq 7>selected</cfif>>7
						<option value="8"<cfif auto_relist eq 8>selected</cfif>>8
						<option value="9"<cfif auto_relist eq 9>selected</cfif>>9
					</select>
					&nbsp;The number of times an item will automatically relist if it does not sell.</font></TD>
      			 </tr>
      			 <tr>
	  				<td><font face="helvetica" size=2><B>Private Auction</B></font></td>
       				<td>&nbsp;</td>
       				<td colspan=2><input type="checkbox" name="private" value="1"<cfif #private# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Auction is private (hide E-Mail addresses)</font></td> 
      			 </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr> 
                  <tr>
                   <td>
                  <!--- <input name="private" type="hidden" value="#private#"> --->
                  <input name="status" type="hidden" value="#status#">
				  <input name="auction_mode" type="hidden" value="#auction_mode#">
                  </td>
                  </tr> 
                  <tr>
                   <td colspan=4><cfif #submit3# is "Another">
				   <!---<input type="submit" name="submit3" value="Edit Another" width=75>&nbsp;---><cflocation url="edit_pre_new.cfm?submit=enter&selected_item=#session.itemnum#">
					<cfelse><input type="submit" name="submit2" value="Save" width=75>&nbsp;
				   </cfif><input type="submit" name="submit2" value="Cancel" width=75></td>
                  </tr> 
                 </table>
				
                </td>
               </tr>
              </table>
             </form>
            </td>
           </tr>
          </table>
         </td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   <div align="center">

 <cfinclude template="nav.cfm">
</div>
      
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>
 </body>
</html>



