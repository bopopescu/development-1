<cfinclude template="../includes/app_globals.cfm">

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
	<!--- <cfif #get_layout.useronline# eq 1> ---> 
	<cfif isdefined("session.nickname")>	    
		<cfquery username="#db_username#" password="#db_password#" name="check1" datasource="#DATASOURCE#">
		SELECT  nickname	          
		FROM loggedin	         
		WHERE nickname = '#session.nickname#'				    
		</cfquery>		
		<cfif #check1.recordcount#>
			<cfquery username="#db_username#" password="#db_password#" name="check1" datasource="#DATASOURCE#">	        
			update loggedin set loggedin = 1<!--- ,date_time =#timenow# --->	         
			WHERE nickname = '#session.nickname#'
			</cfquery>
		<cfelse>
			<cfquery username="#db_username#" password="#db_password#" name="insert" datasource="#DATASOURCE#">	        
			insert into loggedin(nickname,loggedin,date_time, remote_ip)values('#session.nickname#',1, #timenow#,'#CGI.REMOTE_ADDR#')
			</cfquery>
		</cfif>
	</cfif>
	<cfset interval = DateFormat(DateAdd("s", -5, TIMENOW), "mm/dd/yyyy") & " " & TimeFormat(DateAdd("n", -5, TIMENOW), "HH:mm:ss tt") >
	<cfquery username="#db_username#" password="#db_password#" name="getloggedin" datasource="#DATASOURCE#">	        	           
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
			<font color=#get_layout.text_color#>
				<b><i>
					<a href="#varoot#/messaging/index.cfm?user_id=#getloggedin.nickname#">#getloggedin.nickname#</a>
				</i></b>
			</font>
		<cfelse>
			No users online at this time.
		</cfif>
		<br />--->
	
		<font color=#get_layout.text_color#>
			<font color=#get_layout.text_color#>
				<a href="#VAROOT#/">HOME</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/listings/index.cfm?curr_cat=S&curr_lvl=0">AUCTIONS</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/advertise">ADVERTISE</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0">SEARCH</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/terms.cfm">TERMS</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/registration">REGISTRATION</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/contactus.cfm">CONTACT US</a>&nbsp;|&nbsp;
				<a href="#VAROOT#/help.cfm">HELP</a>&nbsp;|&nbsp;
				<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
					<a href="#VAROOT#/personal/my_auctions.cfm?my_No=11">MY AUCTION</a>&nbsp;|&nbsp;
					<a href="#VAROOT#/personal/my_accounts.cfm?my_No=11">MY ACCOUNT</a>
				</cfif>				
				<br />
				Copyright &copy; #Year(TIMENOW)# #get_layout.COMPANY_NAME#
				<i>All Rights Reserved.</i><br />
				Use of this Web site constitutes acceptance of the <a href="#VAROOT#/terms.cfm">User Agreement</a>.<br /><br />
				Horse Auction of #Year(TIMENOW)# <a href="http://www.TPfarms.com/">Best Horse Farm</a>
				<i>All Rights Reserved.</i><br />
			</font>
		</font>
	</font>
</center><br />
</cfoutput>

<cfquery name="get_ip" datasource="#datasource#">SELECT tracker FROM tracking WHERE tracker = '#cgi.remote_addr#'</cfquery>

<cfif #get_ip.recordcount# eq 0>
	<cfquery name=get_ip1 datasource="#datasource#">insert into tracking(tracker,webbrowser,referer,date_time) values('#CGI.REMOTE_ADDR#','#CGI.HTTP_USER_AGENT#','#CGI.HTTP_REFERER#',  #CreateODBCDateTime(timenow)#)</cfquery>
	<cfquery name=updatetempip datasource="#datasource#">select count(tracker) as blah from tracking</cfquery>
	<cfquery name="updateip" datasource="#datasource#">update stats set tracking= #updatetempip.blah# where id = 1</cfquery>
</cfif>
