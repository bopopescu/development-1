<cfsetting EnableCFOutputOnly="YES">
<!---
     cf_countries.cfm

     Outputs a SELECT box with a list of countries for the user to choose from.

     Written by Jason Johnson - Beyond Solutions, Inc.
     02-11-1999

     Modification History:
     03/1/99 - Added the "any" attribute.     -JMJ

     <CFMODULE TEMPLATE="cf_countries.cfm"
      [SELECTNAME=""]
      [SELECTED=""]
      [MULTIPLE=""]
      [SIZE=""]
      [ANY=""]>
	
	 Example:
	
    <CFMODULE TEMPLATE="cf_countries.cfm"
     SELECTNAME="myselectbox"
     SELECTED="USA"
     MULTIPLE="1"
     SIZE="5"	
     ANY="0">	       (displays "Any Country" option first if this is 1)
--->

<CFSCRIPT>
   // load countries into array
   countries = ArrayNew(2);   
   countries [1][1] = "Afghanistan";
   countries [2][1] = "Albania";
   countries [3][1] = "Algeria";
   countries [4][1] = "American Samoa";
   countries [5][1] = "Andorra";
   countries [6][1] = "Angola";
   countries [7][1] = "Anguilla";
   countries [8][1] = "Antigua and Barbuda";
   countries [9][1] = "Argentina";
   countries [10][1] = "Armenia";
   countries [11][1] = "Aruba";
   countries [12][1] = "Australia";
   countries [13][1] = "Austria";
   countries [14][1] = "Azerbaijan";
   countries [15][1] = "Bahamas";
   countries [16][1] = "Bahrain";
   countries [17][1] = "Bangladesh";
   countries [18][1] = "Barbados";
   countries [19][1] = "Belarus";
   countries [20][1] = "Belgium";
   countries [21][1] = "Belize";
   countries [22][1] = "Benin";
   countries [23][1] = "Bermuda";
   countries [24][1] = "Bhutan";
   countries [25][1] = "Bolivia";
   countries [26][1] = "Bosnia and Herzegovina";
   countries [27][1] = "Botswana";
   countries [28][1] = "Brazil";
   countries [29][1] = "British Virgin Islands";
   countries [30][1] = "Brunei Darussalam";
   countries [31][1] = "Bulgaria";
   countries [32][1] = "Burkina Faso";
   countries [33][1] = "Burundi";
   countries [34][1] = "Cambodia";
   countries [35][1] = "Cameroon";
   countries [36][1] = "Canada";
   countries [37][1] = "Cape Verde";
   countries [38][1] = "Cayman Islands";
   countries [39][1] = "Central African Republic";
   countries [40][1] = "Chad";
   countries [41][1] = "Chile";
   countries [42][1] = "China";
   countries [43][1] = "Christmas Island";
   countries [44][1] = "Colombia";
   countries [45][1] = "Comoros";
   countries [46][1] = "Cook Islands";
   countries [47][1] = "Costa Rica";
   countries [48][1] = "Croatia";
   countries [49][1] = "Cuba";
   countries [50][1] = "Cyprus";
   countries [51][1] = "Czech Republic";
   countries [52][1] = "Denmark";
   countries [53][1] = "Djibouti";
   countries [54][1] = "Dominica";
   countries [55][1] = "Dominican Republic";
   countries [56][1] = "Ecuador";
   countries [57][1] = "Egypt";
   countries [58][1] = "El Salvador";
   countries [59][1] = "Equatorial Guinea";
   countries [60][1] = "Falkland Islands";
   countries [61][1] = "Fiji";
   countries [62][1] = "Finland";
   countries [63][1] = "France";
   countries [64][1] = "Gabon";
   countries [65][1] = "Germany";
   countries [66][1] = "Greece";
   countries [67][1] = "Greenland";
   countries [68][1] = "Guam";
   countries [69][1] = "Guatemala";
   countries [70][1] = "Guinea";
   countries [71][1] = "Haiti";
   countries [72][1] = "Honduras";
   countries [73][1] = "Hong Kong";
   countries [74][1] = "Hungary";
   countries [75][1] = "Iceland";
   countries [76][1] = "India";
   countries [77][1] = "Indonesia";
   countries [78][1] = "Iran";
   countries [79][1] = "Iraq";
   countries [80][1] = "Ireland";
   countries [81][1] = "Israel";
   countries [82][1] = "Italy";
   countries [83][1] = "Jamaica";
   countries [84][1] = "Japan";
   countries [85][1] = "Jordan";
   countries [86][1] = "Kenya";
   countries [87][1] = "Kuwait";
   countries [88][1] = "Liberia";
   countries [89][1] = "Libya";
   countries [90][1] = "Liechtenstein";
   countries [91][1] = "Lithuania";
   countries [92][1] = "Luxembourg";
   countries [93][1] = "Macedonia";
   countries [94][1] = "Madagascar";
   countries [95][1] = "Malaysia";
   countries [96][1] = "Mexico";
   countries [97][1] = "Monaco";
   countries [98][1] = "Mongolia";
   countries [99][1] = "Morocco";
   countries [100][1] = "Mozambique";
   countries [101][1] = "Nepal";
   countries [102][1] = "Netherlands";
   countries [103][1] = "New Zealand";
   countries [104][1] = "Nicaragua";
   countries [105][1] = "Nigeria";
   countries [106][1] = "Norway";
   countries [107][1] = "Pakistan";
   countries [108][1] = "---Any---";
   countries [109][1] = "Panama";
   countries [110][1] = "Papua New Guinea";
   countries [111][1] = "Peru";
   countries [112][1] = "Philippines";
   countries [113][1] = "Poland";
   countries [114][1] = "Portugal";
   countries [115][1] = "Puerto Rico";
   countries [116][1] = "Romania";
   countries [117][1] = "Russia";
   countries [118][1] = "Rwanda";
   countries [119][1] = "Saudi Arabia";
   countries [120][1] = "Singapore";
   countries [121][1] = "Slovakia";
   countries [122][1] = "South Africa";
   countries [123][1] = "Spain";
   countries [124][1] = "Sweden";
   countries [125][1] = "Switzerland";
   countries [126][1] = "Taiwan";
   countries [127][1] = "Thailand";
   countries [128][1] = "Turkey";
   countries [129][1] = "Ukraine";
   countries [130][1] = "United Arab Emirates";
   countries [131][1] = "United Kingdom";
   countries [132][1] = "Uruguay";
   countries [133][1] = "USA";
   countries [134][1] = "Vietnam";
   countries [135][1] = "Virgin Islands";
   countries [136][1] = "Yugoslavia";
</CFSCRIPT>


<!--- verify attributes present --->
<CFLOOP INDEX="l" LIST="SELECTNAME,SELECTED,MULTIPLE,SIZE">
 <CFIF not IsDefined("Attributes." & l)>
   Attribute not specified for cf_countries... Aborting...<BR>
  <CFABORT>
 </CFIF>
</CFLOOP>

<!--- output select box --->
<CFOUTPUT><SELECT NAME="#Trim(Attributes.SELECTNAME)#"<cfif #trim(Attributes.MULTIPLE)# is "1"> multiple</cfif><cfif #trim(Attributes.SIZE)# GT "1"> size=#trim(Attributes.SIZE)#</cfif>></CFOUTPUT>
<cfif #isDefined ("attributes.any")#>
 <cfif #attributes.any# is "1">
  <cfoutput><option value=""<cfif #attributes.selected# is ""> selected</cfif>>---Any---</option></cfoutput>
 </cfif> 
</cfif>
<CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(countries)#">
 <CFOUTPUT><OPTION VALUE="#countries [i][1]#"<CFIF countries [i][1] IS #Trim(Attributes.SELECTED)#> SELECTED</CFIF>>#countries [i][1]#</option></CFOUTPUT>
</CFLOOP>
<CFOUTPUT>
 </SELECT>
</CFOUTPUT>
<cfsetting EnableCFOutputOnly="NO">