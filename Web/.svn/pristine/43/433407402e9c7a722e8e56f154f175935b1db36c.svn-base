<!---
  
  PairLoginPass.cfm
  
  module for checking and setting pairing of login and password boolean on site..
    (if software should display login and password together)
    
  Usage:
  
  <cfmodule template="PairLoginPass.cfm"
    [sAction="[SET]"]
    [bNewVal="[1|0 new val to set flag to]"]>
    
  Interface:
    sAction = SET      ;note.. will always return vals regarless of action
    bNewVal = (1|0)      ;bool (new val you want to set flag to)
    
  Implementation:
    sAction = ChkFlagExist      ;sub routine action
    [bSub="[1|0]"]      ;bool (true = running sub routine)
  
  Structure returned: hPairLoginPass
  
  Keys:
    .bPair      ;bool (true if password should be displayed with login)
    .aErrors      ;array (errors experienced will processing)
    
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- def vals --->
<cfparam name="Attributes.sAction" default="">
<cfset bRunSub = 0>

<cfset bDefPairLogin = 0>
<cfset sFlagName = "PairLoginPass">

<!--- init globals --->
<cfmodule template="../includes/app_globals.cfm"
  sStructName="hAppGlobals">
  
<!--- def if running sub --->
<cfif IsDefined("Attributes.bSub")>
  <cfif IsBoolean(Attributes.bSub)>
    <cfif Attributes.bSub>
      
      <cfset bRunSub = 1>
    </cfif>
  </cfif>
</cfif>

<!--- if sub routine --->
<cfif Variables.bRunSub>
  
  <!--- chk flag defined --->
  <cfif Attributes.sAction IS "ChkFlagExist">
    
    <!--- get current flag --->
    <cfquery username="#db_username#" password="#db_password#" name="chkExist" datasource="#hAppGlobals.DATASOURCE#">
        SELECT pair
          FROM defaults
         WHERE name = '#Variables.sFlagName#'
    </cfquery>
    
    <!--- if doesn't exist set to default --->
    <cfif not chkExist.RecordCount>
      
      <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
          INSERT INTO defaults
            (name, pair)
          VALUES
            ('#Variables.sFlagName#', '#Variables.bDefPairLogin#')
      </cfquery>
      
    <!--- else if not bool set to default --->
    <cfelseif not IsBoolean(chkExist.pair)>
      
      <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
          UPDATE defaults
             SET pair = '#Variables.bDefPairLogin#'
           WHERE name = '#Variables.sFlagName#'
      </cfquery>
      
    </cfif>
  </cfif>
  
<!--- else if calling action --->
<cfelse>
  
  <!--- def vals --->
  <cfset hTempStruct = StructNew()>
  <cfset temp = StructInsert(hTempStruct, "bPair", Variables.bDefPairLogin)>
  <cfset temp = StructInsert(hTempStruct, "aErrors", ArrayNew(1))>
  
  <!--- chk flag exist --->
  <cfmodule template="PairLoginPass.cfm"
    sAction="ChkFlagExist"
    bSub="1">
  
  <!--- if SET value --->
  <cfif Attributes.sAction IS "SET">
    
    <!--- chk given val --->
    <cfif not IsDefined("Attributes.bNewVal")>
      
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "New value not defined.  Can't reset #Variables.sFlagName# flag.")>
      
    <!--- chk val is bool --->
    <cfelseif not IsBoolean(Attributes.bNewVal)>
      
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "New value not boolean.  Can't reset #Variables.sFlagName# flag.")>
      
    <!--- else set val --->
    <cfelse>
      
      <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
          UPDATE defaults
             SET pair = '#Trim(Attributes.bNewVal)#'
           WHERE name = '#Variables.sFlagName#'
      </cfquery>
    </cfif>
  </cfif>
  
  <!--- get current val --->
  <cfquery username="#db_username#" password="#db_password#" name="getVal" datasource="#hAppGlobals.DATASOURCE#">
      SELECT pair
        FROM defaults
       WHERE name = '#Variables.sFlagName#'
  </cfquery>
  
  <cfset temp = StructUpdate(hTempStruct, "bPair", Trim(getVal.pair))>
  
  <!--- rtn vals to Caller --->
  <cfset Caller.hPairLoginPass = hTempStruct>
  
</cfif>

<cfsetting enablecfoutputonly="No">
