<!--- mediaList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.mediaArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset mediaCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(mediaCount / attributes.maxresults) />


<cfset message = attributes.message /> 
<cfif CompareNoCase(message, "deleted") eq 0>
	<p class="alert">Record deleted</p>
<cfelseif CompareNoCase(message, "search") eq 0>
	<p class="alert">Results for <em>"<cfoutput>#attributes.q#</cfoutput>"</em></p>
<cfelse>
	<p></p>
</cfif>
<cfoutput>
<table>
	<thead>
		<tr>
			<!--- Header for MEDIAID --->
			<cfset MEDIAIDascOrDesc = (FindNoCase("MEDIAID asc", url.orderby))? "desc" : "asc" />
			<cfset MEDIAIDascOrDescIcon = (FindNoCase("MEDIAID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=MEDIAID #MEDIAIDascOrDesc#&amp;q=#attributes.q#">Mediaid #MEDIAIDascOrDescIcon#</a></th>

			<!--- Header for MEDIATYPE --->
			<cfset MEDIATYPEascOrDesc = (FindNoCase("MEDIATYPE asc", url.orderby))? "desc" : "asc" />
			<cfset MEDIATYPEascOrDescIcon = (FindNoCase("MEDIATYPE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=MEDIATYPE #MEDIATYPEascOrDesc#&amp;q=#attributes.q#">Mediatype #MEDIATYPEascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.mediaArray)#">
		<cfset media = attributes.mediaArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#media.getMEDIAID()#</td>
			<td>#media.getMEDIATYPE()#</td>
			<td class="crudlink"><a href="media.cfm?method=read&MEDIAID=#media.getMEDIAID()#">Read</a></td>
			<td class="crudlink"><a href="media.cfm?method=edit&MEDIAID=#media.getMEDIAID()#">Edit</a></td>
			<td class="crudlink"><a href="media.cfm?method=delete_process&MEDIAID=#media.getMEDIAID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="5">
		<table class="listnav">
			<tr>
				<td class="prev">
					<cfif prevOffset gte 0>
						<a href="?method=#attributes.method#&amp;offset=#prevOffset#&amp;maxresults=#attributes.maxresults#&amp;orderby=#attributes.orderby#&amp;q=#url.q#">&larr; Prev</a>
					</cfif>
				</td>
				<td class="pages">
					<cfloop index="i" from="1" to="#pages#">
						<cfset offset = 0 + ((i -1) * attributes.maxresults) />
						<cfif offset eq attributes.offset>
							#i#
						<cfelse>
							<a href="?method=#attributes.method#&amp;offset=#offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=#attributes.orderby#&amp;q=#url.q#">#i#</a>
						</cfif>
					</cfloop>
				</td>
				<td class="next">
					<cfif nextOffset lt mediaCount>
					<a href="?method=#attributes.method#&amp;offset=#nextOffset#&amp;maxresults=#attributes.maxresults#&amp;orderby=#attributes.orderby#&amp;q=#url.q#">Next &rarr;<a/>
					</cfif>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</cfif>
	</tbody>
</cfif>
	</cfoutput>
</table>
</cfprocessingdirective>
<cfexit method="exitTag" />