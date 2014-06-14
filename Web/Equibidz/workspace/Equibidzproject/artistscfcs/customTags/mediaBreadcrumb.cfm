<!--- mediaBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.media" type="any" default="" />
<cfset new = attributes.new />
<cfset media = attributes.media />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="media.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="media.cfm?method=edit&amp;MEDIAID=#media.getMEDIAID()#">Edit</a> /
		<a href="media.cfm?method=clone&amp;MEDIAID=#media.getMEDIAID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="media.cfm?method=read&amp;MEDIAID=#media.getMEDIAID()#">Read</a> /
		<a href="media.cfm?method=clone&amp;MEDIAID=#media.getMEDIAID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="media.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />