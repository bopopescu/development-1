<!---
/admin/accounts.cfm
--->




<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">  
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">

 <cfif IsDefined('selected_item') IS 0>
   <cfif IsDefined('selected_item_ads')>
     <cfset selecteditem = #selected_item_ads#>
   </cfif>
 <cfelse>
   <cfif IsDefined('selected_item')>
     <cfset selecteditem = #selected_item#>
   </cfif>
 </cfif>                  
 <cfparam name="selected_item" default = 0>     
 <cfparam name="selected_item_ads" default = 0>
 
<!---  
<cfif IsDefined('selected_item')>
  <cfoutput>selected_item = #selected_item#<br></cfoutput>
<cfelse>
  <cfoutput>selected_item NOT defined<BR></cfoutput>
</cfif>  

<cfif IsDefined('selected_item_ads')>
  <cfoutput>selected_item_ads = #selected_item_ads#<br></cfoutput>
<cfelse>
  <cfoutput> selected_item_ads NOT defined<br></cfoutput>
</cfif>
 --->
  
  <!--- if submitting payment --->
  <cfif IsDefined("Form.sSubmitPayment")
    AND IsDefined("Form.fPaymentAmount")
    AND CGI.HTTP_REFERER CONTAINS "/admin/accounts.cfm">
    
    <!--- def vals --->
    <cfset sPaymentRef = "Payment">
    
    <!--- vals to make script load invoice again after submit --->
    <cfset submit = "Retrieve">
    <cfset selecteditem = itemnum>



    <!--- inc timenow --->
    <cfmodule template="../functions/timenow.cfm">
    
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
              SELECT user_id
                FROM invoices
               WHERE itemnum = #itemnum#
          </cfquery>


<!---           <cfoutput>total fees = #totalfees#<br></cfoutput>
          <cfoutput>Payment Amount = #variables.fPaymentAmount#<br></cfoutput>
          <cfoutput>fPaymentAmount-TotalFee = #evaluate(fPaymentAmount-totalfees)#<br></cfoutput>
   --->        

          
          <!--- adjust account balance --->
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE users
                 SET balance = balance - #Variables.fPaymentAmount#
                 WHERE user_id = #resolve_userid.user_id#
          </cfquery>
          
          <!--- adjust invoice paid --->
          <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
              UPDATE invoices
                 SET paid = paid + #Variables.fPaymentAmount#
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
                 reference
                )
              VALUES
                (
                 #itemnum#,
                 #Variables.TIMENOW#,
                 #resolve_userid.user_id#,
                 #Variables.fPaymentAmount#,
                 '#Variables.sPaymentRef#'
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
  

 <!--- Set defaults of they're here for the first time --->
 <cfif #isDefined ("submit")#>
  <cfset #submit# = #trim (submit)#>
 <cfelse>
  <cfset #submit# = "">
 </cfif>







  <!--- Check to see if they want to delete an invoice --->
  <cfif #submit# is "Delete">
    <cfquery username="#db_username#" password="#db_password#" name="delete_invoice" DATASOURCE="#DATASOURCE#">
        DELETE FROM invoices
         WHERE itemnum = #selecteditem#
    </cfquery>
    
   <!--- log invoice deletion --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Invoice Deleted"
      itemnum="#selecteditem#">
  </cfif>











  <!--- Check to see if they were updating a record --->
  <cfif #submit# is "Update Record">
    
    <!--- Find who's item this is --->
    <cfquery username="#db_username#" password="#db_password#" name="resolve_userid" datasource="#DATASOURCE#">
        SELECT user_id
          FROM invoices
         WHERE itemnum = #itemnum#
    </cfquery>
    <!--- strip all but numerics from fee vals --->
    <cfloop index="e" list="studio,featured_studio,listing,second_cat,fee,bold,banner,featured,featured_cat,fee_inspector,late_charge">
      <cfset "#e#" = REReplace(Evaluate(e), "[^0-9.]", "", "ALL")>
      <cfif not Len(Evaluate(e))>
        <cfset "#e#" = 0.00>
      </cfif>
    </cfloop>
    

    <cfset #total#=#evaluate ("studio+featured_studio+listing+second_cat+fee+bold+banner+featured+featured_cat+fee_inspector+late_charge")#>
    
    <cfquery username="#db_username#" password="#db_password#" name="update_invoice" datasource="#DATASOURCE#">
        UPDATE invoices
           SET date_due = #CreateODBCDateTime (date_due)#,
               listing = #listing#,
               second_cat = #second_cat#,
               fee = #fee#,
               bold = #bold#,
               featured = #featured#,
               featured_cat = #featured_cat#,
               banner = #banner#,
               studio = #studio#,
               featured_studio = #featured_studio#,
               fee_inspector = #fee_inspector#, 
               late_charge = #late_charge#,
               reference = '#reference#',
               invoice_total = #total#
         WHERE itemnum = #itemnum#
  </cfquery>
    
    <!--- log update to invoice --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Invoice Updated"
      itemnum="#itemnum#"
      details="DUE DATE: #CreateODBCDateTime(date_due)#     LISTING FEE: #listing#     2ND CATEGORY FEE: #second_cat#     SALE FEE: #fee#     BOLD TITLE FEE: #bold#     BANNER FEE: #banner#     FEATURED FEE: #featured#     CATEGORY FEATURED FEE: #featured_cat#     LATE CHARGE: #late_charge#     REFERENCE: #reference#   STUDIO: #studio#    FEATURED STUDIO: #featured_studio#">
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
         invoices.fee_inspector,
         invoices.late_charge,
         invoices.paid,
         invoices.reference,
         users.name,
         users.balance,
         users.user_id,
         items.quantity,
         items.inspector
FROM invoices, users, items
   WHERE items.itemnum = invoices.itemnum 
     AND users.user_id = invoices.user_id
   <cfif #filter# is "Paid">
     AND invoices.paid >= invoices.invoice_total
   </cfif>
   <cfif #filter# is "Overdue">
     AND invoices.paid < invoices.invoice_total
   </cfif>

   ORDER BY users.name, invoices.date_created
 </cfquery>
<!---   WHERE invoices.status = 0 --->



<cfif classified_valid is "Yes">  
<!--- Get a list of active users (classifieds) that have account info --->
 <cfquery username="#db_username#" password="#db_password#" name="get_user_list_ads" datasource="#DATASOURCE#">
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
         invoices.fee_inspector,
         invoices.late_charge,
         invoices.paid,
         invoices.reference,
         users.name,
         users.balance,
         users.user_id
FROM invoices, users, ad_info
   WHERE ad_info.adnum = invoices.itemnum
      AND users.user_id = invoices.user_id
   <cfif #filter# is "Paid">
     AND invoices.paid >= invoices.invoice_total
   </cfif>
   <cfif #filter# is "Overdue">
     AND invoices.paid < invoices.invoice_total
   </cfif>
   ORDER BY users.name, invoices.date_created
 </cfquery>
</cfif> 
 
 

 
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
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>           
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
            <td colspan=2>
             <font face="helvetica" size=2 color=000000>
              Use this page to administer the user billing accounts in your <i>Auction Server</i> software.  If you do not<br>
              know how to use this administration tool, please click the help button in the upper right corner of this window.
                          <hr size=1 color=#heading_color# width=100%> 
             </font>
            </td>
           </tr>
           <tr>
            <form name="userForm" action="accounts.cfm" method="post">
        
             <td valign="top" align="left">
              &nbsp;<font face="Helvetica" size=2 color=000080><b>SELLER FEE INVOICE MANAGER</b></font><br>
              <br>


              <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
               <tr>
                <td>
                 <table border=0 bordercolor=ffffff cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                 <cfif #submit# is not "Retrieve">
                  <tr>
                   <cfoutput><td><font face="helvetica" size=2>&nbsp;<b>Please select a user from the lists:<br><br>&nbsp;AUCTION ITEMS</b>&nbsp;(#get_user_list.recordcount# records found)</font></td></cfoutput>
                   <td>&nbsp;</td>
                  </tr>
                  <tr>
                   <td>
                    <cfif #isDefined ("form.itemnum")#>
                     <cfset #the_itemnum# = #form.itemnum#>
                    <cfelse>
                     <cfset #the_itemnum# = #get_user_list.itemnum#>
                    </cfif>
                    <select name="selected_item" size=10 width=304 onBlur="this.blur()" >
                     <cfif #get_user_list.recordcount# is 0><option value="-1">< none ></option></cfif>                    <cfloop query="get_user_list"><cfoutput><option value="#itemnum#">#name#&nbsp;[Item ###itemnum#]&nbsp;(#dateFormat (date_created, "mm-dd-yyyy")#)</option></cfoutput></cfloop>                      
                    </select>
                    
                   </td>
                   <td valign="top">

<cfif classified_valid is "no"> 
                    <table border=0 cellspacing=0 cellpadding=2>
                     <tr>
                       <td>
                         <cfif #get_user_list.recordcount# GT 0 or #get_user_list_ads.recordcount# GT 0>
                           <input type="submit" name="submit" value="Retrieve" width=70>
                         <cfelse>
                           &nbsp;
                         </cfif>
                       </td>
                     </tr>
                     <tr>
                       <td>
                         <input type="submit" name="submit" value=" Refresh" width=65>
                       </td> 
                     <tr>
                       <td>
                         <cfif #get_user_list.recordcount# GT 0 or #get_user_list_ads.recordcount# GT 0>
                           <input type="submit" name="submit" value="Delete" width=70>
                         <cfelse>
                           &nbsp;
                         </cfif>
                       </td>
                     </tr>
                    </table>
<cfelse>
                    &nbsp;
</cfif>                    
                   </td>
                  </tr>
                  
<cfif classified_valid is "Yes">  
                  <tr>
                    <td colspan=2>            <hr size=1 color=#heading_color# width=100%> </td>
                  </tr> 
                  <tr>
                    <td><font face="helvetica" size=2>&nbsp;<b>CLASSIFIED ADS</b>&nbsp;<cfoutput>(#get_user_list_ads.recordcount# records found)</cfoutput></font></td>
                    <td>&nbsp;</td>
                  </tr>  
                  
                  <tr>
                    <td>
                      <cfif #isDefined ("form.itemnum")#>
                        <cfset #the_itemnum# = #form.itemnum#>
                      <cfelse>
                        <cfset #the_itemnum# = #get_user_list_ads.itemnum#>
                      </cfif>
                      <select name="selected_item_ads" size=10 width=304 onblur="this.blur()">
                        <cfif #get_user_list_ads.recordcount# is 0><option value="-1">< none ></option></cfif>
                        <cfloop query="get_user_list_ads"><cfoutput><option value="#itemnum#">#name#&nbsp;[Item ###itemnum#]&nbsp;(#dateFormat (date_created, "mm-dd-yyyy")#)</option></cfoutput></cfloop>                      
                      </select>
                    </td>
                    <td valign=top>
                      <table border=0 cellspacing=0 cellpadding=2>
                        <tr>
                          <td>
                            <cfif #get_user_list.recordcount# GT 0 or #get_user_list_ads.recordcount# GT 0>
                              <input type="submit" name="submit" value="Retrieve" width=70>
                            <cfelse>
                              &nbsp;
                            </cfif>
                          </td>
                        </tr>
                        <td>
                          <input type="submit" name="submit" value=" Refresh" width=65>
                        </td> 
                      <tr>
                        <td>
                          <cfif #get_user_list.recordcount# GT 0 or #get_user_list_ads.recordcount# GT 0>
                            <input type="submit" name="submit" value="Delete" width=70>
                          <cfelse>
                            &nbsp;
                          </cfif>
                        </td>
                      </tr>
                    </table>

                  </tr>  
                  
</cfif>                  
                  
                  
                  
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
                      <td><input type="radio" name="filter" value="Overdue"<cfif #filter# is "Overdue"> checked</cfif>><font face="helvetica" size=2>Unpaid</font></td>
                      <td>&nbsp;</td>
                     </tr>
                    </table>
                   </td>
                   <td>&nbsp;</td>
                  </tr>
                </cfif>
                <cfif #submit# is "Retrieve">
                
                
               
<!---                 <cfif IsDefined('selected_item') IS 0>
                  <cfset selecteditem = #selected_item_ads#>
                <cfelse>
                  <cfset selecteditem = #selected_item#>
                </cfif>                  

                <cfparam name="selected_item" default = 0>     
                <cfparam name="selected_item_ads" default = 0>  --->
                  
                <cfquery username="#db_username#" password="#db_password#" name="get_invoice" DATASOURCE="#DATASOURCE#">
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
                         invoices.fee_inspector,
                         users.name,
                         users.balance,
                         users.credit,
                         users.statement_date,
                         items.title,
                         items.quantity,
                         items.inspector
                    FROM invoices, users, items, ad_info
                    WHERE users.user_id = invoices.user_id
                     AND items.itemnum = invoices.itemnum
                     AND items.itemnum = #selecteditem# 
                     <cfif classified_valid is "Yes">  
                      OR users.user_id = invoices.user_id
                     AND ad_info.adnum = invoices.itemnum

                     AND ad_info.adnum = #selecteditem# </cfif>
                  </cfquery>
 

<!---                  
                 <cfoutput>listing = #get_invoice.listing#<br></cfoutput>
                 <cfoutput>second_cat = #get_invoice.second_cat#<br></cfoutput>
                 <cfoutput>fee = #get_invoice.fee#<br></cfoutput>
                 <cfoutput>bold = #get_invoice.bold#<br></cfoutput>
                 <cfoutput>banner = #get_invoice.banner#<br></cfoutput>
                 <cfoutput>feature = #get_invoice.featured#<br></cfoutput>
                 <cfoutput>featured_cat = #get_invoice.featured_cat#<br></cfoutput>
                 <cfoutput>fee_inspector = #get_invoice.fee_inspector#<br></cfoutput>
                 <cfoutput>studio = #get_invoice.studio#<br></cfoutput>
                 <cfoutput>featured_studio = #get_invoice.featured_studio#<br></cfoutput>
                 <cfoutput>late_charge = #get_invoice.late_charge#<br></cfoutput>
 --->

                 <cfset #total# = #Evaluate(get_invoice.listing + get_invoice.second_cat + get_invoice.fee + get_invoice.bold + get_invoice.banner  + get_invoice.featured + get_invoice.featured_cat + get_invoice.fee_inspector + get_invoice.studio + get_invoice.featured_studio + get_invoice.late_charge)#>
                                  
                 
                 <cfoutput>
                  <input type="hidden" name="TotalFees" value="#total#">
                  <input type="hidden" name="itemnum" value="#get_invoice.itemnum#">
                  <input type="hidden" name="paid" value="#get_invoice.paid#">
                  <input type="hidden" name="balance" value="#get_invoice.balance#">
                  <input type="hidden" name="theCredit" value="#get_invoice.credit#">
                  <tr>
                   <td><font face="helvetica" size=2><b>Invoice ##:</b></font></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=4>#get_invoice.itemnum#</font></td>
                  </tr>
<!---                   <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
                  
                  <!--- if not paid, disp. payment form --->


                  <cfif get_invoice.paid LT Variables.total>
                    <tr>
                      <td><font face="helvetica" size=2><input name="sSubmitPayment" type=submit value="Make Payment"></font></td>
                      <td>&nbsp;</td>
                      <td><input name="fPaymentAmount" type=text value="" size=20></td>
                    </tr>
                    <tr>
                      <td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td>
                    </tr>
                  </cfif> --->
                 
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
                   <td><input name="date_due" size=22 maxlength=22 value="#dateFormat (get_invoice.date_due, 'mm-dd-yyyy')#"></td>
                  </tr>
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
                   <td><input type="text" name="listing" size=8 maxlength=15 value="#numberformat (get_invoice.listing,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Second category fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="second_cat" size=8 maxlength=15 value="#numberformat (get_invoice.second_cat,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>% of sale fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="fee" size=8 maxlength=15 value="#numberformat (get_invoice.fee,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Bold title fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="bold" size=8 maxlength=15 value="#numberformat (get_invoice.bold,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Banner fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="banner" size=8 maxlength=15 value="#numberformat (get_invoice.banner,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Studio inclusion fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="studio" size=8 maxlength=15 value="#numberformat (get_invoice.studio,numbermask)#"></td>
                  </tr>

                  <tr>
                   <td><font face="helvetica" size=2><b>Main feature fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="featured" size=8 maxlength=15 value="#numberformat (get_invoice.featured,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Category feature fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="featured_cat" size=8 maxlength=15 value="#numberformat (get_invoice.featured_cat,numbermask)#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Studio feature fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="featured_studio" size=8 maxlength=15 value="#numberformat (get_invoice.featured_studio,numbermask)#"></td>
                  </tr>

                  
                  
                  
                <cfif get_invoice.inspector is not "">          
                  <tr>
                   <td><font face="helvetica" size=2><b>Item Inspector fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="fee_inspector" size=8 maxlength=15 value="#numberformat (get_invoice.fee_inspector,numbermask)#"></td>
                  </tr>
                <cfelse>           
                  <input type="hidden" name="fee_inspector" value="0">
                </cfif>

                  
                  
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Late charge:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input type="text" name="late_charge" size=8 maxlength=15 value="#numberformat (get_invoice.late_charge,numbermask)#"></td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
            

                  <tr>
                   <td><font face="helvetica" size=2><b>Total fees:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><font face="helvetica" size=2>#numberformat(total,numbermask)# (Includes all fees + late charge)</font></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Amount already paid:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>

                   <td><font face="helvetica" size=2>#numberformat(get_invoice.paid,numbermask)#&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                  </tr>

                  <tr>
                   <td><font face="helvetica" size=2><b>Remaining balance:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                   <td><font face="helvetica" size=2><cfif #get_invoice.paid# GTE #total#><font color="00a000"><b>PAID IN FULL</b></font><cfelse><font color="a00000"><b>#numberformat(Evaluate(total - get_invoice.paid),numbermask)# #Trim(getCurrency.type)# STILL DUE</b></font></cfif></font></td>
                  </tr>

                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  <tr>
                    <td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td>
                  </tr>  
                  <tr>
                    <td><font face="helvetica" size=2><b>User's Current Balance</b></font></td>
                    <td align="right"><font face="helvetica" size=2><b>$</b></font></td>
                    <cfset current_balance = #get_invoice.balance# - #get_invoice.credit#> 
                    <td>
                      <font face="helvetica" size=2><b>
                      #numberformat(abs(current_balance),numbermask)#
                      <cfif #current_balance# GT 0>
                        <font color="00a000"> STILL DUE</font>
                      <cfelseif #current_balance# IS 0>
                        <font color="000000"> PAID IN FULL</b></font>
                      <cfelseif #current_balance# LT 0> 
                        <font color="a00000"> CREDIT</b></font>
                      </cfif>
                      </font>
                    </td>
                  </tr>                  

                  <!--- if not paid, disp. payment form --->
                  <cfif get_invoice.paid LT Variables.total>
                    <tr><td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td></tr>
                    <tr>
                      <td><font face="helvetica" size=2><input name="sSubmitPayment" type=submit value="Make Payment"></font></td>
                      <td>&nbsp;</td>
                      <td><input name="fPaymentAmount" type=text value="" size=20></td>
                    </tr>
                   </cfif>
                  
                  
                  
                  </cfoutput>
                 </cfif>
                 </table>               
                </td>         
               </tr>
               <cfif #submit# is "Retrieve">
                <tr>
                  <td>
                  <br>
                    <input type="submit" name="submit" value="Update Record">&nbsp;&nbsp;
                    <input type="submit" name="submit" value="Cancel (Back)">
                    
                  </td>
                </tr>
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