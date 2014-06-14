 <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">

<cfquery username="#db_username#" password="#db_password#" name="CategoryNew" datasource="#DATASOURCE#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'category_new'
</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="get_limitcat_frontpage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='limitcat_frpage'
</cfquery>
<cfset #limitcat_frpage# = #get_limitcat_frontpage.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#" maxrows="#limitcat_frpage#">
    SELECT category, name, date_created, child_count, count_total
      FROM categories
     WHERE parent = 0
       AND active = 1
       AND require_login = 0
     ORDER BY name ASC
</cfquery>

<!--- get category that require login --->
<cfquery username="#db_username#" password="#db_password#" name="LoginCategories" datasource="#DATASOURCE#">
    SELECT category
      FROM categories
     WHERE active = 1
       AND require_login = 1
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfoutput>

<html>
<head>
	<title>#company_name#</title>
  <link rel=stylesheet href="#VAROOT#/includes/style.css" type="text/css">
</head>
<cfset imagefile = "#expandpath('..\logos\#Trim(get_layout.logo)#')#">
<cfx_image action="iml" file="#imagefile#"
JPEG_quality="100"
commands="
resize 134,129,fit
write #expandpath('..\smallimage\#Trim(get_layout.logo)#')#
">   



<!---<bod leftmargin=0 topmargin=0 marginheight="0" marginwidth="0" bgcolor="E6E6E6"> --->

<table border="0" cellpadding="0" cellspacing="0" width="758" align="center">
<tr valign="top">
	<td><!---<img src="#varoot#/logos/#get_layout.logo#" alt="" width="184" height="129" border="0">
--->
<TABLE WIDTH=184 BORDER=0 CELLPADDING=0 CELLSPACING=0 height=129>
	<TR>
		<TD>
			<IMG SRC="#varoot#/images/logo_01.gif" WIDTH=22 HEIGHT=129></TD>
		<TD>
	<a href="#varoot#/index.cfm?hit=0">		<IMG SRC="#varoot#/smallimage/#trim(get_layout.logo)#" <!---WIDTH=134 HEIGHT=129--->border=0></a></TD>
		<TD>
			<IMG SRC="#varoot#/images/logo_03.gif" WIDTH=22 HEIGHT=129></TD>
	</TR>
</TABLE>


</td>
	<td>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td colspan="2">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><a href="#varoot#/index.cfm?hit=0"><img src="#varoot#/images/but01.gif" width="115" height="30" alt="" border="0"></a></td>
	<td><a href="#varoot#/registration"><img src="#varoot#/images/but02.gif" alt="" width="114" height="30" border="0"></a></td>
	<td><a href="#varoot#/feedback"><img src="#varoot#/images/but03.gif" width="112" height="30" alt="" border="0"></a></td>
	<td><a href="#varoot#/support"><img src="#varoot#/images/but04.gif" width="116" height="30" alt="" border="0"></a></td>
	<td><a href="#varoot#/store/store.cfm"><img src="#varoot#/images/but05.gif" width="117" height="30" alt="" border="0"></a></td>
</tr>
</table>	
	</td>
</tr>
<tr>
	<td background="#varoot#/images/fon_top01.gif" colspan="2" height="37">
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="">
<tr>
	<td><p class="menu01"><a href="#varoot#/news.cfm"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp; What's new</a></p></td>
	<td><p class="menu01"><a href="#varoot#/messaging"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;Messaging</a></p></td>
<cfif classified_valid IS "Yes">
<td><p class="menu01"><a href="#varoot#/classified"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;Classified</a></p></td>
	<td><p class="menu01"><a href="#varoot#/classified/search"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;Classified Search</a></p></td>
<cfelse>
<td><p class="menu01"><a href="#varoot#/contactus.cfm"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;Contact us</a></p></td>
	<td><p class="menu01"><a href="#varoot#/privacy.cfm"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;Privacy</a></p></td>
</cfif>
	<td><p class="menu01">

<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq ""><a href="#VAROOT#/login.cfm?logout=1" ><font color=red><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;Logout</a></font></a><cfelse><a href="#VAROOT#/personal"><img src="#varoot#/images/e01.gif" width="8" height="7" alt="" border="0">&nbsp;&nbsp;My Account</a></cfif></p>
</td>
</tr>
</table>
	</td>
</tr>
<!---
<tr>
	<td><img src="#varoot#/images/form01.gif" width="341" height="22" alt="" border="0"></td>
	<td><img src="#varoot#/images/form02.gif" width="233" height="22" alt="" border="0"></td>
</tr>
<tr>
<form action="#varoot#/login.cfm"  method="post">
	<td height="40" background="#varoot#/images/form03.gif" width="341" alt="" border="0" align="center">
<input type="Text" name="user_id" value="Nickname" size="10" maxlength="255" onclick="this.value=''; return true">&nbsp;<input type="password" name="password" value="password" size="10" maxlength="255" onclick="this.value=''; return true"><input type="image" src="#varoot#/images/b_login.gif" width="69" height="20" alt="" border="0" align="absbottom" >
<input  type="hidden" name="submit" value="Log In" >
	</td>
	</form>
	<td  background="#varoot#/images/form04.gif" width="233" height="40">
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="">
<tr align="center">
	<td><p style="color: FFFFFF; font-size: 10px;"><b>&nbsp;</b></p></td>
	<td><a href=""><!---<img src="#varoot#/images/b_vew.gif" width="79" height="20" alt="" border="0">---></a>


</td>
</tr>--->

<tr>
<td align=center>
<cfinclude template="banners1.cfm">
</td>
</tr>
</table>
	</td>
</tr>
</table>
	</td>
</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="758" align="center">
<tr valign="top">
	<td width="185" background="#varoot#/images/fon_left03.gif">
<table border="0" cellpadding="0" cellspacing="0" background="#varoot#/images/fon_left01.gif" width="100%">
<tr>
	<td align="right">
<table border="0" cellpadding="0" cellspacing="0" width="165" background="#varoot#/images/fon_left02.gif">
<tr>
	<td background="#varoot#/images/left01.gif" height="26"><p class="title">CATEGORIES</p></td>
</tr>
<cfloop query="get_Categories">             <cfquery username="#db_username#" password="#db_password#" name="get_child_count" datasource="#DATASOURCE#">    			SELECT category      			FROM categories     			WHERE parent = #category#       			AND active = 1			  </cfquery>              <!--- define info --->                            <cfif get_child_count.recordcount gt 0>                <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#category#">                <cfset dspArrow = '<img src="#VAROOT#/images/folder.gif" width=22 height=16 border=0 align=top ALT="This category contains subcategories">'>              <cfelse>                <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#category#">                <cfset dspArrow = "">              </cfif>              			<!--- don't modify this cfparam... change it in the /includes/cache_control.cfm page only! --->			<cfparam name="URL.strCaching" default="no">			<cfif URL.strCaching NEQ "no">			<!--- yes, we are caching... get count from categories table (faster) --->			<cfset total_auctions = get_categories.count_total>			<cfelse>				<!--- No page caching... get live count: --->				<!--- tally number of auctions for category --->	<cfmodule template="../functions/tallyauctions.cfm"				category="#category#"				datasource="#DATASOURCE#"				TIMENOW="#TIMENOW#"> 			</cfif>              			 

<tr>
	<td>
<p class="b01"><img src="#varoot#/images/e02.gif" width="6" height="5" alt="" border="0" align="absmiddle">&nbsp;&nbsp;<a href="#categoryLink#"><b>#Trim(name)#</b></a> #dspArrow#<font size=1>(#total_auctions#)<!---<cfif DateDiff("d", get_Categories.date_created, TIMENOW) LTE CategoryNew.days> &nbsp;<font color=ff0000>NEW</font></cfif>---></font></p>
<div align="center"><img src="#varoot#/images/hr01.gif" width="137" height="3" alt="" border="0"></div>

</td>
</tr>
</cfloop>

<tr>
<td>
<p class="b01">&nbsp;</td></tr>
<tr><td>
<p class="b01"><img src="#varoot#/images/e02.gif" width="6" height="5" alt="" border="0" align="absmiddle">&nbsp;&nbsp;
<a href="#VAROOT#/listings/categories/all_cats.html"><font size=1><b>View All Categories</b></font></a>
<div align="center"><img src="#varoot#/images/hr01.gif" width="137" height="3" alt="" border="0"></div>
</td>
</tr>

<tr>
	<td><img src="#varoot#/images/left_bot02.gif" width="165" height="18" alt="" border="0"></td>
</tr>
</table>	
<br>
<table border="0" cellpadding="0" cellspacing="0" width="165" background="#varoot#/images/fon_left02.gif">
<tr>
	<td background="#varoot#/images/left02.gif" height="26"><p class="title">QUICK SEARCH</p></td>
</tr>
<tr>
	<td>
<form name="search" action="#VAROOT#/search/search_results.cfm" method="get" >
<p class="px5">
<div align="center"><input type=text name="search_text"  size="13"></div>
<p class="px5">
<div align="center"><input type="Image" src="#varoot#/images/b_search.gif" width="79" height="20" alt="" border="0"></div>
<p class="px5">
<p class="b01"><img src="#varoot#/images/e02.gif" width="6" height="5" alt="" border="0" align="absmiddle">&nbsp;&nbsp;<A HREF="#VAROOT#/search/index.cfm" >Advanced search</a></p>
	
<input type="hidden" name="search_type" value="title_search"><input type="hidden" name="search_name" value="Title &amp Description Search"><input name="phrase_match" type=hidden value="any"></td>
</tr>
</form>
<tr>


	<td><img src="#varoot#/images/left_bot02.gif" width="165" height="18" alt="" border="0"></td>
</tr>
</table>	
	</td>
</tr>


<tr>
	<td><img src="#varoot#/images/left_bot01.gif" width="185" height="32" alt="" border="0"></td>
</tr>
</table>
	</td>

<!--- add in --->
<td bgcolor="FFFFFF" width="572">
<div align="center"><img src="images/m_top.gif" width="572" height="8" alt="" border="0"></div>
<p class="px5">
<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center" height="25" background="images/fon_bar01.gif">
<tr><td><table><tr><td>

</cfoutput>