<!---
/admin/paymenu.cfm

1/15/01 Robbie Smith
         New sub menu to select user and accept credit payment to be passed to payanyinv.cfm screen.


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


 <!--- Set defaults of they're here for the first time --->
 <cfif isDefined ("submit")>
  <cfset #submit# = #trim (submit)#>
 <cfelse>
  <cfset #submit# = "">
 </cfif>

 <!--- initialize check num --->
 <cfif IsDefined("fdocnum") >
   <cfset #fdocnum# = #trim (fdocnum)#>
 <cfelse>
   <cfset #fdocnum# = "">
 </cfif> 
 
<!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
  <cfif #submit# is "Return to Menu">
     <cflocation url="accountsNU.cfm">
  </cfif>
  </cfif>
  
  
 <cfsetting EnableCFOutputOnly="YES">

<!---  1/01 Store info in session variables and branch to another form(payanyinv.cfm) to process credit payments --->

  <cfif IsDefined("submit3")>
  <!--- check if user has been selected --->
    <cfif IsDefined("form.selectbox_user_id3")>
	
  <!--- display error if check number or payment not entered --->
  	 
	  <cfif Variables.fdocnum NEQ  "">
  
	  <!--- strip all but numeric from amount --->	   
        <cfset CpaymentAmt = REReplace(form.CpaymentAmt, "[^0-9.]", "", "ALL")>
         
      <!--- chk val left --->
        <cfif Len(Variables.CpaymentAmt)>
      
      <!--- chk val numeric --->
        <cfif IsNumeric(Variables.CpaymentAmt)>		 
		 
      <!--- chk val GT 0 --->
        <cfif Variables.CpaymentAmt GT 0 >
	     <cfset session.from_accounts = '1'>
		 <cfset session.CpaymentAmt = #CpaymentAmt#>
		 <cfset session.fdocnum = #fdocnum#>
         <cfset session.selectbox_user_id3 = #form.selectbox_user_id3#>
	     <cflocation url="payanyinvNU.cfm">
	   <cfelse>
	     <cfoutput><font color=ff0000>PLEASE ENTER AN AMOUNT > 0 BEFORE PROCESSING PAYMENTS </font></cfoutput>
      </cfif>
		
  <cfelse>
         <cfoutput><font color=ff0000>PLEASE ENTER AN AMOUNT > 0 BEFORE PROCESSING PAYMENTS </font></cfoutput>
			 
	</cfif>
	
 <cfelse>
      <cfoutput><font color=ff0000>PLEASE ENTER AN AMOUNT > 0  BEFORE PROCESSING PAYMENTS </font></cfoutput>	   
	 
  </cfif>
      
   
 <cfelse>
     <cfoutput><font color=ff0000>PLEASE ENTER CHECK NO AND AMOUNT > 0 BEFORE PROCESSING PAYMENTS </font></cfoutput>
	
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
                      <table border=0 cellspacing=0 cellpadding=0 width=100%>
					    <tr>
						  <td colspan=7>
                            <font face="helvetica" size=2 color=000000><b>Welcome to Invoice and Credit Payment processing screen. Use this page to select user and enter payment amount. After doing so, 
							click on 'Process' to have payments applied to outstanding invoices or create a credit balance.</b>
							<br><br>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
                            </font>
                          </td>
                         </tr>			 		
                          
	     
<!--- 11/22 RS  Code on Main accounts screen to accept a payment and go to another form and apply payments to all invoices.  No user selection allowed
--->  
                      <tr>
					    <form name="paymForm" action="paymenu.cfm" method="post">      
                        <tr>
                        <td><font face="helvetica" size=2><b>User:</b></font>&nbsp;
						 <!---</td>--->
                        <!---<td>--->
                        <cfif #isDefined ("form.user_id3")#>
                         <cfset #the_user_id3# = #form.user_id3#>
                        <cfelse>
                          <cfset #the_user_id3# = #getUser.user_id#>
                        </cfif>
                        <select name="selectbox_user_id3" size=1 width= 8>
                        <cfif #getUser.recordcount# is 0><option value="-1">< none ></option></cfif>
                       <cfoutput>
		               <!--- <option selected value="0">All Users</option> --->
		               <cfloop query="getUser">
		               <option value="#user_id#" <cfif #user_id# is #the_user_id3#> selected </cfif>>#getUser.nickname#</option>
		               </cfloop>
		               </cfoutput>
                       </select>
	                   </td>
	                  <td><font face="helvetica" size=2><b>Amount:&nbsp;</b></font></td>
                      <!---<td>&nbsp;</td>--->
                      <td><input name="CpaymentAmt" type=text value="" size=15></td>
	                 <!---<td>&nbsp;</td>--->
	                 <td><font face="helvetica" size=2><b>Check Number:</b></font></td>
                     <td><input name="fdocnum" type=text value="" size=10></td>
	                 <td><input type="submit" name="submit3" value="Process" width=20></td>
                   </tr>
				   <tr><td>&nbsp;</td></tr>
				   <tr><td>&nbsp;</td></tr>
	               <tr><td><input type="submit" name="submit" value="Return to Menu"></td> </tr>
	 </form>
	 </tr> 		   
   </table>
  </td> 
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>
