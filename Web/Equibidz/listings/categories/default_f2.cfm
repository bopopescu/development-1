
  <cfsetting enablecfoutputonly="Yes">

  <!--- define TIMENOW --->
  <cfmodule template="../../functions/timenow.cfm">

<!--- include globals --->
<cfif isdefined("db_password") is not true>
	<cfinclude template="../../includes/app_globals.cfm">
</cfif>

<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">



<!--- DEFINE PAGE LANGUAGE 
<cfparam name="this_lang" default="1">
--->




  
  <!--- if not root, get 4 newest featured in category --->
  <cfif category IS NOT 0>
    <cfquery username="#db_username#" password="#db_password#" name="get_Featured" datasource="#DATASOURCE#" maxrows="4">
        SELECT itemnum, title, bold_title
          FROM items
         WHERE category1 = #category#
           AND featured_cat = 1
           AND status = 1
           AND date_end > #TIMENOW#
            OR category2 = #category#
           AND featured_cat = 1
           AND status = 1
           AND date_end > #TIMENOW#
         ORDER BY date_start DESC
    </cfquery>
  </cfif>
  
  
  <cfsetting enablecfoutputonly="No">

            </center>
          </td>
          <td width=250 valign=top>
		  &nbsp;
		  <!--- comment featured category or advertise--->
            <!--- <br>
<!--- 
<form name="search" action="<cfoutput>#VAROOT#</cfoutput>/search/search_results.cfm" method="GET">
              <input name="phrase_match" type=hidden value="all">
              <font size=2 face="Arial">
                <input type=text name="search_text" size=15>
                <input type=submit name="search" value="Search">
                <br>
                <cfif category IS NOT 0>
                  <input name="search_category" type="checkbox" value="#category#">Search only in this category
                </cfif>
              </font>
</form>
 --->
            <!--- if not root, display featured in cat --->
            <cfif category IS NOT 0>
              <b>featured auctions</b><br>
              <cfsetting enablecfoutputonly="Yes">
                <!--- output featured auctions --->
                <cfif get_Featured.RecordCount IS 0>
             
                      <br>
                    <center>
                      <font size=2>Sorry, no featured auctions in this category at this time.</font>
                    </center>
                  
                <cfelse>
              <table border=0 cellspacing=0 cellpadding=0 noshade>
                  <cfoutput query="get_Featured">
                    <tr>
                      <td><font size=2><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#"><cfif bold_title><b></cfif>#Trim(title)#<cfif bold_title></cfif></a></font>
                      </td>
                    </tr>
                  </cfoutput>
              </table>
                </cfif>
              <cfsetting enablecfoutputonly="No">
            </cfif> --->
          </td>
        </tr>
<!--- ++++++++++++++++++++++++++ --->



<!--- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --->
        <!--- <tr><td height=50>&nbsp;</td></tr> --->
		
		<!--- comment not show all sub categories --->
<!--- <cfquery username="#db_username#" password="#db_password#" name="get_colorInfo" datasource="#DATASOURCE#">
		select bg_color, heading_color, font_color, font_style
		from categories
		where category = #category#
	</cfquery>
		
		<tr>
		
		<td colspan=3 ><cfoutput><table border=1 cellspacing=0 width=100% bordercolor="#get_colorInfo.heading_color#"></cfoutput>
		<cfoutput><tr bgcolor="#get_colorInfo.heading_color#"></cfoutput><td>
		<!--- get number of auctions in parent catgory --->
<cfif category GT 0>
  <cfquery username="#db_username#" password="#db_password#" name="getParentItems" datasource="#DATASOURCE#">
      SELECT COUNT(itemnum) AS found
        FROM items
       WHERE (category1 = #category#
	     OR category2 = #category#)
	     AND status = 1
         AND date_start < #TIMENOW#
         AND date_end > #TIMENOW#
  </cfquery>
</cfif>

<cfoutput>
  <B><cfif category GT 0><a href="#VAROOT#/listings/categories/index.cfm?category=#category#"></cfif><font face="#get_colorInfo.font_style#" color="#get_colorInfo.font_color#" size=3>#category_name#:<cfif category GT 0></a></cfif></B><cfif category GT 0> <b>(#getParentItems.found#)</b></cfif></font>

<CFIF DateDiff("d", get_CategoryInfo.date_created, TIMENOW) LTE CategoryNew.days><FONT COLOR=FF0000 SIZE=1>&nbsp; NEW!</FONT></cfif>
  <P>
</cfoutput>

		</td></tr>
		<tr><td>
		<!--- **************************************** --->

<!--- get /root categories for front page  --->
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total
      FROM categories
     WHERE parent = 0
       AND active = 1
       AND require_login = 0
     ORDER BY name ASC
</cfquery>

<cfoutput><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=0 NOSHADE width=100% bgcolor="#get_colorInfo.bg_color#">
    </cfoutput>
<cfoutput><tr></cfoutput>


<cfoutput></tr></cfoutput>
<cfset no_of_categories=ListLen(result, ext_delim)>
<cfset rows=Int((no_of_categories+2) / 3)>
<cfset cols=3>
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


         <cfoutput><td width=250>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#</cfoutput>
    
        <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput><b></cfoutput></cfif>
    
	 
	       <cfif get_Categories.child_count>
			 
		<!---	 <cfset categoryLink = "#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">--->
 				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#"> 
				<cfelse>
				 <cfset categoryLink = "#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#">
				</cfif>
			 
			 
			   <!--- <cfoutput><a href="#VAROOT#/listings/index.cfm?category=#ListGetAt(l, 1, int_delim)#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput> --->

				
    		 <cfoutput><a href="#categoryLink#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput>

    <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput></b></cfoutput></cfif>

    <cfoutput> <FONT SIZE="1">(#nTotal_Auctions#)</font></cfoutput>

    <cfif getCatInfo.allow_sales eq 1><cfoutput><font size=1> &nbsp;</cfoutput> 

      <CFIF #getCatInfo.user_id# is 0 or #getCatInfo.user_id# is "">
        <cfoutput><a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#">Post&nbsp;here!</a></cfoutput> 
	  
		<!--- <cfif #b2b_mode# is 1> --->
		  <cfif isDefined("session.logged_in") and #getCatInfo.user_id# is session.logged_in>
          	<cfoutput><a href="#VAROOT#/sell/index.cfm?cat=#ListGetAt(l, 1, int_delim)#">Post&nbsp;here!</a></cfoutput> 
</cfif>		  
<cfelse>
<a href="#VAROOT#/personal/">
<img src="#VAROOT#/images/exclusive.gif" border="0" align="absmiddle" title=Exclusive category><font size=-2 color=red>Exclusive category</font></a>


    </cfif> 
		  
    <cfif DateDiff("d", getCatInfo.date_created, TIMENOW) LTE CategoryNew.days><cfoutput><FONT COLOR=FF0000>&nbsp; NEW!</FONT></cfoutput></cfif>

    <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) GTE Variables.levelsDisplayed>
      <cfif ListGetAt(l, 4, int_delim)><cfoutput> <a href="#VAROOT#/listings/categories/index.cfm?category=#ListGetAt(l, 1, int_delim)#"><IMG SRC="#VAROOT#/images/arrow.gif" HEIGHT=13 WIDTH=15 BORDER=0></a></cfoutput></cfif>
    </cfif>

        </font></td>
    

   </cfif>
    <cfelse>
      <td>&nbsp;</td>
</cfif>
</cfloop>
  </tr>
  
</cfloop> --->

</TABLE>
</td></tr></table>
		
		
		</td></tr></table>
		</td></tr>
        <tr>
          <td colspan=2>
            <center>
			<br>
			            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
            <!--- <b>Last updated:</b> <cfoutput>#DateFormat(TIMENOW, "mm/dd/yyyy")#, #TimeFormat(TIMENOW, "HH:mm:ss")# #TIME_ZONE#</cfoutput> --->
            </center>
            <cfsetting enablecfoutputonly="Yes">
              


            
            <cfsetting enablecfoutputonly="No">
            <font size=2>
 <cfinclude template="../../includes/le_categories.html">
<br>
              <cfinclude template="../../includes/copyrights.cfm">
              <br>
            </font>
          </tr>
        </tr>
      </table>
    </center>
  </body>
</html>
<!--- <br>
              <br>
              <br>
            </font>
          </tr>
        </tr>
      </table>
    </center>
  </body>
</html>
 --->
