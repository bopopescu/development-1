<!--
  gen_seller_results.cfm
  
  setup information about auction to email to the seller...
  uses eml_seller_results.cfm to send info..
  
  <!---

  <cfmodule template="gen_seller_results.cfm"
    adnum="[ad number]"
    datasource="[system dsn]"
    db_username="[username]"
    db_password="[password]"
    timenow="[timenow]"
    fromEmail="[from email address]">

  --->

-->

<!-- define values -->
<cfset itemsSold = 0>
<cfset qualBid = 0>
<cfset numBidders = 0>

<!-- inc app_globals -->
<cfinclude template="../../includes/app_globals.cfm">

<!-- get item information -->
<cfquery name="getInfo" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT A.title, A.date_start, A.date_end, A.user_id, A.ask_price, A.ad_dur, U.email
      FROM ad_info A, users U
     WHERE adnum = #Attributes.adnum#
       AND A.user_id = U.user_id
</cfquery>

<cfquery name="getOffer" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT MAX(offer) as topoffer
      FROM ad_offers
     WHERE adnum = #Attributes.adnum#
</cfquery>

<!-- get currency type -->
<cfquery name="getCurrency" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT pair AS type
      FROM defaults
     WHERE name = 'site_currency'
</cfquery>

<!-- setup message -->
<cfset message = "">
<cfset nl = Chr(13) & Chr(10)>

<cfset message = message & "Your ad placed with #SITE_ADDRESS# has run for the prescribed #getInfo.ad_dur# days." & nl>
<cfset message = message & 'Please click here if you would like to<a href=http://#SITE_ADDRESS##VAROOT#/classified/place_ad.cfm>relist.</a>' & nl>
<cfset message = message & "Ad Number: " & Attributes.adnum & nl>
<cfset message = message & "Ad Title: " & Trim(getInfo.title) & nl>
<cfset message = message & "Date Started: " & DateFormat(getInfo.date_start, "d-mmm-yy") & " " & TimeFormat(getInfo.date_start, "HH:mm:ss") & nl>
<cfset message = message & "Date Ended: " & DateFormat(getInfo.date_end, "d-mmm-yy") & " " & TimeFormat(getInfo.date_start, "HH:mm:ss") & nl>

<cfset message = message & "Asking Price: " & numberFormat(getInfo.ask_price,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
  
<cfset message = message & "Please contact these winners as soon as possible." & nl & nl>

<!-- send email -->
<cfmodule template="eml_seller_results.cfm"
  to="#Trim(getInfo.email)#"
  from="#Attributes.fromEmail#"
  subject="Ad Run Completion: (Ad ###Attributes.adnum#) #Trim(getInfo.title)#"
  message="#Variables.message#">

<!--- log seller notified --->
<cfmodule template="../../functions/addTransaction.cfm"
  datasource="#Attributes.DATASOURCE#"
  db_username="#Attributes.db_username#"
  db_password="#Attributes.db_password#"
  description="Auction Results emailed to Seller"
  itemnum="#Attributes.adnum#"
  details="#Variables.message#"
  user_id="#getInfo.user_id#">

