<!---
  
  iescrow.cfm
  
  module for working with IEscrow information..
  
  Interface:
    ChkStatus
    
  Implementation:
    ChkFlagExist
    
  Author: John Adams
  Date: 1999/08/25
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- def vals --->
<cfparam name="Attributes.sOpt" default="">

<cfset sFlagName = "enable_iescrow">      <!--- flag used in defaults for IEscrow enabled/disabled --->


<!--- if sOpt IS "ChkStatus" --->
<!------------------------------>
<cfif Attributes.sOpt IS "ChkStatus">
  
  <!---
    
    Usage:
    
    <cfmodule template="iescrow.cfm"
      sOpt="ChkStatus">
      
    Returns structure "hIEscrow."
    
    Keys returned:
      ##.bEnabled      ;is IEscrow enabled in admin
      
  --->
  
  <!--- def vals --->
  <cfset hTmpStruct = StructNew()>
  
  <!--- init app_globals --->
  <cfmodule template="../includes/app_globals.cfm"
    sStructName="hAppGlobals">
  
  <!--- chk flag exist --->
  <cfmodule template="iescrow.cfm"
    sOpt="ChkFlagExist">
    
  <!--- get flag val --->
  <cfquery username="#db_username#" password="#db_password#" name="getFlag" datasource="#hAppGlobals.DATASOURCE#">
      SELECT pair
        FROM defaults
       WHERE name = '#Variables.sFlagName#'
  </cfquery>
  
  <!--- set val in struct --->
  <cfset temp = StructInsert(hTmpStruct, "bEnabled", Trim(getFlag.pair))>
  
  <!--- return val to caller --->
  <cfset Caller.hIEscrow = hTmpStruct>
  
  
<!--- if sOpt IS "ChkFlagExist" --->
<!--------------------------------->
<cfelseif Attributes.sOpt IS "ChkFlagExist">
  
  <!---
    
    Checks IEscrow enabled/disabled flag exists and is boolean.
    
    Usage:
    
    <cfmodule template="iescrow.cfm"
      sOpt="ChkFlagExist">
      
    Returns structure "hIEscrow."
    
    Keys returned:
      ##.bPreExist      ;did flag previously exist
      ##.bWasBool      ;was previously boolean
      
  --->
  
  <!--- def vals --->
  <cfset bDefFlagVal = 0>      <!--- default enabled/disabled value for IEscrow --->
  
  <cfset hTmpStruct = StructNew()>
  <cfset temp = StructInsert(hTmpStruct, "bPreExist", "0")>
  <cfset temp = StructInsert(hTmpStruct, "bWasBool", "0")>
  
  <!--- init app_globals --->
  <cfmodule template="../includes/app_globals.cfm"
    sStructName="hAppGlobals">
  
  <!--- chk if exist in "defaults" --->
  <cfquery username="#db_username#" password="#db_password#" name="chkFlag" datasource="#hAppGlobals.DATASOURCE#">
      SELECT pair
        FROM defaults
       WHERE name = '#Variables.sFlagName#'
  </cfquery>
  
  <!--- update vals --->
  <cfif chkFlag.RecordCount>
    
    <!--- set bPreExist true --->
    <cfset temp = StructUpdate(hTmpStruct, "bPreExist", "1")>
    
    <cfif IsBoolean(chkFlag.pair)>
      
      <!--- set bWasBool true --->
      <cfset temp = StructUpdate(hTmpStruct, "bWasBool", "1")>
    </cfif>
  </cfif>
  
  <!--- if didn't exist, create --->
  <cfif not hTmpStruct.bPreExist>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
        INSERT INTO defaults
          (name, pair)
        VALUES
          ('#Variables.sFlagName#', '#Variables.bDefFlagVal#')
    </cfquery>
  </cfif>
  
  <!--- if existed but wasn't bool, update --->
  <cfif hTmpStruct.bPreExist
    AND not hTmpStruct.bWasBool>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
        UPDATE defaults
           SET pair = '#Variables.bDefFlagVal#'
         WHERE name = '#Variables.sFlagName#'
    </cfquery>
  </cfif>
  
  <!--- return to caller --->
  <cfset Caller.hIEscrow = hTmpStruct>
  
</cfif>

<cfsetting enablecfoutputonly="No">
