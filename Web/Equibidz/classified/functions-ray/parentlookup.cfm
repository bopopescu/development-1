<!---
  parentlookup.cfm
  
  searches up category tree and builds list of parent categories...
  
  <CFMODULE TEMPLATE="parentlookup.cfm"
  	CATEGORY="[#######]"
  	DATASOURCE="#DATASOURCE#"
  	[RETURN="variable name"]>
  	
  	CATEGORY = category number to start searching from
  	DATASOURCE = name of datasource to query
  	RETURN = optional name of return variable, returns "parent_list" by default

--->
<cfsetting enablecfoutputonly="Yes">

<!--- default attributes --->
<CFPARAM NAME="Attributes.CATEGORY" DEFAULT="0">
<CFPARAM NAME="Attributes.RETURN" DEFAULT="parent_list">

<!--- DATASOURCE required --->
<CFIF not IsDefined("Attributes.DATASOURCE")>
  <B>MISSING PARAMETER:</B> You must specify the datasource for "parentlookup".<BR><BR>
  <CFABORT>
</CFIF>

<!--- define array to hold parents --->
<CFSET parent_list = ArrayNew(2)>

<!--- if given category (code) is not 0 look for parents --->
<CFIF Attributes.CATEGORY IS NOT 0>
  
  <!--- get parent (code) of given category --->
  <CFQUERY NAME="get_Parent" DATASOURCE="#Attributes.DATASOURCE#">
      SELECT parent
        FROM categories
       WHERE category = #Attributes.CATEGORY#
  </CFQUERY>
   
  <!--- get category information for parent --->
  <CFQUERY NAME="get_Parent" DATASOURCE="#Attributes.DATASOURCE#">
  		SELECT category, parent, name
        FROM categories
       WHERE category = #get_Parent.parent#
	</CFQUERY>
	
	<!--- define counter --->
	<CFSET counter = 1>
	
	<!--- if parent is 0 --->
	<CFLOOP CONDITION="#get_Parent.RecordCount# IS NOT 0">
    
    <!--- set element in --->
    <CFSET parent_list[counter][1] = Trim(get_Parent.name)>
    <CFSET parent_list[counter][2] = get_Parent.category>
    
    <!--- increment counter --->
    <CFSET counter = IncrementValue(counter)>
    
    <!--- get next parent --->
    <CFQUERY NAME="get_Parent" DATASOURCE="#Attributes.DATASOURCE#">
        SELECT category, parent, name
          FROM categories
         WHERE category = #get_Parent.parent#
		</CFQUERY>
	</CFLOOP>
</CFIF>

<!--- return to caller --->
<CFSET temp = "Caller." & Attributes.RETURN>
<CFSET "#temp#" = parent_list>

<cfsetting enablecfoutputonly="No">