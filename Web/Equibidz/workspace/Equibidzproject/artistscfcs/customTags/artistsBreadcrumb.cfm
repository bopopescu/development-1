<!--- artistsBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.artists" type="any" default="" />
<cfset new = attributes.new />
<cfset artists = attributes.artists />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="artists.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="artists.cfm?method=edit&amp;ARTISTID=#artists.getARTISTID()#">Edit</a> /
		<a href="artists.cfm?method=clone&amp;ARTISTID=#artists.getARTISTID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="artists.cfm?method=read&amp;ARTISTID=#artists.getARTISTID()#">Read</a> /
		<a href="artists.cfm?method=clone&amp;ARTISTID=#artists.getARTISTID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="artists.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />