<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
<head>
	<title>Insert New Banner</title>
</head>

 <cfinclude template="../includes/app_globals.cfm">
 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
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

<CFQUERY DATASOURCE="#datasource#" NAME="banner">
SELECT * FROM banners
WHERE ID = ID
</CFQUERY>

<!--- Get Banner Count and Limit to 3 records Updated Sylvester July 09,2011--->

<cfquery datasource="#datasource#" name="getBannerCount">
	SELECT * FROM banners WHERE banner_enable = '1'
</cfquery>
	
	<cfset bannerCount = #getBannerCount.RecordCount#>


	
<!---
<cfif #ParameterExists(insert)#>


<cfquery datasource="#datasource#">
INSERT INTO banners (factor, file_name, company, webaddress, username, password, ban_hptop, ban_hpbot, ban_am)
VALUES ('#factor#', '#file_name#', '#company#', '#webaddress#', '#username#', '#password#', #ban_hptop#, #ban_hpbot#, #ban_am#)
</cfquery>
</cfif>


--->
 



<cfset check="">


		<cfif #bannerCount # EQ 3>
		
		<cfoutput>
		
		<script type="text/javascript">
		
			alert("You have reached the maximum banners to display.");
			window.location.href="add_new_banner.cfm";
		
		</script>
			
		</cfoutput>

		
		
	<cfelse>
	

<cfif isdefined("form.file_name") and form.file_name is not "" and form.webaddress is not "">
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
	 <cfimage action="resize" width="220" height="240" source="#directory2#" destination="#directory2#" overwrite="yes">
	 </cfif>

  <cfset file_name = #File.ServerFile#>

	<cfquery datasource="#datasource#">
	INSERT INTO banners (factor, file_name, company, webaddress, username, password, ban_hptop, ban_hpbot, ban_am)
	VALUES ('#factor#', '#file_name#', '#company#', '#webaddress#', '#username#', '#password#', #ban_hptop#, #ban_hpbot#, #ban_am#)
	</cfquery>

<cflocation url="add_new_banner.cfm">
<cfset check="TRUE">
<cfelse>
<cfset check="FALSE">

</cfif>


</cfif>




<tr bgcolor="bac1cf"><td colspan=5>
<form action="insert_new_banner.cfm" method="post" ENCTYPE="multipart/form-data">


<table cellspacing="1" width=750 cellpadding="2" bgcolor=bac1cf border="0">
<tr>
<td>


<p>
Enter the advertising company name, the URL the banner will be linked to, the frequency, browse for the banner image (the optimum size should be 400x60, other than that the banner might be distorted.), and click on "add new banner" button.</p><br>

</td>
</tr>
<cfif #check# is not "">
<tr>
<td align=center>
<cfoutput> <font color=red> You must browse for a banner and provide the URL it will be linked to to proceed.</font></cfoutput>
</td>
</tr>
</cfif>
</table>
<table cellspacing="1" width=750 cellpadding="2" bgcolor=bac1cf border="0">
<tr>
<td align=right>
<font face="Arial,Verdana" size="2" color="Navy"><b>Company:</b></font>
</td>
<td><input type="text" name="company" size="30" maxlength="50"></td>
</tr>
<tr>
    <td align="right"><font face="Arial,Verdana" size="2" color="navy"><b>Url Link:</b></font></td>
    <td><input type="text" name="webaddress" size="50" maxlength="120"></td>
</tr>
<input type="hidden" name="username" value=" ">
<input type="hidden" name="password" value=" ">
<tr>
    <td align="right"><font face="Arial,Verdana" size="2" color="Navy"><b>Frequency:</b></font></td>
    <td><select name="factor">
	
	<option value="1" selected>1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option></select>&nbsp; <font face="Arial,Verdana" size="1" color="Red">1 = rarely 10 = often</font></td>
</tr>
<tr>
    <td align="right"><font face="Arial,Verdana" size="2" color="Navy"><b>Upload Banner:</b></font></td>
    <td><input name="file_name" type="file" size=43 maxlength=250></td>
</tr>
<input type="hidden" name="ban_hptop" value="1">
<input type="hidden" name="ban_hpam" value="0">
<input type="hidden" name="ban_hpbot" value="0">
<tr>
    <td colspan="2" align="center">
	<input type="submit" name="insert" value="Add New Banner"> <input type="button" value="Go Back" Onclick="history.back();"></td>
</tr>
</table>
</form>
</td></tr>
	 </table>		
</center>


</body>
</html>
