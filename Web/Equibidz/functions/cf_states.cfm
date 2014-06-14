<cfsetting EnableCFOutputOnly="YES">
<!---
     cf_states.cfm

     Outputs a SELECT box with a list of states for the user to choose from.

     Written by Jason Johnson - Beyond Solutions, Inc.
     02-11-1999

     Modification History:
     03/1/99 - Added the "any" attribute.     -JMJ

     <CFMODULE TEMPLATE="cf_states.cfm"
      [SELECTNAME=""]
      [SELECTED=""]
      [MULTIPLE=""]
      [SIZE=""]
      [ANY=""]>
	
	 Example:
	
    <CFMODULE TEMPLATE="cf_states.cfm"
     SELECTNAME="myselectbox"
     SELECTED="California"
     MULTIPLE="0"
     SIZE="1"	
     ANY="0">	       (displays "Any State" option first if this is 1)
--->

<CFSCRIPT>
   // load states into array
   states = ArrayNew(2);   
   states [1][1] = "N/A";
   states [2][1] = "Alabama";
   states [3][1] = "Alaska";
   states [4][1] = "Arizona";
   states [5][1] = "Arkansas";
   states [6][1] = "California";
   states [7][1] = "Colorado";
   states [8][1] = "Connecticut";
   states [9][1] = "Delaware";
   states [10][1] = "Florida";
   states [11][1] = "Georgia";
   states [12][1] = "Hawaii";
   states [13][1] = "Idaho";
   states [14][1] = "Illinois";
   states [15][1] = "Indiana";
   states [16][1] = "Iowa";
   states [17][1] = "Kansas";
   states [18][1] = "Kentucky";
   states [19][1] = "Louisiana";
   states [20][1] = "Maine";
   states [21][1] = "Maryland";
   states [22][1] = "Massachusetts";
   states [23][1] = "Michigan";
   states [24][1] = "Minnesota";
   states [25][1] = "Mississippi";
   states [26][1] = "Missouri";
   states [27][1] = "Montana";
   states [28][1] = "Nebraska";
   states [29][1] = "Nevada";
   states [30][1] = "New Hampshire";
   states [31][1] = "New Jersey";
   states [32][1] = "New Mexico";
   states [33][1] = "New York";
   states [34][1] = "North Carolina";
   states [35][1] = "North Dakota";
   states [36][1] = "Ohio";
   states [37][1] = "Oklahoma";
   states [38][1] = "Oregon";
   states [39][1] = "Pennsylvania";
   states [40][1] = "Rhode Island";
   states [41][1] = "South Carolina";
   states [42][1] = "South Dakota";
   states [43][1] = "Tennessee";
   states [44][1] = "Texas";
   states [45][1] = "Utah";
   states [46][1] = "Vermont";
   states [47][1] = "Virginia";
   states [48][1] = "Washington";
   states [49][1] = "West Virginia";
   states [50][1] = "Wisconsin";
   states [51][1] = "Wyoming";
</CFSCRIPT>


<!--- verify attributes present --->
<CFLOOP INDEX="l" LIST="SELECTNAME,SELECTED,MULTIPLE,SIZE">
 <CFIF not IsDefined("Attributes." & l)>
   Attribute not specified for cf_states... Aborting...<BR>
  <CFABORT>
 </CFIF>
</CFLOOP>

<!--- output select box --->
<CFOUTPUT><SELECT NAME="#Trim(Attributes.SELECTNAME)#" ID="#Trim(Attributes.SELECTNAME)#" <cfif #trim(Attributes.MULTIPLE)# is "1"> multiple</cfif><cfif #trim(Attributes.SIZE)# GT "1"> size=#trim(Attributes.SIZE)#</cfif> onChange="setLocation()"></CFOUTPUT>
<cfif #isDefined ("attributes.any")#>
 <cfif #attributes.any# is "1">
  <cfoutput><option value=""<cfif #attributes.selected# is ""> selected</cfif>>Select a State</option></cfoutput>
 </cfif>
 <cfif #attributes.any# is "2">
  <cfoutput><option value="" selected>---Any---</option></cfoutput>
 </cfif>
</cfif>
<CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(states)#">
 <CFOUTPUT><OPTION VALUE="#states [i][1]#"<CFIF states [i][1] IS #Trim(Attributes.SELECTED)#> SELECTED</CFIF>>#states [i][1]#</option></CFOUTPUT>
</CFLOOP>
<CFOUTPUT>
 </SELECT>
</CFOUTPUT>
<cfsetting EnableCFOutputOnly="NO">