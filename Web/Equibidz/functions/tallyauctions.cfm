<!---
  tallyauctions.cfm
  
  will add up the number of auctions in a given category
  
  <cfmodule template="tallyauctions.cfm"
  	CATEGORY="[#########]"
  	DATASOURCE="[datasource name]"
  	TIMENOW="[TIMENOW]"
  	[RETURN=""]>
  	
  	CATEGORY = the category number you want to tally for
  	DATASOURCE = name of datasource to use
  	TIMENOW = TIMENOW
  	RETURN = optional return variable, default is "total_auctions"
  	
  	requires /functions/cf_category_tree.cfm

--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- define default return variable --->
<cfparam name="Attributes.RETURN" default="total_auctions">

<!--- make sure required attributes are present --->
<cfloop index="l" list="CATEGORY,DATASOURCE,TIMENOW">
	<cfif not IsDefined("Attributes." & l)>
		<b>ERROR:</b> Missing <cfoutput>"#l#"</cfoutput> attribute of "tallyauctions" function.  Aborting...<BR><BR>
		<cfabort>
	</cfif>
</cfloop>

<!--- define default total --->
<cfset total = 0>

<!--- lookup category --->
<cfquery username="#db_username#" password="#db_password#" name="get_Category" datasource="#Attributes.DATASOURCE#">
	SELECT child_count
	  FROM categories
	 WHERE category = #Attributes.CATEGORY#
</cfquery>

<!--- if exists , continue to tally --->
<cfif get_Category.RecordCount>
  
  <!--- define list of categories --->
  <cfset category_list = #Attributes.CATEGORY#>
  
  <!--- if child_count, retrieve subs --->
  <cfif get_Category.child_count>
    
    <!--- retrieve subs (cf_category_tree.cfm) --->
    <CFMODULE TEMPLATE="cf_category_tree.cfm"
      type="RETRIEVE"
      datasource="#Attributes.DATASOURCE#"
      parent="#Attributes.CATEGORY#"
      active_only="1"
      require_login="0">
    
    <!--- define delims of RESULT --->
    <cfset #ext_delim# = "²">
    <cfset #int_delim# = "÷">
    
		<!--- loop over RESULT --->
		<cfloop index="l" list="#RESULT#" delimiters="#ext_delim#">
		  
		  <!--- add category code from list --->
  	  <cfset category_list = ListAppend(category_list, ListGetAt(l, 1, #int_delim#), ",")>
  	  
		</cfloop>
	</cfif>
	
	<!--- count auctions in categories on list --->
	<cfloop index="l" list="#category_list#">
	  <cfquery username="#db_username#" password="#db_password#" name="get_Auctions" datasource="#Attributes.DATASOURCE#">
			SELECT COUNT(status) AS totalAuctions
			  FROM items
			 WHERE category1 = #l#
			   AND status = 1
			   AND date_start < #Attributes.TIMENOW#
			   AND date_end > #Attributes.TIMENOW#
			    OR category2 = #l#
			   AND status = 1
			   AND date_start < #Attributes.TIMENOW#
			   AND date_end > #Attributes.TIMENOW#
		</cfquery>
		
		<cfset total = total + get_Auctions.totalAuctions>
	</cfloop>
</cfif>

<!--- return total to caller --->
<cfset temp = "Caller." & Attributes.RETURN>
<cfset "#temp#" = total>

<cfsetting enablecfoutputonly="No">
