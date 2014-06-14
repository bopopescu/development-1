getbids.cfm<br>
simple utility for reviewing all bids/proxy bids on an item.<br>
<br>

<cfif IsDefined("URL.itemnum")>
  <cfif IsNumeric(URL.itemnum)>
    <b>retrieving all bids/proxy bids for item number:</b> <cfoutput>#URL.itemnum#</cfoutput><br>
    <br>
    
    <cfinclude template="../../includes/app_globals.cfm">
    
    <cfquery name="getInfo" datasource="#DATASOURCE#">
        SELECT minimum_bid, reserve_bid, increment, increment_valu
          FROM items
         WHERE itemnum = #URL.itemnum#
    </cfquery>
    
    <b>item info:</b><br>
    <br>
    <cfoutput>
      started at: #DecimalFormat(getInfo.minimum_bid)#<br>
      <cfif getInfo.reserve_bid GT getInfo.minimum_bid>
        reserve bid: #DecimalFormat(getInfo.reserve_bid)#<br>
      </cfif>
      <cfif getInfo.increment>
        bid increment: #DecimalFormat(getInfo.increment_valu)#<br>
      </cfif>
    </cfoutput>
    <br>
    
    <cfquery name="getBids" datasource="#DATASOURCE#">
        SELECT B.user_id, B.bid, U.nickname
          FROM bids B, users U
         WHERE B.itemnum = #URL.itemnum#
           AND B.user_id = U.user_id
         ORDER BY B.bid DESC, B.time_placed ASC
    </cfquery>
    
    <b>current bids:</b><br>
    <br>
    
    <cfoutput query="getBids">
      ::#user_id#:: ::#Trim(nickname)#:: ::#DecimalFormat(bid)#::<br>
    </cfoutput>
    <cfif not getBids.RecordCount>
      none<br>
    </cfif>
    <br>
    
    <cfquery name="getProxyBids" datasource="#DATASOURCE#">
        SELECT P.user_id, P.bid, U.nickname
          FROM proxy_bids P, users U
         WHERE P.itemnum = #URL.itemnum#
           AND P.user_id = U.user_id
         ORDER BY P.bid DESC, P.time_placed ASC
    </cfquery>
    
    <b>current proxy bids:</b><br>
    <br>
    
    <cfoutput query="getProxyBids">
      ::#user_id#:: ::#Trim(nickname)#:: ::#DecimalFormat(bid)#::<br>
    </cfoutput>
    <cfif not getProxyBids.RecordCount>
      none<br>
    </cfif>
    <br>
    
  <cfelse>
    item numbers can only contain numerics<br>
    <br>
  </cfif>
  
<cfelse>
  please specify an item number before using this utility.<br>
  (ie. .../getbids.cfm?itemnum=######)<br>
  <br>
</cfif>

<b>done...</b><br>
