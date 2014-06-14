<!--- artistsList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.artistsArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset artistsCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(artistsCount / attributes.maxresults) />


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
			<!--- Header for ARTISTID --->
			<cfset ARTISTIDascOrDesc = (FindNoCase("ARTISTID asc", url.orderby))? "desc" : "asc" />
			<cfset ARTISTIDascOrDescIcon = (FindNoCase("ARTISTID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ARTISTID #ARTISTIDascOrDesc#&amp;q=#attributes.q#">Artistid #ARTISTIDascOrDescIcon#</a></th>

			<!--- Header for FIRSTNAME --->
			<cfset FIRSTNAMEascOrDesc = (FindNoCase("FIRSTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset FIRSTNAMEascOrDescIcon = (FindNoCase("FIRSTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=FIRSTNAME #FIRSTNAMEascOrDesc#&amp;q=#attributes.q#">Firstname #FIRSTNAMEascOrDescIcon#</a></th>

			<!--- Header for LASTNAME --->
			<cfset LASTNAMEascOrDesc = (FindNoCase("LASTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset LASTNAMEascOrDescIcon = (FindNoCase("LASTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=LASTNAME #LASTNAMEascOrDesc#&amp;q=#attributes.q#">Lastname #LASTNAMEascOrDescIcon#</a></th>

			<!--- Header for ADDRESS --->
			<cfset ADDRESSascOrDesc = (FindNoCase("ADDRESS asc", url.orderby))? "desc" : "asc" />
			<cfset ADDRESSascOrDescIcon = (FindNoCase("ADDRESS asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ADDRESS #ADDRESSascOrDesc#&amp;q=#attributes.q#">Address #ADDRESSascOrDescIcon#</a></th>

			<!--- Header for CITY --->
			<cfset CITYascOrDesc = (FindNoCase("CITY asc", url.orderby))? "desc" : "asc" />
			<cfset CITYascOrDescIcon = (FindNoCase("CITY asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=CITY #CITYascOrDesc#&amp;q=#attributes.q#">City #CITYascOrDescIcon#</a></th>

			<!--- Header for STATE --->
			<cfset STATEascOrDesc = (FindNoCase("STATE asc", url.orderby))? "desc" : "asc" />
			<cfset STATEascOrDescIcon = (FindNoCase("STATE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=STATE #STATEascOrDesc#&amp;q=#attributes.q#">State #STATEascOrDescIcon#</a></th>

			<!--- Header for POSTALCODE --->
			<cfset POSTALCODEascOrDesc = (FindNoCase("POSTALCODE asc", url.orderby))? "desc" : "asc" />
			<cfset POSTALCODEascOrDescIcon = (FindNoCase("POSTALCODE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=POSTALCODE #POSTALCODEascOrDesc#&amp;q=#attributes.q#">Postalcode #POSTALCODEascOrDescIcon#</a></th>

			<!--- Header for EMAIL --->
			<cfset EMAILascOrDesc = (FindNoCase("EMAIL asc", url.orderby))? "desc" : "asc" />
			<cfset EMAILascOrDescIcon = (FindNoCase("EMAIL asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=EMAIL #EMAILascOrDesc#&amp;q=#attributes.q#">Email #EMAILascOrDescIcon#</a></th>

			<!--- Header for PHONE --->
			<cfset PHONEascOrDesc = (FindNoCase("PHONE asc", url.orderby))? "desc" : "asc" />
			<cfset PHONEascOrDescIcon = (FindNoCase("PHONE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=PHONE #PHONEascOrDesc#&amp;q=#attributes.q#">Phone #PHONEascOrDescIcon#</a></th>

			<!--- Header for FAX --->
			<cfset FAXascOrDesc = (FindNoCase("FAX asc", url.orderby))? "desc" : "asc" />
			<cfset FAXascOrDescIcon = (FindNoCase("FAX asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=FAX #FAXascOrDesc#&amp;q=#attributes.q#">Fax #FAXascOrDescIcon#</a></th>

			<!--- Header for THEPASSWORD --->
			<cfset THEPASSWORDascOrDesc = (FindNoCase("THEPASSWORD asc", url.orderby))? "desc" : "asc" />
			<cfset THEPASSWORDascOrDescIcon = (FindNoCase("THEPASSWORD asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=THEPASSWORD #THEPASSWORDascOrDesc#&amp;q=#attributes.q#">Thepassword #THEPASSWORDascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.artistsArray)#">
		<cfset artists = attributes.artistsArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#artists.getARTISTID()#</td>
			<td>#artists.getFIRSTNAME()#</td>
			<td>#artists.getLASTNAME()#</td>
			<td>#artists.getADDRESS()#</td>
			<td>#artists.getCITY()#</td>
			<td>#artists.getSTATE()#</td>
			<td>#artists.getPOSTALCODE()#</td>
			<td>#artists.getEMAIL()#</td>
			<td>#artists.getPHONE()#</td>
			<td>#artists.getFAX()#</td>
			<td>#artists.getTHEPASSWORD()#</td>
			<td class="crudlink"><a href="artists.cfm?method=read&ARTISTID=#artists.getARTISTID()#">Read</a></td>
			<td class="crudlink"><a href="artists.cfm?method=edit&ARTISTID=#artists.getARTISTID()#">Edit</a></td>
			<td class="crudlink"><a href="artists.cfm?method=delete_process&ARTISTID=#artists.getARTISTID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="14">
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
					<cfif nextOffset lt artistsCount>
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