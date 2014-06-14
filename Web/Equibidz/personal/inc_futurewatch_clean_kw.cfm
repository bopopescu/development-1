<!--- Strip unwanted characters from keyword list. --->

<cfset keywords = trim(keywords)>
<cfset keywords = REReplace(keywords,",,",",")>
<cfset keywords = REReplaceNoCase(keywords,"[^0-9a-z,]","")>
<cfif right(keywords, 1) is ",">
  <cfset keywords = removeChars(keywords, len(keywords), "1")> 
</CFIF> 
