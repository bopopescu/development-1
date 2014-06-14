<!--- mediaEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.media" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset media = attributes.media /> 
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
			<input name="MEDIAID" type="hidden" value="#media.getMEDIAID()#" />
		<tr>
			<th><label for="MEDIATYPE">Mediatype:</label></th>
			<td><input name="MEDIATYPE" type="text" id="MEDIATYPE" value="#media.getMEDIATYPE()#" /></td>
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