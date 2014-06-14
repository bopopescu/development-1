<!--- galleryadminList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.galleryadminArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset galleryadminCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(galleryadminCount / attributes.maxresults) />


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
			<!--- Header for GALLERYADMINID --->
			<cfset GALLERYADMINIDascOrDesc = (FindNoCase("GALLERYADMINID asc", url.orderby))? "desc" : "asc" />
			<cfset GALLERYADMINIDascOrDescIcon = (FindNoCase("GALLERYADMINID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=GALLERYADMINID #GALLERYADMINIDascOrDesc#&amp;q=#attributes.q#">Galleryadminid #GALLERYADMINIDascOrDescIcon#</a></th>

			<!--- Header for FIRSTNAME --->
			<cfset FIRSTNAMEascOrDesc = (FindNoCase("FIRSTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset FIRSTNAMEascOrDescIcon = (FindNoCase("FIRSTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=FIRSTNAME #FIRSTNAMEascOrDesc#&amp;q=#attributes.q#">Firstname #FIRSTNAMEascOrDescIcon#</a></th>

			<!--- Header for LASTNAME --->
			<cfset LASTNAMEascOrDesc = (FindNoCase("LASTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset LASTNAMEascOrDescIcon = (FindNoCase("LASTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=LASTNAME #LASTNAMEascOrDesc#&amp;q=#attributes.q#">Lastname #LASTNAMEascOrDescIcon#</a></th>

			<!--- Header for EMAIL --->
			<cfset EMAILascOrDesc = (FindNoCase("EMAIL asc", url.orderby))? "desc" : "asc" />
			<cfset EMAILascOrDescIcon = (FindNoCase("EMAIL asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=EMAIL #EMAILascOrDesc#&amp;q=#attributes.q#">Email #EMAILascOrDescIcon#</a></th>

			<!--- Header for ADMINPASSWORD --->
			<cfset ADMINPASSWORDascOrDesc = (FindNoCase("ADMINPASSWORD asc", url.orderby))? "desc" : "asc" />
			<cfset ADMINPASSWORDascOrDescIcon = (FindNoCase("ADMINPASSWORD asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ADMINPASSWORD #ADMINPASSWORDascOrDesc#&amp;q=#attributes.q#">Adminpassword #ADMINPASSWORDascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.galleryadminArray)#">
		<cfset galleryadmin = attributes.galleryadminArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#galleryadmin.getGALLERYADMINID()#</td>
			<td>#galleryadmin.getFIRSTNAME()#</td>
			<td>#galleryadmin.getLASTNAME()#</td>
			<td>#galleryadmin.getEMAIL()#</td>
			<td>#galleryadmin.getADMINPASSWORD()#</td>
			<td class="crudlink"><a href="galleryadmin.cfm?method=read&GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#">Read</a></td>
			<td class="crudlink"><a href="galleryadmin.cfm?method=edit&GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#">Edit</a></td>
			<td class="crudlink"><a href="galleryadmin.cfm?method=delete_process&GALLERYADMINID=#galleryadmin.getGALLERYADMINID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="8">
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
					<cfif nextOffset lt galleryadminCount>
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