<cfsetting enablecfoutputonly="yes">

 
<cfif session.auction_mode is 0>
<!-- Regular Auctions -- Reverse Auction on line  46-->
          <!--- see if user still high bidder --->
          <cfset isHighBidder = "TRUE">
          
          <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
            <cfquery username="#db_username#" password="#db_password#" name="getHighBidder" datasource="#DATASOURCE#">
                SELECT user_id
                  FROM bids
                 WHERE itemnum = #get_ItemInfo.itemnum#
                   AND bid = (SELECT MAX(bid)
                                FROM bids
                               WHERE itemnum = #get_ItemInfo.itemnum#)
            </cfquery>
            
            <cfif getHighBidder.user_id IS NOT Variables.userID>
              <cfset isHighBidder = "FALSE">
            </cfif>
          </cfif>

<cfsetting enablecfoutputonly="no">
<cfoutput>

          <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
            <tr>
              <td>
                <cfif isdefined("buynow")>
				  Buy successful.<br>
				<cfelse>
                  Bid successful.<br>
				</cfif>
                  <br>
                  Thank you for your patronage.<br>
                  <br>
                  <cfif not Variables.isHighBidder>
                    <font size=4>
                      <b>NOTICE! You have been OUTBID by another bidder.</b><br>
                    </font>
                    <br>
                  </cfif>
                <cfif isdefined("buynow")>
                  You will receive a conformation e-mail with payment instructions. If you do not receive a conformation e-mail within 24 hours please contact our office immediately.                
                <cfelse>
                  You may view this auction in progress at 
                  <a href="http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#get_ItemInfo.itemnum#">http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#get_ItemInfo.itemnum#</a>
                  until its close on #DateFormat(get_ItemInfo.date_end, "mm/dd/yy")#&nbsp;#TimeFormat(get_ItemInfo.date_end, "HH:mm:ss")#.<br>
                </cfif>  
                  <br>
             <!--- <cfif isDefined('session.logic_path')>#session.logic_path#</cfif>  --->
              </td>
            </tr>
          </table>
		  </cfoutput>
<cfelse>
<!-- Reverse Auction -->
          <!--- see if user still low bidder --->
          <cfset isLowBidder = "TRUE">
          
          <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
            <cfquery username="#db_username#" password="#db_password#" name="getLowBidder" datasource="#DATASOURCE#">
                SELECT user_id
                  FROM bids
                 WHERE itemnum = #get_ItemInfo.itemnum#
                   AND bid = (SELECT MIN(bid)
                                FROM bids
                               WHERE itemnum = #get_ItemInfo.itemnum#)
            </cfquery>
            
            <cfif getLowBidder.user_id IS NOT Variables.userID>
              <cfset isLowBidder = "FALSE">
            </cfif>
          </cfif>

<cfsetting enablecfoutputonly="no">
<cfoutput>

          <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
            <tr>
              <td>
                
                  Offer successful.<br>
                  <br>
                  Thank you for your patronage.<br>
                  <br>
                  <cfif not Variables.isLowBidder>
                    <font size=4>
                      <b>NOTICE! You have been OUTBID by another bidder.</b><br>
                    </font>
                    <br>
                  </cfif>
                  You may view this auction in progress at 
                  <a href="http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#get_ItemInfo.itemnum#">http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#get_ItemInfo.itemnum#</a>
                  until its close on #DateFormat(get_ItemInfo.date_end, "mm/dd/yy")#&nbsp;#TimeFormat(get_ItemInfo.date_end, "HH:mm:ss")#.<br>
			                  <br>
<!--- uncomment to see bid_logic debug code
                <cfif isDefined('session.logic_path')>#session.logic_path#</cfif>--->
              </td>
            </tr>
          </table>

</cfoutput>
</cfif>

