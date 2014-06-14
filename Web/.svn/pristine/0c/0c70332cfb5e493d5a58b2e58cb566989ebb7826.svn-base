<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/validate_include.cfm $ $Revision: 3 $ $Date: 1/27/00 8:40p $ $Author: Davidh1 $ --->

<!--- Enable session tracking --->
<cfset #mins_until_timeout# = 20>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#" setclientcookies="yes">

<!--- Check for missing session variables --->
<cfif (#isDefined ("session.username")# is 0) or (#isDefined ("session.password")# is 0)>
 <cflocation url="#VAROOT#/admin/login.cfm?failed=2">
</cfif>

<!--- Check for correct username and password --->
<cfquery username="#db_username#" password="#db_password#" name="check_password" datasource="#DATASOURCE#">
 SELECT name,
        sec_level, login
   FROM administrators
  WHERE login = '#session.username#'
    AND password = '#session.password#'
    AND is_active = 1
</cfquery>

<!--- If it failed, let them know about it --->

 <cfif (#check_password.recordcount# is 0) or (#check_password.sec_level# LT 10)>
  <cflocation url="#VAROOT#/admin/login.cfm?failed=2">
 </cfif>

