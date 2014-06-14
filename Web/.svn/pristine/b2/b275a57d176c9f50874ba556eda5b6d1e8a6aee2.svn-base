<!--- artList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.artArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset artCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(artCount / attributes.maxresults) />


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
			<!--- Header for ARTID --->
			<cfset ARTIDascOrDesc = (FindNoCase("ARTID asc", url.orderby))? "desc" : "asc" />
			<cfset ARTIDascOrDescIcon = (FindNoCase("ARTID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ARTID #ARTIDascOrDesc#&amp;q=#attributes.q#">Artid #ARTIDascOrDescIcon#</a></th>

			<!--- Header for ARTISTID --->
			<cfset ARTISTIDascOrDesc = (FindNoCase("ARTISTID asc", url.orderby))? "desc" : "asc" />
			<cfset ARTISTIDascOrDescIcon = (FindNoCase("ARTISTID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ARTISTID #ARTISTIDascOrDesc#&amp;q=#attributes.q#">Artistid #ARTISTIDascOrDescIcon#</a></th>

			<!--- Header for ARTNAME --->
			<cfset ARTNAMEascOrDesc = (FindNoCase("ARTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset ARTNAMEascOrDescIcon = (FindNoCase("ARTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ARTNAME #ARTNAMEascOrDesc#&amp;q=#attributes.q#">Artname #ARTNAMEascOrDescIcon#</a></th>

			<!--- Header for DESCRIPTION --->
			<cfset DESCRIPTIONascOrDesc = (FindNoCase("DESCRIPTION asc", url.orderby))? "desc" : "asc" />
			<cfset DESCRIPTIONascOrDescIcon = (FindNoCase("DESCRIPTION asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=DESCRIPTION #DESCRIPTIONascOrDesc#&amp;q=#attributes.q#">Description #DESCRIPTIONascOrDescIcon#</a></th>

			<!--- Header for PRICE --->
			<cfset PRICEascOrDesc = (FindNoCase("PRICE asc", url.orderby))? "desc" : "asc" />
			<cfset PRICEascOrDescIcon = (FindNoCase("PRICE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=PRICE #PRICEascOrDesc#&amp;q=#attributes.q#">Price #PRICEascOrDescIcon#</a></th>

			<!--- Header for LARGEIMAGE --->
			<cfset LARGEIMAGEascOrDesc = (FindNoCase("LARGEIMAGE asc", url.orderby))? "desc" : "asc" />
			<cfset LARGEIMAGEascOrDescIcon = (FindNoCase("LARGEIMAGE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=LARGEIMAGE #LARGEIMAGEascOrDesc#&amp;q=#attributes.q#">Largeimage #LARGEIMAGEascOrDescIcon#</a></th>

			<!--- Header for MEDIAID --->
			<cfset MEDIAIDascOrDesc = (FindNoCase("MEDIAID asc", url.orderby))? "desc" : "asc" />
			<cfset MEDIAIDascOrDescIcon = (FindNoCase("MEDIAID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=MEDIAID #MEDIAIDascOrDesc#&amp;q=#attributes.q#">Mediaid #MEDIAIDascOrDescIcon#</a></th>

			<!--- Header for ISSOLD --->
			<cfset ISSOLDascOrDesc = (FindNoCase("ISSOLD asc", url.orderby))? "desc" : "asc" />
			<cfset ISSOLDascOrDescIcon = (FindNoCase("ISSOLD asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ISSOLD #ISSOLDascOrDesc#&amp;q=#attributes.q#">Issold #ISSOLDascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.artArray)#">
		<cfset art = attributes.artArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#art.getARTID()#</td>
			<td>#art.getARTISTID()#</td>
			<td>#art.getARTNAME()#</td>
			<td>#art.getDESCRIPTION()#</td>
			<td>#art.getPRICE()#</td>
			<td>#art.getLARGEIMAGE()#</td>
			<td>#art.getMEDIAID()#</td>
			<td>#art.getISSOLD()#</td>
			<td class="crudlink"><a href="art.cfm?method=read&ARTID=#art.getARTID()#">Read</a></td>
			<td class="crudlink"><a href="art.cfm?method=edit&ARTID=#art.getARTID()#">Edit</a></td>
			<td class="crudlink"><a href="art.cfm?method=delete_process&ARTID=#art.getARTID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="11">
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
					<cfif nextOffset lt artCount>
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