<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.ARTID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="ARTID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Art</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset artArray = application.artService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.artService.count() />
		<cf_artBreadcrumb method="list"/>
		<cf_artSearch q="#url.q#" />
		<cf_artList orderby="#url.orderby#" artArray = "#artArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset artArray = application.artService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.artService.searchCount(url.q) />
		<cf_artBreadcrumb method="list"/>
		<cf_artSearch q="#url.q#" />
		<cf_artList method="searchresult" q="#url.q#" orderby="#url.orderby#" artArray = "#artArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset art = application.artService.get(url.ARTID) />
		<cf_artBreadcrumb method="read" art = "#art#"/>
		<cf_artSearch q="#url.q#" />
		<cf_artRead art = "#art#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.ARTID eq 0>
			<cfset art = New art() />
			<cfset new = true />
		<cfelse>
			<cfset art = application.artService.get(url.ARTID) />
			<cfset new = false />
		</cfif>
		<cf_artBreadcrumb method="edit" art = "#art#"  new="#new#" /> 

		<cf_artEdit art = "#art#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.artService.get(url.ARTID) />
		<cfset art = entityNew("art") />
		<cfset art.setARTISTID(ref.getARTISTID())  />
		<cfset art.setARTNAME(ref.getARTNAME())  />
		<cfset art.setDESCRIPTION(ref.getDESCRIPTION())  />
		<cfset art.setPRICE(ref.getPRICE())  />
		<cfset art.setLARGEIMAGE(ref.getLARGEIMAGE())  />
		<cfset art.setMEDIAID(ref.getMEDIAID())  />
		<cfset art.setISSOLD(ref.getISSOLD())  />

		<cf_artBreadcrumb method="new" art = "#art#"  new="true" /> 

		<cf_artEdit art = "#art#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset art = EntityNew("art") />
		<cfset art = art.populate(form) />
		<cfset application.artService.update(art) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&ARTID=#art.getARTID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset art = application.artService.get(url.ARTID) />
		<cfset application.artService.destroy(art) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>