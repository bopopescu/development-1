


<cfset button_list = "buttonsquareltblue.gif,buttonsquaredkblue.gif,buttonsquareltred.gif,buttonsquaredkred.gif,buttonsquareltgreen.gif,buttonsquaredkgreen.gif,buttonsquareltyellow.gif,buttonsquaredkyellow.gif,buttonsquareltbrown.gif,buttonsquaredkbrown.gif,buttonsquaregray.gif,buttonroundltblue.gif,buttonrounddkblue.gif,buttonroundltred.gif,buttonrounddkred.gif,buttonroundltgreen.gif,buttonrounddkgreen.gif,buttonroundltyellow.gif,buttonrounddkyellow.gif,buttonroundltbrown.gif,buttonrounddkbrown.gif,buttonroundgray.gif,buttonbarltblue.gif,buttonbardkblue.gif,buttonbarltred.gif,buttonbardkred.gif,buttonbarltgreen.gif,buttonbardkgreen.gif,buttonbarltyellow.gif,buttonbardkyellow.gif,buttonbarltbrown.gif,buttonbardkbrown.gif,buttonbargray.gif,TextLink.gif">

<cfset bgcolor_list = "6B85B6,02214C,D66352,2E0602,5AB238,16500,F4D731,F6AC00,B5715A,2A0F08,929292,9EAEBE,264667,FEAAA2,7E1602,7EC64E,28602,F6E242,FEB202,D2A28E,3E160E,C2C2C2,5A748E,02254D,BC3E24,330900,16920C,4200,FEB300,8F6300,6F2818,632315,9A9A9A,FFFFFF">

<cfif get_layout.matching_bgcolor>
<cfset bg_color = "bgcolor=""#listgetat(bgcolor_list,get_layout.button_style,",")#""">
<cfelse>
<cfset bg_color = "">
</cfif>
<cfoutput>
<head><!--- <title>Menu Bar</title> --->

 <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css"  type="text/css"> 
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
document.getElementById("ButtonText").style.fontFamily = "#get_layout.button_font#";
document.getElementById("ButtonText").style.color = "#get_layout.button_color#";
document.getElementById("ButtonText").style.fontSize = "#get_layout.button_size#";;
//alert(document.getElementById("ButtonText").style.top);
if (document.getElementById("ButtonText").style.fontFamily == "cursive" || document.getElementById("ButtonText").style.fontFamily == "arial black") {
document.getElementById("ButtonText").style.top = tpcursive;
}
else {document.getElementById("ButtonText").style.top = tparial;}
}

function ColorOver01(){
document.getElementById("ButtonText01").style.color = "#get_layout.button_hover#";
}
function ColorOut01(){
document.getElementById("ButtonText01").style.color = "#get_layout.button_color#";
}
function ColorOver1a(){
document.getElementById("ButtonText1a").style.color = "#get_layout.button_hover#";
}
function ColorOut1a(){
document.getElementById("ButtonText1a").style.color = "#get_layout.button_color#";
}
function ColorOver1(){
document.getElementById("ButtonText1").style.color = "#get_layout.button_hover#";
}
function ColorOut1(){
document.getElementById("ButtonText1").style.color = "#get_layout.button_color#";
}
function ColorOver2(){
document.getElementById("ButtonText2").style.color = "#get_layout.button_hover#";
}
function ColorOut2(){
document.getElementById("ButtonText2").style.color = "#get_layout.button_color#";
}
function ColorOver3(){
document.getElementById("ButtonText3").style.color = "#get_layout.button_hover#";
}
function ColorOut3(){
document.getElementById("ButtonText3").style.color = "#get_layout.button_color#";
}
function ColorOver4(){
document.getElementById("ButtonText4").style.color = "#get_layout.button_hover#";
}
function ColorOut4(){
document.getElementById("ButtonText4").style.color = "#get_layout.button_color#";
}
function ColorOver5(){
document.getElementById("ButtonText5").style.color = "#get_layout.button_hover#";
}
function ColorOut5(){
document.getElementById("ButtonText5").style.color = "#get_layout.button_color#";
}
function ColorOver6(){
document.getElementById("ButtonText6").style.color = "#get_layout.button_hover#";
}
function ColorOut6(){
document.getElementById("ButtonText6").style.color = "#get_layout.button_color#";
}
function ColorOver7(){
document.getElementById("ButtonText7").style.color = "#get_layout.button_hover#";
}
function ColorOut7(){
document.getElementById("ButtonText7").style.color = "#get_layout.button_color#";
}
function ColorOver8(){
document.getElementById("ButtonText8").style.color = "#get_layout.button_hover#";
}
function ColorOut8(){
document.getElementById("ButtonText8").style.color = "#get_layout.button_color#";
}
function ColorOver9(){
document.getElementById("ButtonText9").style.color = "#get_layout.button_hover#";
}
function ColorOut9(){
document.getElementById("ButtonText9").style.color = "#get_layout.button_color#";
}
function ColorOver10(){
document.getElementById("ButtonText10").style.color = "#get_layout.button_hover#";
}
function ColorOut10(){
document.getElementById("ButtonText10").style.color = "#get_layout.button_color#";
}function ColorOver11(){
document.getElementById("ButtonText11").style.color = "#get_layout.button_hover#";
}
function ColorOut11(){
document.getElementById("ButtonText11").style.color = "#get_layout.button_color#";
}function ColorOver12(){
document.getElementById("ButtonText12").style.color = "#get_layout.button_hover#";
}
function ColorOut12(){
document.getElementById("ButtonText12").style.color = "#get_layout.button_color#";
}
-->
</script>
<!--- Set Link Colors --->
<style type="text/css">

##ButtonText01 {
	position: relative;
	text-align: left;
	font-family:#get_layout.button_font#;
	font-size:9px;
	font-weight:bold;
	color:###get_layout.button_color#;
	padding-bottom : 11px;
}

 
##ButtonText1a {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText1 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText2 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText3 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText4 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText5 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText6 {
position: relative;
text-align: right;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText7 {
position: relative;
text-align: right;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText8 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText9 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText10 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText11 {
position: relative;
text-align: center;
font-family:#get_layout.button_font#;
font-size:#get_layout.button_size#;
font-weight:bold;
color:###get_layout.button_color#;
padding-top : 3px;

}  
##ButtonText12 {
	position: relative;
	text-align: center;
	font-family:#get_layout.button_font#;
	font-size:#get_layout.button_size#;
	font-weight:bold;
	color:###get_layout.button_color#;
	padding-top : 3px;
	
}    


</style>



</head>

<cfparam name="current_page" default="indexhome">

<cfset classified_valid="No">

<cfif #get_layout.template# eq 1>
<body bgcolor="#get_layout.bg_color#" text="#get_layout.text_color#" marginheight="0" topmargin="0" vspace="0" marginwidth="0" leftmargin="0" hspace="0" style="margin:0; padding:0;font-family:#get_layout.text_font#" onload="ShowText();">
<!--- Menu --->
<form name="search" action="#VAROOT#/search/search_results.cfm" method="get" >
<div align="center">
	<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align=center>
			<a href="#VAROOT#/index.cfm?hit=0"><IMG SRC="#VAROOT#/logos/#get_layout.logo#" width=1003 border=0 alt="Auction Home"></a>
		</td>
	</tr>
	<tr>
		<td valign=top align=center #bg_color#>
			<table width=100% border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align=left valign=middle>&nbsp;&nbsp;&nbsp;
					<B><font face=#get_layout.button_font# color=#get_layout.button_color#>Search</font></B> 
					<input type=text name="search_text" size=50 maxlength="50" value="">
					<input type=submit name="search" value="Search">
					<A HREF="#VAROOT#/search/index.cfm"> &nbsp;&nbsp;<FONT id="ButtonText01" style="color:###get_layout.button_color#; position:relative;cursor:hand;" onmouseover="ColorOver01()" onmouseout="ColorOut01()"><b>Advanced Search</b></FONT></A>
					<input type="hidden" name="search_type" value="title_search">
					<input type="hidden" name="search_name" value="Title &amp <!---Description---> Search">
					<input name="phrase_match" type=hidden value="any">
					<cfif classified_valid IS "Yes">
				</td>
				<td aligh=right>
					<div align="right">
						<a href="#VAROOT#/classified/search/" ><font id="ButtonText7" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="right" onmouseover="ColorOver7()" onmouseout="ColorOut7()">Classified Search</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#VAROOT#/classified/index.cfm" ><font id="ButtonText6" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="right" onmouseover="ColorOver6()" onmouseout="ColorOut6()">Classified Ads</font></a>&nbsp;&nbsp;
					</div>
					</CFIF> 
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<!--- <table border="0" cellspacing="0" cellpadding="0" width=100%><tr #bg_color#><td align=center> --->
			<table border="0" cellspacing="0" cellpadding="0" width=100%>
			<tr>
				<td valign=middle align=left width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/index.cfm">
						<div id="ButtonText1a" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver1a()" onmouseout="ColorOut1a()">Home</div></a>
					</div>
				</td>
				<td valign=middle align=left width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/registration/index.cfm"><div id="ButtonText1" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver1()" onmouseout="ColorOut1()">Register</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/sellers/" ><div id="ButtonText2" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver2()" onmouseout="ColorOut2()">Sell</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/help/" ><div id="ButtonText3" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver3()" onmouseout="ColorOut3()">Help</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/messaging/" ><div id="ButtonText4" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver4()" onmouseout="ColorOut4()">Messaging</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/feedback/leavefeedback.cfm"><div id="ButtonText5" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver5()" onmouseout="ColorOut5()">Feedback</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/help/sitemap.cfm" ><div id="ButtonText8" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver8()" onmouseout="ColorOut8()">Site&nbsp;Map</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/personal"><div id="ButtonText9" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver9()" onmouseout="ColorOut9()">My&nbsp;Account</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/listings/categories/index.cfm"><div id="ButtonText10" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver10()" onmouseout="ColorOut10()">Browse</div></a>
					</div>
				</td>
				<td valign=middle align=left  width="98" height="29" #bg_color#>
					<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/login.cfm?logout=1" ><div id="ButtonText11" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver11()" onmouseout="ColorOut11()">
						<font color=red>Logout</div></a>
					</div> 
					<cfelse>
					<div style="position:relative;">
						<img src="/buttons/#listgetat(button_list,get_layout.button_style,",")#" style="position:absolute;left:0;top:0;width:100px;height:25px;" />
						<a href="#VAROOT#/login.cfm?login=1"><div id="ButtonText12" style="color:###get_layout.button_color#; position:relative;cursor:pointer;" align="center" onmouseover="ColorOver12()" onmouseout="ColorOut12()">
						Login</div></a>
					</div>
					</cfif>
				</td>
			</tr>
			</table>
			<!--- </td></tr></table> --->
		</td>
	</tr>
	</table>
</div>
</form>
</cfif>

<div style="font-family:#get_layout.heading_font#;font-size:14px;" align="center">
<!--- <table>
<tr>
<td>
<!--- Banner --->
<cfinclude template=banners1.cfm>
</td>
<!--- Search ---> 
<td>
<form name="search" action="#VAROOT#/search/search_results.cfm" method="get" >
<B>Search</B> 
<input type=text name="search_text" size=6 maxlength="50"><input type=submit name="search" value="Search"><A HREF="#VAROOT#/search/index.cfm" ><FONT SIZE=1 FACE="arial,helvetica,geneva"><br>Advanced Search</FONT></A><input type="hidden" name="search_type" value="title_search"><input type="hidden" name="search_name" value="Title &amp <!---Description---> Search"><input name="phrase_match" type=hidden value="any">
</form>
</td>
</tr>
</table> --->
</div>

</cfoutput>