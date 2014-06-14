<cfsetting EnableCFOutputOnly="YES">
<!---
     cf_ccardname.cfm

     Outputs a SELECT box with a list of ccardname for the user to choose from.

     

     Modification History:
     10/19/11 - Added the "any" attribute.     -JM

     <CFMODULE TEMPLATE="cf_ccardname.cfm"
      [SELECTNAME=""]
      [SELECTED=""]
      [MULTIPLE=""]
      [SIZE=""]
      [ANY=""]>
	
	 Example:
	
    <CFMODULE TEMPLATE="cf_ccardname.cfm"
     SELECTNAME="myselectbox"
     SELECTED="California"
     MULTIPLE="0"
     SIZE="1"	
     ANY="0">	       (displays "Credit Card Name" option first if this is 1)
--->

<CFSCRIPT>
   // load ccardname into array
   ccardname = ArrayNew(2);   
   ccardname [1][1] = "N/A";
   ccardname [2][1] = "Master Card";
   ccardname [3][1] = "Visa";
   ccardname [4][1] = "American Express";
   ccardname [5][1] = "Discover";
   
   
   
</CFSCRIPT>


<!--- verify attributes present --->
<CFLOOP INDEX="l" LIST="SELECTNAME,SELECTED,MULTIPLE,SIZE">
 <CFIF not IsDefined("Attributes." & l)>
   Attribute not specified for cf_ccardname... Aborting...<BR>
  <CFABORT>
 </CFIF>
</CFLOOP>

<!--- output select box --->
<CFOUTPUT><SELECT NAME="#Trim(Attributes.SELECTNAME)#" ID="#Trim(Attributes.SELECTNAME)#" <cfif #trim(Attributes.MULTIPLE)# is "1"> multiple</cfif><cfif #trim(Attributes.SIZE)# GT "1"> size=#trim(Attributes.SIZE)#</cfif> onChange="setLocation()"></CFOUTPUT>
<cfif #isDefined ("attributes.any")#>
 <cfif #attributes.any# is "1">
  <cfoutput><option value=""<cfif #attributes.selected# is ""> selected</cfif>>Select Credit Card Type</option></cfoutput>
 </cfif>
 <cfif #attributes.any# is "2">
  <cfoutput><option value="" selected>---Any---</option></cfoutput>
 </cfif>
</cfif>
<CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(ccardname)#">
 <CFOUTPUT><OPTION VALUE="#ccardname [i][1]#"<CFIF ccardname [i][1] IS #Trim(Attributes.SELECTED)#> SELECTED</CFIF>>#ccardname [i][1]#</option></CFOUTPUT>
</CFLOOP>
<CFOUTPUT>
 </SELECT>
</CFOUTPUT>
<cfsetting EnableCFOutputOnly="NO">