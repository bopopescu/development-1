<!--- orderstatusBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.orderstatus" type="any" default="" />
<cfset new = attributes.new />
<cfset orderstatus = attributes.orderstatus />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="orderstatus.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="orderstatus.cfm?method=edit&amp;ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#">Edit</a> /
		<a href="orderstatus.cfm?method=clone&amp;ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="orderstatus.cfm?method=read&amp;ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#">Read</a> /
		<a href="orderstatus.cfm?method=clone&amp;ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="orderstatus.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />