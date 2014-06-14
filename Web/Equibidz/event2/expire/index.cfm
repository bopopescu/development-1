<!--
  index.cfm
  
  main auction expirer script...

  checks auctions
    with status
    and date_end < TIMENOW
  and that it meets any dynamic close requirements..
  if should expire.. then expires auction..
  generates invoices.. etc..
  sends emails..
   
-->

<cftry>
  <!-- include globals -->
  <cfinclude template="../../includes/app_globals.cfm">
  
  <!-- define TIMENOW -->
  <cfmodule template="../../functions/timenow.cfm">
  
  <cfcatch>
    <cfabort>
  </cfcatch>
</cftry>

<!--- get billing type --->
<cfquery username="#db_username#" password="#db_password#" name="get_billing_type" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='billing_type'
</cfquery>
<cfset #billing_type# = #get_billing_type.pair#>
<!--- Run query to get all no invoice users --->
<cfquery username="#db_username#" password="#db_password#" name="get_noinv_users" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='noinv_user'
</cfquery>
<cfset noinv_users_list = valuelist(get_noinv_users.pair)>

<!-- get auctions -->
<cfquery username="#db_username#" password="#db_password#" name="getAuctions" datasource="#DATASOURCE#">
    SELECT itemnum, user_id, dynamic, auto_relist, reserve_bid, auction_mode, quantity
      FROM items
     WHERE status = 1
       AND date_end < #TIMENOW#
</cfquery>

<!-- chk auctions -->
<cfloop query="getAuctions">

<!--- chk bids to see if item was bid on --->
  <cfquery username="#db_username#" password="#db_password#" NAME="getBids" DATASOURCE="#DATASOURCE#" MAXROWS="1">
SELECT bid FROM bids
WHERE itemnum = #getAuctions.itemnum#
ORDER BY bid DESC
</CFQUERY>
  
  <!-- chk user account on auction still valid -->
  <cfquery username="#db_username#" password="#db_password#" name="chkAccount" datasource="#DATASOURCE#">
      SELECT COUNT(user_id) AS found
        FROM users
       WHERE user_id = #getAuctions.user_id#
  </cfquery>
  
<cfif chkAccount.found>
	<cfset acntValid = "TRUE">
<cfelse>
	<cfset acntValid = "FALSE">
	<!-- set auction inactive -->
	<cfquery username="#db_username#" password="#db_password#" name="updAuction" datasource="#DATASOURCE#">
		UPDATE items
		SET status = 0
		WHERE itemnum = #getAuctions.itemnum#
	</cfquery>

	<!-- log auction expired -->
	<cfmodule template="../../functions/addTransaction.cfm" datasource="#DATASOURCE#" description="Auction Expired (Invalid User ID)" itemnum="#getAuctions.itemnum#">
	<!-- send email to customer service -->
	<cfmodule template="eml_badaccount.cfm" to="#SERVICE_EMAIL##DOMAIN#" 
		from="#SERVICE_EMAIL##DOMAIN#"
		subject="Invalid user account - auction #getAuctions.itemnum# now inactive"
		itemnum="#getAuctions.itemnum#"
		user_id="#getAuctions.user_id#">
</cfif>

<!-- if acount still valid continue -->
<cfif acntValid>

	<!-- define values -->
	<cfset leaveOpen = "FALSE">

	<!-- chk dynamic close params -->
	<cfif getAuctions.dynamic eq 1>
		<cfmodule template="chk_dynamic.cfm"
		itemnum="#getAuctions.itemnum#"
		datasource="#DATASOURCE#"
		timenow="#TIMENOW#">
	</cfif>

	<!-- if ok -->
	<cfif not leaveOpen>

		<!-- set expired item to inactive -->
		<cfquery username="#db_username#" password="#db_password#" name="set_inactive" datasource="#datasource#">
		UPDATE items
		SET status = 0
		WHERE itemnum = #getAuctions.itemnum#
		</cfquery>


		<!-- gen invoice/bill user/set inactive -->
		<cfif listcontains(noinv_users_list, getAuctions.user_id) is 0>

			<cfif billing_type eq "per_auction">
				<cfmodule template="bill_seller.cfm"
					itemnum="#getAuctions.itemnum#"
					datasource="#DATASOURCE#"
					timenow="#TIMENOW#"
					fromEmail="#SERVICE_EMAIL##DOMAIN#">
			<cfelseif billing_type eq "monthly">
				<cfmodule template="bill_seller_monthly.cfm" itemnum="#getAuctions.itemnum#" datasource="#DATASOURCE#" timenow="#TIMENOW#" fromEmail="#SERVICE_EMAIL##DOMAIN#">
			</cfif>
		<cfelse>

			<!--- log auction expired --->
			<cfmodule template="../../functions/addTransaction.cfm"
			datasource="#datasource#"
			description="Auction Expired"
			itemnum="#getAuctions.itemnum#"
			user_id="#getAuctions.user_id#">
		</cfif>

		<!-- eml seller w/ results -->
		<cfmodule template="gen_seller_results.cfm"
		itemnum="#getAuctions.itemnum#"
		datasource="#DATASOURCE#"
		timenow="#TIMENOW#"
		auction_mode="#getAuctions.auction_mode#"
		fromEmail="#SERVICE_EMAIL##DOMAIN#">

		<!-- eml bidder(s) w/ results -->
		<cfmodule template="gen_bidder_results.cfm"
		itemnum="#getAuctions.itemnum#"
		datasource="#DATASOURCE#"
		timenow="#TIMENOW#"
		auction_mode="#getAuctions.auction_mode#"
		fromEmail="#SERVICE_EMAIL##DOMAIN#">


		<!-- Auto relist items that have expired without bids meeting reserve bid-->	
		<cfif getAuctions.auction_mode is 0>
			
			<CFIF (getBids.recordcount is 0 OR getBids.bid LT getAuctions.reserve_bid) AND getAuctions.quantity gt 0>

				<cfif #getAuctions.auto_relist# is not 0 >
					<cfmodule template="auto_relist.cfm"
					itemnum="#getAuctions.itemnum#"
					timenow="#TIMENOW#"
					datasource="#DATASOURCE#"> 
				</cfif>
			</CFIF>
		<CFELSE>
		<!--- Reverse Auction --->
			<CFIF getBids.recordcount is 0 OR getBids.bid GT getAuctions.reserve_bid>

				<cfif #getAuctions.auto_relist# is not 0 >
					<cfmodule template="auto_relist.cfm"
					itemnum="#getAuctions.itemnum#"
					timenow="#TIMENOW#"
					datasource="#DATASOURCE#"> 
				</cfif>
			</CFIF>
		</CFIF>
	</cfif>
</cfif>
</cfloop>
