<cffunction name="formatDollar" displayname="Format Dollar" description="Formats the provided 'dollar' text value by removing all non-decimal characters such as '$ and ,'">
	<cfargument name="dollarString" required="yes" type="string">
	<cfset var dollarAmount = reReplace(arguments.dollarString, "$,", "", "all">
	<cfreturn dollarAmount>
</cffunction>