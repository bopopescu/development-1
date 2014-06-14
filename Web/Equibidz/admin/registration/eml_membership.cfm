<!---
  eml_thankyou.cfm
  
  email file
  used by thankyou.cfm
  
  <cfmodule template="eml_thankyou.cfm"
    from="[from address]"
    to="[to address]"
    subject="[subject line]"
    attachment="[attachment file]"
    user_fname="[user's first name]"
    domain="[GLOBAL #DOMAIN#]"
    password="[user's password]"
    company_name="[GLOBAL #COMPANY_NAME#]">
    
--->

<!--- inc app_globals --->
<cfinclude template="../includes/app_globals.cfm">
<!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">


<!--- Run a query to find membership status  --->
 <cfquery username="#db_username#" password="#db_password#" name="get_membership_status" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'membership_sta'
    ORDER BY pair
 </cfquery>

<!--- Get their name again --->
 <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
  SELECT name, nickname, email, membership, membership_exp, membership_status
    FROM users
   WHERE user_id = #Attributes.user_id#
 </cfquery>
 
 <!--- get currency type --->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
   SELECT pair AS type
     FROM defaults
    WHERE name = 'site_currency'
</cfquery>

<!--- Send them an e-mail --->
<cfmail to="#get_user_info.email#"
  from="customer_service@#domain#"
  subject="New Membership (#get_user_info.nickname#)" type="HTML">
  
Dear #get_user_info.name# (#get_user_info.nickname#),<br><br>
<cfif get_membership_status.pair eq 1>
	<cfif get_user_info.membership neq "">
		<cfset membership_fee = listgetat(get_user_info.membership,1,"_")>
		<cfset membership_pct = listgetat(get_user_info.membership,2,"_")>
		<cfset membership_name = listgetat(get_user_info.membership,3,"_")>
		<cfset membership_cycle = listgetat(get_user_info.membership,4,"_")>
		Thank you for joining our membership: #membership_name# membership entitles you to a #membership_pct#% discount on all auction fees, a #membership_fee# #getCurrency.type# fee <cfif isdefined("Attributes.paid") and Attributes.paid eq 0>is needed to be paid in order to activate<cfelse>has been charged for</cfif> your #membership_cycle# membership<br>
		Your membership status is <cfif get_user_info.membership_status eq 1>active<cfelse>inactive<br>(Please send a check to company address or <cfif isdefined("Attributes.paid") and Attributes.paid eq 0><cfif isdefined("paypal") and paypal eq "yes">click on the PayPal logo below to pay)<br>
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input type="hidden" name="return" value="#paypal_return#"><input type="hidden" name="cancel_return" value="#paypal_cancel_return#"><input type="hidden" name="notify_url" value="#paypal_notify_url_membership#"><input type="hidden" name="cmd" value="_xclick"><input type="hidden" name="business" value="#paypal_business_acct#"><input type="hidden" name="item_name" value="#Attributes.title#"><input type="hidden" name="item_number" value="#Attributes.itemnum#"><input type="hidden" name="amount" value="#numberformat(Attributes.invSubTotal, numbermask)#"><input type="hidden" name="custom" value="#Attributes.user_id#"><input type="image" src="#paypal_bttn#" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!"></form>
		</cfif></cfif></cfif>
		<cfif get_user_info.membership_status eq 1><cfif membership_cycle neq "OneTime">Your membership duration: #dateformat(timenow,"mm/dd/yyyy")# to #dateformat(get_user_info.membership_exp,"mm/dd/yyyy")#</cfif></cfif><br><br>
	</cfif>
</cfif>
			  
Thank you<br>
#company_name#


</cfmail>
