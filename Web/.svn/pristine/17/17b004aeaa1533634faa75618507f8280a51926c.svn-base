<!---
  /includes/404notfound.cfm
  
  custom error message...
  feature temporarily unavailable..
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfinclude template="app_globals.cfm">

<cftry>
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cfset TIMENOW = Now()>
  </cfcatch>
</cftry>

<!--- output page --->
<cfsetting enablecfoutputonly="No">
<html>
  <head>
    <title></title>
  </head>
  
  <cftry>
    <cfinclude template="bodytag.html">
    <cfcatch>
      <body bgcolor="ffffff" text="000000" link="0000ff" alink="ff0000" vlink="0000dd">
    </cfcatch>
  </cftry>
    <center>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=100%>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
  
              <font size=2>
                <cftry>
                  <cfinclude template="menu_bar.cfm">
                  <cfcatch>
                  </cfcatch>
                </cftry>
              </font>
              <br>
<!--- 
              <br>
              Browse the <a href="<cfoutput>#VAROOT#</cfoutput>/studio/index.html">studio</a> for items.
 --->
            </center>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=4>
              Temporarily Unavailable!
            </font>
<hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade>
            We're sorry... this feature is temporarily unavailable.  Please try back 
            at a later time.<br>
            <br>
            Thank you!<br>
            Customer Service<br>


<cfif isdefined("url.error")>
            <p><font color=ff0000><b>Error Reported:</b></font> <cfoutput>#url.error#</cfoutput>
</cfif>

            <br>
            <br>
          </td>
        </tr>
      </table>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td align=left valign=top>
            <font size=2>
              <cftry> 
                <cfinclude template="copyrights.cfm">
                <cfcatch>
                </cfcatch>
              </cftry>
              <br>
              <br>
              <br>
            </font>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
