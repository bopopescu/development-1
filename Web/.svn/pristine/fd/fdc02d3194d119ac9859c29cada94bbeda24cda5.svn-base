<!---
/admin/void_menu.cfm

  Menu to accept data and branch to 'Void an invoice' process

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
 <cfif IsDefined("invoice") >
   <cfset #invoice# = #trim (invoice)#>
 <cfelse>
   <cfset #invoice# = "">
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
	
  <!--- display error if an invoice number not entered --or not numeric--->
  	 
	<cfif Variables.invoice NEQ  "" >    
	   <cfif IsNumeric(Variables.invoice)>        
  	
	     <cfset session.from_accounts = '1'>
		 <cfset session.invoice = #invoice#>
         <cfset session.selectbox_user_id3 = #form.selectbox_user_id3#>
	     <cflocation url="void_invoice.cfm">
	   <cfelse>
	     <cfoutput><font color=ff0000>Please enter an existing NUMERIC invoice before processing void </font></cfoutput>
       </cfif>
	
	<cfelse>
	     <cfoutput><font color=ff0000>Please enter an existing invoice number before processing void </font></cfoutput>
      </cfif>	
   <cfelse>
         <cfoutput><font color=ff0000>PLEASE select an user befor processing void </font></cfoutput>
			 
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
       <table border=0 bordercolor=000000 cellspacing=0 cellpadding=0>	    
        <tr>
         <td>
          <table border=1 cellspacing=0 cellpadding=1 width=709>
           <tr>
            <td>
             <font face="helvetica" size=3 color=000000>
              <b>Use this page to Void an Invoice. Select user and enter Invoice number. After doing so, click on 'Process' to have void processing initiated.  Note: If payments have been made via check/credit card, the Invoice will not be voided. </b>  <br><br>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
              
             </font>
            </td>
           </tr>
		  
           <tr>
            <form name="voidForm" action="void_menu.cfm" method="post">          
              <tr>
                <td>
 
 <table border=0 bordercolor=000080 cellspacing=0 cellpadding=1 >
 <tr>
  <td><font face="helvetica" size=2><b>User:&nbsp;</b></font>
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
	   <td>&nbsp;&nbsp;&nbsp;</td>
	   <td><font face="helvetica" size=2><b>Invoice Number :</b></font></td>
       <td><input name="invoice" type=text value="" size=10></td>
	   <td><input type="submit" name="submit3" value="Process" width=20></td>
      </tr>
	  <tr><td>&nbsp;&nbsp;</td></tr>
	  <tr><td>&nbsp;&nbsp;</td></tr>
	  <tr><td><input type="submit" name="submit" value="Return to Menu"></td> </tr>
	 </table>
	 </td>
	 </tr>	 	 
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
