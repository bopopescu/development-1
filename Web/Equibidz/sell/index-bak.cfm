<!---
/sell/index.cfm
Auction items listing form.
---><cfset current_page="sell">

<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">


<cfif isDefined('session.user_id') is 0>
<cflocation url="/login.cfm?login=1&path=#script_name#" addtoken="No"></cfif>

<cfif mode_switch is "dual">
  <cfif isDefined('form.auction_mode') >
    <cfset auction_mode = form.auction_mode>
  </cfif>
</cfif>

 <!--- Check for valid login & password --->
    <cfquery username="#db_username#" password="#db_password#" name="get_seller" datasource="#DATASOURCE#">
        SELECT user_id, is_active,state,country,same_address,shipping_state, shipping_country
          FROM users
		  <cfif isDefined('session.nickname')>
		   WHERE nickname = '#session.nickname#'
		   <cfelseif isDefined('sesson.user_id')>
		  WHERE user_id = #session.user_id#
		
		  </cfif>
         
         AND is_active = 1
         AND confirmation =1
    </cfquery>

<!--- Get selected category from session or link --->
<cfif isDefined('submit') or isDefined('url.cat') or isDefined('session.category1')>
<cfif isDefined('url.cat')>
<cfset selected_cat = "#url.cat#">
<cfset selected_cat2 = "#url.cat#">
<cfelseif isDefined('session.category1')>
<cfset selected_cat = "#session.category1#">
<cfset selected_cat2 = "#session.category2#">
<cfelseif isDefined('form.category1')>
<cfset selected_cat = "#form.category1#">
<cfset selected_cat2 = "#form.category2#">
</cfif>

<cfquery name="selected_cat1" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">
SELECT category, name
FROM categories

where category = #selected_cat#

</cfquery>

<cfquery name="selected_cat_subs" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT category, name
FROM categories
where parent = #selected_cat#
</cfquery>
<cfelse>
<cflocation url="../listings/categories/top_cats.cfm?from=sell">
</cfif>
  <cfparam name="cat2name" default="None">
<cfparam name="session.auction_mode" default="0">  

<html>
 <head>
  <title>Sell Item Page</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 
<cfsetting enablecfoutputonly="Yes">
 
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
<!---    <cfset #password# = #session.password#> --->
  </cfif>
</cfif>

<!--- get increments info --->
<cfmodule template="../functions/BidIncrements.cfm">
 
<!--- Include this module to obtain a unique item number --->
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
    <cfset #EPOCH#=#EPOCH# + 1>
  <cfelse>
<!--- <cfset #itemnum#=#EPOCH#> --->
    <cfset #loop_again#=0>
  </cfif>
</cfloop>
  

<cfif #isDefined("directory")#>
  <cffile action="delete"	file="#directory##incoming#">  
</cfif> 
 



<!--- Auto Thumb resizing  --->

<cfif isdefined("form.thumb") and form.thumb is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"sell","thumbs")>
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


  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#">
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_height GT 110 or Img_width GT 124>
    <cfif Img_height/Img_width*100 GT 88>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="110"> 
     <cfelse>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="124"> 
    </cfif>
  </cfif>
  <!---
  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#">
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_height GT 110>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="110">    
  </cfif>
  <cfif Img_width GT 124>
  	<CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="124">
  </cfif>
--->
  <cfset session.incoming = #URLEncodedFormat(File.ServerFile)#>
  <cfset session.serverfile = #File.ServerFile#>
</cfif>  

<!--- upload full size image --->
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory2 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs")>
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
  <!-- Resize full size image if the width is greater than 640 or height greater than 480 -->
  <CFX_GIFGD ACTION="READ" FILE="#directory2##File.ServerFile#"> 
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_width GT 640>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory2##File.ServerFile#" OUTPUT="#directory2##thumbName#" x="640"> 
  <cfelseif Img_height GT 480>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory2##File.ServerFile#" OUTPUT="#directory2##thumbName#" y="480"> 
  </cfif>
</cfif>
<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs1")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture2 = #File.ServerFile#>
  <!-- Resize full size image if the width is greater than 640 or height greater than 480 -->
  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#"> 
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_width GT 640>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="640"> 
  <cfelseif Img_height GT 480>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="480"> 
  </cfif>
</cfif>

<!--- upload full size image #3--->
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs2")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture3 = #File.ServerFile#>
  <!-- Resize full size image if the width is greater than 640 or height greater than 480 -->
  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#"> 
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_width GT 640>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="640"> 
  <cfelseif Img_height GT 480>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="480"> 
  </cfif>
</cfif>
 

<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs3")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture4 = #File.ServerFile#>
  <!-- Resize full size image if the width is greater than 640 or height greater than 480 -->
  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#"> 
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_width GT 640>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="640"> 
  <cfelseif Img_height GT 480>
    <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="480"> 
  </cfif>
</cfif>

<cfif #isDefined("incoming")# is 0>
  <cfset #incoming# = "">
</cfif>   
<cfif #isDefined("theMsg")# is 0>
  <cfset #theMsg# = "">
</cfif>  


 
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">
 
<!---
   If they came back with the "<< Back" button from the preview
   page, restore the items from the session and clear it.
--->
<cfif #isDefined ("session.held_item")#> 
  <cfif #session.held_item# is "1">
   <cfset #session.held_item# = "0">
    <cfset #theMsg# = "<font color=ff0000>Please note: by refreshing the browser, some information may be lost.</font>">
    <!--- <cfif #isDefined ("thumb")#>
      <cfif #thumb# is not "">
        <cffile action="delete"	file="#directory##incoming#">  
      </cfif>    
    </cfif> --->  
    <!--- define if coming from form --->
    <cfif IsDefined("Form.submit")>
      <cfif Form.submit IS "Add Item">
        <cfset from_form = "TRUE">
      <cfelse>
        <cfset from_form = "FALSE">
      </cfif>
    <cfelse>
      <cfset from_form = "FALSE">
    </cfif>
   
    <!--- Get all vars from session variables --->
    <cfif not from_form>
      <cfset #itemnum# = #session.itemnum#>
      <cfset #status# = #session.status#>
      <cfset #user_id# = #session.user_id#>
      <cfset #category1# = #session.category1#>
      <cfset #category2# = #session.category2#>
      <cfset #auction_type# = #session.auction_type#>
      <cfset #title# = #session.title#>
      <cfset #location# = #session.location#>
	   <cfset state = session.state>
      <cfset #country# = #session.country#>
      <cfset #pay_morder_ccheck# = #session.pay_morder_ccheck#>
      <cfset #pay_cod# = #session.pay_cod#>
      <cfset #pay_see_desc# = #session.pay_see_desc#>
      <cfset #pay_pcheck# = #session.pay_pcheck#>
      <cfset #pay_ol_escrow# = #session.pay_ol_escrow#>
      <cfset #pay_other# = #session.pay_other#>
      <cfset #pay_visa_mc# = #session.pay_visa_mc#>
      <cfset #pay_am_express# = #session.pay_am_express#>
      <cfset #pay_discover# = #session.pay_discover#>
      <cfset #ship_sell_pays# = #session.ship_sell_pays#>
      <cfset #ship_buy_pays_act# = #session.ship_buy_pays_act#>
      <cfset #ship_see_desc# = #session.ship_see_desc#>
      <cfset #ship_buy_pays_fxd# = #session.ship_buy_pays_fxd#>
      <cfset #ship_international# = #session.ship_international#>
      <cfset #description# = #session.description#>
      <cfset #picture# = #session.picture#>
	  <cfset #picture1# = #session.picture1#>
	  <cfset #picture2# = #session.picture2#>
	  <cfset #picture3# = #session.picture3#>
	  <cfset #picture4# = #session.picture4#>
      <cfset #thumb# = #session.thumb#>
      <cfset #sound# = #session.sound#>
      <cfset #quantity# = #session.quantity#>
      <cfset #minimum_bid# = #session.minimum_bid#>
 	  <cfset #maximum_bid# = #session.maximum_bid#>
      <cfset #increment# = #session.increment#>
      <cfset #increment_valu# = #session.increment_valu#>
      <cfset #dynamic# = #session.dynamic#>
      <cfset #dynamic_valu# = #session.dynamic_valu#>
      <cfset #reserve_bid# = #session.reserve_bid#>
      <cfset #bold_title# = #session.bold_title#>
      <cfset #featured# = #session.featured#>
      <cfset #featured_cat# = #session.featured_cat#>
      <cfset #private# = #session.private#>
      <cfset #banner# = #session.banner#>
      <cfset #banner_line# = #session.banner_line#>
      <cfset #studio# = #session.studio#>
      <cfset #featured_studio# = #session.featured_studio#>
      <cfset #picture_studio# = #session.picture_studio#>
      <cfset #sound_studio# = #session.sound_studio#>
      <cfset #date_start# = #session.date_start#>
      <cfset #date_end# = #session.date_end#>
      <cfset #billmeth# = #session.billmeth#>
      <cfset #remote_ip# = #session.remote_ip#>
	  <cfset #auction_mode# = #session.auction_mode#>
      <cfset #auto_relist# = #session.auto_relist#>
      <cfset #session.held_item# = "0">
	  <cfset buynow_price = #session.buynow_price#>
	  <cfset buynow = #session.buynow#>
	  <cfset shipping_fee = #session.shipping_fee#>
	  <cfset salestax = #session.salestax#>
    </cfif>
  </cfif>
</cfif>
 


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

<!--- If defined, merge the seperate date and time objects into 1 object --->
<cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, Second(Now()))#>
</cfif>

<cfif #submit# is "Add Item">
  <cfif #isDefined ("Form.dynamic_valu")#>
    <cfif #Form.dynamic_valu# is "">
      <cfset #dynamic_valu# = "0">
    </cfif>
  </cfif>
  <cfif #isDefined ("Form.increment_valu")#>
    <cfif #Form.increment_valu# is "">
      <cfset #increment_valu# = "0">
    </cfif>
  </cfif>
  <cfif #isDefined ("Form.minimum_bid")#>
    <cfif #Form.minimum_bid# is "">
      <cfset #minimum_bid# = "0">
	  <cfelse>
	    <CFOUTPUT><cfset #minimum_bid# = REReplace("#form.minimum_bid#", "[^0123456789.]", "", "ALL")></CFOUTPUT>
    </cfif>
  </cfif>
  <cfif #isDefined ("Form.maximum_bid")#>
    <cfif #Form.maximum_bid# is "">
      <cfset #maximum_bid# = "0">
	  <cfelse>
	    <CFOUTPUT><cfset #maximum_bid# = REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")></CFOUTPUT>
    </cfif>
  </cfif>
  <cfif auction_mode is 0>
  	<cfif #isDefined ("Form.reserve_bid")#>
   		<cfif #Form.reserve_bid# is "">
    	<cfset #reserve_bid# = "0">
		<cfelse>
		<CFOUTPUT><cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")></CFOUTPUT>
   		</cfif>
  	</cfif> 
  <cfelse>
    <cfif #isDefined ("Form.reserve_bid")#>
      <cfif #Form.reserve_bid# is "" or #form.reserve_bid# is 0>
   	    <CFOUTPUT> <cfset #reserve_bid# =REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")></CFOUTPUT>
	    <cfelse>
	      <CFOUTPUT><cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")></CFOUTPUT>
      </cfif>
    </cfif> 
  </cfif> 

  <cfif #isDefined ("Form.bold_title")#><cfset #bold_title# = "1"><cfelse><cfset #bold_title# = "0"></cfif>
  <cfif #isDefined ("Form.pay_morder_ccheck")#><cfset #pay_morder_ccheck# = "1"><cfelse><cfset #pay_morder_ccheck# = "0"></cfif>
  <cfif #isDefined ("Form.pay_cod")#><cfset #pay_cod# = "1"><cfelse><cfset #pay_cod# = "0"></cfif>
  <cfif #isDefined ("Form.pay_see_desc")#><cfset #pay_see_desc# = "1"><cfelse><cfset #pay_see_desc# = "0"></cfif>
  <cfif #isDefined ("Form.pay_pcheck")#><cfset #pay_pcheck# = "1"><cfelse><cfset #pay_pcheck# = "0"></cfif>
  <cfif #isDefined ("Form.pay_ol_escrow")#><cfset #pay_ol_escrow# = "1"><cfelse><cfset #pay_ol_escrow# = "0"></cfif>
  <cfif #isDefined ("Form.pay_other")#><cfset #pay_other# = "1"><cfelse><cfset #pay_other# = "0"></cfif>
  <cfif #isDefined ("Form.pay_visa_mc")#><cfset #pay_visa_mc# = "1"><cfelse><cfset #pay_visa_mc# = "0"></cfif>
  <cfif #isDefined ("Form.pay_am_express")#><cfset #pay_am_express# = "1"><cfelse><cfset #pay_am_express# = "0"></cfif>
  <cfif #isDefined ("Form.pay_discover")#><cfset #pay_discover# = "1"><cfelse><cfset #pay_discover# = "0"></cfif>
  <cfif #isDefined ("Form.ship_sell_pays")#><cfset #ship_sell_pays# = "1"><cfelse><cfset #ship_sell_pays# = "0"></cfif>
  <cfif #isDefined ("Form.ship_buy_pays_act")#><cfset #ship_buy_pays_act# = "1"><cfelse><cfset #ship_buy_pays_act# = "0"></cfif>
  <cfif #isDefined ("Form.ship_see_desc")#><cfset #ship_see_desc# = "1"><cfelse><cfset #ship_see_desc# = "0"></cfif>
  <cfif #isDefined ("Form.ship_buy_pays_fxd")#><cfset #ship_buy_pays_fxd# = "1"><cfelse><cfset #ship_buy_pays_fxd# = "0"></cfif>
  <cfif #isDefined ("Form.ship_international")#><cfset #ship_international# = "1"><cfelse><cfset #ship_international# = "0"></cfif>
  <cfif #isDefined ("Form.increment")#><cfset #increment# = "1"><cfelse><cfset #increment# = "0"></cfif>
  <cfif #isDefined ("Form.dynamic")#><cfset #dynamic# = "1"><cfelse><cfset #dynamic# = "0"></cfif>
  <cfif #isDefined ("Form.featured")#><cfset #featured# = "1"><cfelse><cfset #featured# = "0"></cfif>
  <cfif #isDefined ("Form.featured_cat")#><cfset #featured_cat# = "1"><cfelse><cfset #featured_cat# = "0"></cfif>
  <cfif #isDefined ("Form.private")#><cfset #private# = "1"><cfelse><cfset #private# = "0"></cfif>
  <cfif #isDefined ("Form.banner")#><cfset #banner# = "1"><cfelse><cfset #banner# = "0"></cfif>
 <cfif #isDefined ("Form.auction_type")# is 0><cfset #auction_type# = "E"></cfif></cfif>
 
 <cfif #isDefined ("Form.thumb")#>
    <cfif #form.thumb# IS NOT "">
		<cfset #studio# = "1">
		<cfif isDefined('featured_studio')>
    	<cfset #featured_studio# = "1">
		<cfelse>
		<cfset #featured_studio# = "0">
		</cfif>
	<cfelse>
    	<cfset #studio# = "0">
    	<cfset #featured_studio# = "0">
  	</cfif>
</cfif>

  
  
<!--- Reset the error message string --->
  <cfif #isDefined("error_message")# is 0>
    <cfset #error_message# = "">
  </cfif>

  <!--- Check the form for valid data --->
  <cfif #submit# is "Add Item">

  	<cfif form.buynow_price gt 0>
      <cfset buynow = 1>
  	<cfelse>
	    <cfset buynow = 0>
  	</cfif>
  <!--- Make sure they specified a bid increment only if the quantity is 1 --->
    <cfif #increment# is "1">
      <cfif #quantity# GT 1>
        <cfset #increment# = "0">
      <cfelseif (#increment_valu# is 0) or (#isNumeric (increment_valu)# is 0)>
        <cfset #error_message# = "<font color=ff0000>You must specify a bid increment value if auto-incrementing is enabled.</font>"> 
      </cfif>
    </cfif>

    <!--- Check for valid login & password --->
    <cfquery username="#db_username#" password="#db_password#" name="check_login" datasource="#DATASOURCE#">
        SELECT user_id, is_active,state,country,same_address,shipping_state, shipping_country
          FROM users
         WHERE (nickname = '#login#'
         <cfif #isNumeric(login)#>
              OR user_id = #login#)
         <cfelse>
              )
         </cfif>
         AND password = '#password#'
         AND is_active = 1
         AND confirmation =1
    </cfquery>
    
    <CFIF isDefined('form.category1')>
      <cfquery username="#db_username#" password="#db_password#" NAME="getcat1_user_id" DATASOURCE="#Datasource#">
         SELECT user_id FROM Categories
          WHERE category = #form.category1#
      </CFQUERY>
    <cfelse>
      <cfoutput>form.category1 NOT defined</cfoutput>  
    </CFIF>
  
  
   
      <cfquery username="#db_username#" password="#db_password#" NAME="getcat2_user_id" DATASOURCE="#Datasource#">
         SELECT category,name,user_id FROM Categories
 <CFIF isDefined('form.category2') and form.category2 is not "">
          WHERE category = #form.category2#
		  <cfelseif isDefined('session.category2')>
		  WHERE category = #session.category2#
		   </cfif>
      </CFQUERY>
       <cfif #getcat2_user_id.recordcount# is 1>
      <cfset cat2user_id = "#getcat2_user_id.user_id#">
	<cfset cat2name= "#GETCAT2_USER_ID.NAME#">
<cfset cat2category = #getcat2_user_id.category#>      <cfelse>
      <cfset cat2user_id = 0>
	<cfset cat2name= "None">
<cfset cat2category = -1>    </cfif>


    <!--- If it's valid, store their info in session variables --->
    <cfif #check_login.recordcount# is 1>
      <cfset selected_user = check_login.user_id>
      <cfset #session.nickname# = "#login#">
    <cfelse>
      <cfset selected_user = 0>
    </cfif>
    
   <cfif #check_login.recordcount# is 0> 
      <cfset #error_message# = "<font color=ff0000>Login incorrect. Please try again.</font>">  
    <cfelseif #trim (title)# is "">
      <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
    <cfelseif (#trim (quantity)# is "") or (#isNumeric (quantity)# is 0) or (#quantity# is 0)>
      <cfset #error_message# = "<font color=ff0000>Please enter a valid quantity for this item.</font>"> 
    <cfelseif #trim (description)# is "">
      <cfset #error_message# = "<font color=ff0000>Please enter a description of this item.</font>"> 
    <cfelseif #trim (location)# is "">
      <cfset #error_message# = "<font color=ff0000>Please enter a location where this item will be shipped from.</font>"> 
    <cfelseif #trim (country)# is "">
      <cfset #error_message# = "<font color=ff0000>Please specify a country where this item will be shipped from.</font>"> 
    <cfelseif (#category1# is "-1") and (#category2# is "-1")>
      <cfset #error_message# = "<font color=ff0000>Please specify at least 1 auction category for this item.</font>">


    <!--check for exclusive category and match logon user_id with category user_id -->
 
   
    <cfelseif #getcat1_user_id.user_id# is not 0 and ((#selected_user# is not #getcat1_user_id.user_id#))>
      <cfset #error_message# = "You are not authorized to enter items in this primary category. Please contact the site administrator to list items in your own exclusive category.">
    <cfelseif (#getcat2_user_id.user_id# is not 0) and (#cat2user_id# is not 0) and ((#selected_user# is not #getcat2_user_id.user_id#) or (#selected_user# is not #cat2user_id#))>
        <cfset #error_message# = "You are not authorized to enter items in this secondary category. Please contact the site administrator to list items in your own exclusive category.">


    <!-- end check --->
   
    <cfelseif form.auction_mode is 0 and ((#trim (minimum_bid)# is "") or (#minimum_bid# is "0") or (#isNumeric (minimum_bid)# is "0"))>
      <cfset #error_message# = "<font color=ff0000>Please specify a minimum bid value for this item.</font>">
	<cfelseif form.auction_mode is 0 and (#auction_type# is "D" or #auction_type# is "Y") and #trim (reserve_bid)# gt 0>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">
	<cfelseif form.auction_mode is 1 and #trim (reserve_bid)# lt maximum_bid>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">
<!---
<cfelseif form.auction_mode is 0 and (#REReplace("#form.minimum_bid#", "[^0-9.]", "", "ALL")#  mod  #increment_valu#  is not "0")>
      <cfset #error_message# = "<font color=ff0000>Please make the minimum bid an even multiple of the bid increment.</font>"> 
--->
    <cfelseif form.auction_mode is 1 and ((#trim (maximum_bid)# is "") or (#maximum_bid# is "0") or (#isNumeric (maximum_bid)# is "0"))>
      <cfset #error_message# = "<font color=ff0000>Please specify a maximum bid value for this item.</font>"> 
	
	<cfelseif not isNumeric(buynow_price) or #buynow_price# eq "">
			<cfset #error_message# = "<font color=ff0000>Please double check the buy now price the default is 0 and required to be numeric.</font>">
	
	<cfelseif form.auction_mode eq 0 and buynow eq 1 and (not isNumeric(form.buynow_price) or #form.buynow_price# lt #minimum_bid#)>
		<cfset #error_message# = "<font color=ff0000>Please double check the buy now price for this item.</font>">
		
	<cfelseif auction_mode eq 0 and buynow eq 1 and #buynow_price# lt #reserve_bid#>
		<cfset #error_message# = "<font color=ff0000>The buynow option does not allow reserve bid greater than buynow price.</font>">
		
	<cfelseif form.auction_mode is 1 and buynow eq 1>
		<cfset #error_message# = "<font color=ff0000>Reverse auction does not allow the buy now option.  Please change the buy now value to 0.</font>">

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
	<cfif country is "USA" and state eq "">
	
	</cfif> 
  </cfif>



<!--- Check to see if we're saving an auction item --->
<cfif #submit# is "Add Item">
  <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
</cfif>

<cfif (#submit# is "Add Item") and (#error_message# is "")>
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
   
  <cfif form.buynow_price gt 0 and form.buynow_price gte #minimum_bid#>
      <cfset buynow = 1>
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
  <cfset session.state = state>
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
  <cfset #session.picture# = #picture#>
  <cfset #session.picture1# = #picture1#>
  <cfset #session.picture2# = #picture2#>
  <cfset #session.picture3# = #picture3#>
  <cfset #session.picture4# = #picture4#>
  <cfset #session.thumb# = #thumb#>
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
  <cfset #session.studio# = #studio#>
  <cfset #session.featured_studio# = #featured_studio#>
  <cfset #session.picture_studio# = #picture_studio#>
  <cfset #session.sound_studio# = #sound_studio#>
  <cfset #session.date_start# = #date_start#>
  <cfset #session.date_end# = #date_end#>
  <cfset #session.billmeth# = "BM">
  <cfset #session.remote_ip# = #cgi.remote_addr#>
  <cfset #session.auto_relist# = #auto_relist#>
  <cfset #session.auction_mode# = #auction_mode#>
  <cfset session.studio = #session.studio#> 
  <cfset session.buynow_price = #buynow_price#>
  <cfset session.buynow = #buynow#>
  <cfset session.shipping_fee = #shipping_fee#>
  <cfset session.salestax = #salestax#>

  <cflocation url="item_preview.cfm?itemnum=#itemnum#">
</cfif>
 

<!--- Set defaults --->
<cfif (#submit# is "") and (#submit# is not "<< Back")>
  <cfset #user_id# = "">
  <cfset #category1# = "#cat#">
  <cfset #category2# = "">
  <cfset #title# = "">
  <cfif get_seller.same_address eq 1>
  <cfset state = "#get_seller.state#">
  <cfset #country# = "#get_seller.country#">
  <cfelse>
<cfset state = "#get_seller.shipping_state#">
<cfset #country# = "#get_seller.shipping_country#">
  </cfif>

  <cfset #location# = "#state#">
  
  
  <cfset #description# = "">
  <cfset #picture# = "http://">
  <cfset #picture1# = "">
  <cfset #picture2# = "">
  <cfset #picture3# = "">
  <cfset #picture4# = "">
  <cfset #sound# = "http://">
  <cfset #picture_studio# = "http://">
  <cfset #thumb# = "">
  <cfset #sound_studio# = "http://">
  <cfset #quantity# = "1">
  <cfset #minimum_bid# = "0">
  <cfset #maximum_bid# = "0">
  <cfset #increment_valu# = hBidIncrements.fDefIncrement>
  <cfset #dynamic_valu# = "0">
  <cfset #reserve_bid# = "0">
  <cfset #banner_line# = "">
  <cfset #date_start# = "#Timenow#">
  <cfset #date_end# = "#Timenow#">
  <cfset #pay_morder_ccheck# = 0>
  <cfset #pay_cod# = 0>
  <cfset #pay_see_desc# = 0>
  <cfset #pay_pcheck# = 0>
  <cfset #pay_ol_escrow# = 0>
  <cfset #pay_other# = 0>
  <cfset #pay_visa_mc# = 0>
  <cfset #pay_am_express# = 0>
  <cfset #pay_discover# = 0>
  <cfset #ship_sell_pays# = 0>
  <cfset #ship_buy_pays_act# = 0>
  <cfset #ship_see_desc# = 0>
  <cfset #ship_buy_pays_fxd# = 0>
  <cfset #ship_international# = 0>
  <cfset #increment# = 0>
  <cfset #dynamic# = 0>
  <cfset #bold_title# = 0>
  <cfset #featured# = 0>
  <cfset #featured_cat# = 0>
  <cfset #private# = 0>
  <cfset #banner# = 0>
  <cfset #studio# = 0>
  <cfset #featured_studio# = 0> 
  <cfset #auction_type# = "E"> 
  <cfset #auto_relist# = "0">
  <cfset #buynow_price# = 0>
  <cfset #shipping_fee# = 0>
  <cfset #salestax# = 0>
</cfif>



<!--- Run a query to find all active categories --->
<cfquery username="#db_username#" password="#db_password#" name="get_cats" dataSource="#DATASOURCE#">
  SELECT name, category
    FROM categories
   WHERE active = 1
     AND allow_sales = 1
     AND parent > -1
   ORDER by name
</cfquery>

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

<cfsetting enablecfoutputonly="No">

<cfoutput>


<!--- Some JavaScript for the "Preview" buttons --->
<script language="JavaScript">

// Opens a new browser window with no titlebar and the given size, and
// loads the given URL into it.
function openWindow (URL, width, height){
  window.open (URL, "previewWindow", "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
}

function doThis(){
  if (document.item_input.thumb.value==""){
    document.item_input.featured_studio.checked=false
    alert("Thumbnail Source above is empty.\nPlease browse to the thumbnail on your local system.")
  } 
}   
  
function theRFlag(){
  if (document.item_input.auction_mode.selectedIndex == "1"){
    document.theFlag.src="../images/r_reverse.gif"
    document.item_input.maximum_bid.value=document.item_input.minimum_bid.value
    document.item_input.minimum_bid.value=0
    document.item_input.reserve_bid.value = document.item_input.maximum_bid.value
  }else{
    document.theFlag.src="../images/r_reverse_blank.gif"
    document.item_input.minimum_bid.value=document.item_input.maximum_bid.value
    document.item_input.maximum_bid.value=0
    document.item_input.reserve_bid.value = 0      
  }
} 
  
function singleItem(){ 
  if (document.item_input.quantity.value > 1){
    document.item_input.dynamic_valu.focus()
  }
}    

function reverseItem(){
  if (document.item_input.auction_mode.selectedIndex == 1){
     document.item_input.reserve_bid.value = document.item_input.maximum_bid.value
//     document.item_input.increment_valu.focus() 
  }
}    

function chk_minmax(parm){
  if ((parm == "min")&&(document.item_input.auction_mode.selectedIndex == "1")){
    document.item_input.maximum_bid.focus()
  }
  if ((parm == "max")&&(document.item_input.auction_mode.selectedIndex == "0")){
    if (document.item_input.minimum_bid.value == 0){
      document.item_input.minimum_bid.focus()
    }else{
      document.item_input.reserve_bid.focus()
    }      
  } 
}

function setLocation(){

var selObj = document.getElementById('state');
	
	var txtLocationObj = document.getElementById('txtLocation');
	
	var selIndex = selObj.selectedIndex;
	txtLocationObj.value = selObj.options[selIndex].value;
}
</script>


<!---
<body onLoad='if (document.item_input.login.value == ""){document.item_input.login.focus()}else{document.item_input.password.focus()}'>  
--->
  <!--- The main table --->
 
<cfinclude template = "../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><b>Post Auction Page</b></font></td></tr>

    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       This page allows you to put an item up for online auction.  Please
       fill out the following form to place your item(s) up for auction, remembering
       to be as accurate and honest as possible when describing your items, as set
       forth in the <A HREF="#VAROOT#/registration/user_agreement.html">User Agreement</A>.  You must be a <A HREF="#VAROOT#/registration/index.cfm">registered user</A> to sell an item.  <a href=/help/fee_schedule.cfm target=_blank><u>Fees</u></a>
      </font>
      <form action="index.cfm" method="post" name="item_input" ENCTYPE="multipart/form-data">
       <input type="hidden" name="#itemnum#" value="#itemnum#">
      <center><font size=2><b>Required items are in <font color="0000ff">blue</font>; all others are optional.</b></font></center>

      <cfif #theMsg# is not "">
         <br><font face="Helvetica" size=2 color=ff0000>#theMsg#<br></font>
         <cfset #theMsg# = "">
      </cfif>

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
      <tr><td colspan=3><hr size=1 color=#heading_color# width=100%></td></tr>
	  </cfif>

      <tr>
       <td><font size=3 color="0000ff"><b>Title:</b></font></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="text" size=35 maxlength=255 value="#title#"></td><td>&nbsp;<input name="bold_title" type="checkbox" value="1"<cfif #bold_title# is "1"> checked</cfif>><font size=3>&nbsp;Bold title<cfif #get_fee_bold.pair# GT 0> <font size=2>(a #numberformat(get_fee_bold.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td></tr></table></td>
      </tr>
      <tr>
       <td><font size=3><b>Banner line:</b></font></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="banner_line" type="text" size=35 maxlength=45 value="#banner_line#"></td><td>&nbsp;<input name="banner" type="checkbox" value="1"<cfif #banner# is "1"> checked</cfif>><font size=3>&nbsp;Enable banner<cfif #get_fee_banner.pair# GT 0> <font size=2>(a #numberformat(get_fee_banner.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td></tr></table></td>
      </tr>
      <tr>
       <td><font size=3 color="0000ff"><b>Quantity:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="quantity" type="text" size=5 maxlength=6 value="#quantity#"></td>
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
	   <cfif mode_switch is "dual">
	     <tr>
	       <td>
	         <font size=3 color="0000ff"><b>Auction Method:</b></font>
	       </td> 
	       <td>&nbsp;</td>
        <td>
	         <select name="auction_mode" onChange="theRFlag()">
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
     <cfelse>
       <input type="Hidden" name="auction_mode" value="#auction_mode#">
     </cfif>


     <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Item<br>Description:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><textarea name="description" rows=5 cols=50 wrap=virtual>#description#</textarea></td>
      </tr>
      <tr>
   
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
       <td colspan=2><input name="location" id="txtLocation" type="text" size=25 maxlength=100 value="#location#"><font size=2>  <b>USA:</b> Populated by the seller's shipping state override by selecting state above. <b>Other Country:</b> Enter manually.</font</td>
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
          <cfset #the_month# = #datePart ("m", "#Timenow#")#>
          <cfset #the_day# = #datePart ("d", "#Timenow#")#>
          <cfset #the_year# = #datePart ("yyyy", "#Timenow#")#>
          <cfset #the_time# = #timeFormat ("#Timenow#", 'hh:mm')#>
          <cfset #the_time_s# = #timeFormat ("#Timenow#", 'tt')#>
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
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Categories<br>Auctioned In:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top">
	   
        </cfoutput>
		
	<cfoutput query="selected_cat1">
		<font size="+2" color="Blue">#name#</font>
		
		<input type=hidden name="category1" value="#category#">
		</cfoutput>
		
		 Select new category <a href="../listings/categories/top_cats.cfm?from=sell">here</a>
        <br>
        <table border=0 cellspacing=0 cellpadding=0><tr><td>
		<select name="category2">
		<option value="-1"<cfif isDefined('session.category2') is 0> selected</cfif>> None </option>
		<cfif isDefined('session.category2') and session.category2 gt 0>
		<cfoutput><option value="#session.category2#" selected>#cat2name#</option></cfoutput>
		</cfif>
		<cfinclude template = "options.txt">
		</select>
		<cfoutput></td><td><cfif enable_cat_fee eq 1><font size=2>(<a href="../listings/categories/cat_fees.cfm" target="_blank">Click Here</a> to see fee for listing in a second category)</font><cfelse><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a #numberformat(get_fee_second_cat.pair,numbermask)# #Trim(getCurrency.type)# fee to list in a second category)</font><cfelse>&nbsp;</cfif></cfif></td></tr></table>
       </td>
      </tr>
      
      
      
      <tr>
        <td><font size=3><b>Picture URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#" >
            </td><td align=center><input type="button" name="previewImage" value="Preview" 
            onClick="if (document.item_input.picture.value != 'http://') 
            openWindow ('preview_image.cfm?image=' + escape(document.item_input.picture.value) 
            + '&title=' + escape(document.item_input.title.value), 450, 300);">
            </td></tr>
          </table>
         </td>
      </tr>   

<tr><td><font size=3><b>Full size<br>image1</b></font></td><td>&nbsp;</td><td><input name="picture1" type="file" size=43 maxlength=250><br><font size="2"><font size=2><cfif #get_fee_picture1.pair# GT 0>A #numberformat(get_fee_picture1.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
<tr><td><font><b>Full size<br>image2</b></font></td><td>&nbsp;</td><td><input name="picture2" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture2.pair# GT 0>A #numberformat(get_fee_picture2.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
<tr><td><font><b>Full size<br>image3</b></font></td><td>&nbsp;</td><td><input name="picture3" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture3.pair# GT 0>A #numberformat(get_fee_picture3.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
      
<tr><td><font size=3><b>Full size<br>image4</b></font></td><td>&nbsp;</td><td><input name="picture4" type="file" size=43 maxlength=250><br><font size="2"><cfif #get_fee_picture4.pair# GT 0>A #numberformat(get_fee_picture4.pair,numbermask)# #Trim(getCurrency.type)# fee for Image Upload.</cfif></font></td></tr>
      <tr>
        <td valign=top><font size=3><b>The Studio<br>Thumbnail:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="thumb" type="file" size=43 maxlength=250><br>

              <font size=2><cfif #get_fee_studio.pair# GT 0>A #numberformat(get_fee_studio.pair,numbermask)# #Trim(getCurrency.type)# fee for Studio Thumbnail Upload.</cfif>
		<br>Only JPG (not progressive) and GIF images are supported.</font>
		
            </td></tr>
          </table>
        </td>
      </tr>   

      <tr>      
        <td><font size=3><b>Sound URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td>
                <input name="sound" type="text" size=43 maxlength=250 value="#sound#">
              </td>
              <td>
                <input type="button" name="previewSound" value="Preview"  onClick="openWindow ('preview_image.cfm?image=' + escape(document.item_input.thumb_url.value) 
                + '&title=' + escape(document.item_input.title.value), 450, 300);">
              </td>
            </tr>
          </table>
        </td>
      </tr>
      
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr> 

     <input name="picture_studio" type=hidden value="#picture_studio#">
     <input name="sound_studio" type=hidden value="#sound_studio#">
 
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
		<td><font size=3><b>Shipping Fee:</b></font></td>
		<td>&nbsp;</td>
		<td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input type="text" name="shipping_fee" size="10" maxlength="10" value="#shipping_fee#"></td></tr></table></td> 
	  </tr>
	  <tr>
		<td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr>
	  <tr>
		<td><font size=3><b>Sales Tax Rate:</b></font></td>
		<td>&nbsp;</td>
		<td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="salestax" id="salestax" type="text" size=7 maxlength=9 value="#salestax#">% <em style="font-size:0.75em; color:##CC3333;">(Do not enter value with % sign)</em> &nbsp;<input type="button" name="btnSalesTax" value="Get Sales Tax Rate" onclick="openWindow ('salestaxcalculator.cfm', 750, 400);"/></td></tr></table></td> 
	  </tr>
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr>

	<!--- Display Minimum & Maximum bids according to mode settings --->
	<cfset str_minimum_bid = "Minimum Bid:">
	<cfset str_maximum_bid = "Maximum Bid:">
	<cfset str_min_description = "The minimum price at which you, the seller, are willing to start the bidding in a regular auction.">
	<cfset str_max_description = "The maximum price you, the buyer, are willing to pay in a <img src = ""../images/r_reverse.gif"" name=flag width=22 height=17 border=0>reverse auction.">








	<cfset str_input_min = "<input name=""minimum_bid"" type=""text"" size=10 maxlength=10 value=""#minimum_bid#"" onFocus=""chk_minmax('min')"">">
	<cfset str_input_max = "<input name=""maximum_bid"" type=""text"" size=10 maxlength=10 value=""#maximum_bid#"" onFocus=""chk_minmax('max')"">">







	<cfset str_min_layout = "<tr>" &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_minimum_bid# </b></font></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_min#" &
		"    &nbsp;&nbsp;  #str_min_description# </td>" &
		"</tr>">

	<cfset str_max_layout = "<tr>" &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_maximum_bid# </b></font></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_max#" &
		"    &nbsp;&nbsp;  #str_max_description# </td>" &
		"</tr>">

	<cfif mode_switch is "dual">
		#str_min_layout#
		#str_max_layout#

	<cfelse>
		<cfif auction_mode is 0>
			#str_min_layout#
			<input type="Hidden" name="maximum_bid" value="0">
		<cfelse>
			#str_max_layout#
			<input type="Hidden" name="minimum_bid" value="0">
		</cfif>
	</cfif>

    <tr>
      <td valign="top"><font size=3><b>Reserve Bid:</b></font></td>
      <td><font size=3><b>&nbsp;</b></font></td>
      <td><input name="reserve_bid" type="text" size=10 maxlength=10 value="#reserve_bid#" onFocus="reverseItem()"><cfif #get_fee_reserve_bid.pair# GT 0> <font size=2>(a #numberFormat(get_fee_reserve_bid.pair,numbermask)# #Trim(getCurrency.type)# fee)</font><br></cfif>&nbsp; &nbsp;<b>(For single-quantity items only that are not reverse or buyer's auctions)</b></td>
    </tr>
	
    <tr>
       <td><font size=3><b>Buy Now:</b></font></td>
       <td>&nbsp;</td>
       <td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input type="text" name="buynow_price" size="10" maxlength="10" value="#buynow_price#"></td></tr></table></td> 
    </tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td>&nbsp;&nbsp;(Buy now function allow users buy at the setting price without bidding process)</td>
	</tr>
    <tr>
      <td><font size=3><b>Bid Increment:</b></font></td>
      <td><font size=3><b>&nbsp;</b></font></td>
      <td>
        <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td>
              <select name="increment_valu" size=1><!---  onFocus="singleItem()" --->
              <cfloop index="i" from="1" to="#ArrayLen(hBidIncrements.aIncrements)#">
              <option value="#hBidIncrements.aIncrements[i]#"<cfif increment_valu IS hBidIncrements.aIncrements[i]> selected</cfif>>#numberformat(hBidIncrements.aIncrements[i],numbermask)#</option>
              </cfloop>
              </select>
            </td>
            <td>&nbsp;</td>
            <td><input type="hidden" name="increment" value="1"><!--- <font size=3>&nbsp;&nbsp;&nbsp;&nbsp;<b>(Increment is ignored if selling more than one item.)</b></font> ---></td>
          </tr>
        </table>
       </td> 
      </tr>
      <tr>
       <td><font size=3><b>Dynamic Bid<br>Time (minutes):</b></font></td>
       <td>&nbsp;</td>
       <td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><select name="dynamic_valu" size=1><cfloop query="get_dynamic"><option value="#pair#"<cfif #dynamic_valu# is #pair#> selected</cfif>>#Int(pair)#</option></cfloop></select></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"<cfif #dynamic# is "1"> checked</cfif>><font size=3>&nbsp;Enabled</font></td></tr></table></td> 
      </tr>
      <tr>
       <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
      </tr>

      <tr>
       <td valign=top><font size=3><b>Other Settings:</b></font></td>
       <td>&nbsp;</td>
       
       <td colspan=2><input type="checkbox" name="featured" value="1"<cfif #featured# is "1"> checked</cfif>><font size=3>&nbsp;Feature this item on the front page<cfif #get_fee_featured.pair# GT 0> <font size=2>(a #numberformat(get_fee_featured.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font>
	<br><input type="checkbox" name="featured_cat" value="1"<cfif #featured_cat# is "1"> checked</cfif>><font size=3>&nbsp;Feature this item in its category(s)<cfif #get_fee_feat_cat.pair# GT 0> <font size=2>(a #numberformat(get_fee_feat_cat.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font>
	
	<br><input type="checkbox" name="featured_studio" value="1" <cfif #featured_studio# is "1"> checked</cfif> onClick="doThis()"><font size=3>&nbsp;Feature this item in Studio<cfif #get_fee_feat_studio.pair# GT 0> <font size=2>(a #numberformat(get_fee_feat_studio.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font>
      </tr>


      <tr>
       <td><font size=3><B>Auto Relist</B></font></td>
       <td>&nbsp;</td>
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
	   &nbsp;&nbsp;The number of times an item will automatically relist if it does not sell.</TD>
      </tr>


      <tr>
	  <td><font size=3><B>Private Auction</B></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
	   <input type="hidden" name="private" value="0"<cfif #private# is "1"> checked</cfif>><font size=3>&nbsp;Auction is private (E-Mail addresses are hidden for sellers and bidders)</font>

	   <!--- <input type="hidden" name="private" value="0"> ---></td> 
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
      </table>
  </cfoutput>
  </div>
 </body>
</html>


