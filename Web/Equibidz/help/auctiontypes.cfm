<!--- include globals --->

<cfset current_page="help">
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<html>
  <head>
    <title>Auction Types</title>
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
     <!--- The main table --->
<div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            <font size=4 color="000000">
              <b>Auction Types - Standard</b>
            </font>
          </td>
        </tr>
        <tr>
          <td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
        </tr>
        <tr>
          <td>
            <font size=3>
              Here are the types of auctions you will encounter on this site.
              <br>
              <br>
              <table border=1 cellspacing=0 cellpadding=2 width=100%>
                <!--- Use this code to specify additional items of information
                <tr bgcolor="000080">
                  <td>
                    <font color="ffffff">
                      <b>Heading Here</b>
                    </font>
                  </td>
                </tr>
                <tr>
                  <td>
                    Information Here
                    <br>
                    <br>
                  </td>
                </tr>
                --->
                
				<cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="ENGLISH"></A><b>English Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    English auctions are probably the most common type. Users bid the highest
                    price they are willing to pay for an item and bidding activity stops when
                    the auction duration is complete. The item is sold to the highest bidder at their bid price.
                    <BR>
                    <BR>
                    English auctions also allow the seller to specify a reserve price below
                    which the item will not be sold.
                    <br>
                    <br>
                  </td>
                </tr>
				
                <cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="VICKREY"></A><b>Vickrey Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    The Vickrey auction allows for selling single items as does the English
                    Auction. The difference is that the highest bidder obtains the item at the price offered by the second highest bidder. This is a good format because bidders have the incentive to bid what they think the item is worth and not worry about what others will bid.
                    <br>
                    <br>
                  </td>
                </tr>
				
                <cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="DUTCH"></A><b>Dutch Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    Dutch auctions are special type of auction designed to handle the case 
                    where a seller has a number of identical items to sell. The seller 
                    should specify the minimum price (starting  bid) and the exact number 
                    of items that are available at that price. The bidders bid at or 
                    above that minimum price for the number of items that they are 
                    interested in buying. At the end of the auction, the highest bidders 
                    earn the right to purchase those items at the minimum successful bid. 
                    <BR>
                    <BR>
                    Here is an example, say there are twenty-five widgets being sold 
                    at $75.00 and forty-five bidders bid for one widget each, at $75.00. 
                    In this case, only the first twenty-five people will be the bidders 
                    who get their product successfully. Since the bid amounts are the 
                    same, the earlier bids will take merchandise. 
                    <BR>
                    <BR>
                    Now, let's say that one of those people bids $100 for one widget. 
                    Since his bid is higher than all the others, he will certainly be 
                    one of the bidders to get the merchandise.
                    <BR>
                    <BR>
                    If bidders continue to bid higher than the starting price enough 
                    times, then the final bidding price will increase as well. In 
                    another instance, if less than twenty-five people bid in our 
                    example "widget" auction, only that number of widgets will be sold 
                    at the opening price of $75.00. For the selling price to increase 
                    past the opening price specified by the seller there must be a 
                    higher or equal level of demand than the supply indicated. In our 
                    example, the selling price would only increase if twenty-four or 
                    more widgets were bid on, no matter what the amount of each bid.
                    <BR>
                    <BR>
                    In a case where a bidder bids for multiple quantities, the bidder 
                    who bid the lowest will not always get the merchandise that he/she 
                    bid on.  If the bidder who made the lowest bid requested a quantity 
                    of four widgets, he/she may not even be entitled to one widget.  
                    For instance, if 12 other higher bidders each bought two widgets, 
                    there would only 1 widget left.  In this case, the original bidder 
                    would only be entitled to one widget, even though he originally bid 
                    for four.  The way around this problem is to ensure that you are not 
                    the lowest successful bidder. Note: <I>A bid's value in the auction is 
                    determined by the total number of items bid on, multiplied by the 
                    bid price</I>.
                    <BR>
                    <BR>
                  </td>
                </tr>
				
                <cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="YANKEE"></A><b>Yankee Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    A Yankee Auction is a variation of the Dutch Auction where successful
                    bidders pay what they bid as opposed to paying the price determined 
                    by the lowest qualified bidder (as in a Dutch Auction).
                    <br>
                    <br>
                  </td>
                </tr>
              </table>
            </font>
          </td>
        </tr></table><cfoutput>
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>
  </body>
</html>
