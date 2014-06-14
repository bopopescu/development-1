<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/accountHistory.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<!---
  accountHistory.cfm
  
  account history report output screen
  
  files used:
    /admin/validate_include.cfm
    /admin/menu_include.cfm
    /functions/timenow.cfm
  
  Author: John Adams
  Date: 08/03/1999
  
---><cfsetting enablecfoutputonly="Yes">

<!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">

<!--- chk coming from reports menu --->
<cfif CGI.HTTP_REFERER DOES NOT CONTAIN "/admin/reports.cfm">
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/reports.cfm">
</cfif>

<!--- def TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- def vals --->
<cfparam name="type" default="html">
<cfparam name="sort" default="nameA">
<cfparam name="days" default="30">
<cfset sOutputType = type>
<cfset sNewline = Chr(13) & Chr(10)>
<cfset TIMENOW = DateAdd("n", -30, TIMENOW)>    <!--- backup TIMENOW 30 mins, so all auctions will have invoices --->

<cfset iDefDays = 30>
<cfset iDays = IIf(IsNumeric(days), "days", "Variables.iDefDays") - (2 * IIf(IsNumeric(days), "days", "Variables.iDefDays"))>
<cfset tsStartDay = DateAdd("d", Variables.iDays, TIMENOW)>
<cfset tsStartStamp = CreateODBCDateTime("#Year(tsStartDay)#-#Month(tsStartDay)#-#Day(tsStartDay)# 00:00:00")>

<cfset sSqlFields = "">
<cfset sSqlOrderBy = "">
<cfset sDefSqlOrderBy = "ORDER BY name ASC, date_registered ASC">

<cfset sCSVFile = "accounthistory#rand()#.csv">
<cfset lCSVHeader = '"User ID","Date","Item Number","Description","Amount"'>
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "">
<cfset lCSVFlds = "">

<cfset iHTMRowCount = 0>

<!--- <cfset lInvFeeFields = "listing,fee,studio,featured_studio,bold,featured,featured_cat,banner,second_cat,late_charge"> --->
<cfset lInvFeeFields = "invoice_total">
<cfset hInvFeeFields = StructNew()>
<cfset temp = StructInsert(hInvFeeFields, "listing", "Listing Fee")>
<cfset temp = StructInsert(hInvFeeFields, "fee", "Sale Fee (based on final sale price)")>
<cfset temp = StructInsert(hInvFeeFields, "studio", "Studio Fee")>
<cfset temp = StructInsert(hInvFeeFields, "featured_studio", "Featured Studio Fee")>
<cfset temp = StructInsert(hInvFeeFields, "bold", "Bold Listing Fee")>
<cfset temp = StructInsert(hInvFeeFields, "featured", "Main Featured Fee")>
<cfset temp = StructInsert(hInvFeeFields, "featured_cat", "Featured In Category Fee")>
<cfset temp = StructInsert(hInvFeeFields, "banner", "Banner Listing Fee")>
<cfset temp = StructInsert(hInvFeeFields, "second_cat", "Second Category Listing Fee")>
<cfset temp = StructInsert(hInvFeeFields, "late_charge", "Late Payment Fee")>
<cfset temp = StructInsert(hInvFeeFields, "invoice_total", "Invoice Total")>

<!--- def sql order by --->
<cfif sort IS "nameA">
  <cfset sSqlOrderBy = "ORDER BY name ASC, date_registered ASC">
  
<cfelseif sort IS "nameD">
  <cfset sSqlOrderBy = "ORDER BY name DESC, date_registered DESC">
  
<cfelseif sort IS "nicknameA">
  <cfset sSqlOrderBy = "ORDER BY nickname ASC, date_registered ASC">
  
<cfelseif sort IS "nicknameD">
  <cfset sSqlOrderBy = "ORDER BY nickname DESC, date_registered DESC">
  
<cfelse>
  <cfset sSqlOrderBy = Variables.sDefSqlOrderBy>
</cfif>

<!--- SETUP FOR CSV OUTPUT --->
<!---------------------------->
<cfif sOutputType IS "csv">
  
  <!--- if /admin/downloads dir doesn't exist, create --->
  <cfif not DirectoryExists(ExpandPath("./downloads"))>
    
    <cfdirectory action="Create"
      directory="#ExpandPath("./downloads")#"
      mode="666">
  </cfif>
  
  <!--- write header line of file --->
  <cffile action="Write"
    file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
    output="#Variables.lCSVHeader#">
  
  <!--- get accounts --->
  <cfquery username="#db_username#" password="#db_password#" name="getAccounts" datasource="#DATASOURCE#">
      SELECT user_id, name, nickname, date_registered, balance, company, address1, address2, city, state, postal_code
        FROM users
        #Variables.sSqlOrderBy#
  </cfquery>
  
  <!--- loop over accounts --->
  <cfloop query="getAccounts">
    
    <!--- def vals --->
    <cfset iCurrentUserId = getAccounts.user_id>
    
    <!--- get info for csv --->
    
    <!--- get invoices --->
    <cfquery username="#db_username#" password="#db_password#" name="getInvoices" datasource="#DATASOURCE#">
        SELECT itemnum, date_created, listing, fee, studio, featured_studio, bold, featured, featured_cat, banner, second_cat, late_charge, invoice_total
          FROM invoices
         WHERE date_created >= #Variables.tsStartStamp#
           AND user_id = #getAccounts.user_id#
         ORDER BY date_created ASC
    </cfquery>
    
    <!--- get payments --->
    <cfquery username="#db_username#" password="#db_password#" name="getPayments" datasource="#DATASOURCE#">
        SELECT itemnum, date_posted, amount, reference
          FROM payments
         WHERE date_posted >= #Variables.tsStartStamp#
           AND user_id = #getAccounts.user_id#
         ORDER BY date_posted ASC
    </cfquery>
    
    <!--- def vals --->
    <cfset sTmpContent = "">
    
    <!--- loop over fees --->
    <cfloop query="getInvoices">
      
      <cfloop index="e" list="#Variables.lInvFeeFields#">
        
        <cfif Evaluate("getInvoices." & e) GT 0>
          
          <cfset sTmpDate = """#getInvoices.date_created#""">
          <cfset sTmpDesc = """#Evaluate("hInvFeeFields." & e)#""">
          
          <cfset sTmpContent = ListAppend(sTmpContent, Variables.iCurrentUserId, ",")>
          <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDate, ",")>
          <cfset sTmpContent = ListAppend(sTmpContent, getInvoices.itemnum, ",")>
          <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDesc, ",")>
          <cfset sTmpContent = ListAppend(sTmpContent, Evaluate("getInvoices." & e), ",")>
          
          <cfset sCSVContent = sCSVContent & sTmpContent & Variables.sNewline>
          <cfset sTmpContent = "">
        </cfif>
      </cfloop>
    </cfloop>
    
    <!--- loop over payments --->
    <cfloop query="getPayments">
      
      <cfset sTmpDate = """#getPayments.date_posted#""">
      <cfset sTmpDesc = """#Replace(getPayments.reference, """", """""", "ALL")#""">
      
      <cfset sTmpContent = ListAppend(sTmpContent, Variables.iCurrentUserId, ",")>
      <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDate, ",")>
      <cfset sTmpContent = ListAppend(sTmpContent, getPayments.itemnum, ",")>
      <cfset sTmpContent = ListAppend(sTmpContent, Variables.sTmpDesc, ",")>
      <cfset sTmpContent = ListAppend(sTmpContent, "-#getPayments.amount#", ",")>
      
      <cfset sCSVContent = sCSVContent & sTmpContent & Variables.sNewline>
      <cfset sTmpContent = "">
    </cfloop>
    
    <!--- if Len sCSVContent & if present, strip trailing nl --->
    <cfif Len(sCSVContent)>
      <cfif Mid(sCSVContent, Evaluate(Len(sCSVContent) - 1), 2) IS "#Chr(13)##Chr(10)#">
        
        <cfset sCSVContent = Mid(sCSVContent, 1, Evaluate(Len(sCSVContent) - 1))>
      </cfif>
    </cfif>
    
    <!--- if Len cCSVContent, append to file --->
    <cfif Len(sCSVContent)>
      
      <cffile action="Append"
        file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
        output="#Variables.sCSVContent#">
        
      <cfset sCSVContent = "">
    </cfif>
  </cfloop>
  
  <!--- redirect to file --->
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/downloads/#Variables.sCSVFile#">
  
<!--- SETUP FOR HTML DISPLAY --->
<!------------------------------>
<cfelseif sOutputType IS "html">
  
  <!--- get accounts --->
  <cfquery username="#db_username#" password="#db_password#" name="getAccounts" datasource="#DATASOURCE#">
      SELECT user_id, name, nickname, date_registered, balance, company, address1, address2, city, state, postal_code
        FROM users
        #Variables.sSqlOrderBy#
  </cfquery>
  
  <!--- get currency code --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <cfif getCurrency.RecordCount>
    <cfset sSiteCurrency = Trim(getCurrency.pair)>
  <cfelse>
    <cfset sSiteCurrency = "">
  </cfif>
  
  <!--- output page --->
  <cfsetting enablecfoutputonly="No">
  
  <html>
    <head>
      <title>Visual Auction Server Administrator [Reports Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
      
    </head>
    
    <body bgcolor=465775 link=0000ff alink=ffaa00 vlink=999999>
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
                          <td>
                            <font face="helvetica" size=2 color=000000>
                              Use this page to print reports and conduct statistical analysis of your <i>Auction Server</i>.<br>
                              If you do not know how to use this administration tool, please <!--- consult your user manual or --->click the help button in the upper right corner of this window.
                                          <hr size=1 color=#heading_color# width=100%> 
                            </font>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <table border=0 cellspacing=0 cellpadding=0 width=100%>
                              <tr>
                                <td>&nbsp;<font face="helvetica" size=2 color=000080><b>ACCOUNT HISTORY:</b></font></td>
                                <td align=right><font face="helvetica" size=2><b><cfoutput>#DateFormat(tsStartStamp, "mm/dd/yyyy")# - #DateFormat(TIMENOW, "mm/dd/yyyy")#</cfoutput></b></font>&nbsp;</td>
                              </tr>
                            </table>
                            
                            <!--- The main table with the dark blue border --->
                            <table width=100% border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                              <tr>
                                <td>
                                  
                                  <cfsetting enablecfoutputonly="Yes">
                                  
                                  <!--- loop over accounts --->
                                  <cfloop query="getAccounts">
								  	
                                    <!--- setup info for fees/payments --->
                                    
                                    <!--- get invoices --->
                                    <cfquery username="#db_username#" password="#db_password#" name="getInvoices" datasource="#DATASOURCE#">
                                        SELECT itemnum, date_created, listing, fee, studio, featured_studio, bold, featured, featured_cat, banner, second_cat, late_charge,invoice_total
                                          FROM invoices
                                         WHERE date_created >= #Variables.tsStartStamp#
                                           AND user_id = #getAccounts.user_id#
                                         ORDER BY date_created ASC
                                    </cfquery>
                                    
                                    <!--- get payments --->
                                    <cfquery username="#db_username#" password="#db_password#" name="getPayments" datasource="#DATASOURCE#">
                                        SELECT itemnum, date_posted, amount, reference
                                          FROM payments
                                         WHERE date_posted >= #Variables.tsStartStamp#
                                           AND user_id = #getAccounts.user_id#
                                         ORDER BY date_posted ASC
                                    </cfquery>
                                    
                                    <cfoutput>
                                      <table border=0 cellpadding=0 cellspacing=2 width=100%>
                                        <tr>
                                          <td width=20% align=right><font size=2 face="helvetica"><b>Name:</b></font></td>
                                          <td width=25% valign=bottom><font size=1 face="helvetica">#Trim(getAccounts.name)#</font></td>
                                          <td width=20% align=right><font size=2 face="helvetica"><b>Company Name:</b></font></td>
                                          <td width=35% valign=bottom><font size=1 face="helvetica">#Trim(getAccounts.company)#</font></td>
                                        </tr>
                                        <tr>
                                          <td align=right><font size=2 face="helvetica"><b>Nickname:</b></font></td>
                                          <td valign=bottom><font size=1 face="helvetica">#Trim(getAccounts.nickname)#</font></td>
                                          <td align=right><font size=2 face="helvetica"><b>Address:</font></td>
                                          <td valign=bottom><font size=1 face="helvetica">#Trim(getAccounts.address1)#</font></td>
                                        </tr>
                                        <tr>
                                          <td align=right><font size=2 face="helvetica"><b>Member Since:</b></font></td>
                                          <td valign=bottom><font size=1 face="helvetica">#DateFormat(getAccounts.date_registered, "dd/mm/yyyy")#</font></td>
                                          <td align=right><font size=2 face="helvetica"><b><cfif not Len(Trim(getAccounts.address2))>City/State/Zip:</cfif></b></font></td>
                                          <td valign=bottom><font size=1 face="helvetica"><cfif Len(Trim(getAccounts.address2))>#Trim(getAccounts.address2)#<cfelse>#Trim(getAccounts.city)#, #Trim(getAccounts.state)#  #Trim(getAccounts.postal_code)#</cfif></font></td>
                                        </tr>
                                        <tr>
                                          <td align=right><font size=2 face="helvetica"><b>Current Balance:</b></font></td>
                                          <td valign=bottom><font size=1 face="helvetica">#numberformat(getAccounts.balance,numbermask)# #Variables.sSiteCurrency#</font></td>
                                          <td align=right><font size=2 face="helvetica"><b><cfif Len(Trim(getAccounts.address2))>City/State/Zip:</cfif></b></font></td>
                                          <td valign=bottom><font size=1 face="helvetica"><cfif Len(Trim(getAccounts.address2))>#Trim(getAccounts.city)#, #Trim(getAccounts.state)#  #Trim(getAccounts.postal_code)#</cfif></font></td>
                                        </tr>
                                      </table>
                                      <font size=1><br></font>
                                      <table border=0 cellpadding=2 cellspacing=0 width=100%>
                                        <tr bgcolor=cbeef9>
                                          <td align=center><font size=2 face="helvetica"><b>Date</b></font></td>
                                          <td><font size=2 face="helvetica"><b>Item No.</b></font></td>
                                          <td><font size=2 face="helvetica"><b>Fee Description</b></font></td>
                                          <td align=right><font size=2 face="helvetica"><b>Amount</b></font></td>
                                        </tr>
                                    </cfoutput>
                                    
                                    <cfset iRecsListed = 0>
                                    
                                    <!--- loop over fees --->
                                    <cfloop query="getInvoices">
                                      
                                      <cfloop index="e" list="#Variables.lInvFeeFields#">
                                        
                                        <cfif Evaluate("getInvoices." & e) GT 0>
                                          
                                          <cfset iHTMRowCount = iHTMRowCount + 1>
                                          <cfset iRecsListed = iRecsListed + 1>
                                          
                                          <cfoutput>
                                            <tr <cfif iHTMRowCount GT 2>bgcolor=bac1cf</cfif>>
                                              <td align=center><font size=2 face="helvetica">#DateFormat(getInvoices.date_created, "mm/dd/yyyy")#</font></td>
                                              <td><font size=2 face="helvetica"><a href="acctdetls.cfm?submit=Retrieve&selected_item=#getInvoices.itemnum#" target="_blank">#getInvoices.itemnum#</a></font></td>
                                              <td><font size=2 face="helvetica"><a href="acctdetls.cfm?submit=Retrieve&selected_item=#getInvoices.itemnum#" target="_blank">#Evaluate("hInvFeeFields." & e)#</a></font></td>
                                              <td align=right><font size=2 face="helvetica">#numberformat(Evaluate("getInvoices." & e),numbermask)#</font></td>
                                            </tr>
                                          </cfoutput>
                                          
                                          <cfif iHTMRowCount GTE 4>
                                            <cfset iHTMRowCount = 0>
                                          </cfif>
                                         </cfif>
                                      </cfloop>
                                    </cfloop>
                                    
                                    <cfset iHTMRowCount = 0>
                                    
                                    <!--- if no invoices --->
                                    <cfif not iRecsListed>
                                      
                                      <cfoutput>
                                        <tr>
                                          <td align=center><font size=2 face="helvetica">-</font></td>
                                          <td align=center><font size=2 face="helvetica">-</font></td>
                                          <td><font size=2 face="helvetica">No Records Available</font></td>
                                          <td align=right><font size=2 face="helvetica">-</font></td>
                                        </tr>
                                      </cfoutput>
                                    </cfif>
                                    
                                    <cfoutput>
                                        <tr bgcolor=cbeef9>
                                          <td align=center><font size=2 face="helvetica"><b>Date</b></font></td>
                                          <td><font size=2 face="helvetica"><b>Item No.</b></font></td>
                                          <td><font size=2 face="helvetica"><b>Payment Description</b></font></td>
                                          <td align=right><font size=2 face="helvetica"><b>Amount</b></font></td>
                                        </tr>
                                    </cfoutput>
                                    
                                    <cfset iHTMRowCount = 0>
                                    <cfset iRecsListed = 0>
                                    
                                    <!--- loop over payments --->
                                    <cfloop query="getPayments">
                                      
                                      <cfset iHTMRowCount = iHTMRowCount + 1>
                                      <cfset iRecsListed = iRecsListed + 1>
                                      
                                      <cfoutput>
                                        <tr <cfif iHTMRowCount GT 2>bgcolor=bac1cf</cfif>>
                                          <td align=center><font size=2 face="helvetica">#DateFormat(getPayments.date_posted, "mm/dd/yyyy")#</font></td>
                                          <td><font size=2 face="helvetica">#getPayments.itemnum#</font></td>
                                          <td><font size=2 face="helvetica">#getPayments.reference#</font></td>
                                          <td align=right><font size=2 face="helvetica">#numberformat(getPayments.amount,numbermask)#</font></td>
                                        </tr>
                                      </cfoutput>
                                      
                                      <cfif iHTMRowCount GTE 4>
                                        <cfset iHTMRowCount = 0>
                                      </cfif>
                                    </cfloop>
                                    
                                    <!--- if no payments --->
                                    <cfif not iRecsListed>
                                      
                                      <cfoutput>
                                        <tr>
                                          <td align=center><font size=2 face="helvetica">-</font></td>
                                          <td align=center><font size=2 face="helvetica">-</font></td>
                                          <td><font size=2 face="helvetica">No Records Available</font></td>
                                          <td align=right><font size=2 face="helvetica">-</font></td>
                                        </tr>
                                      </cfoutput>
                                    </cfif>
                                    
                                    <cfoutput>
                                      </table>
                                      
                                      <cfif getAccounts.CurrentRow LT getAccounts.RecordCount>
                                                    <hr size=1 color=#heading_color# width=100%> 
                                      </cfif>
                                    </cfoutput>
                                    
                                  </cfloop>
                                  
                                  <cfsetting enablecfoutputonly="No">
                                  
                                </td>
                              </tr>
                            </table>
                          </td>
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
</cfif>
