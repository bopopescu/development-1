<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/mailingList.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<!---
  winning_bidders.cfm
  
  Winning bidder report output screen
  
  files used:
    /admin/validate_include.cfm
    /admin/menu_include.cfm
    /functions/cf_languages.cfm
  
  Author: Phillip Nguyen
  Date: 01/28/2003
  
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
<cfparam name="sort" default="nameA">
<cfset sOutputType = type>
<cfset sNewline = Chr(13)>

<cfset sSqlFields = "name, email, nickname, itemnum, title, quantity, bid">
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


<cfset sCSVFile = "winningbidders#rand()#.csv">
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "name, email, nickname, itemnum, title, quantity, bid, address1, address2, city, state, postal_code, country, phone1, phone2, fax, location, date_end">

<!--- def optional sql fields --->
<cfif IsDefined("nick")>
  <cfif nick>
    <cfset bEchoNick = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "nickname", ",")>
  </cfif>
</cfif>

<cfif IsDefined("name")>
  <cfif name>
    <cfset bEchoName = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "name", ",")>
  </cfif>
</cfif>

<cfif IsDefined("id")>
  <cfif id>
    <cfset bEchoID = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "user_id", ",")>
  </cfif>
</cfif>

<cfif IsDefined("Loc")>
  <cfif Loc>
    <cfset bEchoLocation = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "location", ",")>
  </cfif>
</cfif>

<cfif IsDefined("Date_end")>
  <cfif Date_end>
    <cfset bEchoDate_end = 1>
    <cfset sSqlFields = ListAppend(sSqlFields, "date_end", ",")>
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


<!--- def sql order by --->
<cfif sort IS "itemnumA">
  <cfset sSqlOrderBy = "ORDER BY I.itemnum ASC">
  
<cfelseif sort IS "itemnumD">
  <cfset sSqlOrderBy = "ORDER BY I.itemnum DESC">
  
<cfelseif sort IS "titleA">
  <cfset sSqlOrderBy = "ORDER BY title ASC">
  
<cfelseif sort IS "titleD">
  <cfset sSqlOrderBy = "ORDER BY title DESC">
  
<cfelseif sort IS "date_endA">
  <cfset sSqlOrderBy = "ORDER BY date_end ASC">
  
<cfelseif sort IS "date_endD">
  <cfset sSqlOrderBy = "ORDER BY date_end DESC">
  
<cfelse>
  <cfset sSqlOrderBy = Variables.sDefSqlOrderBy>
</cfif>

<!--- def if should echo extras --->
<cfif Variables.bEchoName
  OR Variables.bEchoAddress
  OR Variables.bEchoPhone
  OR Variables.bEchoLocation
  OR Variables.bEchoDate_end>
  
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
      SELECT name, email, nickname, I.itemnum, title, B.quantity, bid, address1, address2, city, state, postal_code, U.country, phone1, phone2, fax, location, date_end<!--- #sSqlFields# --->
        							FROM bids B, items I, users U
       								WHERE B.user_id = U.user_id
									AND B.itemnum = I.itemnum
									AND B.winner = 1
									<cfif fromdate neq "" and isdate(fromdate) and todate neq "" and isdate(todate)>
	<!---	 							AND B.time_placed >= #fromdate#
		 							AND B.time_placed <= #todate#
		
--->
AND I.date_end >= #fromdate#
         AND I.date_end <= #todate#
 							</cfif>
         							#Variables.sSqlOrderBy#
  </cfquery>
  
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
  <cfquery username="#db_username#" password="#db_password#" name="getSeller" datasource="#DATASOURCE#">
      SELECT DISTINCT U.user_id, U.nickname, U.name
        FROM bids B, items I, users U
       WHERE B.itemnum = I.itemnum
	     AND I.user_id = U.user_id
         AND B.winner = 1
		 <cfif isdefined("fromdate") and fromdate neq "" and isdate(todate) and isdefined("todate") and todate neq "" and isdate(todate)>
<!---		
 AND B.time_placed >= #fromdate#
		 AND B.time_placed <= #todate#
--->

AND I.date_end >= #fromdate#
         AND I.date_end <= #todate#
		 </cfif>
         ORDER BY U.nickname
  </cfquery>
  
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
                            &nbsp;<font face="Helvetica" size=2 color=000080><b>WINNER LIST:</b></font> <cfoutput>#dateformat(fromdate, 'mm/dd/yyyy')# - #dateformat(todate, 'mm/dd/yyyy')#</cfoutput>
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
								  <cfloop query="getSeller">
								  <tr bgcolor=cbeef9><td colspan="4"><font face="helvetica" color=000080><b><a href="users.cfm?submit=retrieve&selected_user=#user_id#" target="_blank">#Trim(nickname)#</a> (#name#)</b></font></td></tr>
								  	<!--- get accounts on mailing list --->
  									<cfquery username="#db_username#" password="#db_password#" name="getList" datasource="#DATASOURCE#">
      								SELECT B.id, B.itemnum, B.user_id, B.bid, B.quantity, B.buynow, I.title, I.location, I.date_end, I.auction_mode<!--- #sSqlFields# --->
        							FROM bids B, items I, users U
       								WHERE I.user_id = #user_id#
									AND I.user_id = U.user_id
									AND I.itemnum = B.itemnum
									AND B.winner = 1
									<cfif fromdate neq "" and isdate(fromdate) and todate neq "" and isdate(todate)>
		 							AND B.time_placed >= #fromdate#
		 							AND B.time_placed <= #todate#
		 							</cfif>
         							#Variables.sSqlOrderBy#
  									</cfquery>
								  
                                    <cfloop query="getList">
										<!--- get accounts on mailing list --->
  										<cfquery username="#db_username#" password="#db_password#" name="getbidder" datasource="#DATASOURCE#">
      									SELECT user_id, name, nickname, email, address1, address2, city, state, postal_code, country, phone1, phone2, fax
        								FROM users
       									WHERE user_id = #user_id#
  										</cfquery>
                                      
                                        <tr><td width=10%>&nbsp;</td><td colspan="3"><font face="helvetica" size=2><cfif buynow eq 1>Buyer<cfelse>Winner</cfif>: <b><a href="users.cfm?submit=retrieve&selected_user=#getbidder.user_id#" target="_blank">#Trim(getbidder.nickname)#</a></b> (#Trim(getbidder.name)#)</font></td></tr>
                                     	<tr><td colspan=2>&nbsp;</td><td colspan=2><table border=0 cellspacing=0 cellpadding=2 width=100%>
											<tr><td width=20%><font face="helvetica" size=2>Email:</font></td><td align="left" width=80%><font face="helvetica" size=2>&lt;<a href="mailto:#Trim(getbidder.name)# <#Trim(getbidder.email)#>">#Trim(getbidder.email)#</font></a>&gt;</td></tr>
											<tr> <td width=20% valign="top"><font face="helvetica" size=2>Item:</font></td> <td width=80%><font face="helvetica" size=2>#title# (<a href="#varoot#/listings/details/index.cfm?itemnum=#itemnum#" target="_blank">#itemnum#</a>)</font> <cfif auction_mode eq 1><img src="../images/R_reverse.gif" alt="Reverse Auction"></cfif></td></tr>
											<tr> <td width=20%><font face="helvetica" size=2>Qty:</font></td> <td width=80%><font face="helvetica" size=2>#quantity#</font></td></tr>
											<tr> <td width=20% valign="bottom"><font face="helvetica" size=2><cfif buynow eq 1>BuyNow Price<cfelse>Winning Bid</cfif>:</font></td> <td width=80%><font face="helvetica" size=2>#numberformat(bid,numbermask)#</font> <cfif buynow eq 1><img src="../images/buynow.gif" alt="BuyNow"></cfif></td></tr>
										</table></td></tr>
                                      <cfif Variables.bEchoExtras>
                                        <tr><td colspan=2>&nbsp;</td><td colspan=2><table border=0 cellspacing=0 cellpadding=2 width=100%>
											<cfif Variables.bEchoLocation>
                                              <tr><td width=20%><font face="helvetica" size=2>Item Location:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(location)#</font></td></tr>
                                            </cfif>
											<cfif Variables.bEchoDate_end>
                                              <tr><td width=20%><font face="helvetica" size=2>Date End:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(date_end)#</font></td></tr>
                                            </cfif>
                                            <!--- <cfif Variables.bEchoName>
                                              <tr><td width=20%><font face="helvetica" size=2>Nickname:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.nickname)#</font></td></tr>
                                            </cfif> --->
                                            <cfif Variables.bEchoAddress>
                                              <tr><td width=20%><font face="helvetica" size=2>Address:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.address1)#</font></td></tr>
                                              <cfif Len(Trim(getbidder.address2))><tr><td width=20%><font face="helvetica" size=2></font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.address2)#</font></td></tr></cfif>
                                              <tr><td width=20%><font face="helvetica" size=2></font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.city)#, #Trim(getbidder.state)#  #Trim(getbidder.postal_code)#</font></td></tr>
                                              <tr><td width=20%><font face="helvetica" size=2></font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.country)#</font></td></tr>
                                            </cfif>
                                            <cfif Variables.bEchoPhone>
                                              <cfif Len(Trim(getbidder.phone1))><tr></td> <td width=20%><font face="helvetica" size=2>Phone 1:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.phone1)#</font></td></tr></cfif>
                                              <cfif Len(Trim(getbidder.phone2))><tr></td> <td width=20%><font face="helvetica" size=2>Phone 2:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.phone2)#</font></td></tr></cfif>
                                              <cfif Len(Trim(getbidder.fax))><tr></td> <td width=20%><font face="helvetica" size=2>Fax:</font></td> <td width=80%><font face="helvetica" size=2>#Trim(getbidder.fax)#</font></td></tr></cfif>
                                            </cfif>
                                            
                                        </table></td></tr>
                                      </cfif>
									  <tr><td colspan="3">&nbsp;</td></tr>
                                    </cfloop>
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
