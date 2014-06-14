<!---
/admin/archive_process.cfm

5/01
New template menu to Archive/remove nvoices and payments from the site.  A flag is set to '1=archive=do not display on site' 
--->


<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module- Archive Invoices]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>


 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->

<cfinclude template="../includes/session_include.cfm">

 <!--- inc timenow --->
 <cfmodule template="../functions/timenow.cfm">
 
 <cfset warning = 0>
 
<!--- Check to see if archive flag has not been set and go back --->
 <cfif session.archive_flag eq 0>
     <cflocation url="archive_menu2.cfm">
 </cfif>

<!---update invoices and payments archive flag --->
  <cfset itemarray = listtoarray(session.selected_item)>
  <cfloop index = "ix" from = 1 to = "#ArrayLen(itemarray)#" >
    <cfquery username="#db_username#" password="#db_password#" NAME="" DATASOURCE="#DATASOURCE#">
       UPDATE invoices
          SET archive = '1'
        WHERE itemnum = #itemarray[ix]#
    </CFQUERY>
	
		<!--- log archive of invoice & payment --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Archived Invoice/Payment"
      itemnum="#itemarray[ix]#"
      details="Removed Invoice/Payment from site display ">
	  
  </CFLOOP>
  
 <!---update archive flag for payments made to selected invoices  ---> 
  
 <!---<cfset itemarray = listtoarray(form.itemlist)>--->
  <cfloop index = "ix" from = 1 to = "#ArrayLen(itemarray)#" >
    <cfquery username="#db_username#" password="#db_password#" NAME="" DATASOURCE="#DATASOURCE#">
       UPDATE payments
          SET archive = '1'
        WHERE itemnum = #itemarray[ix]#
    </CFQUERY> 
  </CFLOOP>
 
 
<cflocation url="archive_menu2.cfm">

