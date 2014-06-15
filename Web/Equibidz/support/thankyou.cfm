<cfsetting enablecfoutputonly="yes">
<!---
  Support/FAQ
  thankyou.cfm
  confirms question has been sent and sends email to support staff
  06/16/00 TLingard
--->

<cfinclude template = "../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


<cfquery name="check" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT question
FROM faqquestion
WHERE question = '#session.quest_sub#'
</cfquery>

<cfif #check.recordcount# GTE 1>
  <font face="Arial" color=ff0000 size="+2">This question has already been submitted.</font>
  <cfabort>
</cfif>


 <cfset subject_sub = session.subject_sub>
 <cfset quest_sub = session.quest_sub>
 <cfset name_sub = session.name_sub>
 <cfset email_sub = session.email_sub>
 <!--- <cfset phone_sub = session.phone_sub> --->


<cfquery name="insertquest" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
INSERT INTO faqquestion (sub_id, question, answer, name, email)<!--- , phone --->
VALUES (#subject_sub#, '#quest_sub#', '', '#name_sub#', '#email_sub#')<!--- , '#phone_sub#' --->
</cfquery>

<cfquery  name="listsub" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqsubject
WHERE sub_id = #subject_sub#
</cfquery>

<cfmodule template="eml_support.cfm"
 subject_sub = "#listsub.subjects#"
 quest_sub = "#quest_sub#"
 name_sub = "#name_sub#"
 email_sub = "#email_sub#"><!--- phone_sub = "#phone_sub#" --->

 <cfset session.subject_sub = "">
 <cfset session.quest_sub = "">
 <cfset session.name_sub = "">
 <cfset session.email_sub = "">
 <!--- <cfset session.phone_sub = ""> --->
 
<cfoutput>
<html>
<head>
	<title>FAQ Question Submited</title>
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
	
<center><table cellspacing="10" width="100%">
<tr>
	<td>
<font size="4">
<b>
<center>Your question has been sent to customer support.</center> 
</b>
<br>
<br>

<center><font size="3" color="0000ff">We will get back to you ASAP.</font></center>

</font>
</td>
</tr>
<tr>
	<td align="center"><a href="#VAROOT#/support/index.cfm">Return to support page</a></td>
</tr>
</table>
</center>
</td>
</tr>
</table>
<!--- include copyright information --->
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