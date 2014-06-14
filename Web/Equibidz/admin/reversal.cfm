<!---
/admin/reversal.cfm

1/16/01 Robbie Smith 
New template menu to reverse payments.  
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
 
 
<!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
     <cflocation url="payrev_menu.cfm">
 </cfif>

  
<!---  retrieve all payments for user and check no. entered --->

<cfquery username="#db_username#" password="#db_password#"    name="getPayments" datasource="#DATASOURCE#" >
        SELECT *
            FROM payments
			WHERE user_id = #session.selectbox_user_id3# and
			       docNum = '#session.fdocnum#'  AND
				   archive = 0 AND
				   (reference <> 'REVERSED') AND 
				   (reference <> 'REVERSAL')	  

		  <!---Note: Reversed = original payment record reversed                  
		             Reversal = New offsetting reversal record  --->
	
	<!---  
      
	   Note: There should be one payment per invoice no. entered but 	   
	   there may be more.  --->
				  
</cfquery>

<!--- LOOP THROUGH ALL PAYMENTS ---> 


<cfif getPayments.recordcount is not 0>
 <cfloop query="getPayments">

<!--- Include this module to obtain a unique item number --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">

  <cfif getPayments.recordcount is not 0>
    <cfset negative_amt = getPayments.amount * -1>
	<!--- 1. check for credit payment type and back out credit --->
	
   <cfif getPayments.reference is "CREDITPAYMENT">
      <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
      UPDATE users             
		   SET  credit = credit - #getPayments.amount#
		        WHERE user_id = #session.selectbox_user_id3#
     </cfquery>

	 <!---2.  add payment reversal record for credit --->
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
                 #negative_amt#,
                 'REVERSAL',
				 '#session.fdocnum#'
                )
          </cfquery>

          <!--- log reverse credit payment --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="REVERSECREDITPAID"
            itemnum="#EPOCH#"
            amount="#negative_amt#"
            user_id="#session.selectbox_user_id3#"> 

  <cfelse>

	 <!---1.  Back out payment in Invoices for Non-credit payments --->
	   <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
       UPDATE invoices         
		   SET  paid = paid - #getPayments.amount#,
		   		docnum = ' '
		        WHERE itemnum = #getPayments.itemnum# 
       </cfquery>
	   
	  <!---   back out payment in Users table  ---> 
	  
	  <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
      UPDATE users             
		   SET  balance = balance + #getPayments.amount#
		        WHERE user_id = #session.selectbox_user_id3#
      </cfquery>
	  
	 <!---   Create a Reversal payment   ---> 
	 
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
                 #getPayments.itemnum#,
				 #Variables.TIMENOW#,
                 #session.selectbox_user_id3#,
                 #negative_amt#,
                 'REVERSAL',
				 '#session.fdocnum#'
                )
          </cfquery>

          <!--- log reverse invoice payment --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="REVERSEINVOICEPAID"
            itemnum="#getPayments.itemnum#"
            amount="#negative_amt#"
            user_id="#session.selectbox_user_id3#"> 
	     
   </cfif>
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
				(#session.selectbox_user_id3#,#getPayments.itemnum#,#CreateODBCDateTime(timenow)#,'Reversed',#getPayments.amount#,#get_newbalance.balance#,#get_newbalance.credit#)
			</cfquery>
  </cfif> 
 </cfloop>
</cfif> 

<cfif getPayments.recordcount is not 0>
 <cfloop query="getPayments">
  
  <!--- update all payments records to indicate records have been reversed--->

     <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#"> 
       UPDATE payments 
		   SET reference = 'REVERSED'
		        WHERE ID = #getPayments.ID# 		
    </cfquery>
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

      <tr>
       <td colspan=5 bgcolor=bac1cf>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=3 width=100%>
		    <form name="revForm" action="reversal.cfm" method="post">   
           <tr>
            <td colspan=2>
             <font face="helvetica" size=3 color=000080>
			  <b>Reversal Payment Process has been completed.  </b> <br>            <hr size=1 color=#heading_color# width=100%> 
             </font>             		 
			</td>
           </tr>
		  </td>
		  <tr>
		  <td> 
		  <cfif getPayments.recordcount is not 0>
		   <font face="helvetica" size=3 color=000080> <b>Your check: #session.fdocnum# for user: #session.selectbox_user_id3# has been reversed. </b></font>
		  <cfelse>
		   <font face="helvetica" size=3 color=000080> <b>Your check: #session.fdocnum# WAS NOT reversed. Either it was already reversed or <br>
		    your check number was not valid.</b></font>
		  </cfif>
		  </td>
		  </tr>
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
	
