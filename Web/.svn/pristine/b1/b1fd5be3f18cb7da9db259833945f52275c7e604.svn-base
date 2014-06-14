<!--- SourceSafe $Logfile: /Visual-Auction-4/sell/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfquery username="#db_username#" password="#db_password#" name="delete_item" datasource="#DATASOURCE#">
    DELETE FROM items WHERE itemnum = #itemnum#
</cfquery>       
<cflocation url="my_auctions.cfm?my_No=17">
