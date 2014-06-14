<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfset current_page="register">
<cfmodule template="../functions/timenow.cfm">

<cfoutput>
<html>
  <head>
    <title>#company_name#: Auction Site User Agreement</title>
  </head>
  
</cfoutput>

<cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">

<cfoutput>
  <div align=center>
    <center>
      <table border=0 cellspacing=0 cellpadding=2 width=640>
        <tr>
          <td>
            <cfinclude template="user_agreement.html">
            <!--- <FONT FACE="arial,helvetica,geneva" SIZE=4 COLOR="0000FF">
              <CENTER>
                Thank you for using this site!
              </CENTER>
            </font> --->
          </td>
        </tr>
        <tr>
          <td align="center">
            <br>
              <form name="dummy" action="index.cfm" method="post">
                <input type="submit" name="submitted" value="Accept" width=75>&nbsp;&nbsp;<input type="submit" name="submitted" value="Decline" width=75>
              </form>
          </td>
        </tr>
        <tr>
          <td>         <hr size=1 color=#heading_color# width=100%></td>
        </tr>
        <tr>
          <td align="left"><font size=2><cfinclude template="../includes/copyrights.cfm"></font></td>
        </tr>
      </table>
    </center>
  </div>
</cfoutput>
