<!---
findrootdir.cfm

determines how many parent directories away from root running script is...
and returns number and string for ExpandPath() (ie. "../../")

<CFMODULE TEMPLATE="findrootdir.cfm"
	[NUMBER_RETURN="[variable name]"]
	[STRING_RETURN="[varaible name]"]>
	
	NUMBER_RETURN = optional variable name of number of levels being returned,
		if not defined, will not return number
	STRING_RETURN = optional variable name of string of levels being returned,
		if not defined, will not return string
--->

<!--- remove everything except /'s from CGI.SCRIPT_NAME --->
<cfset temp = REReplace(CGI.SCRIPT_NAME, "[^/]", "", "ALL")>

<!--- count Len() to determine number of / --->
<cfset slashes = Len(temp)>

<!--- define subs off root --->
<cfset levels = DecrementValue(slashes)>

<!--- if NUMBER_RETURN defined, return number levels off / --->
<cfif IsDefined("Attributes.NUMBER_RETURN")>
  <cfset temp = "Caller." & Attributes.NUMBER_RETURN>
  <cfset "#temp#" = levels>
</cfif>

<!--- if STRING_RETURN defined, return relative path string --->
<cfif IsDefined("Attributes.STRING_RETURN")>
  <cfset temp = "Caller." & Attributes.STRING_RETURN>
  <cfset "#temp#" = "" & RepeatString("../", levels)>
</cfif>