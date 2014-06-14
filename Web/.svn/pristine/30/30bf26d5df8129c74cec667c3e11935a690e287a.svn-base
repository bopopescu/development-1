<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.GALLERYADMINID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="GALLERYADMINID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Galleryadmin</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset galleryadminArray = application.galleryadminService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.galleryadminService.count() />
		<cf_galleryadminBreadcrumb method="list"/>
		<cf_galleryadminSearch q="#url.q#" />
		<cf_galleryadminList orderby="#url.orderby#" galleryadminArray = "#galleryadminArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset galleryadminArray = application.galleryadminService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.galleryadminService.searchCount(url.q) />
		<cf_galleryadminBreadcrumb method="list"/>
		<cf_galleryadminSearch q="#url.q#" />
		<cf_galleryadminList method="searchresult" q="#url.q#" orderby="#url.orderby#" galleryadminArray = "#galleryadminArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset galleryadmin = application.galleryadminService.get(url.GALLERYADMINID) />
		<cf_galleryadminBreadcrumb method="read" galleryadmin = "#galleryadmin#"/>
		<cf_galleryadminSearch q="#url.q#" />
		<cf_galleryadminRead galleryadmin = "#galleryadmin#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.GALLERYADMINID eq 0>
			<cfset galleryadmin = New galleryadmin() />
			<cfset new = true />
		<cfelse>
			<cfset galleryadmin = application.galleryadminService.get(url.GALLERYADMINID) />
			<cfset new = false />
		</cfif>
		<cf_galleryadminBreadcrumb method="edit" galleryadmin = "#galleryadmin#"  new="#new#" /> 

		<cf_galleryadminEdit galleryadmin = "#galleryadmin#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.galleryadminService.get(url.GALLERYADMINID) />
		<cfset galleryadmin = entityNew("galleryadmin") />
		<cfset galleryadmin.setFIRSTNAME(ref.getFIRSTNAME())  />
		<cfset galleryadmin.setLASTNAME(ref.getLASTNAME())  />
		<cfset galleryadmin.setEMAIL(ref.getEMAIL())  />
		<cfset galleryadmin.setADMINPASSWORD(ref.getADMINPASSWORD())  />

		<cf_galleryadminBreadcrumb method="new" galleryadmin = "#galleryadmin#"  new="true" /> 

		<cf_galleryadminEdit galleryadmin = "#galleryadmin#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset galleryadmin = EntityNew("galleryadmin") />
		<cfset galleryadmin = galleryadmin.populate(form) />
		<cfset application.galleryadminService.update(galleryadmin) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset galleryadmin = application.galleryadminService.get(url.GALLERYADMINID) />
		<cfset application.galleryadminService.destroy(galleryadmin) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>