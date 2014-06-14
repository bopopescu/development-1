<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>
<cfif isdefined("form.defaultlist") is 0>
	<cfset #error_message# = "Please check at least one default check box and its content.">
	<cflocation url="index2.cfm?error_message=#error_message#">
	
</cfif>
<!--- Check that default fields are valid --->
<cfif ListFindNoCase(form.defaultlist,"title")>
	<cfif #trim (title)# is "">
      <cfset #error_message# = error_message & "<font color=ff0000>Please specify a title for this item.</font> ">
	</cfif>
</cfif>
<!--- <cfif ListFindNoCase(form.defaultlist,"orig_cost")>
	<cfif isnumeric(orig_cost) is 0>
      <cfset #error_message# = error_message & "<font color=ff0000>Original cost must be a number.</font> ">
	</cfif>
</cfif> --->
<cfif ListFindNoCase(form.defaultlist,"quantity")>
   <cfif (#trim (quantity)# is "") or (#isNumeric (quantity)# is 0) or (#quantity# is 0)>
     <cfset #error_message# = error_message & "<font color=ff0000>Please enter a valid quantity for this item.</font> "> 
		</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"description")>	
   <cfif #trim (description)# is "">
     <cfset #error_message# = error_message & "<font color=ff0000>Please enter a description of this item.</font> "> 
	</cfif>
</cfif>

<!--- <cfif ListFindNoCase(form.defaultlist,"condition")>	
   <cfif #trim (condition)# is "">
     <cfset #error_message# = error_message & "<font color=ff0000>Please enter a condition of this item.</font> "> 
	</cfif>
</cfif> --->
	
<cfif ListFindNoCase(form.defaultlist,"desc_languages")>	
   <cfif isDefined ("desc_languages") is "0">
      <cfset #error_message# = error_message & "<font color=ff0000>Please specify the language(s) the description is in.</font> "> 
	</cfif>
</cfif>
	
<cfif ListFindNoCase(form.defaultlist,"location")>
  <cfif #trim (location)# is "">
     <cfset #error_message# = error_message & "<font color=ff0000>Please enter a location where this item will be shipped from.</font> "> 
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"country")>
  <cfif #trim (country)# is "">
     <cfset #error_message# = error_message & "<font color=ff0000>Please select a state where this item will be shipped from.</font> "> 
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"date_end")>
  <cfif #trim (end_day)# is "" OR #trim (end_month)# is "">
     <cfset #error_message# = error_message & "<font color=ff0000>Please enter month and date when this item will be end.</font> "> 
	</cfif>
</cfif>
	
<cfif ListFindNoCase(form.defaultlist,"category1")>
  <cfif (#category1# is "-1") and (#category2# is "-1")>
    <cfset #error_message# = error_message & "<font color=ff0000>Please specify at least 1 auction category for this item.</font> ">
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"minimum_bid")>
  <cfif auction_mode is 0 and ((#trim (minimum_bid)# is "") or (#minimum_bid# is "0") or (#isNumeric (minimum_bid)# is "0"))>
      <cfset #error_message# = error_message & "<font color=ff0000>Please specify a minimum bid value for this item.</font> ">
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"maximum_bid")>
	<cfif form.auction_mode is 1 and ((#trim (maximum_bid)# is "") or (#maximum_bid# is "0") or (#isNumeric (maximum_bid)# is "0"))>
      <cfset #error_message# = error_message & "<font color=ff0000>Please specify a maximum bid value for this item.</font> ">
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"reserve_bid")>
	<cfif form.auction_mode is 0 and (#auction_type# is "D" or #auction_type# is "Y") and #trim (reserve_bid)# gt 0>
      <cfset #error_message# = "<font color=ff0000>Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.</font>">
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"buynow")>
	<cfif form.buynow_price gt 0>
      <cfset buynow = 1>
  	<cfelse>
	    <cfset buynow = 0>
  	</cfif>
	
	<cfif buynow eq 1 and (not isNumeric(form.buynow_price) or #form.buynow_price# lt #minimum_bid#)>
		<cfset #error_message# = "<font color=ff0000>Please double check the buy now price for this item.  It must greater than minimum bid.</font>">
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"quantity") AND ListFindNoCase(form.defaultlist,"auction_type")>
  <cfif (#quantity# GT 1) and (#auction_type# is "E" or #auction_type# is "V")>
      <cfset #error_message# = error_message & "<font color=ff0000>This type of auction only allows 1 unit of an item to be sold.</font> "> 
  <cfelseif (#quantity# IS 1) and (#auction_type# is "D" or #auction_type# is "Y")>
      <cfset #error_message# = error_message & "<font color=ff0000>This type of auction does not allow 1 unit of an item to be sold.</font> "> 
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"paymethod")>
  <cfif #pay_morder_ccheck# is 0 and
              #pay_cod# is 0 and
              #pay_see_desc# is 0 and
              #pay_pcheck# is 0 and
              #pay_ol_escrow# is 0 and
              #pay_other# is 0 and
              #pay_visa_mc# is 0 and
              #pay_am_express# is 0 and
              #pay_discover# is 0>
      <cfset #error_message# = error_message & "<font color=ff0000>You must specify at least one accepted payment method.</font> ">
	</cfif>
</cfif>

<cfif ListFindNoCase(form.defaultlist,"shipping")>
  <cfif #ship_sell_pays# is 0 and
              #ship_buy_pays_act# is 0 and
              #ship_see_desc# is 0 and
              #ship_buy_pays_fxd# is 0 and
              #ship_international# is 0>
      <cfset #error_message# = error_message & "<font color=ff0000>You must specify at least one shipping arrangement.</font> ">
	</cfif>
</cfif>

<!--- <cfif ListFindNoCase(form.defaultlist,"consignor")>
	<cfif #trim (consignor)# is "">
      <cfset #error_message# = error_message & "<font color=ff0000>Please enter consignor.</font> ">
	</cfif>
</cfif> --->
 

    
    

    
    
