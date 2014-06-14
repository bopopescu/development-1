<!--- artEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.art" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset art = attributes.art /> 
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
			<input name="ARTID" type="hidden" value="#art.getARTID()#" />
		<tr>
			<th><label for="ARTISTID">Artistid:</label></th>
			<td><input name="ARTISTID" type="text" id="ARTISTID" value="#art.getARTISTID()#" /></td>
		</tr>
		<tr>
			<th><label for="ARTNAME">Artname:</label></th>
			<td><input name="ARTNAME" type="text" id="ARTNAME" value="#art.getARTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="DESCRIPTION">Description:</label></th>
			<td><cftextarea name="DESCRIPTION"  id="DESCRIPTION" value="#art.getDESCRIPTION()#" richtext="true" toolbar="Basic" skin="Silver" /></td>
		</tr>
		<tr>
			<th><label for="PRICE">Price:</label></th>
			<td><input name="PRICE" type="text" id="PRICE" value="#art.getPRICE()#" /></td>
		</tr>
		<tr>
			<th><label for="LARGEIMAGE">Largeimage:</label></th>
			<td><input name="LARGEIMAGE" type="text" id="LARGEIMAGE" value="#art.getLARGEIMAGE()#" /></td>
		</tr>
		<tr>
			<th><label for="MEDIAID">Mediaid:</label></th>
			<td><input name="MEDIAID" type="text" id="MEDIAID" value="#art.getMEDIAID()#" /></td>
		</tr>
		<tr>
			<th><label for="ISSOLD">Issold:</label></th>
			<td><input name="ISSOLD" type="text" id="ISSOLD" value="#art.getISSOLD()#" /></td>
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