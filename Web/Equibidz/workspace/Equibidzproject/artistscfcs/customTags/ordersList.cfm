<!--- ordersList.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.ordersArray" type="array" />
<cfparam name="attributes.maxresults" type="numeric" default="-1" />
<cfparam name="attributes.offset" type="numeric" default="-1" />
<cfparam name="attributes.orderby" type="string" default="" />
<cfparam name="attributes.q" type="string" default="" />
<cfparam name="attributes.method" type="string" default="list" />
<cfparam name="attributes.totalCount" type="numeric" default="0" />

<cfset ordersCount = attributes.totalCount  />
<cfset prevOffset = attributes.offset - attributes.maxresults />
<cfset nextOffset = attributes.offset + attributes.maxresults />
<cfset pages = Ceiling(ordersCount / attributes.maxresults) />


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
			<!--- Header for ORDERID --->
			<cfset ORDERIDascOrDesc = (FindNoCase("ORDERID asc", url.orderby))? "desc" : "asc" />
			<cfset ORDERIDascOrDescIcon = (FindNoCase("ORDERID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ORDERID #ORDERIDascOrDesc#&amp;q=#attributes.q#">Orderid #ORDERIDascOrDescIcon#</a></th>

			<!--- Header for TAX --->
			<cfset TAXascOrDesc = (FindNoCase("TAX asc", url.orderby))? "desc" : "asc" />
			<cfset TAXascOrDescIcon = (FindNoCase("TAX asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=TAX #TAXascOrDesc#&amp;q=#attributes.q#">Tax #TAXascOrDescIcon#</a></th>

			<!--- Header for TOTAL --->
			<cfset TOTALascOrDesc = (FindNoCase("TOTAL asc", url.orderby))? "desc" : "asc" />
			<cfset TOTALascOrDescIcon = (FindNoCase("TOTAL asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=TOTAL #TOTALascOrDesc#&amp;q=#attributes.q#">Total #TOTALascOrDescIcon#</a></th>

			<!--- Header for ORDERDATE --->
			<cfset ORDERDATEascOrDesc = (FindNoCase("ORDERDATE asc", url.orderby))? "desc" : "asc" />
			<cfset ORDERDATEascOrDescIcon = (FindNoCase("ORDERDATE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ORDERDATE #ORDERDATEascOrDesc#&amp;q=#attributes.q#">Orderdate #ORDERDATEascOrDescIcon#</a></th>

			<!--- Header for ORDERSTATUSID --->
			<cfset ORDERSTATUSIDascOrDesc = (FindNoCase("ORDERSTATUSID asc", url.orderby))? "desc" : "asc" />
			<cfset ORDERSTATUSIDascOrDescIcon = (FindNoCase("ORDERSTATUSID asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=ORDERSTATUSID #ORDERSTATUSIDascOrDesc#&amp;q=#attributes.q#">Orderstatusid #ORDERSTATUSIDascOrDescIcon#</a></th>

			<!--- Header for CUSTOMERFIRSTNAME --->
			<cfset CUSTOMERFIRSTNAMEascOrDesc = (FindNoCase("CUSTOMERFIRSTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset CUSTOMERFIRSTNAMEascOrDescIcon = (FindNoCase("CUSTOMERFIRSTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=CUSTOMERFIRSTNAME #CUSTOMERFIRSTNAMEascOrDesc#&amp;q=#attributes.q#">Customerfirstname #CUSTOMERFIRSTNAMEascOrDescIcon#</a></th>

			<!--- Header for CUSTOMERLASTNAME --->
			<cfset CUSTOMERLASTNAMEascOrDesc = (FindNoCase("CUSTOMERLASTNAME asc", url.orderby))? "desc" : "asc" />
			<cfset CUSTOMERLASTNAMEascOrDescIcon = (FindNoCase("CUSTOMERLASTNAME asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=CUSTOMERLASTNAME #CUSTOMERLASTNAMEascOrDesc#&amp;q=#attributes.q#">Customerlastname #CUSTOMERLASTNAMEascOrDescIcon#</a></th>

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

			<!--- Header for PHONE --->
			<cfset PHONEascOrDesc = (FindNoCase("PHONE asc", url.orderby))? "desc" : "asc" />
			<cfset PHONEascOrDescIcon = (FindNoCase("PHONE asc", url.orderby))? "&darr;" : "&uarr;" />
			<th><a href="?method=#attributes.method#&amp;offset=#attributes.offset#&amp;maxresults=#attributes.maxresults#&amp;orderby=PHONE #PHONEascOrDesc#&amp;q=#attributes.q#">Phone #PHONEascOrDescIcon#</a></th>

		</tr>
	</thead>
	<tbody>
	<cfloop index="i" from="1" to="#ArrayLen(attributes.ordersArray)#">
		<cfset orders = attributes.ordersArray[i] />
		<tr<cfif i mod 2> class="odd"</cfif>>
			<td>#orders.getORDERID()#</td>
			<td>#orders.getTAX()#</td>
			<td>#orders.getTOTAL()#</td>
			<td>#dateFormat(orders.getORDERDATE(),"mm/dd/yyyy" )# #timeFormat(orders.getORDERDATE(),"h:mm tt" )#</td>
			<td>#orders.getORDERSTATUSID()#</td>
			<td>#orders.getCUSTOMERFIRSTNAME()#</td>
			<td>#orders.getCUSTOMERLASTNAME()#</td>
			<td>#orders.getADDRESS()#</td>
			<td>#orders.getCITY()#</td>
			<td>#orders.getSTATE()#</td>
			<td>#orders.getPOSTALCODE()#</td>
			<td>#orders.getPHONE()#</td>
			<td class="crudlink"><a href="orders.cfm?method=read&ORDERID=#orders.getORDERID()#">Read</a></td>
			<td class="crudlink"><a href="orders.cfm?method=edit&ORDERID=#orders.getORDERID()#">Edit</a></td>
			<td class="crudlink"><a href="orders.cfm?method=delete_process&ORDERID=#orders.getORDERID()#" onclick="if (confirm('Are you sure?')) { return true}; return false"">Delete</a></td>
		</tr>
	</cfloop>
<cfif attributes.offset gte 0>
<cfif pages gt 1>
	<tr>
	<td colspan="15">
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
					<cfif nextOffset lt ordersCount>
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