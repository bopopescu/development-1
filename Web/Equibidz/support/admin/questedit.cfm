<!---
support/admin/support.cfm
used to edit questions
Visual Auction 4 Administrator [Support Module]
06/16/00 TLingard
--->

<cfinclude template = "../../includes/app_globals.cfm">

<!--- Always check for valid username/password --->
 <cfinclude template="../../admin/validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">
 
 <!--- Set a default value for "submit" if nonexistent --->
<!---  <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "enter">
 </cfif> --->
 
 <cfset error_message = "">
 <cfset questget = "">
 <cfset selected_sub = 0>
 
 <cfif isDefined("Send")>
 
  <cfparam name="form.active" default="0">
  <cfparam name="form.emailuser" default="0">
  
  <cfquery name="update_question" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
 UPDATE faqquestion
 SET sub_id = #form.sub_id#, 
	 question = '#form.question#',
	 answer = '#form.answer#',
	 active = #form.active#
 WHERE quest_id = #form.questid# 
 </cfquery>
 
 	<cfif form.emailuser neq 0>
 
	<cfmodule template="eml_answer.cfm"
 		sub_id = "#form.sub_id#"
 		question = "#form.question#"
 		answer = "#form.answer#"
 		active = "#form.active#"
 		email = "#form.email#"
 		username = "#form.name#">
 	</cfif>
 <cflocation url="./support.cfm?updated=True">
 <cfabort>
 </cfif>
 
<cfif isDefined("url.quest_id")>
<cfquery name="showquest" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqquestion
WHERE quest_id = #url.quest_id#
</cfquery>
<cfset active = showquest.active>
<cfset questid = #url.quest_id#>
</cfif>


<cfquery name="subidconvert" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
  SELECT subjects, sub_id
  FROM faqsubject
  WHERE 
<cfif isDefined("Preview")>
sub_id = #form.selected_sub#
<cfelse>
sub_id = #showquest.sub_id#</cfif>
</cfquery>


<cfquery name="allsubs" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqsubject
</cfquery> 

 <cfsetting EnableCFOutputOnly="NO">
 
<!--- Main page --->
<html>
 <head>
  <title>Visual Auction 4 Administrator [Support Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
</head>

 <body bgcolor=465775>
  <font face="helvetica" size=2>
   <center>

<!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900>
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>
<!---
<td></td>
<td></td>
--->
<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->


<!--- Include the menubar --->
  <cfset #page# = "support">
  <cfinclude template="../../admin/menu_include.cfm">
 <tr>
  <td colspan=5 bgcolor=bac1cf>
    <table border=0 cellspacing=0 cellpadding=5 width=709>
  <tr>
  <td>
    <table border=0 cellspacing=0 cellpadding=5 width=100%>
      <tr>

       <td>
         <font face="helvetica" size=2 color=000000>
          Use this page to administer the support area in your <i>Auction Server</i> software.  If you do not
          know<br> how to use this administration tool, please click the
          help button in the <br>upper right corner of this window.
         <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
         </font>
		 </td>
		 <tr>
        <td valign="top">
		<font face="Helvetica" size=2 color=000080><b>SUPPORT INFORMATION:</b>
		<cfif isDefined("url.quest_id")>
		<cfoutput>This question is #IIf(active eq 0, DE("inactive"), DE("active"))#</cfoutput>
		</cfif>
		<br></font>
		<table border=0 bordercolor=000080 cellspacing=0 cellpadding=2 width="100%">
		 <tr>
		 <td>
<cfif isdefined("Preview")>

		 <cfoutput>
		 <form name="userForm" action="questedit.cfm" method="post">
			<table width="90%">
			<tr>
				<td width="30%" align="right"><font size="3"><b>Select subject :</b></font></td>
				<td>#subidconvert.subjects#
				</td>
			</tr>
			<tr>
			<td><br></td>
			<td><br></td>
			</tr>
			<tr>
				<td align="right" valign="top"><font size="3"><b>Question :</b></font><br> </td>
				<td>#form.question#
				</td>
			</tr>
			<tr>
				<td><br></td>
				<td><br></td>
			</tr>
			<tr>
				<td align="right" valign="top"><font size="3"><b>Answer :</b></font></td>
				<td>
				#form.answer#
				</td>
			</tr>
			<tr>
				<td><br></td>
				<td><br></td>
			</tr>
			<tr>
			<td align="right"><font size="3"><b>Make Active:</b></font></td>
			<td><input type="checkbox" name="active" value=1 checked></td>
            </tr>
			<tr>
			<td align="right"><font size="3"><b>Email user:</b></font></td>
			<td><input type="checkbox" name="emailuser" value="1" checked></td>
            </tr>

				<input type="hidden" name="sub_id" value="#form.selected_sub#">
				<input type="hidden" name="question" value="#form.question#">
				<input type="hidden" name="answer" value="#form.answer#">
				<input type="hidden" name="email" value="#form.email#">
				<input type="hidden" name="name" value="#form.name#">
				<input type="hidden" name="questid" value="#form.questid#">
			<tr>
				<td align="right">
				<br>
				<input type="submit" name="Send" value="Send" width="75">

</td>
				</form>

				</cfoutput>

<cfelse>
	  	  
			<table width="100%">
			<form name="userFormquest" action="support.cfm" method="post">
			<tr>
				<td><cfoutput><input type="hidden" name="questid" value="#url.quest_id#"></cfoutput></td>
				<td align="right"><input type="submit" name="Deletequest" value="Delete"><br></td>
			</tr>
			</form>
	<cfoutput><form name="userForm" action="questedit.cfm" method="post"></cfoutput>
			<tr>
				<td width="30%" align="right"><font size="3"><b>Select subject :</b></font></td>
				<td><select name="selected_sub" width="175">
      <cfif allsubs.recordcount is 0><option value="0">< none ></option></cfif>
	  <cfloop query="allsubs"><cfoutput><option value="#sub_id#" <cfif subidconvert.sub_id eq sub_id>selected</cfif>>#subjects#</option>
	  </cfoutput></cfloop>
      </select> &nbsp; 
	  	<cfoutput>
				( originally : <u>#subidconvert.subjects#</u> )
				</td>
			</tr>

			<tr>
				<td align="right" valign="top"><font size="3"><b>Question :</b></font><br> </td>
				<td><textarea cols="45" rows="5" name="question" wrap="physical">#showquest.question#</textarea>
				</td>
			</tr>
			<tr>
				<td><br></td>
				<td><br></td>
			</tr>
			<tr>
				<td align="right" valign="top"><font size="3"><b>Answer :</b></font></td>
				<td><font color=433294>Use HTML to format answers (i.e. for line breaks use &lt;br&gt;)<br> Do Not Use Quotation Marks ( "" )</font>
				<br>
				<textarea rows=10 cols="45" name="answer" wrap="physical">#showquest.answer#</textarea>
				</td>
			</tr>
			<tr>
				<td>
				</td>
				
				<input type="hidden" name="questid" value="#questid#">
				<input type="hidden" name="email" value="#showquest.email#">
				<input type="hidden" name="name" value="#showquest.name#">
				<td><input type="submit" name="Preview" value="Preview">
				</form>
				</cfoutput>
		</cfif>
		</td>
		</tr>
	  </table>
	 </td>
	 </tr>
	 </table>
		</td>
       </tr>
      </table>
	  	 </td>
	    </tr>
	   </table>    
	  </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>
