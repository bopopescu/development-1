<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.ARTISTID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="ARTISTID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Artists</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset artistsArray = application.artistsService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.artistsService.count() />
		<cf_artistsBreadcrumb method="list"/>
		<cf_artistsSearch q="#url.q#" />
		<cf_artistsList orderby="#url.orderby#" artistsArray = "#artistsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset artistsArray = application.artistsService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.artistsService.searchCount(url.q) />
		<cf_artistsBreadcrumb method="list"/>
		<cf_artistsSearch q="#url.q#" />
		<cf_artistsList method="searchresult" q="#url.q#" orderby="#url.orderby#" artistsArray = "#artistsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset artists = application.artistsService.get(url.ARTISTID) />
		<cf_artistsBreadcrumb method="read" artists = "#artists#"/>
		<cf_artistsSearch q="#url.q#" />
		<cf_artistsRead artists = "#artists#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.ARTISTID eq 0>
			<cfset artists = New artists() />
			<cfset new = true />
		<cfelse>
			<cfset artists = application.artistsService.get(url.ARTISTID) />
			<cfset new = false />
		</cfif>
		<cf_artistsBreadcrumb method="edit" artists = "#artists#"  new="#new#" /> 

		<cf_artistsEdit artists = "#artists#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.artistsService.get(url.ARTISTID) />
		<cfset artists = entityNew("artists") />
		<cfset artists.setFIRSTNAME(ref.getFIRSTNAME())  />
		<cfset artists.setLASTNAME(ref.getLASTNAME())  />
		<cfset artists.setADDRESS(ref.getADDRESS())  />
		<cfset artists.setCITY(ref.getCITY())  />
		<cfset artists.setSTATE(ref.getSTATE())  />
		<cfset artists.setPOSTALCODE(ref.getPOSTALCODE())  />
		<cfset artists.setEMAIL(ref.getEMAIL())  />
		<cfset artists.setPHONE(ref.getPHONE())  />
		<cfset artists.setFAX(ref.getFAX())  />
		<cfset artists.setTHEPASSWORD(ref.getTHEPASSWORD())  />

		<cf_artistsBreadcrumb method="new" artists = "#artists#"  new="true" /> 

		<cf_artistsEdit artists = "#artists#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset artists = EntityNew("artists") />
		<cfset artists = artists.populate(form) />
		<cfset application.artistsService.update(artists) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&ARTISTID=#artists.getARTISTID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset artists = application.artistsService.get(url.ARTISTID) />
		<cfset application.artistsService.destroy(artists) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>