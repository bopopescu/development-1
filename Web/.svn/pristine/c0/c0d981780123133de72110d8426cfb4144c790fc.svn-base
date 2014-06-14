<!---
/admin/reinstate_process.cfm

5/01
New template menu to reinstate nvoices and payments to the site.  A flag is set to '0=reinstate, display again on the site' 
--->


<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module- Reinstate Invoices and Payments]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>


 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->

<cfinclude template="../includes/session_include.cfm">

 <!--- inc timenow --->
 <cfmodule template="../functions/timenow.cfm">
 
<!--- Check to see if reinstate flag has not been set and go back --->
 <cfif session.reinstate_flag eq 0>
     <cflocation url="reinstate_menu.cfm">
 </cfif>

<!---update invoices and payments reinstate flag --->
  <cfset itemarray = listtoarray(session.selected_item)>
  <cfloop index = "ix" from = 1 to = "#ArrayLen(itemarray)#" >
    <cfquery username="#db_username#" password="#db_password#" NAME="" DATASOURCE="#DATASOURCE#">
       UPDATE invoices
          SET archive = '0'
        WHERE itemnum = #itemarray[ix]#
    </CFQUERY>
	
		<!--- log reinstatement of invoice & payment --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Reinstated Invoice/Payment"
      itemnum="#itemarray[ix]#"
      details="Reinstated Invoice/Payment to display on site">
	  
  </CFLOOP>
  
 <!---update Reinstated flag for payments made to selected invoices  ---> 
  
 <!---<cfset itemarray = listtoarray(form.itemlist)>--->
  <cfloop index = "ix" from = 1 to = "#ArrayLen(itemarray)#" >
    <cfquery username="#db_username#" password="#db_password#" NAME="" DATASOURCE="#DATASOURCE#">
       UPDATE payments
          SET archive = '0'
        WHERE itemnum = #itemarray[ix]#
    </CFQUERY> 
  </CFLOOP>
 
 
<cflocation url="reinstate_menu.cfm">

