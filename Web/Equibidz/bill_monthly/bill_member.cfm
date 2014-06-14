<!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 
 <!-- define TIMENOW -->
  <cfmodule template="../functions/timenow.cfm">
 
 <!-- get currency type -->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#datasource#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
 
 <!-- get billing period -->
  <cfquery username="#db_username#" password="#db_password#" name="getPeriod" datasource="#datasource#">
      SELECT pair AS days
        FROM defaults
       WHERE name = 'billing_period'
  </cfquery>
 <cfset dateDue = DateAdd("d", getPeriod.days, timenow)>

<cfquery name="get_all_balances" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT user_id
FROM users
WHERE balance > 0
</cfquery>

<cfloop query="get_all_balances">
<!--- get member info --->
<cfquery name="getInfo" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT *
FROM users
WHERE user_id = #user_id#
</cfquery>



<cfif getInfo.balance gt 0>
	<cfset new_bal = getInfo.balance - getInfo.credit>
	<cfif new_bal gt 0>
		<cfif isdefined("authorize_net_aim") and authorize_net_aim eq "yes">
		<!-- RUN AUTOMATED MODULES (AUTHORIZE.NET), UPDATE PAID VALUE,STATUS -->

		<cfmodule template="../event2/expire/auth_net_automated_billing.cfm"
    	user_id="#getInfo.user_id#"
		itemnum="0"
		title="Monthly Charged"
		invoice_total="#new_bal#">
		
			<cfif billing_status EQ "ok">
			
			<!--- if monthly insert into member_bal --->
				<cfquery username="#db_username#" password="#db_password#" name="insert_member_bal" datasource="#DATASOURCE#">
				INSERT INTO member_bal
				(user_id,itemnum,date_time,descr,pmt_credit,total)
				VALUES
				(#getInfo.user_id#,0,#CreateODBCDateTime(timenow)#,'Monthly charged',#billing_paid#,0)
				</cfquery>

			</cfif>
		
		<cfelse>
	<cfmodule template="member_monthly_billing.cfm"
    	user_id = "#getInfo.user_id#"
		itemnum="0"
		invoice_total="#new_bal#">
		</cfif>
<!--- <cfoutput>#getInfo.user_id#---#getInfo.balance#<br></cfoutput> --->


	<cfif billing_status NEQ "ok">

	<cfmail to="site_admin@#domain#" 
			from="member_monthly_billing@#domain#" 
			subject="Error: executing automated billing for ###getInfo.user_id#.">
		There was an error while processing the automated billing module (member_monthly_billing.cfm) for user: ###getInfo.user_id#.

		Billing Status: '#billing_status#'.
		The error reported was: '#billing_reference#'.

		...
		</cfmail>
	</cfif>
	
		<cfset newBalance = #getInfo.balance# - #billing_paid#>
		<!-- setup email message -->
  		<cfset nl = "<br>"><!---Chr(13) & Chr(10)--->
  		<cfset message = "">
  		<cfset message = message & "User Nickname: " & Trim(getInfo.nickname) & nl>
  		<!--- <cfset message = message & "Item Number: " & getInfo.itemnum & nl>
  		<cfset message = message & "Item Title: " & Trim(getInfo.title) & nl> --->
  		<cfset message = message & "Date of Invoice: " & DateFormat(timenow, "mm/dd/yyyy") & nl>
  		<cfset message = message & "Date Invoice Due: " & DateFormat(Variables.dateDue, "mm/dd/yyyy") & nl & nl>
  
  		<!--- <cfset message = message & nl & "Sub Total: " & numberformat(invSubTotal,numbermask) & " " & Trim(getCurrency.type) & nl> --->
  		<!--- <cfset message = message & "Account Credit: " & numberformat(getInfo.credit,numbermask) & " " & Trim(getCurrency.type) & nl> --->
  		<cfset message = message & nl & "Total: " & numberformat(getInfo.balance,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
  		<!--- <cfset message = message & "Current Account Balance: " & numberformat(getInfo.balance,numbermask) & " " & Trim(getCurrency.type) & nl> --->
		<cfif isdefined("paypal") and paypal eq "no">
  		<cfset message = message & "Total Payment Received: " & numberFormat(billing_paid,numbermask) & " " & Trim(getCurrency.type) & "<br>">
  		<cfset message = message & "New Account Balance: " & numberFormat(newBalance,numbermask) & " " & Trim(getCurrency.type)>
		</cfif>

  		<!-- send email -->
  		<cfmodule template="eml_member_statement.cfm"
    	to="#Trim(getInfo.email)#"
    	from="member_monthly_billing@#domain#"
    	subject="Monthly Invoice: (user ###getInfo.user_id#[#getInfo.nickname#])"
    	message="#Variables.message#"
		itemnum="0"
		title="Monthly Billing"
		newBalance="#newBalance#"
		user_id="#user_id#"
		paid="#billing_paid#">
		
		<!--- pay any outstanding invoice for a specific user --->
		<cfif billing_paid gt 0>
			<cfinclude template="payanyinv.cfm">
		</cfif>
	
	</cfif>
</cfif>

</cfloop>
