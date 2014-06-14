<!---
  
  Ranking.cfm
  
  module for returning the rank of all bidders in an auction..
  
  Usage:
  
  <cfmodule template="Ranking.cfm"
    iItemNum="[item number]">
    
  Struct Returned: hRanking
  
  Keys Returned:
    .aList      ;array (list of bidders on auction)
      [].bQualified      ;bool (if bidder is qualified bid on auction)
      [].iRank      ;int (rank of bidder on auction)
      [].iUserId      ;int (user id of bidder)
      [].iQty      ;int (quantity of item bidder is entitled to)
      [].fPrice      ;float (price bidder must pay for entitled quantity)
      [].fBid      ;float (actual bid made at position)
      [].sNickname      ;string (user nickname)
      [].sEmail      ;string (user email)
    .bItemStatus      ;bool (false if auction is marked expired)
    .bItemSold      ;bool (true if auction has winning bidder)
    .aErrors      ;array (errors encountered while processing)
    
  Author: John Adams
  Date: 1999/09/02
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- chk req params --->
<cfloop index="e" list="iItemNum">
  
  <cfif not IsDefined("Attributes.#e#")>
    
    <cfoutput>
      <br>
      <b>ERROR:</b> "#e#" attribute of Ranking not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def vals --->
<cfset bItemIsNumeric = 1>
<cfset iQtyTaken = 0>

<cfset hTempStruct1 = StructNew()>
<cfset temp = StructInsert(hTempStruct1, "aList", ArrayNew(1))>
<cfset temp = StructInsert(hTempStruct1, "bItemStatus", "1")>
<cfset temp = StructInsert(hTempStruct1, "bItemSold", "0")>
<cfset temp = StructInsert(hTempStruct1, "aErrors", ArrayNew(1))>

<!--- init globals --->
<cfmodule template="../includes/app_globals.cfm"
  sStructName="hAppGlobals">

<!--- chk item # numeric --->
<cfif not IsNumeric(Attributes.iItemNum)>
  
  <cfset bItemIsNumeric = 0>      <!--- set not numeric item number --->
  <cfset temp = ArrayAppend(hTempStruct1.aErrors, "Item number is not numeric.")>      <!--- add error mesg to array --->
</cfif>

<!--- if numeric item # continue --->
<cfif Variables.bItemIsNumeric>
  
  <!--- chk item exist --->
  <cfquery username="#db_username#" password="#db_password#" name="chkStatus" datasource="#hAppGlobals.DATASOURCE#">
      SELECT status, auction_type, org_quantity as quantity, reserve_bid, minimum_bid
        FROM items
       WHERE itemnum = #Trim(Attributes.iItemNum)#
  </cfquery>
  
  <!--- if exist continue --->
  <cfif chkStatus.RecordCount>
    
    <!--- set item status --->
    <cfset temp = StructUpdate(hTempStruct1, "bItemStatus", chkStatus.status)>
    
    <!--- get bidders on item --->
    <cfquery username="#db_username#" password="#db_password#" name="getBids" datasource="#hAppGlobals.DATASOURCE#">
        SELECT user_id, bid, quantity
          FROM bids
         WHERE itemnum = #Trim(Attributes.iItemNum)#
         ORDER BY bid DESC, time_placed ASC
    </cfquery>
    
    <!--- set 2nd highest bid for Vickery --->
    <cfif getBids.RecordCount GTE 2>
      
      <cfloop query="getBids">
        <cfif getBids.CurrentRow IS 2>
          
          <cfset fVickeryWinBid = getBids.bid>
          <cfbreak>
        </cfif>
      </cfloop>
      
    <cfelse>
      <cfset fVickeryWinBid = chkStatus.minimum_bid>
    </cfif>
    
    <!--- set Dutch winning bid value --->
    <cfset fDutchWinBid = chkStatus.minimum_bid>
    
    <cfif getBids.RecordCount>
      <cfquery username="#db_username#" password="#db_password#" name="chkDutchQty" datasource="#hAppGlobals.DATASOURCE#">
          SELECT SUM(quantity) AS totalQty
            FROM bids
           WHERE itemnum = #Trim(Attributes.iItemNum)#
      </cfquery>
      
      <cfif chkDutchQty.totalQty GTE chkStatus.quantity>
        
        <cfloop query="getBids">
          
          <cfset iQtyTaken = iQtyTaken + getBids.quantity>
          
          <cfif iQtyTaken GTE chkStatus.quantity>
            
            <cfset fDutchWinBid = getBids.bid>
          </cfif>
        </cfloop>
        
        <cfset iQtyTaken = 0>
      </cfif>
    </cfif>
    
    <!--- add bidders to array by rank --->
    <cfloop query="getBids">
      
      <!--- def vals --->
      <cfset bQualified = 0>
      <cfset iQty = 0>
      <cfset fPrice = 0.00>
      <cfset fBid = 0.00>
      
      <cfset sNickname = "">
      <cfset sEmail = "">
      
      <!--- def qualified --->
      <cfif Variables.iQtyTaken LT chkStatus.quantity>
        
        <cfif chkStatus.auction_type IS "E"
          OR chkStatus.auction_type IS "V">
          
          <cfif getBids.CurrentRow IS 1>
            
            <cfif chkStatus.auction_type IS "E"
              AND getBids.bid GTE chkStatus.reserve_bid>
              
              <cfset bQualified = 1>
              
            <cfelseif chkStatus.auction_type IS "V"
              AND Variables.fVickeryWinBid GTE chkStatus.reserve_bid>
              
              <cfset bQualified = 1>
            </cfif>
          </cfif>
          
        <cfelseif chkStatus.auction_type IS "D"
          OR chkStatus.auction_type IS "Y">
          
          <cfif Variables.iQtyTaken LT chkStatus.quantity>
            <cfset bQualified = 1>
          </cfif>
        </cfif>
      </cfif>
      
      <!--- def qty qualified for --->
      <cfif chkStatus.auction_type IS "E"
        AND Variables.bQualified
        OR chkStatus.auction_type IS "V"
        AND Variables.bQualified>
        
        <cfset iQty = getBids.quantity>
        
      <cfelseif chkStatus.auction_type IS "D"
        AND Variables.bQualified
        OR chkStatus.auction_type IS "Y"
        AND Variables.bQualified>
        
        <cfif getBids.quantity LTE Evaluate(chkStatus.quantity - Variables.iQtyTaken)>
          
          <cfset iQty = getBids.quantity>
          
        <cfelse>
          <cfset iQty = chkStatus.quantity - Variables.iQtyTaken>
        </cfif>
      </cfif>
      
      <!--- def price --->
      <cfif chkStatus.auction_type IS "E">
        
        <cfset fPrice = getBids.bid>
        
      <cfelseif chkStatus.auction_type IS "V">
        
        <cfset fPrice = fVickeryWinBid>
        
      <cfelseif chkStatus.auction_type IS "D">
        
        <cfset fPrice = fDutchWinBid>
        
      <cfelseif chkStatus.auction_type IS "Y">
        
        <cfset fPrice = getBids.bid>
      </cfif>
      
      <!--- def qty taken --->
      <cfset iQtyTaken = Variables.iQtyTaken + Variables.iQty>
      
      <!--- def item sold --->
      <cfif not hTempStruct1.bItemSold
        AND Variables.bQualified>
        
        <cfset temp = StructUpdate(hTempStruct1, "bItemSold", "1")>
      </cfif>
      
      <!--- get user info --->
      <cfquery username="#db_username#" password="#db_password#" name="getUserInfo" datasource="#hAppGlobals.DATASOURCE#">
          SELECT nickname, email
            FROM users
           WHERE user_id = #getBids.user_id#
      </cfquery>
      
      <cfif getUserInfo.RecordCount>
        
        <cfset sNickname = Trim(getUserInfo.nickname)>
        <cfset sEmail = Trim(getUserInfo.email)>
      </cfif>
      
      <cfset hTempStruct1.aList[getBids.CurrentRow] = StructNew()>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "bQualified", Variables.bQualified)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "iRank", getBids.CurrentRow)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "iUserId", getBids.user_id)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "iQty", Variables.iQty)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "fPrice", Variables.fPrice)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "fBid", getBids.bid)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "sNickname", Variables.sNickname)>
      <cfset temp = StructInsert(hTempStruct1.aList[getBids.CurrentRow], "sEmail", Variables.sEmail)>
      
    </cfloop>
    
  <!--- else add error mesg --->
  <cfelse>
    
    <cfset temp = ArrayAppend(hTempStruct1.aErrors, "Item does not exist in database.")>
  </cfif>
</cfif>

<!--- rtn vals to caller --->
<cfset Caller.hRanking = hTempStruct1>

<cfsetting enablecfoutputonly="No">
