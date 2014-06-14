<!---
/admin/summary.cfm

1/11/01 Robbie Smith
        New summary accounts screen that displays total invoice information.

--->

<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->

<cfinclude template="../includes/session_include.cfm">
 
  
 <cfsetting EnableCFOutputOnly="YES">
    <!--- inc timenow --->
 <cfmodule template="../functions/timenow.cfm">
 
 <!--- Define accummulator variables --->
 
 <cfset total_count = 0>
 <cfset total_amt = 0>
 <cfset total_paidcount = 0>
 <cfset total_paidamt = 0>
 <cfset total_unpaidcount = 0>
 <cfset total_unpaidamt = 0>
    
 <!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
  <cfif #submit# is "Back">
     <cflocation url="accountsNU.cfm">
  </cfif>
  </cfif>   
  
<!--- retrieve all invoices --->
 
  <cfquery username="#db_username#" password="#db_password#" name="sumInvoices" DATASOURCE="#DATASOURCE#">

		SELECT invoices.itemnum,
         invoices.user_id,
         invoices.date_due,
         invoices.paid,
		 invoices.invoice_total,
         users.name,
         users.balance,
         users.user_id,
         users.nickname,
		 items.quantity
    FROM items, invoices, users
   WHERE items.itemnum = invoices.itemnum
        AND users.user_id = invoices.user_id
		AND invoices.archive = 0

 </cfquery>

 <cfloop query=sumInvoices>
  <!--- accumulate total of all invoices  --->
       <cfset #total_count# = #total_count# + 1>
	   <cfset #total_amt# = #total_amt# + sumInvoices.invoice_total> 
  <!--- accumulate paid totals  --->
  <cfif sumInvoices.paid GTE sumInvoices.invoice_total>
       <cfset #total_paidcount# = #total_paidcount# + 1>
	   <cfset #total_paidamt# = #total_paidamt# + sumInvoices.paid>
  </cfif>
 <!--- accumulate unpaid totals  --->
  <cfif sumInvoices.paid LT sumInvoices.invoice_total>
       <cfset #total_unpaidcount# = #total_unpaidcount# + 1>
	   <cfset #total_unpaidamt# = #total_unpaidamt# + sumInvoices.invoice_total>
  </cfif>
 
 </cfloop>
 
 <cfsetting EnableCFOutputOnly="NO">

 <cfoutput>
 <!--- Main page body --->
 <!---<body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
  <font face="helvetica" size=2>
   <center>
    <!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900>
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>
<!---
<td></td>
<td></td>
--->
<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->


      <!--- Include the menubar --->
      <cfset #page# = "accounts">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>
       <table border=0 bordercolor=000000 cellspacing=0 cellpadding=0>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=3 >--->
		  
		   <body bgcolor=ffffff link=ffffff alink=ffaa00 vlink=999999>
      <font face="helvetica" size=2>
        <center>
          
          <!--- The main table encapsulating everything on the page --->
          <table border=0 cellspacing=0 cellpadding=0>
            <tr bgcolor=0c546c>
              <td bgcolor=ffffff><img border=0 src="./images/left.gif"></td>
              <td><img border=0 src="./images/top_banner.gif"></td>
              <td><img border=0 src="./images/header_fill.gif" width=124 height=25></td>
              <td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
              <td bgcolor=ffffff align=right><img border=0 src="./images/right.gif"></td>
            </tr>
            
            <!--- Include the menubar --->
            <cfset #page# = "accounts">
            <cfinclude template="menu_include.cfm">
            
            <tr>
              <td colspan=5 bgcolor=bac1cf>
                <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
                  <tr>
                    <td>
                      <table border=0 cellspacing=0 cellpadding=5 width=100%>
  		    <form name="sumForm" action="summary.cfm" method="post">   
           <tr>
            <!---<td colspan=4>--->
			<td>
             <font face="helvetica" size=3 color=000080>
              <b>Invoice Summary Information is as follows: </b> <br>            <hr size=1 color=#heading_color# width=100%> 
             </font>
            </td>
           </tr>
		  </td>
	
		   
		   <tr>
		   <td><font face="helvetica" size=3 color=000080> </font> Total number of invoices= #total_count# </font></td>
           <td><font face="helvetica" size=3 color=000080> </font> Total invoice amount = #numberformat(total_amt,numbermask)# </font></td>
		   </tr>
		   <tr>
		   <td><font face="helvetica" size=3 color=000080> </font> --Total number of Paid invoices= #total_paidcount# </font></td>
           <td><font face="helvetica" size=3 color=000080> </font> --Total Paid invoice amount = #numberformat(total_paidamt,numbermask)# </font></td>
		   </tr>
		   <tr>
		   <td><font face="helvetica" size=3 > </font>--Total number of Unpaid invoices= #total_unpaidcount# </font></td>
           <td><font face="helvetica" size=3 > </font>--Total Unpaid invoice amount = #numberformat(total_unpaidamt,numbermask)# </font></td>
		   </tr>
		   <tr></tr>
		   <tr></tr>
		  <tr><td><input type="submit" name="submit" value="Back"></td></tr>
     
      </td>
     </tr>
    </tr>
</table>
</table>
</table>
</cfoutput>
</body>
</html>
	   
            