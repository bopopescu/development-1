<style type="text/css"> 
/////////////////////////////////////////////////////////////////////////////////
#container h3 {clear:both; margin-top:4em;}
/* Set Flat Header Width Below */
.flat {background: transparent; width:315px; margin:0 auto;}
.flat h1, .flat p {margin:0 10px;}
.flat h1 {font-size:20px; color:#000000; letter-spacing:1px; font-family:arial}
.flat p {padding-bottom:0.5em;}
.flat .top, .flat .bottom {display:block; background:transparent; font-size:1px;}
.flat .z1, .flat .z2, .flat .z3, .flat .z4, .flat .z1z, .flat .z2z, .flat .z3z, .flat .z4z {display:block; overflow:hidden;}
.flat .z1, .flat .z2, .flat .z3, .flat .z1z, .flat .z2z, .flat .z3z {height:1px;}
.flat .z2 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z2z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z1 {margin:0 5px; background:#000000;}
.flat .z2, .flat .z2z {margin:0 3px; border-width:0 2px;}
.flat .z3, .flat .z3z {margin:0 2px;}
.flat .z4, .flat .z4z {height:2px; margin:0 1px;}
.flat .z1z {margin:0 5px; background:#000000;}
.flat .boxcontent2 {display:block;  background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
/////////////////////////////////////////////////////////////////////////////////
</style>

<!---<cfinclude template ="includes/app_globals.cfm">--->



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

			   <td style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>

<div id="container">
<div class="flat">
<b class="top"><b class="z1"></b><b class="z2"></b><b class="z3"></b><b class="z4"></b></b>
<div class="boxcontent2">
<b>Tell a Friend</b>
</div>
<b class="bottom"><b class="z4z"></b><b class="z3z"></b><b class="z2z"></b>
<b class="z1z"></b></b>
</div>
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







                &nbsp;&nbsp;&nbsp;<font size=1>Friend email address</font><br>

                &nbsp;&nbsp;&nbsp;<input type=text name="email" value="" size=20 maxlength=255><br>

                <br>

               

              </td>

             

            </tr>

            <tr>

              <td colspan=2>

<!---

                <font size=1>

                  &nbsp;&nbsp;&nbsp;<b>Personal message</b> for your friend<br>

                </font> --->

&nbsp;&nbsp;&nbsp;<font size=1><textarea name="message" rows=2 cols=20 wrap=virtual>#message#</textarea></font>

                <br>

                <br>

             

                &nbsp;&nbsp;&nbsp;<input type=submit name="sendemail" value="Send "> 

                &nbsp;&nbsp;&nbsp;<input type=reset  value="Reset ">

               

              </td>

            </tr>

          </table>

          </cfoutput>

          </form>

     

    

    </center>
