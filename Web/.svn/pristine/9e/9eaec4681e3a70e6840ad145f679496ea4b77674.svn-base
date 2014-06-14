<cfinclude template = "../includes/app_globals.cfm">

 <!-- define TIMENOW -->
  <cfmodule template="../functions/timenow.cfm">

<!-- read post from PayPal system and add 'cmd' -->
<CFSET str="cmd=_notify-validate">
<CFLOOP INDEX="TheField" list="#Form.FieldNames#">
<CFSET str = str & "&#LCase(TheField)#=#URLEncodedFormat(Evaluate(TheField))#">
</CFLOOP>
<CFIF IsDefined("FORM.payment_date")>
<CFSET str = str & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
</CFIF>
<CFIF IsDefined("FORM.subscr_date")>
<CFSET str = str & "&subscr_date=#URLEncodedFormat(Form.subscr_date)#">
</CFIF>

<!-- post back to PayPal system to validate -->
<CFHTTP URL="https://www.paypal.com/cgi-bin/webscr?#str#" METHOD="GET" RESOLVEURL="false">
</CFHTTP>

<!-- assign posted variables to local variables -->
<!-- note: additional IPN variables also available -- see IPN documentation -->
<CFSET item_name=FORM.item_name>
<CFSET receiver_email=FORM.receiver_email>
<CFSET payment_status=FORM.payment_status>
<CFSET payment_gross=FORM.payment_gross>
<CFSET txn_id=FORM.txn_id>
<CFSET payer_email=FORM.payer_email>
<CFSET user_id=FORM.custom>
<CFIF IsDefined("FORM.item_number")>
<CFSET item_number=FORM.item_number>
</CFIF>

<!-- check notification validation -->
<CFIF #CFHTTP.FileContent# is "VERIFIED">
		<!-- check that txn_id has not been previously processed -->
		<cfquery username="#db_username#" password="#db_password#" name="chck_prev_proc" datasource="#datasource#">
			SELECT itemnum
			FROM payments
			WHERE docnum = 'PAYPAL-#txn_id#'
		</cfquery>
<!-- check that payment_status=Completed -->
	<cfif payment_status eq "Completed">

			<!-- check that receiver_email is your email address -->
			<cfif receiver_email eq paypal_business_acct>
				<!--- get membership --->
				<cfquery username="#db_username#" password="#db_password#" name="get_membership" datasource="#datasource#">
					SELECT membership
					FROM users
         			WHERE user_id = #user_id#
    			</cfquery>
				<cfset membership_cycle = listgetat(get_membership.membership,4,"_")>
				<!--- update membership --->
				<cfquery username="#db_username#" password="#db_password#" name="upd_membership" datasource="#datasource#">
       				UPDATE users
           			SET membership_status = 1,
						<cfif membership_cycle eq "Monthly">,membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#<cfelseif membership_cycle eq "LifeTime">,membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#<cfelse>,membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#</cfif>
         			WHERE user_id = #user_id#
    			</cfquery>
			
			<!--- log payment --->
		    <cfmodule template="../functions/addTransaction.cfm"
		      datasource="#DATASOURCE#"
		      description="Payment Membership Fee (PayPal: #payment_status#  Membership: #get_membership.membership#  Amount: #payment_gross#)"
		      amount="#payment_gross#"
		      user_id="#user_id#">
			
			<cfset payment_email_status = "Your payment has been successfully processed. Transaction id: #txn_id#">
			<cfelse>
				<cfset payment_email_status = "INCOMPLETE: The receiver_email is not site owner business account's email.">
			</cfif>
		
	<cfelse>
		<cfset payment_email_status = "#payment_status#">
	</cfif>

<CFELSEIF #CFHTTP.FileContent# is "INVALID">
	<!--- log for investigation --->
	<cfset payment_email_status = "INVALID: Your payment has not been completed.">
<CFELSE>
	<!--- error --->
	<cfset payment_email_status = "ERROR: Your payment has not been completed.">
</CFIF>

<!--- Send email to payer --->
<cfmail to="#payer_email#" from="customerservices@#domain#" subject="Payment thru PayPal: (item###item_number#)#item_name#">
	#payment_email_status#
	
	Amount: #payment_gross#
	
	Thank you!
	#COMPANY_NAME#
</cfmail>
