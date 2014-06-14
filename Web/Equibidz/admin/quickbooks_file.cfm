<!---
  quickbooks_file.cfm
  
  Quickbooks import file 12/00 Robbie Smith
   -A file of invoices and payments is created to be later loaded into Quickbooks

 
--->

<!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">

<!--- def TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
  <cfif #submit# is "Back">
     <cflocation url="accountsNU.cfm">
  </cfif>
  </cfif>

 
<!--- Check to see if they want to save files to local pc--->
 <cfif #IsDefined("submit2")#>
      <cflocation url="../admin/qbdownload">
 </cfif> 
  
<cfset sNewline = Chr(13)>
<cfset sTab = Chr(9)>
<cfset total_payments = 0>
<cfset total_invoices = 0>
<cfset total_invwritten = 0>
<cfset total_paywritten = 0>

<cfset stabFileinv = "quickbki.iif">
<cfset stabFilepay = "quickbkp.iif">

<!--- PAYMENT HEADERS  --->

<cfset lPAYMENTtabHeader1 = "">
<cfset lPAYMENTtabHeader2 = "">

<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"!TRNS",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"TRNSID",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"TRNSTYPE",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"DATE",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"ACCNT",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"NAME",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"AMOUNT",#sTab#)>
<cfset lPAYMENTtabHeader1  = ListAppend(lPAYMENTtabHeader1 ,"DOCNUM",#sTab#)>


<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"!SPL",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"SPLID",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"TRNSTYPE",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"DATE",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"ACCNT",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"NAME",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"AMOUNT",#sTab#)>
<cfset lPAYMENTtabHeader2  = ListAppend(lPAYMENTtabHeader2 ,"DOCNUM",#sTab#)>

<!--- Invoice HEADERS  --->

<cfset lINVOICEtabHeader1 = "">
<cfset lINVOICEtabHeader2 = "">

<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"!TRNS",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"TRNSID",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"TRNSTYPE",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"DATE",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"ACCNT",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"NAME",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"AMOUNT",#sTab#)>
<cfset lINVOICEtabHeader1 = ListAppend(lINVOICEtabHeader1,"DOCNUM",#sTab#)>

<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"!SPL",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"SPLID",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"TRNSTYPE",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"DATE",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"ACCNT",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"NAME",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"AMOUNT",#sTab#)>
<cfset lINVOICEtabHeader2 = ListAppend(lINVOICEtabHeader2,"DOCNUM",#sTab#)>


<!--- FINAL HEADER  --->

<cfset lFINALtabHeader = '!ENDTRNS'>

<cfset stabContentinv = "">
<cfset stabContentpay = "">

<cfset stabCiteChr = """">
<cfset stabFldDelim = ",">
<cfset itabRecsPerWrite = 5>
<cfset ltabStringFlds = "">
<cfset ltabFlds = "">


<!--- SETUP FOR Tab OUTPUT --->
<!---------------------------->
  
  <!--- if /admin/qbdownload dir doesn't exist, create --->
  <cfif not DirectoryExists(ExpandPath("./qbdownload"))>
    
    <cfdirectory action="Create"
      directory="#ExpandPath("./qbdownload")#"
      mode="666">
  </cfif>
  
  <!--- write header line 1 for invoice file --->
  
   <cffile action="Write"
    file="#ExpandPath("./qbdownload/" & Variables.stabFileinv)#"
    output="#Variables.lINVOICEtabHeader1#">
	
	<!--- write header line 2 for INVOICE file --->
	
	<cffile action="Append"
        file="#ExpandPath("./qbdownload/" & Variables.stabFileinv)#"
        output="#Variables.lINVOICEtabHeader2#">
	
	
	<!--- write header line 3 for INVOICE file --->
	
	<cffile action="Append"
        file="#ExpandPath("./qbdownload/" & Variables.stabFileinv)#"
        output="#Variables.lFINALtabHeader#">
		
<!--- write header lines for payments files --->
  
   <cffile action="Write"
       file="#ExpandPath("./qbdownload/" & Variables.stabFilepay)#"
       output="#Variables.lPAYMENTtabHeader1#">
	
	
   <cffile action="Append"
        file="#ExpandPath("./qbdownload/" & Variables.stabFilepay)#"
        output="#Variables.lPAYMENTtabHeader2#">

		
   <cffile action="Append"
        file="#ExpandPath("./qbdownload/" & Variables.stabFilepay)#"
        output="#Variables.lFINALtabHeader#">
		
    
    <!--- get invoices and user info for those that HAVE NOT been sent to Quickbooks and
	      have not been archived--->

    <cfquery username="#db_username#" password="#db_password#" name="getInvoices" datasource="#DATASOURCE#">
        SELECT invoices.itemnum, invoices.invoice_total, invoices.user_id, invoices.date_created, invoices.docnum,
		 users.name,  users.address1, users.address2, users.city, users.state, users.postal_code
          FROM invoices, users
		   where  users.user_id = invoices.user_id AND
		          invoices.date_exported IS NULL and
				  reference <> 'VOID'  AND
				  invoices.archive = 0 
	
		</cfquery>
	
	<cfloop query="getInvoices">
	  <!--- accumulate total invoices --->
		<cfset #total_invoices# = #total_invoices# + 
		#getInvoices.invoice_total#>
		<cfset #total_invwritten# = #total_invwritten# + 1 >
	</cfloop>
	
	<!--- get payments --->
    <cfquery username="#db_username#" password="#db_password#" name="getPayments" datasource="#DATASOURCE#">
        SELECT itemnum, date_posted, amount, reference, ID, docnum, payments.user_id, users.name as payname
          FROM payments, users
		  where  users.user_id = payments.user_id  AND
		        payments.date_exported IS NULL AND
				(reference <> 'REVERSAL') AND
				(reference <> 'REVERSED') AND
				payments.archive = 0
	 		
    </cfquery> 
 
    <cfloop query="getPayments">
	  <!--- accummulate total payments --->
		<cfset #total_payments# = #total_payments# + #getPayments.amount#>
		<cfset #total_paywritten# = #total_paywritten# + 1 >
	</cfloop>
	
 
  
  
  <!--- loop over Invoices & write out records--->
  <cfloop query="getInvoices">
  
   <!--- Create 1st Invoice line, total record --->
    
   <cfset sTmpContent = "">
   <cfset sTmpDate = #DateFormat("#getInvoices.date_created#", "mm/dd/yyyy")#>
  
    <cfset sTmpContent = ListAppend(sTmpContent, "TRNS", #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent, "", #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent,  "INVOICE", #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDate, #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, "Accounts Receivable", #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, getInvoices.name, #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent, getInvoices.invoice_total, #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent, getInvoices.docnum, #sTab#)>
	           
    <cfset stabContentinv = stabContentinv & sTmpContent & Variables.sNewline>
    
	
      
    <!--- create 2nd invoice line, a distribution record  --->
	
      <cfset sTmpContent = ""> 
	  <cfset sTmpDate = #DateFormat("#getInvoices.date_created#", "mm/dd/yyyy")#>
    
      <cfset sTmpContent = ListAppend(sTmpContent, "SPL", #sTab#)>
	  <cfset sTmpContent = ListAppend(sTmpContent, "", #sTab#)>
	  <cfset sTmpContent = ListAppend(sTmpContent, "INVOICE", #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDate, #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, "Auction Sales", #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, getInvoices.name, #sTab#)>
	  <cfset sTmpContent = ListAppend(sTmpContent, "-#getInvoices.invoice_total#", #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, #getInvoices.docnum# , #sTab#)>
                     
       <cfset stabContentinv = stabContentinv & sTmpContent & Variables.sNewline>
       <cfset sTmpContent = ""> 
	   <cfset sTmpContent = ListAppend(sTmpContent, "ENDTRNS", #sTab#)> 
	   <cfset stabContentinv = stabContentinv & sTmpContent & Variables.sNewline> 	
       <cfset sTmpContent = "">

    </cfloop>
	


    <!--- loop over payments --->
  <cfloop query="getPayments">
  
    <cfset sTmpDate = #DateFormat("#getPayments.date_posted#", "mm/dd/yyyy")#>

	<!--- Create 1st Payment line , a transaction record ---> 
  
    <cfset sTmpContent = "">
    <cfset sTmpContent = ListAppend(sTmpContent, "TRNS", #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent, "", #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent, "PAYMENT", #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDate, #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, "Undeposited Funds", #sTab#)>
	<cfset sTmpContent = ListAppend(sTmpContent, getPayments.payname, #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, getPayments.amount, #sTab#)>
    <cfset sTmpContent = ListAppend(sTmpContent, getPayments.docnum, #sTab#)>
        
    <cfset stabContentpay = stabContentpay & sTmpContent & Variables.sNewline>

	
     <cfset sTmpContent = "">
      
	<!--- Create 2nd Payment line, a distribution record --->
	  
	  <!---<cfset payment_offset = #getPayments.amount#  * -1>--->
	       
      <cfset sTmpContent = ListAppend(sTmpContent, "SPL", #sTab#)>
	  <cfset sTmpContent = ListAppend(sTmpContent, "", #sTab#)>
	  <cfset sTmpContent = ListAppend(sTmpContent, "PAYMENT", #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDate, #sTab#)>
	  <cfset sTmpContent = ListAppend(sTmpContent, "Accounts Receivable", #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent,  getPayments.payname, #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, "-#getPayments.amount#", #sTab#)>
      <cfset sTmpContent = ListAppend(sTmpContent, getPayments.docnum, #sTab#)>
      <cfset stabContentpay = stabContentpay & sTmpContent & Variables.sNewline>

	  <cfset sTmpContent = ""> 
	  <cfset sTmpContent = ListAppend(sTmpContent, "ENDTRNS", #sTab#)> 
	  <cfset stabContentpay = stabContentpay & sTmpContent & Variables.sNewline> 	
      <cfset sTmpContent = ""> 
	  
	  	  
    </cfloop>
   
	
    <!--- if Len stabContentpay & if present, strip trailing nl --->
    <cfif Len(stabContentpay)>
      <cfif Mid(stabContentpay, Evaluate(Len(stabContentpay) - 1), 2) IS "#Chr(13)#">
        
        <cfset stabContentpay = Mid(stabContentpay, 1, Evaluate(Len(stabContentpay) - 1))>
      </cfif>
    </cfif>
    
	<!--- if Len stabContentinv & if present, strip trailing nl --->
    <cfif Len(stabContentinv)>
      <cfif Mid(stabContentinv, Evaluate(Len(stabContentinv) - 1), 2) IS "#Chr(13)#">
        
        <cfset stabContentinv = Mid(stabContentinv, 1, Evaluate(Len(stabContentinv) - 1))>
      </cfif>
    </cfif>
	
	
	
    <!--- if Len ctabContentinv, append to invoice file --->
    <cfif Len(stabContentinv)>
      
      <cffile action="Append"
        file="#ExpandPath("./qbdownload/" & Variables.stabFileinv)#"
        output="#Variables.stabContentinv#">
        
      <cfset stabContentinv = "">
    </cfif>
	
	 <!--- if Len ctabContentpay, append to payment file --->
    <cfif Len(stabContentpay)>
      
      <cffile action="Append"
        file="#ExpandPath("./qbdownload/" & Variables.stabFilepay)#"
        output="#Variables.stabContentpay#">
        
      <cfset stabContentpay = "">
    </cfif>
	

  <!--- output page --->
  <cfsetting enablecfoutputonly="No">
 
 <cfoutput>
  <html>
    <head>
      <title>Visual Auction Server Administrator [Accounts Module-Quickbook files]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
      
    </head>
    
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
            <cfset #page# = "reports">
            <cfinclude template="menu_include.cfm">
            
            <tr>
              <td colspan=5 bgcolor=bac1cf>
                <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
                  <tr>
                    <td>
                      <table border=0 cellspacing=0 cellpadding=5 width=100%>
					  <tr>
                     <form name="quickForm" action="quickbooks_file.cfm"  method="post"> 
                        <tr>
                          <td>
                            <font face="helvetica" size=3 color=000000>
							  
                              <b>Your Quickbooks export files have been generated. <br>To process files, follow the steps below:</b><br><br>

1. To save files to your PC, click the <b>Save Files</b> button below. <br>
2. If browser is Internet Explorer, right click on each   file(quickbki.iif and quickbkp.iif) <br> and select <b>Save Target as </b>to save your files on your local PC. <br>
3. If browser is Netscape, click on each file(quickbki.iif and quickbkp.iif) <br> and then click on <b>Save </b>to save your files on your local PC. <br>
4. Once saved, bring up files in <b>Excel</b> to review accounts before attempting <br>to load into Quickbooks. You may need to modify files to make accounts <br>consistent with your Chart Of Accounts. <br>
5. If you modify in Excel, <b>you must save file as Tab delimited <br> with the existing extension of '.iif'</b> or Quickbooks will not allow Importing. <br> 
6. Once files have been reviewed/modifed, <b>Backup your Quickbooks database<br>before importing files.</b><br>
7. Import quickbki.iif, Invoices, into Quickbooks <br>
8. Import quickbkp.iif, Payments, into Quickbooks <br>



<br><br> <b>NOTE: Reversal and Void transactions are not included.</b><br> Please enter them directly into Quickbooks. 

                            </font>
                          </td>
                   </tr>
				   <tr>
				   <td>#total_invwritten#  invoice records written: </td>
				  </tr>			  
				   <tr>
				   <td>#total_paywritten# payment records written: </td>
				   </tr>
				  
				  <!--- go to download directory  --->
                  
				  <!---<cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/qbdownload">--->
						  				   
				  <tr><td><input type="submit" name="submit" value="Back"></td></tr>
                  <tr><td><input type="submit" name="submit2" value="Save Files"></td></tr>
                  </tr> 
				  
				  <!--- Update payments export date ---> 
	             
				  <cfloop query="getPayments">
				  
				    <cfif getPayments.recordcount is not 0>
					
				     <cfquery username="#db_username#"           password="#db_password#" datasource="#DATASOURCE#">
                       UPDATE payments        
		                 SET date_exported = #Variables.TIMENOW#
		               WHERE user_id = #getPayments.user_id#
                    </cfquery>
					
                   </cfif>		       
			   
			      </cfloop>
				  
				  
				  <!--- Update invoices export date ---> 
					   
			    <cfif getInvoices.recordcount is not 0>            
				   <cfloop query="getInvoices">
		   
				    <cfquery username="#db_username#"           password="#db_password#" datasource="#DATASOURCE#">
                       UPDATE Invoices    
		                 SET date_exported = #Variables.TIMENOW#
		               WHERE user_id = #getInvoices.user_id#
                    </cfquery>				
								
		          </cfloop>
			  </cfif>	 
	 </table>   
	</table>
</table>    

</body>
</cfoutput> 
</html>
				