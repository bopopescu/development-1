
<cfset #curPath# = GetTemplatePath()>

<!--- Delete tmp and map files from root --->

 <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfif curPath contains "clearcache">
 <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"clearcache\","")>
<cfelseif curPath contains "admin">
<cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin\","")>
</cfif>
<cfdirectory action="LIST" directory="#directory#" name="get_files" filter="">

<!--- <cfoutput>#directory#</cfoutput> --->
 <cfoutput query="get_files">
<cfif right("#Name#", 4) is ".tmp">

  <cffile action="delete"	file="#directory##Name#">  

 <br>
</cfif>

<cfif right("#Name#", 4) is ".map">
 <cffile action="delete"	file="#directory##Name#">

</cfif>
</cfoutput>
 
<!--- Delete Category tmp and map files--->

  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfif curPath contains "clearcache">
 <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"clearcache\","listings\categories\")>
<cfelseif curPath contains "admin">
<cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin\","listings\categories\")>
</cfif>
<cfdirectory action="LIST" directory="#directory#" name="get_files" filter="">

<!--- <cfoutput>#directory#</cfoutput> --->
 <cfoutput query="get_files">
<cfif right("#Name#", 4) is ".tmp">

  <cffile action="delete"	file="#directory##Name#">  

 <br>
</cfif>

<cfif right("#Name#", 4) is ".map">
 <cffile action="delete"	file="#directory##Name#">

</cfif>

</cfoutput> 
<!--- Delete listings tmp and map files --->
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfif curPath contains "clearcache">
 <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"clearcache\","listings\")>
<cfelseif curPath contains "admin">
 <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin\","listings\")>
</cfif>
<cfdirectory action="LIST" directory="#directory#" name="get_files" filter="">

<!--- <cfoutput>#directory#</cfoutput> --->
 <cfoutput query="get_files">
<cfif right("#Name#", 4) is ".tmp">

  <cffile action="delete"	file="#directory##Name#">  

 <br>
</cfif>

<cfif right("#Name#", 4) is ".map">
 <cffile action="delete"	file="#directory##Name#">

</cfif>

</cfoutput> 
<!--- Delete featured tmp and map files --->

  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfif curPath contains "clearcache">
 <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"clearcache\","listings\featured\")>
<cfelseif curPath contains "admin">
<cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin\","listings\featured\")>
</cfif>
<cfdirectory action="LIST" directory="#directory#" name="get_files" filter="">

<!--- <cfoutput>#directory#</cfoutput> --->
<cfoutput query="get_files">

<cfif right("#Name#", 4) is ".tmp">

  <cffile action="delete"	file="#directory##Name#">  

 <br>
</cfif>

<cfif right("#Name#", 4) is ".map">
 <cffile action="delete"	file="#directory##Name#">

</cfif>

 </cfoutput>