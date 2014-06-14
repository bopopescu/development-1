<!---
/bulksell/index.cfm
intro page for bulk load page
07/10/00
--->

<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">

<cfinclude template="../../includes/session_include.cfm">

<cfif isdefined("url.from_list")>
	<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
		<cfoutput><cflocation url="index2.cfm?chck=1&auction_mode=0&category1=#category1#" addtoken="No"></cfoutput>
	</cfif>
</cfif>

<cfset error_message = "">
<!--- Check for valid login & password --->
<cfif isdefined("submit")>
	<cfquery username="#db_username#" password="#db_password#" name="check_login" datasource="#DATASOURCE#">
        SELECT user_id, is_active
          FROM users
         WHERE (nickname = '#login#'
         <cfif #isNumeric(login)#>
              OR user_id = #login#)
         <cfelse>
              )
         </cfif>
         AND password = '#password#'
         AND is_active = 1
  </cfquery>
<!--- If it's valid, store their info in cookie variables --->
    <cfif #check_login.recordcount# is 1>
			<cfcookie name="user_id" value="#check_login.user_id#" >
			<cfcookie name="password" value="#form.password#" >
      <cfset selected_user = check_login.user_id>
	  <cfset session.user_id = check_login.user_id>
    <cfelse>
      <cfset error_message = "Sorry, your login failed, please try again.">
    </cfif>
</cfif>
<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">
<html>
 <head>
  <title>Bulk Load Sell Item Page</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 




<body>  
  <!--- The main table --->
  <center>
   <table border=0 cellspacing=0 cellpadding=2 width=640>
	 <tr valign="top" >
    <tr>	
			<td colspan="3"><center><cfoutput><IMG SRC="#VAROOT#/images/logohere.gif"></cfoutput> &nbsp; &nbsp; &nbsp; <FONT SIZE=2><cfinclude template="../../includes/menu_bar.cfm"></FONT></center>
			</td>
		</tr>
    <tr><td colspan="3"><font size=4><b>Post Auction Page</b></font></td></tr>
    <tr><td colspan="3">         <hr size=1 color=#heading_color# width=100%></td></tr>
	 <cfif not isdefined('from_main') AND (isdefined("submit") eq 0 OR error_message neq "")>
	 <form action="index.cfm" method="post">
	 			<cfif #error_message# is not "">
				<tr valign="top" ><td colspan=3>
         <br><font face="Helvetica" size=2 color=ff0000><b>ERROR:</b><cfoutput> #error_message#</cfoutput><br></font></td></tr>
      </cfif>


 <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
 		<input name="login" type="hidden" value="#session.user_id#">
		<input name="password" type="hidden" value="#session.password#">
		<cflocation url="index2.cfm?chck=1&auction_mode=0" addtoken="No">
 	  <cfelse>

		<tr valign="top">
       <td width="150">
			 <font size=3 color="0000ff"><b>User ID or Nickname:</b></font></td>
       <td>&nbsp;</td>
       <td><input name="login" type="text" size=12 maxlength=20 value=""></td>
      </tr>
      <tr valign="top" >
			 
       <td><font size=3 color="0000ff"><b>Password:</b></font></td>
       <td>&nbsp;</td>
       <td><input name="password" type="password" size=12 maxlength=12 value=""></td>
      </tr>
      <tr valign="top" >
       <td colspan=3><input type="submit" name="submit" value="Login"></td>
      </tr> 
			</form>
</cfif>
	<cfelse>
	<!--- <cfcookie name="user_id" value="#session.user_id#" > --->
	<cflocation url="index2.cfm?chck=1&auction_mode=0" addtoken="No">
    <tr>
     <td colspan="3">
      <font size=3>
       The links below allow you to put multiple items up for online auction, setting 
			 selected fields as defaults. The default fields are only filled out once, using the 
			 "set defaults" page. After that, you can submit as many items as you want using 
			 the defaults you set.
      </font>
     	</td>
    </tr>
		<tr><td><br><br>         <hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td colspan="3">
      <a href="index2.cfm?auction_mode=0">Sell multiple items after setting defaults.</a>
     	</td>
    </tr>  
		<!--- <tr>
     <td colspan="3">
      <a href="index2.cfm?auction_mode=1">Buy multiple items after setting defaults.</a>
     	</td>
    </tr> --->
	</cfif>	
    <tr><td colspan="3"><br><br>         <hr size=1 color=#heading_color# width=100%></td></tr>
    <tr><td align="left" colspan="3"><font size=3><cfinclude template="../../includes/copyrights.cfm"></font></td></tr>
   
	
   </table>
 </body>
</html>
