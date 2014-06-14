

<!--- SCHEDULED TASKS --->
<cfschedule 
    action = "update"
    task = "event1"
    interval = "600"
    operation = "HTTPRequest"
    startDate = "1/1/01"
    startTime = "00:00:00"
    requestTimeOut = "600"
    url = "http://www.equibidz.com/event1/event.cfm" >

<cfschedule 
    action = "update"
    task = "event2"
    interval = "600"
    operation = "HTTPRequest"
    startDate = "1/1/01"
    startTime = "00:05:00"
    requestTimeOut = "600"
    url = "http://www.equibidz.com/event2/event.cfm" >

<cfschedule 
    action = "update"
    task = "event5"
    interval = "7200"
    operation = "HTTPRequest"
    startDate = "1/1/01"
    startTime = "00:05:00"
    requestTimeOut = "600"
    url = "http://www.equibidz.com/event5/event.cfm" >

<!--- Security --->
<cfif cgi.SCRIPT_NAME contains "exec" OR cgi.PATH_INFO contains "exec" OR cgi.QUERY_STRING contains "exec"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "eval" OR cgi.PATH_INFO contains "eval" OR cgi.QUERY_STRING contains "eval"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "concat" OR cgi.PATH_INFO contains "concat" OR cgi.QUERY_STRING contains "concat"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "select" OR cgi.PATH_INFO contains "select" OR cgi.QUERY_STRING contains "select"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "union" OR cgi.PATH_INFO contains "union" OR cgi.QUERY_STRING contains "union"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "delete" OR cgi.PATH_INFO contains "delete" OR cgi.QUERY_STRING contains "delete"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "insert" OR cgi.PATH_INFO contains "insert" OR cgi.QUERY_STRING contains "insert"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "join" OR cgi.PATH_INFO contains "join" OR cgi.QUERY_STRING contains "join"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "cast" OR cgi.PATH_INFO contains "cast" OR cgi.QUERY_STRING contains "cast"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "iframe" OR cgi.PATH_INFO contains "iframe" OR cgi.QUERY_STRING contains "iframe"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "%22" OR cgi.PATH_INFO contains "%22" OR cgi.QUERY_STRING contains "%22"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "%3C" OR cgi.PATH_INFO contains "%3C" OR cgi.QUERY_STRING contains "%3C"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "%3E" OR cgi.PATH_INFO contains "%3E" OR cgi.QUERY_STRING contains "%3E"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "cscript" OR cgi.PATH_INFO contains "cscript" OR cgi.QUERY_STRING contains "cscript"><cfabort></cfif>
<cfif cgi.SCRIPT_NAME contains "script" OR cgi.PATH_INFO contains "script" OR cgi.QUERY_STRING contains "script"><cfabort></cfif>
