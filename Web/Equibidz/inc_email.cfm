<cfinclude template ="includes/app_globals.cfm">



 <cfif IsDefined("Form.email")>

    <cfset email = Trim(Form.email)>

  <cfelse>

    <cfset email = "">

  </cfif>

  

  

  

  <!--- define message --->

  <cfif IsDefined("Form.message")>

    <cfset message = Trim(Form.message)>

  <cfelse>

    <cfset message = "I saw this site: http://#CGI.SERVER_NAME##VAROOT# and thought you might be interested in it.">

  </cfif>

  

  <!--- define chk values --->

  <cfset chkAccount = "TRUE">

  <cfset chkFriendEmail = "TRUE">

  <cfset chkSubmit = "FALSE">

    

  <!--- if sumbit, check info --->

  <cfif IsDefined("Form.sendemail")>


<cfif len(#email#) eq 0>
<cfoutput>
<FONT FACE=ARIAL COLOR=RED><b>ERROR</b><br></FONT>
No Email Address specified.<br><br>
<input type="button" value="Go Back" Onclick="history.back();">
</cfoutput>
<cfabort>
</cfif>   

<cfmail to="#email#" from="#get_layout.service_email##domain#" subject="Thought you might be interested in this...">#message#</cfmail>

     <!---  

<cfoutput>Your message has been sent.</cfoutput>

    <input type="button" value="Go Back" Onclick="history.back();">



--->



  <cfset chkSubmit = "TRUE">

    

    

  </cfif>

  

<cfmodule template="functions/timenow.cfm">







<html>

  <head>

    <title>Tell A Friend</title>

    

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">

  </head>

  

  <!--- Include the body tag --->





<!--- Statistics Heading --->

        	<table cellpadding=2 border=0 width="100%">

            <tr>

               <cfoutput>

			   <td bgcolor=#heading_color# style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>

				<b>.:Tell a friend:.</b>

			   </td>

			   </cfoutput>

            </tr>

         	</table>

			  

         	<center>

      

         

    

          <form name="email2friend" action="inc_email.cfm" method="POST">

          <cfoutput>

          <table border=0 cellspacing=0 cellpadding=1 noshade width=100%>

            







<cfif chksubmit>

<tr>

<td>

<font color=red>Your message has been sent.</font>

<br>

<input type="button" value="Go Back" Onclick="history.back();">

</td>

</tr>

</cfif>





            <tr>

              <td valign=top>







                <font size=1>Friend email address</font><br>

                <input type=text name="email" value="" size=20 maxlength=255><br>

                <br>

               

              </td>

             

            </tr>

            <tr>

              <td colspan=2>

<!---

                <font size=1>

                  <b>Personal message</b> for your friend<br>

                </font> --->

             <font size=1>   <textarea name="message" rows=2 cols=20 wrap=virtual>#message#</textarea></font>

                <br>

                <br>

             

                <input type=submit name="sendemail" value="Send "> 

                <input type=reset  value="Reset ">

               

              </td>

            </tr>

          </table>

          </cfoutput>

          </form>

     

    

    </center>
