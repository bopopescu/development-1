<cfmail 
from="#form.mailfrom#" 
to="brian@beyondsolutions.com" 
cc="dougweick@yahoo.com"
subject="Mail test"
>

AUTOMATED SITE RESPONSE
Name: #form.name#
Phone: #form.phone#
Questions: #form.questions#

This user has requested information on Visual Auction.
</CFMAIL>

<CFOUTPUT>
<!--- FORM RESPONSE --->
<html><head>
<!-- CHANGE THE NEXT THREE LINES -->
<title>Submission Successful</title>
</head>
<BODY BGCOLOR="FFFFFF" TEXT="000000" LINK="99CCCC" VLINK="99CCCC" ALINK="FFFFFF" leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" marginheight="0" marginwidth="0">
<!-- OUTER TABLE-->
<TABLE cellpadding="0" cellspacing="0" border="0" width="100%" height="100%"><tr><td VALIGN="TOP">
<!-- top TABLE-->
<TABLE cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td ALIGN="left" VALIGN="top">
<CENTER>
<!-- MAIN TABLE-->
<TABLE cellpadding="0" cellspacing=10 border="0" width="450">
<tr><td ALIGN="LEFT" VALIGN="TOP">

<H2>Mail Test Complete</H2><BR>
Check your email to see if form info was received.
<br>
<br>
<BR>
<BR><BR><BR>
<!-- END CONTACT TEXT -->
<br>
</td></tr></table>
<!-- MAIN TABLE-->
</CENTER>
<br>
</td><td align="left" valign="top" width="150">
</td></tr></table>
<!-- top TABLE-->
</TD></TR><TR><TD VALIGN="BOTTOM"><!-- OUTER TABLE-->
</td></tr></table>
<!-- OUTER TABLE-->
</BODY>
</HTML>
<!--- FORM RESPONSE --->
</CFOUTPUT>