
<!--- enable Session state management --->
<cfset mins_until_timeout = 60>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">

