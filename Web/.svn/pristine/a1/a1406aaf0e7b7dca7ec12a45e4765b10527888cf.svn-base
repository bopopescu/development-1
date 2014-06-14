<!--- orderitemsBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.orderitems" type="any" default="" />
<cfset new = attributes.new />
<cfset orderitems = attributes.orderitems />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="orderitems.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="orderitems.cfm?method=edit&amp;ORDERITEMID=#orderitems.getORDERITEMID()#">Edit</a> /
		<a href="orderitems.cfm?method=clone&amp;ORDERITEMID=#orderitems.getORDERITEMID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="orderitems.cfm?method=read&amp;ORDERITEMID=#orderitems.getORDERITEMID()#">Read</a> /
		<a href="orderitems.cfm?method=clone&amp;ORDERITEMID=#orderitems.getORDERITEMID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="orderitems.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />