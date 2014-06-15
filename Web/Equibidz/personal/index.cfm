<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>

<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Personal Page: Login</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">


 <cfoutput>

  <!--- The main table --->
 <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4 color="000000"><b>Personal Page</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       This section of our site allows you to change and update your personal information,
       as well as view statistics such as your bidding history, feedback you've left, and
       items you've auctioned.
       <br><br>
       <cfif #isDefined ("failed")# and failed eq 1>
        <font color="ff0000"><b>Login failed.  Please try again.</font>
	   <cfelseif #isDefined ("failed")# and failed eq 2>
	    <font color="ff0000"><b>Login failed.  Please check your email to confirm your registration before loging in.</font>
       <cfelse>
        Before proceeding, you must log in.<br><br>
       </cfif>
       <form name="loginform" action="main_page.cfm" method="post">
        <table border=0 cellspacing=0 cellpadding=4>
      


<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
 		<input name="login" type="hidden" value="#session.user_id#">
		<input name="password" type="hidden" value="#session.password#">
		<cflocation url="main_page.cfm" addtoken="No">
 	  <cfelse>
         <tr><td><b>User ID:</b></td><td><input type="text" name="user_id" value="" size=15 maxlength=20></td><td>(User ID number or Username)</td></tr>
         <tr><td><b>Password:</b></td><td><input type="password" name="password" value="" size=15 maxlength=12></td></tr>
                
        
        </table>
        <br>
        <input type="submit" name="submit" value="Next >>" width=75>
       </form>
     </td>
    </tr>
    

</cfif>
  <tr><td><br></td></tr></table></div>
	 
     <div align="center">
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>

<SCRIPT LANGUAGE="JavaScript">
<!--
document.loginform.user_id.focus()

// -->
</SCRIPT>

 </body>
</html>
