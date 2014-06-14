<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">


<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>

<cfif #trim(submit)# is "Close">
    <script language="JavaScript">window.close( 'this' )</script>
</cfif>

<cfset inWatchlist = false>
<cfset message_stat = "">
<cfif #trim(submit)# is "Add to Watchlist">
   <cfquery username="#db_username#" password="#db_password#" name="add_watchlist" datasource="#DATASOURCE#">
      INSERT INTO watchlist (itemnum, user_id) VALUES (#itemnum#, #session.user_id#)       
   </cfquery> 
   <cfset inWatchlist = true>
   <cfset message_stat = "Item is now in your Watchlist">   
<cfelse>
   <cfquery username="#db_username#" password="#db_password#" name="get_watchlist" datasource="#DATASOURCE#">
	  SELECT itemnum
  	  FROM watchlist
	  WHERE itemnum = #itemnum# AND user_id = #session.user_id#
   </cfquery>
   <cfif #get_watchlist.RecordCount#>
      <cfset inWatchlist = true>
      <cfset message_stat = "Item is already in your Watchlist">
   </cfif>
</cfif>   
<cfquery username="#db_username#" password="#db_password#" name="get_itemwatch" datasource="#DATASOURCE#">
	SELECT name, pri_breed, color, picture1
	FROM items
	WHERE itemnum = #itemnum#
</cfquery>

<cfoutput>
<html>
<head>
	<title>Watch List</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>

<body>
<form name="WatchForm" action="index_sub.cfm" method="post">
<input type="hidden" name="itemnum" value="#itemnum#">
<center>
<table border=0 cellspacing=0 cellpadding=15 noshade width="100%">
    <tr><td>
        <img src="/fullsize_thumbs/#get_itemwatch.picture1#" height=200 width=200 border=0><br>
        <font size=3 color="black">#get_itemwatch.name#</font><br>
        <font size=3 color="black">#get_itemwatch.pri_breed# #get_itemwatch.color#</font><br>
        <font size=2 color="red">#message_stat#</font>
    </td></tr>
    <tr><td align="center">
        <cfif not #inWatchlist#>
           <input type="submit" name="submit" value="Add to Watchlist">
        </cfif>   
        <input type="submit" name="submit" value="Close">
    </td></tr>
</table>
</form>
</cfoutput>
</center>
</body>
</html>