<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfinclude template="../../includes/app_globals.cfm">

<cfinclude template="../../includes/session_include.cfm">

<cflock timeout="30" name="#session.sessionid#" type="exclusive">
	<cfset structdelete(session, "defaultlist")>
	<cfcookie name="user_id" expires="NOW">
		
		<cflocation url="#VAROOT#/index.cfm?flushcache=1">

</cflock>

<!--- <cflock timeout="30" name="#session.sessionid#" type="readonly">
	<cfloop collection=#session# item="y">
		<cfoutput>key=#y# (value=#session[y]#)<br></cfoutput>
	</cfloop>
</cflock> --->
</body>
</html>
