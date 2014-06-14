<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


 
<cfquery name="Get_Fee" datasource="#dataSource#" maxrows=1 dbtype="ODBC">
SELECT *
	FROM member_fees
	WHERE descr = 'Late Charge'</cfquery>
	
	<cfquery name="Get_member_bal" datasource="#dataSource#" maxrows=1 dbtype="ODBC">
SELECT *
	FROM member_bal
	WHERE user_id = #attributes.user_id#
	order by total desc</cfquery>
	
	<cfset user_id = session.RepID>
	<cfset date_time = createODBCdatetime(now())>
	<cfset descr = "#get_fee.descr#">
	<cfset pmt_credit = 0.00>
	<cfset fee = get_fee.fee>
	<cfif get_member_bal.recordcount>
	<cfset total = get_member_bal.total + fee - pmt_credit>
	<cfelse>
	<cfset total =  fee - pmt_credit>
	</cfif>
	
	<cfquery name="" datasource="#DATASOURCE#" dbtype="ODBC">
INSERT INTO member_bal
(user_id,date_time,descr,pmt_credit,fee,total) VALUES (#user_id#,#date_time#,'#descr#',#pmt_credit#,#fee#,#total#)
</cfquery>


