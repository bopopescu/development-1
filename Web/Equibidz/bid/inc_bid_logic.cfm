<cfsetting enablecfoutputonly="yes">




<cfset bid_qty = 1>
<cfset session.logic_path="a">
<cfif isDefined('session.auction_mode')>
   <cfset session.logic_path="#session.logic_path#, b">
<cfelse>
   <cfset session.logic_path="#session.logic_path#, c">
   <CFQUERY NAME="get_auction_mode" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
     SELECT  auction_mode
     FROM items
     WHERE itemnum = #itemnum#
   </CFQUERY>
   <cfset session.auction_mode = get_auction_mode.auction_mode>
</CFIF>
<cfif session.auction_mode is 0>
<cfset session.logic_path="#session.logic_path#, d">
<!-- Regular Auctions -->
<!-- Reverse Auction begins on line 426 -->
  <cfinclude template="./inc_bid_get_max_bid.cfm">

  <cfinclude template="./inc_bid_get_session_user.cfm">
  
  <!--- define quantity --->
  <cfif IsDefined("quantity")>
    <cfset quantity = Trim(quantity)>
  <cfelse>
    <cfset quantity = 1>
  </cfif>

  <cfinclude template="./inc_bid_get_default_bid_type.cfm">
  
  <!--- get enable_ssl --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getSSL" datasource="#DATASOURCE#">
        SELECT pair AS enable_ssl
          FROM defaults
         WHERE name = 'enable_ssl'
    </cfquery>
    <cfset enableSSL = getSSL.enable_ssl>
    
    <cfcatch>
      <cfset enableSSL = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <!--- def currency name --->
  <cfmodule template="../functions/cf_currencies.cfm"
    mode="CODECONVERT"
    code="#getCurrency.type#"
    return="currencyName">
  
  <!--- bidIncrement & minimumBid --->
  <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
<cfset session.logic_path="#session.logic_path#, e">
    <cfset bidIncrement = IIf(get_ItemInfo.increment, "get_ItemInfo.increment_valu", "0.50")>
<cfset minimumBid = numberformat(evaluate(bid_currently + bidIncrement),numbermask)>
<cfif bid_count LT 1>
    <cfset minimumBid = numberformat(bid_currently,numbermask)>
<cfelse>
<cfset minimumBid = numberformat(bid_currently + bidIncrement,numbermask)>
</cfif>
    <cfset bidIncrement = numberformat(bidIncrement,numbermask)>
  <cfelse>  
  <cfset session.logic_path="#session.logic_path#, f">  
  	<cfmodule template="../functions/dutch_bidding.cfm"
		itemnum="#get_itemInfo.itemnum#"
		quantity="#bid_qty#"
		miminum_bid = "#get_itemInfo.minimum_bid#"
		increment_valu = "#get_itemInfo.increment_valu#">
    <cfset minimumBid = numberformat(minimumBid,numbermask)>
  </cfif>
  <cfset bid_currently = numberformat(bid_currently,numbermask)>
  
  <!--- define bid --->
  <cfif IsDefined("bid")>
    <cfset userBid = bid>
  <cfelseif IsDefined("Session.bid")>
    <cfset userBid = Session.bid>
  <cfelse>
    <cfset userBid = Variables.minimumBid>
  </cfif>
  
  
  
  <!--- if review submit, check bid --->
  <cfif IsDefined("reviewBid") or IsDefined("buynow_yes")>
  <cfset session.logic_path="#session.logic_path#, g">
  <!---  <cftry> --->
      <!--- chk bid --->
      <!--- <cfmodule template="../functions/checkbid.cfm"
        itemnum="#get_ItemInfo.itemnum#"
        user_id="#Trim(nickname)#"
        password="#Trim(password)#"
        auctionType="#get_ItemInfo.auction_type#"
        bid="#REReplace(bid, "[^0-9.]", "", "ALL")#"
        minimumBid="#REReplace(minimumBid, "[^0123456789.]", "", "ALL")#"
        quantity="#REReplace(quantity, "[^0123456789.]", "", "ALL")#"
        datasource="#DATASOURCE#"
        timenow="#TIMENOW#"
		buynow="review"
		submitbid="no"> --->
	  
	  <!--- check bid --->
	    <cfif numberformat(REReplace(bid, "[^0123456789.]", "", "ALL"),'#numbermask#') gte numberformat(REReplace(requiredBid, "[^0123456789.]", "", "ALL"),'#numbermask#')>
<cfset session.logic_path="#session.logic_path#, h">
		<cfset isGoodBid = "True">
		<cfelse>
		<cfset session.logic_path="#session.logic_path#, i">
		<cfset isGoodBid = "false">
		<cfset whyBadBid = "Bid lower than the minimum bid.">
		</cfif>
	  <!--- check quantity --->
	  <cfif isGoodBid eq "True">
	    <cfif session.quantity lte bid_qty>
		<cfset isGoodBid = "True">
		<cfelse>
		<cfset isGoodBid = "false">
		<cfset whyBadBid = "Invalid quantity. Quantity available: #bid_qty#.">
		</cfif>
	  </cfif>
      
      <!--- set info in session --->
      <cfset Session.nickname = Trim(nickname)>
	  
      <!--- End of Check high bid is equal --->
      <cfif isGoodBid>
	  <cfset session.logic_path="#session.logic_path#, j">
	  	<cfif isdefined("buynow_yes")>
		<cfset session.logic_path="#session.logic_path#, k">
			<cfset totalBid = REReplace(get_ItemInfo.buynow_price, "[^0123456789.]", "", "ALL") * REReplace(quantity, "[^0123456789.]", "", "ALL")>
		<cfelse>
		<cfset session.logic_path="#session.logic_path#, l">
        <cfset totalBid = REReplace(bid, "[^0123456789.]", "", "ALL") * REReplace(quantity, "[^0123456789.]", "", "ALL")>
        </cfif>
        
        <!--- set info in session --->
        <cfset Session.nickname = Trim(nickname)>
        <cfset Session.password = Trim(password)>
		<cfif isdefined("buynow_yes")>
		<cfset session.logic_path="#session.logic_path#, m">
			<cfset Session.bid = REReplace(get_ItemInfo.buynow_price, "[^0123456789.]", "", "ALL")>
		<cfelse>
		<cfset session.logic_path="#session.logic_path#, n">
        <cfset Session.bid = REReplace(bid, "[^0123456789.]", "", "ALL")>
		</cfif>
        <cfset session.quantity = REReplace(quantity, "[^0123456789.]", "", "ALL")>
        <cfset Session.bidType = bidType>
      </cfif>
      <!---
      <cfcatch>
        <cfset isGoodBid = "FALSE">
        <cfset whyBadBid = "">
      </cfcatch>
    </cftry> --->
  </cfif>
  
  <!--- if final submit, chk & process --->
  <cfif IsDefined("submitBid")>
  <!---  <cftry> --->
  <cfset session.logic_path="#session.logic_path#, o">
  <cfquery username="#db_username#" password="#db_password#" name="getUserId0" datasource="#DATASOURCE#">
            SELECT user_id
              FROM users
             WHERE <cfif isNumeric(Session.nickname)>
			 user_id = #Session.nickname# OR nickname = '#Session.nickname#'
			 <cfelse>
			 nickname = '#Session.nickname#'
			 </cfif>
        </cfquery>
  	
    <!--- get highest proxy bid on item --->
  <cfquery name="testHighest" datasource="#datasource#" maxrows=1 dbtype="ODBC" username="#db_username#" password="#db_password#">
SELECT bid  AS max_proxy_bid
FROM proxy_bids
WHERE itemnum = #get_ItemInfo.itemnum#
GROUP BY bid
ORDER BY bid DESC</cfquery>
<cfif testHighest.recordcount>
<cfset session.logic_path="#session.logic_path#, p">
  <cfquery username="#db_username#" password="#db_password#" name="getHighest" datasource="#datasource#">
      SELECT bid, user_id
        FROM proxy_bids
       WHERE itemnum = #get_ItemInfo.itemnum#
         AND bid = #testHighest.max_proxy_bid#
  </cfquery>
  <cfelse>
  <cfset session.logic_path="#session.logic_path#, q">
  
  </cfif>
      <!--- chk bid --->
  	<cfif isdefined("buynow")>
	<cfset session.logic_path="#session.logic_path#, r">
		<cfmodule template="../functions/checkbid.cfm"
        itemnum="#get_ItemInfo.itemnum#"
        user_id="#Trim(Session.nickname)#"
        password="#Trim(Session.password)#"
        auctionType="#get_ItemInfo.auction_type#"
        bid="#REReplace(Session.bid, "[^0123456789.]", "", "ALL")#"
        minimumBid="#REReplace(minimumBid, "[^0123456789.]", "", "ALL")#"
        quantity="#REReplace(session.quantity, "[^0123456789.]", "", "ALL")#"
        datasource="#DATASOURCE#"
        timenow="#TIMENOW#"
		buynow="#buynow#"
		submitbid="yes">
		
	<cfelse>
      <!--- chk bid --->
	  <cfset session.logic_path="#session.logic_path#, s">
      <cfmodule template="../functions/checkbid.cfm"
        itemnum="#get_ItemInfo.itemnum#"
        user_id="#Trim(Session.nickname)#"
        password="#Trim(Session.password)#"
        auctionType="#get_ItemInfo.auction_type#"
        bid="#REReplace(Session.bid, "[^0123456789.]", "", "ALL")#"
        minimumBid="#REReplace(minimumBid, "[^0123456789.]", "", "ALL")#"
        quantity="#REReplace(session.quantity, "[^0123456789.]", "", "ALL")#"
        datasource="#DATASOURCE#"
        timenow="#TIMENOW#"
		buynow="bid"
		submitbid="yes">
	</cfif>
      
      <!--- get user ID # --->
      <cftry>
        <cfquery username="#db_username#" password="#db_password#" name="getUserId1" datasource="#DATASOURCE#">
            SELECT user_id, email, bid_confirm_email
              FROM users
             WHERE nickname = '#Session.nickname#'
			 AND password = '#session.password#'
			 AND is_active = 1
			 AND confirmation = 1
        </cfquery>






<cfif #getuserid1.recordcount#>
            <cfquery username="#db_username#" password="#db_password#" name="getUserId5" datasource="#DATASOURCE#">
                SELECT bidder from blocked_bidders where itemnum=#get_iteminfo.itemnum# and bidder=#getuserid1.user_id#
            </cfquery>
</cfif>

		<cfset bid_confirm_email = getUserId1.bid_confirm_email>
        
        <cfif getUserId1.RecordCount and (#getuserid5.recordcount# eq 0)>
          <cfset userID = getUserId1.user_id>
          <cfset userEmail = Trim(getUserId1.email)>
		  <cfset session.logic_path="#session.logic_path#, t">
        <cfelse>
		<cfset session.logic_path="#session.logic_path#, u">
          <cfthrow>
        </cfif>
        
        <cfcatch>
          <cftry>
            <cfquery username="#db_username#" password="#db_password#" name="getUserId2" datasource="#DATASOURCE#">
                SELECT user_id, email, bid_confirm_email
                  FROM users
                 WHERE nickname = '#Session.nickname#'
				 AND password = '#session.password#'
			 	 AND is_active = 1
				 AND confirmation = 1
            </cfquery>



<cfif #getuserid2.recordcount#>
            <cfquery username="#db_username#" password="#db_password#" name="getUserId4" datasource="#DATASOURCE#">
                SELECT bidder from blocked_bidders where itemnum=#get_iteminfo.itemnum# and bidder=#getuserid2.user_id#
            </cfquery>
</cfif>

			<cfset bid_confirm_email = getUserId2.bid_confirm_email>
            
            <cfif getUserId2.RecordCount and (#getuserid4.recordcount# eq 0)>
			<cfset session.logic_path="#session.logic_path#, v">
              <cfset userID = getUserId2.user_id>
              <cfset userEmail = Trim(getUserId2.email)>
            <cfelse>
              <cfthrow>
            </cfif>
            
            <cfcatch>
			<cfset session.logic_path="#session.logic_path#, w">
              <cfset userID = 0>
              <cfset isGoodBid = "FALSE">
              <cfset whyBadBid = ListAppend(whyBadBid, "Cannot find your email address in the database, or you might be blocked from bidding on this item by the seller.", ",")>
            </cfcatch>
          </cftry>
        </cfcatch>
      </cftry>
      
      <cfif isGoodBid>
	  <cfset session.logic_path="#session.logic_path#, x">
        <!--- send outbid notice if English or Vickery --->
        <cfif (get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V")>
<cfset session.logic_path="#session.logic_path#, y">
<cfquery username="#db_username#" password="#db_password#" name="test4bids" datasource="#DATASOURCE#">        
SELECT bid
FROM bids
WHERE itemnum = #get_ItemInfo.itemnum#
</cfquery>

<cfif test4bids.recordcount >
<cfset session.logic_path="#session.logic_path#, z">
  <cfquery name="getPrevHigh2" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC" username="#db_username#" password="#db_password#">SELECT bid 
FROM bids
WHERE itemnum = #get_ItemInfo.itemnum#
ORDER BY bid desc</cfquery>
<cfset bid_max = getPrevHigh2.bid>
<cfelse>
<cfset session.logic_path="#session.logic_path#, 1a">
<cfset bid_max = 0>
</cfif>
          <!--- get previous high bid --->
          <cfquery username="#db_username#" password="#db_password#" name="getPrevHigh" datasource="#DATASOURCE#">
              SELECT B.user_id, B.bid, U.email, U.outbid_email
                FROM bids B, users U
               WHERE B.itemnum = #get_ItemInfo.itemnum#
                 AND B.user_id = U.user_id
           AND B.bid = #bid_max#

          </cfquery>

 <!--- get previous high bid         
<cfquery username="#db_username#" password="#db_password#" name="getPrevHigh2" datasource="#DATASOURCE#">
SELECT MAX(bid) 
FROM bids
WHERE itemnum = #get_ItemInfo.itemnum#
group by itemnum
</cfquery>
---> 
 <!--- get previous high bid info

          <cfquery username="#db_username#" password="#db_password#" name="getPrevHigh" datasource="#DATASOURCE#">
              SELECT B.user_id, B.bid, U.email
                FROM bids B, users U
               WHERE B.itemnum = #get_ItemInfo.itemnum#
                 AND B.user_id = U.user_id
				  <cfif getPrevHigh2.recordcount>
           AND B.bid = #getPrevHigh2.bid#
		   </cfif> 
          </cfquery>
--->   
     

	      <cfset getPrevHigh_email = getPrevHigh.email>

              <cfif getPrevHigh.RecordCount>
			  <cfset session.logic_path="#session.logic_path#, 1b">
                <cfquery name="getPrevHighProxy" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC" username="#db_username#" password="#db_password#">
				SELECT bid as maxheadroom
	                FROM proxy_bids
	               WHERE itemnum = #get_ItemInfo.itemnum#
	                 AND user_id = #getPrevHigh.user_id#
                         AND bid >= #getPrevHigh.bid#
						 ORDER BY bid desc</cfquery>

                <cfif getPrevHighProxy.RecordCount>
				<cfset session.logic_path="#session.logic_path#, 1c">
                  <cfset getPrevHighProxy_maxheadroom = getPrevHighProxy.maxheadroom>
                  <cfif getPrevHighProxy.maxheadroom lt session.bid AND len(getPrevHighProxy.maxheadroom) gt 0>
<cfset session.logic_path="#session.logic_path#, 1d">
                    <cfset old_bid = getPrevHighProxy.maxheadroom>
                    <cfif ucase(session.bidtype) eq "PROXY">
					  <cfset session.logic_path="#session.logic_path#, 1e">
                      <cfset new_bid = minimumBid>
                    <cfelse>
					  <cfset session.logic_path="#session.logic_path#, 1f">
                      <cfset new_bid = session.bid>
                    </cfif>
                  <cfelse>
				  <cfset session.logic_path="#session.logic_path#, 1g">
                    <cfset old_bid = getPrevHigh.bid>
                    <cfset new_bid = session.bid>
                  </cfif>
                <cfelse>
				<cfset session.logic_path="#session.logic_path#, 1h">
                  <cfset old_bid = getPrevHigh.bid>
                  <cfset new_bid = minimumBid>
                </cfif>
                <cfif old_bid LT new_bid>
    <cfset session.logic_path="#session.logic_path#, 1i">
	            <!--- send outbid email to previous high bidder --->
				<cfif getPrevHigh.outbid_email eq 1>
	            <cfmodule template="eml_outbiduser.cfm"
	              to="#Trim(getPrevHigh.email)#"
	              from="#SERVICE_EMAIL##DOMAIN#"
	              subject="(ibl:1) Outbid - #Trim(get_ItemInfo.name)#"
	              itemnum="#get_ItemInfo.itemnum#"
	              itemTitle="#Trim(get_ItemInfo.name)#"
	              oldBid="#numberformat(old_bid,numbermask)# #getCurrency.type#"
	              newHighUser="#Trim(Session.nickname)#"
	              newBid="#new_bid# #getCurrency.type#">
				</cfif>
	
	          </cfif>
	    </cfif>
        </cfif>
        
        <!--- ins bid into database --->
        <cfif Session.bidType IS "PROXY">
		<cfset session.logic_path="#session.logic_path#, 1j">
		<!--- Test for bids--->
		<cfquery username="#db_username#" password="#db_password#" name="getNextBid2" datasource="#DATASOURCE#">
              SELECT itemnum
              FROM proxy_bids
              WHERE itemnum = #get_ItemInfo.itemnum#
              AND user_id <> #Variables.userID#
        </cfquery> 
		
        <cfif getNextBid2.recordcount gt 0> 
          <cfset session.logic_path="#session.logic_path#, 1k">     
          <!--- def next bid --->
          <cfquery username="#db_username#" password="#db_password#" name="getNextBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS highbid, COUNT(bid) AS found
                FROM proxy_bids
               WHERE itemnum = #get_ItemInfo.itemnum#
                 AND user_id <> #Variables.userID#
          </cfquery>
		  <cfset next_high_bid = getNextbid.highbid>
          <cfset next_found = getNextBid.found>
          <cfset session.logic_path="#session.logic_path#, 1L">
        <cfelse>
          <cfset session.logic_path="#session.logic_path#, 1m">
	      <cfset next_high_bid = 0>
	      <cfset next_found = 0>	  
        </cfif>         
          <!--- if previous proxy bid & bid --->
           <cfif next_found is not 0 AND getPrevHigh.RecordCount>
	       <cfset session.logic_path="#session.logic_path#, 1n">
           <cftry>
		   
              <cfif next_high_bid GTE getPrevHigh.bid>
			  <cfset session.logic_path="#session.logic_path#, 1o">
                <cfif get_ItemInfo.increment>
				  <cfset session.logic_path="#session.logic_path#, 1p">
                  <cfset newBid = next_high_bid + get_ItemInfo.increment_valu>
                <cfelse>
				  <cfset session.logic_path="#session.logic_path#, 1q">
                  <cfset newBid = next_high_bid + 0.01>
                </cfif>
                
                <cfif newBid GT Session.bid>
				<cfset session.logic_path="#session.logic_path#, 1r">
                  <!--- chk for new proxy eq to old high proxy --->
                  <cfif next_high_bid GT Session.bid>
				  <cfset session.logic_path="#session.logic_path#, 1s">
                    <cfthrow>
                  <cfelse>
				  <cfset session.logic_path="#session.logic_path#, 1t">
                    <cfset newBid = session.bid>
                  </cfif>
                </cfif>
              <cfelse>
                <cfthrow>
              </cfif>
              
              <cfcatch>
			  <cfset session.logic_path="#session.logic_path#, 1u">
                <cfset newBid = REReplace(minimumBid, "[^0-9.]", "", "ALL")>
              </cfcatch>
            </cftry> 
            
          <!--- if previous proxy bid --->
          <cfelseif next_found is not 0>
		    <cfset session.logic_path="#session.logic_path#, 1v">
            <cfif get_ItemInfo.increment>
			<cfset session.logic_path="#session.logic_path#, 1w">
              <cfset newBid = next_high_bid + get_ItemInfo.increment_valu>
            <cfelse>
			<cfset session.logic_path="#session.logic_path#, 1w">
              <cfset newBid = next_high_bid + 0.01>
            </cfif>
            
            <cftry>
              <cfif newBid GT Session.bid>
			  <cfset session.logic_path="#session.logic_path#, 1x">
                <!--- chk for new proxy eq to old high proxy --->
                <cfif next_high_bid GT Session.bid>
				<cfset session.logic_path="#session.logic_path#, 1y">
                  <cfthrow>
                <cfelse>
				<cfset session.logic_path="#session.logic_path#, 1z">
                  <cfset newBid = Session.bid>
                </cfif>
              </cfif>
              
              <cfcatch>
			  <cfset session.logic_path="#session.logic_path#, 2a">
                <cfset newBid = REReplace(minimumBid, "[^0-9.]", "", "ALL")>
              </cfcatch>
            </cftry>
            
          <!--- else no prev. bid or just reg bids, place min. --->
          <cfelse>
		     <cfset session.logic_path="#session.logic_path#, 2b">
             <cfset newBid = REReplace(minimumBid, "[^0-9.]", "", "ALL")>
          </cfif>
          
          <!--- if newBid below reserve --->
          <cfif Variables.newBid LT get_ItemInfo.reserve_bid>
		    <cfset session.logic_path="#session.logic_path#, 2c">
            <!--- get/setup proxy maxout/default --->
            <cfmodule template="../functions/setupDefProxyMax.cfm"
              datasource="#DATASOURCE#"
              rtnMaxout="bMaxoutProxies">
            
            <!--- if bid gt reserve --->
            <cfif Session.bid GTE get_ItemInfo.reserve_bid>
			  <cfset session.logic_path="#session.logic_path#, 2d">
              <cfset Variables.newBid = get_ItemInfo.reserve_bid>
              
            <!--- if bid lt reserve & bid gt newBid --->
            <cfelseif Session.bid LT get_ItemInfo.reserve_bid
              AND Session.bid GT Variables.newBid
              AND Variables.bMaxoutProxies>
			  <cfset session.logic_path="#session.logic_path#, 2e">
              <cfset Variables.newBid = Session.bid>
            </cfif>    
          </cfif>
          <!--- place bid --->
	<cfif isdefined("buynow")>
	    <cfset session.logic_path="#session.logic_path#, 2f">
		<cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip, buynow, winner)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #get_ItemInfo.buynow_price#, #session.quantity#, '#CGI.REMOTE_ADDR#', 1, 1)
          </cfquery>
		  <!--- Place all good bids if Reserve has not been met --->	  
	<cfelseif Variables.newBid LTE get_ItemInfo.reserve_bid>
	      <cfset session.logic_path="#session.logic_path#, 2g">
          <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
		  <!--- Do not place bid if newbid is by Current High bidder and reserve has been met--->
	<cfelseif getPrevHigh.user_id is not Variables.userID AND Variables.newBid GT get_ItemInfo.reserve_bid >
         <cfset session.logic_path="#session.logic_path#, 2h">
		<cfif next_high_bid LT Session.bid>
		<cfset session.logic_path="#session.logic_path#, 2i">
          <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
		<cfelse>
		<cfset session.logic_path="#session.logic_path#, 2j">
          <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
	
		</CFIF>
	<!--- If the session bidder is also the current highbidder and the new bid is GTE to the reserve--->
	<cfelseif getPrevHigh.user_id is Variables.userID AND Variables.newBid GTE get_ItemInfo.reserve_bid >
<cfset session.logic_path="#session.logic_path#, 2k">
		<!--- Place the bid if the session bidder's last bid was  less than the reserve--->
		<cfif getPrevHigh.bid LT get_ItemInfo.reserve_bid>
		<cfset session.logic_path="#session.logic_path#, 2l">
			<cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          	</cfquery>
		</CFIF>

	<cfelse> 	
	<cfset session.logic_path="#session.logic_path#, 2m">
		  <!--- If the session.bid is GT the reserve bid  --->	  
		  <cfif getPrevHigh.user_id is Variables.userID>
		  <cfset session.logic_path="#session.logic_path#, 2n">
		  <!--- and the session bidder is  also the current high bidder with a bid less than the reserve --->
		   <cfif session.bid GTE get_ItemInfo.reserve_bid>
		   <cfset session.logic_path="#session.logic_path#, 2o">
		   <!--- Place user's bid as the reserve bid  if gte the reserve bid--->
		   	<cfif getPrevHigh.user_id is not Variables.userID>
			<cfset session.logic_path="#session.logic_path#, 2p">
		   	<cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          	</cfquery>
		  	</CFIF>
		   <CFELSE>
		   <cfset session.logic_path="#session.logic_path#, 2q">
		   <!--- Just in case code: place the users bid as is if less than the reserve --->
		   <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
		   </CFIF>
		  
		  </CFIF>
	</CFIF>
          <!--- place proxy bid --->
		  <cfif isdefined("buynow_yes") is 0>
		  <cfset session.logic_path="#session.logic_path#, 2r">
          <cfquery username="#db_username#" password="#db_password#" name="insBid" datasource="#DATASOURCE#">
              INSERT INTO proxy_bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #Session.bid#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
          </cfif>
          
          <!--- log proxy bid --->
		  <cfif isdefined("buynow") and #buynow# eq "buy now">
		  	<cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="BuyNow"
            itemnum="#get_ItemInfo.itemnum#"
            details="BUYNOW: #get_ItemInfo.buynow_price#"
            user_id="#Variables.userID#">
		  <cfelse>
            <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Auto Bid"
            itemnum="#get_ItemInfo.itemnum#"
            details="BID: #Session.bid#"
            user_id="#Variables.userID#">
		  </cfif>
			
          
			<!--- If submit good bid subtract quantity, Phillip Nguyen 11-27-00 --->
			<cfif isdefined("buynow") and #buynow# eq "buy now">
<cfset session.logic_path="#session.logic_path#, 2s">
   			<cfquery  username="#db_username#" password="#db_password#" name="get_item_quantity" datasource="#DATASOURCE#">
				SELECT quantity as avail_quantity
				FROM items
				WHERE itemnum = #get_ItemInfo.itemnum#
 			</cfquery>
	  
				<cfset avail_quantity = ((#get_item_quantity.avail_quantity#) - (#session.quantity#))>
<cfset session.logic_path="#session.logic_path#, 2t">
				<CFQUERY NAME="update_quantity" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
					UPDATE items
					SET quantity = #avail_quantity#
					WHERE itemnum = #get_ItemInfo.itemnum#
				</CFQUERY>
		
				<cfif avail_quantity eq 0>
				<cfset session.logic_path="#session.logic_path#, 2u">
					<CFQUERY NAME="update_date_end" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
						UPDATE items
						SET date_end = #createODBCdatetime(timenow)#
						WHERE itemnum = #get_ItemInfo.itemnum#
					</CFQUERY>
	   			</cfif>	
 
			</cfif>
        <cfelse>
		<cfset session.logic_path="#session.logic_path#, 2v">
		  <!--- Send outbid Notification... (variable comes from dutch_bidding.cfm) --->
		  <cfif isdefined("session.outbid_notification")>
		  <cfset session.logic_path="#session.logic_path#, 2w">
		  	<cfset len_outbid_notification = len(session.outbid_notification)>
			<cfif len_outbid_notification gt 1>
			<cfset session.logic_path="#session.logic_path#, 2x">
				<cfwddx action="WDDX2CFML" input="#session.outbid_notification#" output="outbid_array">
				<cfif isarray(outbid_array)>
				<cfset session.logic_path="#session.logic_path#, 2y">
					<cfif arraylen(outbid_array) gt 0>
					<cfset session.logic_path="#session.logic_path#, 2z">
						<cfloop index="outbid_user" from="1" to="#arraylen(outbid_array)#">
							<cfif useremail neq outbid_array[outbid_user][1]>
							<cfset session.logic_path="#session.logic_path#, 2z1">
								<cfif outbid_array[outbid_user][3] eq 1>
								<cfmodule template="eml_outbiduser.cfm"
					              to="#Trim(outbid_array[outbid_user][1])#"
					              from="#SERVICE_EMAIL##DOMAIN#"
					              subject="(ibl:2) Outbid - #Trim(get_ItemInfo.name)#"
					              itemnum="#get_ItemInfo.itemnum#"
					              itemTitle="#Trim(get_ItemInfo.name)#"
					              oldBid="#numberformat(outbid_array[outbid_user][2],numbermask)# #getCurrency.type#"
					              newHighUser="#Trim(Session.nickname)#"
	               				  newBid="#numberformat(session.Bid,'#numbermask#')# #getCurrency.type#">
								</cfif>
								  
						  	</cfif>
						</cfloop>
					</cfif>
				</cfif>
			</cfif>
		  </cfif>
          <cfquery username="#db_username#" password="#db_password#" name="insBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip, buynow, winner)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, <cfif isdefined("buynow")>#get_ItemInfo.buynow_price#<cfelse>#Session.bid#</cfif>, #session.quantity#, '#CGI.REMOTE_ADDR#', <cfif isdefined("buynow")>1, 1<cfelse>0, 0</cfif>)
          </cfquery>
          
          <!--- log bid --->
		  <cfif isdefined("buynow") and #buynow# eq "buy now">
		  	<cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="BuyNow"
            itemnum="#get_ItemInfo.itemnum#"
            details="BUYNOW: #get_ItemInfo.buynow_price#"
            user_id="#Variables.userID#">
		  <cfelse>
            <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Bid"
            itemnum="#get_ItemInfo.itemnum#"
            details="BID: #Session.bid#"
            user_id="#Variables.userID#">
		  </cfif>
          
			
			<cfif isdefined("buynow") and #buynow# eq "buy now">
            <cfset session.logic_path="#session.logic_path#, 3a">

			<cfset session.logic_path="#session.logic_path#, 3b">
			<CFQUERY NAME="update_date_end" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
				UPDATE items
				SET date_end = #createODBCdatetime(timenow)#
				WHERE itemnum = #get_ItemInfo.itemnum#
			</CFQUERY>
            
				<!---Exclude bacause all quantity is set to 1
				<cfquery  username="#db_username#" password="#db_password#" name="get_item_quantity" datasource="#DATASOURCE#">
					SELECT quantity as avail_quantity
					FROM items
					WHERE itemnum = #get_ItemInfo.itemnum#
				</cfquery>
	  
				<cfset avail_quantity = ((#get_item_quantity.avail_quantity#) - (#session.quantity#))>
				<CFQUERY NAME="update_quantity" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
					UPDATE items
					SET quantity = #avail_quantity#
					WHERE itemnum = #get_ItemInfo.itemnum#
				</CFQUERY>
		
				<cfif avail_quantity eq 0>
				<cfset session.logic_path="#session.logic_path#, 3b">
					<CFQUERY NAME="update_date_end" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
						UPDATE items
						SET date_end = #createODBCdatetime(timenow)#
						WHERE itemnum = #get_ItemInfo.itemnum#
					</CFQUERY>
	   			</cfif>	
	   			--->
	   			
	   			
			</cfif>
        </cfif>
        
        <!--- send confirmation email to bidder --->
	<cfif Isdefined("buynow")>
	<cfset session.logic_path="#session.logic_path#, 3c">
        <cfmodule template="eml_bidconfirmation.cfm"
          to="#Variables.userEmail#"
          from="#SERVICE_EMAIL##DOMAIN#"
          subject="Buy Now successful - #Trim(get_ItemInfo.name)#"
          itemnum="#get_ItemInfo.itemnum#"
          itemTitle="#Trim(get_ItemInfo.name)#"
          nickname="#Trim(Session.nickname)#"
          bid="#get_ItemInfo.buynow_price#"
          quantity="#session.quantity#"
          bidType="#Session.bidType#"
          date="#TIMENOW#"
          date_end="#get_ItemInfo.date_end#"
          domain="#CGI.SERVER_NAME#"
          remoteHost="#CGI.REMOTE_ADDR#"
		  user_id="#Variables.userID#"
		  buynow="yes">
		  <!--- log buynow email send to buyer--->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Buynow email sent to buyer"
            itemnum="#get_ItemInfo.itemnum#"
            details="Buynow: #get_ItemInfo.buynow_price#"
            user_id="#Variables.userID#">
			<!--- get selller info --->
			<cfquery  username="#db_username#" password="#db_password#" name="get_seller_info" datasource="#DATASOURCE#">
				SELECT U.user_id, U.email
				FROM users U, items I
				WHERE I.itemnum = #get_ItemInfo.itemnum#
				AND I.user_id = U.user_id
 			</cfquery>
	  
		  <cfmodule template="eml_seller_result.cfm"
          to="#get_seller_info.email#"
          from="#SERVICE_EMAIL##DOMAIN#"
          subject="Result Buy Now- #Trim(get_ItemInfo.name)#"
          itemnum="#get_ItemInfo.itemnum#"
          itemTitle="#Trim(get_ItemInfo.name)#"
          nickname="#Trim(Session.nickname)#"
          bid="#get_ItemInfo.buynow_price#"
          quantity="#session.quantity#"
          bidType="#Session.bidType#"
          date="#TIMENOW#"
          date_end="#get_ItemInfo.date_end#"
          domain="#CGI.SERVER_NAME#"
          remoteHost="#CGI.REMOTE_ADDR#"
		  user_id="#Variables.userID#">
		  <!--- log buynow email send to seller--->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Buynow email sent to seller"
            itemnum="#get_ItemInfo.itemnum#"
            details="Buynow: #get_ItemInfo.buynow_price#  	Buyer: #Variables.userID#"
            user_id="#get_seller_info.user_ID#">
	 <cfelse>
	 	<cfif bid_confirm_email eq 1>
	 		<cfset session.logic_path="#session.logic_path#, 3d">
        <cfmodule template="eml_bidconfirmation.cfm"
          to="#Variables.userEmail#"
          from="#SERVICE_EMAIL##DOMAIN#"
          subject="Bid successful - #Trim(get_ItemInfo.name)#"
          itemnum="#get_ItemInfo.itemnum#"
          itemTitle="#Trim(get_ItemInfo.name)#"
          nickname="#Trim(Session.nickname)#"
          bid="#Session.bid#"
          quantity="#session.quantity#"
          bidType="#Session.bidType#"
          date="#TIMENOW#"
          date_end="#get_ItemInfo.date_end#"
          domain="#CGI.SERVER_NAME#"
          remoteHost="#CGI.REMOTE_ADDR#"
		  user_id="#Variables.userID#"
		  buynow="no">
		</cfif>
     </cfif>
        
        <!--- run proxy bidding if English or Vickery --->
        <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
		<cfset session.logic_path="#session.logic_path#, 3e">
          <cfif not isdefined("buynow")>
		  <cfset session.logic_path="#session.logic_path#, 3f">
          <cfmodule template="proxy.cfm"
            itemnum="#get_ItemInfo.itemnum#"
            datasource="#DATASOURCE#"
            timenow="#TIMENOW#"
            fromEmail="#SERVICE_EMAIL##DOMAIN#">
		  </cfif>
        </cfif>
        
        <!--- blank info in session --->
        <!----
        <cfset Session.password = "">
        <cfset Session.bid = "">
        <cfset session.quantity = "">
        <cfset Session.bidType = "">
        <cfset Session.outbid_notification = "">
        --->
      </cfif>
<!---      <cfcatch>
        <cfset isGoodBid = "FALSE">
        <cfset whyBadBid = "">
      </cfcatch>
    </cftry> --->
  </cfif>

  <cfinclude template="./inc_bid_highlight_enddate.cfm">




<cfelse>




<cfset session.logic_path="#session.logic_path#, 3a">
<!-- Reverse Auction -->

<cfinclude template="./inc_bid_get_max_bid.cfm">

  <cfinclude template="./inc_bid_get_session_user.cfm">
  
  <!--- define quantity --->
  <cfif IsDefined("quantity")>
    <cfset quantity = Trim(quantity)>
  <cfelse>
    <cfset quantity = 1>
  </cfif>

  <cfinclude template="./inc_bid_get_default_bid_type.cfm">
  
  <!--- get enable_ssl --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getSSL" datasource="#DATASOURCE#">
        SELECT pair AS enable_ssl
          FROM defaults
         WHERE name = 'enable_ssl'
    </cfquery>
    
    <cfset enableSSL = getSSL.enable_ssl>
    
    <cfcatch>
      <cfset enableSSL = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <!--- def currency name --->
  <cfmodule template="../functions/cf_currencies.cfm"
    mode="CODECONVERT"
    code="#getCurrency.type#"
    return="currencyName">
  
  <!--- bidIncrement & maximumBid --->
  <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
  <cfset session.logic_path="#session.logic_path#, 3b">
    <cfset bidIncrement = IIf(get_ItemInfo.increment, "get_ItemInfo.increment_valu", "0.01")>

<cfif bid_count lT 1>
<cfset session.logic_path="#session.logic_path#, 3c">
    <cfset maximumBid = numberformat(bid_currently,numbermask)>
    <cfelse>
	<cfset session.logic_path="#session.logic_path#, 3d">
     <cfset maximumBid = numberformat(bid_currently - bidIncrement,numbermask)>
	</CFIF>
    <cfset bidIncrement = numberformat(bidIncrement,numbermask)>
  <cfelse>  
  <cfset session.logic_path="#session.logic_path#, 3e">  
  	<cfmodule template="../functions/dutch_bidding.cfm"
		itemnum="#get_itemInfo.itemnum#"
		quantity="#bid_qty#"
		maximum_bid = "#get_itemInfo.maximum_bid#">
    <cfset maximumBid = numberformat(maximumBid,numbermask)>
  </cfif>
  <cfset bid_currently = numberformat(bid_currently,numbermask)>
  
  <!--- define bid --->
  <cfif IsDefined("bid")>
    <cfset userBid = bid>
  <cfelseif IsDefined("Session.bid")>
    <cfset userBid = Session.bid>
  <cfelse>
    <cfset userBid = Variables.maximumBid>
  </cfif>
  
  
  
  <!--- if review submit, check bid --->
  <cfif IsDefined("reviewBid")>
  <cfset session.logic_path="#session.logic_path#, 3e">
  <!---  <cftry> --->
      <!--- chk bid --->
      <!--- <cfmodule template="../functions/checkbid.cfm"
        itemnum="#get_ItemInfo.itemnum#"
        user_id="#Trim(nickname)#"
        password="#Trim(password)#"
        auctionType="#get_ItemInfo.auction_type#"
        bid="#REReplace(bid, "[^0-9.]", "", "ALL")#"
        maximumBid="#REReplace(maximumBid, "[^0123456789.]", "", "ALL")#"
        quantity="#REReplace(quantity, "[^0123456789.]", "", "ALL")#"
        datasource="#DATASOURCE#"
        timenow="#TIMENOW#"> --->
	  <!--- check bid --->
	    <cfif numberformat(REReplace(bid, "[^0123456789.]", "", "ALL"),'#numbermask#') lte numberformat(REReplace(requiredBid, "[^0123456789.]", "", "ALL"),'#numbermask#')>
<cfset session.logic_path="#session.logic_path#, 3f">
		<cfset isGoodBid = "True">
		<cfelse>
		<cfset session.logic_path="#session.logic_path#, 3g">
		<cfset isGoodBid = "false">
		<cfset whyBadBid = "Bid higher than the maximum bid.">
		</cfif>
	  <!--- check quantity --->
	  <cfif isGoodBid eq "True">
	  <cfset session.logic_path="#session.logic_path#, 3h">
	    <cfif session.quantity lte bid_qty>
		<cfset session.logic_path="#session.logic_path#, 3i">
		<cfset isGoodBid = "True">
		<cfelse>
		<cfset session.logic_path="#session.logic_path#, 3j">
		<cfset isGoodBid = "false">
		<cfset whyBadBid = "Invalid quantity. Quantity available: #bid_qty#.">
		</cfif>
	  </cfif>
      
      <!--- set info in session --->
      <cfset Session.nickname = Trim(nickname)>
	  
      <!--- End of Check high bid is equal --->
      <cfif isGoodBid>
	  <cfset session.logic_path="#session.logic_path#, 3j">
        <cfset totalBid = REReplace(bid, "[^0123456789.]", "", "ALL") * REReplace(quantity, "[^0123456789.]", "", "ALL")>
        
        <!--- set info in session --->
        <cfset Session.nickname = Trim(nickname)>
        <cfset Session.password = Trim(password)>
        <cfset Session.bid = REReplace(bid, "[^0123456789.]", "", "ALL")>
        <cfset session.quantity = REReplace(quantity, "[^0123456789.]", "", "ALL")>
        <cfset Session.bidType = bidType>
      </cfif>
      <!---
      <cfcatch>
        <cfset isGoodBid = "FALSE">
        <cfset whyBadBid = "">
      </cfcatch>
    </cftry> --->
  </cfif>
  
  <!--- if final submit, chk & process --->
  <cfif IsDefined("submitBid")>
  <cfset session.logic_path="#session.logic_path#, 3k">
    <!--- get lowest proxy bid on item --->
  <cfquery name="testLowest" datasource="#datasource#" maxrows=1 dbtype="ODBC" username="#db_username#" password="#db_password#">
SELECT bid  AS min_proxy_bid
FROM proxy_bids
WHERE itemnum = #get_ItemInfo.itemnum#
GROUP BY bid
ORDER BY bid ASC</cfquery>

<cfif testLowest.recordcount>
<cfset session.logic_path="#session.logic_path#, 3L">
  <cfquery username="#db_username#" password="#db_password#" name="getLowest" datasource="#datasource#">
      SELECT bid, user_id
        FROM proxy_bids
       WHERE itemnum = #get_ItemInfo.itemnum#
         AND bid = #testLowest.min_proxy_bid#
  </cfquery>
  <cfelse>
  <cfset session.logic_path="#session.logic_path#, 3m">
  
  </cfif>

      <!--- chk bid --->
      <cfmodule template="../functions/checkbid.cfm"
        itemnum="#get_ItemInfo.itemnum#"
        user_id="#Trim(Session.nickname)#"
        password="#Trim(Session.password)#"
        auctionType="#get_ItemInfo.auction_type#"
        bid="#REReplace(Session.bid, "[^0123456789.]", "", "ALL")#"
        maximumBid="#REReplace(maximumBid, "[^0123456789.]", "", "ALL")#"
        quantity="#REReplace(session.quantity, "[^0123456789.]", "", "ALL")#"
        datasource="#DATASOURCE#"
        timenow="#TIMENOW#">
      
      <!--- get user ID # --->
      <cftry>
        <cfquery username="#db_username#" password="#db_password#" name="getUserId1" datasource="#DATASOURCE#">
            SELECT user_id, email, bid_confirm_email
              FROM users
             WHERE nickname = '#Session.nickname#'
			 AND password = '#session.password#'
			 AND is_active = 1
			 AND confirmation = 1
        </cfquery>
		<cfset bid_confirm_email = getUserId1.bid_confirm_email>
        
        <cfif getUserId1.RecordCount>
		<cfset session.logic_path="#session.logic_path#, 3n">
          <cfset userID = getUserId1.user_id>
          <cfset userEmail = Trim(getUserId1.email)>
        <cfelse>
          <cfthrow>
        </cfif>
        
        <cfcatch>
          <cftry>
            <cfquery username="#db_username#" password="#db_password#" name="getUserId2" datasource="#DATASOURCE#">
                SELECT user_id, email, bid_confirm_email
                  FROM users
                 WHERE user_id = #Session.nickname#
				 AND password = '#session.password#'
			 	 AND is_active = 1
				 AND confirmation = 1
            </cfquery>
			<cfset bid_confirm_email = getUserId2.bid_confirm_email>
            
            <cfif getUserId2.RecordCount>
			<cfset session.logic_path="#session.logic_path#, 3o">
              <cfset userID = getUserId2.user_id>
              <cfset userEmail = Trim(getUserId2.email)>
            <cfelse>
              <cfthrow>
            </cfif>
            
            <cfcatch>
			<cfset session.logic_path="#session.logic_path#, 3p">
              <cfset userID = 0>
              <cfset isGoodBid = "FALSE">
              <cfset whyBadBid = ListAppend(whyBadBid, "Cannot find your email address in the database.", ",")>
            </cfcatch>
          </cftry>
        </cfcatch>
      </cftry>
      
      <cfif isGoodBid>
      <cfset session.logic_path="#session.logic_path#, 3q">  
        <!--- send outbid notice if English or Vickery --->
        <cfif (get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V")>
		<cfset session.logic_path="#session.logic_path#, 3r">
<!--- Linux change --->
<cfquery username="#db_username#" password="#db_password#" name="testMinBid" datasource="#DATASOURCE#">
          SELECT bid
          FROM bids
          WHERE itemnum = #get_ItemInfo.itemnum#
</cfquery>
<cfif testMinBid.recordcount is not 0 and testMinBid.bid is not "">
<cfset session.logic_path="#session.logic_path#, 3s">
 <cfquery username="#db_username#" password="#db_password#" name="getMinBid" datasource="#DATASOURCE#">
          SELECT MIN(bid)as min_bid
                                FROM bids
                               WHERE itemnum = #get_ItemInfo.itemnum#
</cfquery>
<cfset min_bid = getMinBid.min_bid>
<cfelse>
<cfset session.logic_path="#session.logic_path#, 3t">
<cfset min_bid = get_ItemInfo.maximum_bid>
</cfif>
          <!--- get previous low bid --->
          <cfquery username="#db_username#" password="#db_password#" name="getPrevLow" datasource="#DATASOURCE#">
              SELECT B.user_id, B.bid, U.email, U.outbid_email
                FROM bids B, users U
               WHERE B.itemnum = #get_ItemInfo.itemnum#
                 AND B.user_id = U.user_id
                 AND B.bid = #min_bid#
          </cfquery>

	      <cfset getPrevLow_email = getPrevLow.email>

              <cfif getPrevLow.RecordCount>
			  <cfset session.logic_path="#session.logic_path#, 3u">
			  <cfquery username="#db_username#" password="#db_password#" name="testPrevLowProxy" datasource="#DATASOURCE#">
	              SELECT bid
	                FROM proxy_bids
	               WHERE itemnum = #get_ItemInfo.itemnum#
	                 AND user_id = #getPrevLow.user_id#
                         AND bid <= #getPrevLow.bid#
                </cfquery>
	  
                <cfquery name="getPrevLowProxy" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC" username="#db_username#" password="#db_password#">
SELECT bid as minheadroom
	                FROM proxy_bids
	               WHERE itemnum = #get_ItemInfo.itemnum#
	                 AND user_id = #getPrevLow.user_id#
                         AND bid <= #getPrevLow.bid#
						 ORDER BY bid ASC
						 </cfquery>
				
<cfif getPrevLowProxy.recordcount>
<cfset session.logic_path="#session.logic_path#, 3v">
<cfset getPrevLowProxy_minheadroom = getPrevLowProxy.minheadroom>
<cfelse>
<cfset session.logic_path="#session.logic_path#, 3w">
<cfset getPrevLowProxy_minheadroom = 0>
</cfif> 
      
                  <cfset getPrevLowProxy_minheadroom = getPrevLowProxy.minheadroom>
                  <cfif getPrevLowProxy_minheadroom gt session.bid AND len(getPrevLowProxy.minheadroom) gt 0>
<cfset session.logic_path="#session.logic_path#, 3x">
                    <cfset old_bid = getPrevLowProxy_minheadroom>
                    <cfif ucase(session.bidtype) eq "PROXY">
					<cfset session.logic_path="#session.logic_path#, 3y">
                      <cfset new_bid = maximumBid>
                    <cfelse>
					<cfset session.logic_path="#session.logic_path#, 3z">
                      <cfset new_bid = session.bid>
                    </cfif>
                  <cfelse>
				  <cfset session.logic_path="#session.logic_path#, 4a">
                    <cfset old_bid = getPrevLow.bid>
                    <cfset new_bid = session.bid>
					<cfif old_bid GT new_bid>
     <cfset session.logic_path="#session.logic_path#, 4c">
	            <!--- send outbid email to previous high bidder --->
				<cfif getPrevLow.outbid_email eq 1>
	            <cfmodule template="eml_outbiduser.cfm"
	              to="#Trim(getPrevLow.email)#"
	              from="#SERVICE_EMAIL##DOMAIN#"
	              subject="(ibl:1) Outbid - #Trim(get_ItemInfo.name)#"
	              itemnum="#get_ItemInfo.itemnum#"
	              itemTitle="#Trim(get_ItemInfo.name)#"
	              oldBid="#numberformat(old_bid,numbermask)# #getCurrency.type#"
	              newLowUser="#Trim(Session.nickname)#">
				</cfif>
	
	          </cfif>
                  </cfif>
                <cfelse>
				 <cfset session.logic_path="#session.logic_path#, 4b">
                  <cfset old_bid = getPrevLow.bid>
                  <cfset new_bid = maximumBid>
                
                <cfif old_bid GT new_bid>
     <cfset session.logic_path="#session.logic_path#, 4c">
	            <!--- send outbid email to previous high bidder --->
				<cfif getPrevLow.outbid_email eq 1>
	            <cfmodule template="eml_outbiduser.cfm"
	              to="#Trim(getPrevLow.email)#"
	              from="#SERVICE_EMAIL##DOMAIN#"
	              subject="(ibl:1) Outbid - #Trim(get_ItemInfo.name)#"
	              itemnum="#get_ItemInfo.itemnum#"
	              itemTitle="#Trim(get_ItemInfo.name)#"
	              oldBid="#numberformat(old_bid,numbermask)# #getCurrency.type#"
	              newLowUser="#Trim(Session.nickname)#">
				</cfif>
	
	          </cfif>
	    </cfif>
        </cfif>
        
        <!--- ins bid into database --->
        <cfif Session.bidType IS "PROXY">
           <cfset session.logic_path="#session.logic_path#, 4d">
          <!--- def next bid Linux change--->
		  <cfquery username="#db_username#" password="#db_password#" name="testNextBid" datasource="#DATASOURCE#">
              SELECT bid
                FROM proxy_bids
               WHERE itemnum = #get_ItemInfo.itemnum#
                 AND user_id <> #Variables.userID#
          </cfquery>
		  <cfif testNextBid.recordcount>
		   <cfset session.logic_path="#session.logic_path#, 4e">
          <cfquery username="#db_username#" password="#db_password#" name="getNextBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS lowbid, COUNT(bid) AS found
                FROM proxy_bids
               WHERE itemnum = #get_ItemInfo.itemnum#
                 AND user_id <> #Variables.userID#
          </cfquery>
		  <cfset proxy_lowbid = getNextBid.lowbid>
		  <cfset proxy_found = getNextBid.found>
          <cfelse>
		   <cfset session.logic_path="#session.logic_path#, 4f">
		   <cfset proxy_lowbid = 0>
		  <cfset proxy_found = 0>
		  
		  </cfif>
          <!--- if previous proxy bid & bid --->
          <cfif proxy_found AND getPrevLow.RecordCount>
		   <cfset session.logic_path="#session.logic_path#, 4g">
            <cftry>
              <cfif proxy_lowbid LTE getPrevLow.bid>
                 <cfset session.logic_path="#session.logic_path#, 4h">
                <cfif get_ItemInfo.increment>
				 <cfset session.logic_path="#session.logic_path#, 4i">
                  <cfset newBid = proxy_lowbid - get_ItemInfo.increment_valu>
                <cfelse>
				 <cfset session.logic_path="#session.logic_path#, 4j">
                  <cfset newBid = proxy_lowbid - 0.01>
                </cfif>
                
                <cfif newBid LT Session.bid>
                   <cfset session.logic_path="#session.logic_path#, 4k">
                  <!--- chk for new proxy eq to old low proxy --->
                  <cfif proxy_lowbid LT Session.bid>
				   <cfset session.logic_path="#session.logic_path#, 4L">
                    <cfthrow>
                  <cfelse>
				   <cfset session.logic_path="#session.logic_path#, 4m">
                    <cfset newBid = Session.bid>
                  </cfif>
                </cfif>
              <cfelse>
			   <cfset session.logic_path="#session.logic_path#, 4n">
                <cfthrow>
              </cfif>
              
              <cfcatch>
                <cfset newBid = REReplace(maximumBid, "[^0-9.]", "", "ALL")>
              </cfcatch>
            </cftry>
            
          <!--- if previous proxy bid --->
          <cfelseif proxy_found>
		   <cfset session.logic_path="#session.logic_path#, 4o">
            <cfif get_ItemInfo.increment>
			 <cfset session.logic_path="#session.logic_path#, 4p">
              <cfset newBid = proxy_lowbid - get_ItemInfo.increment_valu>
            <cfelse>
			 <cfset session.logic_path="#session.logic_path#, 4q">
              <cfset newBid = proxy_lowbid - 0.01>
            </cfif>
            
            <cftry>
              <cfif newBid LT Session.bid>
			   <cfset session.logic_path="#session.logic_path#, 4r">
                <!--- chk for new proxy eq to old low proxy --->
                <cfif proxy_lowbid LT Session.bid>
				 <cfset session.logic_path="#session.logic_path#, 4s">
                  <cfthrow>
                <cfelse>
				 <cfset session.logic_path="#session.logic_path#, 4t">
                  <cfset newBid = Session.bid>
                </cfif>
              </cfif>
              
              <cfcatch>
			   <cfset session.logic_path="#session.logic_path#, 4u">
                <cfset newBid = REReplace(maximumBid, "[^0-9.]", "", "ALL")>
              </cfcatch>
            </cftry>
            
          <!--- else no prev. bid or just reg bids, place min. --->
          <cfelse>
		   <cfset session.logic_path="#session.logic_path#, 4v">
            <cfset newBid = REReplace(maximumBid, "[^0-9.]", "", "ALL")>
          </cfif>
          
          <!--- if newBid above reserve --->
          <cfif Variables.newBid GT get_ItemInfo.reserve_bid>
             <cfset session.logic_path="#session.logic_path#, 4w">
            <!--- get/setup proxy maxout/default --->
            <cfmodule template="../functions/setupDefProxyMin.cfm"
              datasource="#DATASOURCE#"
              rtnMinout="bMinoutProxies"
			  auction_mode="#session.auction_mode#">
            
            <!--- if bid lt reserve --->
            <cfif Session.bid LTE get_ItemInfo.reserve_bid>
			 <cfset session.logic_path="#session.logic_path#, 4x">
              <cfset Variables.newBid = get_ItemInfo.reserve_bid>
              
            <!--- if bid gt reserve & bid lt newBid --->
            <cfelseif Session.bid GT get_ItemInfo.reserve_bid
              AND Session.bid LT Variables.newBid
              AND Variables.bMinoutProxies>
               <cfset session.logic_path="#session.logic_path#, 4y">
              <cfset Variables.newBid = Session.bid>
            </cfif>
          </cfif>
          
          <!--- place bid --->
		    <!--- Place all good bids if Reserve has not been met --->	  
	<cfif Variables.newBid GTE get_ItemInfo.reserve_bid>
	 <cfset session.logic_path="#session.logic_path#, 4z">
          <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, 
				#REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
		  <!--- Do not place bid if newbid is by Current High bidder and reserve has been met--->
	<cfelseif getPrevLow.user_id is not Variables.userID AND Variables.newBid LT get_ItemInfo.reserve_bid >
 <cfset session.logic_path="#session.logic_path#, 5a">
		<cfif proxy_lowbid LT Session.bid>
          <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
		<cfelse>
		 <cfset session.logic_path="#session.logic_path#, 5b">
          <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
	
		</CFIF>
	<!--- If the session bidder is also the current highbidder and the new bid is LTE to the reserve--->
	<cfelseif getPrevLow.user_id is Variables.userID AND Variables.newBid LTE get_ItemInfo.reserve_bid >
 <cfset session.logic_path="#session.logic_path#, 5c">
		<!--- Place the bid if the session bidder's last bid was  greater than the reserve--->
		<cfif getPrevLow.bid GT get_ItemInfo.reserve_bid>
		 <cfset session.logic_path="#session.logic_path#, 5d">
			<cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
            </cfquery></CFIF>

		<cfelse> 	
		 <cfset session.logic_path="#session.logic_path#, 5e">
		  <!--- If the session.bid is LT the reserve bid  --->	  
		  <cfif getPrevLow.user_id is Variables.userID>
		   <cfset session.logic_path="#session.logic_path#, 5f">
		  <!--- and the session bidder is  also the current high bidder with a bid greater than the reserve --->
		   <cfif session.bid LTE get_ItemInfo.reserve_bid>
		    <cfset session.logic_path="#session.logic_path#, 5g">
		   <!--- Place user's bid as the reserve bid  if gte the reserve bid--->
		   <cfif getPrevLow.user_id is not Variables.userID>
		   <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
           </cfquery>
		   </CFIF>
		   <CFELSE>
		    <cfset session.logic_path="#session.logic_path#, 5h">
		   <!--- Just in case code: place the users bid as is if less than the reserve --->
		   <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
		   </CFIF>
		  
		  </CFIF>
	</CFIF>

          <!--- <cfquery username="#db_username#" password="#db_password#" name="insNextBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #REReplace(newBid, "[^0-9.]", "", "ALL")#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery> --->
          
          <!--- place proxy bid --->
          <cfquery username="#db_username#" password="#db_password#" name="insBid" datasource="#DATASOURCE#">
              INSERT INTO proxy_bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #Session.bid#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
          
          <!--- log proxy bid --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Auto Bid"
            itemnum="#get_ItemInfo.itemnum#"
            details="BID: #Session.bid#"
            user_id="#Variables.userID#">
          
        <cfelse>
		 <cfset session.logic_path="#session.logic_path#, 5i">
		  <!--- Send outbid Notification... (variable comes from dutch_bidding.cfm) --->
		  <cfif isdefined("session.outbid_notification")>
		   <cfset session.logic_path="#session.logic_path#, 5j">
		  	<cfset len_outbid_notification = len(session.outbid_notification)>
			<cfif len_outbid_notification gt 1>
			 <cfset session.logic_path="#session.logic_path#, 5k">
				<cfwddx action="WDDX2CFML" input="#session.outbid_notification#" output="outbid_array">
				<cfif isarray(outbid_array)>
				 <cfset session.logic_path="#session.logic_path#, 5L">
					<cfif arraylen(outbid_array) gt 0>
					 <cfset session.logic_path="#session.logic_path#, 5m">
						<cfloop index="outbid_user" from="1" to="#arraylen(outbid_array)#">
							<cfif useremail neq outbid_array[outbid_user][1]>
							 <cfset session.logic_path="#session.logic_path#, 5n">
							 	<cfif outbid_array[outbid_user][3] eq 1>
								<cfmodule template="eml_outbiduser.cfm"
					              to="#Trim(outbid_array[outbid_user][1])#"
					              from="#SERVICE_EMAIL##DOMAIN#"
					              subject="(ibl:2) Outbid - #Trim(get_ItemInfo.name)#"
					              itemnum="#get_ItemInfo.itemnum#"
					              itemTitle="#Trim(get_ItemInfo.name)#"
					              oldBid="#numberformat(outbid_array[outbid_user][2],numbermask)# #getCurrency.type#"
					              newLowUser="#Trim(Session.nickname)#"
	              				  newBid="#numberformat(session.Bid,'#numbermask#')# #getCurrency.type#">
								</cfif>
								  
						  	</cfif>
						</cfloop>
					</cfif>
				</cfif>
			</cfif>
		  </cfif>
		
          <cfquery username="#db_username#" password="#db_password#" name="insBid" datasource="#DATASOURCE#">
              INSERT INTO bids
                (itemnum, user_id, time_placed, bid, quantity, remote_ip)
              VALUES
                (#get_ItemInfo.itemnum#, #Variables.userID#, #TIMENOW#, #Session.bid#, #session.quantity#, '#CGI.REMOTE_ADDR#')
          </cfquery>
          
          <!--- log bid --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Bid"
            itemnum="#get_ItemInfo.itemnum#"
            details="BID: #Session.bid#"
            user_id="#Variables.userID#">
          
        </cfif>
        
		<cfif bid_confirm_email eq 1>
        <!--- send confirmation email to bidder --->
        <cfmodule template="eml_bidconfirmation.cfm"
          to="#Variables.userEmail#"
          from="#SERVICE_EMAIL##DOMAIN#"
          subject="Bid successful - #Trim(get_ItemInfo.name)#"
          itemnum="#get_ItemInfo.itemnum#"
          itemTitle="#Trim(get_ItemInfo.name)#"
          nickname="#Trim(Session.nickname)#"
          bid="#Session.bid#"
          quantity="#session.quantity#"
          bidType="#Session.bidType#"
          date="#TIMENOW#"
          date_end="#get_ItemInfo.date_end#"
          domain="#CGI.SERVER_NAME#"
          remoteHost="#CGI.REMOTE_ADDR#"
		  user_id="#Variables.userID#"
		  buynow="reverse">
		</cfif>
        
        <!--- run proxy bidding if English or Vickery --->
        <cfif get_ItemInfo.auction_type IS "E" OR get_ItemInfo.auction_type IS "V">
           <cfset session.logic_path="#session.logic_path#, 5o">
          <cfmodule template="proxy.cfm"
            itemnum="#get_ItemInfo.itemnum#"
            datasource="#DATASOURCE#"
            timenow="#TIMENOW#"
            fromEmail="#SERVICE_EMAIL##DOMAIN#">
        </cfif>
        
<!---mysql--->
		 
    <!-- chk dynamic close params -->
    <cfif get_ItemInfo.dynamic>
      <cfmodule template="../event2/expire/chk_dynamic.cfm"
        itemnum="#get_ItemInfo.itemnum#"
        datasource="#DATASOURCE#"
        timenow="#TIMENOW#">
		
		<cfif leaveOpen>
	 <cfquery username="#db_username#" password="#db_password#" name="UpdateEndDate" datasource="#DATASOURCE#">
UPDATE items
SET date_end = #endDynamic#
WHERE itemnum = #get_ItemInfo.itemnum#

</cfquery>
	</CFIF>
    </cfif>
	
        <!--- blank info in session --->
        <!----
        <cfset Session.password = "">
        <cfset Session.bid = "">
        <cfset session.quantity = "">
        <cfset Session.bidType = "">
        <cfset Session.outbid_notification = "">
      --->
      </cfif>
<!---      <cfcatch>
        <cfset isGoodBid = "FALSE">
        <cfset whyBadBid = "">
      </cfcatch>
    </cftry> --->
  </cfif>
 <cfset session.logic_path="#session.logic_path#, 5p">
  <cfinclude template="./inc_bid_highlight_enddate.cfm">
</cfif>
<cfsetting enablecfoutputonly="no">