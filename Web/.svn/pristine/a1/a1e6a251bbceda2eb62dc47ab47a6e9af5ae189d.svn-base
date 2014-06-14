<!--- orderstatusRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orderstatus" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset orderstatus = attributes.orderstatus /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Orderstatusid</th>
			<td>#orderstatus.getORDERSTATUSID()#</td>
		</tr>
		<tr>
			<th>Status</th>
			<td>#orderstatus.getSTATUS()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />