<style type="text/css"> 
/////////////////////////////////////////////////////////////////////////////////
#container h3 {clear:both; margin-top:4em;}
/* Set Flat Header Width Below */
.flat {background: transparent; width:315px; margin:0 auto;}
.flat h1, .flat p {margin:0 10px;}
.flat h1 {font-size:20px; color:#000000; letter-spacing:1px; font-family:arial}
.flat p {padding-bottom:0.5em;}
.flat .top, .flat .bottom {display:block; background:transparent; font-size:1px;}
.flat .z1, .flat .z2, .flat .z3, .flat .z4, .flat .z1z, .flat .z2z, .flat .z3z, .flat .z4z {display:block; overflow:hidden;}
.flat .z1, .flat .z2, .flat .z3, .flat .z1z, .flat .z2z, .flat .z3z {height:1px;}
.flat .z2 {background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3 {background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4 {background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4z {background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3z {background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z2z {background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z1 {margin:0 5px; background:#000000;}
.flat .z2, .flat .z2z {margin:0 3px; border-width:0 2px;}
.flat .z3, .flat .z3z {margin:0 2px;}
.flat .z4, .flat .z4z {height:2px; margin:0 1px;}
.flat .z1z {margin:0 5px; background-color:#000000;}
.flat .boxcontent2 {display:block;  background-color:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
/////////////////////////////////////////////////////////////////////////////////
</style>
<!--- Featured Auctions Heading --->			<cfoutput>			<table cellpadding=2 border=0 width=100%>              <tr>                <td  style="color:#heading_fcolor#; font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>

<div id="container">
<div class="flat">
<b class="top"><b class="z1"></b><b class="z2"></b><b class="z3"></b><b class="z4"></b></b>
<div class="boxcontent2">
<b>Featured Auctions</b>
</div>
<b class="bottom"><b class="z4z"></b><b class="z3z"></b><b class="z2z"></b>
<b class="z1z"></b></b>
</div>

</td>              </tr>            </table>			</cfoutput>            <!--- output featured auctions --->           <!---  <cfsetting enablecfoutputonly="No"> --->              <cfif get_Featured.RecordCount IS 0>                <cfoutput>                  <br>                  <br>                  <center>                    <font size=2>Sorry, no featured auctions at this time.</font>                  </center>                </cfoutput>              <cfelse>                <cfif #get_thumbsMode.show_thumbs# IS 1>                  <cfoutput>			<!--- Featured Auctions Table --->			<table border=0 cellspacing=0 cellpadding=5 noshade width="100%"></cfoutput>                  <cfset counter=1>                  <cfoutput><tr>                  <cfloop query="get_Featured">
<cfquery name="getstatus"  datasource="#datasource#">

select * from items where itemnum = #itemnum#
</cfquery>
<cfset Img_width=124>
<cfset Img_height=110>


                    <cfif auction_mode is 1>                      <cfset reverse = '<IMG SRC="../images/R_reverse.gif" width=22 height=17 border=0 alt="This is a Reverse Auction">'>                    <cfelse>                      <cfset reverse = "">                    </cfif>                    <td valign="bottom" <cfif featcolspage gt 1>align=center</cfif>>                                        <cfset thePath = #GetDirectoryFromPath(GetTemplatePath())#&"Thumbs\"> <cfif fileExists("#thePath##itemnum#.jpg")>	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.jpg">--->	<cfif img_height is "" or img_width is "">		<cfif featcolspage gt 1>		<table><tr><td align=center width=124><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#"><IMG width=124  src="#varoot#/thumbs/#itemnum#.jpg" border=0></a></td></tr></table>		<cfelse>		<IMG width=124 src="#varoot#/thumbs/#itemnum#.jpg" border=0>&nbsp;		</cfif>	<cfelse>	  <cfif img_height gt img_width>	  	<cfset width = (Img_width/Img_height) * 124>	  	<cfset height = (Img_height/Img_width) * width>	  <cfelse>	  	<cfset height = (Img_height/Img_width) * 124>	  	<cfset width = (Img_width/Img_height) * height>	  </cfif>	  <cfif featcolspage gt 1>      <table><tr><td align=center width=124 ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#"><IMG src="#varoot#/thumbs/#itemnum#.jpg" width="#width#" border=0></a></td></tr></table>	  <cfelse>	  <IMG src="#varoot#/thumbs/#itemnum#.jpg" width="#width#" border=0>&nbsp;	  </cfif>	</cfif> <cfelseif fileExists("#thePath##itemnum#.gif")>	<!---<CFX_GIFGD ACTION="READ" FILE="#thePath##itemnum#.gif">--->	<cfif img_height is "" or img_width is "">		<cfif featcolspage gt 1>		<table><tr><td align=center width=124 ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#"><IMG width=124  src="#varoot#/thumbs/#itemnum#.gif" border=0></a></td></tr></table>		<cfelse>		<IMG width=124 src="#varoot#/thumbs/#itemnum#.gif" border=0>&nbsp;		</cfif>	<cfelse>	  <cfif img_height gt img_width>	  	<cfset width = (Img_width/Img_height) * 124>	  	<cfset height = (Img_height/Img_width) * width>	  <cfelse>	  	<cfset height = (Img_height/Img_width) * 124>	  	<cfset width = (Img_width/Img_height) * height>	  </cfif>	  <cfif featcolspage gt 1>      <table><tr><td align=center width=124 ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#"><IMG src="#varoot#/thumbs/#itemnum#.gif" width="#width#" border=0></a></td></tr></table>	  <cfelse>	  <IMG src="#varoot#/thumbs/#itemnum#.gif" width="#width#" border=0>&nbsp;	  </cfif>	</cfif> <cfelse>   <!--- No Thumbnail ---> </cfif>                      <a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#">                      <cfif getstatus.bold_title><b></cfif>#Trim(getstatus.title)#<cfif getstatus.bold_title></b></cfif></a></font>#reverse#                    <cfif counter eq featcolspage>                      <cfset counter=1>                      </td></tr>					  <tr>                    <cfelse>					  <td>                      <cfset counter=counter+1>                      </td>                    </cfif>                  </cfloop>				  </tr>				  	<cfif featcolspage gt 1><cfset featcolspan = featcolspage * 2></cfif>                    <tr><td <cfif featcolspage gt 1>colspan="#featcolspan#"</cfif>>&nbsp;<a href="#VAROOT#/listings/featured/index.cfm"><font size=1><b>&nbsp;&nbsp;&nbsp;View All Featured Auctions</b></font></a></td></tr>                    </table>                  </cfoutput>                <cfelse>                  <cfoutput>                    <table border=0 cellspacing=0 cellpadding=0 noshade width="100%"><!--- </cfoutput> --->                    <cfloop query="get_Featured">                      <cfif auction_mode is 1>                        <cfset reverse = '<IMG SRC="../images/R_reverse.gif" width=22 height=17 border=0 alt="This is a Reverse Auction">'>                      <cfelse>                        <cfset reverse = "">                      </cfif>                      <tr><td><font size=3><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#">                      <cfif getstatus.bold_title><b></cfif>#Trim(getstatus.title)#<cfif getstatus.bold_title></cfif></a></font>#reverse#                      </td></tr>                    </cfloop>                    <tr><td>&nbsp;<a href="#VAROOT#/listings/featured/index.cfm"><font size=1><b>View All Featured Auctions</b></font></a></td></tr>                    </table>                  </cfoutput>                </cfif>              </cfif>			  			  <!--- end output featured auctions --->
