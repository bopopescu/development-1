<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.MEDIAID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="MEDIAID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.*" />
<cf_pageWrapper>

<h2>Media</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset mediaArray = application.mediaService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.mediaService.count() />
		<cf_mediaBreadcrumb method="list"/>
		<cf_mediaSearch q="#url.q#" />
		<cf_mediaList orderby="#url.orderby#" mediaArray = "#mediaArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset mediaArray = application.mediaService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.mediaService.searchCount(url.q) />
		<cf_mediaBreadcrumb method="list"/>
		<cf_mediaSearch q="#url.q#" />
		<cf_mediaList method="searchresult" q="#url.q#" orderby="#url.orderby#" mediaArray = "#mediaArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset media = application.mediaService.get(url.MEDIAID) />
		<cf_mediaBreadcrumb method="read" media = "#media#"/>
		<cf_mediaSearch q="#url.q#" />
		<cf_mediaRead media = "#media#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.MEDIAID eq 0>
			<cfset media = New media() />
			<cfset new = true />
		<cfelse>
			<cfset media = application.mediaService.get(url.MEDIAID) />
			<cfset new = false />
		</cfif>
		<cf_mediaBreadcrumb method="edit" media = "#media#"  new="#new#" /> 

		<cf_mediaEdit media = "#media#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.mediaService.get(url.MEDIAID) />
		<cfset media = entityNew("media") />
		<cfset media.setMEDIATYPE(ref.getMEDIATYPE())  />

		<cf_mediaBreadcrumb method="new" media = "#media#"  new="true" /> 

		<cf_mediaEdit media = "#media#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset media = EntityNew("media") />
		<cfset media = media.populate(form) />
		<cfset application.mediaService.update(media) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&MEDIAID=#media.getMEDIAID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset media = application.mediaService.get(url.MEDIAID) />
		<cfset application.mediaService.destroy(media) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>