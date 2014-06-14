<cfsetting enablecfoutputonly="yes">
<cfinclude template = "../../includes/app_globals.cfm">

<cfquery username="#db_username#" password="#db_password#" name="get_items" dataSource="#DATASOURCE#">
  SELECT itemnum
    FROM items
   WHERE status = 1 and studio = 1
</cfquery> 

<cfset #curPath# = GetTemplatepath()>
<cfset #directory# = Replace("#curPath#","event6\event.cfm","thumbs\")>

<cfset x = 1>
<cfloop query="get_items">
  <cfset theDest = #directory#&#get_items.itemnum#&".jpg">
  <cfif FileExists(theDest) IS 0> 
    <cfquery username="#db_username#" password="#db_password#" name="update_item" datasource="#DATASOURCE#"> 
      UPDATE items
         SET studio = 0,
         featured_studio = 0
       WHERE itemnum = #get_items.itemnum#
    </cfquery>
  <cfoutput>itemnum = #get_items.itemnum# Studio and featured_studio reset to 0. (missing thumbnail)<br></cfoutput>
  </cfif> 
  <cfset x = x+1>
</cfloop>
  

