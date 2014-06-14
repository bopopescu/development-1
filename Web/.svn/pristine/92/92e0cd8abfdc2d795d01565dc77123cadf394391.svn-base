<cfsetting enablecfoutputonly="Yes">
<!---
	Featured Auctions Page:
	/listings/featured/index.cfm
	builds a list of all featured auctions.
--->

<!--- define default parameters --->
<cfparam name="sortby" default="default">
<cfparam name="group" default="1">

<cfif int(group) lt 1>
	<cfset group = 1>
</cfif>

<cfset current_page = "hot">
<cfinclude template="../../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">

<!--- define EPOCH --->
<cfmodule template="../../functions/epoch.cfm">


<!--- get categories that require login --->
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category
      FROM categories
     WHERE active = 1
       AND require_login = 1
       AND category <> 0
</cfquery>

<!--- count number of auctions in featured --->
<cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#DATASOURCE#">
    SELECT COUNT(status) AS total
      FROM items
     WHERE status = 1
       AND date_start < #TIMENOW#
       AND date_end > #TIMENOW#
  <cfloop query="get_Categories">
       AND category1 <> #get_Categories.category#
       AND category2 <> #get_Categories.category#
  </cfloop>
</cfquery>

<!--- define number of items per page --->
<cfquery username="#db_username#" password="#db_password#" name="get_PageGroup" datasource="#DATASOURCE#">
    SELECT pair AS itemsperpage
      FROM defaults
     WHERE name = 'itemsperpage'
</cfquery>

<!--- define total pages --->
<!--- <cftry>
	<cfset total_pages = ceiling(int(cnt_Auctions.total)/int(get_PageGroup.itemsperpage))>
	<cfcatch>
		<cfset total_pages = 1>
	</cfcatch>
</cftry> --->

<!--- get # of days item is new --->
<cfquery username="#db_username#" password="#db_password#" name="ListingNew" datasource="#DATASOURCE#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'listing_new'
</cfquery>

<!--- get number of bids required for hot auction --->
<cfquery username="#db_username#" password="#db_password#" name="HotAuction" datasource="#DATASOURCE#">
    SELECT pair AS bids
      FROM defaults
     WHERE name = 'bids4hot'
</cfquery>

<!--- get listing ending hours value --->
<cfquery username="#db_username#" password="#db_password#" name="HrsEnding" datasource="#DATASOURCE#">
    SELECT pair AS hours
      FROM defaults
     WHERE name = 'hrsending'
</cfquery>

<!--- get listing ending hours color --->
<cfquery username="#db_username#" password="#db_password#" name="HrsEndingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'hrsending_color'
</cfquery>

<!--- define listing row color --->
<cfquery username="#db_username#" password="#db_password#" name="get_ListingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'listing_bgcolor'
</cfquery>


<cfif sortby EQ "date_asc">
	<cfset orderby = "itemnum ASC">

<cfelseif sortby EQ "title_desc">
	<cfset orderby = "title DESC">
<cfelseif sortby EQ "title_asc">
	<cfset orderby = "title ASC">

<cfelse>
	<cfset orderby = "itemnum DESC">
</cfif>


<!--- get thumbs mode settings (Thumbnail display outside studio) --->
<cfquery username="#db_username#" password="#db_password#" name="get_thumbsMode" datasource="#DATASOURCE#">
    SELECT pair AS show_thumbs
      FROM defaults
     WHERE name = 'enable_thumbs'
</cfquery>

<!--- get info for all auctions on this page --->
<cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#"><!---  maxrows="#evaluate(int(group)*int(get_PageGroup.itemsperpage))#" --->
    SELECT itemnum, status, title, picture, sound, minimum_bid, maximum_bid, bold_title, featured_cat, featured_studio, banner, banner_line, date_start, date_end
      FROM items
     WHERE status = 1
and featured_studio = 1
       AND date_start < #TIMENOW#
       AND date_end > #TIMENOW#
  <cfloop query="get_Categories">
       AND category1 <> #get_Categories.category#
       AND category2 <> #get_Categories.category#
  </cfloop>
     ORDER BY #orderby#
</cfquery>

<!--- output listings --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>Hot Auctions</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../../includes/bodytag.html">
    <center>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
<cfinclude template="../../includes/menu_bar.cfm">
        <tr>
          <td>
            

<!--- include menu bar --->
            <center>

             
              <br>
            </center>
          </td>
        </tr>
      </table>
      <br>
      <!--- <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td width=350 valign=top>
            <b>last updated:</b> <cfoutput>#DateFormat(TIMENOW, "mm/dd/yyyy")#, #TimeFormat(TIMENOW, "HH:mm:ss")# #TIME_ZONE#</cfoutput>
            <br>
            <font size=2>
              Reload often to see the lastest version of this page.
              <br>
              <br>
            </font>
          </td>
          <td width=290 valign=top>
            <form name="search" action="<cfoutput>#VAROOT#</cfoutput>/search/search_results.cfm" method="POST">
            <font size=2 face="Arial">
              <input type=text name="search_text" size=20> <small><input type=submit name="search" value="Search"></small>
            </font>
            </form>
          </td>
        </tr>
      </table> --->

      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=center align=left>
            <font size=-1>
		  <cfmodule template="../../functions/sortorderlinks.cfm"
		    sortby="#sortby#"
		    action="#VAROOT#/listings/hot/index3.cfm">
            </font>
          </td>
        </tr>
      </table>

      <!--- <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <center>
              <font size=2>
                Click here for more items: 
                <cfmodule template="../../functions/pagelinks.cfm"
                  thispage="#group#"
                  totalpages="#total_pages#"
                  link="#VAROOT#/listings/featured/index3.cfm?sortby=#sortby#">
              </font>
            </center>
          </td>
        </tr>
      </table> --->  

      <cfsetting enablecfoutputonly="Yes">

      <!--- FEATURED AUCTIONS --->
      <cfoutput>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=3>
              <b>
                All Hot Auctions:
              </b>
            </font>
            <hr width=100% size=1 noshade>
          </td>
        </tr>
      </table>
      </cfoutput>


<br>

<br>
<CENTER>
<cfoutput>  
      <TABLE cellSpacing=0 cellPadding=0 width=640  border=0>
</cfoutput>  
<cfoutput>  

        <TBODY>
        <TR>
          <TD width=20><IMG height=10 
            src="../../images/spacer.gif" 
            width=10></TD>



          <TD  noWrap align=middle width=200 
          background="../../images/hidden.gif" 
          height=28>
</cfoutput>  
<cfoutput><A 
            href="index.cfm"><font size=4>All auctions</font></a></cfoutput>
</TD>

<cfoutput>

          <TD noWrap width=5 bgColor=ffffff></TD>
          <TD  noWrap align=middle width=200 
          background="../../images/hidden.gif" 
          height=28>
</cfoutput>

<cfoutput><A 
            href="index2.cfm"><font size=4>Buynow Only</font></a></cfoutput>



</TD>
<cfoutput>  
 <TD width=20><IMG height=10 
            src="../../images/spacer.gif" 
            width=10></TD>
</cfoutput>  
          
<cfoutput>  
<TD width=5 bgColor=ffffff></TD>

        <TD  noWrap align=middle width=200 
          background="../../images/visible.gif" 
          height=28></cfoutput>

<cfoutput><A 
            href="index3.cfm"><font size=4>Studio Items</font></a></cfoutput>

</TD>


<!--- adjust space between img background here --->         

<cfoutput>
 <TD width=130>


<IMG height=10 
            src="../../images/spacer.gif" 
            width=10>

</TD></TR></TBODY></TABLE>
</cfoutput>
<cfoutput>
      <TABLE cellSpacing=0 cellPadding=0 width="640" border=0>
        <TBODY>
        <TR>
          <TD width=640 height=10><IMG height=10 
            src="../../images/line.gif" 
            width=640 border=0></TD></TR></TBODY></TABLE></cfoutput><BR>






</center>






      
      
      
      <!--- HOT AUCTIONS --->
      <cfoutput>
      <br>
      <!--- <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=3 face="#heading_font#">
              <b>
                HOT Auctions:
              </b>
            </font>
            <hr width=100% size=1 noshade>
          </td>
        </tr>
      </table> --->
      </cfoutput>
      
      <cfmodule template="../../functions/prnt_listing.cfm"
        part="HEADER"
        featured_studio="#get_Items.featured_studio#"
        show_thumbs="#get_thumbsMode.show_thumbs#"
        datasource="#DATASOURCE#"
		db_username="#db_username#"
		db_password="#db_password#"
		heading_color="#heading_color#"
		heading_fcolor="#heading_fcolor#"
		heading_font="#heading_font#">
      
      <cfset item_count = 0>
      <cfset startrow = 1+(int(group-1)*int(get_PageGroup.itemsperpage))>
      
      <cfloop query="get_Items" startrow=#startrow#>
        <!--- get bids --->
        <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
            SELECT COUNT(itemnum) AS total
              FROM bids
             WHERE itemnum = #itemnum#
        </cfquery>
        
        <!--- if meets criteria of group --->
        <cfif CountBids.total GTE HotAuction.bids>
          
          <!--- increment item_count --->
          <cfset item_count = IncrementValue(item_count)>
          
          <!--- get highest bid --->
        <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
            SELECT MAX(bid) AS price
              FROM bids
             WHERE itemnum = #itemnum#
        </cfquery>

<!--- get lowest bid --->
        <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
            SELECT Min(bid) AS price
              FROM bids
             WHERE itemnum = #itemnum#
        </cfquery>        

        <!--- output listing --->
        <cfmodule template="../../functions/prnt_listing.cfm"
          part="LISTING"
          itemnum="#itemnum#"
          itemtitle="#title#"
          currentrow="#item_count#"
          rowcolor="#get_ListingColor.color#"
          boldtitle="#bold_title#"
          picture="#picture#"
          sound="#sound#"
          banner="#banner#"
          banner_line="#banner_line#"
          highest="#HighestBid.price#"
        	lowest="#LowestBid.price#"
          minimum_bid="#minimum_bid#"
        	maximum_bid="#maximum_bid#"
          totalbids="#CountBids.total#"
          hotbids="#HotAuction.bids#"
          TIMENOW="#TIMENOW#"
          listingnew="#ListingNew.days#"
          date_start="#date_start#"
          date_end="#date_end#"
          listingending="#HrsEnding.hours#"
          endingcolor="#HrsEndingColor.color#"
          featured_studio="#featured_studio#"
          show_thumbs="#get_thumbsMode.show_thumbs#"
          status="#status#"
          VAROOT="#VAROOT#"
		  datasource="#DATASOURCE#"
		  db_username="#db_username#"
		  db_password="#db_password#">
        </cfif>
      </cfloop>
      <!--- define total pages --->
	<cftry>
	<cfset total_pages = ceiling(int(item_count)/int(get_PageGroup.itemsperpage))>
	<cfcatch>
		<cfset total_pages = 1>
	</cfcatch>
	</cftry>
	
      <!--- if no listings show blank --->
      <cfif not item_count>
        <cfmodule template="../../functions/prnt_listing.cfm"
          part="BLANK"
          rowcolor="#get_ListingColor.color#">
      </cfif>
      
      <cfmodule template="../../functions/prnt_listing.cfm" part="FOOTER">
      <!--- /HOT AUCTIONS --->
      
      <cfsetting enablecfoutputonly="No">

      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <center>
              <font size=2>
                Page: 
                <cfmodule template="../../functions/pagelinks.cfm"
                  thispage="#group#"
                  totalpages="#total_pages#"
                  link="#VAROOT#/listings/featured/index3.cfm?sortby=#sortby#">
              </font>
            </center>

      <br>
      <!--- <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=center align=left>
            <font size=-1>
		  <cfmodule template="../../functions/sortorderlinks.cfm"
		    sortby="#sortby#"
		    action="#VAROOT#/listings/featured/index.cfm">
            </font>
          </td>
        </tr>
      </table> --->

            <font size=2>
              Click on any item title to see the auctions complete information and to place 
              a bid.  If an auction's ending time is highlighted it will be ending in 
              less then <cfoutput>#HrsEnding.hours#</cfoutput> hours.  None of the above 
              items have been verified... caveat emptor.  Please remember to reload this 
              page regularly.
            </font>
            <cfsetting enablecfoutputonly="Yes">
              
            
            <cfsetting enablecfoutputonly="No">
          </td>
        </tr>
      </table>
      <br>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
            </center>
            <br>
          </td>
        </tr>
      </table>
	  <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top align="center">
		  <hr size="1" noshade width="100%"
            <b>last updated:</b> <cfoutput>#DateFormat(TIMENOW, "mm/dd/yyyy")#, #TimeFormat(TIMENOW, "HH:mm:ss")# #TIME_ZONE#</cfoutput>
            <br>
            <font size=2>
              <br>
            </font>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td align=left valign=top>
             <font size=2>
               <cfinclude template="../../includes/copyrights.cfm">
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
