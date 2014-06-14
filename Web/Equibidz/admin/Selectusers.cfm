

 <html>
 <head>
 <title> Test User query </title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <body > 
  <cfinclude template="../includes/app_globals.cfm">
  <cfquery username="#db_username#" password="#db_password#"    name="getUser" datasource="#DATASOURCE#" >
          SELECT *
            FROM users
			where nickname = 'adopogi2' OR
			      nickname = 'rjs2000'
         
  </cfquery>
  <cfoutput query="getUser">
  The user is =  #user_id# nickname = #nickname#
  credit =  #credit#
  balance = #balance# <br>
  </cfoutput>
 </body>
 </html>