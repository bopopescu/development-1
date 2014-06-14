<!--- galleryadminBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.galleryadmin" type="any" default="" />
<cfset new = attributes.new />
<cfset galleryadmin = attributes.galleryadmin />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="galleryadmin.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="galleryadmin.cfm?method=edit&amp;GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#">Edit</a> /
		<a href="galleryadmin.cfm?method=clone&amp;GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="galleryadmin.cfm?method=read&amp;GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#">Read</a> /
		<a href="galleryadmin.cfm?method=clone&amp;GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="galleryadmin.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />