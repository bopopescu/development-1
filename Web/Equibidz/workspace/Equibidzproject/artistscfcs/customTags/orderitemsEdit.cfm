<!--- orderitemsEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orderitems" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset orderitems = attributes.orderitems /> 
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
			<input name="ORDERITEMID" type="hidden" value="#orderitems.getORDERITEMID()#" />
		<tr>
			<th><label for="ORDERID">Orderid:</label></th>
			<td><input name="ORDERID" type="text" id="ORDERID" value="#orderitems.getORDERID()#" /></td>
		</tr>
		<tr>
			<th><label for="ARTID">Artid:</label></th>
			<td><input name="ARTID" type="text" id="ARTID" value="#orderitems.getARTID()#" /></td>
		</tr>
		<tr>
			<th><label for="PRICE">Price:</label></th>
			<td><input name="PRICE" type="text" id="PRICE" value="#orderitems.getPRICE()#" /></td>
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