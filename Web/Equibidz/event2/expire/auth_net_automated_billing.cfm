<!--
  auth_net_automated_billing.cfm
   Called from bill_seller.cfm, bill_seller_monthly.cfm, bill_member.cfm

  
  <!---     <cfmodule template="auth_net_automated_billing.cfm"
itemnum="#itemnum#"
user_id="#user_id#"
invoice_total="#invoice_total#"
>
The authorize.net transaction connection fields are aliased as follows:

Enable authorize net: store_authorize_net = 1 Disable: 0
authorize net Login: lp_dba_storename
authorize net Password:lp_storename
authorize net User ID: lp_userid
authorize net Port: lp_port
authorize net URL address: lp_hostaddr
authorize net Encryption Key: lp_keyfile

  --->

  should return to caller:

  billing_status = 'ok' or 'error'.
  billing_reference = (error message, if error), or (a confirmation number if ok.)
  billing_paid = (how much was paid).

-->
<cfinclude template = "../../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">

<!--- 
<cfset caller.billing_status = "ok">
<cfset caller.billing_reference = "automated billing: no changes made.">
<cfset caller.billing_paid = 0> --->


<cfquery username="#db_username#" password="#db_password#" name="SellersCC" datasource="#datasource#">
	select
		u.user_id as user_id,
		u.fname as fname,
		u.lname as lname,
		u.cc_name as cc_name,
		u.company as company,
		u.cc_number as cc_number,
		u.cc_expiration as cc_expiration,
		u.address1 as address1,
		u.address2 as address2,
		u.city as city,
		u.state as state,
		u.postal_code as postal_code,
		u.country as country,
		u.email as email,
		u.phone1 as phone,
		u.fax as fax
	from users u
	where u.user_id = #attributes.user_id#
	</cfquery>

	<cfset cc_number = #SellersCC.cc_number#>
	<cfset cc_number = cfusion_Decrypt(cc_number, "umbala")>
        
	<cfif isdefined("attributes.cc_number") and isdefined("attributes.cc_name") and isdefined("attributes.cc_expiration")>

		<cfset cc_number = cfusion_Decrypt(attributes.cc_number, "umbala")>
		
		<cfset cc_name = attributes.cc_name>
		<cfset cc_expiration = attributes.cc_expiration>
	<cfelse>

		<cfset cc_number = cfusion_Decrypt(SellersCC.cc_number, "umbala")>            
		<cfset cc_name = SellersCC.cc_name>
		<cfset cc_expiration = SellersCC.cc_expiration>
	</cfif>


<!--- Check cc before charge: CREDIT CARD CHECK --->
<cfinclude template="../../includes/cf_mod10.cfm">
            
<cfif error_message is "">	

	<cfif 	len(trim(cc_name)) GT 0 AND
		len(trim(cc_number)) GT 0 AND
		len(trim(cc_expiration)) GT 0 >
		<cfif 	cc_number eq 0 OR
		    len(trim(cc_name)) lt 1 OR
			len(trim(cc_number)) lt 14 OR
			len(trim(cc_expiration)) lt 1 OR
			len(trim(SellersCC.address1)) lt 1 OR
			len(trim(SellersCC.city)) lt 1 OR
			len(trim(SellersCC.state)) lt 1 OR
			len(trim(SellersCC.postal_code)) lt 1 OR
			len(trim(SellersCC.country)) lt 1 >

			<!--- some credit card information left blank. aborting --->
			<cfset caller.billing_reference = "Credit card fields were left blank in the database.  Cannot process credit card at this time.">
			<cfset caller.billing_status = "Error">
			<cfset caller.billing_paid = 0>

		<cfelse>
			<cfset cc_mo_Description = #left(attributes.title,"20")#>
            <cfset cc_mo_order_id = int(attributes.itemnum)>
            <cfset cc_mo_price = int(attributes.invoice_total*100)/100>
            <cfset cc_cpi_card_number = trim(cc_number)>
            <cfset cc_cpi_card_exp = trim(cc_expiration)>
            <cfset cc_cpi_user_id = int(SellersCC.user_id)>
            <cfset cc_cpi_fname = trim(SellersCC.fname)>
            <cfset cc_cpi_lname = trim(SellersCC.lname)>
            <cfset cc_cpi_card_name = trim(SellersCC.cc_name)>
            <cfset cc_cpi_company = trim(SellersCC.company)>
			<cfset cc_cpi_card_address = trim(SellersCC.address1) & " " & trim(SellersCC.address2)>
			<cfset cc_cpi_card_city = trim(SellersCC.city)>
			<cfset cc_cpi_card_state = trim(SellersCC.state)>
			<cfset cc_cpi_card_zip = trim(SellersCC.postal_code)>
			<cfset cc_cpi_card_country = trim(SellersCC.country)>
			<cfset cc_cpi_card_email = trim(SellersCC.email)>
			<cfset cc_cpi_phone = trim(SellersCC.phone)>
			<cfset cc_cpi_fax = trim(SellersCC.fax)>	            
            
         
<cfhttp url="https://secure.authorize.net/gateway/transact.dll" method="POST" port="443">
    <cfhttpparam type="FORMFIELD" name="x_Version" value="3.1">
    <cfhttpparam type="FORMFIELD" name="x_Delim_Data" value="True">
    <cfhttpparam type="FORMFIELD" name="x_Delim_Char" value="|">
    <cfhttpparam type="FORMFIELD" name="x_login" value="#authorize_net_login#">
    <cfhttpparam type="FORMFIELD" name="x_tran_key" value="#authorize_net_pw#">
    <!--- <cfhttpparam type="FORMFIELD" name="x_Password" value="#authorize_net_pw#"> --->
    <!--- <cfhttpparam type="FORMFIELD" name="x_Test_Request" value="True"> --->
    <cfhttpparam type="FORMFIELD" name="x_Amount" value="#cc_mo_price#">
    <cfhttpparam type="FORMFIELD" name="x_Card_Code" value=""><!--- #CVV2# --->
    <cfhttpparam type="FORMFIELD" name="x_Card_Num" value="#cc_cpi_card_number#">
    <cfhttpparam type="FORMFIELD" name="x_Exp_Date" value="#cc_cpi_card_exp#">
    <cfhttpparam type="FORMFIELD" name="x_invoice_num" value="#cc_mo_order_id#">
    <cfhttpparam type="FORMFIELD" name="x_description" value="#cc_mo_Description#">
    <cfhttpparam type="FORMFIELD" name="x_method" value="CC">
    <cfhttpparam type="FORMFIELD" name="x_type" value="AUTH_CAPTURE">
    <cfhttpparam type="FORMFIELD" name="x_cust_id" value="#cc_cpi_user_id#">
    <cfhttpparam type="FORMFIELD" name="x_first_name" value="#cc_cpi_fname#">
    <cfhttpparam type="FORMFIELD" name="x_last_name" value="#cc_cpi_lname#">
    <cfhttpparam type="FORMFIELD" name="x_company" value="#cc_cpi_company#">
    <cfhttpparam type="FORMFIELD" name="x_address" value="#cc_cpi_card_address#">
    <cfhttpparam type="FORMFIELD" name="x_city" value="#cc_cpi_card_city#">
    <cfhttpparam type="FORMFIELD" name="x_state" value="#cc_cpi_card_state#">
    <cfhttpparam type="FORMFIELD" name="x_zip" value="#cc_cpi_card_zip#">
    <cfhttpparam type="FORMFIELD" name="x_country" value="#cc_cpi_card_country#">
    <cfhttpparam type="FORMFIELD" name="x_phone" value="#cc_cpi_phone#">
    <cfhttpparam type="FORMFIELD" name="x_fax" value="#cc_cpi_fax#">
    <cfhttpparam type="FORMFIELD" name="x_email" value="#cc_cpi_card_email#">
    <!--- <cfhttpparam type="FORMFIELD" name="x_ADC_Delim_Data" value=","> --->
    <!--- <cfhttpparam type="FORMFIELD" name="x_ADC_URL" value="FALSE">  --->
</cfhttp>


	<!--- handling response --->
	<cfset list_name = CFHTTP.FileContent>
<cfif isDefined('list_name') and list_name neq "">
<cfset list_len=#ListLen(list_name, ",")#>
<cfset extra_fields = "">
<cfset cntr = 0>
<cfloop index="i" list="#list_name#" delimiters=",">
	<cfset cntr = incrementvalue(cntr)>
<cfif cntr eq 1>
<cfset x_response_code = i>
<cfelseif cntr eq 2>
<cfset x_response_subcode = i>
<cfelseif cntr eq 3>
<cfset x_response_reason_code = i>
<cfelseif cntr eq 4>
<cfset x_response_reason_text = i>
<cfelseif cntr eq 5>
<cfset x_auth_code = i>
<cfelseif cntr eq 6>
<cfset x_avs_code = i>
<cfelseif cntr eq 7>
<cfset x_trans_id = i>
<cfelseif cntr eq 8>
<cfset x_invoice_num = i>
<cfelseif cntr eq 9>
<cfset x_description = i>
<cfelseif cntr eq 10>
<cfset x_amount = i>
<cfelseif cntr eq 11>
<cfset x_method = i>
<cfelseif cntr eq 12>
<cfset x_type = i>
<cfelseif cntr eq 13>
<cfset x_cust_id = i>
<cfelseif cntr eq 14>
<cfset x_first_name = i>
<cfelseif cntr eq 15>
<cfset x_last_name = i>
<cfelseif cntr eq 16>
<cfset x_company = i>
<cfelseif cntr eq 17>
<cfset x_address = i>
<cfelseif cntr eq 18>
<cfset x_city = i>
<cfelseif cntr eq 19>
<cfset x_state = i>
<cfelseif cntr eq 20>
<cfset x_zip = i>
<cfelseif cntr eq 21>
<cfset x_country = i>
<cfelseif cntr eq 22>
<cfset x_phone = i>
<cfelseif cntr eq 23>
<cfset x_fax = i>
<cfelseif cntr eq 24>
<cfset x_email = i>
<cfelseif cntr eq 25>
<cfset x_ship_to_first_name = i>
<cfelseif cntr eq 26>
<cfset x_ship_to_last_name = i>
<cfelseif cntr eq 27>
<cfset x_ship_to_company = i>
<cfelseif cntr eq 28>
<cfset x_ship_to_address = i>
<cfelseif cntr eq 29>
<cfset x_ship_to_city = i>
<cfelseif cntr eq 30>
<cfset x_ship_to_state = i>
<cfelseif cntr eq 31>
<cfset x_ship_to_zip = i>
<cfelseif cntr eq 32>
<cfset x_ship_to_country = i>
<cfelseif cntr eq 33>
<cfset x_tax = i>
<cfelseif cntr eq 34>
<cfset x_duty = i>
<cfelseif cntr eq 35>
<cfset x_freight = i>
<cfelseif cntr eq 36>
<cfset x_tax_exempt = i>
<cfelseif cntr eq 37>
<cfset x_po_num = i>
<cfelseif cntr eq 38>
<cfset x_md5_hash = li>
<cfelseif cntr eq 39>
<cfset x_cvv2_resp_code = i>
<cfelse>
<!--- <cfset extra_fields = "#extra_fields#, #i#:#listGetAt(list_name,i,",")#"> --->
</cfif>

</cfloop>

<cfif isnumeric(x_response_code)>
	<cfif x_response_code eq 1>
 	<cfset caller.billing_status = "ok">
 	<cfset caller.billing_reference = "DateTime:#timenow#, Response_code:#x_response_code#, Response_reason_text:#x_response_reason_text#, AuthorizationNo:#x_auth_code#, TransID:#x_trans_id#, Invoice:#x_invoice_num#, ccUserID:#x_cust_id#"><!--- , cvv2Code:#x_cvv2_resp_code#, --->
	<cfset caller.billing_paid = #cc_mo_price#>
	<cfquery username="#db_username#" password="#db_password#" name="InsertCCTable" datasource="#datasource#">
		insert into credit_cards 
		(itemnum, name, card_number, expiration)
		values (#cc_mo_order_id#, '#cc_cpi_card_name#', '#cc_cpi_card_number#', '#cc_cpi_card_exp#')
	</cfquery>
	<cfelseif x_response_code eq 2>
 		<cfset caller.billing_status = "Denied">
		<cfset caller.billing_reference = "DateTime:#timenow#, Response_code:#x_response_code#, Response_reason_text:#x_response_reason_text#">
		<cfset caller.billing_paid = 0>
	<cfelseif x_response_code eq 3>
 		<cfset caller.billing_status = "Error">
		<cfset caller.billing_reference = "DateTime:#timenow#, Response_code:#x_response_code#, Response_reason_text:#x_response_reason_text#">
		<cfset caller.billing_paid = 0>
	</cfif>
	
<cfelse>
	<cfset caller.billing_status = "ok">
	<cfset caller.billing_reference = "Automated billing: Connection_Error no changes">
	<cfset caller.billing_paid = 0>
</cfif>

<cfelse>
	<cfset caller.billing_status = "ok">
	<cfset caller.billing_reference = "Automated billing: Connection_Error no changes">
	<cfset caller.billing_paid = 0>
</cfif>		

</CFIF>
<cfelse>
	<!-- no cc information supplied -->
	<cfset caller.billing_status = "error">
	<cfset caller.billing_reference = "automated billing: no changes">
	<cfset caller.billing_paid = 0>
</cfif>


<cfelse>
	<!--- validation error from cf_mode10 --->
	<cfset caller.billing_status = "error">
	<cfset caller.billing_paid = 0>
	<cfset caller.billing_reference = "Transaction not intialized. #error_message#">
		
</cfif>


