<cfsetting enablecfoutputonly="Yes">
<!--- 
	functions/dutch_bidding.cfm

--->

	<cfinclude template="../includes/app_globals.cfm">
 <cfinclude template="../includes/session_include.cfm">

<cfif session.auction_mode is 0>
<!-- Regular Auctions --> <!-- Reverse Auction begins on line   118 -->
<cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#datasource#">
SELECT minimum_bid, quantity, increment_valu FROM items
WHERE itemnum = #itemnum#
</cfquery>
<cfparam name="itemnum" default="0">
<cfparam name="Attributes.itemnum" default=#itemnum#>

<cfparam name="quantity" default="1">
<cfparam name="get_itemInfo.quantity" default=#quantity#>
<cfparam name="Attributes.quantity" default=#get_itemInfo.quantity#>
<cfset Attributes_quantity = Attributes.quantity>


<cfparam name="minimum_bid" default="0">
<cfparam name="get_itemInfo.minimum_bid" default=#minimum_bid#>
<cfparam name="Attributes.minimum_bid" default=#get_itemInfo.minimum_bid#>

<!--- get bids --->
<cfquery username="#db_username#" password="#db_password#" name="getBidHistory" datasource="#DATASOURCE#">
    SELECT bid, quantity
      FROM bids
     WHERE itemnum = #Attributes.itemnum#
	 AND buynow = 0
  ORDER BY bid DESC, 
           time_placed ASC
</cfquery>

<cfset items_taken = 0>
<cfset minimum_bid = Attributes.minimum_bid>

<cfloop query="getBidHistory">
	<cfset items_taken = items_taken + int(getBidHistory.quantity)>
	<cfset minimum_bid = getBidHistory.bid>

	<cfif items_taken gte Attributes.quantity>
		<cfbreak>
	</cfif>

</cfloop>

<cfif items_taken gte Attributes.quantity>
	<cfset minimumBid = minimum_bid + get_itemInfo.increment_valu>
<cfelse>
	<cfset minimumBid = Attributes.minimum_bid>
</cfif>

<cfif IsDefined("Attributes.bid")>
	<cfset errorBadBid = "">
	
	<cfset Variables.bid = (int(Attributes.bid*100))/100>  <!--- cf's hand-holding is just a bit too much for me. sorry. --->
	<cfset Variables.minimumBid = (int(minimumBid*100))/100>
	
	<cfif Variables.bid LESS THAN Variables.minimumBid>
		<cfset errorBadBid = "Your bid of #attributes.bid# must be equal to or higher than the current minimum bid of #minimumBid#.">
	
	<cfelse>
		<cfset outbid_array=ArrayNew(2)>
		<cfset session.outbid_notification = "">
		<cfset tempCount = 1>
	
		<cfquery username="#db_username#" password="#db_password#" name="getQuantity" datasource="#DATASOURCE#">
		      SELECT sum(quantity) as total
		        FROM bids
		       WHERE itemnum = #Attributes.itemnum#
			 AND bid >= #Attributes.bid#
		</cfquery>

		<cfset getQuantity_total = iif(len(getQuantity.total) GT 0, DE("#getQuantity.total#"), DE("0"))>

		<cfquery username="#db_username#" password="#db_password#" name="getAllHistory" datasource="#DATASOURCE#">
		      SELECT B.bid, B.quantity, U.email, U.outbid_email
		        FROM bids B, users U
		       WHERE B.itemnum = #Attributes.itemnum#
		         AND B.user_id = U.user_id
			 AND B.bid < #Attributes.bid#
			 AND B.bid >= #minimum_bid#
		    ORDER BY B.bid DESC, B.time_placed ASC
  		</cfquery>

		<cfparam name="Attributes.quantity_wanted" default="1">
		<cfset items_taken = int(getQuantity_total) + int(Attributes.quantity_wanted)>
		<cfset email_sent = "">
		
		<cfloop query="getAllHistory">
			<cfset last_bid = getAllHistory.bid>
			<cfset last_quantity = getAllHistory.quantity>
			<cfset last_email = getAllHistory.email>
			<cfset outbid_email_flag = getAllHistory.outbid_email>

			<cfif items_taken GTE Attributes.quantity AND email_sent NEQ last_email>
				<cfset outbid_array[tempCount][1] = last_email>
				<cfset outbid_array[tempCount][2] = last_bid>
				<cfset outbid_array[tempCount][3] = outbid_email_flag>
				
				<cfset tempCount = tempCount + 1>
			</cfif>

			<cfset items_taken = items_taken + last_quantity>
			<cfset email_sent = last_email>

		</cfloop>
				
		<cfif arrayisempty(outbid_array) is "FALSE">
			<CFWDDX action='cfml2wddx' input=#outbid_array# output='wddxText'>
			<cfset session.outbid_notification = wddxText>
		</cfif>
		
	</cfif>

	<cfset caller.errorBadBid = errorBadBid>
<cfelse>
	<cfset caller.minimumBid = minimumBid>
</cfif>

<cfelse>
<!-- Reverse Auction -->
<cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#datasource#">
SELECT maximum_bid, quantity, increment_valu FROM items
WHERE itemnum = #itemnum#
</cfquery>
<!--- 
<cfparam name="itemnum" default="0">
<cfparam name="Attributes.itemnum" default=#itemnum#> --->

<!--- <cfparam name="quantity" default="1">
<cfparam name="get_itemInfo.quantity" default=#quantity#> --->
<cfparam name="Attributes.quantity" default=#get_itemInfo.quantity#>
<cfset Attributes_quantity = Attributes.quantity>
<!--- 
<cfparam name="maximum_bid" default=#get_itemInfo.maximum_bid#>
<cfparam name="get_itemInfo.maximum_bid" default=#maximum_bid#> --->
<cfparam name="Attributes.maximum_bid" default=#get_itemInfo.maximum_bid#>

<!--- get bids --->
<cfquery username="#db_username#" password="#db_password#" name="getBidHistory" datasource="#DATASOURCE#">
    SELECT bid, quantity
      FROM bids
     WHERE itemnum = #Attributes.itemnum#
  ORDER BY bid ASC, 
           time_placed ASC
</cfquery>

<cfset items_taken = 0>
<cfset maximum_bid = Attributes.maximum_bid>

<cfloop query="getBidHistory">
	<cfset items_taken = items_taken + int(getBidHistory.quantity)>
	<cfset maximum_bid = getBidHistory.bid>

	<cfif items_taken gte Attributes.quantity>
		<cfbreak>
	</cfif>

</cfloop>

<cfif items_taken gte Attributes.quantity>
	<cfset maximumBid = maximum_bid - get_itemInfo.increment_valu>
<cfelse>
	<cfset maximumBid = Attributes.maximum_bid>
</cfif>

<cfif IsDefined("Attributes.bid")>
	<cfset errorBadBid = "">
	
	<cfset Variables.bid = (int(Attributes.bid*100))/100>  <!--- cf's hand-holding is just a bit too much for me. sorry. --->
	<cfset Variables.maximumBid = (int(maximumBid*100))/100>
	
	<cfif Variables.bid GREATER THAN  Variables.maximumBid>
		<cfset errorBadBid = "Your bid of #attributes.bid# must be equal to or lower than the current maximum bid of #maximumBid#.">
	
	<cfelse>
		<cfset outbid_array=ArrayNew(2)>
		<cfset session.outbid_notification = "">
		<cfset tempCount = 1>
	
		<cfquery username="#db_username#" password="#db_password#" name="getQuantity" datasource="#DATASOURCE#">
		      SELECT sum(quantity) as total
		        FROM bids
		       WHERE itemnum = #Attributes.itemnum#
			 AND bid <= #Attributes.bid#
		</cfquery>

		<cfset getQuantity_total = iif(len(getQuantity.total) GT 0, DE("#getQuantity.total#"), DE("0"))>

		<cfquery username="#db_username#" password="#db_password#" name="getAllHistory" datasource="#DATASOURCE#">
		      SELECT B.bid, B.quantity, U.email, U.outbid_email
		        FROM bids B, users U
		       WHERE B.itemnum = #Attributes.itemnum#
		         AND B.user_id = U.user_id
			 AND B.bid > #Attributes.bid#
			 AND B.bid <= #maximum_bid#
		    ORDER BY B.bid ASC, B.time_placed ASC
  		</cfquery>

		<cfparam name="Attributes.quantity_wanted" default="1">
		<cfset items_taken = int(getQuantity_total) + int(Attributes.quantity_wanted)>
		<cfset email_sent = "">
		
		<cfloop query="getAllHistory">
			<cfset last_bid = getAllHistory.bid>
			<cfset last_quantity = getAllHistory.quantity>
			<cfset last_email = getAllHistory.email>
			<cfset outbid_email_flag = getAllHistory.outbid_email>

			<cfif items_taken GTE Attributes.quantity AND email_sent NEQ last_email>
				<cfset outbid_array[tempCount][1] = last_email>
				<cfset outbid_array[tempCount][2] = last_bid>
				<cfset outbid_array[tempCount][3] = outbid_email_flag>
				
				<cfset tempCount = tempCount + 1>
			</cfif>

			<cfset items_taken = items_taken + last_quantity>
			<cfset email_sent = last_email>

		</cfloop>
				
		<cfif arrayisempty(outbid_array) is "FALSE">
			<CFWDDX action='cfml2wddx' input=#outbid_array# output='wddxText'>
			<cfset session.outbid_notification = wddxText>
		</cfif>
		
	</cfif>

	<cfset caller.errorBadBid = errorBadBid>
<cfelse>
	<cfset caller.maximumBid = maximumBid>
</cfif>
</cfif>
	
<cfsetting enablecfoutputonly="No">
