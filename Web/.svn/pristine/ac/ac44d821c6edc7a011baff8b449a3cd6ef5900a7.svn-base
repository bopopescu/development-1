<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/transactionLog.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<!---
  transactionLog.cfm
  
  transaction log report output screen
  
  files used:
    /admin/validate_include.cfm
    /admin/menu_include.cfm
    /functions/timenow.cfm
  
  Author: John Adams
  Date: 08/06/1999
  
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
<cfparam name="type" default="csv">
<cfparam name="sort" default="dateA">
<cfparam name="days" default="30">
<cfset sOutputType = type>
<cfset sNewline = Chr(13) & Chr(10)>

<cfset iDefDays = 30>
<cfset iDays = IIf(IsNumeric(days), "days", "Variables.iDefDays") - (2 * IIf(IsNumeric(days), "days", "Variables.iDefDays"))>
<cfset tsStartDay = DateAdd("d", Variables.iDays, TIMENOW)>
<cfset tsStartStamp = CreateODBCDateTime("#Year(tsStartDay)#-#Month(tsStartDay)#-#Day(tsStartDay)# 00:00:00")>

<cfset sSqlFields = "">
<cfset sSqlOrderBy = "">
<cfset sDefSqlOrderBy = "ORDER BY date_posted ASC, trans_id ASC">

<cfset iHTMDescSpan = 30>
<cfset iHTMRowCount = 0>

<cfset sCSVFile = "transactionlog#rand()#.csv">
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "date_posted, description, details, remote_ip">
<cfset lCSVFlds = "date_posted, trans_id, itemnum, user_id, amount, remote_ip, description, details">
<cfset sCSVHeader = '"Date","Transaction ID","Item Number","User ID","Amount","Remote IP","Description","Details"'>

<!--- def sql order by --->
<cfif sort IS "dateA">
  <cfset sSqlOrderBy = "ORDER BY date_posted ASC, trans_id ASC">
  
<cfelseif sort IS "dateD">
  <cfset sSqlOrderBy = "ORDER BY date_posted DESC, trans_id DESC">
  
<cfelseif sort IS "descA">
  <cfset sSqlOrderBy = "ORDER BY description ASC">
  
<cfelseif sort IS "descD">
  <cfset sSqlOrderBy = "ORDER BY description DESC">
  
<cfelseif sort IS "itemA">
  <cfset sSqlOrderBy = "ORDER BY itemnum ASC">
  
<cfelseif sort IS "itemD">
  <cfset sSqlOrderBy = "ORDER BY itemnum DESC">
  
<cfelseif sort IS "useridA">
  <cfset sSqlOrderBy = "ORDER BY user_id ASC">
  
<cfelseif sort IS "useridD">
  <cfset sSqlOrderBy = "ORDER BY user_id DESC">
  
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
  
  <!--- write header line of csv --->
  <cffile action="Write"
    file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
    output="#Variables.sCSVHeader#">
    
  <!--- get transaction log --->
  <cfquery username="#db_username#" password="#db_password#" name="getLog" datasource="#DATASOURCE#">
      SELECT date_posted, trans_id, itemnum, user_id, amount, remote_ip, description, details
        FROM transaction_log
       WHERE date_posted >= #Variables.tsStartStamp#
       #Variables.sSqlOrderBy#
  </cfquery>
  
  <!--- loop over transactions --->
  <cfloop query="getLog">
    
    <!--- def vals --->
    <cfset sTmpContent = "">
    
    <!--- setup info --->
    <cfloop index="e" list="#Variables.lCSVFlds#">
      
      <cfif ListContainsNoCase(Variables.lCSVStringFlds, Trim(e), ",")>
        <cfset sTemp = """" & Replace(Evaluate("getLog." & Trim(e)), """", """""", "ALL") & """">
      <cfelse>
        <cfset sTemp = Evaluate("getLog." & Trim(e))>
      </cfif>
      
      <cfset sTmpContent = ListAppend(sTmpContent, sTemp, ",")>
    </cfloop>
    
    <!--- add new line to content w/o newline --->
    <cfif getLog.CurrentRow MOD Variables.iCSVRecsPerWrite EQ 0
      OR getLog.CurrentRow IS getLog.RecordCount>
      
      <cfset sCSVContent = sCSVContent & sTmpContent>
    
    <!--- add new line to content w/ newline --->
    <cfelse>
      <cfset sCSVContent = sCSVContent & sTmpContent & Variables.sNewline>
    </cfif>
    
    <!--- append to file --->
    <cffile action="Append"
      file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
      output="#Variables.sCSVContent#">
      
    <cfset sCSVContent = "">
  </cfloop>
  
  <!--- redirect to file --->
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/downloads/#Variables.sCSVFile#">
  
<!--- SETUP FOR HTML DISPLAY --->
<!------------------------------>
<cfelseif sOutputType IS "html">
  
  <!--- get transaction log --->
  <cfquery username="#db_username#" password="#db_password#" name="getLog" datasource="#DATASOURCE#">
      SELECT date_posted, trans_id, itemnum, user_id, amount, remote_ip, description
        FROM transaction_log
       WHERE date_posted >= #Variables.tsStartStamp#
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
                          <td>
                            <font face="helvetica" size=2 color=000000>
                              Use this page to print reports and conduct statistical analysis of your <i>Auction Server</i>.<br>
                              If you do not know how to use this administration tool, please <!--- consult your user manual or<br> --->
                              click the help button in the<br>
							  upper right corner of this window.
                                          <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> 
                            </font>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <table border=0 cellspacing=0 cellpadding=0 width=100%>
                              <tr>
                                <td>&nbsp;<font face="helvetica" size=2 color=000080><b>TRANSACTIONS:</b></font></td>
                                <td align=right><font face="helvetica" size=2><b><cfoutput>#DateFormat(tsStartStamp, "mm/dd/yyyy")# - #DateFormat(TIMENOW, "mm/dd/yyyy")#</cfoutput></b></font>&nbsp;</td>
                              </tr>
                            </table>
                            
                            <!--- The main table with the dark blue border --->
                            <table width=100% border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                              <tr>
                                <td>
                                  <table width=100% border=0 cellspacing=0 cellpadding=3>
                                    <tr bgcolor=cbeef9>
                                      <td><font face="helvetica" size=1><b>Date</b></td>
                                      <td><font face="helvetica" size=1><b>Trans ID</b></td>
                                      <td><font face="helvetica" size=1><b>Description</b></td>
                                      <td><font face="helvetica" size=1><b>Item No.</b></td>
                                      <td><font face="helvetica" size=1><b>User ID</b></td>
                                      <td align=right><font face="helvetica" size=1><b>Amount <cfoutput>(#Variables.sSiteCurrency#)</cfoutput></b></td>
                                      <td align=right><font face="helvetica" size=1><b>Remote IP</b></td>
                                    </tr>
                                    
                                    <!--- loop over transactions --->
                                    <cfloop query="getLog">
                                      
                                      <cfset iHTMRowCount = iHTMRowCount + 1>
                                      
                                      <cfoutput>
                                        <tr <cfif Variables.iHTMRowCount GT 2>bgcolor=bac1cf</cfif>>
                                          <td><font face="helvetica" size=1><b>#DateFormat(getLog.date_posted, "mm/dd/yyyy")#</b></td>
                                          <td><font face="helvetica" size=1><b>#getLog.trans_id#</b></td>
                                          <td><font face="helvetica" size=1><b>#Mid(Trim(getLog.description), 1, Variables.iHTMDescSpan)#<cfif Len(Trim(getLog.description)) GT Variables.iHTMDescSpan>...</cfif></b></td>
                                          <td><font face="helvetica" size=1><b>#getLog.itemnum#</b></td>
                                          <td><font face="helvetica" size=1><b>#getLog.user_id#</b></td>
                                          <td align=right><font face="helvetica" size=1><b>#numberformat(getLog.amount,numbermask)#</b></td>
                                          <td align=right><font face="helvetica" size=1><b>#Trim(getLog.remote_ip)#</b></td>
                                        </tr>
                                      </cfoutput>
                                      
                                      <cfif Variables.iHTMRowCount GTE 4>
                                        <cfset iHTMRowCount = 0>
                                      </cfif>
                                    </cfloop>
                                    
                                    <!--- if no records --->
                                    <cfif not getLog.RecordCount>
                                      <tr>
                                        <td valign=top><font face="helvetica" size=1><b>-</b></td>
                                        <td valign=top><font face="helvetica" size=1><b>-</b></td>
                                        <td valign=top>
                                          <font face="helvetica" size=1>
                                            <b>No Records Available</b>
                                          </font>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                        </td>
                                        <td valign=top><font face="helvetica" size=1><b>-</b></td>
                                        <td valign=top><font face="helvetica" size=1><b>-</b></td>
                                        <td align=right valign=top><font face="helvetica" size=1><b>-</b></td>
                                        <td align=right valign=top><font face="helvetica" size=1><b>-</b></td>
                                      </tr>
                                    </cfif>
                                    
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
              </td>
            </tr>
          </table>
        </center>
      </font>
    </body>
  </html>
</cfif>
