<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/mailingList.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<!---
  users_info.cfm
  
  Users information report output screen
  
  files used:
    /admin/validate_include.cfm
    /admin/menu_include.cfm
    /functions/cf_languages.cfm
  
  Author: Phillip Nguyen
  Date: 03/28/2003
  
---><cfsetting enablecfoutputonly="Yes">

<!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">
<!--- chk coming from reports menu --->
<cfif CGI.HTTP_REFERER DOES NOT CONTAIN "/admin/reports.cfm">
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/reports.cfm">
</cfif>

<!--- def vals --->
<cfif isdefined("fromdate") and fromdate neq "" and isdate(todate) and isdefined("todate") and todate neq "" and isdate(todate)>
  	<cfset fromdate = ParseDateTime(fromdate)>
	<cfset todate = ParseDateTime(todate)>
	<cfset newtime = createtime(23,59,59)>
	<cfset todate = DateFormat(todate,'yyyy-mm-dd') & " " & TimeFormat(newtime,'HH:mm:ss')>
	<cfset todate = CreateODBCDateTime(todate)>
  </cfif>
<cfparam name="type" default="html">
<cfparam name="sort" default="nicknameA">
<cfset sOutputType = type>
<cfset sNewline = Chr(13)>

<cfset sSqlFields = "NICKNAME, NAME, EMAIL, PHONE1">
<cfset sSqlOrderBy = "">
<cfset sDefSqlOrderBy = "ORDER BY I.itemnum ASC">

<cfset bEchoExtras = 0>
<cfset bEchoNick = 0>
<cfset bEchoname = 0>
<cfset bEchoID = 0>
<cfset bEchoAddress = 0>
<cfset bEchoPhone = 0>
<cfset bEchoLocation = 0>
<cfset bEchoDate_end = 0>

<cfif user_type eq "sellers">
<cfset sCSVFile = "sellers_info#rand()#.csv">
<cfelseif user_type eq "bidders">
<cfset sCSVFile = "bidders_info#rand()#.csv">
<cfelseif user_type eq "members">
<cfset sCSVFile = "members_info#rand()#.csv">
<cfelse>
<cfset sCSVFile = "users_info#rand()#.csv">
</cfif>
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "nickname, name, email, phone1">






<!--- def sql order by --->
<cfif sort IS "nicknameA">
  <cfset sSqlOrderBy = "ORDER BY nickname ASC">
  
<cfelseif sort IS "nicknameD">
  <cfset sSqlOrderBy = "ORDER BY nickname DESC">
  
<cfelseif sort IS "nameA">
  <cfset sSqlOrderBy = "ORDER BY name ASC">
  
<cfelseif sort IS "nameD">
  <cfset sSqlOrderBy = "ORDER BY name DESC">
  
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
  
  <!--- get accounts on mailing list --->
  <cfif user_type eq "sellers">
  	<cfquery username="#db_username#" password="#db_password#" name="getList" datasource="#DATASOURCE#">
      SELECT DISTINCT U.user_id, U.nickname, U.name, U.email, U.phone1
        FROM items I, users U
       WHERE I.user_id = U.user_id
         AND U.is_active = 1
         AND U.confirmation = 1
		 <cfif isdefined("fromdate") and fromdate neq "" and isdate(todate) and isdefined("todate") and todate neq "" and isdate(todate)>
		 AND I.date_start >= #fromdate#
		 AND I.date_start <= #todate#
		 </cfif>
         #Variables.sSqlOrderBy#
  	</cfquery>
  <cfelseif user_type eq "bidders">
  	<cfquery username="#db_username#" password="#db_password#" name="getList" datasource="#DATASOURCE#">
      SELECT DISTINCT U.user_id, U.nickname, U.name, U.email, U.phone1
        FROM bids B, users U
       WHERE B.user_id = U.user_id
         AND U.is_active = 1
         AND U.confirmation = 1
		 <cfif isdefined("fromdate") and fromdate neq "" and isdate(todate) and isdefined("todate") and todate neq "" and isdate(todate)>
		 AND B.time_placed >= #fromdate#
		 AND B.time_placed <= #todate#
		 </cfif>
         #Variables.sSqlOrderBy#
  	</cfquery>
  <cfelse>
  	<cfquery username="#db_username#" password="#db_password#" name="getList" datasource="#DATASOURCE#">
      SELECT user_id, nickname, name, email, phone1
        FROM users
       WHERE is_active = 1
         AND confirmation = 1
		 <cfif user_type eq "members">
		 AND membership_status = 1
		 AND membership_exp > #timenow#
		 </cfif>
         #Variables.sSqlOrderBy#
  	</cfquery>
  </cfif>
  
  <!--- <cfoutput>#getList.recordcount# <cfabort></cfoutput> --->
    <cfset sCSVContent = sSQLFields & Variables.sNewline>
  <!--- loop on list --->
  <cfloop query="getList">
    
    <!--- def vals --->
	<cfset sTmpContent = "">
    
    <!--- setup info --->
    <cfloop index="e" list="#Variables.sSQLFields#">
      
      <cfif ListContainsNoCase(Variables.lCSVStringFlds, Trim(e), ",")>
        <cfset sTemp = """" & Replace(Evaluate(Trim(e)), """", """""", "ALL") & """">
      <cfelse>
        <cfset sTemp = Evaluate(Trim(e))>
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
  
  <!--- get accounts on mailing list --->
  <cfif user_type eq "sellers">
  	<cfquery username="#db_username#" password="#db_password#" name="getUsers" datasource="#DATASOURCE#">
      SELECT DISTINCT U.user_id, U.nickname, U.name, U.email, U.phone1
        FROM items I, users U
       WHERE I.user_id = U.user_id
         AND U.is_active = 1
         AND U.confirmation = 1
		 <cfif isdefined("fromdate") and fromdate neq "" and isdate(todate) and isdefined("todate") and todate neq "" and isdate(todate)>
		 AND I.date_start >= #fromdate#
		 AND I.date_start <= #todate#
		 </cfif>
         #Variables.sSqlOrderBy#
  	</cfquery>
  <cfelseif user_type eq "bidders">
  	<cfquery username="#db_username#" password="#db_password#" name="getUsers" datasource="#DATASOURCE#">
      SELECT DISTINCT U.user_id, U.nickname, U.name, U.email, U.phone1
        FROM bids B, users U
       WHERE B.user_id = U.user_id
         AND U.is_active = 1
         AND U.confirmation = 1
		 <cfif isdefined("fromdate") and fromdate neq "" and isdate(todate) and isdefined("todate") and todate neq "" and isdate(todate)>
		 AND B.time_placed >= #fromdate#
		 AND B.time_placed <= #todate#
		 </cfif>
         #Variables.sSqlOrderBy#
  	</cfquery>
  <cfelse>
  	<cfquery username="#db_username#" password="#db_password#" name="getUsers" datasource="#DATASOURCE#">
      SELECT user_id, nickname, name, email, phone1
        FROM users
       WHERE is_active = 1
         AND confirmation = 1
		 <cfif user_type eq "members">
		 AND membership_status = 1
		 AND membership_exp > #timenow#
		 </cfif>
         #Variables.sSqlOrderBy#
  	</cfquery>
  </cfif>
  
  <!--- output page --->
  <cfsetting enablecfoutputonly="No">
  
  <html>
    <head>
      <title>Visual Auction Server Administrator [Reports Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
      
    </head>
    
    <body bgcolor=465775 link=blue alink=ffaa00 vlink=999999>
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
                            &nbsp;<font face="Helvetica" size=2 color=000080><b>ALL <cfif user_type eq "sellers">POSTERS<cfelseif user_type eq "bidders">BIDDERS<cfelseif user_type eq "members">MEMBERS<cfelse>USERS</cfif> LIST:</b></font> <cfif user_type eq "sellers" or user_type eq "bidders"><cfoutput>#dateformat(fromdate, 'mm/dd/yyyy')# - #dateformat(todate, 'mm/dd/yyyy')#</cfoutput></cfif>
                            <!--- The main table with the dark blue border --->
                            <table width=100% border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                              <tr>
                                <td>
                                  
                                  <!--- <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                    <tr>
                                      <td colspan=2><font face="helvetica" size=2><b>Seller</b></td>
									  <td colspan=2><font face="helvetica" size=2><b>Winner Info.</b></td>
                                    </tr>
                                  </table> --->
                                  <cfoutput>
                                  <table width=100% border=0 cellspacing=0 cellpadding=2>
								  <tr><td><font face="Helvetica" size=2 color=000080><b>Nickname</b></font></td><td><font face="Helvetica" size=2 color=000080><b>Name</b></font></td><td><font face="Helvetica" size=2 color=000080><b>Email</b></font></td><td><font face="Helvetica" size=2 color=000080><b>Phone</b></font></td></tr>
								  <cfloop query="getUsers">
								  <tr bgcolor=cbeef9><td><font face="helvetica" color=000080><a href="users.cfm?submit=retrieve&selected_user=#user_id#" target="_blank">#Trim(nickname)#</a></font></td><td><font face="Helvetica" size=2>#name#</font></td><td><font face="Helvetica" size=2><a href="mailto:#email#">#email#</a></font></td><td><font face="Helvetica" size=2>#phone1#</font></td></tr>
									</cfloop>
                                  </table>
								  </cfoutput>
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
