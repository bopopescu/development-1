

 <html>
 <head>
 <title> Test Paid Invoice Query </title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <body bgcolor="Aqua" > 
  <cfinclude template="../includes/app_globals.cfm">
  <cfquery username="#db_username#" password="#db_password#"    name="getInvoices" datasource="#DATASOURCE#" >
          SELECT count(invoices.user_id) as total_paid
		 
	<!---	         invoices.paid, 
				 invoices.invoice_total,
				 users.name,
				 users.nickname --->
            FROM invoices, users
			WHERE users.user_id = invoices.user_id
			    and invoices.paid >= invoices.invoice_total
			
          
  </cfquery>
  <cfoutput query="getInvoices">
  Total for all users paid = #total_paid#
 <!--- nickname = #nickname# name = #name#  amt pd: #paid#   amt tot: #invoice_total#--->
  </cfoutput>
 </body>
 </html>