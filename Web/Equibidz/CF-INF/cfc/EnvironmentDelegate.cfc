<! - - -
	--- EnvironmentConfigurer
	--- ---------------------
	---
	--- Provides global environment configuration information and logic.
	---
	--- author: bsterner
	--- date:   6/14/14
	- - - >
<cfcomponent displayname="EnvironmentConfigurer" hint="Provides global environment configuration information and logic." extends="AbstractBaseComponent" accessors="true" output="false" persistent="false">

	<cffunction name="getEnvironment" access="public" returntype="struct" hint="Retrieves struct containing environment related information.">
		<cfset environment = structNew()>
		<cfreturn environment>
	</cffunction>

</cfcomponent>
