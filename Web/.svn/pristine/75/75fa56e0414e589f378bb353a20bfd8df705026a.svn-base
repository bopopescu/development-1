<!--- orderstatusList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orderstatusArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset orderstatusCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(orderstatusCount / attributes.maxresults) />


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
			<!--- Header for ORDERSTATUSID --->
			<cfset ORDERSTATUSIDascOrDesc = (FindNoCase("ORDERSTATUSID asc", url.orderby))? "desc" : "asc" />
			<cfset ORDERSTATUSIDascOrDescIcon = (FindNoCase("ORDERSTATUSID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ORDERSTATUSID #ORDERSTATUSIDascOrDesc#&amp;q=#attributes.q#">Orderstatusid #ORDERSTATUSIDascOrDescIcon#</a></th>

			<!--- Header for STATUS --->
			<cfset STATUSascOrDesc = (FindNoCase("STATUS asc", url.orderby))? "desc" : "asc" />
			<cfset STATUSascOrDescIcon = (FindNoCase("STATUS asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=STATUS #STATUSascOrDesc#&amp;q=#attributes.q#">Status #STATUSascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.orderstatusArray)#">
		<cfset orderstatus = attributes.orderstatusArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#orderstatus.getORDERSTATUSID()#</td>
			<td>#orderstatus.getSTATUS()#</td>
			<td class="crudlink"><a href="orderstatus.cfm?method=read&ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#">Read</a></td>
			<td class="crudlink"><a href="orderstatus.cfm?method=edit&ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#">Edit</a></td>
			<td class="crudlink"><a href="orderstatus.cfm?method=delete_process&ORDERSTATUSID=#orderstatus.getORDERSTATUSID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
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
					<cfif nextOffset lt orderstatusCount>
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