<!--- orderitemsRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orderitems" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset orderitems = attributes.orderitems /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Orderitemid</th>
			<td>#orderitems.getORDERITEMID()#</td>
		</tr>
		<tr>
			<th>Orderid</th>
			<td>#orderitems.getORDERID()#</td>
		</tr>
		<tr>
			<th>Artid</th>
			<td>#orderitems.getARTID()#</td>
		</tr>
		<tr>
			<th>Price</th>
			<td>#orderitems.getPRICE()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />