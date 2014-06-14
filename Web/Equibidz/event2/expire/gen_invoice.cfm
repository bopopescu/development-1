<!--
  gen_invoice.cfm
  
  generate invoice for user..
  displays all appropriate fees..
  uses eml_invoice.cfm..
  
  <!---

  <cfmodule template="gen_invoice.cfm"
    itemnum="[item number]"
    datasource="[datasource]"
    timenow="[timenow]"
    fromEmail="[from email address]">

  --->


-->

<cfif isdefined("db_password") is not true>
	<cfinclude template="../../includes/app_globals.cfm">
</cfif>

<!--- Include EPOCH module  --->
 <CFMODULE TEMPLATE="../../functions/epoch.cfm">

<!-- def bill -->
<cfmodule template="def_bill.cfm"
  itemnum="#Attributes.itemnum#"
  datasource="#Attributes.datasource#">

<!-- get info -->
<cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
    SELECT I.itemnum, I.title, U.user_id, U.email, U.balance, U.credit, U.nickname
      FROM items I, users U
     WHERE I.itemnum = #Attributes.itemnum#
       AND I.user_id = U.user_id
</cfquery>


  <!-- find if FREE trial is enabled. -->
  <cfquery username="#db_username#" password="#db_password#" name="findFreeTrial" datasource="#Attributes.datasource#">
      SELECT pair AS true_false
        FROM defaults
       WHERE name = 'free_trial'
  </cfquery>

  <cfif findFreeTrial.true_false eq 1>
	<!-- get FREE Trial period (in days) -->
	<cfquery username="#db_username#" password="#db_password#" name="getFreeTrial" datasource="#Attributes.datasource#">
	    SELECT pair AS days
	      FROM defaults
	     WHERE name = 'free_trial_days'
	</cfquery>
  </cfif>


<!-- get currency type -->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.datasource#">
    SELECT pair AS type
      FROM defaults
     WHERE name = 'site_currency'
</cfquery>

<!-- get billing period -->
<cfquery username="#db_username#" password="#db_password#" name="getPeriod" datasource="#Attributes.datasource#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'billing_period'
</cfquery>

<!-- calc date invoice due -->
<cfset dateDue = DateAdd("d", getPeriod.days, Attributes.timenow)>

<!-- calc invoice sub total -->
<cfset invSubTotal = 0>
<cfloop index="i" from="1" to="#ArrayLen(bill)#">
  <cfset invSubTotal = invSubTotal + bill[i][2]>
</cfloop>


<!-- define free trial period  -->
<cfif findFreeTrial.true_false eq 1>
	<cfset seconds_free = (getFreeTrial.days * 86400)>
	<cfif (EPOCH - getInfo.user_id) lt seconds_free>
		<!-- user gets free auction -->
		<cfset invSubTotal = 0>
	</cfif>
	
</cfif>

<!-- calc invoice total -->
<cfset invTotal = invSubTotal - NumberFormat(getInfo.credit,'#numbermask#')>
<cfif invTotal LT 0>
  <cfset invTotal = 0>
</cfif>

<!-- calc new account balance -->
<cfset newBalance = NumberFormat(getInfo.balance,'#numbermask#') + invTotal>

<!-- setup email message -->
<cfset nl = Chr(13) & Chr(10)>
<cfset message = "">
<cfset message = message & "User Nickname: " & Trim(getInfo.nickname) & nl>
<cfset message = message & "Item Number: " & getInfo.itemnum & nl>
<cfset message = message & "Item Title: " & Trim(getInfo.title) & nl>
<cfset message = message & "Date of Invoice: " & DateFormat(Attributes.timenow, "mm/dd/yyyy") & nl>
<cfset message = message & "Date Invoice Due: " & DateFormat(Variables.dateDue, "mm/dd/yyyy") & nl & nl>

<!---
<cfloop index="i" from="1" to="#ArrayLen(bill)#">
  <cfset message = message & bill[i][1] & ": " & numberFormat(bill[i][2],numbermask) & " " & Trim(getCurrency.type) & nl>
</cfloop>
--->


<cfset message = message & nl & "Sub Total: " & numberFormat(invSubTotal,numbermask) & " " & Trim(getCurrency.type) & nl>
<cfset message = message & "Account Credit: " & numberFormat(getInfo.credit,numbermask) & " " & Trim(getCurrency.type) & nl>


<cfset message = message & nl & "Total: " & numberFormat(invTotal,numbermask) & " " & Trim(getCurrency.type) & nl & nl>


<cfset message = message & "Current Account Balance: " & numberFormat(getInfo.balance,numbermask) & " " & Trim(getCurrency.type) & nl>
<cfset message = message & "New Account Balance: " & numberFormat(newBalance,numbermask) & " " & Trim(getCurrency.type)>

<!-- send email -->
<cfmodule template="eml_invoice.cfm"
  to="#Trim(getInfo.email)#"
  from="#Attributes.fromEmail#"
  subject="Invoice: (Item ###getInfo.itemnum#) #Trim(getInfo.title)#"
  message="#Variables.message#"
  itemnum="#getInfo.itemnum#">
