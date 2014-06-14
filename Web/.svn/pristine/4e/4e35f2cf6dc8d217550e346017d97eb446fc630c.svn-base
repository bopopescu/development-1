<cfset serverVars = "server,cgi,url,form,url,variables,caller,session,application">
<cfloop list="#serverVars#" index="varName" delimiters=",">
	<p><cfdump var="#evaluate(varName)#" label="#varName#"></p>
</cfloop>
<cfthrow message="Debug Halt">