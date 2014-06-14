<cfoutput>

 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
  
<cfif session.auction_mode is 0>
<!--Regular Auctions -->
          <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
            <tr>
              <td colspan=4>
                <center>
                  <font size=3>#Trim(get_ItemInfo.title)# (Item ###get_ItemInfo.itemnum#)</font><br>
                </center>
                <br>
              </td>
            </tr>
            <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
              <tr>
                <td></td>
                <td align=left>
                  <font size=3>
                    Current Bid:
                  </font>
                </td>
                <td align=right>
                  #dollarformat(bid_currently-get_ItemInfo.increment_valu)# #Trim(getCurrency.type)#
                </td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td align=left>
                  <font size=3>
                    Bid Increment:
                  </font>
                </td>
                <td align=right>
                  #dollarformat(get_ItemInfo.increment_valu)# #Trim(getCurrency.type)#
                </td>
                <td></td>
              </tr>
            </cfif>
            <tr>
              <td width=180></td>
              <td width=140 align=left>
                <font size=3>
                  <b>Minimum Bid</b>
                </font>
              </td>
              <td width=140 align=right>
                <b>#dollarformat(bid_currently+get_ItemInfo.increment_valu)# #Trim(getCurrency.type)#</b>
              </td>
              <td width=180></td>
            </tr>
            <tr>
              <td valign=top colspan=4>
                <font size=2>
                  <br>
                  <b>Registration Required.</b>  You must be a registered user in order to 
                  place a bid.  <a href="#VAROOT#/registration/index.cfm">Click here</a> to find 
                  out how to become a registered user.
                </font>
              </td>
            </tr>
          </table>
          <cfif IsDefined("Variables.isGoodBid")>
            <cfif not isGoodBid>
              
              <!--- if whyBadBid not defined, def it --->
              <cfif not IsDefined("whyBadBid")>
                
                <cfset whyBadBid = "">
              </cfif>
              
              <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
                <tr>
                  <td>
                    <br>
                    #hlightStart#<font size=3 color="red">
                    <b>ERROR:<b><br>
                    <cfloop index="l" list="#whyBadBid#">
                      #l#<br>
                    </cfloop>
                    </font>#hlightEnd#<br><br>
                  </td>
                </tr>
              </table>
            </cfif>
          </cfif>
          <!--- display bidding form --->
          <!---<form name="bidForm" action="#VAROOT#/bid/index.cfm" method="POST">--->
          <form name="bidForm" action="index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="POST">
            <input type="hidden" name="curr_cat" value="#curr_cat#">
            <input type="hidden" name="curr_lvl" value="#curr_lvl#">
		  
            <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
              <tr>
                <td width=220>
                  <b>User ID</b> or <b>Nickname</b><br>
                  <input type=text name="nickname" value="<cfif isdefined("user_id") and user_id neq "" and isdefined("password") and password neq "">#user_id#<cfelse>#userNickname#</cfif>" size=20>
                </td>
                <td width=220>
                  <b>Password</b> (<a href="#VAROOT#/registration/findpassword.cfm">forgotten it?</a>)<br>
                  <input type=password name="password" value="<cfif isdefined("user_id") and user_id neq "" and isdefined("password") and password neq "">#password#<cfelse></cfif>" size=20>
                </td>
                <td width=200></td>
              </tr>
              <tr>
                <td colspan=2>
                  <br>
                  <!--- quantity if dutch or yankee --->
                  <cfif get_ItemInfo.auction_type IS "D" OR get_ItemInfo.auction_type IS "Y">
                    <cfset quantity = iif(len(quantity) lt 1, "1", "quantity")>

                    <b>Quantity</b> you are bidding for.<br>
                    <input type=text name="quantity" value="#quantity#" size=10><br>
                    <br>
                  <cfelse>
                    <input type=hidden name="quantity" value="1">
                  </cfif>
                  <!--- bid type if not dutch or yankee --->
                  <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
                    <b><a href="#VAROOT#/help/bidtypes.cfm">Bid type</a>.</b><br>
                    <select name="bidType">
                      <option value="REGULAR"<cfif defBidType IS "REGULAR"> selected</cfif>>Regular bid</option>
                      <option value="PROXY"<cfif defBidType IS "PROXY"> selected</cfif>>Auto bid</option>
                    </select><br>
                    <br>
                  <cfelse>
                    <input type="hidden" name="bidType" value="REGULAR">
                  </cfif>
                  <!--- bid --->
                  <b>Your Bid.</b><br>
                  <cfset userBid = iif(len(userBid) lt 1, "minimumBid", "userBid")>

                  <input type=text name="bid" value="#REReplace(userBid, "[^0123456789.]", "", "ALL")#" size=10 maxlength=10> (The amount you are offering for <cfif get_ItemInfo.auction_type IS "D" OR get_ItemInfo.auction_type IS "Y"><b>each</b><cfelse>this</cfif> item.)<br>
				  <input type=hidden name="requiredBid" value="#REReplace(minimumBid, "[^0123456789.]", "", "ALL")#" size=10>
                  <br>
                  Please enter only numerals and the decimal point.  Do not include 
                  currency symbols such as a dollar sign ('$') or commas (',').  Unless 
                  otherwise noted, bids are in #Trim(getCurrency.type)# (#currencyName#)<br>
                  <br>
                  <cfif enableSSL>
                    <b>Use <a href="https://#CGI.SERVER_NAME##VAROOT#/bid/index.cfm?itemnum=#get_ItemInfo.itemnum#">Secure Sockets Layer</a></b><br>
                    This form is unsecure.  Click the preceeding link if you 
                    would like to use <a href="#VAROOT#/help/ssl.html">Secure&nbsp;Sockets&nbsp;Layer</a> 
                    to place a bid on this item.<br>
                    <br>
                  </cfif>
                  <b>Binding contract.</b><br>
                  Placing a bid is a binding contract in many states and provinces. 
                  Do not bid unless you intend to buy this item at the amount of your bid.<br>
                  <br>
                  <!--- auction type --->
                  <cfif get_ItemInfo.auction_type IS "E">
                    <b>This is an <a href="#VAROOT#/help/auctiontypes.html##ENGLISH">English auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    English auctions before bidding.<br>
                  <cfelseif get_ItemInfo.auction_type IS "V">
                    <b>This is a <a href="#VAROOT#/help/auctiontypes.html##VICKERY">Vickery auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    Vickery auctions before bidding.<br>
                  <cfelseif get_ItemInfo.auction_type IS "D">
                    <b>This is a <a href="#VAROOT#/help/auctiontypes.html##DUTCH">Dutch auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    Dutch auctions before bidding.<br>
                  <cfelseif get_ItemInfo.auction_type IS "Y">
                    <b>This is a <a href="#VAROOT#/help/auctiontypes.html##YANKEE">Yankee auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    Yankee auctions before bidding.<br>
                  </cfif>
                  If you have bid on this item before, your new bid 
                  must be greater than your previous bid.<br>
                  <br>
                  <input type=submit value="Review Bid" name="reviewBid">
			      <input type="button" <cfif isdefined("buynow_yes")>value="Cancel BuyNow"<cfelse>value="Cancel Bid"</cfif> onClick="JavaScript:history.back(1)">
                  <br>
                  <input type=hidden name="itemnum" value="#get_ItemInfo.itemnum#">
                  <br>
                </td>
				
				<cfif #get_iteminfo.buynow# eq 1>
				
				<!--- get bids over buynow price --->
				<!--- <cfquery username="#db_username#" password="#db_password#" name="getbidsoverbuynow" datasource="#DATASOURCE#">
        			SELECT count(bid) as cnt_bidover_buynow_price
          			FROM bids
         			WHERE itemnum = #itemnum#
		 			AND bid > #get_ItemInfo.buynow_price#
    			</cfquery> --->
				
			  <cfif numberformat(REReplace(minimumBid, "[^0123456789.]", "", "ALL"),'#numbermask#') lte numberformat(get_ItemInfo.buynow_price,'#numbermask#')><!--- ((get_ItemInfo.auction_type IS "E" or get_ItemInfo.auction_type IS "V") and minimumbid lte get_ItemInfo.buynow_price) or ((get_ItemInfo.auction_type IS "D" or get_ItemInfo.auction_type IS "Y") and  getbidsoverbuynow.cnt_bidover_buynow_price lt get_ItemInfo.quantity) --->	
			  <td valign="top">
			  	<table>
					<tr>
						<td><img src="../images/dummy_black.gif" width="1" height="100"></td>	
						<td align="left" valign="top">
						<b>Buy now price</b><br>
						#numberformat(get_iteminfo.buynow_price, '#numbermask#')#&nbsp;#Trim(getCurrency.type)#
						
						<input type=submit value="Buy Now" name="buynow_yes">
						<input type="button" name="back" value="Back" onClick="JavaScript:history.back(1)">
						</td>
					</tr>
			  	</table>
			  </td>
			  </cfif>
			  </cfif>
              </tr>
            </table>
          </form>
          
          
          
          
          
          
<cfelse>







<!-- Reverse Auction -->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
            <tr>
              <td colspan=4>
                <center>
                  #Trim(get_ItemInfo.title)# (Item ###get_ItemInfo.itemnum#)<br>
                </center>
                <br>
              </td>
            </tr>
            <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
              <tr>
                <td></td>
                <td align=left>
                  <font size=2>
                    Current Offer
                  </font>
                </td>
                <td align=right>
                  #bid_currently# #Trim(getCurrency.type)#
                </td>
                <td></td>
              </tr>
              <tr>
                <td></td>
                <td align=left>
                  <font size=2>
                    Offer Decrement
                  </font>
                </td>
                <td align=right>
                  #bidIncrement# #Trim(getCurrency.type)#
                </td>
                <td></td>
              </tr>
            </cfif>
            <tr>
              <td width=180></td>
              <td width=140 align=left>
                <font size=2>
                  <b>Maximum Offer</b>
                </font>
              </td>
              <td width=140 align=right>
                <b>#maximumBid# #Trim(getCurrency.type)#</b>
              </td>
              <td width=180></td>
            </tr>
            <tr>
              <td valign=top colspan=4>
                <font size=2>
                  <br>
                  <b>Registration Required.</b>  You must be a registered user in order to 
                  place an offer.  <a href="#VAROOT#/registration/index.cfm">Click here</a> to find 
                  out how to become a registered user.
                </font>
              </td>
            </tr>
          </table>
          <cfif IsDefined("Variables.isGoodBid")>
            <cfif not isGoodBid>
              
              <!--- if whyBadBid not defined, def it --->
              <cfif not IsDefined("whyBadBid")>
                
                <cfset whyBadBid = "">
              </cfif>
              
              <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
                <tr>
                  <td>
                    <br>
                    #hlightStart#<font size=3>
                    <b>ERROR:</b><br>
                    <br>
                    <cfloop index="l" list="#whyBadBid#">
                      #l#<br>
                    </cfloop>
                    </font>#hlightEnd#
                  </td>
                </tr>
              </table>
            </cfif>
          </cfif>
          <!--- display bidding form --->
          <!---<form name="bidForm" action="#VAROOT#/bid/index.cfm" method="POST">--->
          <form name="bidForm" action="index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="POST">
            <input type="hidden" name="curr_cat" value="#curr_cat#">
            <input type="hidden" name="curr_lvl" value="#curr_lvl#">
            <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
              <tr>
                <td width=220>
                  <b>User ID</b> or <b>Nickname</b><br>
                  <input type=text name="nickname" value="#userNickname#" size=20>
                </td>
                <td width=220>
                  <b>Password</b> (<a href="#VAROOT#/registration/findpassword.cfm">forgotten it?</a>)<br>
                  <input type=password name="password" value="" size=20>
                </td>
                <td width=200></td>
              </tr>
              <tr>
                <td colspan=2>
                  <br>
                  <!--- quantity if dutch or yankee --->
                  <cfif get_ItemInfo.auction_type IS "D" OR get_ItemInfo.auction_type IS "Y">
                    <cfset quantity = iif(len(quantity) lt 1, "1", "quantity")>

                    <b>Quantity</b> you are bidding for.<br>
                    <input type=text name="quantity" value="#quantity#" size=10><br>
                    <br>
                  <cfelse>
                    <input type=hidden name="quantity" value="1">
                  </cfif>
                  <!--- bid type if not dutch or yankee --->
                  <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
                    <b><a href="#VAROOT#/help/bidtypes.cfm">Offer type</a>.</b><br>
                    <select name="bidType">
                      <option value="REGULAR"<cfif defBidType IS "REGULAR"> selected</cfif>>Regular Offer</option>
                      <option value="PROXY"<cfif defBidType IS "PROXY"> selected</cfif>>Auto Offer</option>
                    </select><br>
                    <br>
                  <cfelse>
                    <input type="hidden" name="bidType" value="REGULAR">
                  </cfif>
                  <!--- offer --->
                  <b>Your Offer.</b><br>
                  <cfset userBid = iif(len(userBid) lt 1, "maximumBid", "userBid")>

                  <input type=text name="bid" value="#REReplace(userBid, "[^0123456789.]", "", "ALL")#" size=10> (The amount you are offering for <cfif get_ItemInfo.auction_type IS "D" OR get_ItemInfo.auction_type IS "Y"><b>each</b><cfelse>this</cfif> item.)<br>
				  <input type=hidden name="requiredBid" value="#REReplace(maximumBid, "[^0123456789.]", "", "ALL")#" size=10>
                  <br>
                  Please enter only numerals and the decimal point.  Do not include 
                  currency symbols such as a dollar sign ('$') or commas (',').  Unless 
                  otherwise noted, offers are in #Trim(getCurrency.type)# (#currencyName#)<br>
                  <br>
                  <cfif enableSSL>
                    <b>Use <a href="https://#CGI.SERVER_NAME##VAROOT#/bid/index.cfm?itemnum=#get_ItemInfo.itemnum#">Secure Sockets Layer</a></b><br>
                    This form is unsecure.  Click the preceeding link if you 
                    would like to use <a href="#VAROOT#/help/ssl.html">Secure&nbsp;Sockets&nbsp;Layer</a> 
                    to place an offer on this item.<br>
                    <br>
                  </cfif>
                  <b>Binding contract.</b><br>
                  Making an offer could be a binding contract in some state and provinces. 
                  Do not make an offer unless you intend to accept this item or service at the amount of your offer.<br>
                  <br>
                  <!--- auction type --->
                  <cfif get_ItemInfo.auction_type IS "E">
                    <b>This is an <a href="#VAROOT#/help/auctiontypes.html##ENGLISH">English auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    English auctions before offering.<br>
                  <cfelseif get_ItemInfo.auction_type IS "V">
                    <b>This is a <a href="#VAROOT#/help/auctiontypes.html##VICKERY">Vickery auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    Vickery auctions before offering.<br>
                  <cfelseif get_ItemInfo.auction_type IS "D">
                    <b>This is a <a href="#VAROOT#/help/auctiontypes.html##DUTCH">Dutch auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    Dutch auctions before offering.<br>
                  <cfelseif get_ItemInfo.auction_type IS "Y">
                    <b>This is a <a href="#VAROOT#/help/auctiontypes.html##YANKEE">Yankee auction</a>.</b><br>
                    Please refer to the preceeding link for the rules governing 
                    Yankee auctions before offering.<br>
                  </cfif>
                  If you have made an offer on this item before, your new offer 
                  must be less than your previous offer.<br>
                  <br>
                  <input type=submit value="Review Offer" name="reviewBid">
			      <input type="Submit" value="Cancel Bid">
                  <br>
                  <input type=hidden name="itemnum" value="#get_ItemInfo.itemnum#">
                  <br>
                </td>
                <td></td>
              </tr>
            </table>
          </form>
</cfif>
</cfoutput>
