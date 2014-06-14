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
<!--- check attributes exist --->
<cfloop index="l" list="from,to,subject,attachment,user_fname,domain,password,company_name">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</b> #l# attribute of eml_thankyou.cfm not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- Run a query to find membership status  --->
 <cfquery username="#db_username#" password="#db_password#" name="get_membership_status" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'membership_sta'
    ORDER BY pair
 </cfquery>

<!--- Get their name again --->
 <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
  SELECT membership,
		 membership_exp
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
<cfmail to="#Attributes.to#"
  from="#Attributes.from#"
  subject="#Attributes.subject#">
  
Congratulations #Attributes.user_fname#!

To complete the registration please click the link below to confirm:
http://#cgi.server_name##VAROOT#/registration/activation.cfm?user_id=#Attributes.user_id#
(Note: If this link doesn't work, then copy and paste the link into your Web browser and hit enter.)
  
This e-mail message has been sent to you with the password you entered, 
in case you forget it. 
<cfif get_membership_status.pair eq 1>
	<cfif get_user_info.membership neq "">
		<cfset membership_fee = listgetat(get_user_info.membership,1,"_")>
		<cfset membership_pct = listgetat(get_user_info.membership,2,"_")>
		<cfset membership_name = listgetat(get_user_info.membership,3,"_")>
		<cfset membership_cycle = listgetat(get_user_info.membership,4,"_")>
		Thank you for joining our membership: #membership_name# membership entitles you to a #membership_pct#% discount on all auction fees, a #membership_fee# #getCurrency.type# fee has been charged for your #membership_cycle# membership
		<cfif membership_cycle neq "OneTime">Your membership duration: #dateformat(timenow,"mm/dd/yyyy")# to #dateformat(get_user_info.membership_exp,"mm/dd/yyyy")#</cfif>
	</cfif>
</cfif>
Here is the password you chose in case you forget it:		  
<!--- Your nickname: #Attributes.nickname# --->
#Attributes.password#

Thank you for registering with us!
#Attributes.company_name#


</cfmail>
