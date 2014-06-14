<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/app_globals.cfm">
 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <!--- Main page body --->
 <body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
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
	     <cfset #page# = "banners">
	     <cfinclude template="menu_include.cfm">  

<cfinclude template = "../includes/app_globals.cfm">
<cfparam name="ban_hptop" default="0">
<cfparam name="ban_hpbot" default="0">
<cfparam name="ban_am" default="0">



<cfquery name="banner2" datasource="#datasource#">
select * from banners
where ID=#ID#
</cfquery>

<cfif #ParameterExists(edit)#>

<cfif #isDefined ("banner_enable")# is 1>
  <cfset #banner_enable# = "1">
 <cfelse>
  <cfset #banner_enable# = "0">
 </cfif> 
 
 
<cfif isdefined("form.file_name") and form.file_name is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory2 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"admin","banners")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.file_name"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.file_name"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset file_name = #File.ServerFile#>
<cfelse><cfset file_name = old_file_name>
</cfif>

<cfquery datasource="#datasource#">
update banners
set factor='#factor#',
    file_name='#file_name#',
	company='#company#',
	webaddress='#webaddress#',
	username='#username#',
	password='#password#',
	ban_hptop=#ban_hptop#,
	ban_hpbot=#ban_hpbot#,
	ban_am=#ban_am#,
banner_enable=#banner_enable#
where ID=#ID#
</cfquery>
</cfif>

<cfif #ParameterExists(delete)#>

<cfquery datasource="#datasource#">
delete  from banners
where id = #ID#
</cfquery>
</cfif>



<tr bgcolor="bac1cf"><td colspan=5 align=center>

<form action="submitbanner.cfm" method="post">
<cfoutput query="banner2">
<table border="0" bgcolor="bac1cf" cellspacing="0" cellpadding="2">
<tr>
	<td><font face="Arial,Verdana" size="2" color="Navy"><b> Company name: <input type="text" name="company" value="#company#" size="25" maxlength="50"></b></font></td>
</tr>
<tr>
	<td>
	<cfif #file_name# is "">
	<img src="../admin/images/noimage2.gif" border="0">
	<cfelse>
	<img src="../banners/#file_name#" border="0"></cfif></td>
</tr>
<input type="hidden" name="username" value=" ">
<input type="hidden" name="password" value=" ">
<input type="hidden" name="old_file_name" value="#file_name#">

	<td ><font face="Arial,Verdana" size="2" color="Navy"><b>Banner URL :</b> <a href="#webaddress#">#webaddress#</a><br><input type="text" name="webaddress" value="#webaddress#" size="40" maxlength="120"></font></td>
</tr>
<tr>
    <td><font face="Arial,Verdana" size="2" color="Navy"><b>Upload Banner:</b></font><br>
    <input name="file_name" type="file" size=43 maxlength=250 value="#file_name#"></td>
</tr>
<tr>
	<td><font face="Arial,Verdana" size="2" color="Navy"><b>Frequency:</b></font> <input type="text" name="factor" value="#factor#" size="2" maxlength="2">&nbsp;&nbsp; <font face="Arial,Verdana" size="1" color="Red">The Higher the Number The More Often Displayed.</font><br>

<input type="Checkbox" name="banner_enable" value="1" <cfif #banner_enable# eq 1>checked</cfif>>&nbsp;Active/Inactive banner
</td>
</tr>

<tr>
	<td align="center"><input type="submit" name="edit" value="Update Selected Banner Ad"> <input type="button" value="Go Back" Onclick="history.back();"></td>
</tr>
<input type="hidden" name="ID" value="#ID#">
<tr><td>
<!---
<table><tr>
    <td align="center"><font face="Arial,Verdana" size="2" color="Navy"><b>Location:</b></font></td>
	<td><input type="Checkbox" name="ban_hptop" value="1" <cfif ban_hptop eq 1>checked</cfif>>&nbsp;(Home Page Top Placement)<br>
		<input type="Checkbox" name="ban_hpbot" value="1" <cfif ban_hpbot eq 1>checked</cfif>>&nbsp;(Home Page Bottom Placement)<br>
		<input type="Checkbox" name="ban_am"  <cfif ban_am eq 1>checked</cfif>>&nbsp;(AutoMenu Placement)</td>
</tr></table>
--->



<input type="hidden" name="ban_hptop" value="1">
<input type="hidden" name="ban_hpam" value="0">
<input type="hidden" name="ban_hpbot" value="0">


</td></tr>
</table>
</cfoutput>
</form>
</td></tr>
</table>