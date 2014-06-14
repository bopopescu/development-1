<!---
index.cfm

category pages..
displays category tree..

--->


<!--- include application globals --->
  <cfinclude template="../../includes/app_globals.cfm">
  <cfinclude template="../../includes/session_include.cfm">
  <!--- define TIMENOW --->
<cfmodule TEMPLATE="../../functions/timenow.cfm">
<cfset current_page="sell">

<!--- define values --->
<cfparam name="category" default="0">
<cfset levelsDisplayed = 10>

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


<!--- get category_new value --->
<cfquery username="#db_username#" password="#db_password#" name="CategoryNew" DATASOURCE="#DATASOURCE#">
	SELECT pair AS days
	  FROM defaults
	 WHERE name = 'category_new'
</cfquery>







<cfsetting enablecfoutputonly="No">
<table border="1" cellspacing="0" cellpadding="0" width="495">
<cfoutput>
<tr bgcolor="#heading_color#"><td style="font-family:#heading_font#; color:#heading_fcolor#">
  <B><font size="4">All Categories:</font></B>
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
	<!--- <cfparam name="URL.strCaching" default="no">
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
	</cfif> --->
</cfif>

         <cfoutput><td width=33% nowrap>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#</cfoutput>
    
        <cfif ListGetAt(l, 3, int_delim) IS 0><b></cfif>
    
	 
	      
 				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#"> 

			 
			 
			   <!--- <cfoutput><a href="#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput> --->

				
    		 <cfoutput><a href="#categoryLink#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput>

    <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput></b></cfoutput></cfif>

    <!--- <cfoutput> <FONT SIZE="1">(#nTotal_Auctions#)&nbsp;</font></cfoutput> --->

    <cfif getCatInfo.allow_sales eq 1><font size=1>

      <CFIF #getCatInfo.user_id# is 0 or #getCatInfo.user_id# is "">
		<cfoutput><a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#"> <font size=1>(Post&nbsp;here!)</font></a></cfoutput>
	  <cfelse>
		<a href="../../personal/"><img src="../../images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font></a>
    </cfif>
	</font>
	</cfif>
    <cfif DateDiff("d", getCatInfo.date_created, TIMENOW) LTE CategoryNew.days><cfoutput><FONT COLOR=FF0000 size="1">&nbsp;NEW!</FONT></cfoutput></cfif>

    <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) GTE Variables.levelsDisplayed>
      <cfif ListGetAt(l, 4, int_delim)><cfoutput> <a href="#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#"><IMG SRC="#VAROOT#/images/arrow.gif" HEIGHT=13 WIDTH=15 BORDER=0></a></cfoutput></cfif>
    </cfif>

        </td>
    

   
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
  <cfinclude TEMPLATE="default_f2.cfm">
<cfelse>
  <cfinclude TEMPLATE="#category#_f.cfm">
</cfif>
