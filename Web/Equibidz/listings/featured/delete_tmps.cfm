<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset #curPath# = GetTemplatePath()>

  <cfset directory = #GetDirectoryFromPath(curPath)#>
 
<cfdirectory action="LIST" directory="#directory#" name="get_files" filter="">

<html>
<head>
	<title>Untitled</title>
</head>
<cfoutput>#directory#</cfoutput>
<cfoutput query="get_files">
<cfif right("#Name#", 4) is ".tmp">

  <cffile action="delete"	file="#directory##Name#">  

 <br>
</cfif>

<cfif right("#Name#", 4) is ".map">
 <cffile action="delete"	file="#directory##Name#">

</cfif>

</cfoutput>
<body>



</body>
</html>
