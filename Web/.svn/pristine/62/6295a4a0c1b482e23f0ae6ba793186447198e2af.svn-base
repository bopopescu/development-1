<!--- ordersBreadcrumb.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.new" type="boolean" default="false" />
<cfparam name="attributes.orders" type="any" default="" />
<cfset new = attributes.new />
<cfset orders = attributes.orders />
<cfset method = attributes.method />

<cfoutput><p class="breadcrumb">
	<a href="index.cfm">Main</a> / 
		<a href="orders.cfm?method=list">List</a> /
		<cfif CompareNoCase(method, "read") eq 0>
		<a href="orders.cfm?method=edit&amp;ORDERID=#orders.getORDERID()#">Edit</a> /
		<a href="orders.cfm?method=clone&amp;ORDERID=#orders.getORDERID()#&amp;message=clone">Clone</a> /
		</cfif>
		<cfif CompareNoCase(method, "edit") eq 0 and not new>
		<a href="orders.cfm?method=read&amp;ORDERID=#orders.getORDERID()#">Read</a> /
		<a href="orders.cfm?method=clone&amp;ORDERID=#orders.getORDERID()#&amp;message=clone">Clone</a> /
		</cfif>
	<a href="orders.cfm?method=edit">New</a>
</p></cfoutput>

</cfprocessingdirective>
<cfexit method="exitTag" />