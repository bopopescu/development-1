<cfsilent>
<cfset current_page="indexhome">

 <!--- include globals --->
 <cfinclude template="includes/app_globals.cfm">
  
 

 <!--- define TIMENOW --->
 <cfmodule template="functions/timenow.cfm">
 
 <!--- logout arase login's session variable, Phillip Nguyen 3-16-01--->


<cfparam name="prev_http_referer" default ="">
 <cfif isdefined("logout")>

<cfif #get_layout.useronline# eq 1>
<cfquery name="clear" datasource="#datasource#">

update loggedin set loggedin = 0 where nickname= (select nickname from users where user_id=#session.user_id#)
</cfquery>
</cfif>
 	<cfset session.nickname = "">
	<cfset session.password = "">
	<cfset session.user_id = "">
	<cfset structdelete(session, "nickname")>
	<cfset structdelete(session, "password")>
	<!---<cfset structdelete(session, "user_id")>
	<cflocation url="#http_referer#" addtoken="No"> --->
<!--- OLD: <cflocation url="http://#SITE_ADDRESS##VAROOT#/" addtoken="No"> --->
	<cflocation url="index.cfm" addtoken="No">
	
	
 <cfelseif isdefined("login")>
 <cfif isDefined('path')>
     <cfset prev_http_referer = path>
 <cfelseif isDefined('http_referer')>
 	<cfset prev_http_referer = http_referer>
 <cfelse>
	<cfset prev_http_referer = "http://#SITE_ADDRESS##VAROOT#/">
	</cfif>
 </cfif>
 
 
<cfif isdefined("submit")>
<cfparam name = "nickname" default = "">
<cfparam name = "password" default = "">
<cfparam name="loggedin" default = 0>

<cfparam name="action" default="">

<!--- coming from login form? --->
	<cfif IsDefined("user_id")>
	    <cfquery username="#db_username#" password="#db_password#" name="validate" datasource="#DATASOURCE#">
	        SELECT user_id, nickname
	          FROM users
	         WHERE nickname = '#user_id#'
	     <cfif isNumeric(user_id) is 1>
	        OR user_id = #user_id#
	     </cfif>
	         AND password = '#password#'
	         AND is_active = 1
                 and confirmation=1
			
	    </cfquery>
		

	    <!--- If it's valid, store in  variables --->
	    <cfif validate.recordcount GT 0>
	        <cfset loggedin = 1>
			<cfset session.nickname = #validate.nickname#>
			<cfset session.password = #password#>
			<cfset session.user_id = #validate.user_id#>
			<cflocation url="index.cfm" addtoken="No">
			<!--- <cflocation url="#prev_http_referer#" addtoken="No"> --->
			<!--- <cflocation url="personal/main_page.cfm" addtoken="No"> --->
		<cfelse> 				
	      <cfset loggedin = 0>
		
		  <cfset failed = 1>
		</cfif>
	</cfif>

	
<!--- </cfif> --->

		
		
	
</cfif>
 
 

 <!--- Get the listing background color 
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>
--->
</cfsilent>
<cfoutput>
<html>
 <head>
  <title>Login</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="includes/bodytag.html">
 <cfinclude template="includes/menu_bar.cfm">



  <!--- The main table --->
<div align="center">
<table border=0 cellspacing=0 cellpadding=0 width=800>
    
    <tr>
     <td>
      <font size=3>
       <!--- This section of our site allows you to change and update your personal information,
       as well as view statistics such as your bidding history, feedback you've left, and
       items you've auctioned. --->
       <br><br>
       <cfif #isDefined ("failed")# is 1>
        <font color="ff0000"><b>Login failed.  Please try again.</font>
       <cfelse>
        Before proceeding, you must log in. To Post a Horse, Buy a Horse or Advertise you must have a registered account. If you need an Account go to Registration now. <br><br>
       </cfif>
       <form name="loginform" action="login.cfm" method="post">
	   <cfif isdefined("prev_http_referer") and prev_http_referer is not "">
	   	<input type="Hidden" name="prev_http_referer" value="#prev_http_referer#">
	   </cfif>
        <table border=0 cellspacing=0 cellpadding=4>
         <tr><td><b>User ID:</b></td><td><input type="text" name="user_id" value="" size=15 maxlength=20></td><td></td></tr>
         <tr><td><b>Password:</b></td><td><input type="password" name="password" value="" size=15 maxlength=12></td></tr>
                
        
        </table>
        
		   <a href="registration/findpassword.cfm"><font size="2">Forgotten your password?</font></a>
			<br><br>
        <input type="submit" name="submit" value="Log In" width="75" class="buttons">
       </form>
     </td>
   </tr></table>
		<table border=0 cellpadding=0 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
          
              <cfinclude template="includes/copyrights.cfm">
           
          </td>
        </tr>
      </table>
</div>


<SCRIPT LANGUAGE="JavaScript">
<!--
document.loginform.user_id.focus()

// -->
</SCRIPT>

 </body>
</html>
</cfoutput>
