<!--- orderitemsList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orderitemsArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset orderitemsCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(orderitemsCount / attributes.maxresults) />


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
			<!--- Header for ORDERITEMID --->
			<cfset ORDERITEMIDascOrDesc = (FindNoCase("ORDERITEMID asc", url.orderby))? "desc" : "asc" />
			<cfset ORDERITEMIDascOrDescIcon = (FindNoCase("ORDERITEMID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ORDERITEMID #ORDERITEMIDascOrDesc#&amp;q=#attributes.q#">Orderitemid #ORDERITEMIDascOrDescIcon#</a></th>

			<!--- Header for ORDERID --->
			<cfset ORDERIDascOrDesc = (FindNoCase("ORDERID asc", url.orderby))? "desc" : "asc" />
			<cfset ORDERIDascOrDescIcon = (FindNoCase("ORDERID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ORDERID #ORDERIDascOrDesc#&amp;q=#attributes.q#">Orderid #ORDERIDascOrDescIcon#</a></th>

			<!--- Header for ARTID --->
			<cfset ARTIDascOrDesc = (FindNoCase("ARTID asc", url.orderby))? "desc" : "asc" />
			<cfset ARTIDascOrDescIcon = (FindNoCase("ARTID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ARTID #ARTIDascOrDesc#&amp;q=#attributes.q#">Artid #ARTIDascOrDescIcon#</a></th>

			<!--- Header for PRICE --->
			<cfset PRICEascOrDesc = (FindNoCase("PRICE asc", url.orderby))? "desc" : "asc" />
			<cfset PRICEascOrDescIcon = (FindNoCase("PRICE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=PRICE #PRICEascOrDesc#&amp;q=#attributes.q#">Price #PRICEascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.orderitemsArray)#">
		<cfset orderitems = attributes.orderitemsArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#orderitems.getORDERITEMID()#</td>
			<td>#orderitems.getORDERID()#</td>
			<td>#orderitems.getARTID()#</td>
			<td>#orderitems.getPRICE()#</td>
			<td class="crudlink"><a href="orderitems.cfm?method=read&ORDERITEMID=#orderitems.getORDERITEMID()#">Read</a></td>
			<td class="crudlink"><a href="orderitems.cfm?method=edit&ORDERITEMID=#orderitems.getORDERITEMID()#">Edit</a></td>
			<td class="crudlink"><a href="orderitems.cfm?method=delete_process&ORDERITEMID=#orderitems.getORDERITEMID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="7">
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
					<cfif nextOffset lt orderitemsCount>
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