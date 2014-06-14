<!--- orderstatusEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.orderstatus" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset orderstatus = attributes.orderstatus /> 
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
			<input name="ORDERSTATUSID" type="hidden" value="#orderstatus.getORDERSTATUSID()#" />
		<tr>
			<th><label for="STATUS">Status:</label></th>
			<td><input name="STATUS" type="text" id="STATUS" value="#orderstatus.getSTATUS()#" /></td>
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