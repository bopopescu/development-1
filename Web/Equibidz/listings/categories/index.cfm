<!---
index.cfm

category pages..
displays category tree..

--->

<head>
<style type="text/css">

.scrollArea {
width: 600px; 
height: 200px;
padding-left: 5px;
padding-right: 5px; 
border-color: #6699CC;
border-width: 1px; 
border-style: solid;
float: left; 
overflow: auto;
}
</style>
</head>



<cfsetting enablecfoutputonly="Yes">

<cfset current_page = "categories">

<!--- include application globals --->
<cftry>
  <cfinclude template="../../includes/app_globals.cfm">
  <cfinclude template="../../includes/session_include.cfm">
<cfmodule template="../../functions/timenow.cfm">

  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<!--- define values --->
<cfparam name="category" default="0">
<cfparam name="url.from" default="">
<cfparam name="itemnum" default="0">
<cfset levelsDisplayed = 8>

<!--- define if custom header & footer present --->
<cfset use_default_HandF = IIf(FileExists(ExpandPath("#category#_h.cfm")) AND FileExists(ExpandPath("#category#_f.cfm")), DE("FALSE"), DE("TRUE"))>



<!--- build category information --->

<!--- get categories information --->
<cfquery username="#db_username#" password="#db_password#" name="get_CategoryInfo" DATASOURCE="#DATASOURCE#">
	SELECT parent, name, date_created, allow_sales, user_id,category
	  FROM categories
	 WHERE category = #category#
</cfquery>

<!--- include header --->
<cfsetting enablecfoutputonly="No">
<cfif use_default_HandF>
  <cfinclude TEMPLATE="default_h.cfm">
<cfelse>
  <cfinclude TEMPLATE="#category#_h.cfm">
</cfif>
<cfsetting enablecfoutputonly="Yes">





<!--- if category not found, redirect --->
<cfif not get_CategoryInfo.RecordCount>
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
</cfif>

<!--- if parent is 0 or RecordCount is 0 --->
<cfif category IS 0 OR get_CategoryInfo.RecordCount IS 0>
  <cfset parent_available = "FALSE">
    <cfset category_name = "">
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


<cfif parent_available>
<!---<a href="<cfoutput>#VAROOT#</cfoutput>/listings/categories/all_cats.cfm">Top></a> --->
  <cfloop INDEX="i" FROM="#ArrayLen(parents_array)#" TO="1" STEP="-1">
    <cfset url_vars = IIf(i IS ArrayLen(parents_array), DE("?category=#parents_array[i][2]#"), DE("?category=#parents_array[i][2]#"))>
    <cfoutput><cfif #parents_array[i][2]# neq "0"><A HREF="#VAROOT#/listings/categories/index.cfm#url_vars#"><B>#parents_array[i][1]#</A>></B> </cfif></cfoutput>
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

<cfoutput>
  <B><cfif category GT 0><a href="#VAROOT#/listings/categories/index.cfm?category=#category#&from=#url.from#&itemnum=#itemnum#"></cfif>#category_name#</a><cfif category GT 0>></cfif></B><cfif category GT 0> <!--- <b>(#getParentItems.found#)</b> ---></cfif>
  <CFIF DateDiff("d", get_CategoryInfo.date_created, TIMENOW) LTE CategoryNew.days><FONT COLOR=FF0000 SIZE=1>&nbsp; NEW!&nbsp;</FONT></cfif>
  <cfif public_sales><FONT SIZE="1"> &nbsp; 
<CFIF #get_CategoryInfo.user_id# is 0 or #get_CategoryInfo.user_id# is "">

<a href="#VAROOT#/sell/index.cfm?cat=#category#"><img src="#VAROOT#/images/icon_post.gif" border="0" align="absmiddle">&nbsp;Post&nbsp;here!</a>

<CFelse>
<a href="#VAROOT#/personal/">
<img src="#VAROOT#/images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font></a>

</CFIF>

  </CFIF>  
</cfoutput>

<cfquery username="#db_username#" password="#db_password#" name="get_colorInfo" datasource="#DATASOURCE#">
select bg_color, heading_color, font_color, font_style,cat_image
from categories
where category = #category#
</cfquery>

<cfif get_colorInfo.cat_image is not "">
 <cfoutput><br><img src="#varoot#/cat_images/#get_colorInfo.cat_image#" border=0><br></cfoutput></cfif>
<CFMODULE TEMPLATE="../../functions/cf_category_tree.cfm"
  TYPE="RETRIEVE"
  DATASOURCE="#DATASOURCE#"
  PARENT="#category#"
  REQUIRE_LOGIN="0"
  active_only="1">

<!--- Set delimiter variables --->
<cfset #int_delim# = "÷">
<cfset #ext_delim# = "²">
<cfif not isDefined('url.category')> <cfset url_category = 0><cfelse> <cfset url_category = #url.category#></cfif>

<cfquery username="#db_username#" password="#db_password#" 
name="get_nameCategories" datasource="#DATASOURCE#"> 
    SELECT category, name, child_count, count_items
      FROM categories 
     WHERE active = 1 
AND parent = #url_category# 
      AND require_login = 0  
     ORDER BY name ASC 
</cfquery> 

<cfif get_nameCategories.recordcount> 
<cfset counter=1> 


          <cfoutput>
		  
		  <table cellspacing=0 cellpadding=0 bordercolor="#get_colorInfo.heading_color#>
		  
		  <tr><td colspan=2 bgcolor="#get_colorInfo.heading_color#"><font face="#get_colorInfo.font_style#" size=4 color="#get_colorInfo.font_color#"><b><cfif category eq 0>All </cfif>Categories</b></font><font face="#get_colorInfo.font_style#" size=1 color="#get_colorInfo.font_color#">&nbsp;&nbsp;&nbsp;(Categories below may include auctions in subcategories.)</font></td></tr>
		  <tr><td>
		  <!--- ***********Category table without sub categories*************** --->

 <!--- ******************
 <table border=0 width=100% bgcolor="#get_colorInfo.bg_color#" cellpadding="5"><tr> 
                  <cfloop query="get_nameCategories"> 
					<!--- get auction count --->

					<cfquery username="#db_username#" password="#db_password#" name="getParentItems" datasource="#DATASOURCE#">
      				SELECT COUNT(itemnum) AS found
        			FROM items
       				WHERE (category1 = #category#
	     			OR category2 = #category#)
	     			AND status = 1
         			AND date_start < #TIMENOW#
         			AND date_end > #TIMENOW#
  					</cfquery>
                    <td align=left nowrap><a href="index.cfm?category=#get_nameCategories.category#"> #get_nameCategories.name# </a><cfif child_count gt 0><img src="#VAROOT#/images/folder.gif" width=22 height=16 border=0 align=top ALT="This category contains subcategories"></cfif><cfif getParentItems.found gt 0><font size="1">(#getParentItems.found#)</font></cfif>

                    <cfif counter is 3> 
                      <cfset counter=1> 
                      </td></tr>
					  <tr> 
                    <cfelse> 
                      <cfset counter=counter+1> 
                      </td> 
                    </cfif> 
                  </cfloop>
			</table> 
******************--->
<!--- ***********End category table *************** --->

			<!--- **********Category table which show all sub categories************** --->
			<!--- get /root categories for front page --->
<!--- <cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total
    FROM categories
    WHERE parent = 0
    AND active = 1
    AND require_login = 0
    ORDER BY name ASC
</cfquery> --->

<!--- ****************** OUTPUT CATEGORIES ***************** --->

<div class="scrollArea">
<center>
<table border=0 bgcolor="#get_colorInfo.bg_color#" cellpadding="5" width=400>

<cfset no_of_categories=ListLen(result, ext_delim)>
<cfset rows=Int((no_of_categories+2) / 1)><!--- *** /# is the number of columns *** --->
<cfset cols=1>
<cfloop index="row_index" from="1" to="#rows#">
 <tr>
  
  <cfloop index="col_index" from="1" to = "#cols#">
    <cfset categ_index = 1 + (row_index-1) + (col_index-1)*rows>
    <cfif not (categ_index gt no_of_categories)>
      <cfset l = ListGetAt(result, categ_index, ext_delim)>
      <cfset thisCategory = ListGetAt(l, 1, int_delim)>
      <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) LTE Variables.levelsDisplayed>
    
        <cfquery username="#db_username#" password="#db_password#" name="getCatInfo" datasource="#DATASOURCE#">
            SELECT date_created, allow_sales, user_id, count_items, child_count
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

         <td nowrap>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#
    
        <cfif ListGetAt(l, 3, int_delim) IS 0><b></cfif>
    
	 
	      <!--- <cfif get_Categories.child_count>
		    <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#&from=#url.from#&itemnum=#itemnum#">
 		  <cfelse> --->
		    <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#&from=#url.from#&itemnum=#itemnum#">
		  <!--- </cfif> --->
		   				
     	<a href="#categoryLink#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a>
	  
        <cfif ListGetAt(l, 3, int_delim) IS 0></b></cfif>
    
        <FONT SIZE="1" color="000080">(#nTotal_Auctions#)</font>
    
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
		  
           <!---  <a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#"><font size=1>Post here!</font></a> --->

    <cfelse>
<a href="#VAROOT#/personal">
<img src="#VAROOT#/images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font></a>
          </CFIF> 

        </cfif>
    
        <cfif DateDiff("d", getCatInfo.date_created, TIMENOW) LTE CategoryNew.days><FONT COLOR=FF0000>&nbsp; NEW!</FONT></cfif>
    
        <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) GTE Variables.levelsDisplayed>
          <cfif ListGetAt(l, 4, int_delim)> <a href="#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#&from=#url.from#&itemnum=#itemnum#"><IMG SRC="#VAROOT#/images/arrow.gif" HEIGHT=16 WIDTH=22 BORDER=0></a></cfif>
        </cfif>
    
       </font></td>

      </cfif>
    <cfelse>
      <td>&nbsp;</td>
    </cfif>
  </cfloop>
 </tr>
</cfloop>
</table>
</center>
</div>
	
<!--- ************************ --->
			</td></tr>
			</table>
			</cfoutput> 
</cfif> 


<cfif #get_categoryinfo.category# neq 0>

<cfinclude template="index4.cfm">
</cfif>
<!---  category include footer  --->
<cfsetting enablecfoutputonly="No">  
<cfif use_default_HandF>
	<!--- featured auctions or advertise --->
  <cfinclude TEMPLATE="default_f.cfm">
<cfelse>
  <cfinclude TEMPLATE="#category#_f.cfm">
</cfif>
