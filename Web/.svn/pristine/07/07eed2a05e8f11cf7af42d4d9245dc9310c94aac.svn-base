<!---
  pagelinks.cfm
  
  generates links for other similar pages...
  ie. index.html, page2.html, page3.html, page4.html, etc.
  will show next 5 & prev 5 if any...
  then in increments of 10 beyond that...
  plus next & prev links...
  
  <cfmodule template="pagelinks.cfm"
    thispage="[page numer on]"
    totalpages="[total number of like pages]"
    link="[location of like pages]">

--->
<cfsetting enablecfoutputonly="Yes">

<!--- required params --->
<cfloop index="l" list="thispage,totalpages,link">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</b> "#l#" attribute of pagelinks function not defined.<br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- if thispage > 1 show "prev" & other links --->
<cfif Attributes.thispage GT 1>
  <!--- prev page link --->
  <cfif Attributes.thispage - 1 IS 1>
    <cfset prevpage = "">
  <cfelse>
    <cfset prevpage = "&group=#Evaluate(Attributes.thispage - 1)#">
  </cfif>
    <cfoutput><a href="#Attributes.link##prevpage#">previous&nbsp;page</a> &nbsp;</cfoutput>
  
  <!--- other prev links --->
  <cfloop index="i" from="1" to="#Evaluate(Attributes.thispage - 1)#">
    <cfif i GTE Evaluate(Attributes.thispage - 5)>
      <cfif i IS 1>
        <cfoutput><a href="#Attributes.link#">#i#</a> </cfoutput>
      <cfelse>
        <cfoutput><a href="#Attributes.link#&group=#i#">#i#</a> </cfoutput>
      </cfif>
    <cfelseif i IS 1>
      <cfoutput><a href="#Attributes.link#">1</a> </cfoutput>
    <cfelseif Fix(Evaluate(i / 10)) IS Evaluate(i / 10)>
      <cfoutput><a href="#Attributes.link#&group=#i#">#i#</a> </cfoutput>
    </cfif>
  </cfloop>
</cfif>

<!--- show thispage --->
<cfoutput><b>#Attributes.thispage#</b> </cfoutput>

<!--- if thispage < totalpages show other & "next" links --->
<cfif Attributes.thispage LT Attributes.totalpages>
  <!--- next links --->
  <cfloop index="i" from="#Evaluate(Attributes.thispage + 1)#" to="#Attributes.totalpages#">
    <cfif i LTE Evaluate(Attributes.thispage + 5)>
      <cfoutput><a href="#Attributes.link#&group=#i#">#i#</a> </cfoutput>
    <cfelseif Fix(Evaluate(i / 10)) IS Evaluate(i / 10)>
      <cfoutput><a href="#Attributes.link#&group=#i#">#i#</a> </cfoutput>
    <cfelseif i IS Attributes.totalpages>
      <cfoutput><a href="#Attributes.link#&group=#i#">#i#</a> </cfoutput>
    </cfif>
  </cfloop>
  
  <!--- next page link --->
  <cfoutput>&nbsp;<a href="#Attributes.link#&group=#Evaluate(Attributes.thispage + 1)#">next&nbsp;page</a></cfoutput>
</cfif>

<cfsetting enablecfoutputonly="No">