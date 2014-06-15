<cfsetting enablecfoutputonly="yes">


 <!--- include globals --->
 <!--- include globals --->

 <cfset current_page = "personal"> 
 <cfinclude template="../includes/app_globals.cfm">
  
 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
 
  <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 
 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>



<cfif isDefined("session.user_id")>

<!---  retrieve existing html entered by user  --->
  <cfquery username="#db_username#" password="#db_password#" name="get_html" datasource="#DATASOURCE#">
      SELECT mypage, user_id, nickname,showfeedback,showauctions
        FROM users
       WHERE user_id = #session.user_id#
  </cfquery>

<cfelse>
   <cflocation url="index.cfm">
  
  </cfif>



 <cfif #isDefined ("form.showauctions")# is 1>
  <cfset #showauctions# = "1">
 <cfelse>
 <cfset #showauctions# = "0">
  </cfif>



 <cfif #isDefined ("form.showfeedback")# is 1>
  <cfset #showfeedback# = "1">
 <cfelse>
 <cfset #showfeedback# = "0">
  </cfif>


<cfset error_message="">

 
 <CFIF IsDefined("form.submit")>
<CFQUERY name="putmypage" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
Update users
set mypage = '#form.mypagetext#',

showfeedback=#showfeedback#,
showauctions=#showauctions#
WHERE user_id = #session.user_id#
</CFQUERY>
<cfset #error_message#= "<font color=red> Your personal page updated.</font>">
<cfelse>
<cfset showfeedback=#get_html.showfeedback#>
<cfset showauctions=#get_html.showauctions#>
</CFIF>




 
<cfif get_html.recordcount GT 0>
    <cfset mypagetext = get_html.mypage>
</cfif>


<CFOUTPUT>

<html>
<head><title>  About Me page</title>
<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
</head>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">


 
 
  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4 color="000000"><b>My Page</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>

 #error_message#
</font>
</td>
</tr>



<TR><TD ALIGN=CENTER>
Please enter your information in the box below (HTML is ok).
<FORM ACTION="editmypage.cfm" method=post name="EditMyPageForm">
<cfif get_html.mypage neq "">

Your personal page will look like 
<a href="mypage.cfm?nickname=#get_html.nickname#" target="_blank">this</a><br><br></cfif>
<TEXTAREA name="mypagetext" ROWS=15 COLS=70>
#mypagetext#
</TEXTAREA><BR>
<center>

<input name="showauctions" type="checkbox" value="1"<cfif #showauctions# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Show Auctions
<input name="showfeedback" type="checkbox" value="1"<cfif #showfeedback# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Show Feedback Ratings.<br>(<font color=red size=1> Uncheck to the boxes remove your feedback ratings and auction listings from your personal page</font>)

<br>
<INPUT TYPE="SUBMIT" name="submit" VALUE="Submit">
</FORM>


</TD></TR>
</TABLE>

            </td>
              </tr>
             </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>

</table>

 </div><div align="center">
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
 </body>
</html>