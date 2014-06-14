<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/completedAuctions.cfm $ $Revision: 1 $ $Date: 12/29/99 2:21p $ $Author: Joe $ --->

<!---
  completedAuctions.cfm
  
  completed auctions report output screen
  
  files used:
    /admin/validate_include.cfm
    /admin/menu_include.cfm
    /functions/timenow.cfm
  
  Author: John Adams
  Date: 07/29/1999
  
---><cfsetting enablecfoutputonly="Yes">

<!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">

<!--- chk coming from reports menu --->
<cfif CGI.HTTP_REFERER DOES NOT CONTAIN "/admin/reports.cfm">
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/reports.cfm">
</cfif>

<!--- def TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- def vals --->
<cfparam name="type" default="html">
<cfparam name="sort" default="dateA">
<cfparam name="days" default="30">
<cfset sOutputType = type>
<cfset sNewline = Chr(13) & Chr(10)>
<cfset TIMENOW = DateAdd("n", -30, TIMENOW)>    <!--- backup TIMENOW 30 mins, so all auctions will have invoices --->

<cfset iDefDays = 30>
<cfset iDays = IIf(IsNumeric(days), "days", "Variables.iDefDays") - (2 * IIf(IsNumeric(days), "days", "Variables.iDefDays"))>
<cfset tsStartDay = DateAdd("d", Variables.iDays, TIMENOW)>
<cfset tsStartStamp = CreateODBCDateTime("#Year(tsStartDay)#-#Month(tsStartDay)#-#Day(tsStartDay)# 00:00:00")>
<cfset fSellPTotal = 0.00>
<cfset fFeesTotal = 0.00>

<cfset sSqlFields = "">
<cfset sSqlOrderBy = "">
<cfset sDefSqlOrderBy = "ORDER BY I.date_end ASC, I.itemnum ASC">

<cfset iHTMTitleSpan = 15>
<cfset iHTMNameSpan = 20>
<cfset iHTMRowCount = 0>

<cfset sCSVFile = "completedauctions#rand()#.csv">
<cfset sCSVContent = "">
<cfset sCSVCiteChr = """">
<cfset sCSVFldDelim = ",">
<cfset iCSVRecsPerWrite = 5>
<cfset lCSVStringFlds = "date_end, title, seller_name">
<cfset lCSVFlds = "date_end, itemnum, title, seller_name, user_id, category1, category2">

<!--- def sql order by --->
<cfif sort IS "categoryA">
  <cfset sSqlOrderBy = "ORDER BY I.category1 ASC">
  
<cfelseif sort IS "categoryD">
  <cfset sSqlOrderBy = "ORDER BY I.category1 DESC">
  
<cfelseif sort IS "dateA">
  <cfset sSqlOrderBy = "ORDER BY I.date_end ASC, I.itemnum ASC">
  
<cfelseif sort IS "dateD">
  <cfset sSqlOrderBy = "ORDER BY I.date_end DESC, I.itemnum DESC">
  
<cfelseif sort IS "nameA">
  <cfset sSqlOrderBy = "ORDER BY U.name ASC">
  
<cfelseif sort IS "nameD">
  <cfset sSqlOrderBy = "ORDER BY U.name DESC">
  
<cfelse>
  <cfset sSqlOrderBy = Variables.sDefSqlOrderBy>
</cfif>

<!--- SETUP FOR CSV OUTPUT --->
<!---------------------------->
<cfif sOutputType IS "csv">
  
  <!--- if /admin/downloads dir doesn't exist, create --->
  <cfif not DirectoryExists(ExpandPath("./downloads"))>
    
    <cfdirectory action="Create"
      directory="#ExpandPath("./downloads")#"
      mode="666">
  </cfif>
  
  <!--- get completed auctions --->
  <cfquery username="#db_username#" password="#db_password#" name="getAuctions" datasource="#DATASOURCE#">
      SELECT I.date_end, I.itemnum, I.title, I.user_id, I.category1, I.category2, I.minimum_bid, I.reserve_bid, I.auction_type, I.quantity, U.name AS seller_name
        FROM items I, users U
       WHERE I.status = 0
         AND I.date_end <= #TIMENOW#
         AND I.date_end >= #Variables.tsStartStamp#
         AND I.user_id = U.user_id
         #Variables.sSqlOrderBy#
  </cfquery>
  
  <!--- loop on auctions --->
  <cfloop query="getAuctions">
    
    <!--- def vals --->
    <cfset sTmpContent = "">
    
    <!--- setup info --->
    <cfloop index="e" list="#Variables.lCSVFlds#">
      
      <cfif ListContainsNoCase(Variables.lCSVStringFlds, Trim(e), ",")>
        <cfset sTemp = """" & Replace(Evaluate("getAuctions." & Trim(e)), """", """""", "ALL") & """">
      <cfelse>
        <cfset sTemp = Evaluate("getAuctions." & Trim(e))>
      </cfif>
      
      <cfset sTmpContent = ListAppend(sTmpContent, sTemp, ",")>
    </cfloop>
    
    <!--- add sold & sale price & total fees --->
    <!--- get sale price --->
    <cfif getAuctions.auction_type IS "V">
      
      <cfquery username="#db_username#" password="#db_password#" name="cntBid" datasource="#DATASOURCE#">
          SELECT COUNT(itemnum) AS found
            FROM bids
           WHERE itemnum = #getAuctions.itemnum#
      </cfquery>
      
      <cfquery username="#db_username#" password="#db_password#" name="getBid" datasource="#DATASOURCE#" maxrows="2">
          SELECT bid AS highbid
            FROM bids
           WHERE itemnum = #getAuctions.itemnum#
           ORDER BY bid DESC
      </cfquery>
      
      <cfset iBidsFound = cntBid.found>
      
      <cfif cntBid.found GTE 2>
        <cfloop query="getBid">
          <cfset fHighBid = getBid.highbid>
        </cfloop>
      <cfelse>
        <cfset fHighBid = getAuctions.minimum_bid>
      </cfif>
        
    <cfelse>
      <cfquery username="#db_username#" password="#db_password#" name="getBid" datasource="#DATASOURCE#">
          SELECT COUNT(itemnum) AS found, MAX(bid) AS highbid
            FROM bids
           WHERE itemnum = #getAuctions.itemnum#
      </cfquery>
      
      <cfset iBidsFound = getBid.found>
      <cfset fHighBid = getBid.highbid>
    </cfif>
    
    <!--- def sold --->
    <cfif Variables.iBidsFound>
      
      <cfif Variables.fHighBid GTE getAuctions.minimum_bid
        AND Variables.fHighBid GTE getAuctions.reserve_bid>
        
        <cfset bIsSold = 1>
      <cfelse>
        <cfset bIsSold = 0>
      </cfif>
    <cfelse>
      <cfset bIsSold = 0>
    </cfif>
    
    <!--- def sell price --->
    <cfif bIsSold>
      
      <!--- if english or vickery --->
      <cfif getAuctions.auction_type IS "E"
        OR getAuctions.auction_type IS "V">
        
        <cfset fSellPrice = fHighBid>
        
      <!--- elseif dutch or yankee --->
      <cfelseif getAuctions.auction_type IS "D"
        OR getAuctions.auction_type IS "Y">
        
        <cfquery username="#db_username#" password="#db_password#" name="getMultiBids" datasource="#DATASOURCE#" maxrows="#getAuctions.quantity#">
            SELECT bid, quantity
              FROM bids
             WHERE itemnum = #getAuctions.itemnum#
             ORDER BY bid DESC, time_placed ASC
        </cfquery>
        
        <cfset fSellPrice = 0>
        <cfset iCurrentQty = 0>
        
        <cfloop query="getMultiBids">
          
          <cfset fSellPrice = getMultiBids.bid>
          <cfset iCurrentQty = iCurrentQty + getMultiBids.quantity>
          
          <!--- if qty met, break --->
          <cfif iCurrentQty GTE getAuctions.quantity>
            <cfbreak>
          </cfif>
        </cfloop>
        
      <cfelse>
        <cfset fSellPrice = 0>
      </cfif>
    <cfelse>
      <cfset fSellPrice = 0>
    </cfif>
    
    <!--- def total fee --->
    <cfquery username="#db_username#" password="#db_password#" name="getInvoice" datasource="#DATASOURCE#">
        SELECT invoice_total
          FROM invoices
         WHERE itemnum = #getAuctions.itemnum#
    </cfquery>
    
    <cfif getInvoice.RecordCount>
      <cfset fTotalFees = getInvoice.invoice_total>
    <cfelse>
      <cfset fTotalFees = 0>
    </cfif>
    
    <cfset sTmpContent = ListAppend(sTmpContent, """#YesNoFormat(Variables.bIsSold)#""", ",")>
    <cfset sTmpContent = ListAppend(sTmpContent, Variables.fSellPrice, ",")>
    <cfset sTmpContent = ListAppend(sTmpContent, Variables.fTotalFees, ",")>
    
    <!--- add new line to content w/o newline --->
    <cfif getAuctions.CurrentRow MOD Variables.iCSVRecsPerWrite EQ 0
      OR getAuctions.CurrentRow IS getAuctions.RecordCount>
      
      <cfset sCSVContent = sCSVContent & sTmpContent>
    
    <!--- add new line to content w/ newline --->
    <cfelse>
      <cfset sCSVContent = sCSVContent & sTmpContent & Variables.sNewline>
    </cfif>
    
    <!--- write/append to file --->
    <cfif getAuctions.CurrentRow MOD Variables.iCSVRecsPerWrite EQ 0
      OR getAuctions.CurrentRow IS getAuctions.RecordCount>
      
      <!--- def action --->
      <cfif getAuctions.CurrentRow IS Variables.iCSVRecsPerWrite>
        <cfset sAction = "Write">
        
      <cfelseif getAuctions.RecordCount LT Variables.iCSVRecsPerWrite>
        <cfset sAction = "Write">
        
      <cfelse>
        <cfset sAction = "Append">
      </cfif>
      
      <cffile action="#Variables.sAction#"
        file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
        output="#Variables.sCSVContent#">
        
      <cfset sCSVContent = "">
    </cfif>
  </cfloop>
  
  <!--- if no records --->
  <cfif not getAuctions.RecordCount>
    
    <cfset sCSVContent = " ">
    
    <cffile action="Write"
      file="#ExpandPath("./downloads/" & Variables.sCSVFile)#"
      output="#Variables.sCSVContent#">
  </cfif>
  
  <!--- redirect to file --->
  <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/admin/downloads/#Variables.sCSVFile#">
  
<!--- SETUP FOR HTML DISPLAY --->
<!------------------------------>
<cfelseif sOutputType IS "html">
  
  <!--- get completed auctions --->
  <cfquery username="#db_username#" password="#db_password#" name="getAuctions" datasource="#DATASOURCE#">
      SELECT I.date_end, I.itemnum, I.title, I.user_id, I.category1, I.category2, I.minimum_bid, I.reserve_bid, I.auction_type, I.quantity, U.name AS seller_name
        FROM items I, users U
       WHERE I.status = 0
         AND I.date_end <= #TIMENOW#
         AND I.date_end >= #Variables.tsStartStamp#
         AND I.user_id = U.user_id
         #Variables.sSqlOrderBy#
  </cfquery>
  
  <!--- get currency code --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <cfif getCurrency.RecordCount>
    <cfset sSiteCurrency = Trim(getCurrency.pair)>
  <cfelse>
    <cfset sSiteCurrency = "">
  </cfif>
  
  <!--- output page --->
  <cfsetting enablecfoutputonly="No">
  
  <html>
    <head>
      <title>Visual Auction Server Administrator [Reports Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
      
    </head>
    
    <body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
      <font face="helvetica" size=2>
        <center>
          
       <!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900>
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>
<!---
<td></td>
<td></td>
--->
<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->

            
            <!--- Include the menubar --->
            <cfset #page# = "reports">
            <cfinclude template="menu_include.cfm">
            
            <tr>
              <td colspan=5 bgcolor=bac1cf>
                <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=709>	    
                  <tr>
                    <td>
                      <table border=0 cellspacing=0 cellpadding=5 width=100%>
                        <tr>
                          <td>
                            <font face="helvetica" size=2 color=000000>
                              Use this page to print reports and conduct statistical analysis of your <i>Auction Server</i>.<br>
                              If you do not know how to use this administration tool, please
							  <!--- consult your user manual or ---> click the help button in the<br>
							  upper right corner of this window.
                                          <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> 
                            </font>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <table border=0 cellspacing=0 cellpadding=0 width=100%>
                              <tr>
                                <td>&nbsp;<font face="helvetica" size=2 color=000080><b>COMPLETED AUCTIONS:</b></font></td>
                                <td align=right><font face="helvetica" size=2><b><cfoutput>#DateFormat(tsStartStamp, "mm/dd/yyyy")# - #DateFormat(TIMENOW, "mm/dd/yyyy")#</cfoutput></b></font>&nbsp;</td>
                              </tr>
                            </table>
                            
                            <!--- The main table with the dark blue border --->
                            <table width=100% border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                              <tr>
                                <td>
                                  <table width=100% border=0 cellspacing=0 cellpadding=3>
                                    <tr bgcolor=cbeef9>
                                      <td><font color="000000" face="helvetica" size=1><b>Date</b></td>
                                      <td><font color="000000" face="helvetica" size=1><b>Item No.</b></td>
                                      <td><font color="000000" face="helvetica" size=1><b>Item Title</b></td>
                                      <td><font color="000000" face="helvetica" size=1><b>Seller Name</b></td>
                                      <td><font color="000000" face="helvetica" size=1><b>Seller ID</b></td>
                                      <td><font color="000000" face="helvetica" size=1><b>Category</b></td>
                                      <td align=center><font color="000000" face="helvetica" size=1><b>Sold</b></td>
                                      <td align=right><font color="000000" face="helvetica" size=1><b>Sale Price</b></td>
                                      <td align=right><font color="000000" face="helvetica" size=1><b>Total Fees</b></td>
                                    </tr>
                                    
                                    <!--- loop over auctions --->
                                    <cfloop query="getAuctions">
                                      <cfsetting enablecfoutputonly="Yes">
                                      
                                      <!--- increment row counter --->
                                      <cfset iHTMRowCount = iHTMRowCount + 1>
                                      
                                      <!--- get sale price --->
                                      <cfif getAuctions.auction_type IS "V">
                                        
                                        <cfquery username="#db_username#" password="#db_password#" name="cntBid" datasource="#DATASOURCE#">
                                            SELECT COUNT(itemnum) AS found
                                              FROM bids
                                             WHERE itemnum = #getAuctions.itemnum#
                                        </cfquery>
                                        
                                        <cfquery username="#db_username#" password="#db_password#" name="getBid" datasource="#DATASOURCE#" maxrows="2">
                                            SELECT bid AS highbid
                                              FROM bids
                                             WHERE itemnum = #getAuctions.itemnum#
                                             ORDER BY bid DESC
                                        </cfquery>
                                        
                                        <cfset iBidsFound = cntBid.found>
                                        
                                        <cfif cntBid.found GTE 2>
                                          <cfloop query="getBid">
                                            <cfset fHighBid = getBid.highbid>
                                          </cfloop>
                                        <cfelse>
                                          <cfset fHighBid = getAuctions.minimum_bid>
                                        </cfif>
                                          
                                      <cfelse>
                                        <cfquery username="#db_username#" password="#db_password#" name="getBid" datasource="#DATASOURCE#">
                                            SELECT COUNT(itemnum) AS found, MAX(bid) AS highbid
                                              FROM bids
                                             WHERE itemnum = #getAuctions.itemnum#
                                        </cfquery>
                                        
                                        <cfset iBidsFound = getBid.found>
                                        <cfset fHighBid = getBid.highbid>
                                      </cfif>
                                      
                                      <!--- def sold --->
                                      <cfif Variables.iBidsFound>
                                        
                                        <cfif Variables.fHighBid GTE getAuctions.minimum_bid
                                          AND Variables.fHighBid GTE getAuctions.reserve_bid>
                                          
                                          <cfset bIsSold = 1>
                                        <cfelse>
                                          <cfset bIsSold = 0>
                                        </cfif>
                                      <cfelse>
                                        <cfset bIsSold = 0>
                                      </cfif>
                                      
                                      <!--- def sell price --->
                                      <cfif bIsSold>
                                        
                                        <!--- if english or vickery --->
                                        <cfif getAuctions.auction_type IS "E"
                                          OR getAuctions.auction_type IS "V">
                                          
                                          <cfset fSellPrice = fHighBid>
                                          
                                        <!--- elseif dutch or yankee --->
                                        <cfelseif getAuctions.auction_type IS "D"
                                          OR getAuctions.auction_type IS "Y">
                                          
                                          <cfquery username="#db_username#" password="#db_password#" name="getMultiBids" datasource="#DATASOURCE#" maxrows="#getAuctions.quantity#">
                                              SELECT bid, quantity
                                                FROM bids
                                               WHERE itemnum = #getAuctions.itemnum#
                                               ORDER BY bid DESC, time_placed ASC
                                          </cfquery>
                                          
                                          <cfset fSellPrice = 0>
                                          <cfset iCurrentQty = 0>
                                          
                                          <cfloop query="getMultiBids">
                                            
                                            <cfset fSellPrice = getMultiBids.bid>
                                            <cfset iCurrentQty = iCurrentQty + getMultiBids.quantity>
                                            
                                            <!--- if qty met, break --->
                                            <cfif iCurrentQty GTE getAuctions.quantity>
                                              <cfbreak>
                                            </cfif>
                                          </cfloop>
                                          
                                        <cfelse>
                                          <cfset fSellPrice = 0>
                                        </cfif>
                                      <cfelse>
                                        <cfset fSellPrice = 0>
                                      </cfif>
                                      
                                      <!--- def total fee --->
                                      <cfquery username="#db_username#" password="#db_password#" name="getInvoice" datasource="#DATASOURCE#">
                                          SELECT invoice_total
                                            FROM invoices
                                           WHERE itemnum = #getAuctions.itemnum#
                                      </cfquery>
                                      
                                      <cfif getInvoice.RecordCount>
                                        <cfset fTotalFees = getInvoice.invoice_total>
                                      <cfelse>
                                        <cfset fTotalFees = 0>
                                      </cfif>
                                      
                                      <!--- add to totals --->
                                      <cfset fSellPTotal = fSellPTotal + fSellPrice>
                                      <cfset fFeesTotal = fFeesTotal + fTotalFees>
                                      
                                      <cfoutput>
                                        <tr<cfif Variables.iHTMRowCount GT 2> bgcolor=bac1cf</cfif>>
                                          <td><font face="helvetica" size=1><b>#DateFormat(getAuctions.date_end, "mm/dd/yy")#</b></td>
                                          <td><a href="#VAROOT#/listings/details/index.cfm?itemnum=#getAuctions.itemnum#"><font face="helvetica" size=1 color=000080><b>#getAuctions.itemnum#</b></font></a></td>
                                          <td><font face="helvetica" size=1><b>#Mid(Trim(getAuctions.title), 1, Variables.iHTMTitleSpan)#

<cfif Len(Trim(getAuctions.title)) GT Variables.iHTMTitleSpan>...</cfif></b></td>
                                          <td><font face="helvetica" size=1><b>#Mid(Trim(getAuctions.seller_name), 1, Variables.iHTMNameSpan)#<cfif Len(Trim(getAuctions.seller_name)) GT Variables.iHTMNameSpan>...</cfif></b></td>
                                          <td><a href="#VAROOT#/search/search_results.cfm?search_type=seller_search&search_name=Search+by+Seller&search_text=#getAuctions.user_id#&order_by=title&sort_order=ASC"><font face="helvetica" size=1 color=000080><b>#getAuctions.user_id#</b></font></a></td>
                                          <td><a href="#VAROOT#/listings/index.cfm?category=#getAuctions.category1#"><font face="helvetica" size=1 color=000080><b>#getAuctions.category1#</b></a></td>
                                          <td align=center><font face="helvetica" size=1><b>#YesNoFormat(Variables.bIsSold)#</b></td>
                                          <td align=right><font face="helvetica" size=1><b>#numberformat(Variables.fSellPrice,numbermask)#</b></td>
                                          <td align=right><font face="helvetica" size=1><b>#numberformat(Variables.fTotalFees,numbermask)#</b></td>
                                        </tr>
                                      </cfoutput>
                                      
                                      <!--- reset if gte 4 --->
                                      <cfif iHTMRowCount GTE 4>
                                        <cfset iHTMRowCount = 0>
                                      </cfif>
                                      
                                      <cfsetting enablecfoutputonly="No">
                                    </cfloop>
                                    
                                    <tr>
                                      <td colspan=9>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                                    </tr>
                                    <cfoutput>
                                    <tr>
                                      <td></td>
                                      <td></td>
                                      <td></td>
                                      <td></td>
                                      <td></td>
                                      <td colspan=2 align=right><font face="helvetica" size=1><b>Total<cfif Len(Variables.sSiteCurrency)> (#Variables.sSiteCurrency#)</cfif>:</b></font></td>
                                      <td align=right><font face="helvetica" size=1><b>#numberformat(Variables.fSellPTotal,numbermask)#</b></font></td>
                                      <td align=right><font face="helvetica" size=1><b>#numberformat(Variables.fFeesTotal,numbermask)#</b></font></td>
                                    </tr>
                                    </cfoutput>
                                  </table>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </center>
      </font>
    </body>
  </html>
</cfif>
