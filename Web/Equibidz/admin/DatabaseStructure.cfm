<CFOUTPUT>
<FONT FACE=ARIAL><B>MS SQL DATABASE STRUCTURE</B></FONT><BR><BR>
</CFOUTPUT>

<cfinclude template="../includes/app_globals.cfm">
<cfset x = 0>

<cfquery name="get_tables" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT name
  FROM sysobjects
 WHERE type = 'u'
</cfquery>

<cfoutput query="get_tables"> 
<CFSET x = x + 1>
<CFSET TableName[x] = #name#>
<!--- OUTPUT TABLE NAME: <B>#name#</B><br> --->
</cfoutput>

<FONT FACE=ARIAL SIZE=1>
<cfset y = 1>
<cfloop index="i" from="1" to="#ArrayLen(TableName)#">
<cfquery name="get_columns" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT * 
FROM #TableName[y]#
</cfquery>
<cfOutput><B>#TableName[y]#</B><br>#get_columns.ColumnList#<br></cfOutput>
<br>
<cfset y = y + 1>
</cfloop>
</FONT>
