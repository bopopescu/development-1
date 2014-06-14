
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfset current_page="register">
<cfmodule template="../functions/timenow.cfm">


<!--- Check for valid ID and password --->
  
  <cfquery username="#db_username#" password="#db_password#" name="check_login" datasource="#DATASOURCE#">
      SELECT user_id, nickname
        FROM users
       WHERE (nickname = '#user_id#'
         
    <cfif IsNumeric(user_id)>
          OR  user_id = #user_id#
    </cfif>
             )
  </cfquery>
  
  <cfif #check_login.RecordCount# GT 0>
    <cfquery username="#db_username#" password="#db_password#" name="check_login" datasource="#DATASOURCE#">
		UPDATE users
		SET confirmation = 1
		WHERE user_id = #user_id#
	</cfquery>
    <!--- log creation of new account ---> 
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Account Confirmation"
      details="USER ID: #user_id#    NICKNAME: #check_login.nickname#"
      user_id="#user_id#">
  <cfelse>
    <cfset #error_code# = "1">
  </cfif>




<cfoutput>
<html>
  <head>
    <title>New User Registration</title>
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	
  </head>
  
  <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">
    <!--- The main table --->
    <center>
      <table border=0 cellspacing=0 cellpadding=2 width=640>
        <tr>
          <td>
		    <cfif isdefined("error_code")>
			<font size=4 color="red">
			<b>Your account is invalid.</b>
			</font>
			<cfelse>
            <font size=4 color="000000">
              <b>Your account (#check_login.nickname#) has been confirmed. You are now cleared to buy and sell items on our site. </b>
            </font>
			</cfif>
          </td>
        </tr>
        <tr>
          <td>
            <br>
            <br>
                     <hr size=1 color=#heading_color# width=100%>
          </td>
        </tr>
        <tr>
          <td>
            <font size=2>
              <cfinclude template="../includes/copyrights.cfm">
            </font>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
</cfoutput>
