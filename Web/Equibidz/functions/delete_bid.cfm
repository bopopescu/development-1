<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfinclude template = "../includes/app_globals.cfm">
<CFIF isDefined('Submit')>

<CFIF submit is "Delete Bid">

<CFQUERY NAME="del_bid" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
DELETE FROM bids
WHERE itemnum = #form.itemnum#
AND user_id = #form.user_id#
AND bid = #form.bid#
</CFQUERY>


<CFQUERY NAME="find_bid" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
SELECT * FROM bids
WHERE itemnum = #form.itemnum#
AND user_id = #form.user_id#
AND bid = #form.bid#
</CFQUERY>

<CFELSEIF submit is "Delete Auto Bid">

<CFQUERY NAME="del_proxy_bid" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
DELETE FROM proxy_bids
WHERE itemnum = #form.itemnum#
AND user_id = #form.user_id#
AND bid = #form.bid#
</CFQUERY>

<CFQUERY NAME="find_proxy_bid" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
SELECT * FROM proxy_bids
WHERE itemnum = #form.itemnum#
AND user_id = #form.user_id#
AND bid = #form.bid#
</CFQUERY>



</CFIF>
<CFELSE>

<!--- <CFQUERY NAME="get_bids" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
SELECT * FROM bids
WHERE itemnum = #itemnum#
</CFQUERY>


<CFQUERY NAME="get_proxy_bids" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
SELECT * FROM proxy_bids
WHERE itemnum = #itemnum#
</CFQUERY> --->
</CFIF>
<html>
<head>
	<title>Retract bid</title>
</head>

<body>
<CFIF isDefined('Submit')>

<CFOUTPUT>
<cfif submit is "Delete bid">
Your deletion has completed successfully and there are
#find_bid.recordcount# bids for itemnum #form.itemnum# and user #form.user_id# for the amount of #form.bid# in the bids table.
<p><a href="users.cfm">Back to Admin</a>
</CFIF>
<cfif submit is "Delete Auto Bid">
Your deletion has completed successfully and there are
#find_proxy_bid.recordcount# bids for itemnum #form.itemnum# and user #form.user_id# for the amount of #form.bid# in the auto bids table.</cfif> 



</CFOUTPUT>



<CFELSE>

<H3>Enter Itemnum, User ID, and Bid amount to Delete</H3>

<CFFORM ACTION="delete_bid.cfm" METHOD="POST" ENABLECAB="No" ENCTYPE="multipart/form-data">
<P>Itemnum: <CFINPUT TYPE="Text" NAME="itemnum" MESSAGE="You must enter a valid Itemnum" VALIDATE="integer" REQUIRED="Yes">
</P>
<P>User ID: <CFINPUT TYPE="Text" NAME="user_id" MESSAGE="You must enter a valid 9 digit user ID." VALIDATE="integer" REQUIRED="Yes" value="#user_id#"></P>
<P>Bid:  <CFINPUT TYPE="Text" NAME="bid" MESSAGE="You must enter a valid bid amount. Must be a decimal number without currency symbols or commas." VALIDATE="float" REQUIRED="Yes"></P>
<!--- 
<P>From Bids Table: <CFINPUT TYPE="Radio" NAME="bid_table" VALUE="bids">&nbsp;&nbsp;&nbsp;
From Proxy Bids Table: <CFINPUT TYPE="Radio" NAME="bid_table" VALUE="proxy_bids"> --->

</P>
<INPUT TYPE="Submit" NAME="Submit" VALUE="Delete Bid">&nbsp;&nbsp;&nbsp;<INPUT TYPE="Submit" NAME="submit" VALUE="Delete Auto Bid">
&nbsp;&nbsp;&nbsp;<INPUT TYPE="Reset">

</CFFORM>
</CFIF>


</body>
</html>
