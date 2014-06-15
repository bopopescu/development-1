<cfsetting enablecfoutputonly="Yes">

<!---
  relist_info.cfm
--->

<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>
 
 <cfset shipping_fee = 0>
 <cfset salestax = 0>

<cfif isDefined('form.Remove')>
  <cflocation url="./relistitem.cfm?delete=1">
</cfif>
<!--- Get selected category from session or link --->
<cfif isDefined('url.cat')>


<cflock timeout="30" name="#session.sessionid#" type="exclusive">
	<cfset structdelete(session, "category2")>
	
</cflock>

<cfset selected_category = url.cat>
 <cfset session.category1 = url.cat> 


 

</cfif>
<cfif isDefined('session.category1')>
<cfset selected_category = session.category1>
</cfif>

<!--- ********** --->
<cfif #isDefined("directory")#>
  <cffile action="delete"	file="#directory##incoming#">  
</cfif>
<!--- upload full size image --->
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture1 = #File.ServerFile#>
</cfif> 

<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory1# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs1\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory1#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory1#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture2 = #File.ServerFile#>
</cfif> 

<!--- upload full size image #3--->
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs2\")>
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
</cfif> 


<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory3# = Replace(GetDirectoryFromPath("#curPath#"),"personal\","fullsize_thumbs3\")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory3#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory3#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture4 = #File.ServerFile#>
</cfif> 


<!--- *********************************************** --->
<cfif #isDefined("incoming")# is 0>
  <cfset #incoming# = "">
</cfif>  
<!--- ********** --->

<cfif isDefined('form.update')>
	<cfif isDefined("form.itemlist")>
  <cfset itemarray = listtoarray(form.itemlist)>
  <cfloop index = "ix" from = 1 to = "#ArrayLen(itemarray)#" >
    <cfquery username="#db_username#" password="#db_password#" NAME="" DATASOURCE="#DATASOURCE#">
       UPDATE ITEMS
          SET Hide = '1'
        WHERE itemnum = #itemarray[ix]#
    </CFQUERY> 
  </CFLOOP>
  <cflocation url="relistitem.cfm">
  	</cfif>
<cfelse>
</CFIF>


  <!--- If they haven't logged in, set defaults --->
  <cfif #isDefined ("login")# is 0>
    <cfset #login# = "">  
  </cfif>
  <cfif #isDefined ("password")# is 0>
    <cfset #password# = "">  
  </cfif>
  <cfif #login# is "">
    <cfif #isDefined ("session.nickname")#>
      <cfset #login# = #session.nickname#>
    </cfif>
  </cfif>
  <cfif #password# is "">
    <cfif #isDefined ("session.password")#>
      <cfset #password# = #session.password#>
    </cfif>
  </cfif>

<cfset session.incoming = "">
  
  <!--- Include this module to obtain a unique ID for the user --->
  <CFMODULE TEMPLATE="../functions/epoch.cfm"> 

  <!--- Check to see if the EPOCH value has been used before ---> 
  <!--- Set the Condition of the loop to true --->
  <cfset #loop_again# = "1">
  <cfloop condition="loop_again IS 1">
    <cfquery username="#db_username#" password="#db_password#" name="EPOCH_check" DATASOURCE="#DATASOURCE#">
        SELECT itemnum
          FROM items
         WHERE itemnum = #EPOCH#
    </cfquery>
    <cfif EPOCH_check.recordcount GT 0>
      <cfset #EPOCH#=#EPOCH#+1>
    <cfelse>


      <cfset #loop_again#=0>
    </cfif>
  </cfloop>

  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">

  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>

  <!--- Set default params --->
  <cfif #isDefined ("cat")# is 0>
    <cfset #cat# = "">
  </cfif>
  <cfif #isDefined ("submit")# is 1>
    <cfset #submit# = #trim (submit)#>
  <cfelse>
    <cfset #submit# = "">
  </cfif>
  <cfif #isDefined ("itemnum")# is 0>
  <cfset #itemnum# = "#EPOCH#">
  </cfif>

  <cfparam name="error_message" default="">
  <cfif #submit# is "Add Item">
  	<!--- Run a query to find category --->
  <cfquery username="#db_username#" password="#db_password#" name="selected_cat" dataSource="#DATASOURCE#">
    SELECT name, category
      FROM categories
     WHERE category = #category1#

</cfquery>
    <!--- If defined, merge the separate date and time objects into 1 object --->
    <cfif #isDefined ("start_time")#>
      <cfset #start_time# = "#start_time##start_time_s#">
      <cfset #start_hour# = #timeFormat (start_time, 'H')#>
      <cfset #start_min# = #timeFormat (start_time, 'm')#>
      <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, Second(Now()))#>
    </cfif>
  
    <cfif #isDefined ("Form.dynamic_valu")#>
      <cfif #Form.dynamic_valu# is "">
        <cfset #dynamic_valu# = "0">
      </cfif>
    </cfif>
    <cfif #isDefined ("Form.increment_valu")#>
      <cfif #Form.increment_valu# is "">
        <cfset #increment_valu# = "0">
		<cfelse>
	   <cfset #increment_valu# = REReplace("#form.increment_valu#", "[^0-9.]", "", "ALL")>
      </cfif>
    </cfif>
    <cfif #isDefined ("Form.minimum_bid")#>
      <cfif #Form.minimum_bid# is "">
        <cfset #minimum_bid# = "0">
	    <cfelse>
	   <cfset #minimum_bid# = REReplace("#form.minimum_bid#", "[^0-9.]", "", "ALL")>
      </cfif>
    </cfif>
    <cfif #isDefined ("Form.reserve_bid")#>
      <cfif #Form.reserve_bid# is "">
        <cfset #reserve_bid# = "0">
	    <cfelse>
	     <cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0-9.]", "", "ALL")>
      </cfif>
    </cfif>  

    <cfif #isDefined ("Form.bold_title")#>
      <cfset #bold_title# = "1">
    <cfelse>
      <cfset #bold_title# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_morder_ccheck")#>
      <cfset #pay_morder_ccheck# = "1">
    <cfelse>
      <cfset #pay_morder_ccheck# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_cod")#>
      <cfset #pay_cod# = "1">
    <cfelse>
      <cfset #pay_cod# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_see_desc")#>
      <cfset #pay_see_desc# = "1">
    <cfelse>
      <cfset #pay_see_desc# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_pcheck")#>
      <cfset #pay_pcheck# = "1">
    <cfelse>
      <cfset #pay_pcheck# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_ol_escrow")#>
      <cfset #pay_ol_escrow# = "1">
    <cfelse>
      <cfset #pay_ol_escrow# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_other")#>
      <cfset #pay_other# = "1">
    <cfelse>
      <cfset #pay_other# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_visa_mc")#>
      <cfset #pay_visa_mc# = "1">
    <cfelse>
      <cfset #pay_visa_mc# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_am_express")#>
      <cfset #pay_am_express# = "1">
    <cfelse>
      <cfset #pay_am_express# = "0">
    </cfif>
    <cfif #isDefined ("Form.pay_discover")#>
      <cfset #pay_discover# = "1">
    <cfelse>
      <cfset #pay_discover# = "0">
    </cfif>
    <cfif #isDefined ("Form.ship_sell_pays")#>
      <cfset #ship_sell_pays# = "1">
    <cfelse>
      <cfset #ship_sell_pays# = "0">
    </cfif>
    <cfif #isDefined ("Form.ship_buy_pays_act")#>
      <cfset #ship_buy_pays_act# = "1">
    <cfelse>
      <cfset #ship_buy_pays_act# = "0">
    </cfif>
    <cfif #isDefined ("Form.ship_see_desc")#>
      <cfset #ship_see_desc# = "1">
    <cfelse>
      <cfset #ship_see_desc# = "0">
    </cfif>
    <cfif #isDefined ("Form.ship_buy_pays_fxd")#>
      <cfset #ship_buy_pays_fxd# = "1">
    <cfelse>
      <cfset #ship_buy_pays_fxd# = "0">
    </cfif>
    <cfif #isDefined ("Form.ship_international")#>
      <cfset #ship_international# = "1">
    <cfelse>
      <cfset #ship_international# = "0">
    </cfif>
    <cfif #isDefined ("Form.increment")#>
      <cfset #increment# = "1">
    <cfelse>
      <cfset #increment# = "0">
    </cfif>
    <cfif #isDefined ("Form.dynamic")#>
      <cfset #dynamic# = "1">
    <cfelse>
      <cfset #dynamic# = "0">
    </cfif>
    <cfif #isDefined ("Form.featured")#>
      <cfset #featured# = "1">
    <cfelse>
      <cfset #featured# = "0">
    </cfif>
    <cfif #isDefined ("Form.featured_cat")#>
      <cfset #featured_cat# = "1">
    <cfelse>
      <cfset #featured_cat# = "0">
    </cfif>
    <cfif #isDefined ("Form.private")#>
      <cfset #private# = "1">
    <cfelse>
      <cfset #private# = "0">
    </cfif>
    <cfif #isDefined ("Form.banner")#>
      <cfset #banner# = "1">
    <cfelse>
      <cfset #banner# = "0">
    </cfif>
	<cfif #isDefined ("buynow_price")#>
  		<cfset #buynow_price# = #buynow_price#>
 	<cfelse>
  		<cfset #buynow_price# = 0>
 	</cfif>
    
    <cfif #isDefined ("Form.featured_studio")# and form.featured_studio eq 1>
      <cfset #featured_studio# = "1">
	   <cfset studio = 1> 
    <cfelse>
      <cfset #featured_studio# = "0">
    </cfif>
	
	<cfif #isDefined ("shipping_fee")#>
  		<cfset #shipping_fee# = #shipping_fee#>
 	<cfelse>
  		<cfset #shipping_fee# = 0>
 	</cfif>
	
	<cfif #isDefined ("salestax")#>
  		<cfset #salestax# = #salestax#>
 	<cfelse>
  		<cfset #salestax# = 0>
 	</cfif>
	

<cfif isDefined('studio')>
    <cfset studio = studio> 
    <cfelse>
	<cfset studio = 0>
	</cfif>
    <cfif #isDefined ("Form.auction_type")# is 0>
      <cfset #auction_type# = "E">
    </cfif>

    <cfif #isDefined ("Form.auction_mode")# is 0>
      <cfset #auction_mode# = #Form.auction_mode#>
    </cfif>

   <!---  <cfset #error_message# = ""> --->

    <!---HIde: Make sure they specified a bid increment only if the quantity is 1 
    <cfif #increment# is "1">
      <cfif #quantity# GT 1>
      <cfset increment = 0>
     <!---   <cfset #error_message# = "<font color=ff0000>You can only specify a bid increment for single-quantity items.</font>"> --->
      <cfelseif (#increment_valu# is 0) or (#isNumeric (increment_valu)# is 0)>
        <cfset #error_message# = "<font color=ff0000>You must specify a bid increment value if auto-incrementing is enabled.</font>">      
      </cfif>
    </cfif>
--->
    <!--- Check for valid login & password --->
    <cfquery username="#db_username#" password="#db_password#" name="check_login" datasource="#DATASOURCE#">
      SELECT user_id, is_active
        FROM users
       WHERE (nickname = '#login#' 
        <cfif #isNumeric(login)#> 
          OR user_id = #login#)
       <cfelse>
          )
       </cfif>
       AND password = '#password#'
    </cfquery>

    <!--- If it's valid, store their info in session variables --->
    <cfif #check_login.recordcount# is 1>
      <cfset selected_user = check_login.user_id>
      <cfset #session.nickname# = "#login#">
    <cfelse>
      <cfset selected_user = "">
    </cfif>
      
    <!--- Get user_id from new category selection --->
    <CFIF isDefined('form.category1')>
      <cfquery username="#db_username#" password="#db_password#" NAME="getcat1_user_id" DATASOURCE="#Datasource#">
        SELECT user_id FROM categories
         WHERE category = #form.category1#
      </CFQUERY>
    </CFIF>
  
    <CFIF isDefined('form.category2')>
      <cfquery username="#db_username#" password="#db_password#" NAME="getcat2_user_id" DATASOURCE="#Datasource#">
        SELECT user_id, name FROM categories
         WHERE category = #form.category2#
      </CFQUERY>
      <cfif #getcat2_user_id.recordcount# gt 0>
        <cfset cat2user_id = "#getcat2_user_id.user_id#">
      <cfelse>
        <cfset cat2user_id = 0>
      </cfif>
    </CFIF>

	<cfif auction_mode eq 0>
 		<cfif buynow_price gt 0>
      		<cfset buynow = 1>
 		<cfelse>
 			<cfset buynow = 0>
  		</cfif>
	</cfif>
    <cfif #check_login.recordcount# is 0>  
      <cfset #error_message# = "<font color=ff0000>Login incorrect. Please try again.</font>">  
    <cfelseif #trim (title)# is "">
      <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
    <cfelseif (#trim (quantity)# is "") or (#isNumeric (quantity)# is 0) or (#quantity# is 0)>
      <cfset #error_message# = "<font color=ff0000>Please enter a valid quantity for this item.</font>"> 
    <cfelseif #trim (description)# is "">
      <cfset #error_message# = "<font color=ff0000>Please enter a description of this item.</font>"> 
    <cfelseif #isDefined ("desc_languages")# is "0">
      <cfset #error_message# = "<font color=ff0000>Please specify the language(s) the description is in.</font>"> 
      <cfset #desc_languages# = "">
    <cfelseif #trim (location)# is "">
      <cfset #error_message# = "<font color=ff0000>Please enter the state where this item will be shipped from.</font>"> 
    <cfelseif #trim (country)# is "">
      <cfset #error_message# = "<font color=ff0000>Please specify a country where this item will be shipped from.</font>"> 
    <cfelseif (#category1# is "-1") and (#category2# is "-1")>
      <cfset #error_message# = "<font color=ff0000>Please specify at least 1 auction category for this item.</font>">
	<cfelseif not isNumeric(buynow_price) or #buynow_price# eq "">
			<cfset #error_message# = "<font color=ff0000>Please double check the buy now price the default is 0 and required to be numeric.</font>">
	<cfelseif auction_mode eq 0 and buynow eq 1 and (not isNumeric(buynow_price) or #buynow_price# lt #minimum_bid#)>
			<cfset #error_message# = "<font color=ff0000>Please double check the buy now price for this item.</font>">
	<cfelseif auction_mode eq 0 and buynow eq 1 and #buynow_price# lt #reserve_bid#>
		<cfset #error_message# = "<font color=ff0000>The buynow option does not allow reserve bid greater than buynow price.</font>">
            <!--check for exclusive category and match logon user_id with category user_id -->

    <cfelseif #getcat1_user_id.user_id# is not 0>   
      <cfif (#selected_user# is not #getcat1_user_id.user_id#)>
        <cfset #error_message# = "You are not authorized to enter items in this primary category. Please contact the site administrator to list items in your own exclusive category.">
      </cfif>
    <CFELSEIF (#getcat2_user_id.user_id# is not 0) and (#cat2user_id# is not 0)>
      <cfif (#selected_user# is not #getcat2_user_id.user_id#) or (#selected_user# is not #cat2user_id#)>
        <cfset #error_message# = "You are not authorized to enter items in this secondary category. Please contact the site administrator to list items in your own exclusive category.">
      </CFIF> 
            <!-- end check --->

    <cfelseif #auction_mode# IS 0 and ((#trim (minimum_bid)# is "") or (#minimum_bid# is "0") or (#isNumeric (minimum_bid)# is "0"))>
        <cfset #error_message# = "<font color=ff0000>Please specify a minimum bid value for this item.</font>"> 
	<cfelseif auction_mode is 0 and (#auction_type# is "D" or #auction_type# is "Y") and #trim (reserve_bid)# gt 0>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">
	<cfelseif auction_mode is 1 and #trim (reserve_bid)# gt 0 and #trim (reserve_bid)# lt maximum_bid>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">



    <cfelseif #auction_mode# IS 1 and ((#trim (maximum_bid)# is "") or (#maximum_bid# is "0") or (#isNumeric (maximum_bid)# is "0"))>
        <cfset #error_message# = "<font color=ff0000>Please specify a maximum bid value for this item.</font>">
 
    <cfelseif (#quantity# GT 1) and (#auction_type# is "E" or #auction_type# is "V")>
      <cfset #error_message# = "<font color=ff0000>This type of auction only allows 1 unit of an item to be sold.</font>"> 
    <cfelseif (#quantity# IS 1) and (#auction_type# is "D" or #auction_type# is "Y")>
      <cfset #error_message# = "<font color=ff0000>This type of auction does not allow 1 unit of an item to be sold.</font>"> 
    <cfelseif #pay_morder_ccheck# is 0 and
              #pay_cod# is 0 and
              #pay_see_desc# is 0 and
              #pay_pcheck# is 0 and
              #pay_ol_escrow# is 0 and
              #pay_other# is 0 and
              #pay_visa_mc# is 0 and
              #pay_am_express# is 0 and
              #pay_discover# is 0>
       <cfset #error_message# = "<font color=ff0000>You must specify at least one accepted payment method.</font>">
    <cfelseif #ship_sell_pays# is 0 and
              #ship_buy_pays_act# is 0 and
              #ship_see_desc# is 0 and
              #ship_buy_pays_fxd# is 0 and
              #ship_international# is 0>
       <cfset #error_message# = "<font color=ff0000>You must specify at least one shipping arrangement.</font>">
    </cfif>

	<cfif auction_mode eq 0>
		<cfif buynow_price gt 0 and buynow_price gte #minimum_bid#>
			<cfset buynow = 1>
		<cfelse>
			<cfset buynow = 0>
		</cfif>
	<cfelse>
			<cfset buynow = 0>
	</cfif>
    <!--- Save all posted vars into session variables --->
    <cfset #session.held_item# = "1">
    <cfset #session.itemnum# = #itemnum#>
    <cfset #session.status# = "1">
    <cfset #session.password# = #password#>
    <cfset #session.user_id# = #selected_user#>
    <cfset #session.category1# = #category1#>
    <cfset #session.category2# = #category2#>
    <cfset #session.auction_type# = #auction_type#>
    <cfset #session.title# = #title#>
    <cfset #session.location# = #location#>
    <cfset #session.country# = #country#>
    <cfset #session.pay_morder_ccheck# = #pay_morder_ccheck#>
    <cfset #session.pay_cod# = #pay_cod#>
    <cfset #session.pay_see_desc# = #pay_see_desc#>
    <cfset #session.pay_pcheck# = #pay_pcheck#>
    <cfset #session.pay_ol_escrow# = #pay_ol_escrow#>
    <cfset #session.pay_other# = #pay_other#>
    <cfset #session.pay_visa_mc# = #pay_visa_mc#>
    <cfset #session.pay_am_express# = #pay_am_express#>
    <cfset #session.pay_discover# = #pay_discover#>
    <cfset #session.ship_sell_pays# = #ship_sell_pays#>
    <cfset #session.ship_buy_pays_act# = #ship_buy_pays_act#>
    <cfset #session.ship_see_desc# = #ship_see_desc#>
    <cfset #session.ship_buy_pays_fxd# = #ship_buy_pays_fxd#>
    <cfset #session.ship_international# = #ship_international#>
    <cfset #session.description# = #description#>
    <cfset #session.desc_languages# = #desc_languages#>
    <cfset #session.picture# = #picture#>
	<cfif picture1 eq "">
		<cfset #session.picture1# = #org_picture1#>
	<cfelse>
		<cfset #session.picture1# = #picture1#>
	</cfif>
	<cfif picture2 eq "">
		<cfset #session.picture2# = #org_picture2#>
	<cfelse>
		<cfset #session.picture2# = #picture2#>
	</cfif>
	<cfif picture3 eq "">
		<cfset #session.picture3# = #org_picture3#>
	<cfelse>
		<cfset #session.picture3# = #picture3#>
	</cfif>

	<cfif picture4 eq "">
		<cfset #session.picture4# = #org_picture4#>
	<cfelse>
		<cfset #session.picture4# = #picture4#>
	</cfif>
    <cfset #session.sound# = #sound#>
    <cfset #session.quantity# = #quantity#>
    <cfset #session.minimum_bid# = #minimum_bid#>
    <cfset #session.maximum_bid# = #maximum_bid#>
    <cfset #session.increment# = #increment#>
    <cfset #session.increment_valu# = #increment_valu#>
    <cfset #session.dynamic# = #dynamic#>
    <cfset #session.dynamic_valu# = #dynamic_valu#>
    <cfset #session.reserve_bid# = #reserve_bid#>
    <cfset #session.bold_title# = #bold_title#>
    <cfset #session.featured# = #featured#>
    <cfset #session.featured_cat# = #featured_cat#>
    <cfset #session.private# = #private#>
    <cfset #session.banner# = #banner#>
    <cfset #session.banner_line# = #banner_line#>
    <cfset #session.featured_studio# = #featured_studio#>
  
    <cfset #session.picture_studio# = #picture_studio#>
    <cfset #session.sound_studio# = #sound_studio#>
    <cfset #session.date_start# = #date_start#>
  	<cfset #session.auto_relist# = #auto_relist#>
    <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
    <cfset #session.date_end# = #date_end#>
    
    <cfset #session.billmeth# = "BM">
    <cfset #session.remote_ip# = #cgi.remote_addr#>
    <cfset #session.auction_mode# = #auction_mode#> 

	<cfset #session.buynow_price# = #buynow_price#>
	<cfset #session.buynow# = #buynow#>
	<cfset #session.shipping_fee# = #shipping_fee#>
	<cfset #session.salestax# = #salestax#>
	
    <cfif #studio# is 1>
	  <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"personal\","thumbs\")#>
                      <cfif fileExists("#thePath##incoming#.jpg")>
<cfset studio = 1>
                        <cfset #session.incoming# = "#incoming#.jpg">
                      <cfelseif fileExists("#thePath##incoming#.gif")>
                        <cfset #session.incoming# = "#incoming#.gif">
                      <cfelse>
						<cfset #session.incoming# = "dummy.gif">
                      </cfif>
      <cfset #session.studio# = "1">
    <cfelse>
	<cfset #session.incoming# = "">
      <cfset #session.studio# = "0">
    </cfif>

    <cfif IsDefined('session.serverfile')>
      <cfset session.serverfile = "">
    </cfif>  

  </cfif> <!--- (#submit# is "Add Item") --->

  <cfif (#submit# is "Add Item") and (#error_message# is "")>



    <cflocation url="#VAROOT#/sell/item_preview.cfm?itemnum=#itemnum#&mode=relist"> 


  </cfif> <!---  (#submit# is "Add Item") and (#error_message# is "") --->

  <!--- Run a query to get their item when they first come to the page --->
  <cfif (#submit# is "" or #submit# is "Continue" OR #submit# is "<< Back")>
    <cfif not isdefined("session.orig_itemnum") or (isdefined("session.orign_itemnum") and session.orig_itemnum IS "") or #submit# is "Continue">
      <cfset session.orig_itemnum = #itemnum#>
    </cfif>  
    <cfquery username="#db_username#" password="#db_password#" name="get_item" datasource="#DATASOURCE#">
      SELECT itemnum,
          status,
          user_id,
          category1,
          category2,
          auction_type,
          title,
          location,
          country,
          pay_morder_ccheck,
          pay_cod,
          pay_pcheck,
          pay_ol_escrow,
          pay_other,
          pay_visa_mc,
          pay_am_express,
          pay_discover,
          pay_see_desc,
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
          billmeth,
          remote_ip,
          auction_mode,
          auto_relist,
		  buynow_price,
		  buynow,
		  org_quantity,
		  shipping_fee,
		  salestax
       FROM items
      WHERE itemnum=#session.orig_itemnum#
    </cfquery>
<!--- Run a query to find category --->
  <cfquery username="#db_username#" password="#db_password#" name="selected_cat" dataSource="#DATASOURCE#">
    SELECT name, category
      FROM categories
	  <cfif isDefined('url.cat')>
	  WHERE category = #selected_category#

	  <cfelse>
     WHERE category = #get_item.category1#

	 </cfif>
     ORDER by name
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" NAME="getcat2_user_id" DATASOURCE="#Datasource#">
     SELECT user_id, name FROM categories
     WHERE category = #get_item.category2#
  </CFQUERY>
    <!--- Fill in vars for the old item, but with a new item # --->
    <cfset #incoming# = "#get_item.itemnum#">
    <cfset #itemnum# = "#EPOCH#">
    <cfset #user_id# = "#get_item.user_id#">
    <cfset #category1# = "#get_item.category1#">
    <cfset #category2# = "#get_item.category2#">
    <cfset #title# = "#get_item.title#">
	<cfset state = "#get_item.location#">
    <cfset #location# = "#get_item.location#">
    <cfset #country# = "#get_item.country#">
    <cfset #description# = "#get_item.description#">
    <cfset #desc_languages# = "English">
    <cfset #picture# = "#get_item.picture#">

	<cfset #picture1# = "#get_item.picture1#">
	<cfset #org_picture1# = "#get_item.picture1#">
	<cfset #picture2# = "#get_item.picture2#">
	<cfset #org_picture2# = "#get_item.picture2#">
	<cfset #picture3# = "#get_item.picture3#">
	<cfset #org_picture3# = "#get_item.picture3#">
	<cfset #picture4# = "#get_item.picture4#">
	<cfset #org_picture4# = "#get_item.picture4#">
    <cfset #sound# = "#get_item.sound#"> 
    <cfset #picture_studio# = "#get_item.picture_studio#">
    <cfset #sound_studio# = "#get_item.sound_studio#">
    <cfset #quantity# = "#get_item.quantity#">
    <cfset #minimum_bid# = "#get_item.minimum_bid#">
    <cfset #maximum_bid# = "#get_item.maximum_bid#">
    <cfset #increment_valu# = "#get_item.increment_valu#">
    <cfset #dynamic_valu# = "#get_item.dynamic_valu#">
    <cfset #reserve_bid# = "#get_item.reserve_bid#">
    <cfset #banner_line# = "#get_item.banner_line#">
    <cfset #date_start# = "#now ()#">
    <cfset #date_end# = "#now ()#">
    <cfset #bold_title# = "#get_item.bold_title#">
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
    <cfset #increment# = "#get_item.increment#">
    <cfset #dynamic# = "#get_item.dynamic#">
    <cfset #featured# = "#get_item.featured#">
    <cfset #featured_cat# = "#get_item.featured_cat#">
    <cfset #private# = "#get_item.private#">
    <cfset #banner# = "#get_item.banner#">

    <cfset #studio# = "#get_item.studio#">
    <cfset #featured_studio# = "#get_item.featured_studio#">

    <cfset #auction_type# = "#get_item.auction_type#">
    <cfset #auction_mode# = "#get_Item.auction_mode#">
    <cfset #session.auction_mode# = #get_Item.auction_mode#>
    <cfset #auto_relist# = "#get_item.auto_relist#">
    <cfset #error_message# = "">    
	<cfset #buynow_price# = "#get_item.buynow_price#">
	<cfset #buynow# = "#get_item.buynow#">
	<cfset org_quantity = #get_item.org_quantity#>
	<cfset shipping_fee = #get_item.shipping_fee#>
	<cfset salestax = #get_item.salestax#>

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
  </cfif> <!--- (#submit# is "" or #submit# is "Continue") and (#submit# is not "<< Back") --->
  
  <!--- ********************** --->
  <!--- define picture1URL --->
  <cfif Right(org_picture1, 4) IS ".gif"
   OR Right(org_picture1, 4) IS ".jpg"
   OR Right(org_picture1, 4) IS ".png">
    <cfset isImage1 = "TRUE">
    <cfset picture1URL = Trim(org_picture1)>
  <cfelse>
    <cfset isImage1 = "FALSE">
  </cfif>
  <!--- ********************** --->
  
  <!--- define picture2URL --->
  <cfif Right(org_picture2, 4) IS ".gif"
   OR Right(org_picture2, 4) IS ".jpg"
   OR Right(org_picture2, 4) IS ".png">
    <cfset isImage2 = "TRUE">
    <cfset picture2URL = Trim(org_picture2)>
  <cfelse>
    <cfset isImage2 = "FALSE">
  </cfif>
  
  <!--- define picture3URL --->
  <cfif Right(org_picture3, 4) IS ".gif"
   OR Right(org_picture3, 4) IS ".jpg"
   OR Right(org_picture3, 4) IS ".png">
    <cfset isImage3 = "TRUE">
    <cfset picture3URL = Trim(org_picture3)>
  <cfelse>
    <cfset isImage3 = "FALSE">
  </cfif>

   <!--- define picture3URL --->
  <cfif Right(org_picture4, 4) IS ".gif"
   OR Right(org_picture4, 4) IS ".jpg"
   OR Right(org_picture4, 4) IS ".png">
    <cfset isImage4 = "TRUE">
    <cfset picture4URL = Trim(org_picture4)>
  <cfelse>
    <cfset isImage4 = "FALSE">
  </cfif>



  <!--- Run a query to find all durations --->
  <cfquery username="#db_username#" password="#db_password#" name="get_durations" dataSource="#DATASOURCE#">
      SELECT pair
        FROM defaults
      WHERE name = 'duration'
      ORDER BY pair
  </cfquery>

  <!--- Run a query to find the default duration --->
  <cfquery username="#db_username#" password="#db_password#" name="get_def_duration" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
    WHERE name = 'def_duration'
     ORDER BY pair
  </cfquery>
 
  <!--- Run a query to find all increments --->
  <cfquery username="#db_username#" password="#db_password#" name="get_increments" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'increment'
       AND pair <> '0000'
     ORDER BY pair
  </cfquery>
 
  <!--- get all dynamic closes --->
  <cfquery username="#db_username#" password="#db_password#" name="get_dynamic" datasource="#DATASOURCE#">
      SELECT pair
        FROM defaults
       WHERE name = 'dynamic'
         AND pair <> '0000'
       ORDER BY pair
  </cfquery>

  <!--- Run queries to find fees --->
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
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_second_cat" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
    WHERE name = 'fee_second_cat'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_cat" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'fee_feat_cat'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_listing" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'fee_listing'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_featured" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'fee_featured'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_reserve_bid" dataSource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'fee_reserve_bid'
  </cfquery>
  <!--- Run queries to find cat_fee enable --->
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_cat_fee" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_cat_fee'
  </cfquery>
  <cfset #enable_cat_fee# = #get_enable_cat_fee.pair#>
  
  

  <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"personal\","thumbs\")#>
 
  <cfif #studio# IS 1>
    <cfif fileExists("#thePath##incoming#.jpg")>
      <cfset theThumb = "<IMG src=#varoot#/thumbs/#incoming#.jpg border=0>">
    <cfelseif fileExists("#thePath##incoming#.gif")>
      <cfset theThumb = "<IMG src=#varoot#/thumbs/#incoming#.gif border=0>">
    <cfelse>
      <cfset theThumb = "">
    </cfif>      
  </cfif>

  <cfsetting enablecfoutputonly="No">
 


 

<html>
  <head>
   <title>Personal Page: Relist Item Page</title>
   <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  <cfoutput><cfinclude template="../includes/bodytag.html"></cfoutput>

 <cfinclude template="../includes/menu_bar.cfm">
  <cfoutput>


  <!--- Some JavaScript for the "Preview" buttons --->
  <script language="JavaScript">

  // Opens a new browser window with no titlebar and the given size, and
  // loads the given URL into it.
  function openWindow (URL, width, height) {
     window.open (URL, "previewWindow", "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
  }
function setLocation(){

var selObj = document.getElementById('state');
	
	var txtLocationObj = document.getElementById('txtLocation');
	
	var selIndex = selObj.selectedIndex;
	txtLocationObj.value = selObj.options[selIndex].value;
}
  </script>


  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><b>Relist Item Page</b></font></td></tr>
    <tr><td>         <hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       This page allows you to relist an item you previously put up for auction,
       but expired before it was sold.  Please verify that the information below
       is correct for this item.  You may modify any of the information you wish
       before relisting the item.
      </font>
      <form action="relist_info.cfm" method="post" name="item_input" ENCTYPE="multipart/form-data">
      <input type="hidden" name="#itemnum#" value="#itemnum#">
      <input type="hidden" name="auction_mode" value="#session.auction_mode#">
      <input type="hidden" name="studio" value="#studio#">
      <input type="hidden" name="incoming" value="#incoming#">
      <input type="hidden" name="picture_studio" value="#picture_studio#">
      <input type="hidden" name="sound_studio" value="#sound_studio#">
	  <input name="org_quantity" type="hidden" value="#org_quantity#">
	  <input name="org_picture1" type="hidden" value="#picture1#">
	  <input name="org_picture2" type="hidden" value="#picture2#">
	  <input name="org_picture3" type="hidden" value="#picture3#">
	  <input name="org_picture4" type="hidden" value="#picture4#">

      <center><font size=2><b>Required items are in <font color="0000ff">blue</font>; all others are optional.</b></font></center>
      <cfif #error_message# is not "">
        <br><font face="Helvetica" size=2 color=ff0000><b>ERROR:</b> #error_message#<br></font>
      </cfif>
               <hr size=1 color=#heading_color# width=100%>

      <table border=0 cellspacing=0 cellpadding=2 width=100%>
     


 <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
 		<input name="login" type="hidden" value="#session.user_id#">
		<input name="password" type="hidden" value="#session.password#">
 	  <cfelse>




 <tr>
       <td><font size=3 color="0000ff"><b>User ID or Nickname:</b></font></td>
       <td>&nbsp;</td>
       <td><input name="login" type="text" size=12 maxlength=20 value="#login#"></td>
      </tr>
      <tr>
       <td><font size=3 color="0000ff"><b>Password:</b></font></td>
       <td>&nbsp;</td>
       <td><input name="password" type="password" size=12 maxlength=12 value=""></td>
      </tr>
      <tr><td colspan=3>         <hr size=1 color=#heading_color# width=100%></td></tr>


</cfif>
      <tr>
       <td><font size=3 color="0000ff"><b>Title:</b></font></td>
       <td>&nbsp;</td>

       <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="text" size=35 maxlength=45 value="#title#"></td><td>&nbsp;<input name="bold_title" type="checkbox" value="1"<cfif #bold_title# is "1"> checked</cfif>><font size=3>&nbsp;Bold title<cfif #get_fee_bold.pair# GT 0> <font size=2>(a #numberformat(get_fee_bold.pair,'#numbermask#')# #Trim(getCurrency.type)# fee)</font></cfif></font></td></tr></table></td>
      </tr>
      <tr>
       <td><font size=3><b>Banner:</b></font></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="banner_line" type="text" size=35 maxlength=45 value="#banner_line#"></td><td>&nbsp;<input name="banner" type="checkbox" value="1"<cfif #banner# is "1"> checked</cfif>><font size=3>&nbsp;Enable banner<cfif #get_fee_banner.pair# GT 0> <font size=2>(a #numberformat(get_fee_banner.pair,'#numbermask#')# #Trim(getCurrency.type)# fee)</font></cfif></font></td></tr></table></td>
      </tr>
      <tr>
       <td><font size=3 color="0000ff"><b>Quantity:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="quantity" type="text" size=5 maxlength=6 value="#org_quantity#"></td>
      </tr>
      <tr>
       <td><font size=3 color="0000ff"><b>Auction Type:</b></font></td>
       <td>&nbsp;</td>   
       <td>
        <select name="auction_type">
         <option value="E"<cfif #auction_type# is "E"> selected</cfif>>English (Normal)</option>
         <option value="D"<cfif #auction_type# is "D"> selected</cfif>>Dutch</option>
         <option value="Y"<cfif #auction_type# is "Y"> selected</cfif>>Yankee</option>
         <option value="V"<cfif #auction_type# is "V"> selected</cfif>>Vickrey</option>
        </select>
       </td>
      </tr>
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Item<br>Description:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><textarea name="description" rows=5 cols=50 wrap=virtual>#description#</textarea></td>
      </tr>
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Description<br>Languages:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
        <cfmodule template="..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="desc_languages" selected="#desc_languages#" size=5 multiple="yes">
       </td>
      </tr>
	  <tr>
       <td><font size=3 color="0000ff"><b>State:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
        </cfoutput>
		
		<CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                  SELECTNAME="state"
                  SELECTED="#state#"
                  MULTIPLE="0"
                  SIZE="1"
				  ANY="1"><cfoutput>
       </td>
      </tr>
	  
	  
	   <tr>
       <td><font size=3 color="0000ff"><b>Country:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
        </cfoutput><CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1"><cfoutput>
       </td>
      </tr>
     <tr>
       <td><font size=3 color="0000ff"><b>Listing Location:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="location" id="txtLocation" type="text" size=25 maxlength=100 value="#location#"><br><font size=2>  <b>USA:</b> Populated by the seller's shipping state override by selecting state above. <b>Other Country:</b> Enter manually.</font</td>
      </tr>
     
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr> 
      <tr>
       <td><font size=3 color="0000ff"><b>Start Date/Time:</b></font></td>
       <td>&nbsp;</td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <cfset #the_month# = #datePart ("m", "#now ()#")#>
          <cfset #the_day# = #datePart ("d", "#now ()#")#>
          <cfset #the_year# = #datePart ("yyyy", "#now ()#")#>
          <cfset #the_time# = #timeFormat ("#now ()#", 'hh:mm')#>
          <cfset #the_time_s# = #timeFormat ("#now ()#", 'tt')#>
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
           </select>
          </td>
          <td><input name="start_day" type="text" size=2 maxlength=2 value="#the_day#">,</td>
          <td><input name="start_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
          <td><font size=3>&nbsp;at&nbsp;</font></td>
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
       <td><font size=3 color="0000ff"><b>Auction Duration:</b></font></td>
       <td>&nbsp;</td>   
       <td>
        <table border=0 cellspacing=0 cellpadding=0>
         <tr>
          <cfset #the_duration# = #dateDiff ("d", date_start, date_end)#>
          <td><select name="duration">                 
           <cfloop query="get_durations">
            <option value="#int (pair)#"<cfif (#int (pair)# is #the_duration#) or (#int (pair)# is #int (get_def_duration.pair)#)> selected</cfif>>#int (pair)#</option>
           </cfloop>
           </select></td>
          <td><font size=3>&nbsp;day(s)</font></td>
         </tr>
        </table>
       </td>
      </tr>
<!---       <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Current Category:<br><BR>2nd Category:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top"> 
	</cfoutput>   
<cfoutput query="selected_cat"><BR><font size=3 color=000000><b>#name#</b></font> (<a href="../listings/categories/top_cats.cfm?from=relist_info&itemnum=#itemnum#">Click Here</A> to select a new category.)<BR>
		<input type=hidden name="category1" value="#category#">
	</cfoutput>


	   
		
	
		
        <br>
        <table border=0 cellspacing=0 cellpadding=0><tr><td>
		<select name="category2">
		<option value="-1"> None </option>
		<cfif getcat2_user_id.recordcount gt 0>
		<cfoutput><option value="#category2#" selected>#getcat2_user_id.name#</option></cfoutput>
		</cfif>

		<cfinclude template = "../sell/options.txt">
		</select>
		</td><td><cfif enable_cat_fee eq 1><font size=2>(<a href="../listings/categories/cat_fees.cfm" target="_blank">Click Here</a> to see fee for listing in a second category)</font><cfelse><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a <cfoutput>#numberFormat(get_fee_second_cat.pair,numbermask)# #Trim(getCurrency.type)#</cfoutput> fee for 2nd category)</font><cfelse>&nbsp;</cfif></cfif></td></tr></table>
       </td>
      </tr> --->
                <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Categories<br>Auctioned In:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top">
        </cfoutput><cfmodule template="..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category1"
                  selected="#category1#">
        <br>
        <table border=0 cellspacing=0 cellpadding=0><tr><td><cfmodule template="..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category2"
                  show_none="yes"
                  selected="#category2#"><cfoutput></td><td><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a #numberFormat(get_fee_second_cat.pair,numbermask)# #Trim(getCurrency.type)# fee for 2nd category)</font><cfelse>&nbsp;</cfif></td></tr></table>
       </td>
      </tr>
     
 <tr>
        <td><font size=3><b>Picture URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#" >
            </td><td align=center>


<input type="button" name="previewImage" value="Preview" onClick="if (document.item_input.picture.value != 'http://')

Win1 = open('preview_image.cfm?image=' + escape(document.item_input.picture.value)+'&title='+escape(document.item_input.title.value),'','height=300,width=450')
;">
            </td></tr>
          </table>
         </td>
      </tr> 





<!---
       <td><font size=3><b>Picture URL:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
  
       
         <table border=0 cellspacing=0 cellpadding=0>
		 <tr><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#"></td>
		 <td>&nbsp;</td>
		 <td><input type="button" name="previewImage" value="Preview" onClick="if (picture.value != 'http://') openWindow ('../sell/preview_image.cfm?image=#URLEncodedFormat(picture)#&title=#URLEncodedFormat (title)#', 450, 300);"></td>
		 </tr>
		 
		 </table>
    
       </td>
      </tr>
--->
	  <!--- ******** --->
	  
      <tr><td>&nbsp;</td><td>&nbsp;</td>
	  <td><cfif isImage1>		
		 <img src="../fullsize_thumbs/#picture1URL#" width=100 height=100>
		  </cfif>
	  </td></tr>
      <tr><td><font size=3><b>Image1<br>Upload</b></font></td><td>&nbsp;</td><td><input name="picture1" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture1.pair# GT 0>A #numberformat(get_fee_picture1.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
     
	 <tr><td>&nbsp;</td><td>&nbsp;</td>
	  <td><cfif isImage2>		
		 <br><img src="../fullsize_thumbs1/#picture2URL#" width=100 height=100>
		  </cfif>
	  </td></tr>
      <tr><td><font size=3><b>Image2<br>Upload</b></font></td><td>&nbsp;</td><td><input name="picture2" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture2.pair# GT 0>A #numberformat(get_fee_picture2.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
	 
	 <tr><td>&nbsp;</td><td>&nbsp;</td>
	  <td><cfif isImage3>		
		 <br><img src="../fullsize_thumbs2/#picture3URL#" width=100 height=100>
		  </cfif>
	  </td></tr>
      <tr><td><font size=3><b>Image3<br>Upload</b></font></td><td>&nbsp;</td><td><input name="picture3" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture3.pair# GT 0>A #numberformat(get_fee_picture3.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
	
	 <tr><td>&nbsp;</td><td>&nbsp;</td>
	  <td><cfif isImage4>		
		 <br><img src="../fullsize_thumbs3/#picture4URL#" width=100 height=100>
		  </cfif>
	  </td></tr>
      <tr><td><font size=3><b>Image4<br>Upload</b></font></td><td>&nbsp;</td><td><input name="picture4" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture4.pair# GT 0>A #numberformat(get_fee_picture4.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
	
 <!--- *************************************************** --->
	
      <tr>
       <td><font size=3><b>Sound URL:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
        <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="sound" type="text" size=43 maxlength=250 value="#sound#"></td><td>&nbsp;</td><td>&nbsp;<!--- <input type="button" name="previewSound" value="Preview"> ---></td></tr></table>
       </td>
      </tr>
		
	  <cfif isDefined("theThumb")>
      <cfif #theThumb# NEQ "">
        <tr>
          <td><font size=3><b>The Studio<br>Thumbnail:</b></font></td>
          <td>&nbsp;</td>
          <td colspan=2 align=left>#theThumb#</td>
        </tr>
      </cfif></cfif>

<!---  ---><!---  ---><!---  ---><!---  ---><!---  ---><!---  --->      
    
      
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr> 

      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Accepted<br>Payment<br>Methods:</b></font></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>><font size=3>&nbsp;Cashier's Check/Money Order</font></td>
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
         <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>><font size=3>&nbsp;See item description for payment information</font></td></tr>
        </table>
       </td>
      </tr>
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr> 
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Shipping<br>Info:</b></font></td>
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
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr>
	  <tr>
          <td><font size=3 color="0000ff"><b>Shipping Fee:</b></font></td>
          <td><font size=3><b>&nbsp;</b></font></td>
          <td><input name="shipping_fee" type="text" size=10 maxlength=10 value="#trim(numberformat(shipping_fee,'#numbermask#'))#">&nbsp;&nbsp;</td>
        </tr>
	  <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr>
	  <tr>
          <td><font size=3 color="0000ff"><b>Sales Tax Rate:</b></font></td>
          <td><font size=3><b>&nbsp;</b></font></td>
          <td><input name="salestax" type="text" size=10 maxlength=10 value="#salestax#">% <em style="font-size:0.75em; color:##CC3333;">(Do not enter value with % sign)</em> &nbsp;<input type="button" name="btnSalesTax" value="Get Sales Tax Rate" onclick="openWindow ('../sell/salestaxcalculator.cfm', 750, 400);"/></td>
        </tr>
	  <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr>
      <cfif isDefined('session.auction_mode')>
        <cfset #auction_mode# = #session.auction_mode#>
      </cfif>        

      <cfif #session.auction_mode# IS 0>
        <tr>
          <td><font size=3 color="0000ff"><b>Minimum Bid:</b></font></td>
          <td><font size=3><b>&nbsp;</b></font></td>
          <td><input name="minimum_bid" type="text" size=10 maxlength=10 value="#trim(numberformat(minimum_bid,'#numbermask#'))#">&nbsp;&nbsp;</td>
        </tr>
		<tr>
       		<td><font size=3><b>Buy Now:</b></font></td>
       		<td>&nbsp;</td>
       		<td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input type="text" name="buynow_price" size=10 maxlength=10 value="#buynow_price#"></td><!--- <td align="left"><input type="checkbox" name="buynow" value="1"<cfif #buynow# is "1"> checked</cfif>><font size=3>&nbsp;<b>Enabled</b></font></td><td>&nbsp;</td> ---></tr></table></td> 
    	</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>&nbsp;&nbsp;(Buy now function allow users buy at the setting price without bidding process)</td>
		</tr>
      <cfelse>
        <input type="hidden" name="minimum_bid"  value="#numberformat(minimum_bid,'#numbermask#')#"> 
      </cfif>

      <cfif #session.auction_mode# IS 1>
        <tr>
          <td><font size=3 color="0000ff"><b>Maximum Bid:</b></font></td>
          <td><font size=3><b>&nbsp;</b></font></td>
          <td><input name="maximum_bid" type="text" size=10 maxlength=10 value="#trim(numberformat(maximum_bid,'#numbermask#'))#">&nbsp;&nbsp; The maximum price a buyer is willing to pay in a reverse auction. <br><font color=blue>
Attention:  Maximum Bid must be an even multiple of the Bid Increment. 
<br> Error checking for this has not been installed on this page yet.</FONT></td>
        </tr>
      <cfelse>
        <input type="hidden" name="maximum_bid"  value="#numberformat(maximum_bid,'#numbermask#')#">      
      </cfif>
      <tr>
        <td valign="top"><font size=3><b>Reserve Bid:</b></font></td>
        <td><font size=3><b>&nbsp;</b></font></td>
        <td><input name="reserve_bid" type="text" size=10 maxlength=10 value="#trim(numberformat(reserve_bid,'#numbermask#'))#"><cfif #get_fee_reserve_bid.pair# GT 0> <font size=2>(a #numberFormat(get_fee_reserve_bid.pair,numbermask)# #Trim(getCurrency.type)# fee)</font><br></cfif>&nbsp; &nbsp;<b>(For single-quantity items only that are not reverse or buyer's auctions)</b></td>
      </tr>
      <tr>
        <td><font size=3><b>Bid Increment:</b></font></td>
        <td><font size=3><b>&nbsp;</b></font></td>
        <td><table border=0 cellspacing=0 cellpadding=0><tr><td><select name="increment_valu" size=1><cfloop query="get_increments"><option value="#pair#"<cfif #increment_valu# is #pair#> selected</cfif>>#trim(numberformat(pair,'#numbermask#'))#</option></cfloop></select></td><td>&nbsp;</td><td><input type="hidden" name="increment" value="1"></td></tr></table></td> 
      </tr>
      <tr>
        <td><font size=3><b>Dynamic Bid<br>Time (minutes):</b></font></td>
        <td>&nbsp;</td>
        <td><table border=0 cellspacing=0 cellpadding=0><tr><td><select name="dynamic_valu" size=1><cfloop query="get_dynamic"><option value="#pair#"<cfif #dynamic_valu# is #pair#> selected</cfif>>#Int(pair)#</option></cfloop></select></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"<cfif #dynamic# is "1"> checked</cfif>><font size=3>&nbsp;Enabled</font></td></tr></table></td> 
      </tr>
      <tr>
        <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr> 
      <tr>
        <td><font size=3><b>Other Settings:</b></font></td>
        <td>&nbsp;</td>
        <td><input type="checkbox" name="featured" value="1"<cfif #featured# is "1"> checked</cfif>><font size=3>&nbsp;Feature this item on the front page<cfif #get_fee_featured.pair# GT 0> <font size=2>(a #numberFormat(get_fee_featured.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td> 
      </tr>
      <tr>
        <td colspan=2>&nbsp;</td>
        <td><input type="checkbox" name="featured_cat" value="1"<cfif #featured_cat# is "1"> checked</cfif>><font size=3>&nbsp;Feature this item in its category(s)<cfif #get_fee_feat_cat.pair# GT 0> <font size=2>(a #numberFormat(get_fee_feat_cat.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td> 
      </tr>

   
     <cfif studio is 0>
	 <input type="hidden" name="featured_studio" value="#featured_studio#">
	<cfelse>
      <tr>
        <td colspan=2>&nbsp;</td>
        <td><input type="checkbox" name="featured_studio" value="1"<cfif #featured_studio# is "1">checked</cfif>><font size=3>&nbsp;Feature this item in  Studio.<cfif #get_fee_feat_studio.pair# GT 0> <font size=2>(a #numberformat(REReplace(get_fee_feat_studio.pair, "[^0-9.]", "", "ALL"),'#numbermask#')# #Trim(getCurrency.type)# fee)</font></cfif></font></td> 
      </tr>      
      </cfif>
      
       <tr>
       <td colspan=2><font size=3><B>Auto Relist</B></font></td>
	   <TD> 
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
	   &nbsp;&nbsp;The number of times an item will automatically relist if it does not sell.
	   </TD>
      </tr>
	  <tr>
	  <td><font size=3><B>Private Auction</B></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
	   <input type="checkbox" name="private" value="1"<cfif #private# is "1"> checked</cfif>><font size=3>&nbsp;Auction is private (hide E-Mail addresses)</font>
	   </td> 
      </tr>
      <tr>
        <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr> 
      <tr>
        <td colspan=4><input type="submit" name="submit" value="Add Item" width=75>&nbsp;&nbsp;&nbsp;<input type="reset" value="Clear" width=75></td>
      </tr> 
     </table>
    </td>
   </tr></table>
      </form>
     <div align="center">

 <cfinclude template="nav.cfm">
</div>
      </td></tr></table></div><div align="center">
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

