<cfoutput>

 



<cfif session.auction_mode is 0>
<!-- Regular Auctions  --Reverse auction begins on line 44 -->
          <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
            <tr>
              <td width="320">
			  	<cfif isdefined("buynow_yes")>
					Please review your buy now<br>
				<cfelse>
                    Please review your bid<br>
				</cfif>
                <br>
                
                <b>Item Number:</b> #get_ItemInfo.itemnum#<br>
                <b>Item Title:</b> #Trim(get_ItemInfo.title)#<br>
                <br>
                <b>Nickname/User ID:</b> #Session.nickname#<br>
			<cfif isdefined("buynow_yes")>
				<b>Your Buy Now Price:</b> $#numberformat(get_iteminfo.buynow_price, '#numbermask#')#&nbsp;#Trim(getCurrency.type)# <br>
				<b>Quantity:</b> 1<br>
                <b>Total Buy Now:</b> $#numberformat(totalBid,numbermask)# #Trim(getCurrency.type)#<br>
			<cfelse>
                <b>Your Bid:</b> $#REReplace(bid, "[^0123456789.]", "", "ALL")# #Trim(getCurrency.type)#<br>
                <b>Quantity:</b> 1<br>
                <b>Total Bid:</b> $#numberformat(totalBid,numbermask)# #Trim(getCurrency.type)#<br>
			</cfif>
			<cfif isdefined("buynow_yes") is 0>
                <b>Bid Type:</b> <cfif bidType eq "PROXY">AUTO<cfelse>#bidType#</cfif><br><br><br>
				Please click "Submit Bid" to finalize this bid.<br><br>
			<cfelse>
				<br><br>Please click "Buy Now" to finalize this buy now.<br><br>
			</cfif>
			</td>
			<td valign="middle">
			<cfif isdefined("buynow_yes") is 0>
                <cfif bidType IS "REGULAR">
                  <b><a href="#VAROOT#/help/bidtypes.cfm##REGULAR" target="_blank">Regular</a> Bid</b><br>
                  This is a regular bid.  A bid for the amount of the "Total Bid" 
                  above will actually be placed on this auction.<br>
                <cfelseif bidType IS "PROXY">
                  <b><a href="#VAROOT#/help/bidtypes.cfm##PROXY" target="_blank">Auto</a> Bid</b><br>
                  This is a auto bid.  Our system will automatically place bids for you 
                  at the next appropriate increment until someone else has outbid your maximum.  If 
                  you win you will be required to pay the current total bid (Your Bid X Quantity).<br>
                </cfif>
                
                <br>
                <font size=2>
                  (<b>WARNING:</b> You are about to enter a legally binding contract. 
                  Once a bid is placed it cannot be retracted.)
                </font>
			<cfelse>
				<br>
                <font size=2>
                  (<b>WARNING:</b> You are about to enter a legally binding contract. 
                  Once a buy now is placed it cannot be retracted.)
                </font>
			</cfif>
			</td>
			</tr>		
            <form name="reviewbid" action="index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="POST">
            <input type="hidden" name="curr_cat" value="#curr_cat#">
            <input type="hidden" name="curr_lvl" value="#curr_lvl#">
		    <tr><td colspan="2">
            <cfif isdefined("session.password") and session.password neq "" and isdefined("session.user_id") and session.user_id is not "">
                   <cfquery name="getuser" datasource="#datasource#">
                       select nickname, password from users where user_id = #session.user_id# and password='#session.password#'
                   </cfquery>
                   <cfset #session.nickname# = #getuser.nickname#>
                   <cfset #session.password# = #getuser.password#>
                   <input type="hidden" name="nickname" value="#session.nickname#">
                   <input type="hidden" name="password" value="#session.password#">
            <cfelse>

		<table>

			<tr>
            <td valign=top colspan="3">
              <font size=2>
                <br>
                <b>Registration Required.</b>  You must be a registered user in order to 
                place a bid.  <a href="#VAROOT#/registration/index.cfm">Click here</a> to find 
                out how to become a registered user.<br>
              </font>
            </td>
          </tr>





		  <tr><td colspan="3">&nbsp;</td></tr>
		  <tr>
              <td width=200>
                <b>User ID</b> or <b>Nickname:</b>
                
              </td>
              <td width=200 align="left">
                <input type=text name="nickname" value="<cfif isdefined("user_id") and user_id neq "" and isdefined("password") and password neq "">#user_id#<cfelse>#userNickname#</cfif>" size=20>
        		<!---<input type=text name="nickname" value=" <cfif isdefined("session.nickname") and session.nickname neq "" and isdefined("session.password") and session.password neq "" >#session.nickname#</cfif>" size=20>--->
              </td>
			  <td width=400>&nbsp;</td>
            </tr>
			<tr>
              <td width=200>
                <b>Password:</b> (<a href="#VAROOT#/registration/findpassword.cfm">forgotten it?</a>)
              </td>
              <td width=200 align="left"> 
                <input type=password name="password" value="<cfif isdefined("user_id") and user_id neq "" and isdefined("password") and password neq "">#password#<cfelse></cfif>" size=20>
                <!---<input type=password name="password" value="<cfif isdefined("session.nickname") and session.nickname neq "" and isdefined("session.password") and session.password neq "" >#session.password#</cfif>" size=20>     --->
              </td>
			  <td width=400>&nbsp;</td>
            </tr>
			</table>
</cfif>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td colspan="2">
				<table><tr>
					<td>
					<cfif isdefined("buynow_yes")>
						<input type="Hidden" name="buynow" value="#buynow_yes#">
						<input type=submit name="submitBid" value="Buy Now">
					<cfelse>


                  <input type=submit name="submitBid" value="Submit Bid">
				  	</cfif>
                  <input type=hidden name="itemnum" value="#get_ItemInfo.itemnum#">
                </form>
				</td>
				<form action="../listings/details/index.cfm?itemnum=#get_ItemInfo.itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="post">
				<td>
                   <input type="hidden" name="curr_cat" value="#curr_cat#">
                   <input type="hidden" name="curr_lvl" value="#curr_lvl#">
				   <input type="Submit" <cfif isdefined("buynow_yes")>value="Cancel BuyNow"<cfelse>value="Cancel Bid"</cfif>>
	            </td>
				</form>
				</tr></table>
              </td>
			</tr>     
          </table>
		 
		 
		 
		 
		 
		 
<cfelse>
		   
		  
		  
		  
		  
		  
		  
		  <!-- Reverse Auction -->
		  <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
            <tr>
              <td width="320">
                Please review your offer.<br>
                <br>
                <b>Item Number:</b> #get_ItemInfo.itemnum#<br>
                <b>Item Title:</b> #Trim(get_ItemInfo.title)#<br>
                <br>
                <b>Nickname/User ID:</b> #Session.nickname#<br>
                <b>Your Offer:</b> #REReplace(bid, "[^0123456789.]", "", "ALL")# #Trim(getCurrency.type)#<br>
                <b>Quantity:</b> 1<br>
                <b>Total Offer:</b> #numberformat(totalBid,numbermask)# #Trim(getCurrency.type)#<br>
                <b>Offer Type:</b> #bidType#<br><br>
				<br>Please click "Submit Offer" to finalize this transaction.<br><br>
				</td>
			<td valign="middle">
                <cfif bidType IS "REGULAR">
                  <b><a href="#VAROOT#/help/bidtypes.cfm##REGULAR" target="_blank">Regular</a> Offer</b><br>
                  This is a regular offer.  An offer for the amount of the "Total Offer" 
                  above will actually be placed on this auction.<br>
                <cfelseif bidType IS "PROXY">
                  <b><a href="#VAROOT#/help/bidtypes.cfm##PROXY" target="_blank">Auto</a> Offer</b><br>
                  This is an Auto Offer.  Our system will automatically place offers for you 
                  at the next appropriate decrement until someone else has outbid your minimum.  If 
                  you win you will be required to pay the current total offer (Your Offer X Quantity).<br>
                </cfif>
                
                <br>
                <font size=2>
                  (<b>WARNING:</b> You are about to enter a legally binding contract. 
                  Once an offer is placed it cannot be retracted.)
                </font>
				</td>
			</tr>
                <form name="reviewbid" action="index.cfm?itemnum=#get_ItemInfo.itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="POST">
                   <input type="hidden" name="curr_cat" value="#curr_cat#">
                   <input type="hidden" name="curr_lvl" value="#curr_lvl#">
		<cfif session.nickname eq "" and session.password eq "">
		<tr><td colspan="2">
		<table>
			<tr>
            <td valign=top colspan="3">
              <font size=2>
                <br>
                <b>Registration Required.</b>  You must be a registered user in order to 
                place a bid.  <a href="#VAROOT#/registration/index.cfm">Click here</a> to find 
                out how to become a registered user.<br>
              </font>
            </td>
          </tr>
		  <tr><td colspan="3">&nbsp;</td></tr>
		  <tr>
              <td width=220>
                <b>User ID</b> or <b>Nickname</b>
                
              </td>
              <td width=220 align="left">
        		<input type=text name="nickname" value="" size=20>
              </td>
			  <td width=200>&nbsp;</td>
            </tr>
			<tr>
              <td width=220>
                <b>Password</b> (<a href="#VAROOT#/registration/findpassword.cfm">forgotten it?</a>)
              </td>
              <td width=220 align="left"> 
                <input type=password name="password" value="" size=20>     
              </td>
			  <td width=200>&nbsp;</td>
            </tr>
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			</cfif>
			<tr><td colspan="2">
				<table><tr>
					<td>
                  <input type=submit name="submitBid" value="Submit Offer">
                  <input type=hidden name="itemnum" value="#get_ItemInfo.itemnum#">
                </form>
				</td>
				<form action="../listings/details/index.cfm?itemnum=#get_ItemInfo.itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#" method="post">
				<td>
                   <input type="hidden" name="curr_cat" value="#curr_cat#">
                   <input type="hidden" name="curr_lvl" value="#curr_lvl#">
				   <input type="Submit" value="Cancel Offer">
				</td>
				</form>
              </tr>
              </table>
              </td>
			</tr>     
          </table>
		  </cfif>

</cfoutput>
