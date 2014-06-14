<!--
  automated_billing.cfm
   
  bills user's credit card:
  
  <!---     <cfmodule template="automated_billing.cfm"
    		itemnum="#itemnum#"
		invoice_total="#invoice_total#"
		datasource="#datasource#">

  --->

  should return to caller:

  billing_status = 'ok' or 'error'.
  billing_reference = (error message, if error), or (a confirmation number if ok.)
  billing_paid = (how much was paid).

-->
<cfinclude template = "../../includes/app_globals.cfm">
 <!--- define TIMENOW --->
 <cfmodule template="../../functions/timenow.cfm">
<cfparam name="cyber_cash" default="yes"> <!--- set this to "yes" when ready to go live,
			set to "no" to turn off, and set to "test" for testing purposes. --->

<cfif cyber_cash neq "yes">
	<cfset CC_MERCHANT_KEY="gmRJp8rbzzcRdI5g8eLRScFeeQSWew5FsBzq6bxJDSJIiWhq7f">
	<cfset CC_CYBERCASH_ID="test-mck">
</cfif>

<cfset caller.billing_status = "ok">
<cfset caller.billing_reference = "automated billing: no changes made.">
<cfset caller.billing_paid = 0>

<cfquery username="#db_username#" password="#db_password#" name="SellersCC" datasource="#datasource#">
	select
		u.cc_name as cc_name,
		u.cc_number as cc_number,
		u.cc_expiration as cc_expiration,
		u.address1 as address1,
		u.address2 as address2,
		u.city as city,
		u.state as state,
		u.postal_code as postal_code,
		u.country as country,
		u.email as email
	from users u
	where u.user_id = #attributes.user_id#
</cfquery>

	<!--- cc decryption --->
   	<cfif SellersCC.cc_number neq 0>
   	<cfset cc_number = Decrypt(SellersCC.cc_number, "umbala")>
   	<cfelse>
   	<cfset cc_number = #SellersCC.cc_number#>
   	</cfif>
	<cfset cc_name="#SellersCC.cc_name#">
   	<cfset cc_expiration="#SellersCC.cc_expiration#">

<cfif cyber_cash neq "no" or link_point neq "no">
	<!--- cyber_cash = yes/test ... <cfoutput>#cyber_cash#</cfoutput>--->

	<cfif 	len(trim(cc_name)) GT 0 AND
		len(trim(cc_number)) GT 0 AND
		len(trim(cc_expiration)) GT 0 >
		<cfif 	cc_number eq 0 OR
		    len(trim(cc_name)) lt 1 OR
			len(trim(cc_number)) lt 14 OR
			len(trim(cc_expiration)) lt 1 OR
			len(trim(sellerscc.address1)) lt 1 OR
			len(trim(sellerscc.city)) lt 1 OR
			len(trim(sellerscc.state)) lt 1 OR
			len(trim(sellerscc.postal_code)) lt 1 OR
			len(trim(sellerscc.country)) lt 1 >

			<!-- some credit card information left blank. aborting -->
			<cfset caller.billing_reference = "One, or more credit card fields were left blank in the database.  Cannot process credit card at this time.">
			<cfset caller.billing_status = "bad">
			<cfset caller.billing_paid = 0>

		<cfelse>
		    	<cfset cc_mo_order_id = int(attributes.itemnum)>
		    	<cfset cc_mo_price = int(attributes.invoice_total*100)/100>
		    	<cfset cc_cpi_card_number = cc_number>
		    	<cfset cc_cpi_card_exp = trim(cc_expiration)>
		    	<cfset cc_cpi_card_name = trim(cc_name)>
			<cfset cc_cpi_card_address = trim(sellerscc.address1) & " " & trim(sellerscc.address2)>
			<cfset cc_cpi_card_city = trim(sellerscc.city)>
			<cfset cc_cpi_card_state = trim(sellerscc.state)>
			<cfset cc_cpi_card_zip = trim(sellerscc.postal_code)>
			<cfset cc_cpi_card_country = trim(sellerscc.country)>
			<cfset cc_cpi_card_email = trim(sellerscc.email)>
			<!-- cfx_cybercash: using the DirectPay style message -->
		<cfif cyber_cash neq "no">
			<CFX_CYBERCASH VERSION="3.2"
				CCPS_HOST="http://cr.cybercash.com/cgi-bin/"
				CYBERCASH_ID="#cc_cybercash_id#"
				MERCHANT_KEY="#cc_merchant_key#"
			    	MO_ORDER_ID="#cc_mo_order_id#"
			    	MO_VERSION="3.2.0.2"
			    	MO_PRICE="usd #cc_mo_price#"
			    	CPI_CARD_NUMBER="#cc_cpi_card_number#"
			    	CPI_CARD_EXP="#cc_cpi_card_exp#"
			    	CPI_CARD_NAME="#cc_cpi_card_name#"
				CPI_CARD_ADDRESS="#cc_cpi_card_address#"
				CPI_CARD_CITY="#cc_cpi_card_city#"
				CPI_CARD_STATE="#cc_cpi_card_state#"
				CPI_CARD_ZIP="#cc_cpi_card_zip#"
				CPI_CARD_COUNTRY="#cc_cpi_card_country#"
			    	OutputPOPQuery="pop">
	<!--- End CybeCash --->
	     <cfelseif link_point neq "no">
         <CFSET Chargetype_Auth = 0>
         <CFSET Live = 0>
	     <cfset ItemContext = queryNew("itemid,description,itemprice,itemqty")>
         <cfset TempValue = queryAddRow(ItemContext)>
         <cfset TempValue = querySetCell(ItemContext,"itemid","#attributes.itemnum#")>
         <cfset TempValue = querySetCell(ItemContext,"description","#attributes.title#")>
         <cfset TempValue = querySetCell(ItemContext,"itemprice","#attributes.invoice_total#")>
 		 <cfset TempValue = querySetCell(ItemContext,"itemqty",1)>
         <cfset LP_ORDERCARDEXPMONTH = mid(#cc_cpi_card_exp#, 1,2)>
         <cfset LP_ORDERCARDEXPYEAR = mid(#cc_cpi_card_exp#, 4,2)>
<cfinclude template="../../includes/cf_mod10.cfm">
<cfif error_message is "">
         <!--- cfx_linkapi:  --->
         <CFX_LinkAPI
	       REQSTORENAME = "#lp_reqstorename#" 
	       REQKEYFILE = "#lp_reqkeyfile#" 
	       REQHOSTADDR = "#lp_reqhostaddr#" 
	       REQPORT = "#lp_reqport#" 
	       SHIPCOUNTRY = "US"
	       SHIPSTATE = "CO"
	       SHIPITEMPRICETOTAL = "#attributes.invoice_total#"
	       SHIPTOTALWEIGHT = "0"
	       SHIPCARRIER = "0"
	       TAXPRICETOTAL = "0"
	       ORDERUSERID = "#lp_orderuserid#" 
	       ORDERBCOMPANY = "#domain#" 
	       ORDERBCOUNTRY = "#cc_cpi_card_country#" 
	       ORDERBNAME = "#cc_cpi_card_name#" 
	       ORDERBADDR1 = "#cc_cpi_card_address#" 
	       ORDERBSTATE = "#cc_cpi_card_state#" 
	       ORDERBZIP = "#cc_cpi_card_zip#" 
	       ORDERSNAME = "#cc_cpi_card_name#"
	       ORDERSADDR1 = "#cc_cpi_card_address#" 
	       ORDERSCITY = "#cc_cpi_card_city#" 
	       ORDERSSTATE = "#cc_cpi_card_state#" 
	       ORDERSZIP = "#cc_cpi_card_zip#" 
	       ORDERSCOUNTRY = "#cc_cpi_card_country#" 
	       ORDERCOMMENTS = "" 
	       ORDERCARDNUMBER = "#cc_cpi_card_number#" 
	       ORDERCHARGETYPE = "" 
	       ORDERCARDEXPMONTH = "#lp_ordercardexpmonth#" 
	       ORDERCARDEXPYEAR = "#lp_ordercardexpyear#" 
	       ORDEREMAIL = "#cc_cpi_card_email#" 
	       ORDERRESULT = "#Live#" 
	       ORDERSHIPPINGPRICE = "0" 
	       ORDERTAX = "0" 
	       QUERY = "ItemContext" 
         >
<cfelse>
<cfset CSIOrderFieldApproved = "#error_message#">
<cfset CSIOrderFieldTime = "">
<cfset CSIOrderFieldOrdernum="">
<cfset CSIOrderFieldError="Transaction not intialized">
</cfif>
</cfif>
		<cfif isDefined('POP.status') >
			<cfif POP.status eq "success">
				<cfset caller.billing_reference = POP.auth_code>
				<cfset caller.billing_status = "ok">
				<cfset caller.billing_paid = cc_mo_price>
			</CFIF>
		<cfelseif isDefined('CSIOrderFieldApproved')>
			<cfif #CSIOrderFieldApproved# eq "approved">
				<!--- cc charged sucessfully --->
				<!--- <cfset caller.billing_reference = "Order Num: " & "#CSIOrderFieldRef#" &  "Transaction Num: " & "#CSIOrderFieldOrdernum#" & "Transaction Time: " & "#CSIOrderFieldTime#"> --->
				<cfset caller.billing_reference = "Order Num: " & "#attributes.itemnum#" &  "Transaction Num: " & "#CSIOrderFieldOrdernum#" & "Transaction Time: " & "#CSIOrderFieldTime#" & "Approved Status: " & "#CSIOrderFieldApproved#" & "Order Error: " & "#CSIOrderFieldError#">
				<cfset caller.billing_status = "#CSIOrderFieldApproved#">
				<cfset caller.billing_status = "ok">
				<cfset caller.billing_paid = cc_mo_price>
				<!--- cc encryption --->
				<cfset card_number = Encrypt(cc_cpi_card_number, "umbala")>
				<cfquery username="#db_username#" password="#db_password#" name="InsertCCTable" datasource="#datasource#">
					insert into credit_cards 
						   (itemnum, name, card_number, expiration)
					values (#cc_mo_order_id#, '#cc_cpi_card_name#', '#card_number#', '#cc_cpi_card_exp#')
				</cfquery>
			<cfelse>
				<!--- If Credit card is not approved --->
				<!--- <cfset caller.billing_reference = "Order Num: " & "#CSIOrderFieldRef#" &  "Transaction Num: " & "#CSIOrderFieldOrdernum#" & "Transaction Time: " & "#CSIOrderFieldTime#"> --->
				<cfset caller.billing_reference = "Order Num: " & "#attributes.itemnum#" &  "Transaction Num: " & "#CSIOrderFieldOrdernum#" & "Transaction Time: " & "#CSIOrderFieldTime#" & "Approved Status: " & "#CSIOrderFieldApproved#" & "Order Error: " & "#CSIOrderFieldError#">
				<cfset caller.billing_status = "#CSIOrderFieldApproved#">
				<cfset caller.billing_paid = 0.00> 
			</cfif>	
				


			<cfelse>
			<cfif isDefined('POP.status')>
				<cfset caller.billing_status = POP.status>
				<cfset caller.billing_reference = "Error code: " & POP.error_code & ", " & POP.error_message>
				<cfset caller.billing_paid = 0>
				<!--- cc not charged successfully: --->
			<!--- billing_reference = <cfoutput>#caller.billing_reference#</cfoutput>--->
				<!--- billing_status    = <cfoutput>#caller.billing_status#</cfoutput> --->
			<cfelseif isDefined('#CSIOrderFieldApproved#')>
			<cfset caller.billing_status = "#CSIOrderFieldApproved#">
				<cfset caller.billing_reference = "Error code: " & "#CSIOrderFieldError#" & "Transaction Num: " & "#CSIOrderFieldOrdernum#" & "Transaction Time: " & "#CSIOrderFieldTime#">
				<cfset caller.billing_paid = 0>
			
			</cfif>
		</cfif>
		</CFIF>
	<cfelse>
		<!-- no cc information supplied -->
		<cfset caller.billing_status = "ok">
		<cfset caller.billing_reference = "automated billing: no changes">
		<cfset caller.billing_paid = 0>
	</cfif>
<cfelse>
	<!--- cyber_cash = no ... <cfoutput>#cyber_cash#</cfoutput> --->
	<cfset caller.billing_status = "ok">
	<cfset caller.billing_reference = "automated billing: no changes">
	<cfset caller.billing_paid = 0>
</cfif>


