<!---
/admin/accountsNU.cfm

1/01  New Accounts screen - a main menu with links to other screens that handle all processing
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

 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 
			
	<body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
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
                <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
                  <tr>
                    <td>
                      <table border=0 cellspacing=0 cellpadding=5 width=100%>
			
			            <font face="helvetica" Size=2><BR>
&nbsp;Use this page to manage user accounting.
                          
<font face="helvetica" Size=2 color=000080>
<B>&nbsp;USER ACCOUNTING</B>
</FONT>
                          <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
             </font>
            </td>
           </tr>
		   
           <tr>
		   <td><a href="acctdetls.cfm"><font face="helvetica" color=000088>1. Account Inquiries and Process payments to an invoice </a></td>
		   </tr>
		   <tr>
		   <td><a href="summary.cfm"><font face="helvetica" color=000088>2. Summarize All Invoices </a></td>
		   </tr>
		   <tr>
           <td><a href="paymenu.cfm"><font face="helvetica" color=000088>3. Process Payments without Invoices and generate credits</a></td>
		   </tr>
		   <tr>
           <td><a href="payrev_menu.cfm"><font face="helvetica" color=000088>4. Reverse Check and Credit Card Payments </a></td>
		   </tr>
		   <!--- <tr>
           <td><a href="quickbooks_file.cfm"><font face="helvetica" color=000088>5. Create Quickbooks Pro 99 Files</a></td>
		   </tr> --->
		   <tr>
           <td><a href="void_menu.cfm"><font face="helvetica" color=000088>5. Void an Invoice</a></td>
		   </tr>
		   <tr>
           <td><a href="archive_menu2.cfm"><font face="helvetica" color=000088>6. Archive/Remove Invoices and Payments</a></td>
		   </tr>
		   <tr>
           <td><a href="reinstate_menu.cfm"><font face="helvetica" color=000088>7. Reinstate/Restore Invoices and Payments</a></td>
		   </tr>
	 </td>
	 </tr>
   </table>
   </table>
  </table>
</body>
</html>
