<cfinclude template = "../includes/app_globals.cfm">
<cfquery name="get_ad_defaults" datasource="#DATASOURCE#">
	SELECT ad_dur, ad_fee
	FROM ad_defaults
</cfquery>


<html>
<head>
	<title>Classified Ad Administrator</title>
</head>
<cfparam name="mode" default="defaults">
<body>

<cfif mode IS "edit">
<TABLE width=100% Border=0>
    <TR>
        <TD><font face="arial black" size="4">Classified Ad Editing</font></TD>
	</TR>
    <TR>
        <TD></TD>
	</TR>
    <TR>
        <TD></TD>
	</TR>
</TABLE>

<cfelseif mode IS "defaults">
<TABLE width=100% Border=0>
    <TR>
        <TD><font face="arial black" size="4" color="blue">Classified Ad Controls</font><br></TD>
	</TR>
    <TR>
        <TD>
			<TABLE width=100% Border=0>
		    <TR>
        		<TD><font face="arial">Use these settings to set the defaults for the Classified Ads Section:</font></TD>
			</TR>
			<tr>
				<td VALIGN=TOP align=center><table width="50%" border="1">
					<td colspan="2" align="center"><font face="Arial" size="+1" color="blue"><b>Classified Ad Durations and Fees</b></font></td>
					<tr><td align="center" width="50%"><font face="Arial" color="Blue"><b>Duration</b></font></td><td align="center" width="50%"><font face="Arial" color="Blue"><b>Fee</b></font></td></tr>
						<cfloop query="get_ad_defaults">
							<cfoutput><tr><td align="center">#ad_dur# days</td><td align="center">#numberFormat(ad_fee,numbermask)#</td></tr></cfoutput>
						</cfloop>
					</table>
					<br>
					<cfif IsDefined("ad_dur") IS 0>
					<cfset ad_dur="">
					<cfelse>
					<cfset ad_dur=#ad_dur#>
					</cfif>
					<cfif IsDefined("ad_fee") IS 0>
					<cfset ad_fee="">
					<cfelse>
					<cfset ad_fee=#ad_fee#>
					</cfif>					
					<cfoutput>
						<FORM ACTION="admin_up.cfm" METHOD="POST" ENCTYPE="multipart/form-data">
	<TABLE>
	<TR><TD COLSPAN=2><CFIF isDefined('url.refuse')>
	
<FONT FACE="Arial" COLOR="Red"><B><CFIF url.refuse IS 1>
You can not have multiple durations of the same value.
<CFELSE>
Please make entries according to the example above.
</CFIF></B></FONT></CFIF></TD></TR>
<TR><TD>Duration:</TD><TD>Fee:</TD></TR>
<TR><TD><input type="text" name="duration" value="#ad_dur#"></TD><TD><input type="text" name="fee" value="#ad_fee#"></TD></TR>
<TR><TD><input type="submit" name="add" value="Add New Pair"></TD><TD><input type="submit" name="delete" value="Delete Old Pair"></TD></TR>
</TABLE>			
			
						</form>
					</cfoutput>
				</td><TD VALIGN=MIDDLE align=left>
				<FONT FACE="Arial" COLOR="Blue">
				Example: 
				</FONT>
				<FORM ACTION="" METHOD="POST">
				<TABLE>
				<TR><TD>Duration:</TD><TD>Fee:</TD></TR>
				<TR><TD><INPUT TYPE="Text" NAME="" VALUE="30"></TD><TD><INPUT TYPE="Text" NAME="" VALUE="15.00"></TD></TR>
				</TABLE>
				
				
				</FORM>
				
				</TD>
			</tr>
			</table>		
		</TD>
	</TR>
</TABLE>
</cfif>

</body>
</html>