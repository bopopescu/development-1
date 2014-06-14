<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<cfquery name="Get_Invoice_total" datasource="#dataSource#" maxrows=1 dbtype="ODBC">
SELECT invoice_total
	FROM invoices
	WHERE itemnum = #attributes.itemnum#</cfquery>
	
	<cfquery name="Get_member_bal" datasource="#dataSource#" maxrows=1 dbtype="ODBC">
SELECT *
	FROM member_bal
	WHERE user_id = #attributes.user_id#
	order by total desc</cfquery>
	
	<cfset user_id = session.RepID>
	<cfset date_time = createODBCdatetime(now())>
	<cfset descr = "Invoice Total">
	<cfset pmt_credit = 0.00>
	<cfset fee = Get_Invoice_total.invoice_total>
	<cfif get_member_bal.recordcount>
	<cfset total = get_member_bal.total + fee>
	<cfelse>
	<cfset total =  fee>
	</cfif>
	
	<cfquery name="" datasource="#DATASOURCE#" dbtype="ODBC">
INSERT INTO member_bal
(user_id,date_time,descr,pmt_credit,fee,total) VALUES (#user_id#,#date_time#,'#descr#',#pmt_credit#,#fee#,#total#)
</cfquery>

<html>
<head>
	<title>Untitled</title>
</head>

<body>



</body>
</html>
