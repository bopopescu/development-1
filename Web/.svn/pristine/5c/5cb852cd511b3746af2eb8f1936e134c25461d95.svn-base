<!--- 
  
  BetweenZips.cfm
  
  Calculate distance between zip codes...
  called where needed in software..
  
  required params:
    datasource (DSN)
	zipCode1
	zipCode2
    
  optional.. 
    unit - unit of measurement
	   "MI"  ' Miles  - default value used if not entered
       "FT" ' Feet
       "YD" ' Yards
       "KM" ' Kilometres
       "M"  ' Metres
  
  <cfmodule template="BetweenZips.cfm"
    datasource = "#DATASOURCE#"
	zipCode1 = "{first zip code}"
	zipCode2 = "{second zip code}"
	[unit = "{opt. unit of measurement}"] >
	
	Returns value in LatLonDistance
    
   
  Author: Michael Miller
  Date: 12/20/2001
  
  Formula used based on http://home.eol.ca/~cnorth/lat_lon_dist.html
  Data validation added by : David Herrick
  Date: 12/20/2001
  
--->
	<cfinclude template="../includes/app_globals.cfm">
<cfsetting enablecfoutputonly="Yes">

<!--- include globals --->
<!--- <cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif> --->

<cfif IsDefined("Attributes.ZipCode1") and IsDefined("Attributes.ZipCode2")>
    <cfquery name="zip1Data" datasource="#datasource#">
       SELECT *
       FROM zips
       WHERE Zip = '#Attributes.ZipCode1#'
    </cfquery>
<cfif zip1Data.recordcount>
<cfset zip1Data_Longitude = zip1Data.Longitude>
<cfset zip1Data_Latitude = zip1Data.Latitude>
<cfset caller.error1 = "OK">
<cfelse>
<cfset caller.error1 = "Please enter a valid zip code">
<cfset caller.zipcode1 = "">
<cfset caller.LatLonDistance = "">	

</cfif>
    <cfquery name="zip2Data" datasource="#datasource#">
       SELECT *
       FROM zips
       WHERE Zip = '#Attributes.ZipCode2#'
    </cfquery>
<cfif zip2Data.recordcount>
<cfset zip2Data_Longitude = zip2Data.Longitude>
<cfset zip2Data_Latitude = zip2Data.Latitude>
<cfset caller.error2 = "OK">
<cfelse>
<cfset caller.error2 = "Please enter a valid zip code">
<cfset caller.zipcode2 = "">
<cfset caller.LatLonDistance = "">
</cfif>

<!--- Set the radius of the earth in the desired units... --->
    <cfset unit_used = 3956> <!--- set for miles ---> 
    <cfif isdefined("Attributes.unit")>
	   <cfif #Attributes.unit# eq 'FT'>
	      <cfset unit_used = 20887680>
	   <cfelseif #Attributes.unit# eq 'YD'>
		  <cfset unit_used = 6962560>
	   <cfelseif #Attributes.unit# eq 'KM'>
		  <cfset unit_used = 6367>
	   <cfelseif #Attributes.unit# eq 'M'>
		  <cfset unit_used = 6367000>
	   </cfif>	  
	</cfif>     

<!--- 'Calculate the Deltas  --->
<cfif zip1Data.recordcount and zip2Data.recordcount>

    <cfset deltaLon = #zip2Data_Longitude# * Pi() / 180 - #zip1Data_Longitude# * Pi() / 180>
    <cfset deltaLat = #zip2Data_Latitude# * Pi() / 180 - #zip1Data_Latitude# * Pi() / 180>

<!--- Intermediate values --->

    <cfset inter_a = ((1 - Cos(#deltaLat#)) / 2) + Cos(#zip1Data_Latitude# * Pi() / 180) * Cos(#zip2Data_Latitude# * Pi() / 180) * ((1 - Cos(#deltaLon#)) / 2)>
	
<!--- Intermediate result c is the great circle distance in radians  --->
    <cfset inter_c1 = Min(1, Sqr(#inter_a#))>
    <cfset inter_c = 2 * Atn(#inter_c1# / Sqr(-#inter_c1# * #inter_c1# + 1))>

	<cfset caller.LatLonDistance = #inter_c# * #unit_used#>
	<cfset caller.unit = "#Attributes.unit#">
	<cfset caller.zipcode1 = "#Attributes.zipcode1#">
	<cfset caller.zipcode2 = "#Attributes.zipcode2#">
<cfelse>
<cfset caller.unit = "#Attributes.unit#">

</cfif>
</cfif>

