<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
  <SCRIPT LANGUAGE="JavaScript">
  <!-- Hide from other browsers

    function checkAll()
    {
      for (var i=0;i<document.numbskull.id.length;i++)
      {
        var e = document.numbskull.id[i];
        if (e.name != 'selectAll')
          e.checked = !e.checked;
      }
    }
	

  // Stop Hididng from other Browsers  -->
  </SCRIPT>
<html>
<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
<head>
	<title>Add New Banner</title>
</head>
 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
 <!--- Main page body --->
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


<cfif #ParameterExists(insert)#>
<cfquery datasource="#datasource#">
INSERT INTO banners (factor, file_name, company, webaddress, username, password,enable)
VALUES ('#factor#', '#file_name#', '#company#', '#webaddress#', '#username#', '#password#',#enable#)
</cfquery>
</cfif>


<cfif #ParameterExists(edit)#>
<cfquery datasource="#datasource#">
update banners
set factor='#factor#', file_name='#file_name#', company='#company#', webaddress='#webaddress#', username='#username#', password='#password#'
where ID=#ID#
</cfquery>
</cfif>

<cfif #ParameterExists(delete)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="bannerid" list="#Form.id#">

<cfquery datasource="#datasource#">
delete  from banners
where id = #bannerID#
</cfquery>
</cfloop>
</cfif>
</cfif>



<cfif #ParameterExists(disable)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="bannerid" list="#Form.id#">

<cfquery datasource="#datasource#">
update banners
set banner_enable = 0
where id = #bannerID#
</cfquery>
</cfloop>
</cfif>
</cfif>


<cfif #ParameterExists(enable)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="bannerid" list="#Form.id#">

<cfquery datasource="#datasource#">
update banners
set banner_enable = 1
where id = #bannerID#
</cfquery>
</cfloop>
</cfif>
</cfif>

<CFQUERY DATASOURCE="#datasource#" NAME="banner">
SELECT * FROM banners
WHERE ID = ID
</CFQUERY>

<CFQUERY DATASOURCE="#datasource#" NAME="banner2">
SELECT * FROM banners

</CFQUERY>
<tr bgcolor="bac1cf"><td colspan=5>
<table cellspacing="1" width=750 cellpadding="2" border="0" >
<tr>
<td colspan=5 bgcolor="bac1cf" >
<table border=0 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%  align=center>	
<tr>
<td>

Select the banner(s) you'd like to delete or disable, then click on the appropriate button to proceed. To add new banner, click on the  "Add new banner" button. To edit an existing banner, click on the banner link.
</td>
</tr>
<tr>
<td>
&nbsp;
</td>
</tr>

<tr><td>
<table>

<cfif #banner.recordcount# neq 0>
<tr>
<td><input type="checkbox" name="selectAll " onClick="return checkAll();">
	Check All<br></td>
</tr></cfif>

<tr>
<td>
<cfoutput query="banner">





<form action="add_new_banner.cfm" name="numbskull"  method="post" >

<input type="checkbox" name="id" value="#ID#"><font face="Arial,Verdana" size="2" color="Navy">

 <a href="submitbanner.cfm?ID=#ID#" target=_self>
<cfif #Company# eq "">
 <cfset NameID = "Blank">
<cfelse>

 <cfset NameID = #Company#> 
</cfif>#NameID# &nbsp;&nbsp;</a>

<cfif #banner_enable# eq 0><font color=red size=1> Banner is disable</font></cfif>
<!---<a href="insert_new_banner.cfm" >Add new banner</a> ---></font><br><br>



</cfoutput>	
<cfif #banner.recordcount# neq 0>
<input type="submit" name="delete" value="Delete banner(s)" onclick="return confirm('Are you sure you want to delete these items?');">


<input type="submit" name="enable" value="Enable Banners" onclick="return confirm('Are you sure you want to enable these items?');">

<input type="submit" name="Disable" value="Disable Banners" onclick="return confirm('Are you sure you want to disable these items?');">
<input type="button" value="Go Back" Onclick="history.back();">


<cfelse>


</cfif>

</form>
</td>


<!---<td>

<form action="insert_new_banner.cfm" method="post">
<input type="submit" value="Add new banner">;">
</form>
</td>
--->



<form action="insert_new_banner.cfm" method="post">
<input type="submit" value="Add new banner">
<input type="button" value="Go Back" Onclick="history.back();">
</form>
</td>
</tr>


</table>


</td>



</tr>
</table>
</td>
</tr>
</table>

</td></tr>
	 </table>
 </center>



</body>
</html>
