<CFQUERY NAME="GetRandProd3" datasource="#datasource#"  maxrows=2>
SELECT *
FROM news
order by newid()
</CFQUERY>
<cfoutput>
<!--- start cutting --->
	<td bgcolor="FFFFFF" width="548"><div align="center"><img src="images/m_top.gif" width="548" height="8" alt="" border="0"></div>
<p class="px5">
<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center" height="25" background="">
<tr>
	<td>
<table border="0" cellpadding="0" cellspacing="0" background="" bgcolor="FFFFFF">
<tr>
	<td><img src="images/e03.gif" width="21" height="21" alt="" border="0" align="left"></td>
	<td><p class="bar01" style="color: DA0008; font-size: 18px;">Hot Auctions&nbsp;</p></td>
</tr>
</table>
	</td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="0" align="center">
<tr valign="top">

<!--- start here --->

<cfif #get_hotauctions.recordcount#>

<cfloop query ="get_hotauctions">
<CFQUERY NAME="Getstatus" datasource="#datasource#"  >
SELECT * from
items where itemnum=#itemnum#
</CFQUERY>
	<td <cfif #get_hotauctions.recordcount# eq 1>align=center</cfif>>
<!-- left -->
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><img src="../images/t_11.gif" width="10" height="9" alt="" border="0"></td>
	<td background="../images/t_13.gif"><img src="../images/t_12.gif" width="6" height="9" alt="" border="0"></td>
	<td background="../images/t_13.gif" align="right"><img src="../images/t_14.gif" width="6" height="9" alt="" border="0"></td>
	<td><img src="../images/t_15.gif" width="10" height="9" alt="" border="0"></td>
</tr>
<tr valign="top">
	<td background="../images/t_fon_left.gif"><img src="../images/t_21.gif" width="10" height="6" alt="" border="0"></td>
	<td rowspan="2" colspan="2">
<!-- in -->
<cfset Img_width=124>
<cfset Img_height=110>
 <cfset thePath = #GetDirectoryFromPath(GetTemplatePath())#&"Thumbs\">
<table border="0" cellpadding="0" cellspacing="0" width="160">
<tr>
	<td><a href="listings/details/index.cfm?itemnum=#itemnum#">
<!---<img src="" alt="" width="58" height="54" border="0">--->
<cfif fileExists("#thePath##itemnum#.jpg")>
	 <!--- <CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.jpg"> --->
	<cfif img_height is "" or img_width is "">
		<IMG width=58 height=54 src="#varoot#/thumbs/#itemnum#.jpg" border=0>
	<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 58>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 58>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>

		<IMG width=#width# height=#height# src="#varoot#/thumbs/#itemnum#.jpg" border=0>
</cfif>
<cfelseif fileExists("#thePath##itemnum#.gif")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.gif">--->
	<cfif img_height is "" or img_width is "">
		<IMG width=58 height=54 src="#varoot#/thumbs/#itemnum#.gif" border=0>
	<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 58>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 58>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>

		<IMG width=#width# height=#height# src="#varoot#/thumbs/#itemnum#.gif" border=0>
</cfif>
<cfelse>
<IMG width=58 height=54 src="#varoot#/images/default.gif" border=0>
</cfif>


</a></td>
	<td>
<p style="color: 1F86DE; font-size: 9px; padding-bottom: 0px;"><b>#left(trim(getstatus.title),7)#...</b></p>
<p>#left(trim(getstatus.description),7)#...</p>
<p style="color: DA0008; font-size: 8px; padding-bottom: 5px;"><a href="listings/details/index.cfm?itemnum=#itemnum#"><b>#dollarformat(getstatus.minimum_Bid)#</b></a></p>
	</td>
</tr>
</table>
<!-- /in -->
	</td>
	<td background="../images/t_fon_right.gif"><img src="../images/t_23.gif" width="10" height="6" alt="" border="0"></td>
</tr>
<tr valign="bottom">
	<td background="../images/t_fon_left.gif"><img src="../images/t_31.gif" width="10" height="7" alt="" border="0"></td>
	<td background="../images/t_fon_right.gif"><img src="../images/t_33.gif" width="10" height="7" alt="" border="0"></td>
</tr>
<tr>
	<td><img src="../images/t_41.gif" width="10" height="10" alt="" border="0"></td>
	<td background="../images/t_fon_bot.gif"><img src="../images/t_42.gif" width="6" height="10" alt="" border="0"></td>
	<td background="../images/t_fon_bot.gif" align="right"><img src="../images/t_44.gif" width="6" height="10" alt="" border="0"></td>
	<td ><img src="../images/t_45.gif" width="10" height="10" alt="" border="0"></td>
</tr>
</table>
<!-- /left -->
	</td>


</cfloop>


<cfelse>
<td>&nbsp;No hot auctions available</td>
</cfif>
<!--- end 1 --->


</tr>

<tr><td>
<p class="b01"><img src="/images/e02.gif" width="6" height="5" alt="" border="0" align="absmiddle">&nbsp;&nbsp;
<a href="#varoot#/listings/hotitems"><font size=1><b>View All Hot Auctions</b></font></a>
<div align="center"><img src="/images/hr01.gif" width="137" height="3" alt="" border="0"></div>
</td>
</tr>



<!---	<td><p class="bar01" style="color: DA0008; font-size: 18px;">Hot Auctions &nbsp;</p></td>
</tr>
</table>
	</td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="0" align="center">
<tr valign="top"><!--- start --->
<cfif #get_hotauctions.recordcount#>

<cfloop query ="get_hotauctions">
<cfquery name="getstatus" datasource="#datasource#">

select * from items where itemnum = #itemnum#
</cfquery>

	<td <cfif #get_hotauctions.recordcount# eq 1>align=center</cfif>>
<!-- left -->
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><img src="../images/t_11.gif" width="10" height="9" alt="" border="0"></td>
	<td background="../images/t_13.gif"><img src="../images/t_12.gif" width="6" height="9" alt="" border="0"></td>
	<td background="../images/t_13.gif" align="right"><img src="../images/t_14.gif" width="6" height="9" alt="" border="0"></td>
	<td><img src="../images/t_15.gif" width="10" height="9" alt="" border="0"></td>
</tr>
<tr valign="top">
	<td background="../images/t_fon_left.gif"><img src="../images/t_21.gif" width="10" height="6" alt="" border="0"></td>
	<td rowspan="2" colspan="2">
<!-- in -->
<table border="0" cellpadding="0" cellspacing="0" width="255">
<tr>
	<td><!---<img src="" width="124" height="92" alt="" border="0">--->
 <cfset thePath = #GetDirectoryFromPath(GetTemplatePath())#&"Thumbs\">
<table border="0" cellpadding="0" cellspacing="0" width="160">
<tr>
	<td><a href="listings/details/index.cfm?itemnum=#itemnum#">
<!---<img src="" alt="" width="58" height="54" border="0">--->
<cfif fileExists("#thePath##itemnum#.jpg")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.jpg">--->
	<cfif img_height is "" or img_width is "">
		<IMG width=124 height=92 src="#varoot#/thumbs/#itemnum#.jpg" border=0>&nbsp;
	<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 124>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 124>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>

		<IMG width=#width# height=#height# src="#varoot#/thumbs/#itemnum#.jpg" border=0>&nbsp;
</cfif>
<cfelseif fileExists("#thePath##itemnum#.gif")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.gif">--->
	<cfif img_height is "" or img_width is "">
		<IMG width=124 height=92 src="#varoot#/thumbs/#itemnum#.gif" border=0>&nbsp;
	<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 124>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 124>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>

		<IMG width=#width# height=#height# src="#varoot#/thumbs/#itemnum#.gif" border=0>&nbsp;


</cfif>
<cfelse>
<IMG width=124 height=92 src="#varoot#/images/default.gif" border=0>
</cfif>

</a>
</td>
	<td>
<p style="color: 1F86DE; font-size: 10px; padding-bottom: 0px;"><b>#left(trim(getstatus.title),9)#</b></p>
<p>#left(trim(getstatus.description),15)#</p>
<p style="color: DA0008; font-size: 8px; padding-bottom: 5px;"><b>#dollarformat(getstatus.minimum_bid)#</b></p>
	</td>
</tr>
</table>

<div align="right">
<table><tr><!---<td width=50%>
<cfif getstatus.buynow><a href="listings/details/index.cfm?itemnum=#itemnum###bid">
<img SRC="#varoot#/images/b_buy.gif" width="45" height="24" alt="" border="0" ALT="Order"></a></cfif>
</td>---><td width=50% valign=top><a href="
listings/details/index.cfm?itemnum=#itemnum#"><img src="#varoot#/images/b_det.gif"  alt="" border="0"></a>&nbsp;
</td>
</tr>
</table>
</div>
<!-- /in -->
	</td>
	<td background="../images/t_fon_right.gif"><img src="../images/t_23.gif" width="10" height="6" alt="" border="0"></td>
</tr>
<tr valign="bottom">
	<td background="../images/t_fon_left.gif"><img src="../images/t_31.gif" width="10" height="7" alt="" border="0"></td>
	<td background="../images/t_fon_right.gif"><img src="../images/t_33.gif" width="10" height="7" alt="" border="0"></td>
</tr>
<tr>
	<td><img src="../images/t_41.gif" width="10" height="10" alt="" border="0"></td>
	<td background="../images/t_fon_bot.gif"><img src="../images/t_42.gif" width="6" height="10" alt="" border="0"></td>
	<td background="../images/t_fon_bot.gif" align="right"><img src="../images/t_44.gif" width="6" height="10" alt="" border="0"></td>
	<td ><img src="../images/t_45.gif" width="10" height="10" alt="" border="0"></td>
</tr>
</table>
<!-- /left -->
	</td>

</cfloop>
<cfelse>

<td>&nbsp;No hot auctions available</td>

</cfif> --->
<!--- end --->
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center" height="25" background="">
<tr>
	<td>
<table border="0" cellpadding="0" cellspacing="0" background="" bgcolor="FFFFFF">
<tr>
	<td><img src="../images/e04.gif" width="21" height="21" alt="" border="0" align="left"></td>
	<td><p class="bar01" style="color: 3466DE; font-size: 18px;">Featured Auctions&nbsp;</p></td>
</tr>
</table>
	</td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="0" align="center">
<tr valign="top">

<!--- start here --->

<cfif #get_featured.recordcount#>

<cfloop query ="get_featured">

	<td <cfif #get_featured.recordcount# eq 1>align=center</cfif>>
<!-- left -->
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><img src="../images/t_11.gif" width="10" height="9" alt="" border="0"></td>
	<td background="../images/t_13.gif"><img src="../images/t_12.gif" width="6" height="9" alt="" border="0"></td>
	<td background="../images/t_13.gif" align="right"><img src="../images/t_14.gif" width="6" height="9" alt="" border="0"></td>
	<td><img src="../images/t_15.gif" width="10" height="9" alt="" border="0"></td>
</tr>
<tr valign="top">
	<td background="../images/t_fon_left.gif"><img src="../images/t_21.gif" width="10" height="6" alt="" border="0"></td>
	<td rowspan="2" colspan="2">
<!-- in -->

 <cfset thePath = #GetDirectoryFromPath(GetTemplatePath())#&"Thumbs\">
<table border="0" cellpadding="0" cellspacing="0" width="160">
<tr>
	<td><a href="listings/details/index.cfm?itemnum=#itemnum#">
<!---<img src="" alt="" width="58" height="54" border="0">--->
<cfif fileExists("#thePath##itemnum#.jpg")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.jpg">--->
	<cfif img_height is "" or img_width is "">
		<IMG width=58 height=54 src="#varoot#/thumbs/#itemnum#.jpg" border=0>
	<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 58>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 58>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>

		<IMG width=#width# height=#height# src="#varoot#/thumbs/#itemnum#.jpg" border=0>
</cfif>
<cfelseif fileExists("#thePath##itemnum#.gif")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.gif">--->
	<cfif img_height is "" or img_width is "">
		<IMG width=58 height=54 src="#varoot#/thumbs/#itemnum#.gif" border=0>
	<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 58>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 58>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>

		<IMG width=#width# height=#height# src="#varoot#/thumbs/#itemnum#.gif" border=0>


</cfif>
<cfelse>
<IMG width=58 height=54 src="#varoot#/images/default.gif" border=0>
</cfif>


</a></td>
	<td>
<p style="color: 1F86DE; font-size: 9px; padding-bottom: 0px;"><b>#left(trim(title),7)#...</b></p>
<p>#left(trim(description),7)#...</p>
<p style="color: DA0008; font-size: 8px; padding-bottom: 5px;"><a href="listings/details/index.cfm?itemnum=#itemnum#"><b>#dollarformat(minimum_Bid)#</b></a></p>
	</td>
</tr>
</table>
<!-- /in -->
	</td>
	<td background="../images/t_fon_right.gif"><img src="../images/t_23.gif" width="10" height="6" alt="" border="0"></td>
</tr>
<tr valign="bottom">
	<td background="../images/t_fon_left.gif"><img src="../images/t_31.gif" width="10" height="7" alt="" border="0"></td>
	<td background="../images/t_fon_right.gif"><img src="../images/t_33.gif" width="10" height="7" alt="" border="0"></td>
</tr>
<tr>
	<td><img src="../images/t_41.gif" width="10" height="10" alt="" border="0"></td>
	<td background="../images/t_fon_bot.gif"><img src="../images/t_42.gif" width="6" height="10" alt="" border="0"></td>
	<td background="../images/t_fon_bot.gif" align="right"><img src="../images/t_44.gif" width="6" height="10" alt="" border="0"></td>
	<td ><img src="../images/t_45.gif" width="10" height="10" alt="" border="0"></td>
</tr>
</table>
<!-- /left -->
	</td>


</cfloop>


<cfelse>
<td>&nbsp;No featured auctions available</td>
</cfif>
<!--- end 1 --->


</tr>
<tr><td>
<p class="b01"><img src="/images/e02.gif" width="6" height="5" alt="" border="0" align="absmiddle">&nbsp;&nbsp;
<a href="/listings/featured"><font size=1><b>View All Featured Auctions</b></font></a>
<div align="center"><img src="/images/hr01.gif" width="137" height="3" alt="" border="0"></div>
</td>
</tr>


</table>
<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center" height="25" background="">
<tr>
	<td>
<table border="0" cellpadding="0" cellspacing="0" background="" bgcolor="FFFFFF">
<tr>
	<td><img src="../images/e05.gif" width="21" height="21" alt="" border="0"></td>
	<td><a name="news"><p class="bar01" style="color: 4AC250; font-size: 18px;">Top News&nbsp;</p></td>
</tr>
</table>
	</td>
</tr>
</table>
<p class="px5">
<table border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
<!--- start --->

<cfif #getrandprod3.recordcount#>
<cfloop query="getrandprod3">

	<td <cfif #getrandprod3.recordcount# eq  2>width="275"</cfif>>
<p class="left"><img src="../images/dot_b.gif" width="5" height="5" alt="" border="0" align="absmiddle">&nbsp;&nbsp;<b>#left(trim(TITLE),15)#...</b></p>
<p class="left">#left(trim(NEWS),100)#...</p>
<p class="left"><a href="news2.cfm?id=#id#">Read More</a></p>
	</td>
	<td bgcolor="979797"><img src="../images/px1.gif" width="1" height="1" alt="" border="0"></td>

</cfloop>
<cfelse>
<td>&nbsp;No news available.</td>
</cfif>
</tr>
</table>
<!--- start cutting --->
<br>
<center>
</cfoutput>