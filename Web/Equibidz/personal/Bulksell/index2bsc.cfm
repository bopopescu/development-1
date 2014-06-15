<!---
/sell/index.cfm
Auction bulk sell items listing form.
Includes Reverse auction and Studio upgrades.
11/29/99
--->

<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">

<!--- define TIMENOW --->
  <cfmodule template="../../functions/timenow.cfm">
  <!--- get increments info --->
<cfmodule template="../../functions/BidIncrements.cfm">
 

  
  <cfif isdefined("url.chck")>
  	<cfcookie name="user_id" value="#session.user_id#" >
  </cfif>
<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>
<!--- Set auction_mode --->

	<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
		<cfset session.auction_mode = auction_mode>
		<cfif isdefined("session.defaultlist") is 0>
			<cfset session.defaultlist = "">
		</cfif>
	</cflock>


<!--- <cfset error_message = ""> --->
<cfparam name = "error_message" default = "">

<cfparam name = "defaultlist" default = "">

<!--- put default list into session variable --->
	<cfif isdefined("form.defaultlist")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.defaultlist = form.defaultlist>
		</cflock>
	</cfif>
	
<!--- set defaults so variables in form values are defined --->
	<cfinclude template="setdefaults.cfm">
<!--- If self-submit Validate required fields --->	
	<cfif isdefined("form.submit")>
		<cfinclude template="bulkvalidate.cfm">
	</cfif>
<!--- If validating bulk sell defaults, set session variables --->
<cfif error_message eq "" and IsDefined("form.defaultlist") and form.submit neq "reset defaults">
<!--- Make sure images and sounds begin with http:// --->
	
		
	 <!---    They can't load pictures or thumbnails from the set defaults page,
	 so just make them http:// --->
	 
	 		<!--- comment this out when picture input box is comment --->
	 <!--- <cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
	    <cfset #picture# = "http://#picture#">
	  </cfif>
		<cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
	    <cfset #picture_studio# = "http://#picture_studio#">
	  </cfif> --->
			<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
				<cfset session.picture_file = "http://">
				<cfset session.picture_studio = "http://">
				<cfset session.picture = "http://">
			</cflock>
			
		<cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
	    <cfset #sound# = "http://#sound#">
	  </cfif>
	  <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
	    <cfset #sound_studio# = "http://#sound_studio#">
	  </cfif>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.sound = sound>
			<cfset session.sound_studio = sound_studio>
		</cflock>
	
  
  
	<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
		<cfset #session.held_item# = "1">
	  <cfset #session.status# = "1">
		 <cfif #isDefined ("Form.thumb")#>
		 	<cfset #studio# = "1">
		<cfelse>
			<cfset #studio# = "0">
		</cfif>
	  <cfset #session.studio# = #studio#>
	  <!--- <cfset #session.picture_studio# = #picture_studio#>
	  <cfset #session.sound_studio# = #sound_studio#> --->
	  <cfset #session.billmeth# = "BM">
	  <cfset #session.remote_ip# = #cgi.remote_addr#>
	</cflock>
	<cfif ListFindNoCase(form.defaultlist,"title")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.title = form.title>
			<cfif isdefined("form.bold_title")>
				<cfset session.bold_title = 1>
			<cfelse>
				<cfset session.bold_title = 0>
			</cfif>
		</cflock>
	</cfif>
  <cfif ListFindNoCase(form.defaultlist,"banner")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.banner")>
				<cfset session.banner = 1>
			<cfelse>
				<cfset session.banner = 0>
			</cfif>
			<cfset session.banner_line = form.banner_line>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"quantity")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.quantity = form.quantity>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"auction_type")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.auction_type = form.auction_type>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"description")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.description = form.description>
		</cflock>
	</cfif>
	<!--- <cfif ListFindNoCase(form.defaultlist,"high_est")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.high_est = form.high_est>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"low_est")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.low_est = form.low_est>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"condition")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.condition = form.condition>
		</cflock>
	</cfif> --->
	<cfif ListFindNoCase(form.defaultlist,"desc_languages")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.desc_languages")>
				<cfset session.desc_languages = form.desc_languages>
			<cfelse>
				<cfset error_message = "You must select a description language">
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"location")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			
			<cfset session.location = form.location>
			</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"country")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.country = form.country>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"date_start")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset #start_time# = "#start_time##start_time_s#">
		  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
		  <cfset #start_min# = #timeFormat (start_time, 'm')#>
		  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, Second(Now()))#>
			<cfset session.start_time = rereplace(start_time,"APM","","all")>
			<cfset session.start_time_s = start_time_s>
			<cfset session.date_start = date_start>
			<cfset session.start_year = start_year>
			<cfset session.start_day = start_day>
			<cfset session.start_hour = start_hour>
			<cfset session.start_min = start_min>
			<cfset session.start_month = start_month>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"date_end")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset #end_time# = "#end_time##end_time_s#">
		  <cfset #end_hour# = #timeFormat (end_time, 'H')#>
		  <cfset #end_min# = #timeFormat (end_time, 'm')#>
		  <cfset #date_end# = #createDateTime (end_year, end_month, end_day, end_hour, end_min, Second(Now()))#>
			<cfset session.end_time = rereplace(end_time,"APM","","all")>
			<cfset session.end_time_s = end_time_s>
			<cfset session.date_end = date_end>
			<cfset session.end_year = end_year>
			<cfset session.end_day = end_day>
			<cfset session.end_hour = end_hour>
			<cfset session.end_min = end_min>
			<cfset session.end_month = end_month>
		</cflock>
	</cfif>
	<!--- <cfif ListFindNoCase(form.defaultlist,"date_end")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset #end_time# = "#end_time##end_time_s#">
		  <cfset #end_hour# = #timeFormat (end_time, 'H')#>
		  <cfset #end_min# = #timeFormat (end_time, 'm')#>
		  <cfset #date_end# = #createDateTime (end_year, end_month, end_day, end_hour, end_min, Second(now()))#>
			<cfset session.date_end = date_end>
		</cflock>
	</cfif> --->
	<!--- <cfif ListFindNoCase(form.defaultlist,"duration")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.date_end = dateAdd ("d", "#duration#", date_start)>
		</cflock>
	</cfif> --->
	<cfif ListFindNoCase(form.defaultlist,"category1")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.category1 = form.category1>
			<cfset session.category2 = form.category2>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"picture1")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
<!--- 			<cfset session.picture1 = form.picture1> --->
			<cfset session.picture1 = "">
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"thumb")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
<!--- 			<cfset session.thumb = form.thumb> --->
			<cfset session.thumb = "">
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"paymethod")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.pay_morder_ccheck")>
				<cfset session.pay_morder_ccheck = 1>
			<cfelse>
				<cfset session.pay_morder_ccheck = 0>
			</cfif>
			<cfif isdefined("form.pay_cod")>
				<cfset session.pay_cod = 1>
			<cfelse>
				<cfset session.pay_cod = 0>
			</cfif>
			<cfif isdefined("form.pay_see_desc")>
				<cfset session.pay_see_desc = 1>
			<cfelse>
				<cfset session.pay_see_desc = 0>
			</cfif>
			<cfif isdefined("form.pay_pcheck")>
				<cfset session.pay_pcheck = 1>
			<cfelse>
				<cfset session.pay_pcheck = 0>
			</cfif>
			<cfif isdefined("form.pay_ol_escrow")>
				<cfset session.pay_ol_escrow = 1>
			<cfelse>
				<cfset session.pay_ol_escrow = 0>
			</cfif>
			<cfif isdefined("form.pay_other")>
				<cfset session.pay_other = 1>
			<cfelse>
				<cfset session.pay_other = 0>
			</cfif>
			<cfif isdefined("form.pay_visa_mc")>
				<cfset session.pay_visa_mc = 1>
			<cfelse>
				<cfset session.pay_visa_mc = 0>
			</cfif>
			<cfif isdefined("form.pay_am_express")>
				<cfset session.pay_am_express = 1>
			<cfelse>
				<cfset session.pay_am_express = 0>
			</cfif>
			<cfif isdefined("form.pay_discover")>
				<cfset session.pay_discover = 1>
			<cfelse>
				<cfset session.pay_discover = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"shipping")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.ship_sell_pays")>
				<cfset session.ship_sell_pays = 1>
			<cfelse>
				<cfset session.ship_sell_pays = 0>
			</cfif>
			<cfif isdefined("form.ship_buy_pays_act")>
				<cfset session.ship_buy_pays_act = 1>
			<cfelse>
				<cfset session.ship_buy_pays_act = 0>
			</cfif>
			<cfif isdefined("form.ship_see_desc")>
				<cfset session.ship_see_desc = 1>
			<cfelse>
				<cfset session.ship_see_desc = 0>
			</cfif>
			<cfif isdefined("form.ship_buy_pays_fxd")>
				<cfset session.ship_buy_pays_fxd = 1>
			<cfelse>
				<cfset session.ship_buy_pays_fxd = 0>
			</cfif>
			<cfif isdefined("form.ship_international")>
				<cfset session.ship_international = 1>
			<cfelse>
				<cfset session.ship_international = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"minimum_bid") OR auction_mode eq 1>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif Form.minimum_bid is "">
      	<cfset session.minimum_bid = "0">
	 	 <cfelse>
				<cfset session.minimum_bid = REReplace("#form.minimum_bid#", "[^0123456789.]", "", "ALL")>
		 </cfif>	
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"maximum_bid") or auction_mode eq 0>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif Form.maximum_bid is "">
      	<cfset session.maximum_bid = "0">
	 	 <cfelse>
				<cfset session.maximum_bid = REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
		 </cfif>	
	  </cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"reserve_bid")>
		<cfif auction_mode is 0><!--- normal --->
 			<cfif Form.reserve_bid is "">
				<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
  					<cfset session.reserve_bid = "0">
				</cflock>
			<cfelse>
				<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
					<cfset session.reserve_bid = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
				</cflock>
 			</cfif>
	  <cfelse><!--- reverse --->
    	<cfif #Form.reserve_bid# is "" or #form.reserve_bid# is 0>
				<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
  	 	    <cfset #session.reserve_bid# =REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
				</cflock>
   	 <cfelse>
		 		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
    	    <cfset #session.reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
				</cflock>
   	  </cfif>
    </cfif>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"buynow")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif form.buynow_price gt 0 and form.buynow_price gte #minimum_bid#>
				<cfset session.buynow_price = form.buynow_price>
				<cfset session.buynow = 1>
			<cfelse>
				<cfset session.buynow_price = 0>
				<cfset session.buynow = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"increment_valu")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif Form.increment_valu is "">
	      <cfset session.increment_valu = "0">
	    <cfelse>
				<cfset session.increment_valu = form.increment_valu>
			</cfif>
				<cfset session.increment = 1>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"dynamic_valu")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif Form.dynamic_valu is "">
      	<cfset session.dynamic_valu = "0">
      <cfelse>
				<cfset session.dynamic_valu = form.dynamic_valu>
			</cfif>
			<cfif isdefined("form.dynamic")>
				<cfset session.dynamic = 1>
			<cfelse>
				<cfset session.dynamic = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"featured")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.featured")>
				<cfset session.featured = 1>
			<cfelse>
				<cfset session.featured = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"featured_cat")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.featured_cat")>
				<cfset session.featured_cat = 1>
			<cfelse>
				<cfset session.featured_cat = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"featured_studio")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.featured_studio")>
				<cfset session.featured_studio = 1>
			<cfelse>
				<cfset session.featured_studio = 0>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"auto_relist")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif auto_relist eq "">
				<cfset session.auto_relist = "0">
			<cfelse>	
				<cfset session.auto_relist = form.auto_relist>
			</cfif>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"private")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfif isdefined("form.private")>
				<cfset session.private = 1>
			<cfelse>
				<cfset session.private = 0>
			</cfif>
		</cflock>
	</cfif>
	<!--- <cfif ListFindNoCase(form.defaultlist,"orig_cost")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.orig_cost = form.orig_cost>
		</cflock>
	</cfif> --->
	<!--- <cfif ListFindNoCase(form.defaultlist,"wh_location")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.wh_location = form.wh_location>
		</cflock>
	</cfif>
	<cfif ListFindNoCase(form.defaultlist,"consignor")>
		<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
			<cfset session.consignor = form.consignor>
		</cflock>
	</cfif> --->
	<cflocation url="bulksell.cfm" addtoken="No">
</cfif>



<!--- get currency type --->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
   SELECT pair AS type
     FROM defaults
    WHERE name = 'site_currency'
</cfquery>

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



<html>
 <head>
  <title>Sell Item Bulk Loader Set Defaults Page</title>
   
  
  
 </head>
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
    alert("Thumbnail Source above is empty.\nPlease indicate the thumbnail file.")
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

</script>
<!--- Calculate minimum bid  --->
  		<script language="JavaScript" type="text/javascript">
  			function calc_minimum_bid(low_est){
				if (document.item_input.low_est.value > 0){
				document.item_input.minimum_bid.value = (document.item_input.low_est.value) * 0.5;
				}
				}
  		</script>

<body>  

 <table border=0 cellspacing=0 cellpadding=2 width=640 align="center">
    <tr><td><center><cfoutput>&nbsp; &nbsp; &nbsp; <FONT SIZE=2><cfinclude template="../../includes/menu_bar.cfm"></FONT></center><br><br></td></tr>
    <tr>
			<td>
				<cfif auction_mode is 0>
		 			<font size=4><b>Bulk Load Set Defaults Normal Auction Page</b></font>
          <img src = "../../images/r_reverse_blank.gif" name="theFlag" width=22 height=17 border="0">
       	<cfelse>
					<font size=4><b>Bulk Load Set Defaults Reverse Auction Page</b></font>
           <img src = "../../images/r_reverse.gif" name="theFlag" width=22 height=17 border="0">
         </cfif>
			</td>
		</tr>
		<tr><td><img src=#varoot#/images/spacer.gif height=8 width=2></td></tr>
    <tr>
     <td>
      
       This page allows you to put multiple items up for online auction.  The first 
			 time you fill out the page, only fill out the fields which will be the same 
			 for all items, and check the checkbox for the default fields. The page will 
			 then display only the fields which change. You can submit as many items as 
			 you want, and the default settings will be remembered.
			 Please  fill out the following form to place your item(s) up for auction, remembering
       to be as accurate and honest as possible when describing your items, as set
       forth in the <A HREF="#VAROOT#/registration/user_agreement.html">User Agreement</A>.  You must be a <A HREF="#VAROOT#/registration/index.cfm">registered user</A> to sell an item.
      </font>
      <form action="index2.cfm" method="post" name="item_input" ENCTYPE="multipart/form-data">
       
			 <input type="hidden" name="auction_mode" value="#auction_mode#">
      <center><font size=2><b>Required items are in <font color="0000ff">blue</font>; all others are optional.</b></font></center>

      

      <cfif #error_message# is not "">
         <br><font face="Helvetica" size=2 color=ff0000><b>ERROR:</b> #error_message#<br></font>
      </cfif> 

      <img src=#varoot#/images/spacer.gif height=8 width=2>
      <table border=0 cellspacing=0 cellpadding=2 width=100%>

      
			 <td valign="top"><input type="checkbox" name="defaultlist" value="title" <cfif ListFindNoCase(session.defaultlist,"title")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Title:</b></td>
			 <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td><input name="title" type="text" size=35 maxlength=75 value="#title#"></td><td>&nbsp;<input name="bold_title" type="checkbox" value="1">&nbsp;Bold title<cfif #get_fee_bold.pair# GT 0> <font size=2>(a #DecimalFormat(get_fee_bold.pair)# #Trim(getCurrency.type)# fee)</font></cfif></td></tr></table></td>
      </tr>
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="banner" <cfif ListFindNoCase(session.defaultlist,"banner")> checked </cfif>></td>
       <td><b>Banner:</b></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td><input name="banner_line" type="text" size=35 maxlength=45 value="#banner_line#"></td><td>&nbsp;<input name="banner" type="checkbox" value="1">&nbsp;Enable banner<cfif #get_fee_banner.pair# GT 0> <font size=2>(a #DecimalFormat(get_fee_banner.pair)# #Trim(getCurrency.type)# fee)</font></cfif></td></tr></table></td>
      </tr>
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="quantity" <cfif ListFindNoCase(session.defaultlist,"quantity")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Quantity:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="quantity" type="text" size=5 maxlength=6 value="#quantity#"></td>
      </tr>
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="auction_type" <cfif ListFindNoCase(session.defaultlist,"auction_type")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Auction Type:</b></td>
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
     <tr valign="top"  bgcolor="##D9D9D9">
		   <td valign="top"><input type="checkbox" name="defaultlist" value="description" <cfif ListFindNoCase(session.defaultlist,"description")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Item<br>Description:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><textarea name="description" rows=5 cols=50 wrap=virtual>#description#</textarea></td>
      </tr>
	  <!--- <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="high_est" <cfif ListFindNoCase(session.defaultlist,"high_est")> checked </cfif>></td>
       <td><b>High estimate:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="high_est" type="text" size=7 maxlength=9 value="#high_est#"></td>
      </tr>
	  <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="low_est" <cfif ListFindNoCase(session.defaultlist,"low_est")> checked </cfif>></td>
       <td><b>Low estimate:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="low_est" type="text" size=7 maxlength=9 value="#low_est#" onblur="calc_minimum_bid()"></td>
      </tr>
	  <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="condition" <cfif ListFindNoCase(session.defaultlist,"condition")> checked </cfif>></td>
       <td><b>Condition:</b></td>
       <td>&nbsp;</td>   
       <td>
        <select name="condition">
		 <option value="">
         <option value="Mint"<cfif #condition# is "Mint"> selected</cfif>>Mint</option>
         <option value="Excellent+"<cfif #condition# is "Excellent+"> selected</cfif>>Excellent+</option>
         <option value="Excellent"<cfif #condition# is "Excellent"> selected</cfif>>Excellent</option>
         <option value="Excellent-"<cfif #condition# is "Excellent-"> selected</cfif>>Excellent-</option>
		 <option value="VGood+"<cfif #condition# is "VGood+"> selected</cfif>>Very Good+</option>
         <option value="VGood"<cfif #condition# is "VGood"> selected</cfif>>Very Good</option>
         <option value="VGood-"<cfif #condition# is "VGood-"> selected</cfif>>Very Good-</option>
         <option value="Good+"<cfif #condition# is "Good+"> selected</cfif>>Good+</option>
		 <option value="Good"<cfif #condition# is "Good"> selected</cfif>>Good</option>
         <option value="Good-"<cfif #condition# is "Good-"> selected</cfif>>Good-</option>
         <option value="Fair+"<cfif #condition# is "Fair+"> selected</cfif>>Fair+</option>
         <option value="Fair"<cfif #condition# is "Fair"> selected</cfif>>Fair</option>
		 <option value="Fair-"<cfif #condition# is "Fair-"> selected</cfif>>Fair-</option>
		 <option value="Poor"<cfif #condition# is "Poor"> selected</cfif>>Poor</option>
        </select>
       </td>
      </tr> --->
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="desc_languages" <cfif ListFindNoCase(session.defaultlist,"desc_languages")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Description<br>Languages:</b></td>
       <td>&nbsp;</td></cfoutput> 
       <td colspan=2>
			 
        <cfmodule template="..\..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="desc_languages" selected="#desc_languages#" size=5 multiple="yes">
       </td>
      </tr>
      <cfoutput> 
			<tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="location" <cfif ListFindNoCase(session.defaultlist,"location")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Location:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="location" type="text" size=35 maxlength=100 value="<cfif location is ""><cfelse>#location#</cfif>"></td>
      </tr>
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="country" <cfif ListFindNoCase(session.defaultlist,"country")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Country:</b></td>
       <td>&nbsp;</td>
			 </cfoutput> 
       <td colspan=2>
        <CFMODULE TEMPLATE="..\..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1">
       </td>
      </tr>
      <cfoutput> 
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="date_start" <cfif ListFindNoCase(session.defaultlist,"date_start")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Start Date/Time:</b></td>
       <td>&nbsp;</td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr valign="top" >
				 <cfif isdefined("form.defaultlist") eq 0 or ListContainsNoCase(defaultlist,"date_start") eq 0>
				  <cfset #start_month# = #datePart ("m", "#timenow#")#>
          <cfset #start_day# = #datePart ("d", "#timenow#")#>
          <cfset #start_year# = #datePart ("yyyy", "#timenow#")#>
          <cfset #start_time# = #rereplace(timeFormat ("#timenow#", 'hh:mm'),"APM","","ALL")#>
          <cfset #start_time_s# = #timeFormat ("#timenow#", 'tt')#>
		 <cfelse>
		 <cfset #start_time# = #rereplace(timeFormat ("#start_time#", 'hh:mm'),"APM","","ALL")#>
         </cfif>
				  <td>
					<select name="start_month">
            <option value="1"<cfif #start_month# is "1"> selected</cfif>>Jan</option>
            <option value="2"<cfif #start_month# is "2"> selected</cfif>>Feb</option>
            <option value="3"<cfif #start_month# is "3"> selected</cfif>>Mar</option>
            <option value="4"<cfif #start_month# is "4"> selected</cfif>>Apr</option>
            <option value="5"<cfif #start_month# is "5"> selected</cfif>>May</option>
            <option value="6"<cfif #start_month# is "6"> selected</cfif>>Jun</option>
            <option value="7"<cfif #start_month# is "7"> selected</cfif>>Jul</option>
            <option value="8"<cfif #start_month# is "8"> selected</cfif>>Aug</option>
            <option value="9"<cfif #start_month# is "9"> selected</cfif>>Sep</option>
            <option value="10"<cfif #start_month# is "10"> selected</cfif>>Oct</option>
            <option value="11"<cfif #start_month# is "11"> selected</cfif>>Nov</option>
            <option value="12"<cfif #start_month# is "12"> selected</cfif>>Dec</option>
           </select>
          </td>
          <td><input name="start_day" type="text" size=2 maxlength=2 value="#start_day#">,</td>
          <td><input name="start_year" type="text" size=4 maxlength=4 value="#start_year#"></td>
          <td>&nbsp;at&nbsp;</td>
          <td><input name="start_time" type="text" size=5 maxlength=5 value="#rereplace(start_time,"^0-9:","","all")#"></td>
          <td>
           <select name="start_time_s">
          <option value="AM"<cfif #start_time_s# is "AM"> selected</cfif>>AM</option>
            <option value="PM"<cfif #start_time_s# is "PM">
			selected</cfif>>PM</option>
           </select>
          </td>
         </tr>
        </table>
       </td>
      </tr>
			<tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
	  <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="date_end" <cfif ListFindNoCase(session.defaultlist,"date_end")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>End Date/Time:</b></td>
       <td>&nbsp;</td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr valign="top" >
		 <cfif isdefined("form.defaultlist") is 0 or ListContainsNoCase(defaultlist,"date_end") eq 0>
          <cfset #End_month# = #datePart ("m", "#timenow#")#>
          <cfset #End_day# = #datePart ("d", "#timenow#")#>
          <cfset #End_year# = #datePart ("yyyy", "#timenow#")#>
		    <cfset #end_time# = #rereplace(timeFormat ("#timenow#", 'hh:mm'),"APM","","ALL")#>
   <!--- <cfset #End_time# = "#end_hour#:#end_min#">
		  <cfset End_time = "#rereplace(end_time,"PM","","all")#">  --->
          <cfset #End_time_s# = #timeFormat ("#timenow#", 'tt')#>
		<cfelse>
		 <cfset #end_time# = #rereplace(timeFormat ("#end_time#", 'hh:mm'),"APM","","ALL")#>
		</cfif>
          <td>
					<select name="end_month">
				<option value="" selected>&nbsp;</option>	
            <option value="1">Jan</option>
            <option value="2">Feb</option>
            <option value="3">Mar</option>
            <option value="4">Apr</option>
            <option value="5">May</option>
            <option value="6">Jun</option>
            <option value="7">Jul</option>
            <option value="8">Aug</option>
            <option value="9">Sep</option>
            <option value="10">Oct</option>
            <option value="11">Nov</option>
            <option value="12">Dec</option>
           </select>
		  <!--- <INPUT TYPE="Hidden" NAME="end_month_required" VALUE="You must select a month when the auction ends."> --->
          </td>
          <td><input name="End_day" type="text" size=2 maxlength=2 value="">,<!--- <input type="hidden" name="end_day_required" value="You must select a day when the auction ends."> ---></td>
          <td><input type="text" name="End_year"size=4 maxlength=4 value="#end_year#"><input type="Hidden" name="End_year_required"  value="You must enter the Year the auctions end"></td>
          <td>&nbsp;at&nbsp;</td>
          <td><input name="End_time" type="text" size=5 maxlength=5 value="#end_time#"></td>
          <td>
           <select name="End_time_s">
            <option value="AM"<cfif #end_time_s# is "AM"> selected</cfif>>AM</option>
            <option value="PM"<cfif #end_time_s# is "PM"> selected</cfif>>PM</option>
           </select>
          </td>
         </tr>
        </table>
       </td>
      </tr>
      <!--- <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="duration" <cfif ListFindNoCase(session.defaultlist,"duration")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Auction Duration:</b></td>
       <td>&nbsp;</td>   
       <td>
        <table border=0 cellspacing=0 cellpadding=0>
         <tr valign="top" >
          <cfset #start_duration# = #dateDiff ("d", date_start, date_end)#> 
          <td><select name="duration">                 
           <cfloop query="get_durations">
            <option value="#int (pair)#"<cfif (#int (pair)# is #start_duration#) or (#int (pair)# is #int (get_def_duration.pair)#)> selected</cfif>>#int (pair)#</option>
           </cfloop>
           </select></td>
          <td>&nbsp;day(s)</td>
         </tr>
        </table>
       </td>
      </tr> --->
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="category1" <cfif ListFindNoCase(session.defaultlist,"category1")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Categories<br>Auctioned In:</b></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top">
        </cfoutput><cfmodule template="..\..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category1"
                  selected="#category1#"><cfoutput>
        <br>
        <table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td></cfoutput><cfmodule template="..\..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category2"
                  show_none="yes"
                  selected="#category2#"><cfoutput></td><td><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a #DecimalFormat(get_fee_second_cat.pair)# #Trim(getCurrency.type)# fee for 2nd category)</font><cfelse>&nbsp;</cfif></td></tr></table>
       </td>
      </tr>
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      
      
      <tr valign="top"  bgcolor="##D9D9D9">
			  <td valign="top"><input type="checkbox" name="defaultlist" value="picture_file" <cfif ListFindNoCase(session.defaultlist,"picture_file")> checked </cfif>></td>
        <td><b>Picture URL:</b></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr valign="top" ><td> <FONT FACE="" SIZE="+1" COLOR="Red">Check checkbox if <u>no </u> images are to be loaded for this set of auctions. </FONT><br>
              <font size=2>
		<!--- <br>Only JPG  images are supported.  ---></td><td align=center>&nbsp;<!--- <input type="button" name="previewImage" value="Preview" 
            onClick="if (document.item_input.picture_file.value != 'http://') 
            openWindow ('preview_image.cfm?image=' + escape(document.item_input.picture_file.value) 
            + '&title=' + escape(document.item_input.title.value), 450, 300);"> --->
            </td></tr>
          </table>
         </td>
      </tr>
	  
	  <tr valign="top" >
		<td valign="top"><input type="checkbox" name="defaultlist" value="picture1" <cfif ListFindNoCase(session.defaultlist,"picture1")> checked </cfif>></td>
        <td valign=top><b>Full Size<br>Image:</b></td>
        <td>&nbsp;</td>
        <td>    <FONT FACE="" SIZE="+1" COLOR="Red">Check checkbox if <u>no</u> full size images are to be loaded for this set of auctions. </FONT>
			<!--- <input name="picture1" type="file" size=43 maxlength=250><br>
              <font size=2>A <cfif #get_fee_studio.pair# GT 0>#DecimalFormat(get_fee_studio.pair)# #Trim(getCurrency.type)#</cfif> fee for Studio inclusion.
		<br>Only JPEG and GIF images are supported.  Image dimensions preferred: 124 width, 110 height pixels.  Other sizes will try to fit, and may display distorted.</font> --->
        </td>
      </tr>
	  
	  <tr valign="top" >
		<td valign="top"><input type="checkbox" name="defaultlist" value="thumb" <cfif ListFindNoCase(session.defaultlist,"thumb")> checked </cfif>></td>
        <td valign=top><b>Thumbnail<br>source:</b></td>
        <td>&nbsp;</td>
        <td>    <FONT FACE="" SIZE="+1" COLOR="Red">Check checkbox if <u>no</u> thumbnail images are to be loaded for this set of auctions. </FONT>
			<!--- <input name="thumb" type="file" size=43 maxlength=250><br>
              <font size=2>A <cfif #get_fee_studio.pair# GT 0>#DecimalFormat(get_fee_studio.pair)# #Trim(getCurrency.type)#</cfif> fee for Studio inclusion.
		<br>Only JPEG and GIF images are supported.  Image dimensions preferred: 124 width, 110 height pixels.  Other sizes will try to fit, and may display distorted.</font> --->
        </td>
      </tr>   

     <tr valign="top"  bgcolor="##D9D9D9">  
				<td valign="top"><input type="checkbox" name="defaultlist" value="sound" <cfif ListFindNoCase(session.defaultlist,"sound")> checked </cfif>></td>
        <td><b>Sound URL:</b></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr valign="top" >
              <td>
                <input name="sound" type="text" size=43 maxlength=250 value="#sound#">
              </td>
              <td>&nbsp;
                <!--- <input type="button" name="previewSound" value="Preview"  onClick="openWindow ('preview_image.cfm?image=' + escape(document.item_input.thumb_url.value) 
                + '&title=' + escape(document.item_input.title.value), 450, 300);"> --->
              </td>
            </tr>
          </table>
        </td>
      </tr>
      
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 

     <input name="picture_studio" type=hidden value="#picture_studio#">
     <input name="sound_studio" type=hidden value="#sound_studio#">
 
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="paymethod" <cfif ListFindNoCase(session.defaultlist,"paymethod")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Accepted<br>Payment<br>Methods:</b></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>>&nbsp;Cashier's Check/Money Order</td>
          <td width=25>&nbsp;</td>
          <td><input name="pay_am_express" type="checkbox" value="1"<cfif #pay_am_express# is "1"> checked</cfif>>&nbsp;American Express card</td>
         </tr>
         <tr>
          <td><input name="pay_cod" type="checkbox" value="1"<cfif #pay_cod# is "1"> checked</cfif>>&nbsp;Collect-on-delivery (COD)</td>
          <td>&nbsp;</td>
          <td><input name="pay_discover" type="checkbox" value="1"<cfif #pay_discover# is "1"> checked</cfif>>&nbsp;Discover card</td>
         </tr>
         <tr>
          <td><input name="pay_pcheck" type="checkbox" value="1"<cfif #pay_pcheck# is "1"> checked</cfif>>&nbsp;Personal check</td>
          <td>&nbsp;</td>
          <td><input name="pay_ol_escrow" type="checkbox" value="1"<cfif #pay_ol_escrow# is "1"> checked</cfif>>&nbsp;Online escrow</td>
         </tr>
         <tr>
          <td><input name="pay_visa_mc" type="checkbox" value="1"<cfif #pay_visa_mc# is "1"> checked</cfif>>&nbsp;VISA/MasterCard</td>
          <td>&nbsp;</td>
          <td><input name="pay_other" type="checkbox" value="1"<cfif #pay_other# is "1"> checked</cfif>>&nbsp;Other/Not listed here</td>
         </tr>
         <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>>&nbsp;See item description for payment information</td></tr>
        </table>
       </td>
      </tr>
      <tr valign="top" >

       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="shipping" <cfif ListFindNoCase(session.defaultlist,"shipping")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Shipping<br>Info:</b></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="ship_sell_pays" type="checkbox" value="1"<cfif #ship_sell_pays# is "1"> checked</cfif>>&nbsp;Seller pays shipping costs</td>
         </tr>
         <tr>
          <td><input name="ship_buy_pays_act" type="checkbox" value="1"<cfif #ship_buy_pays_act# is "1"> checked</cfif>>&nbsp;Buyer pays actual shipping costs</td>
         </tr>
         <tr>
          <td><input name="ship_buy_pays_fxd" type="checkbox" value="1"<cfif #ship_buy_pays_fxd# is "1"> checked</cfif>>&nbsp;Buyer pays fixed shipping costs</td>
         </tr>
         <tr>
          <td><input name="ship_international" type="checkbox" value="1"<cfif #ship_international# is "1"> checked</cfif>>&nbsp;Allow international shipping</td>
         </tr>
         <tr>
          <td><input name="ship_see_desc" type="checkbox" value="1"<cfif #ship_see_desc# is "1"> checked</cfif>>&nbsp;See item description for shipping information</td>
         </tr>
        </table>
       </td>
      </tr>
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr>
	  

	<!--- Display Minimum & Maximum bids according to mode settings --->
	<cfset str_minimum_bid = "Minimum Bid:">
	<cfset str_maximum_bid = "Maximum Bid:">
	<cfset str_min_description = "The minimum price at which you, the seller, are willing to start the bidding in a regular auction.">
	<cfset str_max_description = "The maximum price you, the buyer, are willing to pay in a <img src = ""../images/r_reverse.gif"" name=flag width=22 height=17 border=0>reverse auction.">

	<cfset str_input_min = "<input name=""minimum_bid"" type=""text"" size=7 maxlength=9 value=""#minimum_bid#"" onFocus=""<cfif #low_est# gt 0>calc_minimum_bid()<cfelse>chk_minmax('min')</cfif>"">">
	<cfset str_input_max = "<input name=""maximum_bid"" type=""text"" size=7 maxlength=9 value=""#maximum_bid#"" onFocus=""chk_minmax('max')"">">

	<cfset str_min_layout = "<tr>" & 
	  "  <td><input type=""checkbox"" name=""defaultlist"" value=""minimum_bid""></td> " &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_minimum_bid# </b></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_min#" &
		"    &nbsp;&nbsp;  #str_min_description# </td>" &
		"</tr>">

	<cfset str_max_layout = "<tr>" &
	"  <td><input type=""checkbox"" name=""defaultlist"" value=""maximum_bid""></td> " &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_maximum_bid# </b></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_max#" &
		"    &nbsp;&nbsp;  #str_max_description# </td>" &
		"</tr>">
		<cfif auction_mode is 0>
			<!--- #str_min_layout# --->
			<tr valign="top" >
			 	<td valign="top"><input type="checkbox" name="defaultlist" value="minimum_bid" <cfif ListFindNoCase(session.defaultlist,"minimum_bid")> checked </cfif>></td>
       			<td><font size=3 color="0000ff"><b>Minimum Bid:</b></td>
       			<td>&nbsp;</td>
       			<td colspan=2><input name="minimum_bid" type="text" size=7 maxlength=9 value="#minimum_bid#"></td>
      		</tr>
			<input type="Hidden" name="maximum_bid" value="0">
		<cfelse>
			<!--- #str_max_layout# --->
			<tr valign="top" >
			 	<td valign="top"><input type="checkbox" name="defaultlist" value="maximum_bid" <cfif ListFindNoCase(session.defaultlist,"maximum_bid")> checked </cfif>></td>
       			<td><font size=3 color="0000ff"><b>Maximum Bid:</b></td>
       			<td>&nbsp;</td>
       			<td colspan=2><input name="maximum_bid" type="text" size=7 maxlength=9 value="#maximum_bid#"></td>
      		</tr>
			<input type="Hidden" name="minimum_bid" value="0">
		</cfif>


    <tr valign="top"  bgcolor="##D9D9D9">
		  <td valign="top"><input type="checkbox" name="defaultlist" value="reserve_bid" <cfif ListFindNoCase(session.defaultlist,"reserve_bid")> checked </cfif>></td>
      <td><b>Reserve Bid:</b></td>
      <td><b>&nbsp;</b></td>
      <td><input name="reserve_bid" type="text" size=7 maxlength=9 value="#reserve_bid#" onFocus="reverseItem()"> &nbsp; &nbsp;<b>(For single-quantity items only that are not reverse or buyer's auctions)</b></td>
    </tr>
	
	<tr>
		<td valign="top"><input type="checkbox" name="defaultlist" value="buynow" <cfif ListFindNoCase(session.defaultlist,"buynow")> checked </cfif>></td>
       <td><b>Buy Now:</b></td>
       <td>&nbsp;</td>
       <td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input type="text" name="buynow_price" size="7" value="#buynow_price#"></td><!--- <td align="left"><input type="checkbox" name="buynow" value="1"<cfif #buynow# is "1"> checked</cfif>>&nbsp;<b>Enabled</b></td><td>&nbsp;</td> ---></tr></table></td> 
    </tr>
	<tr>
		<td colspan="3">&nbsp;</td>
		<td>&nbsp;&nbsp;(Buy now function allow users buy at the setting price without bidding process.)</td>
	</tr>
    <tr valign="top" >
		  <td valign="top"><input type="checkbox" name="defaultlist" value="increment_valu" <cfif ListFindNoCase(session.defaultlist,"increment_valu")> checked </cfif>></td>
      <td><b>Bid Increment:</b></td>
      <td><b>&nbsp;</b></td>
      <td>
        <table border=0 cellspacing=0 cellpadding=0>
          <tr valign="top" >
            <td>
              <select name="increment_valu" size=1 onFocus="singleItem()">
              <cfloop index="i" from="1" to="#ArrayLen(hBidIncrements.aIncrements)#">
              <option value="#hBidIncrements.aIncrements[i]#"<cfif increment_valu IS hBidIncrements.aIncrements[i]> selected</cfif>>#DecimalFormat(hBidIncrements.aIncrements[i])#</option>
              </cfloop>
              </select>
            </td>
            <td>&nbsp;</td>
            <td><!--- <input type="hidden" name="increment" value="1"<cfif #increment# is "1"> checked</cfif>>&nbsp;&nbsp;&nbsp;&nbsp;<b>(Increment is ignored if selling more than one item.)</b></font> ---></td>
          </tr>
        </table>
       </td> 
      </tr>
      <!---<tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="dynamic_valu" <cfif ListFindNoCase(session.defaultlist,"dynamic_valu")> checked </cfif>></td>
       <td><b>Dynamic Bid<br>Time (minutes):</b></td>
       <td>&nbsp;</td>
       <td valign=top>
	   		<table border=0 cellspacing=0 cellpadding=0>
	   			<tr valign="top" >
					<td><select name="dynamic_valu" size=1><cfloop query="get_dynamic"><option value="#pair#"<cfif #dynamic_valu# is #pair#> selected</cfif>>#Int(pair)#</option></cfloop></select></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"<cfif #dynamic# is "1"> checked</cfif>>&nbsp;Enabled</td>
				</tr>
			</table>
		</td> 
      </tr> --->
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr>

      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="featured" <cfif ListFindNoCase(session.defaultlist,"featured")> checked </cfif>><br>
			 <input type="checkbox" name="defaultlist" value="featured_cat" <cfif ListFindNoCase(session.defaultlist,"featured_cat")> checked </cfif>><br>
			 <!--- <input type="checkbox" name="defaultlist" value="featured_studio" <cfif ListFindNoCase(session.defaultlist,"featured_studio")> checked </cfif>> --->
			 </td>
       <td valign=top><b>Other Settings:</b></td>
       <td>&nbsp;</td>
       
       <td colspan=2><input type="checkbox" name="featured" value="1"<cfif #featured# is "1"> checked</cfif>>&nbsp;Feature this item on the front page<cfif #get_fee_featured.pair# GT 0> <font size=2>(a #DecimalFormat(get_fee_featured.pair)# #Trim(getCurrency.type)# fee)</font></cfif></font>
	<br><input type="checkbox" name="featured_cat" value="1"<cfif #featured_cat# is "1"> checked</cfif>>&nbsp;Feature this item in its category(s)<cfif #get_fee_feat_cat.pair# GT 0> <font size=2>(a #DecimalFormat(REReplace(get_fee_feat_cat.pair, "[^0-9.]", "", "ALL"))# #Trim(getCurrency.type)# fee)</font></cfif></font>
	<!--- <br><input type="checkbox" name="featured_studio" value="1"<cfif #featured_studio# is "1">checked</cfif> onClick="doThis()">&nbsp;Feature this item in Studio.<cfif #get_fee_feat_studio.pair# GT 0> <font size=2>(a #DecimalFormat(REReplace(get_fee_feat_studio.pair, "[^0-9.]", "", "ALL"))# #Trim(getCurrency.type)# fee)</font></cfif></td> --->
      </tr>


      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="auto_relist" <cfif ListFindNoCase(session.defaultlist,"auto_relist")> checked </cfif>></td>
       <td><B>Auto Relist</B></td>
       <td>&nbsp;</td>
	   <TD><INPUT TYPE="Text" NAME="auto_relist" VALUE="#auto_relist#" SIZE="2" MAXLENGTH="1"> &nbsp;&nbsp;The number of times an item will automatically relist if it does not sell.</TD>
      </tr>


      <tr valign="top" >
			<td valign="top"><input type="checkbox" name="defaultlist" value="private" <cfif ListFindNoCase(session.defaultlist,"private")> checked </cfif>></td>
	  <td><B>Private Auction</B></td>
       <td>&nbsp;</td>
       <td colspan=2>
	   <input type="checkbox" name="private" value="1" <cfif #private# is "1"> checked</cfif>>&nbsp;Auction is private (hide E-Mail addresses)</font>

	   <!--- <input type="hidden" name="private" value="0"> ---></td> 
      <!--- </tr>
			<tr valign="top" >
				<td valign="top"><input type="checkbox" name="defaultlist" value="orig_cost" <cfif ListFindNoCase(defaultlist,"orig_cost")> checked </cfif>></td>
	  		<td><B>Original Cost</B></td>
        <td>&nbsp;</td>
        <td colspan=2><input type="text" name="orig_cost" value="#orig_cost#" size="20" maxlength="20">
	   &nbsp;</td> 
      </tr> --->
	  
	  		<!--- not use for regular software,phillip 12-29-00 --->
			<!--- <tr valign="top" >
				<td valign="top"><input type="checkbox" name="defaultlist" value="wh_location" <cfif ListFindNoCase(defaultlist,"wh_location")> checked </cfif>></td>
	  		<td><B>Warehouse Location</B></td>
        <td>&nbsp;</td>
        <td colspan=2><input type="text" name="wh_location" value="#wh_location#" size="20" maxlength="20">
	   &nbsp;</td> 
      </tr>
			<tr valign="top" >
				<td valign="top"><input type="checkbox" name="defaultlist" value="consignor" <cfif ListFindNoCase(defaultlist,"consignor")> checked </cfif>></td>
	  		<td><B>Consignor</B></font</td>
        <td>&nbsp;</td>
        <td colspan=2><input type="text" name="consignor" value="#consignor#" size="20" maxlength="20">
	   &nbsp;</td> 
      </tr> --->
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      <tr valign="top" >
       <td colspan=4><input type="submit" id="submit" name="submit" value="Set bulk load defaults" width=75>&nbsp;&nbsp;&nbsp;<input type="reset" id="submit" value="Clear" width=75></td>
      </tr> 
     </table>
    </td>
   </tr>
      </form>
    <tr valign="top" ><td><br><br><img src=#varoot#/images/spacer.gif height=8 width=2></td></tr>
    <tr valign="top" ><td align="left"><cfinclude template="../../includes/copyrights.cfm"></td></tr>
    </form>
   </table>
   </center>
   <br>
  </cfoutput>
 </body>
</html>



</body>
</html>



