<cfinclude template="../includes/app_globals.cfm">

<html>
<head>


				<script type="text/javascript">
				
						
						function showAdinfoWindow()
						{
						
						window.open("advertisementinfo.cfm","AdinfoWindow","status=no,scrollbar=yes,width=400,height=350,left=300,top=50");
						
					
						
						
						}
							
				
				</script>

				
</head>
<body>

				
				<!--- Check if Public viewing of Ad Details is enabled ----->
				<cfquery username="#db_username#" password="#db_password#" name="getadinfo1" datasource="#DATASOURCE#">
				   
						SELECT name, pair 
						FROM defaults 
						WHERE name="adinfo_public"
						
				 </cfquery>	
				 
				 <cfquery username="#db_username#" password="#db_password#" name="getadinfo2" datasource="#DATASOURCE#">
				   
						SELECT name, pair 
						FROM defaults 
						WHERE name="adinfo_private"
						
				 </cfquery>	
				 
				 <! -- SET PUBLIC AD SETTINGS ------->
				 
					<cfset enable_publicadinfo = #getadinfo1.pair#>
				 
				 <! -- SET PRIVATE AD SETTINGS ------->
				  
					<cfset enable_privateadinfo = #getadinfo2.pair#>
				  
				
							<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
									
									<!--- User  logged in check private or member only viewing ---------->

										<cfif #enable_privateadinfo# EQ 0>
										 
											<!-- Private ad Viewing info is disabled ---------->
										
										<cfelse>
										
											<font size=1><a href="" onclick="showAdinfoWindow()"> Advertising Information</a></font>
										 
										</cfif>
									
							<cfelse>
								
									<!--- User is not logged in check public viewing ---------->

										<cfif #enable_publicadinfo# EQ 0>
										 
											<!-- Public ad Viewing info is disabled ---------->
										
										<cfelse>
										
											<font size=1><a href="" onclick="showAdinfoWindow()"> Advertising Information</a></font>
										 
										</cfif>

							</cfif>
					
					
					
			
</body>
</html>