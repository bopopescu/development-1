<cfsetting enablecfoutputonly="Yes">
<!---
  index.cfm
  
  main bid page...
  displays form using "itemnum"...
  and/or displays confirm bid...
  
  Files used:
    - ./eml_bidconfirmation.cfm
    - ./eml_outbiduser.cfm
    - ./proxy.cfm
    - /functions/cf_currencies.cfm
    - /functions/checkbid.cfm
    - /functions/setupDefProxyMax.cfm
    - /functions/timenow.cfm
    - /includes/404notfound.cfm
    - /includes/app_globals.cfm
    - /includes/copyrights.cfm
  
--->

<!-- <cftry> -->
  <!--- include globals --->
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  <!--
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm?error=Could+not+include+file:+app_globals+or+timenow">
  </cfcatch>
</cftry>
-->

 

 <!--- set auction_mode --->
		<cfquery username="#db_username#" password="#db_password#" name="get_auction_mode" datasource="#DATASOURCE#">
      	SELECT auction_mode
        FROM items
       	WHERE itemnum = #itemnum#
  		</cfquery>
  		<cfset session.auction_mode = get_auction_mode.auction_mode>
  		<cfset auction_mode = session.auction_mode>

 
<cfif session.auction_mode is 0>
<!--- Regular auctions -- Reverse Auction begins on line  185 --->

<cfif isDefined('url.itemnum')>
<cfset session.itemnum = url.itemnum>
</cfif>

<!--- define if item number valid & retrieve info --->
<cftry>
  <!--- get item's info --->
  <cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#DATASOURCE#">
      SELECT itemnum, title, auction_type, increment, increment_valu, minimum_bid, reserve_bid, date_end, quantity,dynamic, buynow_price, buynow
        FROM items
       WHERE itemnum = #itemnum#
  </cfquery>
  
  
  <!--- define found/not found --->
  <cfset isvalid = IIf(get_ItemInfo.RecordCount, DE("TRUE"), DE("FALSE"))>
  
  <cfcatch>
    <cfset isvalid = "FALSE">
  </cfcatch>
</cftry>

<!--- if valid, setup info --->
<cfif isvalid>
  
  <!--- enable Session state management --->
  <cfset mins_until_timeout = 60>
  <cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">

  <cfparam name="session.nickname" default="">
  <cfparam name="session.password" default="">
  <cfparam name="session.bid"      default="0">
  <cfparam name="session.bidType" default="">
  <cfparam name="session.quantity" default="">
  <cfparam name="session.increment_valu" default="">
  
  <cfset session.nickname = iif(isdefined("nickname"), "nickname", "session.nickname")>
  <cfset session.password = iif(isdefined("password"), "password", "session.password")>
  <cfset session.bid      = iif(isdefined("bid"),      "bid",      "session.bid")>
  <cfset session.bidType = iif(isdefined("bidType"), "bidType", "session.bidType")>
  <cfset session.quantity = iif(isdefined("quantity"), "quantity", "session.quantity")>
  <cfset session.increment_valu = iif(isdefined('increment_valu'), "increment_valu", "session.increment_valu")>




   
   
    
    
  <cfinclude template="./inc_bid_logic.cfm">

</cfif>

<!--- get bool iescrow enabled --->


<!--- if iescrow enabled, get current vals --->
<!--- <cfif hIEscrow.bEnabled>
  
  <cfmodule template="../functions/IEscrowIcons.cfm"
    sOpt="DISP/FRONTPAGE">
</cfif> --->

<cftry>
  <cfset title_itemnum = "##" & get_ItemInfo.itemnum>
  <cfset title_itemtitle = " (" & get_ItemInfo.title & ")">

  <cfcatch>
    <cfset title_itemnum = "">
    <cfset title_itemtitle = "">

  </cfcatch>
</cftry>

<!--- output page --->
<cfsetting enablecfoutputonly="No">

<cfoutput>

<html>
  <head>
    <title>Bid on Item #title_itemnum##title_itemtitle#</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
    <div align="center">
      <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
		  	<cfif isdefined("buynow_yes") or isdefined("buynow")>
			<font size=4>
              <b>Buy on Item</b>
            </font>
			<cfelse>
            <font size=4>
              <b>Bid on Item</b>
            </font>
			</cfif>
            <hr size=1 color=#heading_color# width=100%> 
          </td>
        </tr>
      </table>
      <cfif isvalid>
        <cfparam name="isGoodBid" default="false">
        
        <cfif (IsDefined("reviewBid") OR IsDefined("buynow_yes")) AND isGoodBid>

	      <cfinclude template="./inc_form_verify_bid.cfm">

        <cfelseif IsDefined("submitBid") AND isGoodBid>

          <cfinclude template="./inc_html_final.cfm">
        <cfelse>

          <cfinclude template="./inc_form_redo_bid.cfm">
        </cfif>

      <cfelse>

          <cfinclude template="./inc_item_not_found.cfm">
      </cfif>

      <br>
      <br>

	
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></div>
  </body>
</html>

</cfoutput>
<cfelse>
<!-- Reverse Auction -->

<!--- define if item number valid & retrieve info --->
<cftry>
  <!--- get item's info --->
  <cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#DATASOURCE#">
      SELECT itemnum, title, auction_type, increment, increment_valu, maximum_bid, reserve_bid, date_end, quantity
        FROM items
       WHERE itemnum = #itemnum#
  </cfquery>
  
  <!--- define found/not found --->
  <cfset isvalid = IIf(get_ItemInfo.RecordCount, DE("TRUE"), DE("FALSE"))>
  
  <cfcatch>
    <cfset isvalid = "FALSE">
  </cfcatch>
</cftry>

<!--- if valid, setup info --->
<cfif isvalid>
  
  <!--- enable Session state management --->
  <cfset mins_until_timeout = 60>
  <cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">

  <cfparam name="session.nickname" default="">
  <cfparam name="session.password" default="">
  <cfparam name="session.bid"      default="">
  <cfparam name="session.quantity" default="">
  
  <cfset session.nickname = iif(isdefined("nickname"), "nickname", "session.nickname")>
  <cfset session.password = iif(isdefined("password"), "password", "session.password")>
  <cfset session.bid      = iif(isdefined("bid"),      "bid",      "session.bid")>
  <cfset session.quantity = iif(isdefined("quantity"), "quantity", "session.quantity")>
    
  <cfinclude template="./inc_bid_logic.cfm">

</cfif>

<!--- get bool iescrow enabled --->

<!--- if iescrow enabled, get current vals --->

<cftry>
  <cfset title_itemnum = "##" & get_ItemInfo.itemnum>
  <cfset title_itemtitle = " (" & get_ItemInfo.title & ")">

  <cfcatch>
    <cfset title_itemnum = "">
    <cfset title_itemtitle = "">

  </cfcatch>
</cftry>

<!--- output page --->
<cfsetting enablecfoutputonly="No">

<cfoutput>

<html>
  <head>
    <title>Bid on Item #title_itemnum##title_itemtitle#</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
    <div align="center">
      <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            <font size=4>
              <b>Offer on Item or Service</b>
            </font>
            <hr size=1 color=#heading_color# width=100%> 
          </td>
        </tr>
      </table>
      <cfif isvalid>
        <cfparam name="isGoodBid" default="false">
        
        <cfif IsDefined("reviewBid") AND isGoodBid>

	      <cfinclude template="./inc_form_verify_bid.cfm"> 

        <cfelseif IsDefined("submitBid") AND isGoodBid>

          <cfinclude template="./inc_html_final.cfm">
        <cfelse>

          <cfinclude template="./inc_form_redo_bid.cfm">
        </cfif>

      <cfelse>

          <cfinclude template="./inc_item_not_found.cfm">
      </cfif>

      <br>
      <br>

	  
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></div>
  </body>
</html>

</cfoutput>
</cfif>

