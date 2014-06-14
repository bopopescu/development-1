<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<html>
 <head>
  <title>PayPal Cancel</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">
    
  <!--- The main table --->
<center>
<table border=0 cellspacing=0 cellpadding=2 width=640>
 <tr>
 	<td><font size="4">Your payment has been canceled</font></td>
 </tr>

 <tr><td><br><br><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td></tr>
 <tr><td align="left"><font size=3><cfinclude template="../includes/copyrights.cfm"></font></td></tr>

</table>
</center>
</body>
</html>
