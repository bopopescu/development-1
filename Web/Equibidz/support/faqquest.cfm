<cfsetting enablecfoutputonly="yes">
<!---
  Support/FAQ
  faqquest.cfm
  Displays questions for specified subject
  06/16/00 TLingard
--->

<cfinclude template = "../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">
<cfif ParameterExists(url.subject) is False>
<cflocation url="./index.cfm">
<cfabort>
<cfelse>
<cfset sub_id = #url.subject#>
</cfif>

<cfquery name="faqsub" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqquestion
WHERE sub_id = #sub_id#
AND active = 1
AND answer <> ''
</cfquery>

<cfquery name="listsub" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT subjects
FROM faqsubject
WHERE sub_id = #sub_id#
</cfquery>

<cfset subject = #listsub.subjects#>
<cfset question = #faqsub.question#>

<html>
<head>
	<title>FAQ</title>
</head>

<cfoutput>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>

    <tr><td><center></center><br><br></td></tr>
    <tr><td><font size=4><b>#subject#</b></font></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
If you have a question that is not listed you may <a href="faqsubmit.cfm">submit them here</a>.
<br>

<center>
<table border=0 cellpadding=5 width=100%>
<tr>
	<td align="center">
<center>
<br>

<table cellspacing="10" width="1000%">

<cfif faqsub.recordcount eq 0>
No questions listed
<cfelse>
<cfloop query="faqsub">
<tr>
	<td><li type="disc">
	<a href="faqquestdetail.cfm?quest_id=#quest_id#">#faqsub.question#</a></li></td>
	</tr>
</cfloop>
</cfif>
</table>
</center>
</td>
</tr>
</table>
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
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></div>
</body>
</html>
</cfoutput>>