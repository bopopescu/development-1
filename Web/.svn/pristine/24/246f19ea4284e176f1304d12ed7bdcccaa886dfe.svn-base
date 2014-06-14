<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/mailingList.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<!---
  mailingList.cfm
  
  mailing list report output screen
  
  files used:
    /admin/validate_include.cfm
    /admin/menu_include.cfm
    /functions/cf_languages.cfm
  
  Author: John Adams
  Date: 07/27/1999
  
---><cfsetting enablecfoutputonly="Yes">

<!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">

<!--- chk coming from reports menu --->
<cfif CGI.HTTP_REFERER DOES NOT CONTAIN "/admin/reports.cfm">
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/reports.cfm">
</cfif>

<!--- def vals --->
<cfparam name="type" default="html">
<cfparam name="sort" default="nameA">
<cfset sOutputType = type>
<cfset sNewline = Chr(13) & Chr(10)>

<cfset sSqlFields = "name, email">
<cfset sSqlOrderBy = "">
<cfset sDefSqlOrderBy = "ORDER BY name ASC">

<cfset bEchoExtras = 0>
<cfset bEchoNick = 0>
<cfset bEchoID = 0>
<cfset bEchoDateReg = 0>
<cfset bEchoAddress = 0>
<cfset bEchoPhone = 0>
<cfset bEchoLang = 0>
<cfset bEchoSurvey = 0>
<cfset bEchoCompany = 0>

<cfset sCSVFile = "mailinglist#rand()#.csv">
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "name, email, nickname, date_registered, company, address1, address2, city, state, postal_code, country, phone1, phone2, fax, language, heard_from, promotion_code, friends_email, use_for, interested, age, education, income, gender">

<!--- def optional sql fields --->
<cfif IsDefined("nick")>
  <cfif nick>
    <cfset bEchoNick = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "nickname", ",")>
  </cfif>
</cfif>

<cfif IsDefined("id")>
  <cfif id>
    <cfset bEchoID = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "user_id", ",")>
  </cfif>
</cfif>

<cfif IsDefined("dreg")>
  <cfif dreg>
    <cfset bEchoDateReg = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "date_registered", ",")>
  </cfif>
</cfif>

<cfif IsDefined("comp")>
  <cfif comp>
    <cfset bEchoCompany = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "company", ",")>
  </cfif>
</cfif>

<cfif IsDefined("addr")>
  <cfif addr>
    <cfset bEchoAddress = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "address1", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "address2", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "city", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "state", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "postal_code", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "country", ",")>
  </cfif>
</cfif>

<cfif IsDefined("ph")>
  <cfif ph>
    <cfset bEchoPhone = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "phone1", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "phone2", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "fax", ",")>
  </cfif>
</cfif>

<cfif IsDefined("lang")>
  <cfif lang>
    <cfset bEchoLang = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "language", ",")>
  </cfif>
</cfif>

<cfif IsDefined("sv")>
  <cfif sv>
    <cfset bEchoSurvey = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "heard_from", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "promotion_code", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "friends_email", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "use_for", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "interested", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "age", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "education", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "income", ",")>
    <cfset sSqlFields = ListAppend(sSqlFields, "gender", ",")>
  </cfif>
</cfif>

<!--- def sql order by --->
<cfif sort IS "nameA">
  <cfset sSqlOrderBy = "ORDER BY name ASC">
  
<cfelseif sort IS "nameD">
  <cfset sSqlOrderBy = "ORDER BY name DESC">
  
<cfelseif sort IS "emailA">
  <cfset sSqlOrderBy = "ORDER BY email ASC">
  
<cfelseif sort IS "emailD">
  <cfset sSqlOrderBy = "ORDER BY email DESC">
  
<cfelseif sort IS "dateregA">
  <cfset sSqlOrderBy = "ORDER BY date_registered ASC, user_id ASC">
  
<cfelseif sort IS "dateregD">
  <cfset sSqlOrderBy = "ORDER BY date_registered DESC, user_id DESC">
  
<cfelse>
  <cfset sSqlOrderBy = Variables.sDefSqlOrderBy>
</cfif>

<!--- def if should echo extras --->
<cfif Variables.bEchoNick
  OR Variables.bEchoID
  OR Variables.bEchoDateReg
  OR Variables.bEchoAddress
  OR Variables.bEchoPhone
  OR Variables.bEchoLang
  OR Variables.bEchoSurvey
  OR Variables.bEchoCompany>
  
  <cfset bEchoExtras = 1>
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
  
  <!--- get accounts on mailing list --->
  <cfquery username="#db_username#" password="#db_password#" name="getList" datasource="#DATASOURCE#">
      SELECT #sSqlFields#
        FROM users
       WHERE is_active = 1
         AND last_login_date <> #CreateODBCDateTime("12/31/1969")#
         AND mailing = 1
         #Variables.sSqlOrderBy#
  </cfquery>
  
  <!--- loop on list --->
  <cfloop query="getList">
    
    <!--- def vals --->
    <cfset sTmpContent = "">
    
    <!--- setup info --->
    <cfloop index="e" list="#Variables.sSQLFields#">
      
      <cfif ListContainsNoCase(Variables.lCSVStringFlds, Trim(e), ",")>
        <cfset sTemp = """" & Replace(Evaluate("getList." & Trim(e)), """", """""", "ALL") & """">
      <cfelse>
        <cfset sTemp = Evaluate("getList." & Trim(e))>
      </cfif>
      
      <cfset sTmpContent = ListAppend(sTmpContent, sTemp, ",")>
    </cfloop>
    
    <!--- add new line to content w/o newline --->
    <cfif getList.CurrentRow MOD Variables.iCSVRecsPerWrite EQ 0
      OR getList.CurrentRow IS getList.RecordCount>
      
      <cfset sCSVContent = sCSVContent & sTmpContent>
    
    <!--- add new line to content w/ newline --->
    <cfelse>
      <cfset sCSVContent = sCSVContent & sTmpContent & Variables.sNewline>
    </cfif>
    
    <!--- write/append to file --->
    <cfif getList.CurrentRow MOD Variables.iCSVRecsPerWrite EQ 0
      OR getList.CurrentRow IS getList.RecordCount>
      
      <!--- def action --->
      <cfif getList.CurrentRow IS Variables.iCSVRecsPerWrite>
        <cfset sAction = "Write">
        
      <cfelseif getList.RecordCount LT Variables.iCSVRecsPerWrite>
        <cfset sAction = "Write">
        
      <cfelse>
        <cfset sAction = "Append">
      </cfif>
      
      <cffile action="#Variables.sAction#"
        file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
        output="#Variables.sCSVContent#">
        
      <cfset sCSVContent = "">
    </cfif>
  </cfloop>
  
  <!--- if no records --->
  <cfif not getList.RecordCount>
    
    <cfset sCSVContent = " ">
    
    <cffile action="Write"
      file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
      output="#Variables.sCSVContent#">
  </cfif>
  
  <!--- redirect to file --->
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/downloads/#Variables.sCSVFile#">
  
<!--- SETUP FOR HTML DISPLAY --->
<!------------------------------>
<cfelseif sOutputType IS "html">
  
  <!--- cnt of active accounts --->
  <cfquery username="#db_username#" password="#db_password#" name="cntActiveAccounts" datasource="#DATASOURCE#">
      SELECT COUNT(user_id) AS found
        FROM users
       WHERE is_active = 1
         AND last_login_date <> #CreateODBCDateTime("12/31/1969")#
  </cfquery>
  
  <!--- cnt active accounts on mailing list --->
  <cfquery username="#db_username#" password="#db_password#" name="cntActiveMailing" datasource="#DATASOURCE#">
      SELECT COUNT(user_id) AS found
        FROM users
       WHERE is_active = 1
         AND last_login_date <> #CreateODBCDateTime("12/31/1969")#
         AND mailing = 1
  </cfquery>
  
  <!--- get accounts on mailing list --->
  <cfquery username="#db_username#" password="#db_password#" name="getList" datasource="#DATASOURCE#">
      SELECT #sSqlFields#
        FROM users
       WHERE is_active = 1
         AND last_login_date <> #CreateODBCDateTime("12/31/1969")#
         AND mailing = 1
         #Variables.sSqlOrderBy#
  </cfquery>
  
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
                            &nbsp;<font face="Helvetica" size=2 color=000080><b>MAILING LIST:</b></font>
                            <!--- The main table with the dark blue border --->
                            <table width=80% border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                              <tr>
                                <td>
                                  <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                    <tr bgcolor=cbeef9>
                                      <td colspan=4><font face="helvetica" size=2><b>Statistics</b></td>
                                    </tr>
                                  </table>
                                  <cfoutput>
                                  <table width=100% border=0 cellspacing=0 cellpadding=2>
                                    <tr>
                                      <td width=50%><font face="helvetica" size=2>Active Accounts: #NumberFormat(cntActiveAccounts.found,numbermask)#</font></td>
                                      <td width=50%><font face="helvetica" size=2>Accounts on List: #NumberFormat(cntActiveMailing.found,numbermask)#</font></td>
                                    </tr>
                                  </table>
                                  </cfoutput>
                                  <br>
                                  
                                  <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                    <tr bgcolor=cbeef9>
                                      <td colspan=4><font face="helvetica" size=2><b>List</b></td>
                                    </tr>
                                  </table>
                                  
                                  <table width=100% border=0 cellspacing=0 cellpadding=2>
                                    <cfloop query="getList">
                                      <cfoutput>
                                        <tr><td><font face="helvetica" size=2>#Trim(getList.name)#</font></td> <td><font face="helvetica" size=2>&lt;<a href="mailto:#Trim(getList.name)# <#Trim(getList.email)#>"><font color="000080">#Trim(getList.email)#</font></a>&gt;</font></td></tr>
                                      </cfoutput>
                                      <cfif Variables.bEchoExtras>
                                        <tr><td colspan=2><table border=0 cellspacing=0 cellpadding=2 width=100%>
                                            <cfif Variables.bEchoNick>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Nickname:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.nickname)#</font></td></tr></cfoutput>
                                            </cfif>
                                            <cfif Variables.bEchoID>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>User ID:</font></td> <td width=65%><font face="helvetica" size=2>#getList.user_id#</font></td></tr></cfoutput>
                                            </cfif>
                                            <cfif Variables.bEchoDateReg>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Date Registered:</font></td> <td width=65%><font face="helvetica" size=2>#DateFormat(getList.date_registered, "mm/dd/yyyy")# #TimeFormat(getList.date_registered, "HH:mm:ss")#</font></td></tr></cfoutput>
                                            </cfif>
                                            <cfif Variables.bEchoCompany>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Company:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.company)#</font></td></tr></cfoutput>
                                            </cfif>
                                            <cfif Variables.bEchoAddress>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Address:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.address1)#</font></td></tr></cfoutput>
                                              <cfif Len(Trim(getList.address2))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2></font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.address2)#</font></td></tr></cfoutput></cfif>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2></font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.city)#, #Trim(getList.state)#  #Trim(getList.postal_code)#</font></td></tr></cfoutput>
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2></font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.country)#</font></td></tr></cfoutput>
                                            </cfif>
                                            <cfif Variables.bEchoPhone>
                                              <cfif Len(Trim(getList.phone1))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Phone 1:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.phone1)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.phone2))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Phone 2:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.phone2)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.fax))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Fax:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.fax)#</font></td></tr></cfoutput></cfif>
                                            </cfif>
                                            <cfif Variables.bEchoLang>
                                              
                                              <!--- translate lang --->
                                              <cfmodule template="../functions/cf_languages.cfm"
                                                OPTION="CONVERT"
                                                CODE="#Trim(getList.language)#"
                                                RETURN="sLangName">
                                              
                                              <cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Preferred Language:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.language)# (#sLangName#)</font></td></tr></cfoutput>
                                            </cfif>
                                            <cfif Variables.bEchoSurvey>
                                              <cfif Len(Trim(getList.heard_from))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Heard From:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.heard_from)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.promotion_code))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Promo Code:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.promotion_code)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.friends_email))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Friends Email:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.friends_email)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.use_for))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Use For:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.use_for)#<cfif getList.use_for IS "P"> (Personal)<cfelseif getList.use_for IS "B"> (Business)<cfelseif getList.use_for IS "A"> (Personal & Business)</cfif></font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.interested))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Interested In:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.interested)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.age))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Age:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.age)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.education))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Education:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.education)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.income))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Income:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.income)#</font></td></tr></cfoutput></cfif>
                                              <cfif Len(Trim(getList.gender))><cfoutput><tr><td width=10%></td> <td width=25%><font face="helvetica" size=2>Gender:</font></td> <td width=65%><font face="helvetica" size=2>#Trim(getList.gender)#<cfif getList.gender IS "M"> (Male)<cfelseif getList.gender IS "F"> (Female)<cfelseif getList.gender IS "N"> (Not Disclosed)</cfif></font></td></tr></cfoutput></cfif>
                                            </cfif>
                                        </table></td></tr>
                                      </cfif>
                                    </cfloop>
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
