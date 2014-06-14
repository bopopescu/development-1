<cfsetting enablecfoutputonly="yes">
<!--- 
	Sort Order Links:

  generates a drop down box...
  & optional hidden fields...
  
  <cfmodule template="sortorderlinks.cfm"
    sortby="#sortby#"
    action="[ link where form data will be sent ]"
    [addVars="[URL variable string (no ?)]"]>

--->

<!--- required params --->
<cfloop index="l" list="sortby,action">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</b> "#l#" attribute of pagelinks function not defined.<br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<cfset defaultoption = "">
<cfset date_descoption = "">
<cfset date_ascoption = "">
<cfset title_descoption = "">
<cfset title_ascoption = "">
<cfparam name="Attributes.addVars" default="">
<cfset hiddenFields = "">
<cfset outDlm = "&">
<cfset inDlm = "=">

<cfif Attributes.sortby EQ "date_asc">
	<cfset date_ascoption = "selected">
<cfelseif Attributes.sortby EQ "date_desc">
	<cfset date_descoption = "selected">

<cfelseif Attributes.sortby EQ "title_desc">
	<cfset title_descoption = "selected">
<cfelseif Attributes.sortby EQ "title_asc">
	<cfset title_ascoption = "selected">

<cfelse>
	<cfset defaultoption = "selected">
</cfif>

<!--- if optional vars created hidden fields --->
<cfif Len(Attributes.addVars) AND Find(inDlm, Attributes.addVars)>
  
  <cfloop index="l" list="#Attributes.addVars#" delimiters="#outDlm#">
    <cfset hiddenFields = hiddenFields & '<input name="#ListGetAt(l, 1, inDlm)#" type=hidden value="#ListGetAt(l, 2, inDlm)#">'>
  </cfloop>
  
</cfif>

<cfoutput>
<form method="get" action="#Attributes.action#">
	<table border=0 cellspacing=0 cellpadding=0>
	<tr><td valign=center align=right>
		<select name="sortby">
			<option #defaultoption# 	value=""		>Select a sort order and click GO!</option>
			<option #date_descoption# 	value="date_desc"	>Sort by Date: Newest first</option>
			<option #date_ascoption# 	value="date_asc"	>Sort by Date: Oldest first</option>
			<option #title_ascoption# 	value="title_asc"	>Sort by Title: A to Z</option>
			<option #title_descoption# 	value="title_desc"	>Sort by Title: Z to A</option>
		</select>
		#Variables.hiddenFields#
	</td><td valign=center align=left>
		<small><input type=submit value="GO!"></small>
	</td></tr>
	</table>
</form>
</cfoutput>
<cfsetting enablecfoutputonly="no">

