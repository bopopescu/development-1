
<html>

<cfinclude template="/includes/app_globals.cfm">

 <head>
 <title> Advertisement Information </title>
 </head>

<body>

<center>

<font size="4px"> Advertisement Information </font> <hr>
<br>

<cfquery username="#db_username#" password="#db_password#" name="getaddefaults" datasource="#DATASOURCE#"> 
				   
					SELECT *
					FROM adv_defaults
					
						
</cfquery>

<cfset ad_dur = #getaddefaults.ad_dur#>
<cfset ad_fee = #getaddefaults.ad_fee#>


<table border="0" cellpadding="2" cellspacing="2">

	<tr>
	<td> Duration ( Months )</td> <td> Fee (USD)</td>
	</tr>
	
	<cfloop query="getaddefaults">
	<tr>
		<td> <cfoutput> #ad_dur#  </cfoutput> </td> <td> <cfoutput> #ad_fee# </cfoutput> </td>
	<tr>
	</cfloop>
<tr>
</tr>
</table>
<button onclick="window.close()"> Close </button>
<br>
<hr>
</center>

</body>

</html>