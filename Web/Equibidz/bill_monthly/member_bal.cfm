<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 <cfmodule template="../functions/timenow.cfm">
 
 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
 <cfif isDefined('session.user_id')>
 <cfelse>
 <cflocation url="../personal/index.cfm">
 </cfif>
 
 <cfquery name="get_trans" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT * FROM member_bal
WHERE user_id = #session.user_id#

and date_time >= #dateadd("d",-30, timenow)#
ORDER BY trans_id
</cfquery>
<html>
<head>
	<title>Seller's Balance</title>
	<cfoutput><link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css"></cfoutput>
</head>

<body>
<cfinclude template="../includes/menu_bar.cfm">
<table border="1" cellpadding="5" width=640 align=center>
	<cfoutput><tr bgcolor="#heading_color#">
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Trans ##</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Itemnum</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Date-Time</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Description</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Payment</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Invoice Total</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Unpaid Total</b></td>
		<td align="center" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Credit</b></td>
		
	</tr></cfoutput>
	<cfoutput query="get_trans">
	<cfif pmt_credit gt 0><tr bgcolor="cccccc"><cfelse><tr></cfif>
		<td align="center">#trans_id#</td>
		<td align="center"><cfif itemnum gt 0><a href="../listings/details/index.cfm?itemnum=#itemnum#">#itemnum#</a><cfelse>&nbsp;</cfif></td>
		<td align="center">#dateformat(date_time,"mm/dd/yyyy")# &nbsp;&nbsp; #timeformat(date_time, "HH:mm:ss")#</td>
		<td align="center">#descr#</td>
		<td align="right">#numberformat(pmt_credit,numbermask)#</td>
		<td align="right">#numberformat(Fee,numbermask)#</td>
		<td align="right" <cfif get_trans.currentrow eq get_trans.recordcount> bgcolor="ffff99"</cfif>>#numberformat(total,numbermask)#</td>
		<td align="right">#numberformat(credit,numbermask)#</td>
	</tr>
	</cfoutput>
</table>
<table width=640 align=center>
	<tr><td>Notice: All invoices must be paid in full. Any amount paid that is less than the
invoice total will become a credit balance and that invoice will remain
unpaid. The credit balance will be added to the next payment and applied
to any unpaid invoices.</td></tr>
</table>

<table width=640 align=center>
<tr><td><br><br><hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>

    <cfinclude template="../personal/nav.cfm"><br><br>

    </td></tr>
    <tr><td><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td></tr>
   </table>
   </center>

 </body>
</html>
