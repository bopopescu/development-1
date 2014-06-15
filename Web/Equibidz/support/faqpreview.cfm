<cfsetting enablecfoutputonly="yes">
<!---
  Support/FAQ
  faqpreview.cfm
  previews question to be submitted by user 
  06/16/00 TLingard
--->

<cfinclude template = "../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm"> 


 <cfset subject_sub = session.subject_sub>
 <cfset quest_sub = session.quest_sub>
 <cfset name_sub = session.name_sub>
 <cfset email_sub = session.email_sub>
 <!--- <cfset phone_sub = session.phone_sub> --->
 
 <cfset session.subject_sub = subject_sub>
 <cfset session.quest_sub = quest_sub>
 <cfset session.name_sub = name_sub>
 <cfset session.email_sub = email_sub>
 <!--- <cfset session.phone_sub = phone_sub> --->

<cfquery  name="listsub" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqsubject
WHERE sub_id = #session.subject_sub#
</cfquery>

<cfoutput>
<html>
<head>
	<title>FAQ Preview Page</title>
</head>

<cfinclude template="../includes/bodytag.html">

<cfinclude template="../includes/menu_bar.cfm">
<center>

<!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>

    <tr><td><center></center><br><br></td></tr>
    <tr><td><font size=4><b>Question Submit</b></font>
	</td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
	       <font size=3>
       Please review your question.
      <br>
<center>
<table border=0 cellspacing="10" width="100%">
<tr>
	<td align="right" valign="top" width="15%"><font size="3"><b>Subject :</b></font></td>
	<td><font size="3">#listsub.subjects#</font></td>
	<td width="15%">&nbsp;</td>
</tr>
<tr>
	<td align="right" valign="top" width="15%"><font size="3"><b>Question :</b></font></td>
	<td><font size="3" color="433294">#session.quest_sub#</font></td>
	<td width="15%">&nbsp;</td>
</tr>
<tr>
	<td align="right" valign="top" width="15%"><font size="3"><b>Name :</b></font></td>
	<td><font size="3">#session.name_sub#</font></td>
	<td width="15%">&nbsp;</td>
</tr>
<tr>
	<td align="right" valign="top" width="15%"><font size="3"><b>E-mail :</b></font></td>
	<td><font size="3">#session.email_sub#</font></td>
	<td width="15%">&nbsp;</td>
</tr>
<!--- <tr>
	<td align="right" valign="top" width="15%"><font size="3"><b>Phone :</b></font></td>
	<td><font size="3">#session.phone_sub#</font></td>
	<td width="15%">&nbsp;</td>
</tr> --->
<tr>
	<td align="center" width="15%">
<form action="faqsubmit.cfm" method="post">
<input type="submit" value="< Back" name="Back">
</form></td>
    <td><form action="thankyou.cfm" method="post">
<input type="submit" value="Submit">
</form></td>
<td width="15%">&nbsp;</td>
</tr>
</table>
</center>
</td>
</tr>
</table>
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
</cfoutput>