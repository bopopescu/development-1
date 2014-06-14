<html>
 <head>
  <title>Auction Server 6.0 Administrator [Admin Setup Module]</title>



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

 <cfinclude template="../includes/app_globals.cfm">
 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <!--- Main page body --->
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
	     <cfset #page# = "admin">
	     <cfinclude template="menu_include.cfm">      
		<cfquery name="GetItems" datasource="#datasource#" dbtype="ODBC">
			Select itemnum, title, minimum_bid, date_end, date_start,buynow,buynow_price
			From items
			Where user_id = #Form.user_id#
			Order by Title ASC
		</cfquery>
	<tr><td colspan="5">
		<table border="1">
		  <tr bgcolor="0c546c">

<cfquery name="GetUsers1" datasource="#datasource#" dbtype="ODBC">
		Select user_id, nickname
		From users
where is_active=1
and user_id=#form.user_id#
	</cfquery>

		  	<cfoutput><td ><center><cfif #GetItems.RecordCount# neq 0><font color=black size=3 ><b>#getusers1.nickname#:</b></font><font color=red> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#GetItems.RecordCount# item(s) found &nbsp;</font><cfelse><font color=red>No item found</font>  </cfif></center></td></cfoutput>
		  </tr>
		  <tr><td colspan="10" align="center"   >		  <table bgcolor=black align="center" width=750>
		  	<tr bgcolor=0c546c>
				<td width="15">&nbsp;</td>
<cfif #getitems.recordcount# neq 0>
<input type="checkbox" name="selectAll " onClick="return checkAll();"></cfif></td>
				<td align="center"><b>Item Number</b></td>
		  		<td align="center" ><b>Title</b></td>
		  		 <td align="center" ><b>Price</b></td>
 <td align="center" ><b>Buynow</b></td>
 <td align="center" ><b>Buynow Price</b></td>
<td align="center" ><b>Bids</b></td>		  		 
 <td align="center" ><b>Current Bid</b></td>

 
		  		 <td align="center" ><b>High Bidder</b></td>
				<td align="center"><b>Start</b></td>
				<td align="center"><b>End</b></td></tr>


		<form action="auctions.cfm?action=delete" method="post" name=numbskull>
		<cfoutput query="GetItems">


  <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
              SELECT COUNT(itemnum) AS total
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
          <!--- get highest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
			   AND buynow = 0
          </cfquery>
		  
		  <!--- get lowest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #itemnum#
          </cfquery>
          
<!---
 <cfif #highestbid.recordcount# neq 0 and #highestbid.price#  neq "" >

  <cfquery name="getBidder" datasource="#DATASOURCE#">
    select bids.user_id,users.user_id,users.nickname,users.email
	from bids,users
	where bids.bid = #HighestBid.price#
	and bids.itemnum = #itemnum#
and bids.user_id=users.user_id

  </cfquery>
</cfif>

--->


<cftry>
  <cfquery name="getBidder" datasource="#DATASOURCE#">
    select bids.user_id,users.user_id,users.nickname,users.email
	from bids,users
	where bids.bid =  <cfif #highestbid.recordcount# neq 0 and #highestbid.price#  neq ""  >#HighestBid.price#<cfelseif #lowestbid.recordcount# neq 0 and #lowestbid.price#  neq "">#lowestbid.price#</cfif>
	and   bids.itemnum = #itemnum#
and bids.user_id=users.user_id

  </cfquery>
<cfcatch>
</cfcatch>
</cftry> 




			  <tr bgcolor="eeeeff">
			  	  <td align="center" width="15"><input type="checkbox" name="itemnum" value="#itemnum#"></td>
			  	  <td align="center"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank><font color=black>#itemnum#</font></a></td>
			  	  <td width="225"><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank ><font color=black size="-1">#title#</font></a></td>

 <td ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank ><font color=black size="-1">#minimum_bid#</font></a></td>
 <td ><cfif #getitems.buynow# ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank ><font color=black size="-1">buynow</font></a></cfif></td>
 <td ><cfif #getitems.buynow# ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank ><font color=black size="-1">#buynow_price#</font></a></cfif></td>
 <td ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank ><font color=black size="-1">#CountBids.total#</font></a></td>
 <td ><a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum# "target=_blank ><font color=black size="-1">#highestbid.price#</font></a></td>
 

 <td >
<cfif #countbids.total# neq 0><a href="mailto:#getbidder.email#"><font size="-1" color=black> #getBidder.nickname#</font><cfelse><font size="-1" color=black>No bid yet</font></a></cfif></td>
			  <td width="75" align="center">#DateFormat(date_start, 'mm/dd/yyyy')#<br>
				  				  </td>
				  <td width="75" align="center">#DateFormat(date_end, 'mm/dd/yyyy')#<br>
				  				  </td></tr>
			</cfoutput>
			<tr bgcolor="eeeeef"><td colspan="11" align="center">
<cfif #getitems.recordcount# neq 0>
<input type="submit" value="Delete Item(s)" onclick="return confirm('Are you sure you want to delete these items?');"></cfif>
			<input type="button" value="Go Back" Onclick="history.back();">
			</td></tr>
		 </form>

		  </table>
		  </td></tr></table>
		</td></tr>
	</table>
   </center>
  </font>
 </body>
</html>


