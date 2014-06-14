<!--- mediaRead.cfm --->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.media" type="any" />
<cfparam name="attributes.class" type="string" default="readpage" />
<cfset media = attributes.media /> 
<cfoutput>
<table>
	<tbody>
		<tr>
			<th>Mediaid</th>
			<td>#media.getMEDIAID()#</td>
		</tr>
		<tr>
			<th>Mediatype</th>
			<td>#media.getMEDIATYPE()#</td>
		</tr>
	</tbody>
</table>
</cfoutput>
</cfprocessingdirective>
<cfexit method="exitTag" />