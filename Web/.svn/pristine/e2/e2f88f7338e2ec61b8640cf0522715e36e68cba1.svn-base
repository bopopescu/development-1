<cfset current_page="help"><!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<html>
  <head>
    <title>Search Engine</title>
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
<div align="center">
<cfoutput>
   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
                        <br>
            <br>
          </td>
        </tr>
        <tr>
          <td>
            <font size=4 color="000000">
              <b>Search Engine</b>
            </font>
          </td>
        </tr>
        <tr>
          <td><hr width=100% size=1 color="#heading_color#" noshade></td>
        </tr>
        <tr>
          <td>
            <font size=3>
              <table border=1 cellspacing=0 cellpadding=2 width=100%>
                <tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                
                      <b><a name="titlesearch">Item Title and Description Search</a></b>
                   
                  </td>
                </tr>
                <tr>
                  <td>
                    <b>Noise words:</b> This version of search makes extensive use of the noise
                    words <i>and</i>, <i>or</i>, and <i>not</i> for building logical comparisons
                    in your searches.<br>
                    <br>
                    <b>Phrases:</b> Searching for an exact phrase is easy.  Simply enter the phrase
                    you would like to search for.  (ie. fried green tomatoes)<br>
                    <br>
                    <b>Wild Cards:</b> This version of search excepts two type of wild cards, 
                    multi-character wild cards (*) and single character wild cards (?).  To search 
                    for "fried green tomatoes" or "fried green tomato" try something like this 
                    (fried green tomato*) or something like this (fried green tomato??).<br>
                    <br>
                    <b>Combinations:</b> Using noise words with phrases and wild cards you can build
                    some pretty complex searches. ie.<br>
                    <br>
                    (fried or green or tomatoes)<br>
                    (fried* or green tomatoes)<br>
                    (fried*tomatoes)<br>
                    (*green*tomato??)<br>
                    <br>
                    Try all sorts of interesting combinations.  You'll never know what you might find.<br>
                    <br>
                  </td>
                </tr>
                <tr bgcolor="#heading_color#">
               <td style="color:#heading_fcolor#; font-family:#heading_font#">
                
                      <b><a name="itemsearch">Item Search</a></b>
                  
                  </td>
                </tr>
                <tr>
                  <td>
                    Item search enables you to locate an item by its number.  Simply enter the item's 
                    number in the field and if it exist in our database we'll find it for you.<br>
                    <br>
                    If you would like to find more then one item at a time just enter each item's number 
                    in the field seperating each one with a comma.  (ie. 927156789,927157354,927161657)<br>
                    <br>
                  </td>
                </tr>
                <tr bgcolor="#heading_color#">
                 <td style="color:#heading_fcolor#; font-family:#heading_font#">
            
                      <b><a name="sellersearch">Search by Seller</A></b>
                 
                  </td>
                </tr>
                <tr>
                  <td>
                    If you would like to find all auctions by a particular seller you have been dealing
                    with then you can do so by using Search by Seller.  It's easy.  Just enter the seller's
                    Nickname or User ID in the field and if they are a registered user on our site we'll
                    find all the auctions they have held here.<br>
                    <br>
                  </td>
                </tr>



<tr bgcolor="#heading_color#">
                 <td style="color:#heading_fcolor#; font-family:#heading_font#">
                   
                      <b><a name="buyersearch">Search by bidder</A></b>
                  
                  </td>
                </tr>
                <tr>
                  <td>
                    If you would like to find all auctions by a particular bidder you have been dealing
                    with then you can do so by using Search by bider.  It's easy.  Just enter the bidder's
                    Nickname or User ID in the field and if they are a registered user on our site we'll
                    find all the auctions they have bid here.<br>
                    <br>
                  </td>
                </tr>


              </table>
            </font>
          </td>

        </tr></table>
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
