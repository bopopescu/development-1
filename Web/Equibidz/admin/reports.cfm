

<cfsetting enablecfoutputonly="Yes">

<!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">
<!-- define TIMENOW -->
  <cfmodule template="../functions/timenow.cfm">
  
  <!--- Run a query to find membership status  --->
 <cfquery username="#db_username#" password="#db_password#" name="get_membership_status" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'membership_sta'
    ORDER BY pair
 </cfquery>
  
<!--- if submitting, RUN completed auctions --->
<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runCompletedAuctions")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.sCompletedOutputType>
  <cfset sSortOrder = Form.sCompletedSortOrder>
  <cfset iDays = Form.iCompletedDays>
    
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&days=#Variables.iDays#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Completed Auctions)"
    details="OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     DAYS: #Variables.iDays#">
  
  <!--- redirect to url --->

<!--- OLD CODE - All instances of "#site_address##VAROOT#" replaced.
<cflocation url="http://#site_address##VAROOT#/admin/completedAuctions.cfm#Variables.sUrlVars#">
--->

<cflocation url="completedAuctions.cfm#Variables.sUrlVars#">
</cfif>

<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runallAuctions")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.sallOutputType>
  <cfset sSortOrder = Form.sallSortOrder>
  <cfset iDays = Form.iallDays>
    
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&days=#Variables.iDays#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (All Auctions)"
    details="OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     DAYS: #Variables.iDays#">
  
  <!--- redirect to url --->
  <cflocation url="list_auctions/Auctions.cfm#Variables.sUrlVars#">
</cfif>







<!--- if submitting, RUN account history --->
<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runAccountHistory")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.sHistoryOutputType>
  <cfset sSortOrder = Form.sHistorySortOrder>
  <cfset iDays = Form.iHistoryDays>
  
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&days=#Variables.iDays#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Account History)"
    details="OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     DAYS: #Variables.iDays#">
  
  <!--- redirect to url --->
  <cflocation url="accountHistory.cfm#Variables.sUrlVars#">
</cfif>

<!--- if submitting, RUN transaction log --->
<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runTransLog")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.sTransLogOutputType>
  <cfset sSortOrder = Form.sTransLogSortOrder>
  <cfset iDays = Form.iTransLogDays>
  
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&days=#Variables.iDays#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Transaction Log)"
    details="OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     DAYS: #Variables.iDays#">
  
  <!--- redirect to url --->
  <cflocation url="transactionLog.cfm#Variables.sUrlVars#">
</cfif>





<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runvisitorsLog")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.svisitorsOutputType>
  <cfset sSortOrder = Form.svisitorsSortOrder>
  <cfset iDays = Form.ivisitorsDays>
  
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&days=#Variables.iDays#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Transaction Log)"
    details="OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     DAYS: #Variables.iDays#">
  
  <!--- redirect to url --->
  <cflocation url="tracking.cfm#Variables.sUrlVars#">
</cfif>



<!--- if submitting, RUN winning bidder --->
<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runUsers")>
  
  <!--- setup vars for url --->
  <cfset sUsersType = Form.sUsersType>
  <cfset sOutputType = Form.sUsersOutputType>
  <cfset sSortOrder = Form.sUsersSortOrder>
  
  <cfset sUrlVars = "?user_type=#sUsersType#&type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&fromdate=#sUsers_fromdate#&todate=#sUsers_todate#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Users Information)"
    details="FROM DATE: #sUsers_fromdate#    TO DATE: #sUsers_todate#    OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#">
  
  <!--- redirect to url --->
  <cflocation url="users_info.cfm#Variables.sUrlVars#">
</cfif>

<!--- if submitting, RUN winning bidder --->
<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runwinning_bidder")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.sBidderOutputType>
  <cfset sSortOrder = Form.sBidderSortOrder>
  <cfset bAddress = IIf(IsDefined("Form.sBidderAddress"), 1, 0)>
  <cfset bPhone = IIf(IsDefined("Form.sBidderPhone"), 1, 0)>
  <cfset bLocation = IIf(IsDefined("Form.sBidderLocation"), 1, 0)>
  <cfset bDate_end = IIf(IsDefined("Form.sBidderdate_end"), 1, 0)>
  
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&addr=#Variables.bAddress#&ph=#Variables.bPhone#&loc=#Variables.bLocation#&date_end=#Variables.bDate_end#&fromdate=#sBidder_fromdate#&todate=#sBidder_todate#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Winning Bidder)"
    details="FROM DATE: #sBidder_fromdate#    TO DATE: #sBidder_todate#    OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     MAILING ADDRESS: #Variables.bAddress#     PHONE NUMBERS: #Variables.bPhone#     LOCATION: #Variables.bLocation#     DATE_END: #Variables.bDate_end#">
  
  <!--- redirect to url --->
  <cflocation url="winning_bidders.cfm#Variables.sUrlVars#">
</cfif>

<!--- if submitting, RUN mailing list --->
<cfif HTTP_REFERER CONTAINS "/admin/reports.cfm"
  AND IsDefined("Form.runMailingList")>
  
  <!--- setup vars for url --->
  <cfset sOutputType = Form.sMailOutputType>
  <cfset sSortOrder = Form.sMailSortOrder>
  <cfset bNickname = IIf(IsDefined("Form.sMailNickname"), 1, 0)>
  <cfset bUserID = IIf(IsDefined("Form.sMailUserID"), 1, 0)>
  <cfset bDateReg = IIf(IsDefined("Form.sMailDateReg"), 1, 0)>
  <cfset bAddress = IIf(IsDefined("Form.sMailAddress"), 1, 0)>
  <cfset bPhone = IIf(IsDefined("Form.sMailPhone"), 1, 0)>
  <cfset bLanguage = IIf(IsDefined("Form.sMailLanguage"), 1, 0)>
  <cfset bSurvey = IIf(IsDefined("Form.sMailSurvey"), 1, 0)>
  <cfset bCompany = IIf(IsDefined("Form.sMailCompany"), 1, 0)>
  
  <cfset sUrlVars = "?type=#Variables.sOutputType#&sort=#Variables.sSortOrder#&nick=#Variables.bNickname#&id=#Variables.bUserID#&dreg=#Variables.bDateReg#&addr=#Variables.bAddress#&ph=#Variables.bPhone#&lang=#Variables.bLanguage#&sv=#Variables.bSurvey#&comp=#Variables.bCompany#">
  
  <!--- log running report --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Report Ran (Mailing List)"
    details="OUTPUT TYPE: #Variables.sOutputType#     SORT ORDER: #Variables.sSortOrder#     NICKNAME: #Variables.bNickname#     USER ID: #Variables.bUserID#     DATE REGISTERED: #Variables.bDateReg#     MAILING ADDRESS: #Variables.bAddress#     PHONE NUMBERS: #Variables.bPhone#     PREFERRED LANGUAGE: #Variables.bLanguage#     SURVEY INFO: #Variables.bSurvey#     COMPANY: #Variables.bCompany#">
  
  <!--- redirect to url --->
  <cflocation url="mailingList.cfm#Variables.sUrlVars#">
</cfif>

<cfif IsDefined ("Form.submit")> 
	<cfif Form.submit eq " SEND "> 
	<!-- get the users of the mailing list --->
		<cfif Form.sendmail eq "mailinglist">
			<cfquery username="#db_username#" password="#db_password#" name="GetList" datasource="#DATASOURCE#">
  			select email, name 
			FROM users
			WHERE mailing = 1
			AND is_active = 1
			AND confirmation = 1
			<cfif isDefined('form.other') and form.interested is not "">
			AND interested like '%#interested#%'
			</cfif>
			order by user_id
			</cfquery>
	 	<cfelse> 
			<cfquery username="#db_username#" password="#db_password#" name="GetList" datasource="#DATASOURCE#">
  			select email, name 
			FROM users
			WHERE is_active = 1
			AND confirmation = 1
			<cfif isDefined('form.other') and form.interested is not "">
			AND interested like '%#interested#%'
			</cfif>
			order by user_id
			</cfquery>
		</cfif>
		
		<cfif MessageBody neq "">
		<cfset scr_MessageBody = Rereplace(MessageBody,"##"," ","All")>
		<cfif #ParameterExists(aSalutation)# is "No">
			<cfmail query="GetList"
  		  		to="#email#"
		  		from="#Form.from#"
  		  		subject="#Form.Common_subject#">
				#scr_MessageBody#
				
				Time sent: #now()#
			</cfmail>
			<cfset sent_cnts = GetList.recordcount>
			
		<cfelse>	  
			 <cfmail query="GetList"
  		  		to="#email#"
		  		from="#Form.from#"
  		  		subject="#Form.Common_subject#">
				#Form.salutation# #name#,
				
				#scr_MessageBody#
				
				Time sent: #now()# 
			 </cfmail>  
			 <cfset sent_cnts = GetList.recordcount>
			 
		</cfif>
		</cfif>

		
	</cfif>
</cfif>
<!--- output page --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>Visual Auction Server Administrator [Reports Module]</title>
	<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
    
	<cfquery name="get_keywords" datasource="#DATASOURCE#" dbtype="ODBC">
	SELECT DISTINCT INTERESTED FROM users
	WHERE INTERESTED <> ''
	AND is_active = 1
	</cfquery>
	<script language = "javascript">
  function popup(){
    var popup = window.open("","picWin","height=400,width=370,top=110,left=407,scrollbars")
	popup.document.write('<title>Interested Keywords </title>')
    popup.document.write("<body bgcolor='#efefef'>")// onFocus='(window.close())'
	popup.document.write("<P><font face='Arial' size='2' color='blue'>This is a list of all of the keywords users have entered of the types of items they are interested in buying. Emails will only be sent to those who have keyword(s) matching the one you have entered.</font></P>")
    popup.document.write("<font face='Arial' size='2'> <cfoutput query="get_keywords">#interested#<br><br></cfoutput></font>")
  }
  
  	</script>  
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
          
          <form name="menuForm" action="reports.cfm" method="POST">
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
                            If you do not know how to use this administration tool, please <!---consult your user manual or --->
                            click the help button in the<br>
							upper right corner of this window.
                                        <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
                          </font>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          &nbsp;<font face="Helvetica" size=2 color=000080><b>REPORTS MENU:</b></font>
                          <!--- The main table with the dark blue border --->
                          <table width=80% border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                            <tr>
                              <td>
                                <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Completed Auctions</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays summary of completed auctions during the previous requested period.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
                                        <tr>
                                          <td align=left><font face="helvetica" size=2>Starting Date:</font></td>
                                          <td><input name="iCompletedDays" type=radio value="7" checked><font face="helvetica" size=2 >7 Days</font></td>
                                          <td><input name="iCompletedDays" type=radio value="30"><font face="helvetica" size=2 checked>30 Days</font></td>
                                          <td><input name="iCompletedDays" type=radio value="60"><font face="helvetica" size=2>60 Days</font></td>
                                          <td><input name="iCompletedDays" type=radio value="90"><font face="helvetica" size=2>90 Days</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runCompletedAuctions" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sCompletedSortOrder">
                                               <option value="categoryA">Category ASC</option>
                                               <option value="categoryD">Category DESC</option>
                                               <option value="dateA" >Date ASC</option>
                                               <option value="dateD" selected>Date DESC</option>
                                              <option value="nameA">Seller Name ASC</option>
                                               <option value="nameD">Seller Name DESC</option>

                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sCompletedOutputType">
                                               <option value="csv" >CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
                                <br>



                  <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>All Auctions</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays summary of all auctions during the previous requested period.<br> </font><font color=red size=1>&nbsp; You can delete or end auction early, as well as delete bids on each auction.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
                                        <tr>
                                          <td align=left><font face="helvetica" size=2>Starting Date:</font></td>
                                          <td><input name="iallDays" type=radio value="7" checked><font face="helvetica" size=2>7 Days</font></td>
                                          <td><input name="iallDays" type=radio value="30" ><font face="helvetica" size=2>30 Days</font></td>
                                          <td><input name="iallDays" type=radio value="60"><font face="helvetica" size=2>60 Days</font></td>
                                          <td><input name="iallDays" type=radio value="90"><font face="helvetica" size=2>90 Days</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runallAuctions" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sallSortOrder">
                                               <option value="categoryA">Category ASC</option>
                                               <option value="categoryD">Category DESC</option>
                                               <option value="dateA" >Date ASC</option>
                                               <option value="dateD" selected>Date DESC</option>
                
<!---                               <option value="nameA">Seller Name ASC</option>
                                               <option value="nameD">Seller Name DESC</option>
--->
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sallOutputType">
                                               <option value="csv" >CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
                                <br>
              
                                <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Customer Account History</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays a history of each member's account during the previous requested period.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
                                        <tr>
                                          <td align=left><font face="helvetica" size=2>Starting Date:</font></td>
                                          <td><input name="iHistoryDays" type=radio value="7"><font face="helvetica" size=2>7 Days</font></td>
                                          <td><input name="iHistoryDays" type=radio value="30" checked><font face="helvetica" size=2>30 Days</font></td>
                                          <td><input name="iHistoryDays" type=radio value="60"><font face="helvetica" size=2>60 Days</font></td>
                                          <td><input name="iHistoryDays" type=radio value="90"><font face="helvetica" size=2>90 Days</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runAccountHistory" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sHistorySortOrder">
                                               <option value="nameA" selected>Seller Name ASC</option>
                                               <option value="nameD">Seller Name DESC</option>
                                               <option value="nicknameA">Seller Nickname ASC</option>
                                               <option value="nicknameD">Seller Nickname DESC</option>
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sHistoryOutputType">
                                               <option value="csv">CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
                                <br>
                                <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Transactions</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays the site's transaction log from the previous requested period.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
                                        <tr>
                                          <td align=left><font face="helvetica" size=2>Starting Date:</font></td>
                                          <td><input name="iTransLogDays" type=radio value="7"><font face="helvetica" size=2>7 Days</font></td>
                                          <td><input name="iTransLogDays" type=radio value="30" checked><font face="helvetica" size=2>30 Days</font></td>
                                          <td><input name="iTransLogDays" type=radio value="60"><font face="helvetica" size=2>60 Days</font></td>
                                          <td><input name="iTransLogDays" type=radio value="90"><font face="helvetica" size=2>90 Days</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runTransLog" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sTransLogSortOrder">
                                               <option value="dateA" selected>Date ASC</option>
                                               <option value="dateD">Date DESC</option>
                                               <option value="descA">Description ASC</option>
                                               <option value="descD">Description DESC</option>
                                               <option value="itemA">Item Number ASC</option>
                                               <option value="itemD">Item Number DESC</option>
                                               <option value="useridA">User ID ASC</option>
                                               <option value="useridD">User ID DESC</option>
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sTransLogOutputType">
                                               <option value="csv">CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>










                                <br>
                                <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Visitors Tracking</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays the site's visitors tracking log from the previous requested period.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
                                        <tr>
                                          <td align=left><font face="helvetica" size=2>Starting Date:</font></td>
                                          <td><input name="ivisitorsDays" type=radio value="7"><font face="helvetica" size=2>7 Days</font></td>
                                          <td><input name="ivisitorsDays" type=radio value="30" checked><font face="helvetica" size=2>30 Days</font></td>
                                          <td><input name="ivisitorsDays" type=radio value="60"><font face="helvetica" size=2>60 Days</font></td>
                                          <td><input name="ivisitorsDays" type=radio value="90"><font face="helvetica" size=2>90 Days</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runvisitorsLog" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="svisitorsSortOrder">
                                               <option value="dateA" selected>Date ASC</option>
                                               <option value="dateD">Date DESC</option>
                                               <option value="browserA">Browser Type ASC</option>
                                               <option value="browserD">Browser Type DESC</option>
                                               <option value="remoteipA">Remote IP ASC</option>
                                               <option value="remoteipD">Remote IP DESC</option>
                                               <option value="refererA">Referer ASC</option>
                                               <option value="refererD">Referer DESC</option>
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="svisitorsOutputType">
                                               <option value="csv">CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
                


                                <br>
								
								
								
								<table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Winners</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays winner's nickname, name and email address by default.  
                                      All other fields are optional.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
									  <cfoutput>
									    <tr>
										  <td colspan="2"><font face="helvetica" size=2>From Date: </font><input type="Text" name="sBidder_fromdate" value="#dateformat(dateadd('d',-1,timenow),'mm/dd/yyyy')#"></td>
										  <td colspan="2"><font face="helvetica" size=2>To Date: </font><input type="Text" name="sBidder_todate" value="#dateformat(timenow,'mm/dd/yyyy')#"></td>
										</tr>
										</cfoutput>
                                        <tr>
										  <td><input name="sBidderAddress" type=checkbox><font face="helvetica" size=2>Mailing Address</font></td>
										  <td><input name="sBidderPhone" type=checkbox><font face="helvetica" size=2>Phone Numbers</font></td>
										  <td><input name="sBidderLocation" type=checkbox><font face="helvetica" size=2>Item Location</font></td>
                                          <td><input name="sBidderdate_end" type=checkbox><font face="helvetica" size=2>Item Date End</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runwinning_bidder" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sBidderSortOrder">
									           <option value="itemnumA" selected>itemnum ASC</option>
                                               <option value="itemnumD">itemnum DESC</option>
                                               <option value="titleA">title ASC</option>
                                               <option value="titleD">title DESC</option>
											   <option value="date_endA">date end ASC</option>
                                               <option value="date_endD">date end DESC</option>
                                               
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sBidderOutputType">
                                               <option value="csv" >CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
								<br>
								
								<table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>User Information</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays user's nickname, name, email and phone by default.<br>
									  Notice: All users <cfif get_membership_status.pair eq 1>or all members </cfif>report is not based on date.
                                      </font></td>
                                  </tr>
								  <tr>
								  <td colspan=3><table width=100% cellspacing=0 cellpadding=2><tr>
								    <td><input type="Radio" name="sUsersType" value="users" checked><font face="helvetica" size=2>All Users </font></td>
									<cfif get_membership_status.pair eq 1><td><input type="Radio" name="sUsersType" value="members"><font face="helvetica" size=2>All Members </font></td></cfif>
									<td><input type="Radio" name="sUsersType" value="sellers"><font face="helvetica" size=2>All Posters </font></td>
									<td><input type="Radio" name="sUsersType" value="bidders"><font face="helvetica" size=2>All Bidders </font></td>
									</tr></table></td>
								  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
									  <cfoutput>
									    <tr>
										  <td colspan="2"><font face="helvetica" size=2>From Date: </font><input type="Text" name="sUsers_fromdate" value="#dateformat(dateadd('d',-1,timenow),'mm/dd/yyyy')#"></td>
										  <td colspan="2"><font face="helvetica" size=2>To Date: </font><input type="Text" name="sUsers_todate" value="#dateformat(timenow,'mm/dd/yyyy')#"></td>
										</tr>
										</cfoutput>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runUsers" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sUsersSortOrder">
									           <option value="nicknameA" selected>Nickname ASC</option>
                                               <option value="nicknameD">Nickname DESC</option>
                                               <option value="nameA">Name ASC</option>
                                               <option value="nameD">Name DESC</option>
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sUsersOutputType">
                                               <option value="csv">CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
								<br>
								
                                <table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Mailing List</b></font></td>
                                  </tr>
                                </table>
                                <table width=100% border=0 cellspacing=0 cellpadding=2>
                                  <tr>
                                    <td colspan=3><font face="helvetica" size=2>
                                      Report displays user's name and email address by default.  
                                      All other fields are optional.</font></td>
                                  </tr>
                                  <tr>
                                    <td colspan=3>
                                      <table width=100% cellspacing=0 cellpadding=2>
                                        <tr>
                                          <td><input name="sMailNickname" type=checkbox><font face="helvetica" size=2>Nickname</font></td>
                                          <td><input name="sMailUserID" type=checkbox><font face="helvetica" size=2>User ID</font></td>
                                          <td><input name="sMailDateReg" type=checkbox><font face="helvetica" size=2>Date Registered</font></td>
                                          <td><input name="sMailAddress" type=checkbox><font face="helvetica" size=2>Mailing Address</font></td>
                                        </tr>
                                        <tr>
                                          <td><input name="sMailPhone" type=checkbox><font face="helvetica" size=2>Phone Numbers</font></td>
                                          <td><input name="sMailLanguage" type=checkbox><font face="helvetica" size=2>Language</font></td>
                                          <td><input name="sMailSurvey" type=checkbox><font face="helvetica" size=2>Survey Info</font></td>
                                          <td><input name="sMailCompany" type=checkbox><font face="helvetica" size=2>Company</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width=15%><input name="runMailingList" type=submit value=" RUN "></td>
                                    <td width=55% align=right><font face="helvetica" size=2>Sort By: <select name="sMailSortOrder">
                                               <option value="dateregA">Date Registered ASC</option>
                                               <option value="dateregD">Date Registered DESC</option>
                                               <option value="emailA">Email ASC</option>
                                               <option value="emailD">Email DESC</option>
                                               <option value="nameA" selected>Name ASC</option>
                                               <option value="nameD">Name DESC</option>
                                             </select></font></td>
                                    <td width=30% align=right><font face="helvetica" size=2>Output Type: <select name="sMailOutputType">
                                               <option value="csv" >CSV</option>
                                               <option value="html" selected>HTML</option>
                                             </select></font></td>
                                  </tr>
                                </table>
								<br>

								<table width=100% border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                                  <tr bgcolor=687997>
                                    <td colspan=4><font face="helvetica" size=2><b>Send Message To Users (<font face="helvetica" size=2 color="Red">no HTML</font>)</b></font></td>
                                  </tr>
                                </table>
								
								<table width=100% border=0 cellspacing=0 cellpadding=2>
								<tr><td width="80"><b>From:</b></td><td><input type="text" name="from" size=30 value="customer-service@<cfoutput>#domain#</cfoutput>"></td></tr>
								<tr><td width="80"><b>Subject:</b></td><td><input type="text" name="Common_subject" size=30></td></tr>
								<tr><td width="80"><b>Salutation:</b></td><td><input type="text" name="salutation" value="Dear" size=30>&nbsp;<input type=checkbox name="aSalutation"checked>Enabled</td><cfif isDefined("sent_cnts")><td align=right>&nbsp;Emails Sent:<cfoutput>#sent_cnts#</cfoutput></td></cfif></tr>
								</table>
								
								<textarea name="MessageBody" cols="85" rows="8" wrap="virtual"></textarea>
							   	<br><input name="sendmail" type=radio value="alllist" checked><font face="helvetica" size=2>All Users</font>
								<input name="sendmail" type=radio value="mailinglist"><font face="helvetica" size=2>Users from the Mailing List</font>
								<p><input name="submit" type="submit" value=" SEND "> 
								<input type="reset" value=" RESET "><br><b>Users with interests matching:</b><input type="text" name="interested" value="<cfif isDefined('interested')><cfoutput>#interested#</cfoutput></cfif>">&nbsp;&nbsp;&nbsp;<input type="checkbox" name="other" value="1"<cfif isDefined('form.other')> checked</cfif>> Enabled <a HREF="javascript:popup()"><font size=-1>Interested keywords</font></a>
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
         </form> 

        </table>

	 </center>
    </font>
  </body>
</html>

</html>
