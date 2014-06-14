<!---
/admin/payrev_menu.cfm

1/16/01 Robbie Smith 
New template menu to accept information needed to reverse payments. Once entered, the reversing process 'reversal.cfm' is initiated.
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
 
<!--- initialize check num --->
 <cfif IsDefined("fdocnum") >
   <cfset #fdocnum# = #trim (fdocnum)#>
 <cfelse>
   <cfset #fdocnum# = "">
 </cfif>   
  
  
<!---  retrieve all active users for select box --->

<cfquery username="#db_username#" password="#db_password#"    name="getUser" datasource="#DATASOURCE#" >
          SELECT user_id, nickname
            FROM users
			WHERE is_active = 1
           ORDER BY nickname
</cfquery>


<!--- Check to see if they want to process reversal --->
 <cfif IsDefined("form.submit1")>
   <!--- Check if check# has not been entered --->
   <cfif Variables.fdocnum IS  "">
	    <cfoutput><font color=ff0000>PLEASE ENTER CHECK/CREDIT CARD NO BEFORE PROCESSING REVERSAL </font></cfoutput>
   <cfelse>
     <!---  check for payment records before processing --->   		
        <cfquery username="#db_username#" password="#db_password#"    name="getPayments" datasource="#DATASOURCE#" >
        SELECT *
            FROM payments
			WHERE user_id = #selectbox_user_id3# and
			      docNum =  '#fdocnum#' AND
				  archive = 0

         </cfquery>
		 <cfif getPayments.recordcount is 0>
		   <cfoutput><font color=ff0000>NO PAYMENTS FOUND FOR CHECK/CREDIT NO. AND USER SELECTED. PLEASE TRY AGAIN. </font></cfoutput>
         <cfelse>
		   <cfset session.fdocnum = #fdocnum#>
           <cfset session.selectbox_user_id3 = #form.selectbox_user_id3#>
           <cflocation url="reversal.cfm"> 
		 </cfif>		 
  </cfif>
</cfif>
  
 
<!--- Check to see if they want to go back to menu --->
 <cfif IsDefined("form.submit2")>
     <cflocation url="accountsNU.cfm">
 </cfif>
  
 
   
 <cfsetting EnableCFOutputOnly="NO">

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
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 WIDTH=100%>	    
        <tr>
         <td>
           <tr>
            <td colspan=2>--->
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
                <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=709>	    
                  <tr>
                    <td>
            <table border=0 cellspacing=0 cellpadding=5 width=100%>
  
           <tr>
            <!---<td colspan=4>--->
			<td>					
             <font face="helvetica" size=3 color=000000>
              <b>Welcome to the Reversal Menu. Use this page to select user and enter check/credit card number.  After doing so, click on 'Process Reversal' to have Invoice or Credit payments reversed. </b>  <br><br>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>  
           </font>
           </td>
           </tr>
		   </table> 
		   
		 	<table border=0 bordercolor=000000 cellspacing=0 cellpadding=0 >	
<form name="payrmForm" action="payrev_menu.cfm" method="post">
	                                    
  <tr>
  <td><font face="helvetica" size=2><b>Select  User</b></font></td>
	<td>
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
	   
	   <td>&nbsp;</td>
	   <td><font face="helvetica" size=2><b>Check/Credit Card Number:</b></font></td>
       <td><input name="fdocnum" type=text value="" size=10></td>
	   <td>&nbsp;</td>
	   <td><input type="submit" name="submit1" value="Process Reversal" width=20></td>
      </tr>
	  
	  
	  <tr></tr>
	  <tr></tr>
	  <tr></tr>
	  <tr><td><input type="submit" name="submit2" value="Return to Menu"></td> </tr>
  </form>
 </table> 
  </td>
 </tr>
 </table>
 </td>
 </tr>
 </table>
 </body>
</html>

