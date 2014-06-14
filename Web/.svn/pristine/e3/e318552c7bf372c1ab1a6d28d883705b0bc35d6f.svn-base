<html>
 <head>
  <title>Auction Server 3.0 Administrator [Login Module]</title>
 </head>

<!--- Enable session tracking --->
<cfset #mins_until_timeout# = 20>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#" setclientcookies="yes">

 <!--- Store their username and password in their session --->
 <cfset #session.username# = "">
 <cfset #session.password# = "">

 <!--- Check for page submission --->
 <cfset #login_failed# = "0">
 <cfif #isDefined ("failed")# is 0>
  <cfset #failed# = "0">
 </cfif>
 <cfif #isDefined ("submit")# is 1>
  <cfif #trim (submit)# is "Login">

   <!--- Store their username and password in their session --->
   <cfset #session.username# = #username#>
   <cfset #session.password# = #password#>

   <!--- Check for correct username and password --->
   <cfquery name="check_password" datasource="#DATASOURCE#">
    SELECT name,
           sec_level
      FROM administrators
     WHERE login = '#session.username#'
       AND password = '#session.password#'
       AND is_active = 1
   </cfquery>

   <!--- If it failed, let them know about it --->
  <cfif #username# is not "" and #password# is not ""> 
    <cfif (#check_password.recordcount# is 0) or (#check_password.sec_level# LT 10)>
     <cfset #login_failed# = "1">
     <cflocation url="./login.cfm?failed=1">
    <cfelse>
     <cfset #login_failed# = "0">
     <cflocation url="ad_mngr.cfm">
    </cfif>
  <cfelse>
 <cfset #login_failed# = "0">
    <cfset #session.username# = "">
    <cfset #session.password# = ""> 
    
    <cflocation url="ad_mngr.cfm">
   </cfif> 
   

  </cfif>  
 </cfif> 

 <body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999 onload="document.mainform.password.value='';document.mainform.username.value='';document.mainform.username.focus ();">
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


     <tr>
      <td colspan=4 bgcolor=a9ccd7>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>
        <form name="mainform" action="login.cfm" method="post">
         <tr>
          <td>
            <table border=0 cellspacing=0 cellpadding=5 width=100%>
             <tr>
              <td>
               <table border=0 cellspacing=0 cellpadding=0 width=100%>
                <tr>
                 <td>
                  <font face="helvetica" size=2 color=000000>
                   Please enter your login information in the fields below
                   and click "Login" to continue.<br>  If you do not know your
                   login and password, contact your system administrator <br>or
                   check your <i>Auction Server</i> documentation for the default 
                   login and password.<br>
                  </font>
                 </td>
<cfif lcase(cgi.server_name) EQ "auction30.beyondsolutions.com">
		 <td>
		  <FONT COLOR=RED SIZE=4>
		  USERNAME: admin<BR>
		  PASSWORD: test
		  </FONT>
		 </td>
</cfif>
                </tr>
               </table>
   <hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade>
              </td>
             </tr>
            </table>
           <center> 
            <table border=0 cellspacing=0 cellpadding=3>
             <tr>
              <td colspan=4 align="center">
               <br><br>
               <font face="helvetica" size=3 color=000080><b>Administrator Login</b><br></font>

               <!--- If login failed, let them know about it --->
               <cfif (#login_failed# is 1) or (#failed# is 1)>
                <br><br><font color="red">Login <B>INCORRECT</b>; please try again.</font><br><br>
               <cfelseif #failed# is 2>
                <br><br><font color="red">You must log in before proceeding.</font><br><br>
               <cfelse>
                <br>
               </cfif>
              </td>
             </tr>
             <tr>
              <td><font face="helvetica" size=2>User name: </font></td>
              <td><input name="username" type="text" size=15 maxlength=15></td>
             </tr>
             <tr>
              <td><font face="helvetica" size=2>Password: </font></td>
              <td><input name="password" type="password" size=15 maxlength=15></td>
             </tr>
             <tr>
              <td>&nbsp;</td>
              <td>
               <input type="reset" value=" Clear ">&nbsp;&nbsp;
               <input type="submit" name="submit" value=" Login ">
              </td>
             </tr> 
            </table>
            <br><br><br><br><br><br>
           </center>
          </td>
         </tr>
        </form>
       </table>
      </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>
