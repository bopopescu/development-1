<!--- ordersEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orders" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset orders = attributes.orders /> 
<cfset message = attributes.message /> 
<cfif CompareNoCase(message, "updated") eq 0>
	<p class="alert">Record updated</p>
<cfelse>
	<p></p>
</cfif>
<cfoutput>
<cfform action="?method=edit_process" method="post" format="html" enctype="multipart/form-data">
	<table>
	<tbody>
			<input name="ORDERID" type="hidden" value="#orders.getORDERID()#" />
		<tr>
			<th><label for="TAX">Tax:</label></th>
			<td><input name="TAX" type="text" id="TAX" value="#orders.getTAX()#" /></td>
		</tr>
		<tr>
			<th><label for="TOTAL">Total:</label></th>
			<td><input name="TOTAL" type="text" id="TOTAL" value="#orders.getTOTAL()#" /></td>
		</tr>
		<tr>
			<th><label for="ORDERDATE">Orderdate:</label></th>
			<td><input name="ORDERDATE" type="text" id="ORDERDATE" value="#orders.getORDERDATE()#" /></td>
		</tr>
		<tr>
			<th><label for="ORDERSTATUSID">Orderstatusid:</label></th>
			<td><input name="ORDERSTATUSID" type="text" id="ORDERSTATUSID" value="#orders.getORDERSTATUSID()#" /></td>
		</tr>
		<tr>
			<th><label for="CUSTOMERFIRSTNAME">Customerfirstname:</label></th>
			<td><input name="CUSTOMERFIRSTNAME" type="text" id="CUSTOMERFIRSTNAME" value="#orders.getCUSTOMERFIRSTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="CUSTOMERLASTNAME">Customerlastname:</label></th>
			<td><input name="CUSTOMERLASTNAME" type="text" id="CUSTOMERLASTNAME" value="#orders.getCUSTOMERLASTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="ADDRESS">Address:</label></th>
			<td><input name="ADDRESS" type="text" id="ADDRESS" value="#orders.getADDRESS()#" /></td>
		</tr>
		<tr>
			<th><label for="CITY">City:</label></th>
			<td><input name="CITY" type="text" id="CITY" value="#orders.getCITY()#" /></td>
		</tr>
		<tr>
			<th><label for="STATE">State:</label></th>
			<td><input name="STATE" type="text" id="STATE" value="#orders.getSTATE()#" /></td>
		</tr>
		<tr>
			<th><label for="POSTALCODE">Postalcode:</label></th>
			<td><input name="POSTALCODE" type="text" id="POSTALCODE" value="#orders.getPOSTALCODE()#" /></td>
		</tr>
		<tr>
			<th><label for="PHONE">Phone:</label></th>
			<td><input name="PHONE" type="text" id="PHONE" value="#orders.getPHONE()#" /></td>
		</tr>
		<tr>
			<th />
			<td><input name="save" type="submit" value="Save" /></td>
		</tr>
	</tbody>
	</table>
</cfform>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />