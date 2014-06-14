<!---	megalist.cfm

	No changes need to be made to this file.

	Displays all current items in the format:
	<A HREF="http://#site_address##VAROOT#/listings/details/index.cfm?itemnum=#item#">Short Description</A><PRICE>$nn.nn<CAT>Category<ENDS>dd/mm<BR>
	See: http://www.bidfind.com/af/af-mega.html for more details.
	Bidfind contact: Martin <vision@2020.vsn.net>
	List of valid Category fields: http://www.bidfind.com/af/af-catlist.html


--->
<cfinclude template="../includes/app_globals.cfm">
<cfsetting enablecfoutputonly="yes">

<cfquery username="#db_username#" password="#db_password#" NAME="AllItemData" DATASOURCE=#datasource#>
	SELECT itemnum, title, minimum_bid, category1, date_end
	  FROM items
</CFQUERY>

<CFLOOP QUERY="AllItemData">
	<CFIF DateCompare(Now(), AllItemData.date_end) LT 0>
		<CFSET AuctionEnds = DateFormat(AllItemData.date_end, "mm/dd/yyyy") >
		<cfset AuctionPrice = numberFormat(AllItemData.minimum_bid,numbermask)>

		<cfquery username="#db_username#" password="#db_password#" name="CategoryName" datasource=#datasource#>
			select name
			  from categories
			 where category = #int(AllItemData.category1)#
		</cfquery>

		<cfset AuctionCategory1 = CategoryName.name>

		<CFOUTPUT><A HREF="http://#site_address##VAROOT#/listings/details/index.cfm?itemnum=#AllItemData.itemnum#">#trim(AllItemData.title)#</A><PRICE>$#AuctionPrice#<CAT>#AuctionCategory1#<ENDS>#AuctionEnds#<BR>#chr(13)##chr(10)#</CFOUTPUT>
	</CFIF>
</CFLOOP>

<!--- log megalist accessed --->
<cfmodule template="../functions/addTransaction.cfm"
  datasource="#DATASOURCE#"
  description="Megalist Accessed">

<cfsetting enablecfoutputonly="no">
