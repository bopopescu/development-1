<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<cfinclude template = "../includes/app_globals.cfm">



<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfset message = "">

<cfif #trim(submit)# is "Close">
    <script language="JavaScript">window.close( 'this' )</script>
</cfif>
<cfif #trim(submit)# is "Save">
    <cfquery username="#db_username#" password="#db_password#" name="chk_terms" datasource="#DATASOURCE#">
	   SELECT terms
   	   FROM terms
	   WHERE itemnum = #itemnum#
    </cfquery>
    <cfif chk_terms.RecordCount>
       <cfquery username="#db_username#" password="#db_password#" name="upd_terms" datasource="#DATASOURCE#">
          UPDATE terms 
          SET terms = '#terms#'
          WHERE itemnum = #itemnum#
       </cfquery>       
    <cfelse>
       <cfquery username="#db_username#" password="#db_password#" name="add_terms" datasource="#DATASOURCE#">
          INSERT INTO terms (itemnum,terms) VALUES (#itemnum#,'#terms#') 
       </cfquery>       
    </cfif>
    <cfset message = "Data Saved Successfully">
</cfif>
<cfquery username="#db_username#" password="#db_password#" name="get_terms" datasource="#DATASOURCE#">
	SELECT terms
	FROM terms
	WHERE itemnum = #itemnum#
</cfquery>
<cfset terms = #get_terms.terms#>

<cfoutput>
<html>
 <head>
  <title>Visual Auction Server Administrator [Auctions]</title>
  <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
 </head>
<body>

<center>
<form name="LotForm" action="./auctions_sub2.cfm" method="post">
<input type="hidden" name="itemnum" value="#itemnum#">
<table border=0 cellspacing=0 cellpadding=0 noshade width=800>
    <tr><td>
       <font size=4 color="000000"><b>TERMS OF SALE</b></font><br>
       <font size=2 color="000000">&nbsp;<b>Paste Terms of Sale Document here.</b></font><br>
    </td></tr>
    <tr><td><cfoutput><TEXTAREA WRAP="VIRTUAL" cols=120 name="terms" rows=24>#terms#</TEXTAREA></cfoutput></td></tr>    
    <tr><td><cfif #message# is not "">&nbsp;<font size=2 color="red">&nbsp;#message#</font></cfif></td></tr>
    <tr><td align="center"><input type="submit" name="submit" value="Save">&nbsp;<input type="submit" name="submit" value="Close"></td></tr>
</table>
</form>
</cfoutput>
</center>
</body>
</html>
