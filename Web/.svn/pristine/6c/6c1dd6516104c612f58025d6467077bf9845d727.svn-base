<!--- ordersRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orders" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset orders = attributes.orders /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Orderid</th>
			<td>#orders.getORDERID()#</td>
		</tr>
		<tr>
			<th>Tax</th>
			<td>#orders.getTAX()#</td>
		</tr>
		<tr>
			<th>Total</th>
			<td>#orders.getTOTAL()#</td>
		</tr>
		<tr>
			<th>Orderdate</th>
			<td>#dateFormat(orders.getORDERDATE(),"mm/dd/yyyy" )# #timeFormat(orders.getORDERDATE(),"h:mm tt" )#</td>
		</tr>
		<tr>
			<th>Orderstatusid</th>
			<td>#orders.getORDERSTATUSID()#</td>
		</tr>
		<tr>
			<th>Customerfirstname</th>
			<td>#orders.getCUSTOMERFIRSTNAME()#</td>
		</tr>
		<tr>
			<th>Customerlastname</th>
			<td>#orders.getCUSTOMERLASTNAME()#</td>
		</tr>
		<tr>
			<th>Address</th>
			<td>#orders.getADDRESS()#</td>
		</tr>
		<tr>
			<th>City</th>
			<td>#orders.getCITY()#</td>
		</tr>
		<tr>
			<th>State</th>
			<td>#orders.getSTATE()#</td>
		</tr>
		<tr>
			<th>Postalcode</th>
			<td>#orders.getPOSTALCODE()#</td>
		</tr>
		<tr>
			<th>Phone</th>
			<td>#orders.getPHONE()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />