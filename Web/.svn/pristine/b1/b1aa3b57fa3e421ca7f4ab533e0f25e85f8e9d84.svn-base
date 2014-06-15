<!---
  --- LayoutPageRenderer
  --- ----------------
  ---
  --- Provides layout page rendering data.
  ---
  --- author: bsterner
  --- date:   6/14/14
  --->
<cfcomponent displayname="Layout Page Renderer" hint="Page renderer for home page." extends="/CF-INF/cfc/AbstractPageRenderer" accessors="true" output="false" persistent="false">
	<cffunction name="getLayoutModel" hint="Retrives layout information for page rendering." returntype="query">
		<cfset var getLayout = "">
		<cfquery name="getLayout" datasource="#application.datasource#">
			SELECT *
			FROM layout
			WHERE id = 1
		</cfquery>
		<cfreturn getLayout>
	</cffunction>
</cfcomponent>
