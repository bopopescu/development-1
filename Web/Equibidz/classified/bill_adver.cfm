<!--- classified/bill_adver.cfm
	Module for billing advertiser.
	Uses eml_invoice.cfm for email.
	04/28/00 
	classified ver 1.0a
--->
<!---
  <cfmodule template="bill_adver.cfm"
    adnum="[ad number]"
    datasource="[system dsn]"
    db_username="[username]"
    db_password="[password]"
    timenow="[timenow]"
    fromEmail="#SERVICE_EMAIL##DOMAIN#"
    user_id="[user_id]"
    invoice_total="[invoice total]">
    ad_dur="[duration]"
    date_start="[date_start]"
    date_end="[date_end]">

  returns:
  billing_status = 'ok' or 'error'
  billing_reference = Error message if error (else undef)
  
  --->


<cfinclude template = "../includes/app_globals.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">

<!--- Include EPOCH module  --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">
 
  <CFMODULE TEMPLATE="../functions/timenow.cfm">

 <cfinclude template = "../includes/global_vars.cfm">

<!-- get info -->
<cfquery name="getInfo" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT U.email, U.nickname
    FROM users U
    WHERE U.user_id = #attributes.user_id#
</cfquery>

<!-- get currency type -->
<cfquery name="getCurrency" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT pair AS type
    FROM defaults
    WHERE name = 'site_currency'
</cfquery>

<!-- define values -->
<cfset adnum = Attributes.adnum>
<cfset user_id = Attributes.user_id>
<cfset dateCreated = Attributes.timenow>
<cfset dateDue = DateAdd("d", 30, dateCreated)>
<cfset reference = " ">

<!-- set charges -->
<cfset invoice_total = Attributes.invoice_total>

<!-- if invoice_total LT 0, then set it to 0 -->
<cfif invoice_total LT 0>
<!-- invoice_total was set to 0 -->
  <cfset invoice_total = 0.00>
</cfif>

<cfif cyber_cash neq "no">
<cfif invoice_total GT 0 and session.payby is "cc" or cc_mandatory is "yes">
<!-- RUN AUTOMATED MODULES (CYBERCASH, ETC.), UPDATE PAID VALUE,STATUS -->
	<cfmodule template="automated_billing.cfm"
    		adnum="#adnum#"
    		invoice_total="#invoice_total#"
      datasource="#DATASOURCE#"
      db_username="#db_username#"
      db_password="#db_password#"
      user_id="#user_id#">

<!-- check to see if billing was ok. -->
	<cfif (billing_status NEQ "ok") or (billing_paid NEQ invoice_total)>
<!-- automated billing was not ok... email someone... -->
<cfparam name="CYBERCASH_ERROR_EMAIL" default="tracie@beyondsolutions.com">
		<cfmail to="#CYBERCASH_ERROR_EMAIL#" 
			from="automated_billing@#domain#" 
			subject="Error: executing automated billing for ###adnum#.">
		There was an error while processing the automated billing module (automated_billing.cfm) for ad number: ###adnum#.

		Billing Status: '#billing_status#'.
		The error reported was: '#billing_reference#'.

		...
		</cfmail>
		
<!--- **** to be made into a separate page (?) --->
    <font face="Arial" color="#ff0000" size="+2">Sorry, there has been an error charging to your credit card.<br>
    Please click the back button up to the form and double-check your information.</font><br>
    
    Error code: #billing_reference#<br>
</cfif>  

</cfif> 

</cfif>



<cfif cyber_cash eq "no" or session.payby eq "cmo">
<!-- see if invoice for adnum already exists -->
<cfquery name="getExists" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT COUNT(itemnum) AS found
    FROM invoices
    WHERE itemnum = #Attributes.adnum#
</cfquery>
 
		  <!-- add invoice to db -->
  <cfquery username="#db_username#" password="#db_password#" name="insInvoice" datasource="#Attributes.datasource#">
      INSERT INTO invoices
        (itemnum, user_id, date_created, date_due, listing, invoice_total, reference)
      VALUES
        (#adnum#, #user_id#, #dateCreated#, #dateDue#, #numberformat(invoice_total,numbermask)#, #invoice_total#, '#reference#')
  </cfquery>
  
  <!--- log invoice --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#Attributes.datasource#"
    description="Auction Invoiced"
    itemnum="#adnum#"
    amount="#invoice_total#"
    user_id="#user_id#">

</cfif>

  <cfmodule template="eml_invoice.cfm"
    adnum="#adnum#"
    datasource="#DATASOURCE#"
    db_username="#db_username#"
    db_password="#db_password#"
    timenow="#timenow#"
    fromEmail="#SERVICE_EMAIL##DOMAIN#"
    user_id="#user_id#"
    invoice_total="#invoice_total#"
    ad_dur="#Attributes.ad_dur#"
    date_start="#Attributes.date_start#"
    date_end="#Attributes.date_end#"> 
