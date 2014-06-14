<!---
  cf_AlterTable.cfm
  
  module for altering the structure of a database table..
  
  checks reqFields list against fields found in table..
  if a reqField is not found will create column w/ given info..
    [- problem: requires SELECT * to determine columns, 
       don't recommend running every hit.
       ..and can't determine field type of existing column,
       if name matches leaves alone.]
  
  will drop any additional columns not in reqFields if specified in delExtras..
    [- problem: requires dropping any indexes on column]
    
  <cfmodule template="cf_AlterTable.cfm"
    datasource="[system DSN]"
    table="[db table name]"
    reqFields="[comma delim list of desired fields]"
    reqTypes="[comma delim list of desired field types]"
    reqLimitNull="[comma delim list of null limits on desired fields]"
    reqFieldDefs="[comma delim list of def values for desired fields, w | w/o single quotes]"
    delExtras="[bool val, should drop extra columns found? opt., defs to false]">
      
  Author: John Adams
  Date: 07/07/1999
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- def values --->
<cfparam name="Attributes.delExtras" default="0">

<!--- chk Attributes exist --->
<cfloop index="l" list="datasource,table,reqFields,reqTypes,reqLimitNull,reqFieldDefs,delExtras">
  <cfif not IsDefined("Attributes." & l)>
    
    <cfoutput><!-- debug >> ERROR: #l# attribute of cf_AlterTable not defined. --></cfoutput>
    <cfabort>
    
  </cfif>
</cfloop>

<!--- chk ListLen matches on req* attributes --->
<cfif ListLen(Attributes.reqFields, ",") IS NOT ListLen(Attributes.reqTypes, ",")
  OR ListLen(Attributes.reqFields, ",") IS NOT ListLen(Attributes.reqLimitNull, ",")
  OR ListLen(Attributes.reqFields, ",") IS NOT ListLen(Attributes.reqFieldDefs, ",")>
  
  <cfoutput><!-- debug >> ERROR: List length mismatch in required parameter of cf_AlterTable. --></cfoutput>
  <cfabort>
  
</cfif>

<!--- chk given datasource & table valid --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getColumns" datasource="#Attributes.datasource#">
      SELECT *
        FROM #Attributes.table#
  </cfquery>
  
  <cfset isValidDsnTable = 1>
  
  <cfcatch>
    
    <cfoutput><!-- debug >> ERROR: Invalid system DSN and/or table name in cf_AlterTable. --></cfoutput>
    <cfabort>
    
  </cfcatch>
</cftry>

<!--- def values --->
<cfset iNumReqColumns = ListLen(Attributes.reqFields, ",")>
<cfset iNumExistColumns = ListLen(getColumns.ColumnList, ",")>
<cfset aFieldsToAdd = ArrayNew(2)>
<cfset aFieldsToRemove = ArrayNew(2)>
<cfset iArrayPosition = 1>

<!--- determine required fields not existing --->
<cfloop index="i" from=1 to=#iNumReqColumns#>
  
  <cfif not ListContainsNoCase(getColumns.ColumnList, ListGetAt(Attributes.reqFields, i, ","), ",")>
    
    <cfset aFieldsToAdd[iArrayPosition][1] = ListGetAt(Attributes.reqFields, i, ",")>
    <cfset aFieldsToAdd[iArrayPosition][2] = i>
    <cfset iArrayPosition = iArrayPosition + 1>
  </cfif>
</cfloop>

<!--- reset place holder --->
<cfset iArrayPosition = 1>

<!--- determine existing fields not required --->
<cfloop index="i" from=1 to=#iNumExistColumns#>
  
  <cfif not ListContainsNoCase(Attributes.reqFields, ListGetAt(getColumns.ColumnList, i, ","), ",")>
    
    <cfset aFieldsToRemove[iArrayPosition][1] = ListGetAt(getColumns.ColumnList, i, ",")>
    <cfset iArrayPosition = iArrayPosition + 1>
  </cfif>
</cfloop>

<!--- add required fields that don't exist & default value --->
<cfif ArrayLen(aFieldsToAdd)>
  
  <cfloop index="i" from=1 to=#ArrayLen(aFieldsToAdd)#>
    
    <!--- add column --->
    <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
        ALTER TABLE #Attributes.table#
        ADD #aFieldsToAdd[i][1]# #ListGetAt(Attributes.reqTypes, aFieldsToAdd[i][2], ",")# #ListGetAt(Attributes.reqLimitNull, aFieldsToAdd[i][2], ",")# DEFAULT #ListGetAt(Attributes.reqFieldDefs, aFieldsToAdd[i][2], ",")#
    </cfquery>
    
    <cfoutput>
      <!-- debug >> Field Added: #aFieldsToAdd[i][1]# -->
    </cfoutput>
    
    <!--- set default value for column --->
    <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
        UPDATE #Attributes.table#
           SET #aFieldsToAdd[i][1]# = #ListGetAt(Attributes.reqFieldDefs, aFieldsToAdd[i][2], ",")#
    </cfquery>
    
    <cfoutput>
      <!-- debug >> Column set to: #ListGetAt(Attributes.reqFieldDefs, aFieldsToAdd[i][2], ",")# -->
    </cfoutput>
  </cfloop>
</cfif>

<!--- if desired, remove existing fields that aren't required --->
<cfif Attributes.delExtras AND ArrayLen(aFieldsToRemove)>
  
  <cfloop index="i" from=1 to=#ArrayLen(aFieldsToRemove)#>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
        ALTER TABLE #Attributes.table#
        DROP COLUMN #aFieldsToRemove[i][1]#
    </cfquery>
    
    <cfoutput>
      <!-- debug >> Field Dropped: #aFieldsToRemove[i][1]# -->
    </cfoutput>
  </cfloop>
</cfif>

<cfsetting enablecfoutputonly="No">
