<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.ORDERITEMID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="ORDERITEMID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Orderitems</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset orderitemsArray = application.orderitemsService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.orderitemsService.count() />
		<cf_orderitemsBreadcrumb method="list"/>
		<cf_orderitemsSearch q="#url.q#" />
		<cf_orderitemsList orderby="#url.orderby#" orderitemsArray = "#orderitemsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset orderitemsArray = application.orderitemsService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.orderitemsService.searchCount(url.q) />
		<cf_orderitemsBreadcrumb method="list"/>
		<cf_orderitemsSearch q="#url.q#" />
		<cf_orderitemsList method="searchresult" q="#url.q#" orderby="#url.orderby#" orderitemsArray = "#orderitemsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset orderitems = application.orderitemsService.get(url.ORDERITEMID) />
		<cf_orderitemsBreadcrumb method="read" orderitems = "#orderitems#"/>
		<cf_orderitemsSearch q="#url.q#" />
		<cf_orderitemsRead orderitems = "#orderitems#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.ORDERITEMID eq 0>
			<cfset orderitems = New orderitems() />
			<cfset new = true />
		<cfelse>
			<cfset orderitems = application.orderitemsService.get(url.ORDERITEMID) />
			<cfset new = false />
		</cfif>
		<cf_orderitemsBreadcrumb method="edit" orderitems = "#orderitems#"  new="#new#" /> 

		<cf_orderitemsEdit orderitems = "#orderitems#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.orderitemsService.get(url.ORDERITEMID) />
		<cfset orderitems = entityNew("orderitems") />
		<cfset orderitems.setORDERID(ref.getORDERID())  />
		<cfset orderitems.setARTID(ref.getARTID())  />
		<cfset orderitems.setPRICE(ref.getPRICE())  />

		<cf_orderitemsBreadcrumb method="new" orderitems = "#orderitems#"  new="true" /> 

		<cf_orderitemsEdit orderitems = "#orderitems#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset orderitems = EntityNew("orderitems") />
		<cfset orderitems = orderitems.populate(form) />
		<cfset application.orderitemsService.update(orderitems) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&ORDERITEMID=#orderitems.getORDERITEMID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset orderitems = application.orderitemsService.get(url.ORDERITEMID) />
		<cfset application.orderitemsService.destroy(orderitems) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>