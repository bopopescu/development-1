<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.ORDERID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="ORDERID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Orders</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset ordersArray = application.ordersService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.ordersService.count() />
		<cf_ordersBreadcrumb method="list"/>
		<cf_ordersSearch q="#url.q#" />
		<cf_ordersList orderby="#url.orderby#" ordersArray = "#ordersArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset ordersArray = application.ordersService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.ordersService.searchCount(url.q) />
		<cf_ordersBreadcrumb method="list"/>
		<cf_ordersSearch q="#url.q#" />
		<cf_ordersList method="searchresult" q="#url.q#" orderby="#url.orderby#" ordersArray = "#ordersArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset orders = application.ordersService.get(url.ORDERID) />
		<cf_ordersBreadcrumb method="read" orders = "#orders#"/>
		<cf_ordersSearch q="#url.q#" />
		<cf_ordersRead orders = "#orders#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.ORDERID eq 0>
			<cfset orders = New orders() />
			<cfset new = true />
		<cfelse>
			<cfset orders = application.ordersService.get(url.ORDERID) />
			<cfset new = false />
		</cfif>
		<cf_ordersBreadcrumb method="edit" orders = "#orders#"  new="#new#" /> 

		<cf_ordersEdit orders = "#orders#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.ordersService.get(url.ORDERID) />
		<cfset orders = entityNew("orders") />
		<cfset orders.setTAX(ref.getTAX())  />
		<cfset orders.setTOTAL(ref.getTOTAL())  />
		<cfset orders.setORDERDATE(ref.getORDERDATE())  />
		<cfset orders.setORDERSTATUSID(ref.getORDERSTATUSID())  />
		<cfset orders.setCUSTOMERFIRSTNAME(ref.getCUSTOMERFIRSTNAME())  />
		<cfset orders.setCUSTOMERLASTNAME(ref.getCUSTOMERLASTNAME())  />
		<cfset orders.setADDRESS(ref.getADDRESS())  />
		<cfset orders.setCITY(ref.getCITY())  />
		<cfset orders.setSTATE(ref.getSTATE())  />
		<cfset orders.setPOSTALCODE(ref.getPOSTALCODE())  />
		<cfset orders.setPHONE(ref.getPHONE())  />

		<cf_ordersBreadcrumb method="new" orders = "#orders#"  new="true" /> 

		<cf_ordersEdit orders = "#orders#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset orders = EntityNew("orders") />
		<cfset orders = orders.populate(form) />
		<cfset application.ordersService.update(orders) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&ORDERID=#orders.getORDERID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset orders = application.ordersService.get(url.ORDERID) />
		<cfset application.ordersService.destroy(orders) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>