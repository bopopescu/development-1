<!--- classified/review_ad.cfm
	Review page for Classified's Ads;
	Accept Ad goes to Post_ad.cfm.
	Back goes back to Place_ad.cfm.
	04/28/00 
	classified ver 1.0a
--->


<HTML>
<HEAD>
<TITLE>Advertisement Review</TITLE>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 <link rel=stylesheet href="../includes/stylesheet.css" type="text/css">
</HEAD>



<cfinclude template = "../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">
<cfif isDefined('session.user_id') is 0>
   <cflocation url="/login.cfm?login=1&path=/advertise/index.cfm">
</cfif>

<cfset date_end=#DateAdd("m","#session.duration#","#session.date_start#")#>

<cfinclude template = "../includes/bodytag.html">
<cfinclude template = "../includes/menu_bar.cfm">


<cfoutput>  
<table align="center" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td>
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=700>
  <tr> 
    <td colspan="2" align="left" valign="middle"><br><br><font size="4"><b>Please review and confirm your Advertisement</b></font><br>
      <hr width=100% size=1 color="#heading_color#" noshade><br>
    </td>
  </tr>
  <tr> 
    <td width="15%"><font face="arial"><b>Ad Number:</b></td>
    <td width="85%">#session.adnum#</td>
  </tr>
  <tr> 
    <td width="15%"><font face="arial"><b>Web Link:</b></td>
    <td width="85%">#session.title#</td>
  </tr>
  <tr> 
    <td width="15%"><font face="arial"><b>Duration:</b></td>
    <td width="85%">#session.duration# Month(s)</td>
  </tr>
  <tr> 
    <td width="15%"><font face="arial"><b>Date Start:</b></td>
    <td width="85%">#dateformat(session.date_start)#&nbsp;(Note: Date Start is tentative pending Site Owner's approval)</td>
  </tr>
  <tr><td colspan=2>&nbsp;</td></tr>
  <tr><td valign="top"><font face="arial"><b>Ad Banner:</b></td>
    <td align="left">
        <img src="/advertise/images/#session.picture#" border=0>
    </td>
    </tr>
    <tr>
    <td>
    &nbsp;
    </td>
    </tr>

</cfoutput>
  <tr>
    <td colspan="2"><font size="3">Note: This is Ad will be submitted for approval. 
    However, once the <br>processing is completed, your Ad will be automatically posted in our Site.<br><br></td>
  </tr>  
  <tr>
    <td colspan=2><form action="post_ad.cfm" method="get" >
	 <input type="hidden" name="revise" value="revise"><input type="submit" name="accept" value="Submit Ad">&nbsp;&nbsp;<input type="submit" name="Back" value="Back">
     </form></td>
  </tr>
  <tr><td colspan=2 valign=top>
      <br>
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
  </td>
  </tr>
</table>
</BODY>

</HTML>
