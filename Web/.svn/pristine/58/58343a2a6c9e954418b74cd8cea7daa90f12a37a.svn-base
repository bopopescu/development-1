  <SCRIPT LANGUAGE="JavaScript">
  <!-- Hide from other browsers

    function checkAll()
    {
      for (var i=0;i<document.numbskull.itemnum.length;i++)
      {
        var e = document.numbskull.itemnum[i];
        if (e.name != 'selectAll')
          e.checked = !e.checked;
      }
    }
	

  // Stop Hididng from other Browsers  -->
  </SCRIPT>
<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

<cfsetting enablecfoutputonly="Yes">
<!--- Include session tracking template --->
<cfinclude template="../../includes/session_include.cfm">

<!--- include globals --->
  <cfinclude template="../../includes/app_globals.cfm">




<cfif #ParameterExists(delete)#>
<cfif ParameterExists(Form.itemnum)>
		  <cfloop index="item" list="#Form.itemnum#">

<cfquery datasource="#datasource#">
delete  from items
where itemnum = #item#
</cfquery>
</cfloop>
</cfif>
</cfif>


<cfif #ParameterExists(cancel)#>
<cfif ParameterExists(Form.itemnum)>
		  <cfloop index="item" list="#Form.itemnum#">

<cfquery datasource="#datasource#">
update items

set status=0
where itemnum = #item#
</cfquery>
</cfloop>
</cfif>
</cfif>



<!--- Always check for valid username/password --->
<cfinclude template="../../admin/validate_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">

<!--- Get the auctions --->
<cfquery username="#db_username#" password="#db_password#" name="auctions" datasource="#DATASOURCE#">
  SELECT   itemnum,
           title,
           date_start,
           date_end,
           buynow_price,
           reserve_bid
  FROM     items
  order by date_end DESC

</cfquery>

<cfoutput>

<html>
 <head>
  <title>Visual Auction Server Administrator</title>
  <style type="text/css">
    <!--
    .AuctionCompleted {
      font-family: Helvetica, Arial, sans-serif;
      font-size: 12px;
      color: ##FF0000;
    }
    
    .AuctionNotStarted {
      font-family: Helvetica, Arial, sans-serif;
      font-size: 12px;
      color: ##000000;
    }
    
    .AuctionItem {
      font-family: Helvetica, Arial, sans-serif;
      font-size: 12px;
      color: ##00AA00;
    }
    
    .HeaderLink {
      font-family: Helvetica, Arial, sans-serif;
      font-size: 13px;
      color: ##000000;
      font-weight: bold;
    }
    
    .Bold {
      font-weight: bold;
    }
    -->
  </style>
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="../validate_include.cfm">

 <!--- Main page body --->
 <body bgcolor=ffffff link=ffffff alink=ffaa00 vlink=999999>
  <font face="helvetica" size=2>
   <center>

    <!--- The main table encapsulating everything on the page --->
    <table border=0 cellspacing=0 cellpadding=0>

            <tr bgcolor=0c546c>
              <td bgcolor=ffffff><img border=0 src="../images/left.gif"></td>
              <td><img border=0 src="../images/top_banner.gif"></td>
              <td><img border=0 src="../images/header_fill.gif" width=124 height=25></td>
              <td><a href="http://www.visualauction.com/help/online/"><img border=0 src="../images/help.gif" alt="View Help"></a><a href="../login.cfm"><img border=0 src="../images/logout.gif" alt="Logout"></a></font></td>
              <td bgcolor=ffffff align=right><img border=0 src="../images/right.gif"></td>
            </tr>

     <!--- Include the menubar --->
     <cfset #page# = "list_auctions">
     <cfinclude template="../menu_include.cfm">      

     <tr>
      <td colspan=5 bgcolor=bac1cf>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
              <td>
                <p>Auctions - #auctions.RecordCount# Items Found</p>

<cfif #auctions.recordcount# neq 0>


<input type="checkbox" name="selectAll " onClick="return checkAll();">
	Check All<br></cfif>


<form  name="numbskull" action="auctions.cfm" method="post">

                <table border="0" width="100%" bgcolor="##FFFFFF">
                  <tr>
                    <td nowrap><a href="##" class="HeaderLink">Item ##:</a></td>
                    <td nowrap><a href="##" class="HeaderLink">Title:</a></td>
                    <td nowrap><a href="##" class="HeaderLink">Status:</a></td>
                    <td nowrap align="right"><a href="##" class="HeaderLink">BuyNow:</a></td>
                    <td nowrap align="right"><a href="##" class="HeaderLink">Reserve:</a></td>
                    <td nowrap align="right"><a href="##" class="HeaderLink">Current:</a></td>
                  </tr>
  <cfloop query="auctions">
    <!--- def if auction complete --->
    <cfmodule template="../../functions/auction_complete.cfm" iItemnum = "#itemnum#">

    <!--- define time left --->
    <cfset completed = hAuctionComplete.bComplete>
    <cfif hAuctionComplete.bComplete>
      <cfset timeleft = "Completed">
      <cfset cssStyle = "AuctionItem">
    <cfelseif auctions.date_start GT TIMENOW>
      <cfset timeleft = #auctions.date_start# - TIMENOW>
      <cfif timeleft GT 1>
        <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
        <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
        <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
        <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
        <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
        <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & " +">
      <cfelse>
        <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
        <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
        <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
        <cfset minslabel = IIf(minsleft IS 1, DE("min"), DE("mins"))>
        <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
      </cfif>
      <cfset timeleft = "Starts in " & timeleft>
      <cfset cssStyle="AuctionNotStarted">
    <cfelse>
      <cfset timeleft = hAuctionComplete.tsDateEnd - TIMENOW>
      <cfif timeleft GT 1>
        <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
        <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
        <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
        <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
        <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
        <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & " +">
      <cfelse>
        <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
        <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
        <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
        <cfset minslabel = IIf(minsleft IS 1, DE("min"), DE("mins"))>
        <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
      </cfif>
      <cfset timeleft = "Ends in " & timeleft>
      <cfset cssStyle="AuctionCompleted">
    </cfif>
    
    <!--- check to see if the item has been sold --->
    <cfquery username="#db_username#" password="#db_password#" name="qrySold" datasource="#DATASOURCE#">
      SELECT winner
      FROM   bids
      WHERE  itemnum = #auctions.itemnum# AND
             winner = 1
    </cfquery>
    <cfset itemSold = qrySold.RecordCount EQ 1>
    
    <!--- get the highest bidder --->
    <cfquery username="#db_username#" password="#db_password#" name="qryHighBid" datasource="#DATASOURCE#">
      SELECT MAX(bid) AS high_bid
      FROM   bids
      WHERE  itemnum = #auctions.itemnum#
    </cfquery>
      
                  <tr #IIf(itemSold, DE("class=""Bold"""), DE(""))#>
                    <td class="#cssStyle#">
                     

<input type="checkbox" name="itemnum" value="#itemnum#">
 <a href="../../listings/details/index.cfm?itemnum=#auctions.itemnum#" target="_blank" class="#cssStyle#"><img src="../../images/icon_bid.gif" border="0" align="absmiddle" width="15"></a>
                      <a href="bidhistory.cfm?itemnum=#auctions.itemnum#" class="#cssStyle#">#auctions.itemnum#</a>
                      &nbsp;
                    </td>
                    <td ><a href="../auction_item.cfm?selected_item=#itemnum#&submit=edit"><font color=blue>#auctions.title#</font>&nbsp;</a></td>
                    <td class="#cssStyle#" nowrap>#timeleft#&nbsp;</td>
                    <td align="right" class="#cssStyle#">#LSCurrencyFormat(auctions.buynow_price)#&nbsp;</td>
                    <td align="right" class="#cssStyle#">#LSCurrencyFormat(auctions.reserve_bid)#&nbsp;</td>
                    <td align="right" class="#cssStyle#">#LSCurrencyFormat(qryHighBid.high_bid)#&nbsp;</td>
                  </tr>
  </cfloop>





<cfif #auctions.recordcount# neq 0>
<tr>

<td>

<input type="submit" name="delete" value="Delete items(s)" onclick="return confirm('Are you sure you want to delete these items?');">


<input type="submit" name="status" value="Cancel auctions(s)" onclick="return confirm('Are you sure you want to end these items early?');">

			<input type="button" value="Go Back" Onclick="history.back();">
<cfelse>
		<input type="button" value="Go Back" Onclick="history.back();">
</td>
</tr>
</cfif>

                </table>


</form>
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

</cfoutput>
