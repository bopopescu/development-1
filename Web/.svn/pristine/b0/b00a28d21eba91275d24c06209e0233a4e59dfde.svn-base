

 <html>
 <head>
 <title> Test User query </title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <body bgcolor="Aqua" > 
  <cfinclude template="../includes/app_globals.cfm">
  <cfquery username="#db_username#" password="#db_password#"    name="getUser" datasource="#DATASOURCE#" >
          SELECT *
            FROM payments
           ORDER BY date_posted desc
  </cfquery>
  <cfoutput query="getUser">
  The reference is = #trim(reference)#
  date posted = #date_posted# 
  amount = #amount# 
  item = #itemnum#
  <br>
  </cfoutput>
 </body>
 </html>