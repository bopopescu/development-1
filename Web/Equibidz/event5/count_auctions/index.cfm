<!--- SourceSafe $Logfile: /Visual-Auction-4/event5/count_auctions/index.cfm $ $Revision: 1 $ $Date: 2/02/00 7:17p $ $Author: Davidh1 $ --->
<cfsetting enablecfoutputonly="yes">

<!---
  index.cfm

  count_auctions
  main script..
  
  
  Database fields required:

	categories.count_items int(11) NOT NULL default 0
	  // holds the count of items in this category.  
	  // all categories need this value.
 
	categories.count_total int(11) NOT NULL default 0
	  // holds the total count of items in category AND all categories below it.  
	  // only TOP categories (ie. 0 parent) use this value.  

--->
<!--- set defaults: --->
<cfparam name="TIMENOW" default="#now()#">


<cfoutput>Script started: #DateFormat(TIMENOW, "mm/dd/yyyy")#, #TimeFormat(TIMENOW, "HH:mm:ss")# PST
<br></cfoutput>

<!--- Clear results from previous counts. --->
<cfquery name="" datasource="#DATASOURCE#" dbtype="ODBC">
UPDATE categories
SET count_items = 0, count_total = 0
WHERE category > 0
</cfquery>
<!--- Get All active Items --->

<cfquery name="get_categories" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT DISTINCT category1 FROM items
WHERE status = 1
AND date_start < #TIMENOW#
AND date_end > #TIMENOW#
</cfquery>

<cfloop query="get_categories">
<cfquery name="get_itemCount" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT category1,category2, lvl_1, cat2_lvl_1
FROM items
WHERE category1 = #get_categories.category1#
AND date_start < #TIMENOW#
AND date_end > #TIMENOW#
AND status = 1
</cfquery>

<cfif get_itemCount.recordcount gt 0>
<cfquery name="" datasource="#DATASOURCE#" dbtype="ODBC">
UPDATE categories
SET count_items = #get_itemCount.recordcount#
WHERE category = #get_categories.category1#
</cfquery>

<cfloop query="get_itemCount">
 <cfif get_itemCount.category2 gt 0>
<cfquery name="get_category2Count" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">
SELECT count_items FROM categories
WHERE category = #get_itemCount.category2#
</cfquery>

<cfset new_itemCount = incrementValue(get_category2Count.count_items)>

<cfquery name="" datasource="#DATASOURCE#" dbtype="ODBC">
UPDATE categories
SET count_items = #new_itemCount#
WHERE category = #get_itemCount.category2#
</cfquery>

</cfif> 
<cfif get_itemCount.lvl_1 gt 0>
<cfquery name="get_lvl_1Count" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">
SELECT count_total FROM categories
WHERE category = #get_itemCount.lvl_1#
</cfquery>

<cfset new_itemCount = incrementValue(get_lvl_1Count.count_total)>

<cfquery name="" datasource="#DATASOURCE#" dbtype="ODBC">
UPDATE categories
SET count_total = #new_itemCount#
WHERE category = #get_itemCount.lvl_1#
</cfquery>

</cfif>


</cfloop>

</cfif>

</cfloop>



