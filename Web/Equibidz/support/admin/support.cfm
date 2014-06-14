<!---
support/admin/support.cfm
main support admin page
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

<cfif isDefined("Add")>
<cftry>
  <cftransaction>
  <cfif subadd neq "">
  <cfquery name="addsub" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
  INSERT INTO faqsubject (subjects)
  VALUES ('#subadd#')
  </cfquery>
  <cfset error_message = "Subject '#subadd#' has been added">
  <cfelse>
  <cfset error_message = "Add new subject is null.  Please enter new subject.">
  </cfif>
  </cftransaction>
  
<cfcatch type="Database">
<cfset error_message = "Subject already exist">
</cfcatch>

</cftry>
</cfif>

<cfif isDefined("Delete")>
<cfquery name="checkforquest" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT sub_id
FROM faqquestion
WHERE sub_id = #selected_sub#
</cfquery>

  <cfif checkforquest.recordcount gt 0>
  <cfset error_message = "Can not delete subject; questions are still posted within">
  <cfelse>
  <cfquery name="deletesub" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
  DELETE FROM faqsubject
  WHERE sub_id = #selected_sub#
  </cfquery>
   <cfset error_message = "Subject deleted successfully">
  </cfif>
</cfif>

<cfif isDefined("Retrieve")>
<cftry>
<cftransaction>
<cfquery name="getselected" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqquestion
WHERE sub_id = #selected_sub#
</cfquery>
<cfquery name="getsubject" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT subjects
FROM faqsubject
WHERE sub_id = #selected_sub#
</cfquery>
</cftransaction>

<cfcatch type="Expression">
<cfset error_message = "You must first select a subject">
</cfcatch>

</cftry>
<cfset questget = "selected">
</cfif>

<cfif isDefined("Inactive")>
<cftry>
<cftransaction>
<cfquery name="getselectedinactive" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqquestion
WHERE sub_id = #selected_sub# AND active = 0
</cfquery>
<cfquery name="getsubject" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT subjects
FROM faqsubject
WHERE sub_id = #selected_sub#
</cfquery>
<cfset questget = "inactive">
</cftransaction>

<cfcatch type="Expression">
<cfset error_message = "You must first select a subject">
</cfcatch>

</cftry>
</cfif>

<cfif isDefined("url.updated")>
 <cfset error_message = "Question update successful">
</cfif>

<cfif isdefined("new")>
 <cfparam name="form.active" default="0">
 <cfquery name="add_question" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
 INSERT INTO faqquestion (sub_id, question, answer, active)
 VALUES (#sub_id#, '#question#', '#answer#', #active#)
 </cfquery>
 <cfset error_message = "Question creation successful">
</cfif>


<cfif isdefined("Deletequest")>
<cfset questid = form.questid>
  <cfquery name="deletequest" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
  DELETE FROM faqquestion
  WHERE quest_id = #form.questid#
  </cfquery>
  
   <cfset error_message = "Question deleted successfully">
</cfif>


<cfquery name="getinactive" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqquestion
WHERE active = 0
</cfquery>

<cfquery name="allsubs" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT *
FROM faqsubject
</cfquery> 

<cfif isdefined("Create")>
<cfif allsubs.recordcount gt 0>
<!---><cfoutput><cflocation url="questadd.cfm?selected_sub=#selected_sub#"></cfoutput>--->
<cfoutput><cflocation url="questadd.cfm?sel=#selected_sub#"></cfoutput>

<cfelse>
<cfset error_message = "You have not create FAQ subject.">
</cfif>
</cfif>

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
	  	  <form name="userForm" action="support.cfm" method="post">
       <td>
         <font face="helvetica" size=2 color=000000>
          Use this page to administer the support area in your <i>Auction Server</i> software.  If you do not
          know<br> how to use this administration tool, please click the
          help button in the <br>upper right corner of this window.
<hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
         </font></td>
		 <tr>

        <td valign="top">
		<font face="Helvetica" size=2 color=000080><b>SUPPORT INFORMATION:</b>
		<cfif error_message neq "">
		<cfoutput><font color=ff0000>#error_message#</font></cfoutput>
		</cfif>
		<br></font>
		<table border=0 bordercolor=000080 cellspacing=0 cellpadding=2 width="100%">
		 <tr>
		 <td>
		<table border=0 width=100%>
		<tr>
		<td><input type="text" name="subadd" size="21"></td>
		<td><input type="submit" name="Add" value="Add New Subject" width="75"></td>
		<td>Allows you to add new subjects</td>
		</tr>
		<tr>
		<td colspan="3">&nbsp;</td>
		</tr>
	  <tr>
	  <td rowspan="4" width="20%">
	  <select name="selected_sub" size=7 width=175>
      <cfif allsubs.recordcount is 0><option value="0" selected>< none ></option></cfif>
	  <cfloop query="allsubs">
	  <cfquery name="chk_new_quest" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
		SELECT answer
		FROM faqquestion
		WHERE sub_id = #sub_id#
		AND answer = ''
	  </cfquery>
	  <cfoutput><option value="#sub_id#" <cfif isdefined("selected_sub") and selected_sub eq sub_id>selected<cfelse><cfif allsubs.currentrow eq 1>selected</cfif></cfif>>#subjects#<cfif chk_new_quest.recordcount gt 0> *</cfif></option></cfoutput>
	  </cfloop>
      </select>
	  </td>
	  </tr>
	  <tr>
	   <td width="15%" height="33%">
	   <input type="submit" name="Delete" value="Delete" width="75">
	   </td>
	   <td width="65%"> Deletes the selected subject.</td>
	  </tr>
	  <tr>
	   <td width="15%" height="33%">
	   <input type="submit" name="Retrieve" value="Retrieve" width="75">
	   </td>
	   <td width="65%">Retrieves all questions within the selected subject.</td>
	  </tr>
	  <tr>
	   <td width="15%" height="33%">
	   <input type="submit" name="Inactive" value="Inactive" width="75">
	   </td>
	   <td width="65%">Shows only the inactive questions within the selected subject.</td>
	  </tr>
	  <tr>
	  <td colspan="3">         <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
	  </tr>

<cfoutput>
	 <tr>
	 <td>Subject : <cfif questget eq "">#allsubs.subjects# <cfelse>#getsubject.subjects#</cfif><cfif questget eq "inactive">( inactive )</cfif></td>
	 </tr>
     <cfswitch expression="#questget#">
	  
	 <cfcase value="selected">
	  <cfif getselected.recordcount eq 0>
	   <tr>
	   <td valign="top"><input type="submit" name="Create" value="Create New Question"></td>
	   <td colspan="2" valign="top"><li>No questions posted</li></td>
	   </tr>
	  <cfelse>
	   <cfset rows = #getselected.recordcount# + 1>
	   <td rowspan="#rows#" valign="top"><input type="submit" name="Create" value="Create New Question"></td>
	   </tr> 
	   <cfloop query="getselected">
	    <tr><td colspan="2" valign="top"><li><cfif answer eq ""><img src="images/new.gif"></cfif><a href="questedit.cfm?quest_id=#quest_id#">#question#</a></li></td></tr>
	    </cfloop>
	   </cfif>
	  </cfcase>
	  
	  <cfcase value="inactive">
	   <cfif getselectedinactive.recordcount eq 0>
	   <td valign="top"><input type="submit" name="Create" value="Create New Question"></td>
	    <td colspan="2" valign="top" align="center"><li>No inactive questions within this subject</li></td>
	    </tr>
	   <cfelse> 
	    <cfset rows = #getselectedinactive.recordcount# + 1>
	    <td rowspan="#rows#" valign="top"><input type="submit" name="Create" value="Create New"></td>
	    </tr> 
	    <cfloop query="getselectedinactive">
	     <tr><td colspan="2" valign="top"><li><a href="questedit.cfm?quest_id=#quest_id#">#question#</a></li></td></tr>
	    </cfloop>
	   </cfif>
	  </cfcase>
	   
	  <cfdefaultcase>
	   <cfset rows = #getinactive.recordcount# + 1>
	    <td rowspan="#rows#" valign="top"><input type="submit" name="Create" value="Create New Question"></td>
	   </tr> 
	   <cfloop query="getinactive">
	    <tr><td colspan="2" valign="top"><li><cfif answer eq ""><img src="images/new.gif"></cfif><a href="questedit.cfm?quest_id=#quest_id#">#question#</a></li></td></tr>
	   </cfloop>
	  </cfdefaultcase>
	   
	  </cfswitch>
</cfoutput>
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
