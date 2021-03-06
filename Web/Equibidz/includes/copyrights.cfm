<!--- <cfinclude template="../includes/app_globals.cfm"> --->

<!---
<center>
    <InvalidTag language="JavaScript1.2" src="http://babelfish.altavista.com/static/scripts/translate_engl.js"></script>
    <br />
</center>
--->

<cfsilent>
    <cfif isdefined("company_name") is not true>
        <cfmodule template="../functions/timenow.cfm">
    </cfif>
    <!--- <cfif #getLayout.useronline# eq 1> --->
    <cfif isdefined("session.nickname")>
        <cfquery name="check1" datasource="#application.datasource#">
            SELECT  nickname
            FROM loggedin
            WHERE nickname = '#session.nickname#'
        </cfquery>
        <cfif #check1.recordcount#>
            <cfquery name="check1" datasource="#application.datasource#">
                update loggedin set loggedin = 1<!--- ,date_time =#timenow# --->
                WHERE nickname = '#session.nickname#'
            </cfquery>
        <cfelse>
            <cfquery name="insert" datasource="#application.datasource#">
            insert into loggedin(nickname,loggedin,date_time, remote_ip)values('#session.nickname#',1, #timenow#,'#CGI.REMOTE_ADDR#')
            </cfquery>
        </cfif>
    </cfif>
    <cfset interval = DateFormat(DateAdd("s", -5, TIMENOW), "mm/dd/yyyy") & " " & TimeFormat(DateAdd("n", -5, TIMENOW), "HH:mm:ss tt") >
    <cfquery name="getloggedin" datasource="#application.datasource#">
        select nickname from  loggedin
        WHERE loggedin =1 and nickname <> ''<!---AND date_time BETWEEN #CreateODBCDateTime(interval)# and #CreateODBCDateTime(TIMENOW)#--->
        ORDER BY nickname ASC
    </cfquery><!--- </cfif> --->
</cfsilent>

<cfoutput>
<br />
<center>
    <font size='1'>
        <!---
        <font color=red><b><cfif #getloggedin.recordcount#>#getloggedin.recordcount#</cfif></b></font>
        <font color= green size=3><b>user<cfif #getloggedin.recordcount# gt 1>s</cfif> online</b></font>:
        <cfif getloggedin.recordcount>
            <font color=#getLayout.text_color#>
                <b><i>
                    <a href="/messaging/index.cfm?user_id=#getloggedin.nickname#">#getloggedin.nickname#</a>
                </i></b>
            </font>
        <cfelse>
            No users online at this time.
        </cfif>
        <br />--->

        <font color="#getLayout.text_color#">
            <font color="#getLayout.text_color#">
                <a href="/">HOME</a>&nbsp;|&nbsp;
                <a href="/listings/index.cfm?curr_cat=S&curr_lvl=0">AUCTIONS</a>&nbsp;|&nbsp;
                <a href="/advertise">ADVERTISE</a>&nbsp;|&nbsp;
                <a href="/search/index.cfm?curr_cat=S&curr_lvl=0">SEARCH</a>&nbsp;|&nbsp;
                <a href="/terms.cfm">TERMS</a>&nbsp;|&nbsp;
                <a href="/registration">REGISTRATION</a>&nbsp;|&nbsp;
                <a href="/contactus.cfm">CONTACT US</a>&nbsp;|&nbsp;
                <a href="/help.cfm">HELP</a>&nbsp;|&nbsp;
                <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
                    <a href="/personal/my_auctions.cfm?my_No=11">MY AUCTION</a>&nbsp;|&nbsp;
                    <a href="/personal/my_accounts.cfm?my_No=11">MY ACCOUNT</a>
                </cfif>
                <br />
                Copyright &copy; #Year(TIMENOW)# #getLayout.COMPANY_NAME#
                <i>All Rights Reserved.</i><br />
                Use of this Web site constitutes acceptance of the <a href="/terms.cfm">User Agreement</a>.<br /><br />
                Horse Auction of #Year(TIMENOW)# <a href="http://www.TPfarms.com/">Best Horse Farm</a>
                <i>All Rights Reserved.</i><br />
            </font>
        </font>
    </font>
</center><br />
</cfoutput>

<!--- Record page tracking events if applicable --->
<cfinvoke component="/CF-INF/cfc/security/PageRequestManager" method="trackRequest">
    <cfinvokeargument name="remoteAddress" value="#cgi.remote_addr#">
</cfinvoke>
