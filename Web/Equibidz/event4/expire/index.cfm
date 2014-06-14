<!--
  expire/index.cfm
  
  main classified ad expirer script...

  processes ads
    with status active
    and date_end < TIMENOW
  if should expire.. then expires ad..
  sends email..
   
-->

<cftry>
  <!-- include globals -->
  <cfinclude template="../../includes/app_globals.cfm">
  
  <!-- define TIMENOW -->
  <cfmodule template="../../functions/timenow.cfm">
  
  <cfcatch>
    <cfabort>
  </cfcatch>
</cftry>

<!-- get ads -->
<cfquery name="getAds" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT adnum, user_id
      FROM ad_info
     WHERE status = 1
       AND date_end < #TIMENOW#
</cfquery>

<!-- chk ads -->
<cfloop query="getAds">
  
  <!-- chk user account on ad still valid -->
  <cfquery name="chkAccount" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
      SELECT COUNT(user_id) AS found
        FROM users
       WHERE user_id = #getAds.user_id#
  </cfquery>
  
      <!-- set ad inactive -->
    <cfquery name="updAd" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
        UPDATE ad_info
           SET status = 0
         WHERE adnum = #getAds.adnum#
    </cfquery>
  
  <cfif not chkAccount.found><!--- i.e., if account was closed while ad was running --->
    
    <!-- set ad inactive -->
    <cfquery name="updAd" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
        UPDATE ad_info
           SET status = 0
         WHERE adnum = #getAds.adnum#
    </cfquery>
    
    <!-- log ad expired -->
    <cfmodule template="../../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      db_username="#db_username#"
      db_password="#db_password#"
      description="Ad Expired (Invalid User ID)"
      adnum="#getAds.adnum#">
    
    <!-- send email to customer service -->
    <cfmodule template="eml_badaccount.cfm"
      to="#SERVICE_EMAIL##DOMAIN#"
      from="#SERVICE_EMAIL##DOMAIN#"
      subject="Invalid user account - ad #getAds.adnum# now inactive"
      itemnum="#getAds.adnum#"
      user_id="#getAds.user_id#">
  
  <!-- if account still valid continue -->
  <cfelse>
    
    <!-- email advertiser w/ completion notification -->
    <cfmodule template="gen_seller_results.cfm"
      adnum="#getAds.adnum#"
      datasource="#DATASOURCE#"
      db_username="#db_username#"
      db_password="#db_password#"
      timenow="#TIMENOW#"
      fromEmail="#SERVICE_EMAIL##DOMAIN#">
      
 	</cfif>
</cfloop>
