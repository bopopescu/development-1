
<!--- This page is no longer used.  Forward to index in theis same folder (categories) --->
<cflocation url = "index.cfm">
<!--- ********************************************************* --->

 <cfinclude template="../../includes/app_globals.cfm">

<cfquery name="GetCategory" dataSource="#datasource#">
    SELECT category, parent, name
    FROM categories
	WHERE parent >= 0
    GROUP BY parent, category, name
</cfquery>
<cfset catArray = arraynew(1)>
<cfloop query="GetCategory">
<!---	<cfset catArray[CurrentRow] = "#category#|#parent#|#name# [post here]|/sell/index.cfm?category=#category#"> --->
<cfset catArray[CurrentRow] = "#category#|#parent#|#name#|/sell/index.cfm?cat=#category#">
</cfloop>


  <!--
  Visual Auction 10.0 Copyright 2010 Beyond Solutions, Inc.  All Rights Reserved.
  WWW: http://www.beyondsolutions.com/
  Sales: sales@beyondsolutions.com
  Tech-Support: support@beyondsolutions.com
  -->

  <html>
<head>
  <title>Categories</title>

  <link rel=stylesheet href="/includes/stylesheet.css" type="text/css">

  </title>
</head>

  <body bgcolor='ffffff'>
<head>

 <link rel=stylesheet href="/includes/stylesheet.css"  type="text/css"> 
<script type="text/Javascript">
<!--
var tpcursive = "-117px"
var tparial = "-115px"

//alert(navigator.userAgent);

if (navigator.userAgent.indexOf("Firefox/3") != -1) {
var tpcursive = "-129px"
var tparial = "-127px"
}if (navigator.userAgent.indexOf("Safari") != -1) {
var tpcursive = "-128px"
var tparial = "-126px"
}

function ShowText() {
document.getElementById("ButtonText").style.fontFamily = "arial";
document.getElementById("ButtonText").style.color = "ffffff";
document.getElementById("ButtonText").style.fontSize = "12";;
//alert(document.getElementById("ButtonText").style.top);
if (document.getElementById("ButtonText").style.fontFamily == "cursive" || document.getElementById("ButtonText").style.fontFamily == "arial black") {
document.getElementById("ButtonText").style.top = tpcursive;
}
else {document.getElementById("ButtonText").style.top = tparial;}
}

function ColorOver01(){
document.getElementById("ButtonText01").style.color = "ff8000";
}
function ColorOut01(){
document.getElementById("ButtonText01").style.color = "ffffff";
}
function ColorOver1a(){
document.getElementById("ButtonText1a").style.color = "ff8000";
}
function ColorOut1a(){
document.getElementById("ButtonText1a").style.color = "ffffff";
}
function ColorOver1(){
document.getElementById("ButtonText1").style.color = "ff8000";
}
function ColorOut1(){
document.getElementById("ButtonText1").style.color = "ffffff";
}
function ColorOver2(){
document.getElementById("ButtonText2").style.color = "ff8000";
}
function ColorOut2(){
document.getElementById("ButtonText2").style.color = "ffffff";
}
function ColorOver3(){
document.getElementById("ButtonText3").style.color = "ff8000";
}
function ColorOut3(){
document.getElementById("ButtonText3").style.color = "ffffff";
}
function ColorOver4(){
document.getElementById("ButtonText4").style.color = "ff8000";
}
function ColorOut4(){
document.getElementById("ButtonText4").style.color = "ffffff";
}
function ColorOver5(){
document.getElementById("ButtonText5").style.color = "ff8000";
}
function ColorOut5(){
document.getElementById("ButtonText5").style.color = "ffffff";
}
function ColorOver6(){
document.getElementById("ButtonText6").style.color = "ff8000";
}
function ColorOut6(){
document.getElementById("ButtonText6").style.color = "ffffff";
}
function ColorOver7(){
document.getElementById("ButtonText7").style.color = "ff8000";
}
function ColorOut7(){
document.getElementById("ButtonText7").style.color = "ffffff";
}
function ColorOver8(){
document.getElementById("ButtonText8").style.color = "ff8000";
}
function ColorOut8(){
document.getElementById("ButtonText8").style.color = "ffffff";
}
function ColorOver9(){
document.getElementById("ButtonText9").style.color = "ff8000";
}
function ColorOut9(){
document.getElementById("ButtonText9").style.color = "ffffff";
}
function ColorOver10(){
document.getElementById("ButtonText10").style.color = "ff8000";
}
function ColorOut10(){
document.getElementById("ButtonText10").style.color = "ffffff";
}function ColorOver11(){
document.getElementById("ButtonText11").style.color = "ff8000";
}
function ColorOut11(){
document.getElementById("ButtonText11").style.color = "ffffff";
}function ColorOver12(){
document.getElementById("ButtonText12").style.color = "ff8000";
}
function ColorOut12(){
document.getElementById("ButtonText12").style.color = "ffffff";
}
-->
</script>

<style type="text/css">

#ButtonText01 {
	position: relative;
	text-align: left;
	font-family:arial;
	font-size:9px;
	font-weight:bold;
	color:#ffffff;
	padding-bottom : 11px;
}

 
#ButtonText1a {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText1 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText2 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText3 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText4 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText5 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText6 {
position: relative;
text-align: right;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText7 {
position: relative;
text-align: right;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText8 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText9 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText10 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText11 {
position: relative;
text-align: center;
font-family:arial;
font-size:12;
font-weight:bold;
color:#ffffff;
padding-top : 3px;

}  
#ButtonText12 {
	position: relative;
	text-align: center;
	font-family:arial;
	font-size:12;
	font-weight:bold;
	color:#ffffff;
	padding-top : 3px;
	
}    


</style>
<link rel="StyleSheet" href="../tree/tree.css" type="text/css">
<script type="text/javascript" src="../../tree/tree.js"></script>
<cfoutput>
	<script type="text/javascript">
		var Tree = new Array;
		
		var a = #GetCategory.recordCount#;
		
		<cfset a = 0>
		<cfloop array=#catArray# index="name">
			Tree[#a#] = "#name#";
			<cfset a = #a# + 1>
		</cfloop>
	</script>
</cfoutput>
</head>

<body bgcolor="ffffff" text="000000" marginheight="0" topmargin="0" vspace="0" marginwidth="0" leftmargin="0" hspace="0" style="margin:0; padding:0;font-family:arial" onload="ShowText();">

<form name="search" action="/search/search_results.cfm" method="get" >
<div align="center">
<table border="0" cellspacing="0" cellpadding="0">
	<tr>
    	<td align=center><a href="/index.cfm?hit=0"><IMG SRC="/logos/VALogo.jpg" width=1003 border=0 alt="Auction Home"></a></td>
   	</tr>
	<tr>
    	<td valign=top align=center bgcolor="02254D">
			<table width=100% border="0" cellspacing="0" cellpadding="3">
				<tr>
                	<td align=left valign=middle>&nbsp;&nbsp;&nbsp;
                        <B><font face=arial color=ffffff>Search</font></B> 
                        <input type=text name="search_text" size=50 maxlength="50" value="">
                        <input type=submit name="search" value="Search">
                            <A HREF="/search/index.cfm"> 
                                &nbsp;&nbsp;
                                <FONT id="ButtonText01" style="color:#ffffff; position:relative;cursor:hand;" onmouseover="ColorOver01()" onmouseout="ColorOut01()">
                                <b>Advanced Search</b></FONT>
                            </A>
                        <input type="hidden" name="search_type" value="title_search">
                        <input type="hidden" name="search_name" value="Title &amp Description Search">
                        <input name="phrase_match" type=hidden value="any">
					</td>
                    <td aligh=right>
                    	<div align="right">
                            <a href="/classified/search/" >
                                <font id="ButtonText7" style="color:#ffffff; position:relative;cursor:pointer;" align="right" onmouseover="ColorOver7()" onmouseout="ColorOut7()">
                                Classified Search</font></a>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="/classified/index.cfm" >
                                <font id="ButtonText6" style="color:#ffffff; position:relative;cursor:pointer;" align="right" onmouseover="ColorOver6()" onmouseout="ColorOut6()">
                            Classified Ads</font></a>&nbsp;&nbsp;
                        </div>
					</td>
             	</tr>
			</table>
		</td>
	</tr>
	<tr>
    	<td>
			<table border="0" cellspacing="0" cellpadding="0" width=100%>
				<tr>
					<td valign=middle align=left width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
							<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
							<a  href="/index.cfm"><div id="ButtonText1a" style="color:#ffffff; position:relative;cursor:pointer;" 
                            	align="center" onMouseOver="ColorOver1a()" onMouseOut="ColorOut1a()">Home</div></a>
                     	</div>
					</td>
					<td valign=middle align=left width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
							<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
							<a href="/registration/index.cfm">
                            <div id="ButtonText1" style="color:#ffffff; position:relative;cursor:pointer;" align="center" onMouseOver="ColorOver1()" onMouseOut="ColorOut1()">
                            	Register</div></a>
                            </div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
						<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="/sellers/" ><div id="ButtonText2" style="color:#ffffff; position:relative;cursor:pointer;" 
                        	align="center" onMouseOver="ColorOver2()" onMouseOut="ColorOut2()">Sell</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
						<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="/help/" ><div id="ButtonText3" style="color:#ffffff; position:relative;cursor:pointer;" 
                        	align="center" onMouseOver="ColorOver3()" onMouseOut="ColorOut3()">Help</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
							<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
							<a href="/messaging/" ><div id="ButtonText4" style="color:#ffffff; position:relative;cursor:pointer;" 
                            	align="center" onMouseOver="ColorOver4()" onMouseOut="ColorOut4()">Messaging</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
							<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
							<a href="/feedback/leavefeedback.cfm"><div id="ButtonText5" style="color:#ffffff; position:relative;cursor:pointer;" 
                            	align="center" onMouseOver="ColorOver5()" onMouseOut="ColorOut5()">Feedback</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
							<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
							<a href="/help/sitemap.cfm" ><div id="ButtonText8" style="color:#ffffff; position:relative;cursor:pointer;" 
                            	align="center" onMouseOver="ColorOver8()" onMouseOut="ColorOut8()">Site&nbsp;Map</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
						<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="/personal">
                        <div id="ButtonText9" style="color:#ffffff; position:relative;cursor:pointer;" align="center" onMouseOver="ColorOver9()" onMouseOut="ColorOut9()">
                        	My&nbsp;Account</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
						<img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="/listings/categories/index.cfm"><div id="ButtonText10" style="color:#ffffff; position:relative;cursor:pointer;" 
                        	align="center" onMouseOver="ColorOver10()" onMouseOut="ColorOut10()">
                        Browse</div></a></div>
					</td>
					<td valign=middle align=left  width="98" height="29" bgcolor="02254D">
						<div style="position:relative;">
                            <img src="/buttons/buttonbardkblue.gif" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
                            <a href="/login.cfm?login=1">
                            <div id="ButtonText12" style="color:#ffffff; position:relative;cursor:pointer;" 
                                align="center" onMouseOver="ColorOver12()" onMouseOut="ColorOut12()">
                                Login
                            </div></a>
                       	</div>
					</td>
				</tr>
			</table>
      	</td>
	</tr>
</table>
</div>
</form>

<div style="font-family:arial;font-size:14px;" align="center">
</div>
<center>

<table border=0 cellspacing=0 cellpadding=0 noshade width=500>
	<tr>
    	<td width=500 valign=top>    
			<table border="1" cellspacing="0" cellpadding="0" width="495">
				<tr bgcolor="6B85B6">
                	<td style="font-family:arial; color:ffffff">
  						<B><font size="4">All Categories:</font></B>
					</td>
              	</tr>
				<tr>
                	<td>
						<div class="tree">
							<script type="text/javascript">
							
								createTree(Tree);
							
							</script>
						</div>
					</td>
             	</tr>
     		</table>
</center>
    	</td>
        
        <td width=250 valign=top>&nbsp;       
        </td>
	</tr>
</TABLE>

</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
	<tr>
    	<td colspan=2>
            <center>
			<br>
			            <hr size=1 color=6B85B6 width=100%>
            
            </center>
            
                  <center>
                    <br>

                  </center>
                
            <font size=2>
 

<br>
              

<center>
<font size=1>
<font color=red><b>15</b> </font><font color= green size=3><b>users online</b></font>:<font color=000000><b><i><a href="/messaging/index.cfm?user_id=920710318">920710318</a></i></b></font>,<br><br><font color=000000><font color=000000><a href="/index.cfm">Home</a> |&nbsp;<a href="/help/index.cfm">Help</a> |&nbsp;<a href="/registration">Registration</a> |&nbsp;<a href="/login.cfm?login=1">Login</a>|&nbsp;<a href="/support">FAQ</a>|&nbsp;<a href="/help/sitemap.cfm">Site map</a>|&nbsp;<a href="/contactus.cfm">Contact Us</a>|&nbsp;<a href="/aboutus.cfm">About Us</a> |&nbsp;<a href="/privacy.cfm">Privacy</a> |&nbsp;<a href="/terms.cfm">Terms and conditions</a>|&nbsp;<a href="/help/fee_schedule.cfm">Fees</a>|&nbsp;<a href="/send.cfm">Suggest a Category</a>  
|&nbsp;<a href="/reportfraud.cfm">Report Fraud</a>   
|&nbsp;<a href="http://babelfish.altavista.com" target=_blank>Translate This Page</a>  <br>Copyright &copy; 2010 Your Company <i>All Rights Reserved.</i><br>Use of this Web site constitutes acceptance of the <a href="/registration/user_agreement.cfm">User Agreement</a>.<br><br>VisualAuction Copyright © 1997-2010 <a href="http://www.beyondsolutions.com/">Beyond Solutions Inc.</a>  <i>All Rights Reserved.</i><br></font>

</font></center>



              <br>
            </font>
          </tr>
        </tr>
      </table>
    </center>
  </body>
</html>



