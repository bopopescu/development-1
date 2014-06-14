<cfinclude template = "../includes/app_globals.cfm">

<!--- define values --->
<cfparam name="category" default="0">
<cfparam name="t" default="">
<cfset levelsDisplayed = 4>
<html>
<head>
  <title>Classified Ad Categories</title>

  <link rel=stylesheet href="./includes/stylesheet.css" type="text/css">

  </title>

  <cfinclude template="../includes/bodytag.html">
    <center>

      <table <cfoutput>border=0#t#</cfoutput> cellspacing=0 cellpadding=0 noshade width=100%>
        <tr>
          <td colspan=2>
            <center>

			  <font size=2>
                <cfinclude template="../includes/menu_bar_bid.cfm">
              </font>
            </center>
            <font face="verdana,arial,helvetica" size="+2"><b>Classifieds</b></font><br>
          </td>
        </tr>
        <tr>
          <td width=390 valign=top>
            <center>

<!--- get categories information --->
<cfquery NAME="get_CategoryInfo" DATASOURCE="#DATASOURCE#">
	SELECT parent, name, date_created, allow_sales
	  FROM categories
	 WHERE category = #category#
</cfquery>

<!--- if category not found, redirect --->
<cfif not get_CategoryInfo.RecordCount>
  <cflocation url="http://#CGI.SERVER_NAME#/includes/404notfound.cfm">
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
  <cfmodule template="../functions/parentlookup.cfm"
		CATEGORY="#category#"
		DATASOURCE="#DATASOURCE#"
		RETURN="parents_array">
</cfif>

<!--- get category_new value --->
<cfquery NAME="CategoryNew" DATASOURCE="#DATASOURCE#">
	SELECT pair AS days
	  FROM defaults
	 WHERE name = 'category_new'
</cfquery>

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfif parent_available>
  <cfloop INDEX="i" FROM="#ArrayLen(parents_array)#" TO="1" STEP="-1">
    <cfset url_vars = IIf(i IS ArrayLen(parents_array), DE(""), DE("?category=#parents_array[i][2]#"))>
    <cfoutput><A HREF="list_cat.cfm#url_vars#"><B>#parents_array[i][1]#</A>:</B> </cfoutput>
  </cfloop>
</cfif>

<!--- get number of auctions in parent catgory --->
<cfif category GT 0>
  <cfquery name="getParentItems" datasource="#DATASOURCE#">
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
  <B><cfif category GT 0><a href="listings.cfm?category=#category#"></cfif>#category_name#:<cfif category GT 0></a></cfif></B><cfif category GT 0> <b>(#getParentItems.found#)</b></cfif><cfif public_sales><FONT SIZE="1"> &nbsp; <A HREF="place_ad.cfm?cat=#category#">Advertise&nbsp;Here!</A></FONT></CFIF><CFIF DateDiff("d", get_CategoryInfo.date_created, TIMENOW) LTE CategoryNew.days><FONT COLOR=FF0000 SIZE=1>&nbsp; NEW!</FONT></cfif>
  <P>
</cfoutput>

<CFMODULE template="../functions/cf_category_tree.cfm"
  TYPE="RETRIEVE"
  DATASOURCE="#DATASOURCE#"
  PARENT="#category#"
  REQUIRE_LOGIN="0">

<!--- Set delimiter variables --->
<cfset #int_delim# = "÷">
<cfset #ext_delim# = "²">

<cfoutput><TABLE BORDER=0#t# CELLSPACING=2 CELLPADDING=0 NOSHADE></cfoutput>

<cfsetting enablecfoutputonly="YES">

<cfloop index="l" list="#result#" delimiters="#ext_delim#">
  <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) LTE Variables.levelsDisplayed>
    
    <cfquery name="getCatInfo" datasource="#DATASOURCE#">
        SELECT date_created, allow_sales, user_id <!---**** User ID had been deleted--->
          FROM categories
         WHERE category = #ListGetAt(l, 1, int_delim)#
    </cfquery>
    
    <cfquery name="getCatTotal" datasource="#DATASOURCE#">
        SELECT COUNT(adnum) AS total_ads
          FROM ad_info
         WHERE (   category1 = #ListGetAt(l, 1, int_delim)#
                OR category2 = #ListGetAt(l, 1, int_delim)#)
           AND status = 1
           AND date_start < #TIMENOW#
           AND date_end > #TIMENOW#
    </cfquery>

<!---    <cfoutput>
      <tr><td>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#<cfif ListGetAt(l, 3, int_delim) IS 0><b></cfif><a href="listings.cfm?category=#ListGetAt(l, 1, int_delim)#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a><cfif ListGetAt(l, 3, int_delim) IS 0></b></cfif><cfif DateDiff("d", getCatInfo.date_created, TIMENOW) LTE CategoryNew.days><FONT COLOR=FF0000>&nbsp; NEW!</FONT></cfif><cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) GTE Variables.levelsDisplayed><cfif ListGetAt(l, 4, int_delim)> <a href="listings.cfm?category=#ListGetAt(l, 1, int_delim)#"><IMG SRC="./images/arrow.gif" HEIGHT=16 WIDTH=22 BORDER=0></a></cfif></cfif></font></td></tr>
    </cfoutput>
--->

    <cfoutput><tr><td>#RepeatString("&nbsp;", ListGetAt(l, 3, int_delim) * 4)#</cfoutput>
    <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput><b></cfoutput></cfif>
    <cfoutput><a href="listings.cfm?category=#ListGetAt(l, 1, int_delim)#">#Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2)#</a></cfoutput>
    <cfif ListGetAt(l, 3, int_delim) IS 0><cfoutput></b></cfoutput></cfif>
    <cfoutput> <FONT SIZE="1">(#getCatTotal.total_ads#)</font></cfoutput>
    <cfif getCatInfo.allow_sales><cfoutput><font size=1> &nbsp;</cfoutput> 
      <CFIF #getCatInfo.user_id# is 0 or #getCatInfo.user_id# is "">
        <cfoutput><a href="place_ad.cfm?cat=#ListGetAt(l, 1, int_delim)#">Advertise&nbsp;here!</a></cfoutput> 
      </CFIF>
    </cfif>
    <cfif DateDiff("d", getCatInfo.date_created, TIMENOW) LTE CategoryNew.days><cfoutput><FONT COLOR=FF0000>&nbsp; NEW!</FONT></cfoutput></cfif>
    <cfif Evaluate(ListGetAt(l, 3, int_delim) + 1) GTE Variables.levelsDisplayed>
      <cfif ListGetAt(l, 4, int_delim)><cfoutput> <a href="list_cats.cfm?category=#ListGetAt(l, 1, int_delim)#"><IMG SRC="#VAROOT#/images/arrow.gif" HEIGHT=16 WIDTH=22 BORDER=0></a></cfoutput></cfif><!--- ****This differs from way code was originally converted--->
    </cfif>
    <cfoutput></font></td></tr>
    </cfoutput>

  </cfif>
</cfloop>

<cfsetting enablecfoutputonly="NO">
<cfoutput></TABLE></cfoutput>


  <cfsetting enablecfoutputonly="Yes">

  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">

  <cfsetting enablecfoutputonly="No">

            </center>
          </td>
          <td width=250 valign=top> 
            <br>
<!--- 
            <form name="search" action="search_results.cfm" method="GET">
<input name="phrase_match" type=hidden value="all">
              <font size=2 face="Arial">
                <input type=text name="search_text" size=15>
                <input type=submit name="search" value="Search">
                <br>
                <cfif category IS NOT 0>
                  <input name="search_category" type="checkbox" value="#category#">Search only in this category
                </cfif>
              </font>
            </form> --->

        </td>
        </tr>
        <tr>
          <td colspan=2>
            <br>
            <br>
            <center>
            <b>last updated:</b> <cfoutput>#DateFormat(TIMENOW, "mm/dd/yyyy")#, #TimeFormat(TIMENOW, "HH:mm:ss")# #TIME_ZONE#</cfoutput>
            </center>
            <br>
            <br>
            <br>
            <br>
            <font size=2>
              <cfinclude template="../includes/copyrights.cfm">
              <br>
              <br>
              <br>
            </font>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>

