<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/login.cfm $ $Revision: 2 $ $Date: 2/02/00 8:08p $ $Author: Davidh1 $ --->

<html>
 <head>
  <title>Equibidz Auction Server Administrator [Login Module]</title>
<style type="text/css">
/////////////////////////////////////////////////////////////////////////////////
#container h3 {clear:both; margin-top:4em;}
.raised {background: transparent; margin:0 auto;}
.raised h1, .raised p {margin:0 10px;}
.raised h1 {font-size:2em; color:#fff000; letter-spacing:1px;}
.raised p {padding-bottom:0.5em;}
.raised .top, .raised .bottom {display:block; background:transparent; font-size:1px;}
.raised .b1, .raised .b2, .raised .b3, .raised .b4, .raised .b1b, .raised .b2b, .raised .b3b, .raised .b4b {display:block; overflow:hidden;}
.raised .b1, .raised .b2, .raised .b3, .raised .b1b, .raised .b2b, .raised .b3b {height:1px;}
.raised .b2 {background:#081d40; border-left:1px solid #fff; border-right:1px solid #eee;}
.raised .b3 {background:#081d40; border-left:1px solid #fff; border-right:1px solid #ddd;}
.raised .b4 {background:#081d40; border-left:1px solid #fff; border-right:1px solid #aaa;}
.raised .b4b {background:#081d40; border-left:1px solid #eee; border-right:1px solid #999;}
.raised .b3b {background:#081d40; border-left:1px solid #ddd; border-right:1px solid #999;}
.raised .b2b {background:#081d40; border-left:1px solid #aaa; border-right:1px solid #999;}
.raised .b1 {margin:0 5px; background:#fff;}
.raised .b2, .raised .b2b {margin:0 3px; border-width:0 2px;}
.raised .b3, .raised .b3b {margin:0 2px;}
.raised .b4, .raised .b4b {height:2px; margin:0 1px;}
.raised .b1b {margin:0 5px; background:#999;}
.raised .boxcontent {display:block;  background:#081d40; border-left:1px solid #fff; border-right:1px solid #999;}
</style>
 </head>

<!--- Enable session tracking --->
<cfset #mins_until_timeout# = 20>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#" setDomainCookies="yes" 
setclientcookies="yes">

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
   <cfquery  username="#db_username#" password="#db_password#" name="check_password" datasource="#DATASOURCE#">
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
     <cflocation url="admin.cfm">
    </cfif>
  <cfelse>
 <cfset #login_failed# = "0">
    <cfset #session.username# = "">
    <cfset #session.password# = ""> 
    
    <!--- if URL variable "iamthe" exists & is = "creator" --->
 
    
    <cflocation url="admin.cfm">
   </cfif> 
   

  </cfif>  
 </cfif> 

 <body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999 onload="document.mainform.password.value='';document.mainform.username.value='';document.mainform.username.focus ();">
<center>
<br><br><br><br>
    <form name="mainform" action="login.cfm" method="post">

<div id="container" style="width:500px;height:400px;">
<div class="raised">
<b class="top"><b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b></b>
<div class="boxcontent">
 
 
    
      
<cfif lcase(cgi.server_name) EQ lcase(demo_domain)>
		 
		  <FONT COLOR=RED SIZE=4>
		  USERNAME: admin<BR>
		  PASSWORD: admin
		  </FONT>
		 
</cfif>
                
               <font face="helvetica" size=3 color=white><b>Equibidz.com Administrator Login</b><br><br></font>

               <!--- If login failed, let them know about it --->
               <cfif (#login_failed# is 1) or (#failed# is 1)>
                <font color=yellow size=2 face=arial>Login incorrect. Please try again.</font><br><br>
               <cfelseif #failed# is 2>
                <font color=yellow size=2 face=arial>Please enter your username and password.</font><br><br>
               <cfelse>
                <br><br>
               </cfif>
             
<table border=0>
<tr>
<td><font face="helvetica" size=2 color=white>Username:</font></td>
<td><input name="username" type="text" style="width:150px;"></td>
</tr>
<tr>
<td><font face="helvetica" size=2 color=white>Password:</font></td>
<td><input name="password" type="password" style="width:150px;"></td>
<tr>
<td colspan=2>               
<br><input type="submit" name="submit" value=" Login ">&nbsp;&nbsp;
<input type="reset" value=" Clear "><br><br>
</td>              
</tr>      
</table>

</div>
<b class="bottom"><b class="b4b"></b><b class="b3b"></b><b class="b2b"></b><b class="b1b"></b></b>
</div>
   </form>  

</center>  
 </body>
</html>
