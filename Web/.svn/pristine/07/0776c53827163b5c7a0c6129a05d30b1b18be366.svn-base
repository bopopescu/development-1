<!--- galleryadminRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.galleryadmin" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset galleryadmin = attributes.galleryadmin /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Galleryadminid</th>
			<td>#galleryadmin.getGALLERYADMINID()#</td>
		</tr>
		<tr>
			<th>Firstname</th>
			<td>#galleryadmin.getFIRSTNAME()#</td>
		</tr>
		<tr>
			<th>Lastname</th>
			<td>#galleryadmin.getLASTNAME()#</td>
		</tr>
		<tr>
			<th>Email</th>
			<td>#galleryadmin.getEMAIL()#</td>
		</tr>
		<tr>
			<th>Adminpassword</th>
			<td>#galleryadmin.getADMINPASSWORD()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />