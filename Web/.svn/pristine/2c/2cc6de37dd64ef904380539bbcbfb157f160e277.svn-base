<!---
  timenow.cfm
  
  sets global variable TIMENOW
  replacement for Now() function
  allows owner to set time zone of site +/- to zone server is set to
  
  <cfmodule template="timenow.cfm"
  	[ADJUST="{integer}"]>
  	
  	ADJUST is a positive or negative integer to shift your time zone from where you are

--->

<cfinclude template="../includes/app_globals.cfm">
<cfsetting enablecfoutputonly="Yes">

<!--- default adjustment --->
<cfparam name="Attributes.ADJUST" default="#get_layout.timechange#">

<!--- # of zones to adjust by +/- --->
<cfset adjustment = Attributes.ADJUST>

<!--- verify ADJUST is numeric --->
<cfif not IsNumeric(adjustment)>
	<B>"ADJUST"</B> attribute of <B>TIMENOW</B> module is not numeric!<BR><BR>
	<cfabort>
</cfif>

<!--- set TIMENOW in Caller --->
<cfset Caller.TIMENOW = DateAdd("h", adjustment, Now())>

<cfsetting enablecfoutputonly="No">