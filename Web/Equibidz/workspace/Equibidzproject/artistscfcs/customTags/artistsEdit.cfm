<!--- artistsEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.artists" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset artists = attributes.artists /> 
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
			<input name="ARTISTID" type="hidden" value="#artists.getARTISTID()#" />
		<tr>
			<th><label for="FIRSTNAME">Firstname:</label></th>
			<td><input name="FIRSTNAME" type="text" id="FIRSTNAME" value="#artists.getFIRSTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="LASTNAME">Lastname:</label></th>
			<td><input name="LASTNAME" type="text" id="LASTNAME" value="#artists.getLASTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="ADDRESS">Address:</label></th>
			<td><input name="ADDRESS" type="text" id="ADDRESS" value="#artists.getADDRESS()#" /></td>
		</tr>
		<tr>
			<th><label for="CITY">City:</label></th>
			<td><input name="CITY" type="text" id="CITY" value="#artists.getCITY()#" /></td>
		</tr>
		<tr>
			<th><label for="STATE">State:</label></th>
			<td><input name="STATE" type="text" id="STATE" value="#artists.getSTATE()#" /></td>
		</tr>
		<tr>
			<th><label for="POSTALCODE">Postalcode:</label></th>
			<td><input name="POSTALCODE" type="text" id="POSTALCODE" value="#artists.getPOSTALCODE()#" /></td>
		</tr>
		<tr>
			<th><label for="EMAIL">Email:</label></th>
			<td><input name="EMAIL" type="text" id="EMAIL" value="#artists.getEMAIL()#" /></td>
		</tr>
		<tr>
			<th><label for="PHONE">Phone:</label></th>
			<td><input name="PHONE" type="text" id="PHONE" value="#artists.getPHONE()#" /></td>
		</tr>
		<tr>
			<th><label for="FAX">Fax:</label></th>
			<td><input name="FAX" type="text" id="FAX" value="#artists.getFAX()#" /></td>
		</tr>
		<tr>
			<th><label for="THEPASSWORD">Thepassword:</label></th>
			<td><input name="THEPASSWORD" type="text" id="THEPASSWORD" value="#artists.getTHEPASSWORD()#" /></td>
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