
<html>

<cfinclude template="../includes/app_globals.cfm">

 <head>
 <title> Advertisement Information </title>
 </head>

<body>

<cfquery username="#db_username#" password="#db_password#" name="getadinfo1" datasource="#DATASOURCE#"> 
				   
					SELECT name, pair 
					FROM defaults 
					WHERE name="adinfo_public"
						
</cfquery>


<cfset enable_publicadinfo="#getadinfo1.pair#">  


<cfquery username="#db_username#" password="#db_password#" name="getadinfo2" datasource="#DATASOURCE#"> 
				   
					SELECT name, pair 
					FROM defaults 
					WHERE name="adinfo_private"
						
</cfquery>



<cfset enable_privateadinfo="#getadinfo2.pair#">  


<center>

<font size="4px"> Update Adverstisement Viewing </font>

<hr>
<table border="0" cellpadding="2" cellspacing="2">
<form method="POST" action="adinfo.cfm">
<tr>
<td> 
<cfoutput>


	
	
	<cfif #enable_publicadinfo# EQ 1>
	
		Open to Public	</td > <td> <select name="publicinfo">
							<option selected> Enable </option>
							<option> Disable </option>
						</select>
			<cfelse>
		Open to Public </td > <td>	<select name="publicinfo">
							<option> Enable </option>
							<option selected> Disable </option>
						</select>
	</cfif>
</td>
</tr>
<tr>
<td>

	<cfif #enable_privateadinfo# EQ 1> 
	
		Member Only	</td><td>
		
						<select name="privateinfo">
							<option selected> Enable </option>
							<option> Disable </option>
						</select>
			<cfelse>
		Member Only	 </td > <td> 
		
						<select name="privateinfo">
							<option> Enable </option>
							<option selected> Disable </option>
						</select>
	</cfif>
	

	
</cfoutput>
</td>
<tr>
<tr>
<td align="right"><input type="submit" name="submit"></td><td> <button onclick="window.close()">Cancel</button></td>
</tr>
</form>
</table>
<hr>

<!------- GET FORM DATA ----------->

	
	
	<cfif isdefined("submit")>
		
		<cfif publicinfo EQ "Disable">

			<cfset enablepublicad = 0>
			
		<cfelse>
		
			<cfset enablepublicad = 1>
			
	</cfif>

	

	<cfif privateinfo EQ "Disable">

			<cfset enableprivatead = 0>
			
	<cfelse>
		
			<cfset enableprivatead = 1>
			
	</cfif>
		
		
		<cfquery username="#db_username#" password="#db_password#" name="updatepublic" datasource="#DATASOURCE#"> 
				   
					UPDATE defaults 
					SET pair='#enableprivatead#'
					WHERE name='adinfo_public'
						
		</cfquery>
		
		<cfquery username="#db_username#" password="#db_password#" name="updatepublic" datasource="#DATASOURCE#"> 
				   
					UPDATE defaults 
					SET pair='#enableprivatead#'
					WHERE name='adinfo_private'
						
		</cfquery>
		
		
		
	
		
<cfelse>
	
		<cfoutput></cfoutput>
		
</cfif>

<!--------------------------------->


</center>

</body>

</html>