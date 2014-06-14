<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfinclude template="../includes/app_globals.cfm">
<cfquery name="get_categories" datasource="#DATASOURCE#" dbtype="ODBC">SELECT category, name 
FROM categories
WHERE active = 1
AND allow_sales = 1
group by parent
</cfquery>


<cfset #curPath# = GetTemplatePath()>
<cfset curPath = Replace(#curPath#,"options.cfm","")>
<cffile action="write"
FILE="#curPath#options.txt"
OUTPUT="">

  <cfloop query="get_categories">
<cffile action="append"
FILE="#curPath#options.txt"
OUTPUT="<option value=""#category#"">#name#</option>">
</cfloop>





<html>
<head>
	<title>Untitled</title>
</head>

<body>



</body>
</html>
