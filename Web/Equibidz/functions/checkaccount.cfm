<!---
  checkaccount.cfm
  
  module for checking a users account
  
  verifies provided login and password against:
    nickname and password
    and/or
    user_id and password
  returns validity in statusReturn var
  will return actual user ID and password in:
    useridReturn var
    and
    passwordReturn var
    if defined
  
  <cfmodule template="../functions/checkaccount.cfm"
    datasource="[system DSN]"
    login="[provided login]"
    password="[provided password]"
    statusReturn="[return var for valid|invalid]"
    [useridReturn="[return var for userID]"]
    [passwordReturn="return var for password"]>
    
--->
<cfsetting enablecfoutputonly="YES">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<cfloop index="l" list="datasource,login,password,statusReturn">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <br>
      <B>ERROR:</b> Must provide #l# attribute for checkaccount.cfm.<br>
      <br>
    </cfoutput>
  </cfif>
</cfloop>

<!--- chk info against db --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getAccount" datasource="#Attributes.datasource#">
      SELECT user_id, password
        FROM users
       WHERE password = '#Trim(Attributes.password)#'
      <cfif IsNumeric(Trim(Attributes.login))>
         AND (nickname = '#Trim(Attributes.login)#'
              OR user_id = #Trim(Attributes.login)#)
      <cfelse>
         AND nickname = '#Trim(Attributes.login)#'
      </cfif>
         AND is_active = 1
         AND last_login_date > #CreateODBCDateTime("12/31/1969 00:00:00")#
  </cfquery>
  
  <cfif getAccount.RecordCount>
    <cfset tempStatus = 1>
    <cfset tempUserId = getAccount.user_id>
    <cfset tempPassword = Trim(getAccount.password)>
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cfset tempStatus = 0>
  </cfcatch>
</cftry>

<!--- return values to Caller --->
<cfset tempVar = "Caller." & Attributes.statusReturn>
<cfset "#tempVar#" = tempStatus>

<cfif tempStatus>
  <cfif IsDefined("Attributes.useridReturn")>
    <cfset tempVar = "Caller." & Attributes.useridReturn>
    <cfset "#tempVar#" = tempUserId>
  </cfif>
  <cfif IsDefined("Attributes.passwordReturn")>
    <cfset tempVar = "Caller." & Attributes.passwordReturn>
    <cfset "#tempVar#" = tempPassword>
  </cfif>
</cfif>

<cfsetting enablecfoutputonly="NO">
