<!--
  def_bill.cfm

  defines what the user owes on an item..
  returns 2D array of charge name & amount & field name..
<!---
  <cfmodule template="def_bill.cfm"
    itemnum=""
    datasource="">
--->
  revised to charge sellers for all features, all items listed.

-->


<cfif isdefined("db_password") is not true>
	<cfinclude template="../../includes/app_globals.cfm">
</cfif>

<!-- define values bill:newarray(2),  element -->
<cfset bill = ArrayNew(2)>
<cfset element = 1>

<!-- define fee type default as 0 -->
<cfparam name="feetype" default="0">

<!-- get item/seller info -->
<cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
    SELECT I.category1, I.category2, I.org_quantity as quantity, I.minimum_bid, I.reserve_bid, I.bold_title, I.featured, I.featured_cat, I.banner, <!---I.inspector,---> I.studio, I.featured_studio, I.picture1, I.picture2, I.picture3, I.picture4, I.auction_type, I.auction_mode
      FROM items I
     WHERE I.itemnum = #Attributes.itemnum#
</cfquery>

<!-- get bids on item -->
<cfquery username="#db_username#" password="#db_password#" name="getBid" datasource="#Attributes.datasource#">
    SELECT bid, quantity
      FROM bids
     WHERE itemnum = #Attributes.itemnum#
     ORDER BY bid DESC, time_placed ASC
</cfquery>

<!--- Run queries to find cat_fee enable --->
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_cat_fee" datasource="#Attributes.DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_cat_fee'
  </cfquery>
  <cfset #enable_cat_fee# = #get_enable_cat_fee.pair#>

<!-- get fee info -->
<cfquery username="#db_username#" password="#db_password#" name="getFees" datasource="#Attributes.datasource#">
    SELECT *
      FROM defaults
     WHERE name LIKE 'fee_%'
</cfquery>

<!-- set default fee values -->
<cfset fee_banner = 0>
<cfset fee_bold = 0>
<cfset fee_feat_cat = 0>
<cfset fee_feat_studio = 0>
<cfset fee_featured = 0>
<cfset fee_late_charge = 0>
<cfset fee_listing = 0>
<cfset fee_second_cat = 0>
<cfset fee_studio = 0>
<cfset fee_picture1 = 0>
<cfset fee_picture2 = 0>
<cfset fee_picture3 = 0>
<cfset fee_picture4 = 0>
<cfset fee_reserve_bid = 0>
<!--- <cfset fee_inspector = 0> --->

<!-- set fee values from db -->
<cfloop query="getFees">
  <cfif Trim(name) IS "fee_banner">      <cfset fee_banner = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>      </cfif>
  <cfif Trim(name) IS "fee_bold">        <cfset fee_bold = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>        </cfif>
  <cfif Trim(name) IS "fee_feat_cat">    <cfset fee_feat_cat = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>    </cfif>
  <cfif Trim(name) IS "fee_feat_studio"> <cfset fee_feat_studio = REReplace(getFees.pair, "[^0-9.]", "", "ALL")> </cfif>
  <cfif Trim(name) IS "fee_featured">    <cfset fee_featured = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>    </cfif>
  <cfif Trim(name) IS "fee_late_charge"> <cfset fee_late_charge = REReplace(getFees.pair, "[^0-9.]", "", "ALL")> </cfif>
  <cfif Trim(name) IS "fee_listing">     <cfset fee_listing = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>     </cfif>
  <cfif Trim(name) IS "fee_second_cat">  <cfset fee_second_cat = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>  </cfif>
  <cfif Trim(name) IS "fee_studio">      <cfset fee_studio = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>      </cfif>
  <cfif Trim(name) IS "fee_picture1">    <cfset fee_picture1 = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>    </cfif>
<cfif Trim(name) IS "fee_picture2">    <cfset fee_picture2 = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>    </cfif>
<cfif Trim(name) IS "fee_picture3">    <cfset fee_picture3 = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>    </cfif>
<cfif Trim(name) IS "fee_picture4">    <cfset fee_picture4 = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>    </cfif>
  <cfif Trim(name) IS "fee_reserve_bid"> <cfset fee_reserve_bid = REReplace(getFees.pair, "[^0-9.]", "", "ALL")> </cfif>
  <!--- <cfif Trim(name) IS "fee_inspector">   <cfset fee_inspector = REReplace(getFees.pair, "[^0-9.]", "", "ALL")>   </cfif> --->
</cfloop>

<cfif enable_cat_fee eq 1>
<!-- get category1 fee info -->
<cfquery username="#db_username#" password="#db_password#" name="get_categoryfee1" datasource="#Attributes.datasource#">
    SELECT fee_listing
      FROM categories
     WHERE category = #getInfo.category1#
</cfquery>
<cfset fee_listing = get_categoryfee1.fee_listing>

<!-- get category2 fee info -->
<cfquery username="#db_username#" password="#db_password#" name="get_categoryfee2" datasource="#Attributes.datasource#">
    SELECT fee_listing
      FROM categories
     WHERE category = #getInfo.category2#
</cfquery>
<cfset fee_second_cat = get_categoryfee2.fee_listing>
</cfif>


<!-- add listing fee to bill -->
<cfset bill[element][1] = "Listing Fee">
<cfset bill[element][2] = Variables.fee_listing>
<cfset bill[element][3] = "listing">
<cfset element = IncrementValue(element)>

<!-- if bids & reserve met, add other fees -->
<cfif getBid.RecordCount> <!--- IS NOT 0 --->

  <cfif getInfo.auction_type IS "E">
    <!-- getInfo.auction_type IS "E" -->
    <cfset itemsSold = 1>
    <cfset qualBid = getBid.bid>

  <cfelseif getInfo.auction_type IS "V">
    <!-- getInfo.auction_type IS "V" -->
    <cfset itemsSold = 1>
    <cfif getBid.RecordCount LT 2>
      <cfset qualBid = getInfo.minimum_bid>
    <cfelse>
      <cfloop query="getBid" endrow="2">
        <cfset qualBid = getBid.bid>
      </cfloop>
    </cfif>

  <cfelseif getInfo.auction_type IS "D">
    <!-- getInfo.auction_type IS "D" -->
    <cfset itemsSold = 0>
    <cfloop query="getBid">
      <cfset itemsSold = itemsSold + getBid.quantity>
      <cfif itemsSold GTE getInfo.quantity>
        <cfset qualBid = getBid.bid>
        <cfbreak>
      </cfif>
    </cfloop>
    <cfif itemsSold LT getInfo.quantity>
      <cfset qualBid = getInfo.minimum_bid>
    </cfif>

  <cfelseif getInfo.auction_type IS "Y">
    <!-- getInfo.auction_type IS "V" -->
    <cfset itemsSold = 0>
    <cfloop query="getBid">
      <cfset itemsSold = itemsSold + getBid.quantity>
      <cfif itemsSold GTE getInfo.quantity OR getBid.CurrentRow IS getBid.RecordCount>
        <cfset qualBid = getBid.bid>
        <cfbreak>
      </cfif>
    </cfloop>
  </cfif>


  <cfif itemsSold GT getInfo.quantity>
    <!-- set itemsSold to quantity actually available, if we are selling more than are available. -->
    <cfset itemsSold = getInfo.quantity>
  </cfif>

  <!-- if E or V & reserve met, or D or Y -->
  <cfif getInfo.auction_type IS "E" AND qualBid GTE getInfo.reserve_bid
    OR getInfo.auction_type IS "V" AND qualBid GTE getInfo.reserve_bid
    OR getInfo.auction_type IS "D"
    OR getInfo.auction_type IS "Y">

    <!-- get fee scale -->
    <cfquery username="#db_username#" password="#db_password#" name="getScale" datasource="#Attributes.datasource#">
        SELECT pair AS fee
          FROM defaults
         WHERE name = 'scale_segment'
         ORDER BY pair ASC
    </cfquery>

    <!-- get currency type -->
    <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.DATASOURCE#">
        SELECT pair AS type
          FROM defaults
         WHERE name = 'site_currency'
    </cfquery>

    <!-- determine fee -->
    <cfloop query="getScale">
      <cfif qualBid GTE Int(ListGetAt(getScale.fee, 1, ","))>
        <cfset feeType = ListGetAt(getScale.fee, 2, ",")>
        <cfset feeValue = ListGetAt(getScale.fee, 3, ",")>
      <cfelse>
        <cfbreak>
      </cfif>
    </cfloop>

    <cfif feeType IS "P">
      <cfset bill[element][1] = "Auction Fee (" & <!---itemsSold---> 1 & " x " & numberFormat(qualBid,numbermask) & " " & Trim(getCurrency.type) & " x " & Evaluate(feeValue * 100) & "%)">
      <cfset bill[element][2] = <!---itemsSold---> 1 * qualBid * feeValue>
      <cfset bill[element][3] = "fee">
      <cfset element = IncrementValue(element)>
    <cfelseif feeType IS "F">
      <cfset bill[element][1] = "Auction Fee (" & itemsSold & " x " & numberFormat(feeValue,numbermask) & Trim(getCurrency.type) & ")">
      <cfset bill[element][2] = itemsSold * feeValue>
      <cfset bill[element][3] = "fee">
      <cfset element = IncrementValue(element)>
    </cfif>
  </cfif> <!-- if E or V & reserve met, or D or Y -->
</cfif> <!---Non-zero # of bids--->

<cfif getInfo.bold_title>
  <cfset bill[element][1] = "Bold Listing">
  <cfset bill[element][2] = Variables.fee_bold>
  <cfset bill[element][3] = "bold">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.featured>
  <cfset bill[element][1] = "Featured Listing">
  <cfset bill[element][2] = Variables.fee_featured>
  <cfset bill[element][3] = "featured">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.featured_cat>
  <cfset bill[element][1] = "Featured Category Listing">
  <cfset bill[element][2] = Variables.fee_feat_cat>
  <cfset bill[element][3] = "featured_cat">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.banner>
  <cfset bill[element][1] = "Banner Listing">
  <cfset bill[element][2] = Variables.fee_banner>
  <cfset bill[element][3] = "banner">
  <cfset element = IncrementValue(element)>
</cfif>


<!---  ---><!---  --->

<!--- <cfif getInfo.inspector IS NOT "0">
  <cfset bill[element][1] = "Item Inspector">
  <cfset bill[element][2] = Variables.fee_inspector>
  <cfset bill[element][3] = "fee_inspector">
  <cfset element = IncrementValue(element)>
</cfif> --->

<cfif getInfo.studio>
  <cfset bill[element][1] = "Studio Listing">
  <cfset bill[element][2] = Variables.fee_studio>
  <cfset bill[element][3] = "studio">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.featured_studio>
  <cfset bill[element][1] = "Featured Studio Listing">
  <cfset bill[element][2] = Variables.fee_feat_studio>
  <cfset bill[element][3] = "featured_studio">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.picture1 neq "" and getInfo.picture1 neq "http://">
  <cfset bill[element][1] = "Image1 Upload">
  <cfset bill[element][2] = Variables.fee_picture1>
  <cfset bill[element][3] = "picture1">
  <cfset element = IncrementValue(element)>
</cfif>
<cfif getInfo.picture2 neq "" and getInfo.picture2 neq "http://">
  <cfset bill[element][1] = "Image2 Upload">
  <cfset bill[element][2] = Variables.fee_picture2>
  <cfset bill[element][3] = "picture2">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.picture3 neq "" and getInfo.picture3 neq "http://">
  <cfset bill[element][1] = "Image Upload">
  <cfset bill[element][2] = Variables.fee_picture3>
  <cfset bill[element][3] = "picture3">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.category2 IS NOT (0 OR -1) AND IsNumeric(getInfo.category2)>
  <cfset bill[element][1] = "2nd Category Listing">
  <cfset bill[element][2] = Variables.fee_second_cat>
  <cfset bill[element][3] = "second_cat">
  <cfset element = IncrementValue(element)>
</cfif>

<cfif getInfo.auction_mode eq 0 and getInfo.reserve_bid gt 0>
  <cfset bill[element][1] = "Reserve Bid">
  <cfset bill[element][2] = Variables.fee_reserve_bid>
  <cfset bill[element][3] = "reserve_bid">
  <cfset element = IncrementValue(element)>
</cfif>

<!-- return array to Caller -->
<cfset Caller.bill = bill>
