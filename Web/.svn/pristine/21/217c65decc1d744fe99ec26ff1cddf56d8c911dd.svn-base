<!--
  gen_bidder_results.cfm
  
  setup information for bidder w/ results of auction..
  email each qualified bidder.. using eml_bidder_results.cfm
  
  <!---

  <cfmodule template="gen_bidder_results.cfm"
    itemnum="[item number]"
    datasource="[system dsn]"
    timenow="[timenow]"
    fromEmail="[from email address]">
   

  ---> 
-->

<!-- define values -->
<cfset itemsSold = 0>
<cfset qualBid = 0>
<cfset numBidders = 0>

<!-- inc app_globals -->
<cfinclude template="../../includes/app_globals.cfm">
<cfif #Attributes.auction_mode# is 0>

<!-- get item information -->
<cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
    SELECT I.quantity, I.minimum_bid, I.reserve_bid, I.auction_type, I.private, I.title, I.date_start, I.date_end, I.salestax, I.shipping_fee, U.email, U.nickname
      FROM items I, users U
     WHERE itemnum = #Attributes.itemnum#
       AND I.user_id = U.user_id
</cfquery>

<!-- get bidders -->
<cfquery username="#db_username#" password="#db_password#" name="getBidders" datasource="#Attributes.datasource#">
    SELECT B.id, B.user_id, B.bid, B.quantity, U.nickname, U.email
      FROM bids B, users U, items I
     WHERE B.itemnum = #Attributes.itemnum#
	 	AND B.itemnum = I.itemnum
		AND I.quantity > 0
       AND B.user_id = U.user_id
	   AND B.bid > 0
	   AND B.buynow = 0
     ORDER BY bid DESC, time_placed ASC
</cfquery>

<cfquery username="#db_username#" password="#db_password#" name="getadministrative" datasource="#attributes.datasource#">
    SELECT *
      FROM defaults
     WHERE name = 'administrative'
     LIMIT 1;	 
</cfquery>

<cfif getadministrative.recordcount gt 0><cfset administrative_fee = getadministrative.pair><cfelse><cfset administrative_fee = ""></cfif>

<cfquery username="#db_username#" password="#db_password#" name="getfinancial" datasource="#Attributes.datasource#">
    SELECT *
      FROM defaults
     WHERE name = 'financial' 
     LIMIT 1;	 
</cfquery>
<cfif getfinancial.recordcount gt 0><cfset financial_fee = getfinancial.pair><cfelse><cfset financial_fee = "0"></cfif>

<cfquery username="#db_username#" password="#db_password#" name="getpremium" datasource="#Attributes.datasource#">
    SELECT *
      FROM defaults
     WHERE name = 'premium'
     LIMIT 1;	 
</cfquery>
<cfif getpremium.recordcount gt 0><cfset premium_fee = getpremium.pair><cfelse><cfset premium_fee = "0"></cfif>


<!-- chk IEscrow enabled/disabled -->
<cfmodule template="../../functions/iescrow.cfm"
  sOpt="ChkStatus">

<cfif getBidders.RecordCount>
  <cfif getInfo.auction_type IS "E">
    <cfset qualBid = getBidders.bid>
    <cfset itemsSold = 1>
    <cfset numBidders = 1>
    
  <cfelseif getInfo.auction_type IS "V">
    <cfif getBidders.RecordCount LT 2>
      <cfset qualBid = getInfo.minimum_bid>
    <cfelse>
      <cfloop query="getBidders" endrow="2">
        <cfset qualBid = getBidders.bid>
      </cfloop>
    </cfif>
    <cfset itemsSold = 1>
    <cfset numBidders = 1>
    
  <cfelseif getInfo.auction_type IS "D">
    <cfset itemsSold = 0>
    <cfset numBidders = 0>
    <cfloop query="getBidders">
      <cfset itemsSold = itemsSold + getBidders.quantity>
      <cfset numBidders = IncrementValue(numBidders)>
      <cfif itemsSold GTE getInfo.quantity>
        <cfset qualBid = getBidders.bid>
        <cfbreak>
      </cfif>
    </cfloop>
    <cfif itemsSold LT getInfo.quantity>
      <cfset qualBid = getInfo.minimum_bid>
    </cfif>
    
  <cfelseif getInfo.auction_type IS "Y">
    <cfset itemsSold = 0>
    <cfset numBidders = 0>
    <cfloop query="getBidders">
      <cfset itemsSold = itemsSold + getBidders.quantity>
      <cfset numBidders = IncrementValue(numBidders)>
      <cfif itemsSold GTE getInfo.quantity OR getBidders.CurrentRow IS getBidders.RecordCount>
        <cfset qualBid = getBidders.bid>
        <cfbreak>
      </cfif>
    </cfloop>
  </cfif>
<cfelse>
  <cfset itemsSold = 0>
  <cfset numBidders = 0>
  <cfset qualBid = getInfo.minimum_bid>
</cfif>

<!-- setup message -->
<cfset nl = Chr(13) & Chr(10)>
<cfif getInfo.auction_type IS "E" AND numBidders AND qualBid GTE getInfo.reserve_bid
  OR getInfo.auction_type IS "V" AND numBidders AND qualBid GTE getInfo.reserve_bid
  OR getInfo.auction_type IS "D" AND numBidders
  OR getInfo.auction_type IS "Y" AND numBidders>

  <!-- def auction type title -->
  <cfset typeTitle = "">
  <cfif getInfo.auction_type IS "E">
    <cfset typeTitle = "English">
  <cfelseif getInfo.auction_type IS "V">
    <cfset typeTitle = "Vickery">
  <cfelseif getInfo.auction_type IS "D">
    <cfset typeTitle = "Dutch">
  <cfelseif getInfo.auction_type IS "Y">
    <cfset typeTitle = "Yankee">
  </cfif>
  
  <!-- get currency type -->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>

  <cfset dQuantityAvailable = getInfo.quantity>
  
  <cfloop query="getBidders" endrow="#numBidders#">

    <cfset dQuantityIGet = iif(dQuantityAvailable LT getBidders.quantity,"dQuantityAvailable","getBidders.quantity")>
    <cfset dQuantityAvailable = dQuantityAvailable - getBidders.quantity>

    <cfset message = "">
    <cfset message = message & "Item Number: " & Attributes.itemnum & nl>
    <cfset message = message & "Item Title: " & Trim(getInfo.title) & nl>
    <cfset message = message & "Seller's Nickname: " & Trim(getInfo.nickname) & nl>
    <cfset message = message & "Seller's Email: " & Trim(getInfo.email) & nl>
    <cfset message = message & "Date Started: " & DateFormat(getInfo.date_start, "mm/dd/yyyy") & " " & TimeFormat(getInfo.date_start, "HH:mm:ss") & nl>
    <cfset message = message & "Date Ended: " & DateFormat(getInfo.date_end, "mm/dd/yyyy") & " " & TimeFormat(getInfo.date_start, "HH:mm:ss") & nl>
    <cfset message = message & "Auction Type: " & typeTitle & nl & nl>
    
    <cfif getInfo.auction_type IS "E" OR getInfo.auction_type IS "Y">
	   <cfset price = getBidders.bid>
    <cfelseif getInfo.auction_type IS "V" OR getInfo.auction_type IS "D">
      <cfset price = qualBid>
    </cfif>
    
    <cfset message = message & "Your Nickname: " & Trim(getBidders.nickname) & nl>
    <cfset message = message & "Rank: " & getBidders.CurrentRow & nl>
    <cfset message = message & "Quantity desired: " & getBidders.quantity & nl>
    <cfset message = message & "Quantity available: " & dQuantityIGet & nl>
    <cfset message = message & "Price: " & numberFormat(price,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
    <cfset message = message & "Sales Tax Rate: " & getInfo.salestax & " %"& nl>
	
	<cfset salestaxprice = price * (LSParseNumber(getInfo.salestax) / 100)>

	<cfset message = message & "Sales Tax: " & numberFormat(salestaxprice,numbermask) & " " & Trim(getCurrency.type) & nl & nl>	
	
	<cfset administrative_fee = LSParseNumber(administrative_fee)>
	<cfset financial_fee = LSParseNumber(financial_fee)>
	<cfset premium_fee = LSParseNumber(premium_fee)>
	<cfset shipping_fee = getInfo.shipping_fee>
	
	<cfif not premium_fee eq 0>
		<cfset premium_fee = price * (premium_fee / 100)>
	</cfif>
	
	<cfset message = message & "Administrative Fee: " & numberFormat(administrative_fee,numbermask) & " " & Trim(getCurrency.type) & nl>
	<cfset message = message & "Financial Fee: " & numberFormat(financial_fee,numbermask) & " " & Trim(getCurrency.type) & nl>
	<cfset message = message & "Buyer's Premium: " & numberFormat(premium_fee,numbermask) & " " & Trim(getCurrency.type) & nl>	
	<cfset message = message & "Shipping Fee: " & numberFormat(shipping_fee,numbermask) & " " & Trim(getCurrency.type) & nl & nl>	
	
	<cfset price = price + salestaxprice + administrative_fee + financial_fee + premium_fee + shipping_fee>
	
	<cfset message = message & "Total: " & numberFormat(price,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
    
	
    <cfset message = message & "Please contact the seller as soon as possible." & nl & nl>
    
    <cfset message = message & "Click here for the complete results of this auction: http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#" & nl & nl>
    
    <!-- inc if IEscrow enabled -->
    <!--- <cfif hIEscrow.bEnabled>
      
      <cfset message = message & "To initiate eNetSettle transaction Click here: http://#CGI.SERVER_NAME##VAROOT#/iescrow/index.cfm?itemnum=#Attributes.itemnum#&user_id=#getBidders.user_id#" & nl & nl>
    </cfif> --->
    
    <!-- send email -->
    <cfmodule template="eml_bidder_results.cfm"
      to="#Trim(getBidders.email)#"
      from="#Attributes.fromEmail#"
      subject="Congratulations: (Item ###Attributes.itemnum#) #Trim(getInfo.title)#"
      message="#Variables.message#">
      
    <!--- log results sent to bidder --->
    <cfmodule template="../../functions/addTransaction.cfm"
      datasource="#Attributes.DATASOURCE#"
      description="Auction Results emailed to Bidder"
      itemnum="#Attributes.itemnum#"
      details="#Variables.message#"
      user_id="#getBidders.user_id#">
    
	  <!-- update winner field -->
	<cfquery username="#db_username#" password="#db_password#" name="upd_winner" datasource="#Attributes.datasource#">
    UPDATE bids
	SET winner = 1
	WHERE id = #id#
	</cfquery>
    
  </cfloop>
</cfif>


<!------------------------------------------------------------------>
<cfelse>
<!-- Reverse Auction -->
<!-- get item information -->
<cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
    SELECT I.quantity, I.minimum_bid, I.reserve_bid, I.auction_type, I.private, I.title, I.date_start, I.date_end, U.email, U.nickname
      FROM items I, users U
     WHERE itemnum = #Attributes.itemnum#
       AND I.user_id = U.user_id
</cfquery>

<!-- get bidders -->
<cfquery username="#db_username#" password="#db_password#" name="getBidders" datasource="#Attributes.datasource#">
    SELECT B.id, B.user_id, B.bid, B.quantity, U.nickname, U.email
      FROM bids B, users U
     WHERE B.itemnum = #Attributes.itemnum#
       AND B.user_id = U.user_id
     ORDER BY bid ASC, time_placed ASC
</cfquery>

<!-- chk IEscrow enabled/disabled -->
<cfmodule template="../../functions/iescrow.cfm"
  sOpt="ChkStatus">

<cfif getBidders.RecordCount>
  <cfif getInfo.auction_type IS "E">
    <cfset qualBid = getBidders.bid>
    <cfset itemsSold = 1>
    <cfset numBidders = 1>
    
  <cfelseif getInfo.auction_type IS "V">
    <cfif getBidders.RecordCount LT 2>
      <cfset qualBid = getInfo.minimum_bid>
    <cfelse>
      <cfloop query="getBidders" endrow="2">
        <cfset qualBid = getBidders.bid>
      </cfloop>
    </cfif>
    <cfset itemsSold = 1>
    <cfset numBidders = 1>
    
  <cfelseif getInfo.auction_type IS "D">
    <cfset itemsSold = 0>
    <cfset numBidders = 0>
    <cfloop query="getBidders">
      <cfset itemsSold = itemsSold + getBidders.quantity>
      <cfset numBidders = IncrementValue(numBidders)>
      <cfif itemsSold GTE getInfo.quantity>
        <cfset qualBid = getBidders.bid>
        <cfbreak>
      </cfif>
    </cfloop>
    <cfif itemsSold LT getInfo.quantity>
      <cfset qualBid = getInfo.minimum_bid>
    </cfif>
    
  <cfelseif getInfo.auction_type IS "Y">
    <cfset itemsSold = 0>
    <cfset numBidders = 0>
    <cfloop query="getBidders">
      <cfset itemsSold = itemsSold + getBidders.quantity>
      <cfset numBidders = IncrementValue(numBidders)>
      <cfif itemsSold GTE getInfo.quantity OR getBidders.CurrentRow IS getBidders.RecordCount>
        <cfset qualBid = getBidders.bid>
        <cfbreak>
      </cfif>
    </cfloop>
  </cfif>
<cfelse>
  <cfset itemsSold = 0>
  <cfset numBidders = 0>
  <cfset qualBid = getInfo.minimum_bid>
</cfif>

<!-- setup message -->
<cfset nl = Chr(13) & Chr(10)>
<cfif getInfo.auction_type IS "E" AND numBidders AND qualBid LTE getInfo.reserve_bid
  OR getInfo.auction_type IS "V" AND numBidders AND qualBid LTE getInfo.reserve_bid
  OR getInfo.auction_type IS "D" AND numBidders
  OR getInfo.auction_type IS "Y" AND numBidders>

  <!-- def auction type title -->
  <cfset typeTitle = "">
  <cfif getInfo.auction_type IS "E">
    <cfset typeTitle = "English">
  <cfelseif getInfo.auction_type IS "V">
    <cfset typeTitle = "Vickery">
  <cfelseif getInfo.auction_type IS "D">
    <cfset typeTitle = "Dutch">
  <cfelseif getInfo.auction_type IS "Y">
    <cfset typeTitle = "Yankee">
  </cfif>
  
  <!-- get currency type -->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <cfset dQuantityAvailable = getInfo.quantity>
  
  <cfloop query="getBidders" endrow="#numBidders#">

    <cfset dQuantityIGet = iif(dQuantityAvailable LT getBidders.quantity,"dQuantityAvailable","getBidders.quantity")>
    <cfset dQuantityAvailable = dQuantityAvailable - getBidders.quantity>

    <cfset message = "">
    <cfset message = message & "Item Number: " & Attributes.itemnum & nl>
    <cfset message = message & "Item Title: " & Trim(getInfo.title) & nl>
    <cfset message = message & "Seller's Nickname: " & Trim(getInfo.nickname) & nl>
    <cfset message = message & "Seller's Email: " & Trim(getInfo.email) & nl>
    <cfset message = message & "Date Started: " & DateFormat(getInfo.date_start, "mm/dd/yyyy") & " " & TimeFormat(getInfo.date_start, "HH:mm:ss") & nl>
    <cfset message = message & "Date Ended: " & DateFormat(getInfo.date_end, "mm/dd/yyyy") & " " & TimeFormat(getInfo.date_start, "HH:mm:ss") & nl>
    <cfset message = message & "Auction Type: " & typeTitle & nl & nl>
    
    <cfif getInfo.auction_type IS "E" OR getInfo.auction_type IS "Y">
	   <cfset price = getBidders.bid>
    <cfelseif getInfo.auction_type IS "V" OR getInfo.auction_type IS "D">
      <cfset price = qualBid>
    </cfif>
    
    <cfset message = message & "Your Nickname: " & Trim(getBidders.nickname) & nl>
    <cfset message = message & "Rank: " & getBidders.CurrentRow & nl>
    <cfset message = message & "Quantity desired: " & getBidders.quantity & nl>
    <cfset message = message & "Quantity available: " & dQuantityIGet & nl>
    <cfset message = message & "Price: " & numberFormat(price,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
	<cfset message = message & "Sales Tax Rate: " & getInfo.salestax & " %"& nl>
	
	<cfset salestaxprice = price * (LSParseNumber(getInfo.salestax) / 100)>

	<cfset message = message & "Sales Tax: " & numberFormat(salestaxprice,numbermask) & " " & Trim(getCurrency.type) & nl & nl>	
	
	<cfset administrative_fee = LSParseNumber(administrative_fee)>
	<cfset financial_fee = LSParseNumber(financial_fee)>
	<cfset premium_fee = LSParseNumber(premium_fee)>
	<cfset shipping_fee = getInfo.shipping_fee>
	
	<cfif not premium_fee eq 0>
		<cfset premium_fee = price * (premium_fee / 100)>
	</cfif>
	
	<cfset message = message & "Administrative Fee: " & numberFormat(administrative_fee,numbermask) & " " & Trim(getCurrency.type) & nl>
	<cfset message = message & "Financial Fee: " & numberFormat(financial_fee,numbermask) & " " & Trim(getCurrency.type) & nl>
	<cfset message = message & "Buyer's Premium: " & numberFormat(premium_fee,numbermask) & " " & Trim(getCurrency.type) & nl>	
	<cfset message = message & "Shipping Fee: " & numberFormat(shipping_fee,numbermask) & " " & Trim(getCurrency.type) & nl & nl>	
	
	<cfset price = price + salestaxprice + administrative_fee + financial_fee + premium_fee + shipping_fee>
	
	<cfset message = message & "Total: " & numberFormat(price,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
    
    <cfset message = message & "Please contact the seller as soon as possible." & nl & nl>
    
    <cfset message = message & "Click here for the complete results of this auction: http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#" & nl & nl>
    
    <!-- inc if IEscrow enabled -->
    <!--- <cfif hIEscrow.bEnabled>
      
      <cfset message = message & "To initiate eNetSettle transaction Click here: http://#CGI.SERVER_NAME##VAROOT#/iescrow/index.cfm?itemnum=#Attributes.itemnum#&user_id=#getBidders.user_id#" & nl & nl>
    </cfif> --->
    
    <!-- send email -->
    <cfmodule template="eml_bidder_results.cfm"
      to="#Trim(getBidders.email)#"
      from="#Attributes.fromEmail#"
      subject="Congratulations: (Item ###Attributes.itemnum#) #Trim(getInfo.title)#"
      message="#Variables.message#">
      
    <!--- log results sent to bidder --->
    <cfmodule template="../../functions/addTransaction.cfm"
      datasource="#Attributes.DATASOURCE#"
      description="Auction Results emailed to Bidder"
      itemnum="#Attributes.itemnum#"
      details="#Variables.message#"
      user_id="#getBidders.user_id#">
	  
	  <!-- update winner field -->
	<cfquery username="#db_username#" password="#db_password#" name="upd_winner" datasource="#Attributes.datasource#">
    UPDATE bids
	SET winner = 1
	WHERE id = #id#
	</cfquery>
  </cfloop>
</cfif>
</cfif>

