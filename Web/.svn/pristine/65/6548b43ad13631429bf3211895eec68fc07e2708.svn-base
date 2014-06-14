<!--- eml_invoice.cfm
	Called by bill_adver.cfm;
	e-mail sent to customers.
	04/28/00 
	classified ver 1.0a
--->
 
 <cfinclude template = "../includes/app_globals.cfm">
 
  <!-- get info -->
<cfquery name="getInfo" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
    SELECT U.email, U.nickname
    FROM users U
    WHERE U.user_id = #Attributes.user_id#
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
<cfset invoice_total = Attributes.invoice_total>
<cfset reference = " ">
  
<cfmail to="#getinfo.email#" 
			from="automated_billing@#domain#" 
			subject="Billing Notification for your ad ###adnum#.">	
<!--- If Total fees are 0 --->			
<cfif invoice_total lte 0>
Your ad number is ###adnum#.
	
Your balance is #numberformat(invoice_total,numbermask)#
	
Your ad will run for #Attributes.ad_dur# days, from #DateFormat(Attributes.date_start, "d-mmm-yy")# to #DateFormat(Attributes.date_end, "d-mmm-yy")#.
<!--- If Credit Card is required OR has been choose as payment type --->
<cfelseif session.payby is "cc" or cc_mandatory is "yes">
  Your credit card was processed for ad number: ###adnum# in the amount of #numberformat(invoice_total,numbermask)# #getCurrency.type#.

  Your ad will run for #Attributes.ad_dur# days, from #DateFormat(Attributes.date_start, "d-mmm-yy")# to #DateFormat(Attributes.date_end, "d-mmm-yy")#.
<!--- If Credit Card is not required and has not been chosen as payment type --->
<cfelse>
  Your balance for ad number: ###adnum# is: #numberformat(invoice_total,numbermask)# #getCurrency.type#.
 
  Your ad will run for #Attributes.ad_dur# days, from #DateFormat(Attributes.date_start, "d-mmm-yy")# to #DateFormat(Attributes.date_end, "d-mmm-yy")#.

  Please pay the above amount within 30 days.
</cfif>
  Thank you for using our services,
  #COMPANY_NAME#
</cfmail>