<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.ORDERSTATUSID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="ORDERSTATUSID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Orderstatus</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset orderstatusArray = application.orderstatusService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.orderstatusService.count() />
		<cf_orderstatusBreadcrumb method="list"/>
		<cf_orderstatusSearch q="#url.q#" />
		<cf_orderstatusList orderby="#url.orderby#" orderstatusArray = "#orderstatusArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset orderstatusArray = application.orderstatusService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.orderstatusService.searchCount(url.q) />
		<cf_orderstatusBreadcrumb method="list"/>
		<cf_orderstatusSearch q="#url.q#" />
		<cf_orderstatusList method="searchresult" q="#url.q#" orderby="#url.orderby#" orderstatusArray = "#orderstatusArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset orderstatus = application.orderstatusService.get(url.ORDERSTATUSID) />
		<cf_orderstatusBreadcrumb method="read" orderstatus = "#orderstatus#"/>
		<cf_orderstatusSearch q="#url.q#" />
		<cf_orderstatusRead orderstatus = "#orderstatus#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.ORDERSTATUSID eq 0>
			<cfset orderstatus = New orderstatus() />
			<cfset new = true />
		<cfelse>
			<cfset orderstatus = application.orderstatusService.get(url.ORDERSTATUSID) />
			<cfset new = false />
		</cfif>
		<cf_orderstatusBreadcrumb method="edit" orderstatus = "#orderstatus#"  new="#new#" /> 

		<cf_orderstatusEdit orderstatus = "#orderstatus#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.orderstatusService.get(url.ORDERSTATUSID) />
		<cfset orderstatus = entityNew("orderstatus") />
		<cfset orderstatus.setSTATUS(ref.getSTATUS())  />

		<cf_orderstatusBreadcrumb method="new" orderstatus = "#orderstatus#"  new="true" /> 

		<cf_orderstatusEdit orderstatus = "#orderstatus#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset orderstatus = EntityNew("orderstatus") />
		<cfset orderstatus = orderstatus.populate(form) />
		<cfset application.orderstatusService.update(orderstatus) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset orderstatus = application.orderstatusService.get(url.ORDERSTATUSID) />
		<cfset application.orderstatusService.destroy(orderstatus) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>