<!--- artistsRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.artists" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset artists = attributes.artists /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Artistid</th>
			<td>#artists.getARTISTID()#</td>
		</tr>
		<tr>
			<th>Firstname</th>
			<td>#artists.getFIRSTNAME()#</td>
		</tr>
		<tr>
			<th>Lastname</th>
			<td>#artists.getLASTNAME()#</td>
		</tr>
		<tr>
			<th>Address</th>
			<td>#artists.getADDRESS()#</td>
		</tr>
		<tr>
			<th>City</th>
			<td>#artists.getCITY()#</td>
		</tr>
		<tr>
			<th>State</th>
			<td>#artists.getSTATE()#</td>
		</tr>
		<tr>
			<th>Postalcode</th>
			<td>#artists.getPOSTALCODE()#</td>
		</tr>
		<tr>
			<th>Email</th>
			<td>#artists.getEMAIL()#</td>
		</tr>
		<tr>
			<th>Phone</th>
			<td>#artists.getPHONE()#</td>
		</tr>
		<tr>
			<th>Fax</th>
			<td>#artists.getFAX()#</td>
		</tr>
		<tr>
			<th>Thepassword</th>
			<td>#artists.getTHEPASSWORD()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />