<!---
  /personal/chkTableStruct1.cfm
  
  verifies the structure of the "futurewatch" table is correct..
  makes use of cf_AlterTable.cfm..
  
  <cfmodule template="chkTableStruct1.cfm"
    datasource="[system DSN]">
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- chk attribs exist --->
<cfloop index="l" list="datasource">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <br>
      <b>ERROR:</b> #l# attribute of chkTableStruct1 not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def values --->
<cfset datasource = Attributes.datasource>
<cfset tableName = "futurewatch">
<cfset reqFields = "user_id,keywords,enabled,last_sent">
<cfset reqTypes = "INT,TEXT(255),BIT,INT">
<cfset reqLimitNull = "NOT NULL,NULL,NOT NULL,NOT NULL">
<cfset reqFieldDefs = "0,'',0,0">
<cfset dropExtraFields = 1>
<cfset HashIndexName = "chkTableFutureW">       <!--- max 15 chars --->
<cfset chkStructure = 1>

<!--- chk if flag exist in defaults table --->
<cfloop index="i" from=1 to=2>
  <cfquery username="#db_username#" password="#db_password#" name="chkFlag" datasource="#Variables.datasource#">
      SELECT pair AS flag
        FROM defaults
       WHERE name = '#HashIndexName#'
  </cfquery>

  <!--- if flag doesn't exist create --->
  <cfif not chkFlag.RecordCount>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#Variables.datasource#">
        INSERT INTO defaults
          (name, pair)
        VALUES
          ('#HashIndexName#', '1')
    </cfquery>
    
    <cfoutput>
      <!-- debug >> Inserting Into "default": #HashIndexName# = 1 -->
    </cfoutput>
  <cfelse>
    
    <cfbreak>
  </cfif>
</cfloop>

<!--- chk flag is bool --->
<cfif not IsBoolean(chkFlag.flag)>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#Variables.datasource#">
      UPDATE defaults
         SET pair = 1
       WHERE name = '#HashIndexName#'
  </cfquery>
  
  <cfoutput>
    <!-- debug >> Updating "#HashIndexName#" value to boolean -->
  </cfoutput>
<cfelse>
  
  <cfset chkStructure = chkFlag.flag>
  
  <cfoutput>
    <!-- debug >> Check Table Structure: #chkStructure# -->
  </cfoutput>
</cfif>

<!--- call cf_AlterTable --->
<cfif chkStructure>
  <cfmodule template="../functions/cf_AlterTable.cfm"
    datasource="#Variables.datasource#"
    table="#Variables.tableName#"
    reqFields="#Variables.reqFields#"
    reqTypes="#Variables.reqTypes#"
    reqLimitNull="#Variables.reqLimitNull#"
    reqFieldDefs="#Variables.reqFieldDefs#"
    delExtras="#Variables.dropExtraFields#">
    
  <cfoutput>
    <!-- debug >> Completed structure check -->
  </cfoutput>
  
  <!--- set flag to false --->
  <cfquery username="#db_username#" password="#db_password#" datasource="#Variables.datasource#">
      UPDATE defaults
         SET pair = 0
       WHERE name = '#HashIndexName#'
  </cfquery>
  
  <cfoutput>
    <!-- debug >> Set "#HashIndexName#" value false -->
  </cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">
