<!---
  --- SecurityManager
  --- ------------------
  ---
  --- Manages application security.
  ---
  --- author: bsterner
  --- date:   6/14/14
  --->
<cfcomponent displayname="Security Manager" hint="Manages the security and monitoring around page requests." extends="/CF-INF/cfc/AbstractBaseComponent" accessors="true" output="false" persistent="false">

    <cffunction name="authenticateUser" access="public" returntype="boolean">
        <cfargument name="username" type="string" required="yes" hint="The username used for authentication.">
        <cfargument name="password" type="string" required="yes" hint="The password used for authentication.">
        <cfargument name="successForwardPage" type="string" required="yes" hint="The page to forward the user to if authentication is successful.">
        <cfargument name="failureForwardPage" type="string" required="yes" default="#cgi.http_referer#" hint="The page to forward the user to if authentication is Unsuccessful.  Defaults to the referrer.">
        <cfset var isAuthenticationSuccess = false>
		<cfreturn isAuthenticationSuccess>
	</cffunction>

</cfcomponent>