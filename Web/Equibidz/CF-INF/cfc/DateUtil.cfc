<!---
  --- DateUtil
  --- --------
  ---
  --- Provides date and time related functions.
  ---
  --- author: bsterner
  --- date:   6/14/14
  --->
<cfcomponent displayname="Date Util" hint="Provides date and time related functions." extends="AbstractBaseComponent" accessors="true" output="true" persistent="false">


	<cffunction name="getEpoch" displayname="Get EPOCH" hint="Gets Defines Unix time seconds since 12/31/1999 24:00:00 GMT set 'zone_adjust' +/- to calc GMT from your server time" access="public" output="false" returntype="date">
		<!--- define # of hours to adjust server time to get GMT time --->
		<cfset var zone_adjust = 8>
		<!--- define GMT time --->
		<cfset var GMTtime = dateAdd("h", zone_adjust, Now())>
		<!--- set EPOCH in Caller --->
		<cfset var epoch = dateDiff("s", "12-31-1979 00:00:00", GMTtime)>

		<cfreturn epoch>
	</cffunction>

	<cffunction name="getTimeNow" displayname="Get Time Now" output="true"
				description="Replacement for Now() function that allows owner to set time zone of site +/- to zone server is set to">
		<cfargument name="adjustment" default="#application.getLayout.timechange#" hint="ADJUST is a positive or negative integer used to shift the current time zone.">
		<cfreturn dateAdd("h", adjustment, Now())>
	</cffunction>

</cfcomponent>