<cfinclude template="../includes/app_globals.cfm">
<html>
<head>
	<title>Test CFtable</title>
</head>

<body>

  <cfquery username="#db_username#" password="#db_password#"    name="getInvoices" datasource="#DATASOURCE#" >
          SELECT invoices.user_id,
	             invoices.paid, 
				 invoices.invoice_total,
				 users.name,
				 users.nickname 
            FROM invoices, users
			WHERE users.user_id = invoices.user_id
			    and invoices.paid >= invoices.invoice_total
			
          
  </cfquery>

<cftable query="getInvoices" startrow = "1" colspacing = "1" colheaders =  "User id"  htmltable >
<cfcol header = "ID"  
 align = "left"  text = "#user_id#">
<cfcol header = "paid"
 align = "left"  text = "#paid#">
<cfcol header = "Ok to Pay"
 align = "left"  
 text= " "> 
</cftable>
</body>
</html>
