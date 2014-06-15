<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 

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
  <title>Personal Message Center - Login</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <script language="JavaScript">
  function openWindow (URL, name, width, height) {
    window.open (URL, name, "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
  }
 </script>



 <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">
 <cfoutput>
 <body onLoad="document.loginform.user_id.focus()">

   <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4></font><b>Personal Message Center</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       The Personal Message Center is a complete messaging system for registered users to communicate with while on our site.
       <br><br>

        <cfif #isDefined ("failed")# and failed eq 1>
       		<font color="ff0000"><b>Login failed.  Please try again.</font>
		<cfelseif #isDefined ("failed")# and failed eq 2>
	        <font color="ff0000"><b>Login failed.  Please check your email to confirm your registration before loging in.</font>
        </cfif>

        Before proceeding, you must log in.

    	
  	    <form name="loginform" action="main_page.cfm" method="post">
        <table border=0 cellspacing=0 cellpadding=4>




<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
 		<input name="login" type="hidden" value="#session.user_id#">
		<input name="password" type="hidden" value="#session.password#">

<cflocation url="main_page.cfm">
<cfelse>

         <tr><td ><b>User ID:</b></td><td><input type="text" name="user_id" size=15 maxlength=20></td><td>(User name or ID number)</td></tr>
<!---         <tr><td bgcolor="ffffff"><b>Password:</b></td><td><input type="password" name="password" size=15 maxlength=12 onBlur="document.forms[0].elements[2].focus()"></td></tr> --->
        <tr><td ><b>Password:</b></td><td><input type="password" name="password" size=15 maxlength=12></td></tr>

        </table>
        <br>

       	<cfif isDefined('URL.user_id')>
    	    <input type="hidden" name="seller_userid" value="#URL.user_id#">
     	  </cfif>
		<cfif isDefined('URL.itemnum')>
    	    <input type="hidden" name="itemnum" value="#URL.itemnum#">
     	  </cfif>
      	<cfif isdefined('url.from')>
        	<input type="hidden" name="from" value="#url.from#">
      		<input type="hidden" name="to" value="#url.send_to#">
      	</CFIF>

        <input type="submit" name="submit" value="Next >>" width=75>


       </form>


</cfif>
     </td>
    </table>
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
  
  
 <body onLoad="document.loginform.user_id.focus()">
 </body>
</html>
