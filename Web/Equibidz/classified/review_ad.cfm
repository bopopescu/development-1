<!--- classified/review_ad.cfm
	Review page for Classified's Ads;
	Accept Ad goes to Post_ad.cfm.
	Back goes back to Place_ad.cfm.
	04/28/00 
	classified ver 1.0a
--->


<HTML>
<HEAD>
<TITLE>Classified Ad Review</TITLE>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 <link rel=stylesheet href="../includes/stylesheet.css" type="text/css">
</HEAD>



<cfinclude template = "../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">
<cfif isDefined('session.user_id') is 0>
<cflocation url="/login.cfm?login=1&path=/classified/place_ad.cfm">
</cfif>

<cfset date_end=#DateAdd("d","#session.duration#","#session.date_start#")#>

<cfset obo = session.obo>

<cfquery name="get_cat_name" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT name
FROM categories
WHERE category=#session.category1#
</cfquery>
<cfinclude template = "../includes/bodytag.html">
<cfinclude template = "../includes/menu_bar.cfm">
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
  <tr> 

    <td colspan="2" align="center" valign="top"> <div align="center"><font size="2"></font></div></td>
  </tr>
  <tr> 
    <td width="28%" colspan="3" align="center" valign="middle"><font size="2"><b><font color="#0000FF">This 
      is what your ad will look like when it appears on the site. </font></b></font></td>
  </tr>
  <tr> 
    <td colspan="3" height="52"><cfoutput><font face="arial" color="blue">Ad Number:</font> <font face="arial" color="black">#session.adnum#</font><br><font face="arial" color="blue" size="+1">Title: </font><font face="arial" color="black" size="+1">#session.title# </font><hr width=100% size=1 color="#heading_color#" noshade><br>Category: #get_cat_name.name#</cfoutput></td>
  </tr>
  <cfoutput><tr> 
    <td align="left" valign="top" colspan="2" height="52">Ad Body:<hr width=100% size=1 color="#heading_color#" noshade>#session.ad_body# <cfif #Len(session.picture_url)# GT 7><br><img src="#session.picture_url#" border="0"></cfif></td>
    <td align="left" valign="top" width="33%" height="52">Ad Ends: #TimeFormat("#date_end#", 'hh:mm:ss tt')# #DateFormat("#date_end#", "mm/dd/yyyy")#<hr width=100% size=1 color="#heading_color#" noshade>Asking Price: #numberFormat(session.ask_price,numbermask)#<cfif obo eq "1"> Or Best Offer</cfif>
 <hr width=100% size=1 color="#heading_color#" noshade><font size="-1">Posted By: <a href="mailto:#session.email#">#session.user_id#</a> </td>
  </tr>



<cfif session.picture1 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs/#session.fullsize_name#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>


<cfif session.picture2 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs0/#session.fullsize_name1#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>


<cfif session.picture3 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs1/#session.fullsize_name2#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>
<cfif session.picture4 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs2/#session.fullsize_name3#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>


</cfoutput>
  <tr>
    <td width="28%" height="52"><form action="post_ad.cfm" method="get" >
	 <input type="hidden" name="revise" value="revise"><input type="submit" name="accept" value="Accept Ad">&nbsp;&nbsp;<input type="submit" name="Back" value="Back"></form></td>
    <td width="39%" height="52">&nbsp;</td>
    <td width="33%" height="52">&nbsp;</td>
  </tr>
  <tr><td width=250 valign=top>
            <br>
<!---
            <form name="search" action="search_results.cfm" method="GET">
<input name="phrase_match" type=hidden value="all">
              <font size=2 face="Arial">
                <input type=text name="search_text" size=15>
                <input type=submit name="search" value="Search">
                <br>
                <cfif category IS NOT 0>
                  <input name="search_category" type="checkbox" value="#category#">Search only in this category
                </cfif>
              </font>
            </form> --->

        </td>
        </tr>
        </table><cfoutput>
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
      </table></cfoutput></div>
</BODY>

</HTML>
