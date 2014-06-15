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
.flat .z2 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z2z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z1 {margin:0 5px; background:#000000;}
.flat .z2, .flat .z2z {margin:0 3px; border-width:0 2px;}
.flat .z3, .flat .z3z {margin:0 2px;}
.flat .z4, .flat .z4z {height:2px; margin:0 1px;}
.flat .z1z {margin:0 5px; background:#000000;}
.flat .boxcontent2 {display:block;  background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
/////////////////////////////////////////////////////////////////////////////////
</style>

<!--- Gallery Heading --->              <cfoutput>			  <table cellpadding=2 border=0 width="100%">                <tr>               <td WIDTH=100% align=center style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;">

<div id="container">
<div class="flat">
<b class="top"><b class="z1"></b><b class="z2"></b><b class="z3"></b><b class="z4"></b></b>
<div class="boxcontent2">
<b>Thumbnails Gallery</b>
</div>
<b class="bottom"><b class="z4z"></b><b class="z3z"></b><b class="z2z"></b>
<b class="z1z"></b></b>
</div>

</td>                </tr>              </table>			  </cfoutput>		<TABLE CELLPADDING=2 width="100%" >	 	<TR>			<TD align=center>  								<cfoutput>			<img src="#varoot#/logos/#get_layout.studio_logo#" width="277" height="197" border="0" usemap="##theInfohere" ismap><!--- was width="277" --->  			<map name="theInfohere">    		<area shape="poly" coords="0,0,100,0,0,96"  HREF="javascript:popup()">    		<area shape="poly" coords="101,0,277,0,277,197,0,197,0,97" href="../listings/Studio.cfm?/##theLink" alt="The Studio : A graphical display of auctioned items.">  			</map>			</cfoutput>			</TD>		</TR>		</table>
