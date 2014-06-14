<!---
  
  SetOrdinal.cfm
  
  returns what ordinal suffix should be from given number..
  
  Usage:
  
  <cfmodule template="SetOrdinal.cfm"
    iNumber="[number to def ordinal for]">
    
  Structure returned: hSetOrdinal
  
  Keys:
    .sOrdinal      ;string (ordinal value being returned)
    .aErrors      ;array (any errors encountered will processing module)
  
  Author: John Adams
  Date: 1999/09/02
  
--->
<cfsetting enablecfoutputonly="Yes">

<!--- chk req params --->
<cfloop index="e" list="iNumber">
  
  <cfif not IsDefined("Attributes.#e#")>
    
    <cfoutput>
      <br>
      <b>ERROR:</b> "#e#" attribute of SetOrdinal not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def vals --->
<cfset hTempStruct = StructNew()>
<cfset temp = StructInsert(hTempStruct, "sOrdinal", "")>
<cfset temp = StructInsert(hTempStruct, "aErrors", ArrayNew(1))>

<!--- if numeric val continue --->
<cfif IsNumeric(Attributes.iNumber)>
  
  <!--- def ordinal --->
  <cfif REFind("([^1]|^)1$", Trim(Attributes.iNumber), 1)>
    
    <cfset temp = StructUpdate(hTempStruct, "sOrdinal", "st")>
    
  <cfelseif REFind("([^1]|^)2$", Trim(Attributes.iNumber), 1)>
    
    <cfset temp = StructUpdate(hTempStruct, "sOrdinal", "nd")>
    
  <cfelseif REFind("([^1]|^)3$", Trim(Attributes.iNumber), 1)>
    
    <cfset temp = StructUpdate(hTempStruct, "sOrdinal", "rd")>
    
  <cfelse>
    <cfset temp = StructUpdate(hTempStruct, "sOrdinal", "th")>
  </cfif>
  
<!--- else add error --->
<cfelse>
  <cfset temp = ArrayAppend(hTempStruct.aErrors, "Given value is not numeric.")>
</cfif>

<!--- rtn vals to caller --->
<cfset Caller.hSetOrdinal = hTempStruct>

<cfsetting enablecfoutputonly="No">