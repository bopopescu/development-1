<cfsetting enablecfoutputonly="Yes">
<!---
	Global Caching Control:

	Variables to deal with:

	current_page = 

		categories
		completed
		current
		ending
		featured
		going
		index
		new
		registration
		search
		search_results

	define variable: cache_flush
	  to flush the current cache directory.

--->
<cfif #get_layout.all_cache# eq 1>
<CFPARAM name="URL.strCaching" default="YES">

<cfelse>

<CFPARAM name="URL.strCaching" default="NO">

</cfif>


<cfif URL.strCaching NEQ "no" AND NOT parameterexists(strCacheComplete)>

	<!--- set a variable so we don't run this cache code more than once... --->
	<cfset URL.strCacheComplete = TRUE>

	<!--- SET TIME INTERVALS FOR INCLUDES ACCORDINGLY (in hours) --->
	<cfset int_Categories = 2>
	<cfset int_Completed = 12>
	<cfset int_Current = 2>
	<cfset int_Ending = 12>
	<cfset int_Featured = 4>
	<cfset int_Index = 2>
	<cfset int_New = 12>
	<!--- <cfset int_Registration = 4> --->
	<cfset int_Search = 2>
	<cfset int_Search_results = 2>

	<!--- note: Going int matches "1/2 x hours till end to highlight end date" in admin --->
	<cftry>
	  <cfif NOT isdefined("URL.strDefaults_hrsending")>
		  <cfquery username="#db_username#" password="#db_password#" name="getGoingInt" datasource="#DATASOURCE#">
		      SELECT pair AS hours
		        FROM defaults
		       WHERE name = 'hrsending'
		  </cfquery>
		  <cfset URL.strDefaults_hrsending = getGoingInt.hours>
	  </cfif>
  
	  <cfif len(trim(URL.strDefaults_hrsending)) LT 1>
	    <cfthrow>
	  <cfelseif not IsNumeric(Trim(URL.strDefaults_hrsending))>
	    <cfthrow>
	  <cfelse>
	    <cfset int_Going = ceiling((Trim(URL.strDefaults_hrsending))/2)>
	  </cfif>
  
	  <cfcatch type="Any">
	    <cfset int_Going = 4>
	  </cfcatch>
	</cftry>

	<cfparam name="current_page" default="undefined"> 


<cfif #get_layout.listings_cache# eq 1>
	<cfif current_page EQ "categories">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Categories))>

	<cfelseif current_page EQ "completed">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Completed))>

	<cfelseif current_page EQ "current">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Current))>

	<cfelseif current_page EQ "ending">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Ending))>

	<cfelseif current_page EQ "featured">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Featured))>

	<cfelseif current_page EQ "going">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Going))>
<cfelseif current_page EQ "index">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Index))>
	

	<cfelseif current_page EQ "new">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_New))>

</cfif>

</cfif>



<cfif #get_layout.homepage_cache# eq 1>

<cfif current_page EQ "indexhome">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Index))>


</cfif>
</cfif>


	<!--- <cfelseif current_page EQ "registration">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Registration))> --->
<cfif #get_layout.search_cache# eq 1>

<cfif current_page EQ "index">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Index))>

	<cfelseif current_page EQ "search">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Search))>

	<cfelseif current_page EQ "search_results">
		<cfset cache_control = "true">
		<cfset cache_duration = (0 - int(Variables.int_Search_results))>

</cfif>



	<cfelse>
		<cfset cache_control = "false">
	</cfif>

	<cfparam name="cache_control" default="false">

<!---	<cfif URL.strCaching NEQ "no">
	  <cfif Variables.cache_control EQ "true">
	    <cfif isDefined("cache_flush")>
	      <cfcache action="flush">
	    <cfelse>
	      <cfcache timeout="#DateAdd("h", "#Variables.cache_duration#", Now() )#">
	    </cfif>
	  </cfif>
	</cfif>
--->

</cfif>


<cfsetting enablecfoutputonly="no">
