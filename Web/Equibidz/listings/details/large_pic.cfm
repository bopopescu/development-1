<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfsetting enablecfoutputonly="Yes">
<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">

<!--- include globals --->
  <cfinclude template="../../includes/app_globals.cfm">
  <!--- get item's info --->
  <cfquery name="get_ItemInfo" datasource="#DATASOURCE#">

    SELECT 
	itemnum,
	title
    FROM items
    WHERE itemnum = #url.itemnum#

  </cfquery>

<html>
<head>
	<cfoutput><title>#title#</title></cfoutput>
</head>

<body>
<cfoutput>


<cfif url.Image eq 1>
<a href="JavaScript:history.back(1)">View Previous</a>&nbsp;|&nbsp;<cfif url.Image eq 1><a href="large_pic.cfm?Image=2&itemnum=#url.itemnum#&title=#get_ItemInfo.title#">View Next</a></cfif><br><br>
<cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\details\","fullsize_thumbs\")#>
<cfif fileExists("#thePath##url.itemnum#.jpg")>
<img src="#varoot#/fullsize_thumbs/#url.itemnum#.jpg">
<cfelseif fileExists("#thePath##url.itemnum#.gif")>
<img src="#varoot#/fullsize_thumbs/#url.itemnum#.gif">
<cfelseif fileExists("#thePath##url.itemnum#.png")>
<img src="#varoot#/fullsize_thumbs/#url.itemnum#.png">

</cfif>
<cfelseif url.image eq 2>
<a href="JavaScript:history.back(1)">View Previous</a>&nbsp;|&nbsp;<cfif url.Image eq 2><a href="large_pic.cfm?Image=3&itemnum=#url.itemnum#&title=#get_ItemInfo.title#">View Next</a></cfif><br><br>
<cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\details\","fullsize_thumbs1\")#>
<cfif fileExists("#thePath##url.itemnum#.jpg")>
<img src="#varoot#/fullsize_thumbs1/#url.itemnum#.jpg">
<cfelseif fileExists("#thePath##url.itemnum#.gif")>
<img src="#varoot#/fullsize_thumbs1/#url.itemnum#.gif">
<cfelseif fileExists("#thePath##url.itemnum#.png")>
<img src="#varoot#/fullsize_thumbs1/#url.itemnum#.png">

</cfif>
<cfelseif url.image eq 3>
<a href="JavaScript:history.back(1)">View Previous</a>&nbsp;|&nbsp;<cfif url.Image eq 3><a href="large_pic.cfm?Image=4&itemnum=#url.itemnum#&title=#get_ItemInfo.title#">View Next</a></cfif><br><br>
<cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\details\","fullsize_thumbs2\")#>
<cfif fileExists("#thePath##url.itemnum#.jpg")>
<img src="#varoot#/fullsize_thumbs2/#url.itemnum#.jpg">
<cfelseif fileExists("#thePath##url.itemnum#.gif")>
<img src="#varoot#/fullsize_thumbs2/#url.itemnum#.gif">
<cfelseif fileExists("#thePath##url.itemnum#.png")>
<img src="#varoot#/fullsize_thumbs2/#url.itemnum#.png">
</cfif>
<cfelseif url.image eq 4>
<a href="JavaScript:history.back(1)">View Previous</a>&nbsp;|&nbsp;<cfif url.Image eq 4><a href="large_pic.cfm?Image=1&itemnum=#url.itemnum#&title=#get_ItemInfo.title#">View Next</a></cfif><br><br>
<cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\details\","fullsize_thumbs3\")#>
<cfif fileExists("#thePath##url.itemnum#.jpg")>
<img src="#varoot#/fullsize_thumbs3/#url.itemnum#.jpg">
<cfelseif fileExists("#thePath##url.itemnum#.gif")>
<img src="#varoot#/fullsize_thumbs3/#url.itemnum#.gif">
<cfelseif fileExists("#thePath##url.itemnum#.png")>
<img src="#varoot#/fullsize_thumbs3/#url.itemnum#.png">
</cfif>

</cfif>

</cfoutput>
</body>
</html>
