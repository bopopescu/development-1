
 
<cfif session.auction_mode is 0>
<!-- Regular Auctions -->
  <cftry>
    <!--- get current bid, number of bids, define reserve met --->
    <cfquery username="#db_username#" password="#db_password#" name="get_HighBid" datasource="#DATASOURCE#">
        SELECT MAX(bid) AS highest, COUNT(bid) AS bidcount
          FROM bids
         WHERE itemnum = #get_ItemInfo.itemnum#
    </cfquery>
    
    <cfset bid_currently = IIf(get_HighBid.bidcount, "get_HighBid.highest", "get_ItemInfo.minimum_bid")>
    <cfset bid_count = get_HighBid.bidcount>
    
    <cfif get_ItemInfo.auction_type IS "V">
      <cfquery username="#db_username#" password="#db_password#" name="getSecondBid" datasource="#DATASOURCE#" maxrows=2>
          SELECT bid
            FROM bids
           WHERE itemnum = #get_ItemInfo.itemnum#
           ORDER BY bid DESC
      </cfquery>
      
      <cfloop query="getSecondBid">
        <cfset secondBidder = getSecondBid.bid>
      </cfloop>
      
      <!--- if bids on item --->
      <cfif getSecondBid.RecordCount>
        
        <cfset reserve_met = IIf(secondBidder LT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
      <cfelse>
        
        <cfset reserve_met = IIf(bid_currently LT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
      </cfif>
      
    <cfelse>
      <cfset reserve_met = IIf(bid_currently LT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
    </cfif>
    
    <cfcatch>
      <cfset bid_currently = "Not Available">
      <cfset reserve_met = "not available">
      <cfset bid_count = "Not Available">
    </cfcatch>
  </cftry>

<cfelse>
<!-- Reverse Auction -->
<cftry>
    <!--- get current bid, number of bids, define reserve met --->
    <cfquery username="#db_username#" password="#db_password#" name="get_LowBid" datasource="#DATASOURCE#">
        SELECT MIN(bid) AS lowest, COUNT(bid) AS bidcount
          FROM bids
         WHERE itemnum = #get_ItemInfo.itemnum#
    </cfquery>
    
    <cfset bid_currently = IIf(get_LowBid.bidcount, "get_LowBid.lowest", "get_ItemInfo.maximum_bid")>
    <cfset bid_count = get_lowBid.bidcount>
    
    <cfif get_ItemInfo.auction_type IS "V">
      <cfquery username="#db_username#" password="#db_password#" name="getSecondBid" datasource="#DATASOURCE#" maxrows=2>
          SELECT bid
            FROM bids
           WHERE itemnum = #get_ItemInfo.itemnum#
           ORDER BY bid ASC
      </cfquery>
      
      <cfloop query="getSecondBid">
        <cfset secondBidder = getSecondBid.bid>
      </cfloop>
      
      <!--- if bids on item --->
      <cfif getSecondBid.RecordCount>
        
        <cfset reserve_met = IIf(secondBidder GT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
      <cfelse>
        
        <cfset reserve_met = IIf(bid_currently GT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
      </cfif>
      
    <cfelse>
      <cfset reserve_met = IIf(bid_currently GT get_ItemInfo.reserve_bid, DE("(reserve not met)"), DE(""))>
    </cfif>
    
    <cfcatch>
      <cfset bid_currently = "Not Available">
      <cfset reserve_met = "not available">
      <cfset bid_count = "Not Available">
    </cfcatch>
  </cftry>
</cfif>
