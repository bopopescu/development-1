<!---
/admin/payanyinv.cfm

11/22/00 Robbie Smith 
Modify by Phillip Nguyen 12-20-01
New template to pay any outstanding invoice for a specific user.  This processing does not require the invoice number to be selected.  The method to apply payments is First In First Out (FIFO) based on invoices.date_created.  Any payment amount left over or if there were no invoices, the payment is CREDITED to the users account.

--->

<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module- Pay Outstanding Invoices ]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>


 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->

<cfinclude template="../includes/session_include.cfm">

 <!--- inc timenow --->
 <cfmodule template="../functions/timenow.cfm">
 
 
<!--- Include this module to obtain a unique item number --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">
 
 <!--- get balance and credit as org if get_user_inv return 0--->
   <cfquery username="#db_username#" password="#db_password#" name="get_user_credit" datasource="#DATASOURCE#">
  			SELECT credit, balance
    		FROM users
   			WHERE user_id = #session.selectbox_user_id3#
   	</cfquery>

<!--- initialize variables --->
 
 <cfif IsDefined("session.CpaymentAmt") >
   <cfset #session.CpaymentAmt# = #trim (session.CpaymentAmt)#>
 <cfelse>
   <cfset #session.CpaymentAmt# = "0">
 </cfif> 
 
 <cfset left = #numberformat(session.CpaymentAmt + get_user_credit.credit,numbermask)#>
 <cfset left = REReplace(left, "[^0-9.]", "", "ALL")>
 
 <cfset total_payments = 0>  
 <cfset inv_due       = 0> 
 <cfset inv_amount = 0>
 <cfset already_updated = 'n'> 

 
<!--- Check to see if they want to go back --->
 <cfif #IsDefined("form.submit")#>
  <cfif #submit# is "Back">
     <cflocation url="paymenu.cfm">
  </cfif>
  </cfif>

 <!--- Get a list of active users that have account info FOR SELECTED USER--->
  
<cfquery username="#db_username#" password="#db_password#" name="get_user_inv" datasource="#DATASOURCE#">
  SELECT invoices.itemnum,
         invoices.user_id,
         invoices.status,
         invoices.date_created,
         invoices.date_due,
         invoices.listing,
         invoices.second_cat,
         invoices.fee,
         invoices.bold,
         invoices.featured,
         invoices.featured_cat,
         invoices.banner,
<!---  ---><!---  --->
         invoices.studio,
         invoices.late_charge,
         invoices.paid,
         invoices.reference,
		 invoices.invoice_total,
         users.name,
         users.balance,
		 users.credit,
         users.user_id,
         users.nickname,
		 items.quantity
    FROM items, invoices, users
   WHERE items.itemnum = invoices.itemnum
      AND invoices.paid < invoices.invoice_total
  <!--- Select only invoices for the user specified on paymenu.cfm--->
   	  AND invoices.user_id = #session.selectbox_user_id3#
	  AND users.user_id = #session.selectbox_user_id3#
	  AND invoices.archive = 0
	     ORDER BY invoices.date_created
   </cfquery>
	
	
   
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
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	 
          
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=0 width=100%>
          <tr>--->
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
					  <tr>
		  
            <form name="payanyForm" action="payanyinvNU.cfm" method="post"> 
             <tr>
			 <td><font face="helvetica"  size=4 color=000080><b>Invoice Payment Processing</b></font>
              </td>
			  </tr>



<!--- Perform updates only if page is coming in from paymenu page, not browser 'Refresh' key hit --->

<cfif #session.from_accounts# is '1'>
 <tr>
 <td>Payment Entered: $#session.CpaymentAmt#</td> 
 </tr>
 <cfif #get_user_inv.recordcount# is 0>
  <tr>
  <td>No Invoices Found for user: #session.selectbox_user_id3#</td>
  </tr>
  <tr>
  <td>Payment Credited to your account. </td>
  </tr>
		  

<!---  Update users table with a credit for those accounts that have no invoices .   --->
  <!--- leave # of digits in credit as is if no records in query--->
        <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
     		UPDATE users             
		   SET credit = credit + #session.CpaymentAmt#
		        WHERE user_id = #session.selectbox_user_id3#
          </cfquery>
		  
		  <!--- insert credit into member_bal --->
		  <cfset new_credit = #get_user_credit.credit# + #session.CpaymentAmt#>
			<cfquery name="insert_member_bal2" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
				INSERT INTO member_bal
				(user_id,itemnum,date_time,descr,pmt_credit,total,credit)
				VALUES
				(#session.selectbox_user_id3#,0,#CreateODBCDateTime(timenow)#,'Credit',#session.CpaymentAmt#,0,#new_credit#)
			</cfquery>
			
		  <cfset already_updated = 'y'>
		  
		  <!--- add payment record for credit --->
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              INSERT INTO payments
                (
                 itemnum,
                 date_posted,
                 user_id,
                 amount,
                 reference,
				 docNum
                )
              VALUES
                (
                 #EPOCH#,
				 #Variables.TIMENOW#,
                 #session.selectbox_user_id3#,
                 #session.CpaymentAmt#,
                 'CREDITPAYMENT',
				 '#session.fdocnum#'
                )
          </cfquery>

          <!--- log credit payment --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="CREDITPAYMENT"
            itemnum="#EPOCH#"
            amount="#left#"
            user_id="#session.selectbox_user_id3#">



  <cfelse>

<!---  Attempt to pay all outstanding invoices --->


   <cfloop query="get_user_inv">
    
    <cfset balance_2 = numberformat(balance,numbermask)>
	<cfset balance_2 = REReplace(balance_2, "[^0-9.]", "", "ALL")>
    <cfset inv_amount = numberformat(invoice_total,numbermask)>
	<cfset inv_amount = REReplace(inv_amount, "[^0-9.]", "", "ALL")>
	
	<!--- Due to Credits already being applied by Event2 & here, allow partial payments to invoices when neccessary--->
	
	<cfset #inv_due# = numberformat(Evaluate(#invoice_total# - #paid#),numbermask)>	
	<cfset #inv_due# = REReplace(#inv_due#, "[^0-9.]", "", "ALL")>
	
	<!---<cfif #paid# LT #inv_amount#>--->
	<cfif #inv_due# GT 0>
	  <cfif #inv_due# LTE #left# >
		 <cfset #left# = numberformat(Evaluate(#left# - #inv_due#),numbermask)>
		 <cfset #left# = REReplace(#left#, "[^0-9.]", "", "ALL")>
		 
		 <cfset #total_payments# = numberformat(Evaluate(#total_payments# + + #inv_due#),numbermask)>
	     <cfset #total_payments# = REReplace(#total_payments#, "[^0-9.]", "", "ALL")>
	<!--- Pay all invoices in the query up to payment entered.  Remaining amount will be placed into the User table's credit field. --->
           
          <!--- adjust invoice paid --->
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE invoices
                 SET paid = paid + #inv_due#,
				     docnum = '#session.fdocnum#'
               WHERE itemnum = #itemnum#
          </cfquery>
          
          <!--- add payment record --->
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              INSERT INTO payments
                (
                 itemnum,
                 date_posted,
                 user_id,
                 amount,
                 reference,
				 docNum
                )
              VALUES
                (
                 #itemnum#,
				 #Variables.TIMENOW#,
                 #session.selectbox_user_id3#,
                 #inv_due#,
                 'NOCCAUTOPAYMENT',
				 '#session.fdocnum#'
                )
          </cfquery>
          
          <!--- log payment of invoices--->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="NOCCAUTOPAYMENT"
            itemnum="#itemnum#"
            amount="#inv_due#"
            user_id="#session.selectbox_user_id3#">
		</cfif>
	   </cfif>
	 </cfloop>
 </cfif> 
</cfif> 


<!--- If payments have been made, update user balance and credit if any--->
 <cfif #session.from_accounts# is '1'>
   <cfif #total_payments# GT 0 >
   <!--- convert existing credit to 2 digit--->
      <cfset credit2digit = #numberformat(get_user_inv.credit,numbermask)#>
      <cfset credit2digit = REReplace(credit2digit, "[^0-9.]", "", "ALL")>
   
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE users             
				 <cfif #left# GT 0>
				     SET balance = #balance_2# - #total_payments#,
				         credit = #left# <!--- #credit2digit# +  --->
				 <cfelse>
				     SET balance = #balance_2# - #total_payments#,
					 	 credit = 0
				 </cfif>
               WHERE user_id = #session.selectbox_user_id3#
          </cfquery>
		  
		  <!--- insert into member_bal to display to users --->
		  <cfset new_bal = #get_user_credit.balance# - #total_payments#>
		  	<cfquery name="insert_member_bal" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
				INSERT INTO member_bal
				(user_id,itemnum,date_time,descr,pmt_credit,total,credit)
				VALUES
				(#session.selectbox_user_id3#,0,#CreateODBCDateTime(timenow)#,'Manual Payment',#session.CpaymentAmt#,#new_bal#,#left#)
		  	</cfquery>
		  
		  <!--- create payment record if credit is given --->		  
		  
		  <cfif #left# GT 0 and (session.CpaymentAmt - total_payments) gt 0>
             <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
                  INSERT INTO payments
                    (
                     itemnum,
                     date_posted,
                     user_id,
                     amount,
                     reference,
				     docNum
                      )
                  VALUES
                   (
                     #EPOCH#,
				     #Variables.TIMENOW#,
                     #session.selectbox_user_id3#,
                     #session.CpaymentAmt# - #total_payments#,
                     'CREDITPAYMENT',
				     '#session.fdocnum#'
                      )
             </cfquery>

            <!--- log credit payment --->
            <cfmodule template="../functions/addTransaction.cfm"
               datasource="#DATASOURCE#"
               description="CREDITPAYMENT"
               itemnum="#EPOCH#"
               amount="#left#"
               user_id="#session.selectbox_user_id3#">


          </cfif>	 
	  
   <cfelse>
 <!--- update users table credit for payments made that are smaller
       than any invoice amount or no invoices are outstanding---> 
	   
	 <cfif already_updated is 'n'>
	 <!--- convert existing credit to 2 digit--->
      <cfset credit2digit = #numberformat(get_user_inv.credit,numbermask)#>
      <cfset credit2digit = REReplace(credit2digit, "[^0-9.]", "", "ALL")>
   
       <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE users             
					SET credit = #left# <!--- #credit2digit# +  --->
			     WHERE user_id = #session.selectbox_user_id3#
        </cfquery>
		
		<!--- insert credit into member_bal --->
		<cfset new_bal = #get_user_credit.balance# - #total_payments#>
			<cfquery name="insert_member_bal2" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
				INSERT INTO member_bal
				(user_id,itemnum,date_time,descr,pmt_credit,total,credit)
				VALUES
				(#session.selectbox_user_id3#,0,#CreateODBCDateTime(timenow)#,'Credit',#session.CpaymentAmt#,#new_bal#,#left#)
			</cfquery>
		
		 <!--- add payment record for credit --->
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              INSERT INTO payments
                (
                 itemnum,
                 date_posted,
                 user_id,
                 amount,
                 reference,
				 docNum
                )
              VALUES
                (
                 #EPOCH#,
				 #Variables.TIMENOW#,
                 #session.selectbox_user_id3#,
                 #session.CpaymentAmt#,
                 'CREDITPAYMENT',
				 '#session.fdocnum#'
                )
          </cfquery>	  

	    <!--- log credit payment --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="CREDITPAYMENT"
            itemnum="#EPOCH#"
            amount="#left#"
            user_id="#session.selectbox_user_id3#">


         <cfif #numberformat(left,numbermask)# GT 0 >
           <tr>
            <td> The payment has been Credited to #session.selectbox_user_id3# account. </td>
            </tr>
            <tr>
			<td>There were no outstanding invoices -or- the payment made was smaller than any invoice amount.</td>
           </tr>
         </cfif>
	   </cfif> 
  </cfif>
</cfif> 

<cfif #session.from_accounts# is '1'>
 
 <!---To prevent processing the same payment twice when 'Refresh' is pressed, reset a variable and make user return to accounts screen--->

  <cfset #session.from_accounts# = '0'>
  <cfif #total_payments# GT 0>
    <tr>
	<td colspan=3> Your payment has been processed.  $ #numberformat(total_payments,numbermask)# 
	               has been applied to your outstanding invoices. </td>
	</tr>
	<cfset remainder_payment = session.CpaymentAmt - total_payments>
	<cfif remainder_payment gt 0>
	<tr>
	<td colspan=3>  You have $ #numberformat(remainder_payment,numbermask)# credited to your account. </td>
	</tr>
	</cfif>
   </cfif>
<cfelse>
 <tr>
	<td>PAGE CANNOT BE REFRESHED. PAYMENT CANNOT BE PROCESSED TWICE.  PRESS THE 'BACK' BUTTON IF YOU WANT TO PROCESS ANOTHER PAYMENT.  </td>
 </tr>
</cfif>
 <tr><td><input type="submit" name="submit" value="Back"></td></tr>
</form>
</tr>
</table>
</tr>
</table>
</tr>
</table>
</body>
</cfoutput> 
</html>
        
