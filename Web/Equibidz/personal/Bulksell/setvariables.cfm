<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>
<!--- If session variable is defined from index2.cfm, sets as local variable --->
<cfif isDefined('form.submit_item')>
<cfset defaultlist = session.defaultlist>
  <CFELSE>
<cfset defaultlist = session.defaultlist>
<cfset auction_mode= session.auction_mode>
<cfif ListFindNoCase(session.defaultlist,"category1")>
	<cfset category1 = session.category1>
	<cfset category2 = session.category2>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"title")>
	<cfset title = session.title>
	<cfset bold_title = session.bold_title>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"location")>
	<cfset location = session.location>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"state")>
	<cfset state = session.state>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"country")>
	<cfset country = session.country>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"description")>
	<cfset description = session.description>
</cfif>
<!--- <cfif ListFindNoCase(session.defaultlist,"high_est")>
	<cfset high_est = session.high_est>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"low_est")>
	<cfset low_est = session.low_est>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"condition")>
	<cfset condition = session.condition>
</cfif> --->
<cfif ListFindNoCase(session.defaultlist,"desc_languages")>
	<cfset desc_languages = session.desc_languages>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"picture_file")>
	<cfset picture_file = session.picture_file>
	<cfset picture_studio = session.picture_studio>
	<cfset picture = session.picture>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"sound")>
	<cfset sound = session.sound>
	<cfset sound_studio = session.sound_studio>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"picture1")>
	<cfset picture1 = session.picture1>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"picture2")>
	<cfset picture2 = session.picture2>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"picture3")>
	<cfset picture3 = session.picture3>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"picture4")>
	<cfset picture4 = session.picture4>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"thumb")>
	<cfset thumb = session.thumb>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"quantity")>
	<cfset quantity = session.quantity>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"minimum_bid")>
	<cfset minimum_bid = session.minimum_bid>
	<cfset maximum_bid = session.maximum_bid>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"maximum_bid")>
	<cfset maximum_bid = session.maximum_bid>
	<cfset minimum_bid = session.minimum_bid>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"buynow")>
	<cfset buynow_price = session.buynow_price>
	<cfset buynow = session.buynow>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"increment_valu")>
	<cfset increment_valu = session.increment_valu>
	<cfset increment = session.increment>
</cfif>

<cfif ListFindNoCase(session.defaultlist,"dynamic_valu")>
	<cfset dynamic_valu = session.dynamic_valu>
	<cfset dynamic = session.dynamic>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"reserve_bid")>
	<cfset reserve_bid = session.reserve_bid>
</cfif>

<cfif ListFindNoCase(session.defaultlist,"date_start")>
	<cfset start_time = session.start_time>
	<cfset start_time_s = session.start_time_S>
	<cfset date_start = session.date_start>
	<cfset start_year = session.start_year>
	<cfset start_month = session.start_month>
	<cfset start_day = session.start_day>
	<cfset start_min = session.start_min>
	<cfset start_hour = session.start_hour>
</cfif>

<!--- <cfif ListFindNoCase(session.defaultlist,"date_end")>
	<cfset end_time = session.end_time>
	<cfset end_time_s = session.end_time_S>
	<cfset date_end = session.date_end>
	<cfset end_year = session.end_year>
	<cfset end_month = session.end_month>
	<cfset end_day = session.end_day>
	<cfset end_min = session.end_min>
	<cfset end_hour = session.end_hour>
</cfif> --->






<cfif ListFindNoCase(session.defaultlist,"duration")>

	<cfset date_end = session.date_end>
</cfif>

<cfif ListFindNoCase(session.defaultlist,"paymethod")>
	<cfset pay_morder_ccheck = session.pay_morder_ccheck>
	<cfset pay_cod = session.pay_cod>
	<cfset pay_see_desc = session.pay_see_desc>
	<cfset pay_pcheck = session.pay_pcheck>
	<cfset pay_ol_escrow = session.pay_ol_escrow>
	<cfset pay_other = session.pay_other>
	<cfset pay_visa_mc = session.pay_visa_mc>
	<cfset pay_am_express = session.pay_am_express>
	<cfset pay_discover = session.pay_discover>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"shipping")>
	<cfset ship_sell_pays = session.ship_sell_pays>
	<cfset ship_buy_pays_act = session.ship_buy_pays_act>
	<cfset ship_see_desc = session.ship_see_desc>
	<cfset ship_buy_pays_fxd = session.ship_buy_pays_fxd>
	<cfset ship_international = session.ship_international>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"featured")>
	<cfset featured = session.featured>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"featured_cat")>
	<cfset featured_cat = session.featured_cat>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"private")>
	<cfset private = session.private>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"banner")>
	<cfset banner = session.banner>
	<cfset banner_line = session.banner_line>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"studio")>
	<cfset studio = session.studio>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"featured_studio")>
	<cfset featured_studio = session.featured_studio>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"auction_type")>
	<cfset auction_type = session.auction_type>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"auto_relist")>
	<cfset auto_relist = session.auto_relist>
</cfif>
<!--- <cfif ListFindNoCase(session.defaultlist,"orig_cost")>
	<cfset orig_cost = session.orig_cost>
</cfif> --->
<!--- <cfif ListFindNoCase(session.defaultlist,"wh_location")>
	<cfset wh_location = session.wh_location>
</cfif>
<cfif ListFindNoCase(session.defaultlist,"consignor")>
	<cfset consignor = session.consignor>
</cfif> --->
	<cfset #studio# = #session.studio#>
  <cfset #picture_studio# = #session.picture_studio#>
  <cfset #sound_studio# = #session.sound_studio#>
  <cfset #billmeth# = "BM">
  <cfset #remote_ip# = #cgi.remote_addr#>


  </CFIF>
<!--- Display variables for test<cfinclude template="testbulksell.cfm"> --->


