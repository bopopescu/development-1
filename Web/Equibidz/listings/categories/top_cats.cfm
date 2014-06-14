<!--- This page is no longer used.  Forward to index in theis same folder (categories) --->
<cflocation url = "index.cfm">
<!--- ********************************************************* --->

<!---
index.cfm

category pages..
displays category tree..

--->
<cfsetting enablecfoutputonly="Yes">

<cfset current_page = "categories">

<!--- include application globals
<cftry> --->
  <cfinclude template="../../includes/app_globals.cfm">
  <cfinclude template="../../includes/session_include.cfm">


  
  <!--- <cfcatch>
    <cflocation url="http://#site_address##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry> --->

<!--- define values --->
<cfparam name="category" default="0">
<cfparam name="url.from" default="">
<cfparam name="itemnum" default="0">
<cfset levelsDisplayed = 8>

<cfif category eq 0>
<cfquery name="getRootCategory" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT category
FROM categories
WHERE parent = 0
ORDER BY date_created ASC
</cfquery>
<cfif getRootCategory.recordcount>
<cfset Category = getRootCategory.category>

</cfif>

</cfif>

<!--- define if custom header & footer present --->
<cfset use_default_HandF = IIf(FileExists(ExpandPath("#category#_h.cfm")) AND FileExists(ExpandPath("#category#_f.cfm")), DE("FALSE"), DE("TRUE"))>

<!--- include header --->
<cfsetting enablecfoutputonly="No">
<cfif use_default_HandF>
  <cfinclude TEMPLATE="menu.cfm">
<cfelse>
  <cfinclude TEMPLATE="#category#_h.cfm">
</cfif>
<cfsetting enablecfoutputonly="Yes">




<!--- build category information --->

<!--- get categories information --->
<cfquery username="#db_username#" password="#db_password#" name="get_CategoryInfo" DATASOURCE="#DATASOURCE#">
	SELECT parent, name, date_created, allow_sales, user_id,child_count
	  FROM categories
	 WHERE category = #category#
</cfquery>



<!--- if category not found, redirect --->
<cfif not get_CategoryInfo.RecordCount>
    <cflocation url="http://#site_address##VAROOT#/includes/404notfound.cfm">
</cfif>

<!--- if parent is 0 or RecordCount is 0 --->
<cfif category IS 0 OR get_CategoryInfo.RecordCount IS 0>
  <cfset parent_available = "FALSE">
  <cfset category_name = "Top">
  <cfset public_sales = "FALSE">
<cfelse>
  <cfset parent_available = "TRUE">
  <cfset category_name = Trim(get_CategoryInfo.name)>
  <cfset public_sales = get_CategoryInfo.allow_sales>
  
  <!--- look up parents --->
  <cfmodule TEMPLATE="../../functions/parentlookup.cfm"
		CATEGORY="#category#"
		DATASOURCE="#DATASOURCE#"
		RETURN="parents_array">
</cfif>

<!--- get category_new value --->
<cfquery username="#db_username#" password="#db_password#" name="CategoryNew" DATASOURCE="#DATASOURCE#">
	SELECT pair AS days
	  FROM defaults
	 WHERE name = 'category_new'
</cfquery>

<!--- define TIMENOW --->
<cfmodule TEMPLATE="../../functions/timenow.cfm">

<cfif parent_available>
  <cfloop INDEX="i" FROM="#ArrayLen(parents_array)#" TO="1" STEP="-1">
    <cfset url_vars = IIf(i IS ArrayLen(parents_array), DE(""), DE("?category=#parents_array[i][2]#"))>
    <cfoutput><A HREF="#VAROOT#/listings/categories/index.cfm#url_vars#&from=#url.from#&itemnum=#itemnum#"><B>#parents_array[i][1]#</A>:</B> </cfoutput>
  </cfloop>
</cfif>

<!--- get number of auctions in parent catgory --->
<!--- <cfif category GT 0>
  <cfquery username="#db_username#" password="#db_password#" name="getParentItems" datasource="#DATASOURCE#">
      SELECT COUNT(itemnum) AS found
        FROM items
       WHERE (category1 = #category#
              OR category2 = #category#)
         AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
  </cfquery>
</cfif> --->

<cfsetting enablecfoutputonly="No">
<table border="1" cellspacing="0" cellpadding="0" width="100%">
<cfoutput>
<tr bgcolor="#heading_color#"><td style="font-family:#heading_font#; color:#heading_fcolor#" nowrap>
  <B><font size="4">Top Level Categories:</B><font size=1>&nbsp;&nbsp;&nbsp;(Categories below may include auctions in subcategories.)</font></font>
</td></tr>
</cfoutput>

<CFMODULE TEMPLATE="../../functions/cf_topcategory_tree.cfm"
  TYPE="RETRIEVE"
  DATASOURCE="#DATASOURCE#"
  PARENT="#category#"
  REQUIRE_LOGIN="0"
  active_only="1">

<!--- Set delimiter variables --->
<cfset #int_delim# = "÷">
<cfset #ext_delim# = "²">
<tr><td>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5 NOSHADE width="100%">
 
<cfset no_of_categories=ListLen(result, ext_delim)>
<cfset rows=Int((no_of_categories+2) / 2)>
<cfset cols=2>
<cfloop index="row_index" from="1" to="#rows#">
  <cfoutput><tr>
  </cfoutput>
  <cfloop index="col_index" from="1" to = "#cols#">
    <cfset categ_index = 1 + (row_index-1) + (col_index-1)*rows>
    <cfif not (categ_index gt no_of_categories)>
      <cfset l = ListGetAt(result, categ_index, ext_delim)>
      <cfset thisCategory = ListGetAt(l, 1, int_delim)>
  <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) LTE Variables.levelsDisplayed>
    
    <cfquery username="#db_username#" password="#db_password#" name="getCatInfo" datasource="#DATASOURCE#">
        SELECT date_created, allow_sales, user_id, count_items,category, child_count,count_total
          FROM categories
         WHERE category = #ListGetAt(l, 1, int_delim)#
    </cfquery>

	<!--- don't modify this cfparam... change it in the /includes/cache_control.cfm page only! --->
	<cfparam name="URL.strCaching" default="no">
	<cfif URL.strCaching NEQ "no">

		<!--- yes, we are caching... get count from categories table (faster) --->
		<cfset nTotal_Auctions = getCatInfo.count_total>

	<cfelse>

		<!--- No, no page caching... get live count: --->
		<cfif getcatinfo.recordcount neq 0>
		<cfquery username="#db_username#" password="#db_password#" name="getCatTotal" datasource="#DATASOURCE#">
			SELECT COUNT(status) AS total_auctions
			  FROM items
			 WHERE category1 = #ListGetAt(l, 1, int_delim)#
	            AND status = 1
			   AND date_start < #TIMENOW#
			   AND date_end > #TIMENOW#
			    OR category2 = #ListGetAt(l, 1, int_delim)#
	            AND status = 1
			   AND date_start < #TIMENOW#
			   AND date_end > #TIMENOW#
		</cfquery>
		
		<cfset nTotal_Auctions = getCatTotal.total_auctions>
		</cfif>
	</cfif>
</cfif>

         <cfoutput><td width=33% nowrap>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#</cfoutput>
    
        <cfif ListGetAt(l, 3, int_delim) IS 0><b></cfif>
    
	 
	       <!--- <cfif get_CategoryInfo.child_count>
			 
		<!---	 <cfset categoryLink = "#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">--->
 				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#&from=#url.from#&itemnum=#itemnum#"> 
				<cfelse> --->
				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#&from=#url.from#&itemnum=#itemnum#">
				<!--- </cfif> --->
			 
			 
			   <!--- <cfoutput><a href="#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput> --->

				
    		 <cfoutput><a href="#categoryLink#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput>

    <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput></b></cfoutput></cfif>

    <cfoutput> <cfif getCatInfo.child_count gt 0><img src="#VAROOT#/images/folder.gif" width=22 height=16 border=0 align=top alt="This category contains subcategories"></cfif><FONT SIZE="1">(#nTotal_Auctions#)&nbsp;</font></cfoutput>
	
	<cfoutput>
    <cfif getCatInfo.allow_sales><font size=1>
    
          <CFIF #getCatInfo.user_id# is 0 or #getCatInfo.user_id# is "">
		  
		  <cfif url.from neq "">
<cfif url.from is "edit_info">
<cfoutput><a href="#VAROOT#/personal/edit_info.cfm?cat=#ListGetAt(l, 1, int_delim)#&itemnum=#url.itemnum#">&nbsp;Edit&nbsp;here!</a></cfoutput>
<cfelseif url.from is "relist_info">
<cfoutput><a href="#VAROOT#/personal/relist_info.cfm?cat=#ListGetAt(l, 1, int_delim)#&itemnum=#url.itemnum#">&nbsp;Relist&nbsp;here!</a></cfoutput>
<cfelseif url.from is "sell">
        <cfoutput><a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#">Post&nbsp;here!</a></cfoutput> 
	</cfif>
	<cfelse>
	 <cfoutput><a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#">Post&nbsp;here!</a></cfoutput> 
	</cfif>
            <!--- <a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#"><font size=1>Post here!</font></a> --->

    <cfelse>
<img src="#VAROOT#/images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font>
          </CFIF> 

        </cfif>
		</cfoutput>
    <cfelse>
      <td>&nbsp;</td>
</cfif>
</cfloop>
  </tr>
  
</cfloop>

</TABLE>
</td></tr></table>
<!--- include footer  --->
<cfsetting enablecfoutputonly="No">  
<cfif use_default_HandF>
  <cfinclude TEMPLATE="default_f.cfm">
<cfelse>
  <cfinclude TEMPLATE="#category#_f.cfm">
</cfif>
