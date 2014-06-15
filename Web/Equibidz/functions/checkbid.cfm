<!---
  checkbid.cfm
  
  module for checking if a bid is valid or not...
  returns isGoodBid = TRUE|FALSE
  if FALSE returns whyBadBid = (comma delim list of reasons)
  
  <cfmodule template="checkbid.cfm"
    itemnum=""
    user_id=""
    password=""
    auctionType=""
    bid=""
    minimumBid=""
    quantity=""
    datasource=""
    timenow="">
    
    required: itemnum, user_id, password, auctionType, bid, quantity, datasource, timenow
    
    checks:
      - if item exists
      - if item still open for bidding
      - if user account is good
      - if quantity desired valid with type of auction
      - if bid higher than previous bid by user, if any
      - if bid higher than minimum bid
      - if quantity bid on is available at the bid price for dutch and yankee auctions
--->
<cfsetting enablecfoutputonly="Yes">

<!--- inc app_globals --->
<cfinclude template="../includes/app_globals.cfm">

 
<cfif session.auction_mode is 0>
<!-- Regular Auctions --> <!-- Reverse Auction begins on line 326 -->
<!--- chk required params --->
<cfloop index="l" list="itemnum,user_id,password,auctionType,bid,minimumBid,quantity,datasource,timenow,submitbid,buynow">
  <cfif not IsDefined("Attributes." & l)>
    <!--- abort... send user to "Temp Unavailable" --->
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm?error=checkbid.cfm:+parameter+#l#+must+be+defined.">
  </cfif>
</cfloop>

<!--- define values --->
<cfset isGoodBid = "FALSE">
<cfset whyBadBid = "">

<!--- chk itemnum exist --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getItem" datasource="#Attributes.datasource#">
      SELECT COUNT(itemnum) AS found
        FROM items
       WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <cfif getItem.found>
    <cfset chkItemnum = "TRUE">
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cfset chkItemnum = "FALSE">
    <cfset whyBadBid = ListAppend(whyBadBid, "Invalid item number.", ",")>
  </cfcatch>
</cftry>

<!--- chk item still open --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getItemStatus" datasource="#Attributes.datasource#">
      SELECT date_end, dynamic, dynamic_valu, quantity
        FROM items
       WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <cfif getItemStatus.date_end GT Attributes.timenow>
    <cfset chkOpen = "TRUE">
  <cfelseif getItemStatus.dynamic AND getItemStatus.date_end GT DateAdd("n", -getItemStatus.dynamic_valu, Attributes.timenow)>
    <cfquery username="#db_username#" password="#db_password#" name="getBidTime" datasource="#Attributes.datasource#" maxrows="1">
        SELECT time_placed
          FROM bids
         WHERE itemnum = #Attributes.itemnum#
         ORDER BY time_placed DESC
    </cfquery>
    
    <cfif not getBidTime.RecordCount>
      <cfthrow>
    <cfelseif getBidTime.time_placed GTE DateAdd("n", -getItemStatus.dynamic_valu, Attributes.timenow)>
      <cfset chkOpen = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cfset chkOpen = "FALSE">
    <cfset whyBadBid = ListAppend(whyBadBid, "Auction no longer open for bidding.", ",")>
  </cfcatch>
</cftry>

<!--- chk user account is good --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getAccount" datasource="#Attributes.datasource#">
      SELECT user_id AS found, confirmation
        FROM users
       WHERE nickname = '#Trim(LCase(Attributes.user_id))#'
         AND password = '#Trim(Attributes.password)#'
         AND is_active = 1
         AND last_login_date <> #CreateODBCDateTime("12/31/1969 00:00:00")#
  </cfquery>
  
  <cfset getAccount_found = getAccount.found>
  <cfif getAccount.found>
  	<cfif getAccount.confirmation eq 1>
    	<cfset chkAccount = "TRUE">
	<cfelse>
		<cfset chkAccount = "FALSE">
        <cfset whyBadBid = ListAppend(whyBadBid, "Please check your email to confirm your registration before bidding.", ",")>
	</cfif>
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getAccount" datasource="#Attributes.datasource#">
          SELECT user_id AS found, confirmation
            FROM users
           WHERE user_id = #Trim(LCase(Attributes.user_id))#
             AND password = '#Trim(Attributes.password)#'
             AND is_active = 1
             AND last_login_date <> #CreateODBCDateTime("12/31/1969 00:00:00")#
      </cfquery>
      
	  <cfset getAccount_found = getAccount.found>
      <cfif getAccount.found>
        <cfif getAccount.confirmation eq 1>
    		<cfset chkAccount = "TRUE">
		<cfelse>
			<cfset chkAccount = "FALSE">
        	<cfset whyBadBid = ListAppend(whyBadBid, "Please check your email to confirm your registration before bidding.", ",")>
		</cfif>
      <cfelse>
        <cfthrow>
      </cfif>
      
      <cfcatch>
        <cfset chkAccount = "FALSE">
        <cfset whyBadBid = ListAppend(whyBadBid, "Invalid account or account not active.", ",")>
      </cfcatch>
    </cftry>
  </cfcatch>
</cftry>




<!--- Check if current High bid is equal to the highest Proxy (by Raymond McCaslin). Then heavily modified by many other people --->
<cfif #attributes.buynow# neq "buy now">
<cfif Attributes.auctionType IS "E" OR Attributes.auctionType IS "V">

	<cfquery username="#db_username#" password="#db_password#" name="getPrevHighProxy" datasource="#Attributes.datasource#">
	    SELECT MAX(bid) as bigbid
	      FROM proxy_bids 
	     WHERE itemnum=#Attributes.itemnum#
	</cfquery>
	
    <cfset discard_test = Attributes.bid><!--- Test Code --->
	<cfset current_bid = REReplace(Attributes.bid, "[^0123456789.]", "", "ALL")>
	<cfset getPrevHighProxy_bigbid = getPrevHighProxy.bigbid>
	<cfif Session.bidType IS "PROXY">
		<cfif getPrevHighProxy_bigbid EQ current_bid>
			<cfset chkLastProxy = "FALSE">
			<cfset whyBadBid = ListAppend(whyBadBid, "Your bid is the same as a previous Auto bid, please increase your bid.", ",")>
		<cfelse>
			<cfset chkLastProxy = "TRUE">
		</cfif>
	<cfelse>
		<cfset chkLastProxy = "TRUE">
	</cfif>
<cfelse>
	<cfset chkLastProxy = "TRUE">
</cfif>   
<cfelse>
	<cfset chkLastProxy = "TRUE">
</cfif>   

<cfif Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y">
	<cfmodule template="./dutch_bidding.cfm"
		itemnum="#Attributes.itemnum#"
		quantity="#getItemStatus.quantity#"
		bid="#REReplace(Attributes.bid, "[^0123456789.]", "", "ALL")#"
		quantity_wanted="#Attributes.quantity#">
	
	<cfif len(errorBadBid) gt 0>
		<cfset chkLastDutchBid = "FALSE">
		<cfset whyBadBid = ListAppend(whyBadBid, "#errorBadBid#", ",")>
	<cfelse>
		<cfset chkLastDutchBid = "TRUE">
	</cfif>

<cfelse>
	<cfset chkLastDutchBid = "TRUE">
</cfif>

<cfif chkAccount AND chkOpen AND chkItemnum AND chkLastProxy AND chkLastDutchBid>

  <!--- chk auction type to quantity --->
  <cftry>
  	<cfset Attributes_auctionType = Attributes.auctionType>
	<cfset Attributes_quantity = Attributes.quantity>
	<cfset getItemStatus_quantity = getItemStatus.quantity>
	
    <cfif Attributes.auctionType IS "E" OR Attributes.auctionType IS "V" AND Attributes.quantity IS 1>
      <cfset chkType2Quantity = "TRUE">
    <cfelseif (Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y") AND Attributes.quantity GT 0 AND Attributes.quantity lte getItemStatus.quantity>
      <cfset chkType2Quantity = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cfset chkType2Quantity = "FALSE">
      <cfset whyBadBid = ListAppend(whyBadBid, "Invalid quantity. Quantity available: #getItemStatus.quantity#", ",")>
    </cfcatch>
  </cftry>

  <!--- chk bid higher than previous by user, if previous --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getUserId" datasource="#Attributes.datasource#">
        SELECT user_id
          FROM users
         WHERE nickname = '#Trim(LCase(Attributes.user_id))#'
    </cfquery>
  
    <cfset getUserId_RecordCount = getUserId.RecordCount>
	
    <cfif getUserId.RecordCount>
      <cfset userId = getUserId.user_id>
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cftry>
        <cfquery username="#db_username#" password="#db_password#" name="getUserId" datasource="#Attributes.datasource#">
            SELECT user_id
              FROM users
             WHERE user_id = #Trim(LCase(Attributes.user_id))#
        </cfquery>
      
	    <cfset getUserId_RecordCount = getUserId.RecordCount>
	  
        <cfif getUserId.RecordCount>
          <cfset userId = getUserId.user_id>
        <cfelse>
          <cfthrow>
        </cfif>
      
        <cfcatch>
          <cfset userId = Trim(LCase(Attributes.user_id))>
        </cfcatch>
      </cftry>
    </cfcatch>
  </cftry>

  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getRegular" datasource="#Attributes.datasource#" maxrows="1">
        SELECT bid
          FROM bids
         WHERE user_id = #Variables.userId#
           AND itemnum = #Attributes.itemnum#
         ORDER BY bid DESC
    </cfquery>
  
    <cfif getRegular.RecordCount>
      <cfif Attributes.bid GT getRegular.bid OR (Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y")>
        <cfset chkRegular = "TRUE">
		<cfset getRegular_bid = getRegular.bid>
      <cfelse>
        <cfset chkRegular = "FALSE">
        <cfset my_bid_type = "Regular ">
      </cfif>
    <cfelse>
      <cfset chkRegular = "TRUE">
    </cfif>
  
    <cfquery username="#db_username#" password="#db_password#" name="getProxy" datasource="#Attributes.datasource#" maxrows="1">
        SELECT bid
          FROM proxy_bids
         WHERE user_id = #Variables.userId#
           AND itemnum = #Attributes.itemnum#
         ORDER BY bid DESC
    </cfquery>
  
    <cfif getProxy.RecordCount>
      <cfif Attributes.bid GT getProxy.bid OR (Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y")>
        <cfset chkProxy = "TRUE">
		<cfset getProxy_bid = getProxy.bid>
      <cfelse>
        <cfset chkProxy = "FALSE">
        <cfset my_bid_type = "Proxy ">
      </cfif>
    <cfelse>
      <cfset chkProxy = "TRUE">
    </cfif>
  
    <cfif chkRegular AND chkProxy>
      <cfset chkPrevious = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cfparam name="my_bid_type" default="">
      <cfset chkPrevious = "FALSE">
      <cfset whyBadBid = ListAppend(whyBadBid, "Bid lower than your previous #my_bid_type#bid on item.", ",")>
    </cfcatch>
  </cftry>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_HighBid" datasource="#DATASOURCE#">
        SELECT MAX(bid) AS highest, COUNT(bid) AS bidcount
          FROM bids
         WHERE itemnum = #attributes.itemnum#
    </cfquery>
  
<!--- Check if Quantity bid on is available ---> 

<cfquery  username="#db_username#" password="#db_password#" name="get_avail_qty" datasource="#DATASOURCE#">
SELECT SUM(quantity) AS taken
FROM bids
WHERE itemnum = #attributes.itemnum#
AND bid >= #attributes.bid#
AND buynow = 0
</cfquery>

<cfif get_avail_qty.taken gt 0>
<cfset avail_taken = "#get_avail_qty.taken#">
<cfelse> 
<cfset avail_taken = 0>
</cfif>
<CFIF getItemStatus_quantity GTE Attributes_quantity>
<cfif not isdefined("buynow_yes")>
<cftry>
<cfif (Attributes_quantity + avail_taken) LTE getItemStatus_quantity>
		<cfset qty_available = "True">
		<cfelse>
		 <cfthrow>
       </cfif>
       <cfcatch>
       <cfset qty_available = "False">
	 <cfset avail = getItemStatus_quantity - avail_taken>
<cfif avail eq 1> 
    <cfset whyBadBid = ListAppend(whyBadBid, "There  is #avail# item at this price please increase your bid or reduce your quantity.", ",")>
<cfelse>
<cfset whyBadBid = ListAppend(whyBadBid, "There  are #avail# items at this price please increase your bid or reduce your quantity.", ",")>
</cfif>
    </cfcatch>
    </cftry> 
	<cfelse>
		 <cfset qty_available = "True">
		 </cfif>
	</cfif>
  
  
  <!--- chk bid higher than minimum bid --->
  <cftry>
    <cfif Attributes.bid GTE Attributes.minimumBid>
      <cfset chkMinimum = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cfset chkMinimum = "FALSE">
      <cfset whyBadBid = ListAppend(whyBadBid, "Bid lower than the minimum bid.", ",")>
    </cfcatch>
  </cftry>
</cfif>


<!--- set and return bid status --->
<cfif len(whyBadBid) lt 1>
  <cfset IsGoodBid = "TRUE">
</cfif>

<cfset Caller.isGoodBid = isGoodBid>
<cfset Caller.whyBadBid = whyBadBid>

<cfelse>

<!-- Reverse Auction -->
<!--- chk required params --->

<cfloop index="l" list="itemnum,user_id,password,auctionType,bid,maximumBid,quantity,datasource,timenow">
  <cfif not IsDefined("Attributes." & l)>
    <!--- abort... send user to "Temp Unavailable" --->
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm?error=checkbid.cfm:+parameter+#l#+must+be+defined.">
  </cfif>
</cfloop>

<!--- define values --->
<cfset isGoodBid = "FALSE">
<cfset whyBadBid = "">

<!--- chk itemnum exist --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getItem" datasource="#Attributes.datasource#">
      SELECT COUNT(itemnum) AS found
        FROM items
       WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <cfif getItem.found>
    <cfset chkItemnum = "TRUE">
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cfset chkItemnum = "FALSE">
    <cfset whyBadBid = ListAppend(whyBadBid, "Invalid item number.", ",")>
  </cfcatch>
</cftry>

<!--- chk item still open --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getItemStatus" datasource="#Attributes.datasource#">
      SELECT date_end, dynamic, dynamic_valu, quantity
        FROM items
       WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <cfif getItemStatus.date_end GT Attributes.timenow>
    <cfset chkOpen = "TRUE">
  <cfelseif getItemStatus.dynamic AND getItemStatus.date_end GT DateAdd("n", -getItemStatus.dynamic_valu, Attributes.timenow)>
    <cfquery username="#db_username#" password="#db_password#" name="getBidTime" datasource="#Attributes.datasource#" maxrows="1">
        SELECT time_placed
          FROM bids
         WHERE itemnum = #Attributes.itemnum#
         ORDER BY time_placed DESC
    </cfquery>
    
    <cfif not getBidTime.RecordCount>
      <cfthrow>
    <cfelseif getBidTime.time_placed GTE DateAdd("n", -getItemStatus.dynamic_valu, Attributes.timenow)>
      <cfset chkOpen = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cfset chkOpen = "FALSE">
    <cfset whyBadBid = ListAppend(whyBadBid, "Auction no longer open for bidding.", ",")>
  </cfcatch>
</cftry>

<!--- chk user account is good --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getAccount" datasource="#Attributes.datasource#">
      SELECT user_id AS found, confirmation
        FROM users
       WHERE nickname = '#Trim(LCase(Attributes.user_id))#'
         AND password = '#Trim(Attributes.password)#'
         AND is_active = 1
         AND last_login_date <> #CreateODBCDateTime("12/31/1969 00:00:00")#
  </cfquery>
  
  <cfset getAccount_found = getAccount.found>
  <cfif getAccount.found>
    <cfif getAccount.confirmation eq 1>
    	<cfset chkAccount = "TRUE">
	<cfelse>
		<cfset chkAccount = "FALSE">
        <cfset whyBadBid = ListAppend(whyBadBid, "Please check your email to confirm your registration before bidding.", ",")>
	</cfif>
  <cfelse>
    <cfthrow>
  </cfif>
  
  <cfcatch>
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getAccount" datasource="#Attributes.datasource#">
          SELECT user_id AS found, confirmation
            FROM users
           WHERE user_id = #Trim(LCase(Attributes.user_id))#
             AND password = '#Trim(Attributes.password)#'
             AND is_active = 1
             AND last_login_date <> #CreateODBCDateTime("12/31/1969 00:00:00")#
      </cfquery>
      
	  <cfset getAccount_found = getAccount.found>
      <cfif getAccount.found>
        <cfif getAccount.confirmation eq 1>
    		<cfset chkAccount = "TRUE">
		<cfelse>
			<cfset chkAccount = "FALSE">
        	<cfset whyBadBid = ListAppend(whyBadBid, "Please check your email to confirm your registration before bidding.", ",")>
		</cfif>
      <cfelse>
        <cfthrow>
      </cfif>
      
      <cfcatch>
        <cfset chkAccount = "FALSE">
        <cfset whyBadBid = ListAppend(whyBadBid, "Invalid account or account not active.", ",")>
      </cfcatch>
    </cftry>
  </cfcatch>
</cftry>

<!--- Check if current Low bid is equal to the lowest Proxy . Then heavily modified by many other people --->
<cfif Attributes.auctionType IS "E" OR Attributes.auctionType IS "V">

	<cfquery username="#db_username#" password="#db_password#" name="getPrevLowProxy" datasource="#Attributes.datasource#">
	    SELECT MIN(bid) as smallbid
	      FROM proxy_bids 
	     WHERE itemnum=#Attributes.itemnum#
	</cfquery>
	
    <cfset discard_test = Attributes.bid><!--- Test Code --->
	<cfset current_bid = REReplace(Attributes.bid, "[^0123456789.]", "", "ALL")>
	<cfset getPrevLowProxy_smallbid = getPrevLowProxy.smallbid>
	<cfif Session.bidType IS "PROXY">
		<cfif getPrevLowProxy_smallbid EQ current_bid>
			<cfset chkLastProxy = "FALSE">
			<cfset whyBadBid = ListAppend(whyBadBid, "Your bid is the same as a previous Auto bid, please decrease your bid.", ",")>
		<cfelse>
			<cfset chkLastProxy = "TRUE">
		</cfif>
	<cfelse>
		<cfset chkLastProxy = "TRUE">
	</cfif>
<cfelse>
	<cfset chkLastProxy = "TRUE">
</cfif>   

<cfif Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y">
	<cfmodule template="./dutch_bidding.cfm"
		itemnum="#Attributes.itemnum#"
		quantity="#getItemStatus.quantity#"
		bid="#REReplace(Attributes.bid, "[^0123456789.]", "", "ALL")#"
		quantity_wanted="#Attributes.quantity#">
	
	<cfif len(errorBadBid) gt 0>
		<cfset chkLastDutchBid = "FALSE">
		<cfset whyBadBid = ListAppend(whyBadBid, "#errorBadBid#", ",")>
	<cfelse>
		<cfset chkLastDutchBid = "TRUE">
	</cfif>

<cfelse>
	<cfset chkLastDutchBid = "TRUE">
</cfif>

<cfif chkAccount AND chkOpen AND chkItemnum AND chkLastProxy AND chkLastDutchBid>

  <!--- chk auction type to quantity --->
  <cftry>
  	<cfset Attributes_auctionType = Attributes.auctionType>
	<cfset Attributes_quantity = Attributes.quantity>
	<cfset getItemStatus_quantity = getItemStatus.quantity>
	
    <cfif Attributes.auctionType IS "E" OR Attributes.auctionType IS "V" AND Attributes.quantity IS 1>
      <cfset chkType2Quantity = "TRUE">
    <cfelseif (Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y") AND Attributes.quantity GT 0 AND Attributes.quantity lte getItemStatus.quantity>
      <cfset chkType2Quantity = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cfset chkType2Quantity = "FALSE">
      <cfset whyBadBid = ListAppend(whyBadBid, "Invalid quantity. Quantity available: #getItemStatus.quantity#", ",")>
    </cfcatch>
  </cftry>

  <!--- chk bid higher than previous by user, if previous --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getUserId" datasource="#Attributes.datasource#">
        SELECT user_id
          FROM users
         WHERE nickname = '#Trim(LCase(Attributes.user_id))#'
    </cfquery>
  
    <cfset getUserId_RecordCount = getUserId.RecordCount>
	
    <cfif getUserId.RecordCount>
      <cfset userId = getUserId.user_id>
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cftry>
        <cfquery username="#db_username#" password="#db_password#" name="getUserId" datasource="#Attributes.datasource#">
            SELECT user_id
              FROM users
             WHERE user_id = #Trim(LCase(Attributes.user_id))#
        </cfquery>
      
	    <cfset getUserId_RecordCount = getUserId.RecordCount>
	  
        <cfif getUserId.RecordCount>
          <cfset userId = getUserId.user_id>
        <cfelse>
          <cfthrow>
        </cfif>
      
        <cfcatch>
          <cfset userId = Trim(LCase(Attributes.user_id))>
        </cfcatch>
      </cftry>
    </cfcatch>
  </cftry>

  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getRegular" datasource="#Attributes.datasource#" maxrows="1">
        SELECT bid
          FROM bids
         WHERE user_id = #Variables.userId#
           AND itemnum = #Attributes.itemnum#
         ORDER BY bid ASC
    </cfquery>
  
    <cfif getRegular.RecordCount>
      <cfif Attributes.bid LT getRegular.bid OR (Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y")>
        <cfset chkRegular = "TRUE">
		<cfset getRegular_bid = getRegular.bid>
      <cfelse>
        <cfset chkRegular = "FALSE">
        <cfset my_bid_type = "Regular ">
      </cfif>
    <cfelse>
      <cfset chkRegular = "TRUE">
    </cfif>
  
    <cfquery username="#db_username#" password="#db_password#" name="getProxy" datasource="#Attributes.datasource#" maxrows="1">
        SELECT bid
          FROM proxy_bids
         WHERE user_id = #Variables.userId#
           AND itemnum = #Attributes.itemnum#
         ORDER BY bid ASC
    </cfquery>
  
    <cfif getProxy.RecordCount>
      <cfif Attributes.bid LT getProxy.bid OR (Attributes.auctionType IS "D" OR Attributes.auctionType IS "Y")>
        <cfset chkProxy = "TRUE">
		<cfset getProxy_bid = getProxy.bid>
      <cfelse>
        <cfset chkProxy = "FALSE">
        <cfset my_bid_type = "Proxy ">
      </cfif>
    <cfelse>
      <cfset chkProxy = "TRUE">
    </cfif>
  
    <cfif chkRegular AND chkProxy>
      <cfset chkPrevious = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cfparam name="my_bid_type" default="">
      <cfset chkPrevious = "FALSE">
      <cfset whyBadBid = ListAppend(whyBadBid, "Bid higher than your previous #my_bid_type#bid on item.", ",")>
    </cfcatch>
  </cftry>

  
<!--- Check if current bid is the first bid on item--->
<cfquery username="#db_username#" password="#db_password#" name="get_LowBid" datasource="#DATASOURCE#">
        SELECT MIN(bid) AS lowest, COUNT(bid) AS bidcount
          FROM bids
         WHERE itemnum = #attributes.itemnum#
    </cfquery>
	 
	 
<!--- Check if Quantity bid on is available ---> 

<cfquery  username="#db_username#" password="#db_password#" name="get_avail_qty" datasource="#DATASOURCE#">
SELECT SUM(quantity) AS taken
FROM bids
WHERE itemnum = #attributes.itemnum#
AND bid <= #attributes.bid#
</cfquery>

<cfif get_avail_qty.taken gt 0>
<cfset avail_taken = "#get_avail_qty.taken#">
<cfelse> 
<cfset avail_taken = 0>
</cfif>
<CFIF getItemStatus_quantity GTE Attributes_quantity>
<cftry>
<cfif (Attributes_quantity + avail_taken) LTE getItemStatus_quantity>
		<cfset qty_available = "True">
		<cfelse>
		 <cfthrow>
       </cfif>
       <cfcatch>
       <cfset qty_available = "False">
	 <cfset avail = getItemStatus_quantity - avail_taken>
<cfif avail eq 1> 
    <cfset whyBadBid = ListAppend(whyBadBid, "There  is #avail# item at this price please decrease your bid or reduce your quantity.", ",")>
<cfelse>
<cfset whyBadBid = ListAppend(whyBadBid, "There  are #avail# items at this price please decrease your bid or reduce your quantity.", ",")>
</cfif>
    </cfcatch>
    </cftry> 
	</cfif>
 
  
  <!--- chk bid lower than maximum bid --->
  <cftry>
    <cfif Attributes.bid LTE Attributes.maximumBid>
      <cfset chkMaximum = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
  
    <cfcatch>
      <cfset chkMaximum = "FALSE">
      <cfset whyBadBid = ListAppend(whyBadBid, "Bid higher than the maximum bid.", ",")>
    </cfcatch>
  </cftry>
</cfif>

<!--- set and return bid status --->
<cfif len(whyBadBid) lt 1>
  <cfset IsGoodBid = "TRUE">
</cfif>

<cfset Caller.isGoodBid = isGoodBid>
<cfset Caller.whyBadBid = whyBadBid>
</cfif>
<cfsetting enablecfoutputonly="No">

