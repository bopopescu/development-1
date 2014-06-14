<!---
index.cfm

category pages..
displays category tree..

--->
<cfsetting enablecfoutputonly="Yes">

<cfset current_page = "categories">

<!--- include application globals --->
<cftry>
  <cfinclude template="../../includes/app_globals.cfm">
  <cfinclude template="../../includes/session_include.cfm">


  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<!--- define values --->
<cfparam name="category" default="0">
<cfset levelsDisplayed = 10>

<!--- define if custom header & footer present --->
<cfset use_default_HandF = IIf(FileExists(ExpandPath("#category#_h.cfm")) AND FileExists(ExpandPath("#category#_f.cfm")), DE("FALSE"), DE("TRUE"))>

<!--- include header --->
<cfsetting enablecfoutputonly="No">
<cfif use_default_HandF>
  <cfinclude TEMPLATE="../../includes/menu_bar_L.cfm">
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
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
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
    <cfoutput><A HREF="#VAROOT#/listings/categories/index.cfm#url_vars#"><B>#parents_array[i][1]#</A>:</B> </cfoutput>
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
         AND date_end > #TIMENOW#
  </cfquery>
</cfif> --->
<!--- Font size below was 4 --->
<cfsetting enablecfoutputonly="No">
<table border="1" cellspacing="0" cellpadding="0" width="100%">
<cfoutput>
<tr bgcolor="#heading_color#"><td style="font-family:#heading_font#; color:#heading_fcolor#">
  <B><cfif category GT 0><a href="#VAROOT#/listings/index.cfm?category=#category#"></cfif><!--- #category_name# ---><font size="2">All Categories:</font><cfif category GT 0></a></cfif></B><cfif category GT 0> <b>(#getParentItems.found#)</b></cfif><cfif public_sales><FONT SIZE="1"> &nbsp; 
<CFIF #get_CategoryInfo.user_id# is 0 or #get_CategoryInfo.user_id# is "">
<a href="#VAROOT#/sell/index.cfm?cat=#category#">Post&nbsp;here!</a> 

<cfelse>

<a href="../../personal/">
<img src="../../images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font></a>


</CFIF>
<!--- <A HREF="#VAROOT#/sell/index.cfm?cat=#category#">Sell&nbsp;Here!</A> ---></FONT></CFIF><CFIF DateDiff("d", get_CategoryInfo.date_created, TIMENOW) LTE CategoryNew.days><FONT COLOR=FF0000 SIZE=1>&nbsp; NEW!</FONT></cfif>
</td></tr>
</cfoutput>

<CFMODULE TEMPLATE="../../functions/cf_category_tree.cfm"
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
        SELECT date_created, allow_sales, user_id, count_items,category
          FROM categories
         WHERE category = #ListGetAt(l, 1, int_delim)#
    </cfquery>

	<!--- don't modify this cfparam... change it in the /includes/cache_control.cfm page only! --->
	<cfparam name="URL.strCaching" default="no">
	<cfif URL.strCaching NEQ "no">

		<!--- yes, we are caching... get count from categories table (faster) --->
		<cfset nTotal_Auctions = getCatInfo.count_items>

	<cfelse>

		<!--- No, no page caching... get live count: --->
		<cfif getcatinfo.recordcount neq 0>
		<cfquery username="#db_username#" password="#db_password#" name="getCatTotal" datasource="#DATASOURCE#">
			SELECT COUNT(status) AS total_auctions
			  FROM items
			 WHERE category1 = #ListGetAt(l, 1, int_delim)#
	            AND status = 1
			AND date_end > #TIMENOW#
			    OR category2 = #ListGetAt(l, 1, int_delim)#
	            AND status = 1
			AND date_end > #TIMENOW#
		</cfquery>
		
		<cfset nTotal_Auctions = getCatTotal.total_auctions>
		</cfif>
	</cfif>
</cfif>

         <cfoutput><td width=33% nowrap>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#</cfoutput>
    
        <cfif ListGetAt(l, 3, int_delim) IS 0><b></cfif>
    
	 
	       <cfif get_CategoryInfo.child_count>
			 
		<!---	 <cfset categoryLink = "#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">--->
 				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#"> 
				<cfelse>
				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#">
				</cfif>
			 
			 
			   <!--- <cfoutput><a href="#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput> --->

				
    		 <cfoutput><a href="#categoryLink#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput>

    <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput></b></cfoutput></cfif>

    <cfoutput> <FONT SIZE="1">(#nTotal_Auctions#)&nbsp;</font></cfoutput>

    <cfif getCatInfo.allow_sales eq 1><font size=1>

      <CFIF #getCatInfo.user_id# is 0 or #getCatInfo.user_id# is "">
<cfif isDefined('url.from')>
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
	  <cfelse>
<!--- hide temporarily until debuged --->
		<cfif isDefined('url.from')>
<cfif url.from is "edit_info">
<a href="#VAROOT#/personal/edit_info.cfm?cat=#category#&itemnum=#itemnum#"><img src="#VAROOT#/images/icon_post.gif" border="0" align="absmiddle">&nbsp;Edit&nbsp;here!</a>
<cfelseif url.from is "relist_info">
<a href="#VAROOT#/personal/relist_info.cfm?cat=#category#&itemnum=#itemnum#"><img src="#VAROOT#/images/icon_post.gif" border="0" align="absmiddle">&nbsp;Relist&nbsp;here!</a>
<!--- <cfelseif url.from is "sell">
<a href="#VAROOT#/sell/index.cfm?cat=#category#"><img src="#VAROOT#/images/icon_post.gif" border="0" align="absmiddle">&nbsp;Relist&nbsp;here!</a> --->
</cfif>
<cfelse>
		  <cfif isDefined("session.logged_in") and #getCatInfo.user_id# is session.logged_in>
          	<cfoutput><a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#">Post&nbsp;here!</a></cfoutput> 
		  </cfif>
      </CFIF>
		</font>

<a href="../../personal/">
<img src="../../images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font></a>
    </cfif>
		  
    <cfif DateDiff("d", getCatInfo.date_created, TIMENOW) LTE CategoryNew.days><cfoutput><FONT COLOR=FF0000 size="1">&nbsp;NEW!</FONT></cfoutput></cfif>

    <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) GTE Variables.levelsDisplayed>
      <cfif ListGetAt(l, 4, int_delim)><cfoutput> <a href="#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#"><IMG SRC="#VAROOT#/images/arrow.gif" HEIGHT=13 WIDTH=15 BORDER=0></a></cfoutput></cfif>
    </cfif>

        </td>
    

   </cfif>
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
