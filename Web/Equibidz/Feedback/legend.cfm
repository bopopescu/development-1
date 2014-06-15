<cfsetting enablecfoutputonly="Yes">

<cftry>
  <!--- include globals --->
  <cfset current_page="feedback">
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<!--- output page --->
<cfsetting enablecfoutputonly="No">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>User Feedback</title>
<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
</head>
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
  <div align="center">

  <table border=0 cellspacing=0 cellpadding=2 width=800>			
      <tr><td><font size=4><br><b>Feedback Legend</b></font></td></tr>
      <tr><td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td></tr>
   	  <tr><td>
		<div style="padding-left:12px;padding-right:15px;padding-top:15px;padding-bottom:12px;">
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend1#</cfoutput>"> represents a new member with a Feedback Profile of 0 to 9.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend2#</cfoutput>"> represents a Feedback Profile of 10 to 49.<br>
	    <li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend3#</cfoutput>"> represents a Feedback Profile of 50 to 99.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend4#</cfoutput>"> represents a Feedback Profile of 100 to 499.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend5#</cfoutput>"> represents a Feedback Profile of 500 to 999.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend6#</cfoutput>"> represents a Feedback Profile of 1,000 to 4,999.<br>
    	<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend7#</cfoutput>"> represents a Feedback Profile of 5,000 to 9,999.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend8#</cfoutput>"> represents a Feedback Profile of 10,000 to 24,999.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend9#</cfoutput>"> represents a Feedback Profile of 25,000 to 49,999.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend10#</cfoutput>"> represents a Feedback Profile of 50,000 to 99,999.<br>
		<li>A <img align="ABSMIDDLE" border="0" src="/legends/<cfoutput>#get_layout.legend11#</cfoutput>"> represents a Feedback Profile of 100,000 or higher<br>
		</div><br><br>
	  </td></tr>
   	  <tr><td align="center">
        <input type="button" name="back" value=" << Back " onClick="JavaScript:history.back(1)"><br><br>
	  </td></tr>
  </table> 
  <cfoutput>
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
