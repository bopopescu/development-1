<!---
/admin/acctdetls.cfm

1/10/01 Robbie Smith
        New accounts screen that handles most of the same functions as the original Accounts.cfm screen without delete and credit payment capabilities. It can be accessed via the new Accounts(accountnu.cfm) menu.

--->


<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->
<!--- inc timenow --->
    <cfmodule template="../functions/timenow.cfm">
<cfinclude template="../includes/session_include.cfm">
 
  
 <cfsetting EnableCFOutputOnly="YES">

<!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
  <cfif #submit# is "Return to Menu">
     <cflocation url="accountsNU.cfm">
  </cfif>
  </cfif>
  
<!--- partial pay error msg--->
<cfif IsDefined("e_message") >
   <cfset #e_message# = #trim (e_message)#>
 <cfelse>
   <cfset #e_message# = "">
 </cfif> 
  
<!--- partial pay error msg--->
<cfif IsDefined("inv_due") >
   <cfset #inv_due# = #trim (inv_due)#>
 <cfelse>
   <cfset #inv_due# = 0>
 </cfif>  
  
  <!--- initialize check num --->
 <cfif IsDefined("fdocnum") >
   <cfset #fdocnum# = #trim (fdocnum)#>
 <cfelse>
   <cfset #fdocnum# = "">
 </cfif> 
  
  <!--- if submitting payment --->
 <cfif IsDefined("Form.sSubmitPayment")
    AND IsDefined("Form.fPaymentAmount") 
    AND CGI.HTTP_REFERER CONTAINS "/admin/acctdetls.cfm">
	
	<!--- vals to make script load invoice again after submit --->
    <cfset submit = "Retrieve">
    <cfset selected_item = itemnum>
	
  <cfif Variables.fdocnum NEQ  "">
   
    <!--- def vals --->
    <cfset sPaymentRef = "Payment">   
        
    
    <!--- strip all but numeric from amount --->
    <cfset fPaymentAmount = REReplace(Form.fPaymentAmount, "[^0-9.]", "", "ALL")>
    
    <!--- chk val left --->
    <cfif Len(Variables.fPaymentAmount)>
      
      <!--- chk val numeric --->
      <cfif IsNumeric(Variables.fPaymentAmount)>
        
        <!--- chk val GT 0 --->
        <cfif Variables.fPaymentAmount GT 0>
          
          <!--- get account id --->
          <cfquery username="#db_username#" password="#db_password#" name="resolve_userid" datasource="#DATASOURCE#">
              SELECT user_id, invoice_total, paid
                FROM invoices
               WHERE itemnum = #itemnum#
          </cfquery>
		  
		  <!---  calc. amt due for payment--->
          <cfset #inv_due# = #resolve_userid.invoice_total# - #resolve_userid.paid#>
          <cfset #inv_due# = numberformat(inv_due,numbermask)>
	      <cfset #inv_due# = REReplace(#inv_due#, "[^0-9.]", "", "ALL")>	
		  
	  <!---Only accept payments equal to the amt due on invoice --->
		  
		  <!---<cfif #Variables.fPaymentAmount# eq #resolve_userid.invoice_total#>--->

		  <cfif #Variables.fPaymentAmount# eq #inv_due#>  
             <!--- adjust account balance --->
             <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE users
                  SET balance = balance - #Variables.fPaymentAmount#
                WHERE user_id = #resolve_userid.user_id#
             </cfquery>
          
             <!--- adjust invoice paid --->
             <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
                UPDATE invoices
                   SET paid = paid + #Variables.fPaymentAmount#,
				      docnum = '#fdocnum#'
                 WHERE itemnum = #itemnum#
            </cfquery>
          
			<!--- insert into member balance --->
			<cfquery username="#db_username#" password="#db_password#" name="get_newbalance" datasource="#DATASOURCE#">
              SELECT balance, credit
                FROM users
               WHERE user_id = #resolve_userid.user_id#
            </cfquery>
  			<cfquery username="#db_username#" password="#db_password#" name="insert_member_bal" datasource="#DATASOURCE#">
				INSERT INTO member_bal
				(user_id,itemnum,date_time,descr,pmt_credit,total,credit)
				VALUES
				(#resolve_userid.user_id#,#itemnum#,#CreateODBCDateTime(timenow)#,'Payments to an invoice by Admin',#Variables.fPaymentAmount#,#get_newbalance.balance#,#get_newbalance.credit#)
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
				 docnum
                )
              VALUES
                (
                 #itemnum#,
                 #Variables.TIMENOW#,
                 #resolve_userid.user_id#,
                 #Variables.fPaymentAmount#,
                 '#Variables.sPaymentRef#',				
				 '#fdocnum#'
                )
             </cfquery>
          
            <!--- log payment --->
            <cfmodule template="../functions/addTransaction.cfm"
              datasource="#DATASOURCE#"
              description="Payment"
              itemnum="#itemnum#"
              amount="#Variables.fPaymentAmount#"
              user_id="#resolve_userid.user_id#">
			  
		
		</cfif>
	   </cfif>	
      </cfif>         
    </cfif>
   </cfif>
 </cfif> 
  
<!--- 11/00 RS retrieve all active users for select box --->

<cfquery username="#db_username#" password="#db_password#"    name="getUser" datasource="#DATASOURCE#" >
          SELECT user_id, nickname
            FROM users
			WHERE is_active = 1
           ORDER BY nickname
</cfquery>


 <!--- Set defaults of they're here for the first time --->
 <cfif #isDefined ("submit")#>
  <cfset #submit# = #trim (submit)#>
 <cfelse>
  <cfset #submit# = "">
 </cfif>

   
  <!--- Check to see if they were updating a record --->
  <cfif #submit# is "Update Record">
    
    <!--- Find who's item this is --->
    <cfquery username="#db_username#" password="#db_password#" name="resolve_userid" datasource="#DATASOURCE#">
        SELECT user_id
          FROM invoices
         WHERE itemnum = #itemnum#
    </cfquery>

 <!---  comment out updating of fees 
    
	<!--- strip all but numerics from fee vals --->
    <cfloop index="e" list="studio,listing,second_cat,fee,bold,banner,featured,featured_cat,late_charge">
      <cfset "#e#" = REReplace(Evaluate(e), "[^0-9.]", "", "ALL")>
      <cfif not Len(Evaluate(e))>
        <cfset "#e#" = 0.00>
      </cfif>
    </cfloop>
    
<!---  ---><!---  --->
    <cfset #total#=#evaluate ("studio+listing+second_cat+fee+bold+banner+featured+featured_cat+late_charge")#>
 --->  
  
    <!--- Only allow reference and docnum to be updated --->
	
	<cfquery username="#db_username#" password="#db_password#" name="update_invoice" datasource="#DATASOURCE#">
        UPDATE invoices
           SET   
               reference = '#reference#'
         WHERE itemnum = #itemnum#
    </cfquery>
    
    <!--- log update to invoice --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Invoice Updated"
      itemnum="#itemnum#"
      details=" REFERENCE: #reference#  ">
      
  </cfif>
  
   
 <!--- Set defaults for radio button flags --->
 <cfif #isDefined ("filter")# is 0>
  <cfset #filter# = "All">
 </cfif>
 

 <!--- Get a list of active users that have account info --->
 <cfquery username="#db_username#" password="#db_password#" name="get_user_list" datasource="#DATASOURCE#">
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
		 invoices.featured_studio,
         invoices.late_charge,
         invoices.paid,
         invoices.reference,
		 invoices.invoice_total,
		 invoices.docnum,
         users.name,
         users.balance,
         users.user_id,
         users.nickname,
		 items.quantity
    FROM items, invoices, users
   WHERE items.itemnum = invoices.itemnum
     AND invoices.user_id = users.user_id
   
   <!---  11/00 RS add check of new submit button for user_id.
          if it's pressed,  select only invoices for that user--->
   <cfif IsDefined("submit2")>
<cfif form.selectbox_user_id is not 0>
	  AND invoices.user_id = #form.selectbox_user_id#
	  AND users.user_id = #form.selectbox_user_id#
</cfif>
   <cfelse>
      AND users.user_id = invoices.user_id
   </cfif>
   <cfif #filter# is "Paid">
     AND invoices.paid >= invoices.invoice_total
   </cfif>
   <cfif #filter# is "Unpaid">
     AND invoices.paid < invoices.invoice_total
   </cfif>
     AND invoices.archive = 0
   ORDER BY users.name, invoices.date_created
 </cfquery>
<!---   WHERE invoices.status = 0 --->
 
 <!--- get site currency format --->
 <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
    SELECT pair AS type
      FROM defaults
     WHERE name = 'site_currency'
 </cfquery>

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
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=709>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
		   <cfif #submit# is not "Retrieve">
			<tr>
            <td colspan=2>		
             <font face="helvetica" size=2 color=000000>
             <b> Welcome to the Account Detail screen. To review any users' Account or make <br> payments to a specific user account, select the user below and click on 'Invoices By User'. <br>
			  To proceed with entering payment information, select the an Account and click on 'Retrieve'.</b><br> <br>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>          
             </font>		
            </td>
          </tr>
	 	 </cfif>
		  
		 <tr>
		 <form name="userForm" action="acctdetls.cfm"   method="post">          
			 <td valign="top" align="left">
			 &nbsp;<font face="helvetica"  size=2 color=000080><b>SELLER ACCOUNTS</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Return to Menu">
			  <br>  	  
              <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
              <tr>
                <td>
                <table border=0 bordercolor=ffffff cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                <cfif #isDefined ("submit2")#>
                 <cfif #submit2# is "Invoices by User">
                  <tr>
                   <cfoutput><td><font face="helvetica" size=2>&nbsp;<b>Please select a user from the list:</b><br>&nbsp;(#get_user_list.recordcount# records found)</font></td></cfoutput>
                   <td>&nbsp;</td>
                  </tr>
                  <tr>
                   <td>
                    <cfif #isDefined ("form.itemnum")#>
                     <cfset #the_itemnum# = #form.itemnum#>
                    <cfelse>
                     <cfset #the_itemnum# = #get_user_list.itemnum#>
                    </cfif>
                    <select name="selected_item" size=10 width=314 <cfif IsDefined("submit2") > </cfif>>
                     <cfif #get_user_list.recordcount# is 0><option value="-1">< none ></option></cfif>
                     <cfloop query="get_user_list"><cfoutput><option value="#itemnum#"<cfif #itemnum# is #the_itemnum#> selected</cfif>> #nickname#&nbsp;(#name#)&nbsp;[Item ###itemnum#]&nbsp;(#dateFormat (date_created, "mm-dd-yyyy")#)&nbsp;amount:#numberformat(invoice_total,numbermask)# </option></cfoutput></cfloop>
					</select>
                   </td>
                   <td valign="top">
                    <table border=0 cellspacing=0 cellpadding=2 bgcolor=bac1cf>
                     <tr><td><cfif #get_user_list.recordcount# GT 0><input type="submit" name="submit" value="Retrieve" width=70><cfelse>&nbsp;</cfif></td></tr>
                     <tr><td> </td></tr>
                     </table>
                   </td>
                 </tr>
	      </cfif>	
        </cfif>
		     <!---show select check boxes & new user select box--->
			    <cfif #submit# is not "Retrieve">
                  <tr>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=2>
                     <tr>
                      <td><font face="helvetica" size=2><b>Show:</b></font></td>
                      <td>&nbsp;</td>
                      <td><input type="radio" name="filter" value="All"<cfif #filter# is "All"> checked</cfif>><font face="helvetica" size=2>All</font></td>
                      <td>&nbsp;</td>
                      <td><input type="radio" name="filter" value="Paid"<cfif #filter# is "Paid"> checked</cfif>><font face="helvetica" size=2>Paid</font></td>
                      <td>&nbsp;</td>
                      <td><input type="radio" name="filter" value="Unpaid"<cfif #filter# is "Unpaid"> checked</cfif>><font face="helvetica" size=2>Unpaid</font></td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
				      <td>&nbsp;</td>
                      <td colspan=1>
                      <cfif #isDefined ("form.selectbox_user_id")#>
                        <cfset #the_user_id# = #form.selectbox_user_id#>
                      <cfelse>
                        <cfset #the_user_id# = 0>
                     </cfif>
                     <select name="selectbox_user_id" size=1 width= 10 >
                     <cfif #getUser.recordcount# is 0><option value="-1">< none ></option></cfif>
                    <option value="0">All Users</option>
		               <cfoutput query="getUser">
		               <option value="#getUser.user_id#" <cfif #getUser.user_id# is #the_user_id#> selected </cfif>>#getUser.nickname#</option>
		               </cfoutput>
                    </select>
					</td> 
		            <td>&nbsp;</td>
                    <td><input type="submit" name="submit2" value="Invoices by User" width=30></td>
	             </tr>
			 </table>
	        </td>
		  <td>&nbsp;</td>
        </tr>
      </cfif>
 
	   <!---Show completely new format for screen when retrieve is pressed--->
                <cfif #submit# is "Retrieve">
                 <cfquery username="#db_username#" password="#db_password#" name="get_invoice" DATASOURCE="#DATASOURCE#">
                  SELECT invoices.itemnum,
                         invoices.user_id,
                         invoices.status,
						 invoices.invoice_total,
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
						 invoices.featured_studio,
						 invoices.picture1,
						 invoices.picture2,
						 invoices.picture3,
						 invoices.picture4,
						 invoices.reserve_bid,
                         invoices.late_charge,
                         invoices.paid,
                         invoices.reference,
                         invoices.fee_inspector,
                         invoices.docnum,
						 invoices.discount_note,						 
                         users.name,
                         users.balance,
                         users.statement_date,
                         items.title,
                         items.quantity
                    FROM invoices, users, items
                   WHERE users.user_id = invoices.user_id
                     AND items.itemnum = invoices.itemnum
					 AND invoices.archive = 0  
			  <!--- 11/00 RS Comment old code. use multiple select box itemnum's  --->
              <!---       AND items.itemnum = #selected_item#    --->
                    AND items.itemnum in (#selected_item#) 
  

				  </cfquery>
                  

                  <cfset balance_2 = numberformat(get_invoice.balance,numbermask)>
	              <cfset balance_2 = REReplace(#balance_2#, "[^0-9.]", "", "ALL")>

                 <cfset invoice_total2 = numberformat(get_invoice.invoice_total,numbermask)>
	             <cfset invoice_total2 = REReplace(#invoice_total2#, "[^0-9.]", "", "ALL")>	
			  
                 <cfoutput>
                  <input type="hidden" name="itemnum" value="#get_invoice.itemnum#">
                  <input type="hidden" name="paid" value="#get_invoice.paid#">
                  <input type="hidden" name="balance" value="#balance_2#">
                  <tr>
                   <td><font face="helvetica" size=2><b>Invoice ##:</b></font></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=2>#get_invoice.itemnum#</font></td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
                  
                  <!--- if not paid, disp. payment form --->
			 <cfif get_invoice.paid LT invoice_total2>
                    <tr>
                      <td><font face="helvetica" size=2><input name="sSubmitPayment" type=submit value="Make Payment"></font></td>
                      <td>&nbsp;</td>
                      <td><input name="fPaymentAmount" type=text value="" size=20></td>

                    </tr>
					<tr>
					 <td><font face="helvetica" size=2><b>Check<br>/Approval Number :</b></font></td>
                     <td>&nbsp;</td>
                     <td><input name="fdocnum" type=text value="" size=10></td>
                    </tr>
					
					<tr><td><font face="helvetica" size=2 COLOR=FF0000> PAYMENTS MUST EQUAL AMOUNT DUE</font></td>
                     <td>&nbsp;</td>
					 <td>&nbsp;</td>
                    </tr>

                    <tr>
                      <td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td>
                    </tr>
               </cfif>
                  
                  <tr>
                   <td><font face="helvetica" size=2><b>Invoice date:</b></font></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=2>#dateFormat (get_invoice.date_created, "mm-dd-yyyy")#</font></td>
                  </tr>

<!--- REMOVED, LAST STATEMENT DATE IRRELEVANT TO INVOICE (RELEVANT TO USER'S ACCOUNT)
                  <tr>
                   <td><font face="helvetica" size=2><b>Last statement date:</b></font></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=2>#dateFormat (get_invoice.statement_date, "mm-dd-yyyy")#</font></td>
                  </tr>
 --->
                  <tr>
                   <td><font face="helvetica" size=2><b>Payment due date:</b></font></td>
                   <td>&nbsp;</td>
                   <td>#dateFormat (get_invoice.date_due, 'mm-dd-yyyy')#</td>
                  </tr>
				  
	  <!---- Only display existing check# if invoice is already paid--->
		 <cfif get_invoice.paid GTE invoice_total2>
				  <tr>
					<td><font face="helvetica" size=2><b>Check<br>/Approval Number:</b></font></td>
                    <td>&nbsp;</td>
                    <td>#get_invoice.docnum#</td>
                  </tr>
		  </cfif>
		  
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>		
                  <tr>
                   <td><font face="helvetica" size=2><b>User name:</b></font></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=2>#get_invoice.name#</font></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Item auctioned:</b></font></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=2>#get_invoice.title#</font></td>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Invoice reference:</b></font></td>
                   <td>&nbsp;</td>
                   <td><textarea name="reference" rows=4 cols=31>#get_invoice.reference#</textarea></td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Listing fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.listing,numbermask)#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Second category fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.second_cat,numbermask)#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>% of sale fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.fee,numbermask)#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Bold title fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.bold,numbermask)#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Banner fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.banner,numbermask)#</td>
                  </tr>
<!---  ---><!---  --->
                  <tr>
                   <td><font face="helvetica" size=2><b>Studio inclusion fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.studio,numbermask)#</td>
                  </tr>

                  <tr>
                   <td><font face="helvetica" size=2><b>Featured studio fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.featured_studio,numbermask)#</td>
                  </tr>
				  
				  <tr>
                   <td><font face="helvetica" size=2><b>Image1 upload fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.picture1,numbermask)#</td>
                  </tr>
				  <tr>
                   <td><font face="helvetica" size=2><b>Image2 upload fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.picture2,numbermask)#</td>
                  </tr>
				  <tr>
                   <td><font face="helvetica" size=2><b>Image3 upload fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.picture3,numbermask)#</td>
                  </tr>
				  <tr>
                   <td><font face="helvetica" size=2><b>Image4 upload fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.picture4,numbermask)#</td>
                  </tr>

                  <tr>
                   <td><font face="helvetica" size=2><b>Main feature fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.featured,numbermask)#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Category feature fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.featured_cat,numbermask)#</td>
                  </tr>
				  <tr>
                   <td><font face="helvetica" size=2><b>Reserve bid fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td>#numberformat (get_invoice.reserve_bid,numbermask)#</td>
                  </tr>
				  
				  <!------------------------------------------------------------------------>
						
						ITEM CHARGED
						
					<tr>
					   <td><font face="helvetica" size=2><b>Item on Charge fee:</b></font></td>
					   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
					   <td>#numberformat (get_invoice.reserve_bid,numbermask)#</td>
                   </tr>
					
				  
				  
				  
				  
				  
				  <!------------------------------------------------------------------------>
<!---  ---><!---  --->    
                  
                  
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Late charge:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                  <!---<td><input type="text" name="late_charge" size=8 maxlength=15 value="#numberformat (get_invoice.late_charge,numbermask)#"></td>--->
                  <td> #numberformat (get_invoice.late_charge,numbermask)# </td>
				  </tr>
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
<!---  ---><!---  --->
                  <tr>
                   <td><font face="helvetica" size=2><b>Total fees:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <!---<td><font face="helvetica" size=2>#numberformat(get_invoice.invoice_total,numbermask)#&nbsp;&nbsp;&nbsp;&nbsp;(Includes all fees + late charge)</font></td>--->
				   <cfif get_invoice.discount_note neq ""><cfset membership_pct = " #get_invoice.discount_note#"><cfelse><cfset membership_pct = ""></cfif>
                   <td nowrap><font face="helvetica" size=2>#numberformat(invoice_total2,numbermask)#<font face="helvetica" size=1>&nbsp;&nbsp;&nbsp;&nbsp;(Includes#membership_pct# all fees + late charge)</font></font></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Amount already paid:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><font face="helvetica" size=2>#numberformat(get_invoice.paid,numbermask)#&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                  </tr>

                  <tr bgcolor="cbeef9">
                   <td><font face="helvetica" size=2><b>Amount Due on this Invoice:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <!---<td><font face="helvetica" size=2><cfif #get_invoice.paid# GTE #get_invoice.invoice_total#><font color="00a000"><b>PAID IN FULL</b></font><cfelse><font color="a00000"><b>#numberformat(Evaluate(get_invoice.invoice_total - get_invoice.paid),numbermask)# #Trim(getCurrency.type)# </b></font></cfif></font></td>--->
                  <!--- <td><font face="helvetica" size=2><cfif #get_invoice.paid# GTE #invoice_total2#><font color="00a000"><b>PAID IN FULL</b></font><cfelse><font color="a00000"><b>#numberformat(Evaluate(invoice_total2 - get_invoice.paid),numbermask)# #Trim(getCurrency.type)# </b></font></cfif></font></td> --->
<td><font face="helvetica" size=2><cfif #get_invoice.paid# GTE #invoice_total2#><font color="00a000"><b>PAID IN FULL</b></font><cfelse><font color="a00000"><b>#numberformat(invoice_total2,numbermask)# - #numberformat(get_invoice.paid,numbermask)# #Trim(getCurrency.type)# </b></font></cfif></font></td>

                  </tr>
                  </cfoutput>
                 </cfif>
                 </table>               
                </td>         
               </tr>
               <cfif #submit# is "Retrieve">
                <tr><td><input type="submit" name="submit" value="Update Record">&nbsp;&nbsp;<input type="submit" name="submit" value="Go Back"></td></tr>
               </cfif>
			  </table>	   
             </td>
			</form>
           </tr>
		  </table>
         </td>
        </tr>
       </table>
	  </td>
	 </tr>
	</table>
   </center>
  </font>
 </body>
</html>
