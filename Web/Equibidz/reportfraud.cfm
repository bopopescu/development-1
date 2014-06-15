<cfsilent>
<cfset current_page="help">

 <!--- include globals --->
 <cfinclude template="includes/app_globals.cfm">
  
 <!--- Include session tracking template --->
 <cfinclude template="includes/session_include.cfm">

 <!--- define TIMENOW --->
 <cfmodule template="functions/timenow.cfm">


<cfset #error_message# = "">
<cfset #error_list# = "">
<cfparam name="nickname" default="">
<cfparam name="password" default="">
<cfparam name="message" default="">


<cfif #isDefined ("submit")#>
  <cfset #submit# = #trim (submit)#>
  <cfelse>
  <cfset #submit# = "">
</cfif>




<cfif isdefined ("submit") and  #submit# is "Report Fraud">


   <cfquery username="#db_username#" password="#db_password#" name="verify_login" datasource="#DATASOURCE#">
    SELECT user_id, nickname,email
      FROM users
     WHERE nickname = '#nickname#'
     <cfif isNumeric(nickname) is 1>
        OR user_id = #nickname#
     </cfif>
       AND password = '#password#'
	   AND is_active = 1
and confirmation=1
   </cfquery>
  
   
 <cfif verify_login.recordCount is 0>
      <cfset #error_list# =#listAppend (error_list, "nickname")#>
      <cfset #error_list# = #listAppend (error_list, "password")#>
    <cfelseif #trim (message)# is "">
      <cfset #error_list# = #listAppend (error_list, "message")#>
 </cfif>





<cfif #error_list# is ""  AND #error_message# IS "">



<cfmail to="admin@#domain#"
  from="#verify_login.email#"
  subject="This user,#nickname#,#verify_login.email#,has just suggested a category">
  
#message#


</cfmail>

<cfset #error_message# = "<font color=Red size=2>Your message has been sent successfully</font>">
</cfif>
</cfif> 

</cfsilent>
<cfoutput>

<html>
 <head>
  <title>Report Fraud</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="includes/bodytag.html">
 <cfinclude template="includes/menu_bar.cfm">

  <!--- The main table --->
  <center>

       
   <table border=0 cellspacing=0 cellpadding=2 width=#get_layout.page_width#>

<cfif #error_message# is not "">
	
<tr>
<td>
  
              <font size=3 color=ff0000>	            <center>#error_message#</center></font>
</td>
</tr>

</cfif>

    <tr><td><font size=4 color="000000"><b>Report Fraud</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# noshade></td></tr>
    <tr>
     <td>
     <font size=1><b>
Please enter <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq ""> your nickname, your password,</cfif> the fraudulent activities you 'd like to report, and click on "Report Fraud" button.      
</b></font>
</td>
</tr>
<tr>
<td>
&nbsp;
</td>
</tr></table>

 <br><br>
      
      	 <form name="send" action="reportfraud.cfm" method="post">
        <table border=0 cellspacing=0 cellpadding=4>






<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
 		<input name="nickname" type="hidden" value="#session.nickname#">
		<input name="password" type="hidden" value="#session.password#">

 	  <cfelse>


<tr>
<td>&nbsp;</td>
</tr>      
         <tr><td><font <cfif #listFind (error_list, "nickname")#>color="ff0000"<cfelse>color="0000ff"</cfif>><b>Your nickname:</b></font></td>
		  <td>&nbsp;</td>
<td><input type="text" name="nickname" value="" size=15 maxlength=20></td></tr>
         <tr><td ><font <cfif #listFind (error_list, "password")#>color="ff0000"<cfelse>color="0000ff"</cfif>><b>Your password:</b></font></td>

		  <td>&nbsp;</td>
<td><input type="password" name="password" value="" size=15 maxlength=20></td></tr>
                
</cfif>

<tr>
       		  <td ><font <cfif #listFind (error_list, "message")#>color="ff0000"<cfelse>color="0000ff"</cfif>><b>Your message:</b></font></td>
		  <td>&nbsp;</td>
       <td><textarea name="message" value="#message#" rows=5 cols=50 wrap=virtual></textarea></td>
			</tr>
        
        </table>
        <br>

        <input type="submit" name="submit" value="Report Fraud" width=75>
       </form>
     </td>
    </tr>
  
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
          
              <cfinclude template="includes/copyrights.cfm">
          
          </td>
        </tr>
      </table>
    </center>
  </cfoutput>

 </body>
</html>