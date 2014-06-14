<!---
/admin/void_invoice.cfm

3/01 Robbie Smith 
New template menu to void an invoice.  If an invoice already has a payment applied to it, this process will not back it out. A message is sent to point to the Reverse Check process first before an Invoice can be voided.



--->


<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module- Reverse Paid Invoices]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>


 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->

<cfinclude template="../includes/session_include.cfm">

 <!--- inc timenow --->
 <cfmodule template="../functions/timenow.cfm">
 
 <cfset warning = 0>
 
<!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
     <cflocation url="void_menu.cfm">
 </cfif>

  
<!---  Retrieve all invoices for user and check/credit card no. entered        
      
	   Note: There should be one invoice per check no. entered but 	   
	   there may be more.  --->

<cfquery username="#db_username#" password="#db_password#"    name="getInvoices" datasource="#DATASOURCE#" >
        SELECT *
            FROM invoices
			WHERE user_id = #session.selectbox_user_id3# and
			       itemnum = #session.invoice# AND
				   reference <> 'VOID'	AND
				   archive = 0  

		  <!---Note: 'VOID' = Invoice already voided                  
		   --->
				  
</cfquery>

<!--- LOOP THROUGH ALL Invoices ---> 

<cfif getInvoices.recordcount is not 0>

  <cfloop query="getInvoices">
  
  <!---  If no payments made to the invoice, zero out the User table and invoice table amount and fees   ---->
  
   <cfif getInvoices.paid eq 0>       
	 
	  <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
      UPDATE users             
		   SET  balance = balance - #getInvoices.invoice_total#		       
		        WHERE user_id = #session.selectbox_user_id3#
      </cfquery>
	  
	  <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
      UPDATE invoices         
		   SET  invoice_total = 0,
		        listing = 0,
				fee = 0,
				bold = 0,
				featured = 0,
				featured_cat = 0,
				banner = 0,
				studio = 0,
				featured_studio = 0,
				second_cat = 0,
				late_charge = 0,
				fee_inspector = 0,
				reference = 'VOID'
		        WHERE itemnum = #getInvoices.itemnum# 
				
     </cfquery>
	
	 <!--- insert into member balance --->
			<cfquery username="#db_username#" password="#db_password#" name="get_newbalance" datasource="#DATASOURCE#">
              SELECT balance, credit
                FROM users
               WHERE user_id = #session.selectbox_user_id3#
            </cfquery>
  			<cfquery username="#db_username#" password="#db_password#" name="insert_member_bal" datasource="#DATASOURCE#">
				INSERT INTO member_bal
				(user_id,itemnum,date_time,descr,pmt_credit,total,credit)
				VALUES
				(#session.selectbox_user_id3#,#getInvoices.itemnum#,#CreateODBCDateTime(timenow)#,'Void an invoice by admin',#getInvoices.invoice_total#,#get_newbalance.balance#,#get_newbalance.credit#)
			</cfquery>
	
          <!--- log void Invoice  --->
      <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="VOIDINVOICE"
            itemnum="#getInvoices.itemnum#"
            amount="#getInvoices.invoice_total#"
            user_id="#session.selectbox_user_id3#"> 

  <cfelse>
  	  
	  <cfset warning = 1>
	  
  <!---   back out 'paid' invoice and add payment to credit in Users table  ---> 
	  <!--- 4/5 Do not allow crediting payments here-already done in REversal process--->
	  <!---<cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
      UPDATE users             
		   SET  balance = balance - #getInvoices.invoice_total#,
		        credit = credit + #getInvoices.paid#
		        WHERE user_id = #session.selectbox_user_id3#
      </cfquery>

	 <!---  Back out Invoice fees and total amt  --->
	 
	   <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
       UPDATE invoices         
		   SET  paid = 0,
		        listing = 0,
				fee = 0,
				bold = 0,
				featured = 0,
				featured_cat = 0,
				banner = 0,
				studio = 0,
				featured_studio = 0,
				second_cat = 0,
				late_charge = 0,
				fee_inspector = 0,
		        reference = 'VOID',
				invoice_total = 0
		        WHERE itemnum = #getInvoices.itemnum# 
       </cfquery>
	   
	   
          <!--- log void Invoice  --->
       <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="VOIDINVOICE"
            itemnum="#getInvoices.itemnum#"
            amount="#getInvoices.invoice_total#"
            user_id="#session.selectbox_user_id3#"> 

	   
	  </cfif> 	--->

	  
	   </cfif> 
	 </cfloop> 
  </cfif> 



 
 <cfoutput>
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

      <!---<tr>
       <td colspan=5 bgcolor=bac1cf>
       <table border=0 bordercolor=000000 cellspacing=0 cellpadding=0 >	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=3>		     
           <tr>
            <td colspan=2>--->
	 <tr>
       <td colspan=5 bgcolor=bac1cf>
       <table border=0 bordercolor=000000 cellspacing=0 cellpadding=0>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=1 width=100%>
           <tr>
            <td colspan=2>			
             <font face="helvetica" size=3 color=000080>
              <b>Void an Invoice Process has completed.  </b> <br>            <hr size=1 color=000080>
             </font>
            </td>
           </tr>

		

		  <tr>
		  <form name="voidinvForm" action="void_invoice.cfm" method="post">
		<cfif getInvoices.recordcount eq 0>
		  <td><font face="helvetica" size=3 color=000080><b>There were no invoices found -OR- the invoice was already voided for #session.invoice#  entered. </b></font></td></tr>
        </cfif>
	   
	    <cfif getInvoices.recordcount gt 0>
		  <cfif #warning# eq 0>
	       <tr>
		   <td> <font face="helvetica" size=3 color=000080> <b>Your Invoice: #session.invoice# for user: #session.selectbox_user_id3# has been voided </b>
		   </font></td>
		   </tr>
		  <cfelse>
		   <tr>
		    <td> <font face="helvetica" size=2 color=000080> <b>Your Invoice: #session.invoice# for user: #session.selectbox_user_id3# has payments applied. It could not be voided. <br> Please reverse payments first via Reverse Check and Credit Card Process.</b>
		   </font></td>
		   </tr>
		  </cfif>
		 </cfif> 
		
	     <tr></tr>
		 <tr><td><input type="submit" name="submit" value="Back"></td></tr>
       </td>
     </tr>
	</form>
   </table>
  </td>
 </tr>
</table>
</td>
</tr>
</table>
</cfoutput>
</body>
</html>
	
