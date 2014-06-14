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
   <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            <font size=4 color="000000">
              <b>Reverse Auction Features</b>
            </font>
          </td>
        </tr>
        <tr>
          <td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
        </tr>
        <tr>
          <td>
            <font size=3>
              Reverse Auctions are a specialized auction format that allows individuals/organizations to procure goods and services at the <b>lowest possible price</b>. Featuring <b>decreasing incremental bidding</b>, the format lets potential suppliers submit a bid and the supplier with the lowest price will win. In other words, prospective buyers can list any items that they wish to buy, and then sellers bid to provide the best price. The consumer decides the exact specifications of each item, instead of the specifications being dictated by the seller.
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
                      <A NAME="ENGLISH"></A><b>Reverse English Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    English auctions are probably the most common type. Sellers bid the lowest
                    price they are willing to sell an item for and bidding activity stops when
                    the auction duration is complete. The item is bought from the lowest bidder at their bid price.
                    <BR>
                    <BR>
                    English auctions also allow the buyer to specify a reserve price above
                    which the item will not be bought.
                    <br>
                    <br>
                  </td>
                </tr>
				
                <cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="VICKREY"></A><b>Reverse Vickrey Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    The Vickrey auction allows for selling single items as does the English
                    Auction. The difference is that the lowest bidder sells the item at the price offered by the second lowest bidder. This is a good format because sellers have the incentive to bid what they think the item is worth and not worry about what other sellers will bid.
                    <br>
                    <br>
                  </td>
                </tr>
				
                <cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="DUTCH"></A><b>Reverse Dutch Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    Dutch auctions are special type of auction designed to handle the case 
                    where a buyer has a number of identical items they wish to buy. The buyer 
                    should specify the maximum price (starting  bid) and the exact number 
                    of items that are they wish to buy at that price. The sellers bid at or 
                    below that maximum price for the number of items that they are 
                    interested in selling. At the end of the auction, the lowest bidders 
                    earn the right to sell those items at the minimum successful bid. 
                    <BR>
                    <BR>
                    Here is an example, say a buyer wishes to purchase twenty-five widgets at maximum starting bid of $75.00 and forty-five sellers place bids for one widget each, at $75.00. 
                    In this case, only the first twenty-five sellers will be the bidders 
                    who will sell their product successfully. Since the bid amounts are the 
                    same, the earlier bids will sell merchandise. 
                    <BR>
                    <BR>
                    Now, let's say that one of the sellers bids $50 for one widget. 
                    Since his bid is lower than all the others, he will certainly be 
                    one of the bidders to sell his/her merchandise.
                    <BR>
                    <BR>
                    If sellers continue to bid lower than the starting price enough 
                    times, then the final bidding price will decrease as well. In 
                    another instance, if less than twenty-five people bid in our 
                    example "widget" auction, only that number of widgets will be sold 
                    at the opening price of $75.00. For the selling price to decrease 
                    past the opening price specified by the buyer there must be a 
                    higher or equal level of sellers than the supply indicated. In our 
                    example, the buying price would only decrease if twenty-five or 
                    more widgets were bid on, no matter what the amount of each bid.
                    <BR>
                    <BR>
                    In a case where a seller bids to sell multiple quantities, the seller 
                    who bid the lowest will not always sell the merchandise that he/she 
                    bid on.  If the seller who made the lowest bid made available a quantity 
                    of four widgets, he/she may not even be entitled to sell one widget.  
                    For instance, if 12 other lower bidder/sellers each sold two widgets, 
                    there would only 1 widget left.  In this case, the original bidder/seller 
                    would only be entitled to sell one widget, even though he originally bid 
                    for four.  The way around this problem is to ensure that you are not 
                    the highest successful bidder. Note: <I>A bid's value in the auction is 
                    determined by the total number of items bid on, multiplied by the 
                    bid price</I>.
                    <BR>
                    <BR>
                  </td>
                </tr>
                <cfoutput><tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <A NAME="YANKEE"></A><b>Reverse Yankee Auctions</b>
                  </td>
                </tr></cfoutput>
                <tr>
                  <td>
                    A Yankee Auction is a variation of the Dutch Auction where successful
                    bidders sell what they bid as opposed to selling at the price determined 
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
