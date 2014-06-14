<!---
/bill_monthly/payanyinv.cfm

12-19-01	Phillip Nguyen 
New template to pay any outstanding invoice for a specific user.  This processing does not require the invoice number to be selected.  The method to apply payments is First In First Out (FIFO) based on invoices.date_created.  Any payment amount left over or if there were no invoices, the payment is CREDITED to the users account.

--->
 
 
<!--- Include this module to obtain a unique item number --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">  
 
 
 <cfset left = #numberformat(billing_paid + getInfo.credit,numbermask)#>
 <cfset left = REReplace(left, "[^0-9.]", "", "ALL")>
 
 <cfset total_payments = 0>  
 <cfset inv_due = 0> 
 <cfset inv_amount = 0>
 <cfset already_updated = 'n'> 


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
         invoices.studio,
         invoices.late_charge,
         invoices.paid as inv_paid,
         invoices.reference,
		 invoices.invoice_total as inv_total,
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
   	  AND invoices.user_id = #getInfo.user_id#
	  AND users.user_id = #getInfo.user_id#
	  AND invoices.archive = 0
	     ORDER BY invoices.date_created
   </cfquery>

   
 <cfsetting EnableCFOutputOnly="NO">
 <cfoutput>
 
<!--- Perform updates only if page is coming in from paymenu page, not browser 'Refresh' key hit --->

 <!--- Payment Entered: $#left# for #getInfo.user_id#<br> --->
 <cfif #get_user_inv.recordcount# is 0>
  

<!---  Update users table with a credit for those accounts that have no invoices .   --->
  <!--- leave # of digits in credit as is if no records in query--->
        <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
     		UPDATE users             
		   SET credit = credit + #billing_paid#
		        WHERE user_id = #getInfo.user_id#
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
                 #getInfo.user_id#,
                 #left#,
                 '#billing_reference#',
				 'Monthly billing'
                )
          </cfquery>

          <!--- log credit payment --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="CREDITPAYMENT (Link Point: #billing_reference#)"
            itemnum="#EPOCH#"
            amount="#left#"
            user_id="#getInfo.user_id#">



  <cfelse>

<!---  Attempt to pay all outstanding invoices --->


   <cfloop query="get_user_inv">
    
    <cfset balance_2 = numberformat(balance,numbermask)>
	<cfset balance_2 = REReplace(balance_2, "[^0-9.]", "", "ALL")>
    <cfset inv_amount = numberformat(inv_total,numbermask)>
	<cfset inv_amount = REReplace(inv_amount, "[^0-9.]", "", "ALL")>
	
	<!--- Due to Credits already being applied by Event2 & here, allow partial payments to invoices when neccessary--->
	
	<cfset #inv_due# = numberformat(Evaluate(#inv_total# - #inv_paid#),numbermask)>	
	<cfset #inv_due# = REReplace(#inv_due#, "[^0-9.]", "", "ALL")>
	
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
				 	 reference = 'Monthly Billing: #billing_reference#',
				     docnum = 'Monthly Billing'
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
                 #getInfo.user_id#,
                 #inv_due#,
                 'Monthly Billing: #billing_reference#',
				 'INV#itemnum#'
                )
          </cfquery>
          
          <!--- log payment of invoices--->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="INVAUTOPAYMENT (Link Point: #billing_reference#)"
            itemnum="#itemnum#"
            amount="#inv_due#"
            user_id="#getInfo.user_id#">
		</cfif>
	   </cfif>
	 </cfloop>
 </cfif>


<!--- If payments have been made, update user balance and credit if any--->
   <cfif #total_payments# GT 0 >
   
          <cfquery name="upd_user_bal" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE users             
				 <cfif #left# GT 0>
				     SET balance = #balance_2# - #total_payments#,
				         credit = #left#
				 <cfelse>
				     SET balance = #balance_2# - #total_payments#,
					 	 credit = 0
				 </cfif>
               WHERE user_id = #getInfo.user_id#
          </cfquery>
		  
		  <!--- create payment record if credit is given --->		  
		  
		  <cfif #left# GT 0>
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
                     #getInfo.user_id#,
                     #left#,
                     'Monthly Billing: #billing_reference#',
				     'Monthly billing'
                      )
             </cfquery>

            <!--- log credit payment --->
            <cfmodule template="../functions/addTransaction.cfm"
               datasource="#DATASOURCE#"
               description="CREDITPAYMENT (Link Point: #billing_reference#)"
               itemnum="#EPOCH#"
               amount="#left#"
               user_id="#getInfo.user_id#">


          </cfif>
	  
   <cfelse>
 <!--- update users table credit for payments made that are smaller
       than any invoice amount or no invoices are outstanding---> 
	   
	 <cfif already_updated is 'n'>
   
       <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE users             
					SET credit = #left#
			     WHERE user_id = #getInfo.user_id#
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
                 #getInfo.user_id#,
                 #billing_paid#,
                 '#billing_reference#',
				 'Monthly billing'
                )
          </cfquery>	  

	    <!--- log credit payment --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="CREDITPAYMENT (Link Point: #billing_reference#)"
            itemnum="#EPOCH#"
            amount="#left#"
            user_id="#getInfo.user_id#">

	   </cfif> 
  </cfif>

</cfoutput> 

        
