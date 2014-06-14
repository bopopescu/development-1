<!---
support/admin/questadd.cfm
used to create new questions for the support section
Visual Auction 4 Administrator [Support Module]
06/16/00 TLingard
--->

<cfinclude template = "../../includes/app_globals.cfm">

<!--- Always check for valid username/password --->
 <cfinclude template="../../admin/validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">
 
 <!--- Set a default value for "submit" if nonexistent --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "enter">
 </cfif>
 
 <cfset error_message = "">
 <cfset questget = "">
 
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
		<br></font>
		<table border=0 bordercolor=000080 cellspacing=0 cellpadding=2 width="100%">
		 <tr>
		 <td>
		 <cfif isdefined("PreviewN")>
<cfquery name="subidconvert" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
  SELECT subjects
  FROM faqsubject
  WHERE sub_id = #form.selected_sub#
</cfquery>
		 <cfoutput>
		 <form name="userForm" action="support.cfm" method="post">
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
				<td>
				</td>
				<input type="hidden" name="sub_id" value="#form.selected_sub#">
				<input type="hidden" name="question" value="#form.question#">
				<input type="hidden" name="answer" value="#form.answer#">
				<td>
				<br>
				<br>
				<input type="submit" name="new" value="Submit" width="75">
				</form>
				</cfoutput>
		 <cfelse>
	  	  <cfoutput><form name="userForm" action="questadd.cfm" method="post"></cfoutput>
			<table width="90%">
			<tr>
				<td width="30%" align="right"><font size="3"><b>Select subject :</b></font></td>
				<td><select name="selected_sub" width="175">
      <cfif allsubs.recordcount is 0><option value="0">< none ></option></cfif>
	  <cfloop query="allsubs"><cfoutput><option value="#sub_id#" <cfif isdefined("selected_sub") and selected_sub eq sub_id>selected</cfif>>#subjects#</option>
	  </cfoutput></cfloop>
      </select> &nbsp; 
	  	<cfoutput>
				</td>
			</tr>

			<tr>
				<td align="right" valign="top"><font size="3"><b>Question :</b></font><br> </td>
				<td><textarea cols="45" rows="5" name="question" wrap="physical"></textarea>
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
				<textarea rows=10 cols="45" name="answer" wrap="physical"></textarea>
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td><input type="submit" name="PreviewN" value="Preview">
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
  </form>
 </body>
</html>


</body>
</html>
