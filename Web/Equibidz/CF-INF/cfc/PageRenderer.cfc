<!---
  --- PageRenderer
  --- ------------
  ---
  --- Default page renderer.  Contains generic information used site wide.
  ---
  --- author: bsterner
  --- date:   6/14/14
  --->
<cfcomponent displayname="Page Renderer" hint="Dafult page renderer."
	accessors="true" output="false" persistent="false">

	<cffunction name="getPageModel" hint="Overrides default page model rendering method." returntype="struct">
		<!---<cfthrow message="Method not implemented.  Components extending this should implement and provide page specific rendering logic as well as the model.">--->
	</cffunction>

	<!--- <cffunction name="getQueryLimits" output="true">
		<cfset queryLimits = structNew()>
		<cfset var limitCategoryFrontPage = "">
		<cfset var getLimitcatFrontpage = "">
		<cfdump var="#application#" label="Application in Page Renderer">
		<cfquery name="getLimitcatFrontpage" datasource="#application.datasource#">
		   SELECT pair
		     FROM defaults
		    WHERE name='limitcat_frpage'
		</cfquery>
		<cfset #queryLimits.limitCategoryFrontPage# = #getLimitcatFrontpage.pair#>
		<cfreturn queryLimits>
	</cffunction> --->
</cfcomponent>
