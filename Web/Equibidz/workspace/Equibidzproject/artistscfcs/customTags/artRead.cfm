<!--- artRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.art" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset art = attributes.art /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Artid</th>
			<td>#art.getARTID()#</td>
		</tr>
		<tr>
			<th>Artistid</th>
			<td>#art.getARTISTID()#</td>
		</tr>
		<tr>
			<th>Artname</th>
			<td>#art.getARTNAME()#</td>
		</tr>
		<tr>
			<th>Description</th>
			<td>#art.getDESCRIPTION()#</td>
		</tr>
		<tr>
			<th>Price</th>
			<td>#art.getPRICE()#</td>
		</tr>
		<tr>
			<th>Largeimage</th>
			<td>#art.getLARGEIMAGE()#</td>
		</tr>
		<tr>
			<th>Mediaid</th>
			<td>#art.getMEDIAID()#</td>
		</tr>
		<tr>
			<th>Issold</th>
			<td>#art.getISSOLD()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />