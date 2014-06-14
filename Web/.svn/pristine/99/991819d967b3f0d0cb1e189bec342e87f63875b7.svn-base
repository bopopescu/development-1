<!--- page to be included to set defaults for bulkload module
07/11/00 --->
<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>

<cfquery name="get_location" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">
select shipping_state,shipping_country from users 
where user_id = #cookie.user_id#
</cfquery>
<!--- Set defaults --->

  <cfparam name = "user_id" default = "">
  <cfparam name = "category1" default = "">
  <cfparam name = "category2" default = "">
  <cfparam name = "title" default = "">
  <cfparam name = "location" default = "#get_location.shipping_state#">
  <cfparam name = "state" default = "#get_location.shipping_state#">
  <cfparam name = "country" default = "#get_location.shipping_country#">
  <cfparam name = "description" default = "">
  <cfparam name = "high_est" default = "0">
  <cfparam name = "low_est" default = "0">
  <cfparam name = "condition" default = "">
  <cfparam name = "desc_languages" default = "en">
  <cfparam name = "picture_file" default = "http://">
  <cfparam name = "picture" default = "http://">
  <cfparam name = "sound" default = "http://">
  <cfparam name = "picture_studio" default = "http://">
  <cfparam name = "picture1" default = "">
  <cfparam name = "picture2" default = "">
  <cfparam name = "picture3" default = "">
  <cfparam name = "picture4" default = "">
  <cfparam name = "thumb" default = "">
  <cfparam name = "sound_studio" default = "http://">
  <cfparam name = "quantity" default = "1">
  <cfparam name = "minimum_bid" default = "0">
  <cfparam name = "maximum_bid" default = "0">
  <cfparam name = "increment_valu" default = "#hBidIncrements.fDefIncrement#">
  <cfparam name = "dynamic_valu" default = "0">
  <cfparam name = "reserve_bid" default = "0">
  <cfparam name = "banner_line" default = "">
  <cfparam name = "date_start" default = "#timenow#">
  <cfparam name = "date_end" default = "#Timenow#">
  <cfparam name = "pay_morder_ccheck" default = 0>
  <cfparam name = "pay_cod" default = 0>
  <cfparam name = "pay_see_desc" default = 0>
  <cfparam name = "pay_pcheck" default = 0>
  <cfparam name = "pay_ol_escrow" default = 0>
  <cfparam name = "pay_other" default = 0>
  <cfparam name = "pay_visa_mc" default = 0>
  <cfparam name = "pay_am_express" default = 0>
  <cfparam name = "pay_discover" default = 0>
  <cfparam name = "ship_sell_pays" default = 0>
  <cfparam name = "ship_buy_pays_act" default = 0>
  <cfparam name = "ship_see_desc" default = 0>
  <cfparam name = "ship_buy_pays_fxd" default = 0>
  <cfparam name = "ship_international" default = 0>
  <cfparam name = "increment" default = 0>
  <cfparam name = "dynamic" default = 0>
  <cfparam name = "bold_title" default = 0>
  <cfparam name = "featured" default = 0>
  <cfparam name = "featured_cat" default = 0>
  <cfparam name = "private" default = 0>
  <cfparam name = "banner" default = 0>
  <cfparam name = "studio" default = 0>
  <cfparam name = "featured_studio" default = 0> 
  <cfparam name = "auction_type" default = "E"> 
  <cfparam name = "auto_relist" default = "0">
	<!--- <cfparam name = "orig_cost" default = "0"> --->
	<cfparam name = "consignor" default = "">
	<cfparam name = "wh_location" default = "">
	<cfparam name = "buynow_price" default = 0>
	<!--- <cfparam name = "buynow" default = 0> --->
	
