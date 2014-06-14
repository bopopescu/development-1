<!--- galleryadminEdit.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.galleryadmin" type="any" />
<cfparam name="attributes.message" type="string" default="" />
<cfset galleryadmin = attributes.galleryadmin /> 
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
			<input name="GALLERYADMINID" type="hidden" value="#galleryadmin.getGALLERYADMINID()#" />
		<tr>
			<th><label for="FIRSTNAME">Firstname:</label></th>
			<td><input name="FIRSTNAME" type="text" id="FIRSTNAME" value="#galleryadmin.getFIRSTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="LASTNAME">Lastname:</label></th>
			<td><input name="LASTNAME" type="text" id="LASTNAME" value="#galleryadmin.getLASTNAME()#" /></td>
		</tr>
		<tr>
			<th><label for="EMAIL">Email:</label></th>
			<td><input name="EMAIL" type="text" id="EMAIL" value="#galleryadmin.getEMAIL()#" /></td>
		</tr>
		<tr>
			<th><label for="ADMINPASSWORD">Adminpassword:</label></th>
			<td><input name="ADMINPASSWORD" type="text" id="ADMINPASSWORD" value="#galleryadmin.getADMINPASSWORD()#" /></td>
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