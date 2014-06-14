
<html>
<head>
<title>Sales Tax Calculator</title>
<style>
#outerdiv
{
/* This sets box size */
width:590px;
height:365px;
overflow:hidden;
position:relative;
}

#inneriframe
{
/* This sets page position */
position:absolute;
top:-290px;
left:-105px;
width:1024px;
height:760px;
}
</style>
</head>

<body>

<div id='outerdiv'>
<cfset framecode = "">
<cfset framecode = "<i">
<cfset framecode = framecode & "frame src='http://www.zip2tax.com/z2t_lookup.asp' id='inneriframe' scrolling=no>">
<cfset framecode = framecode & "</i">
<cfset framecode = framecode & "frame>">

<cfoutput>#framecode#</cfoutput>
</div>
&nbsp;&nbsp;&nbsp;&nbsp;<font face=arial size=1>* Please visit zip2tax.com for more information</font>

</body>
</html>
