<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/transactionLog.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->
<cfsetting enablecfoutputonly="Yes">

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
<cfset sDefSqlOrderBy = "ORDER BY date_time ASC">

<cfset iHTMDescSpan = 30>
<cfset iHTMRowCount = 0>

<cfset sCSVFile = "tracking#rand()#.csv">
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "date_time, webbrowser, referer, tracker">
<cfset lCSVFlds = "date_time, webbrowser, referer, tracker">
<cfset sCSVHeader = '"Date","Browser Type","Referer","Remote IP"'>

<!--- def sql order by --->
<cfif sort IS "dateA">
  <cfset sSqlOrderBy = "ORDER BY date_time ASC">
  
<cfelseif sort IS "dateD">
  <cfset sSqlOrderBy = "ORDER BY date_time DESC">
  
<cfelseif sort IS "browserA">
  <cfset sSqlOrderBy = "ORDER BY webbrowser ASC">
  
<cfelseif sort IS "browserD">
  <cfset sSqlOrderBy = "ORDER BY webbrowser DESC">
  
<cfelseif sort IS "remoteipA">
  <cfset sSqlOrderBy = "ORDER BY tracker ASC">
  
<cfelseif sort IS "remoteipD">
  <cfset sSqlOrderBy = "ORDER BY tracker DESC">
  
<cfelseif sort IS "refererA">
  <cfset sSqlOrderBy = "ORDER BY referer ASC">
  
<cfelseif sort IS "refererD">
  <cfset sSqlOrderBy = "ORDER BY referer DESC">
  
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
      SELECT *
        FROM tracking
       WHERE date_time >= #Variables.tsStartStamp#
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
      SELECT *
        FROM tracking
       WHERE date_time >= #Variables.tsStartStamp#
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
                                <td>&nbsp;<font face="helvetica" size=2 color=000080><b>VISITORS TRACKING:</b></font></td>
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
                                      <td><font face="helvetica" size=1><b>Remote IP</b></td>
                                      <td><font face="helvetica" size=1><b>Browser TYpe</b></td>
                                      <td><font face="helvetica" size=1><b>Referer</b></td>
                           </tr>
                                    
                                    <!--- loop over transactions --->
                                    <cfloop query="getLog">
                                      
                                      <cfset iHTMRowCount = iHTMRowCount + 1>
                                      
                                      <cfoutput>
                                        <tr <cfif Variables.iHTMRowCount GT 2>bgcolor=bac1cf</cfif>>
                                          <td><font face="helvetica" size=1><b>#DateFormat(getLog.date_time, "mm/dd/yyyy")#</b></td>
                                          <td><font face="helvetica" size=1><b><a href="http://www.samspade.org/t/ipwhois?a=#getLog.tracker#" target=_blank>#getLog.tracker#</a></b></td>
                                          <td><font face="helvetica" size=1><b>#getLog.webbrowser#</b></td>
                                          <td><font face="helvetica" size=1><b><a href="#getLog.referer#" target=_blank>#getLog.referer#</a></b></td>
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
