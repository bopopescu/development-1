<html><cfinclude template="app_globals.cfm"><head><title>Menu</title><cfoutput><link rel=stylesheet  href="#VAROOT#/includes/style.css"  type="text/css"></cfoutput></head><cfparam name="current_page" default="indexhome"><cfif #get_layout.template# eq 1> <body bgcolor=white marginheight="0" topmargin="0" vspace="0" marginwidth="0" leftmargin="0" hspace="0" style="margin:0; padding:0"><form name="search" action="<cfoutput>#VAROOT#</cfoutput>/search/search_results.cfm" method="get" ><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 width=100%><TR><TD><a href="<cfoutput>#VAROOT#</cfoutput>/index.cfm?hit=0" ><IMG SRC="<cfoutput>#VAROOT#/logos/#get_layout.logo#</cfoutput>" border=0 alt="Auction Home"></a></TD><TD><TABLE CELLPADDING=3 CELLSPACING=0 BORDER=0><TR><TD colspan=2><!---<IMG SRC="/images/menu_bar.gif" border=0 alt="" usemap="#menu">---><font size=4 >	<b><a href="<cfoutput>#VAROOT#</cfoutput>/index.cfm" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Home</font></a	>&nbsp;&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/store" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Stores</font></a	>&nbsp;&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/registration" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Register</font></a	>&nbsp;&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/sellers/" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Sell</font></a>&nbsp;&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/help/" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Help</font></a	>&nbsp;&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/messaging/" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Messaging</font></a	>&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/feedback/leavefeedback.cfm" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Feedback</font></a	>	<cfif classified_valid IS "Yes">   <a href="<cfoutput>#varoot#</cfoutput>/classified/index.cfm" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Classified</font></a>&nbsp;   <a href="<cfoutput>#varoot#</cfoutput>/classified/search/" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Classified Search</font></a>   </CFIF>&nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/help/sitemap.cfm" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Site&nbsp;Map</font></a	> <a href="<cfoutput>#VAROOT#</cfoutput>/personal" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >My Account</a>  &nbsp;<a href="<cfoutput>#VAROOT#</cfoutput>/Classified" ><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Classifieds</a><a href="<cfoutput>#VAROOT#</cfoutput>/listings/categories/index.cfm"><font size=2 color=<cfoutput>#heading_color#</cfoutput> >Browse</font></a>&nbsp;<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq ""><a href="<cfoutput>#VAROOT#</cfoutput>/login.cfm?logout=1" ><font color=red>Logout</font></a><cfelse><a href="<cfoutput>#VAROOT#</cfoutput>/login.cfm?login=1">Login</a></cfif></b></font></TD></TR><TR><!--- Flash Header Here ---><TD><!--- disable flash banner ---><!---<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#3,0,0,0" width="400" height="70"><param name="SRC" value="http://<cfoutput>#cgi.server_name##VAROOT#</cfoutput>/VA_header.swf"><param name=bgcolor value="#003300"><embed src="http://<cfoutput>#cgi.server_name##VAROOT#</cfoutput>/VA_header.swf" pluginspage="http://www.macromedia.com/shockwave/download/" type="application/x-shockwave-flash" width="400" height="70" bgcolor="#003300" >    </embed>   </object>---><!--- use animated gif instead , less overhead ---><cfinclude template=banners1.cfm></TD><TD WIDTH=238><!--- Orange color is FF9700 ---><cfoutput><table cellspacing="0" cellpadding="2" border="0" bgcolor="#heading_color#"></cfoutput><tr><cfoutput><td valign="top" style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput><B>Search</B><table cellspacing="0" cellpadding="3" border="0" bgcolor="DDDDDD" WIDTH=220><tr><td valign="top" ><!--- Search Code Start ---> <input type=text name="search_text" size=6 maxlength="50"><input type=submit name="search" value="Search"><A HREF="<cfoutput>#VAROOT#</cfoutput>/search/index.cfm" ><FONT SIZE=1 FACE="arial,helvetica,geneva"><br>Advanced Search</FONT></A><input type="hidden" name="search_type" value="title_search"><input type="hidden" name="search_name" value="Title &amp Description Search"><input name="phrase_match" type=hidden value="any"><!--- Search Code End ---></td></tr></table></td></tr></table></TD><TR></TABLE></TD></TR></TABLE> </form></body></html></cfif><cfif #get_layout.template# eq 2>   <script language="JavaScript"><!--function MM_swapImgRestore() { //v3.0  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;}function MM_preloadImages() { //v3.0  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)    if (a[i].indexOf("")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}}function MM_findObj(n, d) { //v4.0  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);  if(!x && document.getElementById) x=document.getElementById(n); return x;}function MM_swapImage() { //v3.0  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}}//--></script><center> <cfoutput> <table cellspacing="0" cellpadding="0" border="0"><tr>    <td rowspan="2" valign=top><a href="#varoot#/index.cfm"><img src="#varoot#/logos/#get_layout.logo#" border=0 ></a></td>    <td align=right valign=bottom><b> <font color=#heading_color#><a href="#VAROOT#/personal/index.cfm" >My Account</a> | <a href="#VAROOT#/messaging/index.cfm" >Messaging</a> | <a href="#VAROOT#/help/sitemap.cfm" >Sitemap</a> | <a href="#VAROOT#/support/index.cfm" >FAQ</a> | <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq ""><a href="#VAROOT#/login.cfm?logout=1" ><font color=red>Logout</font></a><cfelse><a href="#VAROOT#/login.cfm?login=1">Login</a></cfif></font></b><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=40></td></tr><tr>    <td valign=bottom>	<table border=0 cellspacing=0 cellpadding=0>		<TR vAlign=bottom align="left">                    <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=45></TD>           <TD align="left"><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD colSpan=3><A             href="#varoot#/index.cfm"            onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','#varoot#/images/home.gif',1)" ><img name="Image1" border="0" src="#varoot#/images/<cfif #current_page# eq "indexhome">home<cfelse>home_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD colSpan=2><A             href="#varoot#/registration"             onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','#varoot#/images/register.gif',1)" ><img name="Image2" border="0" src="#varoot#/images/<cfif #current_page# eq "register">register<cfelse>register_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD colSpan=3><A             href="#varoot#/listings/categories/index.cfm?from=sell"             onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','#varoot#/images/sell.gif',1)" ><img name="Image3" border="0" src="#varoot#/images/<cfif #current_page# eq "sell">sell<cfelse>sell_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD colSpan=2><A             href="#varoot#/sellers"             onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','#varoot#/images/sellers.gif',1)" ><img name="Image4" border="0" src="#varoot#/images/<cfif #current_page# eq "sellers">sellers<cfelse>sellers_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD colSpan=2><A             href="#varoot#/buyers"            onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','#varoot#/images/buyers.gif',1)" ><img name="Image5" border="0" src="#varoot#/images/<cfif #current_page# eq "buyers">buyers<cfelse>buyers_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD colSpan=3><A             href="#varoot#/feedback/leavefeedback.cfm"            onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','#varoot#/images/feedback.gif',1)" ><img name="Image6" border="0" src="#varoot#/images/<cfif #current_page# eq "feedback">feedback<cfelse>feedback_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=1></TD>          <TD><A href="#varoot#/help"              onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','#varoot#/images/help.gif',1)" ><img name="Image7" border="0" src="#varoot#/images/<cfif #current_page# eq "help">help<cfelse>help_off</cfif>.gif"></A></TD>          <TD><IMG border=0 height=21 src="#varoot#/images/spacer.gif"         width=1></TD></TR>		</table>		</td></tr><tr>    <td colspan="2">	<table cellspacing=0 cellpadding=0>	<TR vAlign=top>          <TD><IMG border=0 height=31 name=nav_21             src="/images/left.gif" width=13></TD>          <TD bgColor=43A3F1 colSpan=29 height=31 width=726></TD>          <TD><IMG border=0 height=31 name=nav_23             src="/images/right.gif" width=11></TD>          <TD><IMG border=0 height=31 src="#varoot#/images/spacer.gif"         width=1></TD></TR>    				</table></td></tr>		</td></tr><tr>    <td>	<table border=0 cellspacing=0 cellpadding=0>	<form name="search" action="#VAROOT#/search/search_results.cfm" method="post" >		<TR vAlign=top>          <TD align=middle bgColor="43A3F1" colSpan=2 height=28 rowSpan=3           vAlign=center width=133>            <INPUT name=search type=hidden value=search>  <input type=text name="search_text" size=12 maxlength="50"><input type="hidden" name="search_type" value="title_search"><input type="hidden" name="search_name" value="Title &amp Description Search"><input name="phrase_match" type=hidden value="any"></TD>          <TD colSpan=2 height=28 rowSpan=3 width=29><INPUT border=0 cacheheight=28        onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','#varoot#/images/search_off.gif',1)"             src="/images/search.gif" name="image8" type=image width=29></TD>          <TD><IMG border=0 height=1 src="#varoot#/images/spacer.gif"         width=1></TD></TR></FORM>			</table>		</td>    <td rowspan="3"><cfinclude template="banners1.cfm"></td></tr><tr>    <td>	<table border=0 cellspacing=0 cellpadding=0><TR vAlign=top>          <TD bgColor=43A3F1 colSpan=2 height=14 vAlign=middle width=133>            <DIV ><FONT face=arial color=white size=1>&nbsp; <A             href="#varoot#/search/">Advanced             Search</A></FONT></DIV></TD>          <TD><IMG border=0 height=28              src="/images/corner_right.gif" width=27></TD>          <TD><IMG border=0 height=14 src="#varoot#/images/spacer.gif" width=1></TD></TR>     </table>		</td></tr><tr>    <td>	&nbsp;	</td></tr> </table></cfoutput></center></cfif><cfif #get_layout.template# eq 3><body bgcolor=white marginheight="0" topmargin="0" vspace="0" marginwidth="0" leftmargin="0" hspace="0" style="margin:0; padding:0"><table cellspacing="0" cellpadding="0" border="0"><tr><td colspan=2>&nbsp;</td></tr><tr>    <td rowspan="5"><a href="<cfoutput>#VAROOT#</cfoutput>/index.cfm?hit=0" ><IMG SRC="<cfoutput>#VAROOT#/logos/#get_layout.logo#</cfoutput>" border=0 alt="Auction Home"></a></td>    <td>	<cfoutput>	<table border=0 cellspacing=0 cellpadding=0>	<tr>	    <td align=right colspan=18 valign=top>	<b> <font color=43A3F1><a href="#VAROOT#/personal/index.cfm" >My Account</a> | <a href="#VAROOT#/messaging/index.cfm" >Messaging</a> | <a href="#VAROOT#/help/sitemap.cfm" >Sitemap</a> | <a href="#VAROOT#/support/index.cfm" >FAQ</a> | <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq ""><a href="#VAROOT#/login.cfm?logout=1" ><font color=red>Logout</font></a><cfelse><a href="#VAROOT#/login.cfm?login=1">Login</a></cfif></font></b></tr> <tr><td colspan=18>&nbsp;</td></tr><tr align=center><td><IMG border=0 height=21 src="#varoot#/images/spacer.gif" width=105></td> <cfif #current_page# is "indexhome"><td bgcolor=34a3f1 style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/index.cfm">.:Home:.</a></b></td><td bgcolor="34a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/index.cfm">.:Home:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><cfif #current_page#  is "register"><td style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=43a3f1 style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/registration">.:Register:.</a></b></td><td bgcolor="43a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/registration">.:Register:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><cfif #current_page# is "sell"><td style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=43a3f1 style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/listings/categories/all_cats.html">.:Sell:.</a></b></td><td bgcolor="43a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/listings/categories/all_cats.html">.:Sell:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><cfif #current_page# is "sellers"><td style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=43a3f1 style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/sellers">.:Sellers:.</a></b></td><td bgcolor="43a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/sellers">.:Sellers:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><cfif #current_page# is "buyers"><td style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=43a3f1 style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/buyers">.:Buyers:.</a></b></td><td bgcolor="43a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/buyers">.:Buyers:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><cfif #current_page# is "feedback"><td style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=43a3f1 style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/feedback/leavefeedback.cfm">.:Feedback:.</a></b></td><td bgcolor="43a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/feedback/leavefeedback.cfm">.:Feedback:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><cfif #current_page# is "help"><td style="color:white; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=43a3f1 style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/help">.:Help:.</a></b></td><td bgcolor="43a3f1"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td><cfelse><td style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td><td bgcolor=CDE0FF style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"><b><a href="#varoot#/help">.:Help:.</a></b></td><td bgcolor="CDE0FF"><img src=/images1/tri_edge.gif width=14 height=20 alt=" "></td></cfif><td align=right width=90% style="color:43A3F1; font-family:#heading_font#;font-size:#heading_font_size#px;"></td></tr></table></cfoutput>	</td></tr><tr><td nowrap><cfoutput><table border="0" width=100% cellspacing="0" cellpadding="0" bgcolor="#heading_color#"><tr><td height="15" ></td></tr></table></cfoutput></td></tr><tr>    <td><form name="search" action="<cfoutput>#VAROOT#</cfoutput>/search/search_results.cfm" method="get" ><table border=0><tr><td><cfinclude template=banners1.cfm></TD><TD WIDTH=238><!--- Orange color is FF9700 ---><cfoutput><table cellspacing="0" cellpadding="2" border="0" bgcolor="#heading_color#"></cfoutput><tr><cfoutput><td valign="top" style="color:43A3F1; font-family:#heading_font#"></cfoutput><B>Search</B><table cellspacing="0" cellpadding="3" border="0" bgcolor="DDDDDD"><tr><td valign="top" WIDTH=100%><!--- Search Code Start ---> <input type=text name="search_text" size=25 maxlength="50"><input type=submit name="search" value="Search"><A HREF="<cfoutput>#VAROOT#</cfoutput>/search/index.cfm" ><FONT SIZE=1 FACE="arial,helvetica,geneva"><br>Advanced Search</FONT></A><input type="hidden" name="search_type" value="title_search"><input type="hidden" name="search_name" value="Title &amp Description Search"><input name="phrase_match" type=hidden value="any"><!--- Search Code End ---></td></tr></table></td></tr></table></td></tr></table></form></td></tr></table></body></html></cfif><cfif #get_layout.template# eq 4><cfinclude template="temp41.cfm"></cfif>
