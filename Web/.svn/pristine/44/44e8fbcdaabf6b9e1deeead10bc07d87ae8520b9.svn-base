<!--
  classified/automated_billing.cfm
   
  bills user's credit card:
  
<!---
     <cfmodule template="automated_billing.cfm"
    		adnum="#adnum#"
     	invoice_total="#invoice_total#"
    		datasource="#DATASOURCE#"
      db_username="#db_username#"
      db_password="#db_password#"
      user_id="#user_id#">


  should return to caller:

  billing_status = 'ok' or 'error'.
  billing_reference = (error message, if error), or (a confirmation number if ok.)
  billing_paid = (how much was paid).

  --->
-->
<cfinclude template = "../includes/app_globals.cfm">

<!--- <cfparam name="cyber_cash" default="test">  set this to "yes" when ready to go live,
			set to "no" to turn off, and set to "test" for testing purposes. --->

<cfif cyber_cash neq "yes">
	<cfset CC_MERCHANT_KEY="gmRJp8rbzzcRdI5g8eLRScFeeQSWew5FsBzq6bxJDSJIiWhq7f">
	<cfset CC_CYBERCASH_ID="test-mck">
</cfif>

<cfset caller.billing_status = "ok">
<cfset caller.billing_reference = "automated billing: no changes made.">
<cfset caller.billing_paid = 0>

<cfquery name="advertisersCC" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
	select 	u.cc_name as cc_name,
		u.cc_number as cc_number,
		u.cc_expiration as cc_expiration,
		u.address1 as address1,
		u.address2 as address2,
		u.city as city,
		u.state as state,
		u.postal_code as postal_code,
		u.country as country
	from users u
	where u.user_id =  #Attributes.user_id#
</cfquery>

<!--- <cfif cyber_cash neq "no"> --->
	<!-- cyber_cash = yes/test ... <cfoutput>#cyber_cash#</cfoutput>-->

	 <!--- Using session variables for first three values --->
 <cfset cc_name = trim(session.cc_name)>
 <cfset cc_number = trim(session.cc_number)>
 <cfset cc_expiration = trim(session.cc_expiration)>

	<cfif 	len(cc_name) GT 0 AND
		len(cc_number) GT 0 AND
		len(cc_expiration) GT 0 >

		<cfif 	len(cc_name) lt 1 OR
 			len(cc_number) lt 1 OR
 			len(cc_expiration) lt 1>
 <!---     OR
 			len(trim(advertisersCC.address1)) lt 1 OR
 			len(trim(advertisersCC.city)) lt 1 OR
 			len(trim(advertisersCC.state)) lt 1 OR
 			len(trim(advertisersCC.postal_code)) lt 1 OR
 			len(trim(advertisersCC.country)) lt 1 > --->
 
 			<!-- some credit card information left blank. aborting -->
 			<cfset caller.billing_reference = "One, or more credit card fields were left blank in the database.  Cannot process credit card at this time.">
 			<cfset caller.billing_status = "bad">
 			<cfset caller.billing_paid = 0>

		<cfelse>
   	<cfset cc_mo_order_id = int(attributes.adnum)>
   	<cfset cc_mo_price = attributes.invoice_total>
   	<cfset cc_cpi_card_number = cc_number>
   	<cfset cc_cpi_card_exp = cc_expiration>
   	<cfset cc_cpi_card_name = cc_name>
 			<cfset cc_cpi_card_address = trim(advertisersCC.address1) & " " & trim(advertisersCC.address2)>
 			<cfset cc_cpi_card_city = trim(advertisersCC.city)>
 			<cfset cc_cpi_card_state = trim(advertisersCC.state)>
 			<cfset cc_cpi_card_zip = trim(advertisersCC.postal_code)>
 			<cfset cc_cpi_card_country = trim(advertisersCC.country)>

			<!-- cfx_cybercash: using the DirectPay style message -->
			<CFX_CYBERCASH
			    	VERSION="3.2"
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

			<cfif POP.status eq "success">
				<!-- cc charged sucessfully -->
				<cfset caller.billing_status = "ok">
				<cfset caller.billing_reference = POP.auth_code>
				<cfset caller.billing_paid = cc_mo_price>


<!---   adnum accomodation TBD. --->

			<cfelse>
				<cfset caller.billing_status = POP.status>
				<cfset caller.billing_reference = "Error code: " & POP.error_code & ", " & POP.error_message>
				<cfset caller.billing_paid = 0>
				<!-- cc not charged successfully: -->
				<!-- billing_reference = <cfoutput>#caller.billing_reference#</cfoutput>-->
				<!-- billing_status    = <cfoutput>#caller.billing_status#</cfoutput> -->
			</cfif>
		</cfif>
</cfif>
	<!--- <cfelse>  --->
		<!-- inadequate cc information supplied -->
<!--- 	<cfset caller.billing_status = "ok">
		<cfset caller.billing_reference = "automated billing: no changes">
		<cfset caller.billing_paid = 0>
	</cfif> 
 <cfelse> --->
	<!-- cyber_cash = no ... <cfoutput>#cyber_cash#</cfoutput> -->
<!--- 	<cfset caller.billing_status = "ok">
	<cfset caller.billing_reference = "automated billing: no changes">
	<cfset caller.billing_paid = 0>
</cfif> --->
			<cfif NOT isDefined("reference")>
			<cfset reference = #caller.billing_reference#>
			</cfif>
		    <cfset sPaymentRef = "Payment (CyberCash: #reference#)">
    
		    <!--- add payment record --->
		    <cfquery datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
		        INSERT INTO payments
		          (
		           adnum,
		           date_posted,
		           user_id,
		           amount,
		           reference
		          )
		        VALUES
		          (
		           #adnum#,
		           #dateCreated#,
		           #user_id#,
		           #paid#,
		           '#Variables.sPaymentRef#'
		          )
		    </cfquery>

  
		    <!--- log payment --->
		    <cfmodule template="../../functions/Class_addTransaction.cfm"
		      datasource="#DATASOURCE#"
        db_username="#db_username#"
        db_password="#db_password#"
		      description="Payment (CyberCash: #reference#)"
		      adnum="#adnum#"
		      amount="#paid#"
		      user_id="#user_id#">

<!--- Test Code --->
<cfif Isdefined("session.test") AND session.test is not "">
<cfset veiled_card_number = Left(cc_cpi_card_number, 4) & RepeatString('x', Len(cc_cpi_card_number)-8) & Right(cc_cpi_card_number, 4)>
<cfmail from="tracie@beyondsolutions.com" to="tracie@beyondsolutions.com" subject="Automated Billing Test Output">
			    	VERSION="3.2"
		    		CCPS_HOST="http://cr.cybercash.com/cgi-bin/"
			    	CYBERCASH_ID="#cc_cybercash_id#"
			    	MERCHANT_KEY="#cc_merchant_key#"
			    	MO_ORDER_ID="#cc_mo_order_id#"
			    	MO_VERSION="3.2.0.2"
			    	MO_PRICE="usd #cc_mo_price#"
			    	CPI_CARD_NUMBER="#veiled_card_number#"
			    	CPI_CARD_EXP="#cc_cpi_card_exp#"
			    	CPI_CARD_NAME="#cc_cpi_card_name#"
    				CPI_CARD_ADDRESS="#cc_cpi_card_address#"
    				CPI_CARD_CITY="#cc_cpi_card_city#"
    				CPI_CARD_STATE="#cc_cpi_card_state#"
    				CPI_CARD_ZIP="#cc_cpi_card_zip#"
    				CPI_CARD_COUNTRY="#cc_cpi_card_country#"
			    	OutputPOPQuery="pop">

pop.status: #pop.status#
caller.billing_status: #caller.billing_status#
caller.billing_reference: #caller.billing_reference#
caller.billing_paid: #caller.billing_paid#
</cfmail>
</cfif> 
