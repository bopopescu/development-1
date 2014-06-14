<!---
  index.cfm
  
  main file for proxy bidding..
  runs when new bid is placed on English or Vickery auction..
  
  <cfmodule template="proxy.cfm"
    itemnum="[item number]"
    datasource="[system dsn]"
    timenow="[TIMENOW]"
    fromEmail="[from email address]">
  
--->
<cfsetting enablecfoutputonly="Yes">
<cfinclude template="../includes/app_globals.cfm">
 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
<cfif session.auction_mode is 0>
<!-- Regular Auctions -- Reverse Auction begins on line 238 > -->
<!--- define values --->
<cfset defIncrement = 0.01>
<cfset bidQuantity = 1>
<cfset sRemoteIP = '127.0.0.1'>

<!--- get item information --->
<cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
    SELECT title, minimum_bid, increment, increment_valu, date_end, auction_type
      FROM items
     WHERE itemnum = #Attributes.itemnum#
</cfquery>

<!--- chk high proxy stands alone --->
<cfquery username="#db_username#" password="#db_password#" name="chkAlone" datasource="#Attributes.datasource#">
    SELECT COUNT(bid) AS found
      FROM proxy_bids
     WHERE itemnum = #Attributes.itemnum#
       AND bid = (SELECT MAX(bid)
                    FROM proxy_bids
                   WHERE itemnum = #Attributes.itemnum#)
</cfquery>

<!--- if high proxy alone continue --->
<cfif chkAlone.found IS 1>
  
  <!--- get highest proxy bid on item --->
  <cfquery username="#db_username#" password="#db_password#" name="getHighest" datasource="#Attributes.datasource#">
      SELECT bid
        FROM proxy_bids
       WHERE itemnum = #Attributes.itemnum#
         AND bid = (SELECT MAX(bid)
                      FROM proxy_bids
                     WHERE itemnum = #Attributes.itemnum#)
  </cfquery>
  
  <!--- get 2nd highest proxy bid not by same user --->
  <cfquery username="#db_username#" password="#db_password#" name="getProxyBid" datasource="#Attributes.datasource#">
      SELECT MAX(bid) AS second, COUNT(bid) AS found
        FROM proxy_bids
       WHERE itemnum = #Attributes.itemnum#
         AND bid < (SELECT MAX(bid)
                      FROM proxy_bids
                     WHERE itemnum = #Attributes.itemnum#)
         AND user_id <> (SELECT user_id
                           FROM proxy_bids
                          WHERE itemnum = #Attributes.itemnum#
                            AND bid = (SELECT MAX(bid)
                                         FROM proxy_bids
                                        WHERE itemnum = #Attributes.itemnum#))
  </cfquery>
  
  <!--- get last bid --->
  <cfquery username="#db_username#" password="#db_password#" name="getLastBid" datasource="#Attributes.datasource#">
      SELECT MAX(bid) AS lastbid, COUNT(bid) AS found
        FROM bids
       WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <!--- define new bid --->
  <cfif getProxyBid.found>
    
    <cfif getLastBid.found>
      
      <cfif getProxyBid.second GTE getLastBid.lastbid>
        
        <!--- if highest proxy bid full increment above 2nd highest proxy bid --->
        <cfif getInfo.increment
          AND getHighest.bid GTE Evaluate(getProxyBid.second + getInfo.increment_valu)>
          
          <cfset newBid = getProxyBid.second + getInfo.increment_valu>
          
        <!--- if highest proxy bid not full increment above 2nd highest proxy bid --->
        <cfelseif getInfo.increment
          AND getHighest.bid LT Evaluate(getProxyBid.second + getInfo.increment_valu)>
          
          <cfset newBid = getHighest.bid>
          
        <!--- else using def val --->
        <cfelse>
          <cfset newBid = getHighest.bid>
        </cfif>
      <cfelse>
        
        <cfif getInfo.increment>
          <cfset newBid = getLastBid.lastbid + getInfo.increment_valu>
        <cfelse>
          <cfset newBid = getLastBid.lastbid + defIncrement>
        </cfif>
      </cfif>
    <cfelse>
      
      <!--- if highest proxy bid full increment above 2nd highest proxy bid --->
      <cfif getInfo.increment
        AND getHighest.bid GTE Evaluate(getProxyBid.second + getInfo.increment_valu)>
        
        <cfset newBid = getProxyBid.second + getInfo.increment_valu>
        
      <!--- if highest proxy bid not full increment above 2nd highest proxy bid --->
      <cfelseif getInfo.increment
        AND getHighest.bid LT Evaluate(getProxyBid.second + getInfo.increment_valu)>
        
        <cfset newBid = getHighest.bid>
        
      <!--- else using def val --->
      <cfelse>
        <cfset newBid = getProxyBid.second + defIncrement>
      </cfif>
    </cfif>
  <cfelseif getLastBid.found>
    
    <cfif getInfo.increment>
      <cfset newBid = getLastBid.lastbid + getInfo.increment_valu>
    <cfelse>
      <cfset newBid = getLastBid.lastbid + defIncrement>
    </cfif>
  <cfelse>
    
    <cfif getInfo.increment>
      <cfset newBid = getInfo.minimum_bid + getInfo.increment_valu>
    <cfelse>
      <cfset newBid = getInfo.minimum_bid + defIncrement>
    </cfif>
  </cfif>
  
  <!--- get highest proxy bidder for item and bidder's email/nickname,
        if bid GTE newBid
        AND (if isn't already high bid on item,
             and high proxy bid GT high bid
             OR no bids on item yet) --->
  <cfquery username="#db_username#" password="#db_password#" name="getUser" datasource="#Attributes.datasource#">
      SELECT P.user_id, U.email, U.nickname, U.autobid_email
        FROM proxy_bids P, users U
       WHERE itemnum = #Attributes.itemnum#
         AND P.user_id = U.user_id
         AND P.bid = (SELECT MAX(bid)
                        FROM proxy_bids
                       WHERE itemnum = #Attributes.itemnum#)
         AND P.bid >= #newBid#
         AND (P.user_id <> (SELECT user_id
                              FROM bids
                             WHERE itemnum = #Attributes.itemnum#
                               AND bid = (SELECT MAX(bid)
                                            FROM bids
                                           WHERE itemnum = #Attributes.itemnum#))
              AND (SELECT MAX(bid)
                     FROM proxy_bids
                    WHERE itemnum = #Attributes.itemnum#) > (SELECT MAX(bid)
                                                               FROM bids
                                                              WHERE itemnum = #Attributes.itemnum#)
              OR (SELECT COUNT(bid)
                    FROM bids
                   WHERE itemnum = #Attributes.itemnum#) = 0)
  </cfquery>

  <!--- if qualified proxy bid --->
  <cfif getUser.RecordCount>
    
    <cfif getLastBid.found>
      
      <!--- get currency type --->
      <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.datasource#">
          SELECT pair AS type
            FROM defaults
           WHERE name = 'site_currency'
      </cfquery>
      
      <!--- get previous high bid --->
      <cfquery username="#db_username#" password="#db_password#" name="getPrevHigh" datasource="#Attributes.datasource#">
          SELECT B.bid, U.email, U.outbid_email
            FROM bids B, users U
           WHERE B.itemnum = #Attributes.itemnum#
             AND B.user_id = U.user_id
             AND B.bid = (SELECT MAX(bid)
                            FROM bids
                           WHERE itemnum = #Attributes.itemnum#)
      </cfquery>
      
      <!--- send outbid email to previous high bidder --->
	  <cfif getPrevHigh.outbid_email eq 1>
      <cfmodule template="eml_outbiduser.cfm"
        to="#Trim(getPrevHigh.email)#"
        from="#Attributes.fromEmail#"
        subject="(prx:1) Outbid - #Trim(getInfo.title)#"
        itemnum="#Attributes.itemnum#"
        itemTitle="#Trim(getInfo.title)#"
        oldBid="#numberformat(getPrevHigh.bid,numbermask)# #getCurrency.type#"
        newHighUser="#Trim(getUser.nickname)#"
        newBid="#numberformat(newBid,numbermask)# #getCurrency.type#">
	  </cfif>
    </cfif>
    
    <!--- place bid --->
    <cfquery username="#db_username#" password="#db_password#" name="insBid" datasource="#Attributes.datasource#">
        INSERT INTO bids
          (itemnum, user_id, time_placed, bid, quantity, remote_ip)
        VALUES
          (#Attributes.itemnum#, #getUser.user_id#, #Attributes.timenow#, #newBid#, #bidQuantity#, '#Variables.sRemoteIP#')
    </cfquery>
    
    <!--- log bid --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#Attributes.datasource#"
      description="Bid by Auto"
      itemnum="#Attributes.itemnum#"
      details="AUTO BID: #newBid#"
      user_id="#getUser.user_id#">
    
    <!--- send bid confirmation email --->
	<cfif getUser.autobid_email eq 1>
    <cfmodule template="eml_bidconfirmation.cfm"
      to="#Trim(getUser.email)#"
      from="#Attributes.fromEmail#"
      subject="Auto bid successful - #Trim(getInfo.title)#"
      itemnum="#Attributes.itemnum#"
      itemTitle="#Trim(getInfo.title)#"
      nickname="#Trim(getUser.nickname)#"
      bid="#newBid#"
      quantity="#bidQuantity#"
      bidType="REGULAR (BY PROXY)"
      date="#Attributes.timenow#"
      date_end="#getInfo.date_end#"
      domain="#CGI.SERVER_NAME#"
      remoteHost="NA (Server Generated Email.)"
	  user_id="#getUser.user_id#"
	  buynow="no">
	</cfif>
  </cfif>
</cfif>

<cfelse>

<!-- Reverse Auction -->
<!--- define values --->
<cfset defIncrement = 0.01>
<cfset bidQuantity = 1>
<cfset sRemoteIP = '127.0.0.1'>
<!--- get item information --->
<cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
    SELECT title, maximum_bid, increment, increment_valu, date_end, auction_type
      FROM items
     WHERE itemnum = #Attributes.itemnum#
</cfquery>

<!--- chk high proxy stands alone --->
<cfquery username="#db_username#" password="#db_password#" name="chkAlone" datasource="#Attributes.datasource#">
    SELECT COUNT(bid) AS found
      FROM proxy_bids
     WHERE itemnum = #Attributes.itemnum#
       AND bid = (SELECT MIN(bid)
                    FROM proxy_bids
                   WHERE itemnum = #Attributes.itemnum#)
</cfquery>

<!--- if high proxy alone continue --->
<cfif chkAlone.found IS 1>
  
  <!--- get highest proxy bid on item --->
  <cfquery username="#db_username#" password="#db_password#" name="getLowest" datasource="#Attributes.datasource#">
      SELECT bid
        FROM proxy_bids
       WHERE itemnum = #Attributes.itemnum#
         AND bid = (SELECT MIN(bid)
                      FROM proxy_bids
                     WHERE itemnum = #Attributes.itemnum#)
  </cfquery>
  
  <!--- get 2nd highest proxy bid not by same user --->
  <cfquery username="#db_username#" password="#db_password#" name="getProxyBid" datasource="#Attributes.datasource#">
      SELECT MIN(bid) AS second, COUNT(bid) AS found
        FROM proxy_bids
       WHERE itemnum = #Attributes.itemnum#
         AND bid > (SELECT MIN(bid)
                      FROM proxy_bids
                     WHERE itemnum = #Attributes.itemnum#)
         AND user_id <> (SELECT user_id
                           FROM proxy_bids
                          WHERE itemnum = #Attributes.itemnum#
                            AND bid = (SELECT MIN(bid)
                                         FROM proxy_bids
                                        WHERE itemnum = #Attributes.itemnum#))
  </cfquery>
  
  <!--- get last bid --->
  <cfquery username="#db_username#" password="#db_password#" name="getLastBid" datasource="#Attributes.datasource#">
      SELECT MIN(bid) AS lastbid, COUNT(bid) AS found
        FROM bids
       WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <!--- define new bid --->
  <cfif getProxyBid.found>
    
    <cfif getLastBid.found>
      
      <cfif getProxyBid.second LTE getLastBid.lastbid>
        
        <!--- if lowest proxy bid full increment below 2nd lowest proxy bid --->
        <cfif getInfo.increment
          AND getLowest.bid LTE Evaluate(getProxyBid.second - getInfo.increment_valu)>
          
          <cfset newBid = getProxyBid.second - getInfo.increment_valu>
          
        <!--- if lowest proxy bid not full increment above 2nd lowest proxy bid --->
        <cfelseif getInfo.increment
          AND getLowest.bid GT Evaluate(getProxyBid.second - getInfo.increment_valu)>
          
          <cfset newBid = getLowest.bid>
          
        <!--- else using def val --->
        <cfelse>
          <cfset newBid = getProxyBid.second - defIncrement>
        </cfif>
      <cfelse>
        
        <cfif getInfo.increment>
          <cfset newBid = getLastBid.lastbid - getInfo.increment_valu>
        <cfelse>
          <cfset newBid = getLastBid.lastbid - defIncrement>
        </cfif>
      </cfif>
    <cfelse>
      
      <!--- if lowest proxy bid full increment below 2nd lowest proxy bid --->
      <cfif getInfo.increment
        AND getLowest.bid LTE Evaluate(getProxyBid.second - getInfo.increment_valu)>
        
        <cfset newBid = getProxyBid.second - getInfo.increment_valu>
        
      <!--- if lowest proxy bid not full increment below 2nd lowest proxy bid --->
      <cfelseif getInfo.increment
        AND getLowest.bid GT Evaluate(getProxyBid.second - getInfo.increment_valu)>
        
        <cfset newBid = getLowest.bid>
        
      <!--- else using def val --->
      <cfelse>
        <cfset newBid = getProxyBid.second - defIncrement>
      </cfif>
    </cfif>
  <cfelseif getLastBid.found>
    
    <cfif getInfo.increment>
      <cfset newBid = getLastBid.lastbid - getInfo.increment_valu>
    <cfelse>
      <cfset newBid = getLastBid.lastbid - defIncrement>
    </cfif>
  <cfelse>
    
    <cfif getInfo.increment>
      <cfset newBid = getInfo.maximum_bid - getInfo.increment_valu>
    <cfelse>
      <cfset newBid = getInfo.maximum_bid - defIncrement>
    </cfif>
  </cfif>
  
  <!--- get lowest proxy bidder for item and bidder's email/nickname,
        if bid LTE newBid
        AND (if isn't already low bid on item,
             and high proxy bid LT low bid
             OR no bids on item yet ) --->
  <cfquery username="#db_username#" password="#db_password#" name="getUser" datasource="#Attributes.datasource#">
      SELECT P.user_id, U.email, U.nickname, U.autobid_email
        FROM proxy_bids P, users U
       WHERE itemnum = #Attributes.itemnum#
         AND P.user_id = U.user_id
         AND P.bid = (SELECT MIN(bid)
                        FROM proxy_bids
                       WHERE itemnum = #Attributes.itemnum#)
         AND P.bid <= #newBid#
         AND (P.user_id <> (SELECT user_id
                              FROM bids
                             WHERE itemnum = #Attributes.itemnum#
                               AND bid = (SELECT MIN(bid)
                                            FROM bids
                                           WHERE itemnum = #Attributes.itemnum#))
              AND (SELECT MIN(bid)
                     FROM proxy_bids
                    WHERE itemnum = #Attributes.itemnum#) < (SELECT MAX(bid)
                                                               FROM bids
                                                              WHERE itemnum = #Attributes.itemnum#)
              OR (SELECT COUNT(bid)
                    FROM bids
                   WHERE itemnum = #Attributes.itemnum#) = 0)
  </cfquery>

  <!--- if qualified proxy bid --->
  <cfif getUser.RecordCount>
    
    <cfif getLastBid.found>
      
      <!--- get currency type --->
      <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.datasource#">
          SELECT pair AS type
            FROM defaults
           WHERE name = 'site_currency'
      </cfquery>
      
      <!--- get previous high bid --->
      <cfquery username="#db_username#" password="#db_password#" name="getPrevLow" datasource="#Attributes.datasource#">
          SELECT B.bid, U.email, U.outbid_email
            FROM bids B, users U
           WHERE B.itemnum = #Attributes.itemnum#
             AND B.user_id = U.user_id
             AND B.bid = (SELECT MIN(bid)
                            FROM bids
                           WHERE itemnum = #Attributes.itemnum#)
      </cfquery>
      
      <!--- send outbid email to previous low bidder --->
	  <cfif getPrevLow.outbid_email eq 1>
      <cfmodule template="eml_outbiduser.cfm"
        to="#Trim(getPrevLow.email)#"
        from="#Attributes.fromEmail#"
        subject="(prx:1) Outbid - #Trim(getInfo.title)#"
        itemnum="#Attributes.itemnum#"
        itemTitle="#Trim(getInfo.title)#"
        oldBid="#numberformat(getPrevLow.bid,numbermask)# #getCurrency.type#"
        newLowUser="#Trim(getUser.nickname)#"
        newBid="#numberformat(newBid,numbermask)# #getCurrency.type#">
	  </cfif>
    </cfif>
    
    <!--- place bid --->
    <cfquery username="#db_username#" password="#db_password#" name="insBid" datasource="#Attributes.datasource#">
        INSERT INTO bids
          (itemnum, user_id, time_placed, bid, quantity, remote_ip)
        VALUES
          (#Attributes.itemnum#, #getUser.user_id#, #Attributes.timenow#, #newBid#, #bidQuantity#, '#Variables.sRemoteIP#')
    </cfquery>
    
    <!--- log bid --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#Attributes.datasource#"
      description="Bid by Auto"
      itemnum="#Attributes.itemnum#"
      details="AUTO BID: #newBid#"
      user_id="#getUser.user_id#">
    
    <!--- send bid confirmation email --->
	<cfif getUser.autobid_email eq 1>
    <cfmodule template="eml_bidconfirmation.cfm"
      to="#Trim(getUser.email)#"
      from="#Attributes.fromEmail#"
      subject="Auto bid successful - #Trim(getInfo.title)#"
      itemnum="#Attributes.itemnum#"
      itemTitle="#Trim(getInfo.title)#"
      nickname="#Trim(getUser.nickname)#"
      bid="#newBid#"
      quantity="#bidQuantity#"
      bidType="REGULAR (BY PROXY)"
      date="#Attributes.timenow#"
      date_end="#getInfo.date_end#"
      domain="#CGI.SERVER_NAME#"
      remoteHost="NA (Server Generated Email.)"
	  user_id="#getUser.user_id#"
	  buynow="no">
	</cfif>
</cfif>
</cfif>
</cfif>
<cfsetting enablecfoutputonly="No">
