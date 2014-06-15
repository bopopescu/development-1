<!--- include globals --->

<cfset current_page="help">
 <cfinclude template="../includes/app_globals.cfm">

<html>
 <head>
  <title>Bid Types and Bidding Information</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
  
 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>

    <tr><td><font size=4 color="000000"><b>Bidding Types and Bidding Information</b></font></td></tr>
    <tr><td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td></tr>
    <tr>
     <td>
      <font size=3>
Here is an explanation of the types of Bidding and bidding settings that you will encounter on this site.

       <br><br>

<table border=1 cellspacing=0 cellpadding=2 width=100%>


<cfoutput><tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput>
<A NAME="Regular"></A><b>Reverse Bid/Offer Types</b></td></tr>
<tr>
<td>
See our new Reverse Bid/Offer type features:&nbsp;&nbsp;<A HREF="<cfoutput>#VAROOT#</cfoutput>rev_bidtypes.cfm"><b>Reverse Bid/Offer Type</b></A>
<BR><BR>

<cfoutput><tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput>
<A NAME="Regular"></A><b>Regular Bids</b></td></tr>
<tr>
<td>
A Regular Bid is a standard in auction bidding. The amount that you place into 
this field will be the amount of the bid that you are making.
<BR><BR>
The nescessity of having to continually update your bid is a drawback to this 
type of a bid.
<br><br>
</td>
</tr>

<cfoutput><tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput>
<A NAME="Proxy"></A><b>Auto Bids</b></td></tr>
<tr>
<td>
The Auto Bid takes advantage of the computer in the On-Line auction environment.
By bidding as much as you want to spend and using a auto bid, the Visual Auction&#169; software will 
automatically advance the bidding if someone bids more than the current bid and
less than your Auto Bid.
<br><br>
Auto bids will also automatically advance the bidding to the level of the reserve
or your maximum Auto bid. Whichever is lower.
<BR><BR>
</td>
</tr>

<cfoutput><tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput>
<A NAME="Dynamic"></A><b>Dynamic Bid Times</b></td></tr>
<tr>
<td>
Dynamic Bid Time can be set by the seller when posting his or her auction.
dynamic Bidding allows for bidding to continue beyond the normal end of the 
auction if certain events occur.
<BR><BR>
When you set a value for Dynamic Bid Time this sets a watch for bids on the 
auction from that many minutes before the end of the auction. If anyone places
a bid during the Dynamic Bid window, which is measured in minutes, then the end
of the auction will be extended by the length of time of the Dymnamic Bid setting.
<br><br>
</td>
</tr>

<cfoutput><tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput>
<A NAME="Reserve"></A><b>Reserve Bid</b></td></tr>
<tr>
<td>
When a seller sets a Reserve Bid amount they are stating that this value, which is
not disclosed to the bidders, except to announce whether the Reserve Bid has 
been met, is the lowest bid that they will accept as a successful auction.
<br><br>
As a Seller this allows you to set a minimum amount that you will sell your item for.
You should be aware that setting your Reserve Bid to high will result in you item not
selling.
<br><br>
</td>
</tr>

<cfoutput><tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#"></cfoutput>
<A NAME="buynow"></A><b>Buy Now</b></td></tr>
<tr>
<td>
The BuyNow Price is set by the seller at the amount He/She is willing to sell 
their item outright.
<BR><BR>
When an item is purchased outright using BuyNow, the bidding process is bypassed.  
If there is only one item being auctioned the auction will be closed immediately.  
When there are multiple items being auctioned as in a Yankee or Dutch auction, 
the quantity is reduced untill there are no items left then the auction closed.  
The number of BuyNow purchased is shown next to the number of bids on auction 
details page.
<br><br>
</td>
</tr>
</table></td>
</tr>
</table><cfoutput>
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