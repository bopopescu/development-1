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
<table cellpadding=2  border=0 valign="top" width="100%">            <cfoutput>			<tr>               <td style="color:#heading_fcolor#; font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>			

<div id="container">
<div class="flat">
<b class="top"><b class="z1"></b><b class="z2"></b><b class="z3"></b><b class="z4"></b></b>
<div class="boxcontent2">
<b>Categories</b>
</div>
<b class="bottom"><b class="z4z"></b><b class="z3z"></b><b class="z2z"></b>
<b class="z1z"></b></b>
</div>

			   </td>            </tr>			</cfoutput>            <!--- output categories --->                      <!---  <cfsetting enablecfoutputonly="No"> --->            <cfloop query="get_Categories">              <!--- count sub category --->			  <cfquery username="#db_username#" password="#db_password#" name="get_child_count" datasource="#DATASOURCE#">    			SELECT category      			FROM categories     			WHERE parent = #category#       			AND active = 1			  </cfquery>              <!--- define info --->                            <cfif get_child_count.recordcount gt 0>                <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#category#">                <cfset dspArrow = '<img src="#VAROOT#/images/folder.gif" width=22 height=16 border=0 align=top ALT="This category contains subcategories">'>              <cfelse>                <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#category#">                <cfset dspArrow = "">              </cfif>              			<!--- don't modify this cfparam... change it in the /includes/cache_control.cfm page only! --->			<cfparam name="URL.strCaching" default="no">			<cfif URL.strCaching NEQ "no">			<!--- yes, we are caching... get count from categories table (faster) --->			<cfset total_auctions = get_categories.count_total>			<cfelse>				<!--- No page caching... get live count: --->				<!--- tally number of auctions for category --->				<cfmodule template="./functions/tallyauctions.cfm"				category="#category#"				datasource="#DATASOURCE#"				TIMENOW="#TIMENOW#">			</cfif>              			<!--- Category output is here --->			<cfoutput>			<tr>				<td>&nbsp;&nbsp;&nbsp;					<a href="#categoryLink#"><b>#Trim(name)#</b></a> #dspArrow#<font size=1>(#total_auctions#)<cfif DateDiff("d", get_Categories.date_created, TIMENOW) LTE CategoryNew.days> &nbsp;<font color=ff0000>NEW</font></cfif></font>				</td>			</tr>			</cfoutput>            </cfloop>			           <!---  <cfsetting enablecfoutputonly="No"> --->			<tr>				<td>&nbsp;&nbsp;&nbsp;	<cfoutput><a href="#VAROOT#/listings/categories/index.cfm"><font size=1><b>View All Categories</b></font></a></cfoutput>				</td>            </tr>            </table>

