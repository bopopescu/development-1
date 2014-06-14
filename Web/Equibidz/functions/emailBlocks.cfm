<!---
  
  emailBlocks.cfm
  
  utility for adding, removing, checking email/domain blocks & retrieving array of blocked values..
  works with "email_blocks" table..
    new table.. see /functions/dbModEmailBlocks.cfm
    
  INS-DOMAIN || INS-ACCOUNT :
  
  <cfmodule template="emailBlocks.cfm"
    action="[INS-DOMAIN|INS-ACCOUNT]"
    datasource="#DATASOURCE#"
    address="[domain/account to add]"
    retSuccess="[var name to return bool of successfull ins]">
    
  DEL-DOMAIN || DEL-ACCOUNT :
  
  <cfmodule template="emailBlocks.cfm"
    action="[DEL-DOMAIN|DEL-ACCOUNT]"
    datasource="#DATASOURCE#"
    address="[domain/account to del]"
    retSuccess="[var name to return bool of successfull del]">
    
  CHK-DOMAIN || CHK-ACCOUNT :  (returns TRUE if blocked)
  
  <cfmodule template="emailBlocks.cfm"
    action="[CHK-DOMAIN|CHK-ACCOUNT]"
    datasource="#DATASOURCE#"
    address="[domain/account to check]"
    retBlocked="[var name to return bool of blocked domain/account]">
    
  RET-DOMAINS || RET-ACCOUNTS :
  
  <cfmodule template="emailBlocks.cfm"
    action="[RET-DOMAINS|RET-ACCOUNTS]"
    datasource="#DATASOURCE#"
    retArray="[var name of array to return current domains/accounts]">
    
  Author: John Adams
  Date: 1999/08/18
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- def vals --->
<cfset lReqParams = "datasource">      <!--- action not included,, will bypass all functions if no match --->
<cfparam name="Attributes.action" default="NULL">

<cfset sDomBlockFlag = "D">
<cfset sAcntBlockFlag = "A">

<cfset sBlocksTable = "email_blocks">


<!--- if INS-DOMAIN || INS-ACCOUNT --->
<cfif Attributes.action IS "INS-DOMAIN"
  OR Attributes.action IS "INS-ACCOUNT">
  
  <!--- def vals --->
  <cfset lReqParams = ListAppend(lReqParams, "address", ",")>
  <cfset sBlockType = IIf(Attributes.action IS "INS-DOMAIN", "Variables.sDomBlockFlag", "Variables.sAcntBlockFlag")>
  <cfset bSuccess = 0>
  <cfset bRetSuccessFlag = 0>
  
  <cfif IsDefined("Attributes.retSuccess")>
    <cfif Len(Attributes.retSuccess)>
      <cfset bRetSuccessFlag = 1>
    </cfif>
  </cfif>
  
  <!--- chk req params --->
  <cfloop index="e" list="#lReqParams#">
    
    <cfif not IsDefined("Attributes.#e#")>
      
      <cfoutput>
        <br>
        <b>ERROR:</b> #e# attribute of emailBlock not defined.<br>
        <br>
      </cfoutput>
      <cfabort>
    </cfif>
  </cfloop>
  
  <cfset sAddress = Trim(Attributes.address)>
  
  <!--- ins domain --->
  <cfif Len(Variables.sAddress)>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
        INSERT INTO #Variables.sBlocksTable#
        (
          address,
          block_type
        )
        VALUES
        (
          '#Variables.sAddress#',
          '#Variables.sBlockType#'
        )
    </cfquery>
    
    <cfset bSuccess = 1>
    
    <cfoutput>
      <!-- debug >> domain block "#Variables.sAddress#" added successfully -->
    </cfoutput>
  </cfif>
  
  <!--- ret flag if requested --->
  <cfif Variables.bRetSuccessFlag>
    
    <cfset temp = "Caller.#Trim(Attributes.retSuccess)#">
    <cfset "#temp#" = Variables.bSuccess>
  </cfif>
  
  
<!--- if DEL-DOMAIN || DEL-ACCOUNT --->
<cfelseif Attributes.action IS "DEL-DOMAIN"
  OR Attributes.action IS "DEL-ACCOUNT">
  
  <!--- def vals --->
  <cfset lReqParams = ListAppend(lReqParams, "address", ",")>
  <cfset sBlockType = IIf(Attributes.action IS "DEL-DOMAIN", "Variables.sDomBlockFlag", "Variables.sAcntBlockFlag")>
  <cfset bSuccess = 0>
  <cfset bRetSuccessFlag = 0>
  
  <cfif IsDefined("Attributes.retSuccess")>
    <cfif Len(Attributes.retSuccess)>
      <cfset bRetSuccessFlag = 1>
    </cfif>
  </cfif>
  
  <!--- chk req params --->
  <cfloop index="e" list="#lReqParams#">
    
    <cfif not IsDefined("Attributes.#e#")>
      
      <cfoutput>
        <br>
        <b>ERROR:</b> #e# attribute of emailBlock not defined.<br>
        <br>
      </cfoutput>
      <cfabort>
    </cfif>
  </cfloop>
  
  <cfset sAddress = Trim(Attributes.address)>
  
  <!--- del domain --->
  <cfif Len(Variables.sAddress)>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
        DELETE
          FROM #Variables.sBlocksTable#
         WHERE address = '#Variables.sAddress#'
           AND block_type = '#Variables.sBlockType#'
    </cfquery>
    
    <cfset bSuccess = 1>
    
    <cfoutput>
      <!-- debug >> domain block "#Variables.sAddress#" deleted successfully -->
    </cfoutput>
  </cfif>
  
  <!--- ret flag if requested --->
  <cfif Variables.bRetSuccessFlag>
    
    <cfset temp = "Caller.#Trim(Attributes.retSuccess)#">
    <cfset "#temp#" = Variables.bSuccess>
  </cfif>
  
  
<!--- if CHK-DOMAIN || CHK-ACCOUNT --->
<cfelseif Attributes.action IS "CHK-DOMAIN"
  OR Attributes.action IS "CHK-ACCOUNT">
  
  <!--- def vals --->
  <cfset lReqParams = ListAppend(lReqParams, "address,retBlocked", ",")>
  <cfset bBlocked = 0>
  <cfset sBlockType = IIf(Attributes.action IS "CHK-DOMAIN", "Variables.sDomBlockFlag", "Variables.sAcntBlockFlag")>
  <cfset sComparison = IIf(Attributes.action IS "CHK-DOMAIN", DE("LIKE"), DE("="))>
  
  <!--- chk req params --->
  <cfloop index="e" list="#lReqParams#">
    
    <cfif not IsDefined("Attributes.#e#")>
      
      <cfoutput>
        <br>
        <b>ERROR:</b> #e# attribute of emailBlock not defined.<br>
        <br>
      </cfoutput>
      <cfabort>
    </cfif>
  </cfloop>
  
  <cfset sAddress = Trim(Attributes.address)>
  
  <!--- if domain chk, remove everything except domain --->
  <cfif Attributes.action IS "CHK-DOMAIN">
    
    <cfset sAddress = REReplace(sAddress, ".*@", "", "ALL")>
  </cfif>
  
  <!--- chk if blocked --->
  <cfquery username="#db_username#" password="#db_password#" name="chkBlocked" datasource="#Attributes.datasource#">
      SELECT COUNT(address) AS found
        FROM #Variables.sBlocksTable#
       WHERE address #Variables.sComparison# '#Variables.sAddress#'
         AND block_type = '#Variables.sBlockType#'
  </cfquery>
  
  <!--- def blocked --->
  <cfif chkBlocked.found>
    <cfset bBlocked = 1>
  </cfif>
  
  <!--- ret bool val --->
  <cfset temp = "Caller.#Trim(Attributes.retBlocked)#">
  <cfset "#temp#" = Variables.bBlocked>
  
  
<!--- if RET-DOMAINS || RET-ACCOUNTS --->
<cfelseif Attributes.action IS "RET-DOMAINS"
  OR Attributes.action IS "RET-ACCOUNTS">
  
  <!--- def vals --->
  <cfset lReqParams = ListAppend(lReqParams, "retArray", ",")>
  <cfset aBlocks = ArrayNew(1)>
  <cfset sBlockType = IIf(Attributes.action IS "RET-DOMAINS", "Variables.sDomBlockFlag", "Variables.sAcntBlockFlag")>
  
  <!--- chk req params --->
  <cfloop index="e" list="#lReqParams#">
    
    <cfif not IsDefined("Attributes.#e#")>
      
      <cfoutput>
        <br>
        <b>ERROR:</b> #e# attribute of emailBlock not defined.<br>
        <br>
      </cfoutput>
      <cfabort>
    </cfif>
  </cfloop>
  
  <cfset sRetArray = Attributes.retArray>
  
  <!--- chk len of ret array name --->
  <cfif not Len(Variables.sRetArray)>
    
    <cfoutput>
      <br>
      <b>ERROR:</b> emailBlock does not except 0 length values for variable names.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
  
  <!--- get domain blocks --->
  <cfquery username="#db_username#" password="#db_password#" name="getDomBlocks" datasource="#Attributes.datasource#">
      SELECT address
        FROM #Variables.sBlocksTable#
       WHERE block_type = '#Variables.sBlockType#'
  </cfquery>
  
  <!--- convert query to array --->
  <cfloop query="getDomBlocks">
    
    <cfset aBlocks[getDomBlocks.CurrentRow] = Trim(getDomBlocks.address)>
  </cfloop>
  
  <!--- ret array --->
  <cfset temp = "Caller.#Trim(Variables.sRetArray)#">
  <cfset "#temp#" = aBlocks>
  
  
</cfif>

<cfsetting enablecfoutputonly="No">
