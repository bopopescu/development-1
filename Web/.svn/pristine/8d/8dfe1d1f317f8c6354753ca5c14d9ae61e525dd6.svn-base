

  <!-- include globals -->
  <!--- <cfinclude template="../includes/app_globals.cfm"> --->
  
  <html>
<head>
	<title>Zip Code Test</title>
</head>

<body>
  
  <cfif isDefined('zipCode1')>
   <cfmodule template="BetweenZips.cfm"
	zipCode1 = #form.zipcode1#
	zipCode2 = #form.zipcode2#
	unit = #form.unit#> 

	
   <cfoutput>
   This is the distance in
<cfif unit is "MI"> Mileage = #decimalformat(LatLonDistance)#
<cfelseif unit is "KM"> Kilometers = #decimalformat(LatLonDistance)#
<cfelseif unit is "FT"> Feet = #decimalformat(LatLonDistance)#
<cfelseif unit is "YD"> Yards = #decimalformat(LatLonDistance)#
<cfelseif unit is "M"> Meters = #decimalformat(LatLonDistance)#
<cfelse>
Mileage = #decimalformat(LatLonDistance)#

</cfif>





   </cfoutput>	
   </cfif>
   
   <cfoutput>
   <br>
   <br>
     

	<form action="Testzip.cfm" method="post" name="get_zips" >
	Input first zip code: 
		<input type="Text" name="zipcode1" size="10" value="<cfif isdefined('zipcode1')>#zipcode1#</cfif>">
<cfif isDefined('error1') and error1 is not "OK">#error1#</cfif>
		<br>
	Input second zip code: 
		<input type="Text" name="zipcode2" size="10" value="<cfif isdefined('zipcode2')>#zipcode2#</cfif>">
<cfif isDefined('error2') and error2 is not "OK">#error2#</cfif>		
		<br>
<input type="radio" name="unit" value="MI"
<cfif not isDefined('unit')> checked
<cfelseif isDefined('unit') and unit is "MI"> checked</cfif>> Miles <br>
<input type="radio" name="unit" value="KM"<cfif isDefined('unit') and unit is "KM"> checked</cfif>> Kilometers <br>
<input type="radio" name="unit" value="FT"<cfif isDefined('unit') and unit is "FT"> checked</cfif>> Feet <br>
<input type="radio" name="unit" value="YD"<cfif isDefined('unit') and unit is "YD"> checked</cfif>> Yards <br>
<input type="radio" name="unit" value="M"<cfif isDefined('unit') and unit is "M"> checked</cfif>> Meters <br>



<br>

	
     <input type="submit" name="add" value="Get distance" width=75 style="font-size: 9pt">

	 </form>
	 </cfoutput>
</body>
</html>
