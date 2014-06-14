

 <html>
 <head>
 <title> Test Query to display Invoices Info </title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <body> 
  <cfinclude template="../includes/app_globals.cfm">
  <cfquery username="#db_username#" password="#db_password#"    name="getInvoices2" datasource="#DATASOURCE#" >
          SELECT *
            FROM invoices
			WHERE itemnum= 987743958
			
  </cfquery>
  <cfoutput query="getInvoices2">
  For user  #user_id# item #itemnum#:
  <br>Invoice total= #invoice_total#
  <br>paid = #paid#
  </cfoutput>
 </body>
 </html>