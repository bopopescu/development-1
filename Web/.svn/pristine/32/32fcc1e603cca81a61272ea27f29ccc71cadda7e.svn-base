<!--- artBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.art" type="any" default="" />
<cfset new = attributes.new />
<cfset art = attributes.art />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="art.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="art.cfm?method=edit&amp;ARTID=#art.getARTID()#">Edit</a> /
		<a href="art.cfm?method=clone&amp;ARTID=#art.getARTID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="art.cfm?method=read&amp;ARTID=#art.getARTID()#">Read</a> /
		<a href="art.cfm?method=clone&amp;ARTID=#art.getARTID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="art.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />