<cfset current_page="help"><!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">

<html>
 <head>
  <title>Reverse Bid/Offer Types</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
  
 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<div align="center">
<table border=0 cellspacing=0 cellpadding=2 width=800>


    <tr><td>
   <table border=0 cellspacing=0 cellpadding=2 width=800>


    <tr><td><font size=4 color="000000"><b>Reverse Bid/Offer Information</b></font></td></tr>
    <tr><td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td></tr>
    <tr>
     <td >
      <font size=3>
Here is an explanation of the types of Bid/Offer settings that you will encounter on this site.

       <br><br>
</table>
<table border=1 cellspacing=0 cellpadding=2 width=100%>

<!--- Use this code to specify additional items of information
<tr bgcolor="000080"><td><font color="ffffff"><b>
Heading Here
</b></td></tr>
<tr>
<td>
Information Here
<br><br>
</td>
</tr>
--->

<tr bgcolor="<cfoutput>#heading_color#</cfoutput>"> <td style="color:#heading_fcolor#; font-family:#heading_font#"><b>
<A NAME="Regular">Regular Bids/Offers</A>
</b></td></tr>
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

<tr bgcolor="<cfoutput>#heading_color#</cfoutput>"> <td style="color:#heading_fcolor#; font-family:#heading_font#"><b>
<A NAME="Proxy">Auto Bids/Offers</A>
</b></td></tr>
<tr>
<td>
The Auto Bid takes advantage of the computer in the On-Line auction environment.
Sellers set the minimum amount they are willing to provide the items or services. Using a auto bid, the Visual Auction&#169; software will automatically advance the bidding if someone bids less than the current bid and
more than your auto bid.
<br><br>
Auto bids will also automatically advance the bidding to the level of the reserve
or your minimum auto bid. Whichever is higher.
<BR><BR>
</td>
</tr>

<tr bgcolor="<cfoutput>#heading_color#</cfoutput>"> <td style="color:#heading_fcolor#; font-family:#heading_font#"><b>
<A NAME="Regular">Dynamic Bid/Offer Times</A>
</b></td></tr>
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
<tr bgcolor="<cfoutput>#heading_color#</cfoutput>"> <td style="color:#heading_fcolor#; font-family:#heading_font#"><b>
Reserve Bid/Offer
</b></td></tr>
<tr>
<td>
When a seller sets a Reserve Bid amount they are stating that this value, which is
not disclosed to the bidders, except to announce whether the Reserve Bid has 
been met, is the highest bid that they will accept as a successful auction.
<br><br>
As a buyer this allows you to set a maximum amount that you will pay for an item or service.
You should be aware that setting your Reserve Bid to low might result in you item not
selling.
<br><br>
</td>
</tr>
</table></td></tr></table><cfoutput>
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
      </table></cfoutput></div></body>
</html>