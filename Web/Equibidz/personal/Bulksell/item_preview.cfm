<!---
  item_preview.cfm
  Displays a preview of what the item will look like once it's added to
  the site.
  Includes reverse auctions and studio.
  Walter 11/29/99
--->
<cfsetting enablecfoutputonly="Yes">

<!--- enable Session state management --->
<cfset mins_until_timeout = 60>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">
<!---  --->

  <cfif mode_switch is "dual">
    <cfif not isDefined('session.auction_mode')>
      <cfset auction_mode = form.auction_mode>
    <cfelse>
      <cfset auction_mode = session.auction_mode>
    </cfif>
  </cfif>




<cfif auction_mode is 0>
<!-- Regular auctions -- reverse auction begins on line 819 -->

  

  <!--- Check for item storage session variables --->
  <cfif #isDefined ("session.held_item")# is 1>
    <cfif #session.held_item# is "0">
      <cflocation url="index.cfm">
    </cfif>
  <cfelse>
    <cflocation url="index.cfm">
  </cfif>

  <cfif #isDefined ("mode")# is 0>
    <cfset #mode# = "sell">
  </cfif>

  <cftry>
    <cfcatch>
      <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
    </cfcatch>
  </cftry>
  
  <!--- define found/not found --->
  <cfset isvalid = "TRUE">
 
  <!--- if valid item get rest of info --->
  <cfif isvalid>
    <!--- get currency type --->
    <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
    </cfquery>
  
    <!--- def currency name --->
    <cfmodule template="../functions/cf_currencies.cfm"
      mode="CODECONVERT"
      code="#Trim(getCurrency.type)#"
       return="currencyName">

    <cftry>
    <!--- get category name of item --->
      <cfquery username="#db_username#" password="#db_password#" name="get_CategoryInfo" datasource="#DATASOURCE#">
        SELECT name
          FROM categories
         WHERE category = #session.category1#
      </cfquery>
      <cfset category_name = Trim(get_CategoryInfo.name)>
        <cfcatch>
          <cfset category_name = "Not Available">
        </cfcatch>
    </cftry>
    
    <cftry>
    <!--- get current high bid --->
      <cfquery username="#db_username#" password="#db_password#" name="get_HighBid" datasource="#DATASOURCE#">
          SELECT MAX(bid) AS highest
            FROM bids
           WHERE itemnum = #session.itemnum#
      </cfquery>
      <cfif not get_HighBid.RecordCount>
        <cfthrow>
      </cfif>
      <cfset current_bid = get_HighBid.highest>
      <cfcatch>
        <cfset current_bid = session.minimum_bid>
      </cfcatch>
    </cftry>
  
    <cftry>
      <!--- get seller's info --->
      <cfquery username="#db_username#" password="#db_password#" name="get_SellerInfo" datasource="#DATASOURCE#">
        SELECT nickname, email
          FROM users
         WHERE user_id = #session.user_id#
      </cfquery>
    
      <cfset seller_nickname = Trim(get_SellerInfo.nickname)>
      <cfset seller_email = Trim(get_SellerInfo.email)>
    
      <cfcatch>
        <cfset seller_nickname = "Not Available">
        <cfset seller_email = "Not Available">
      </cfcatch>
    </cftry>
  
    <cftry>
      <!--- get parents of this category --->
      <cfmodule template="../functions/parentlookup.cfm"
        CATEGORY="#session.category1#"
        DATASOURCE="#DATASOURCE#"
        RETURN="parents_array">
    
      <cfcatch>
        <cfset parents_array = ArrayNew(2)>
      </cfcatch>
    </cftry>
  
    <cftry>
      <!--- get current bid, number of bids, define reserve met --->
      <cfquery username="#db_username#" password="#db_password#" name="get_HighBid" datasource="#DATASOURCE#">
          SELECT MAX(bid) AS highest, COUNT(bid) AS bidcount
            FROM bids
           WHERE itemnum = #session.itemnum#
      </cfquery>
      <cfset bid_currently = IIf(get_HighBid.bidcount, "get_HighBid.highest", "session.minimum_bid")>
      <cfset bid_count = get_HighBid.bidcount>
      <cfif session.auction_type IS "V">
        <cfquery username="#db_username#" password="#db_password#" name="getSecondBid" datasource="#DATASOURCE#" maxrows=2>
         SELECT bid
           FROM bids
          WHERE itemnum = #session.itemnum#
          ORDER BY bid DESC
        </cfquery>
        <cfloop query="getSecondBid">
          <cfset secondBidder = getSecondBid.bid>
        </cfloop>
        <cfset reserve_met = IIf(secondBidder LT session.reserve_bid, DE("(reserve not met)"), DE(""))>
      <cfelse>
        <cfset reserve_met = IIf(bid_currently LT session.reserve_bid, DE("(reserve not met)"), DE(""))>
      </cfif>
      <cfcatch>
        <cfset bid_currently = "0">
        <cfset reserve_met = "not available">
        <cfset bid_count = "Not Available">
      </cfcatch>
    </cftry>
  
    <!--- define time left --->
    <cfset timeleft = session.date_end - TIMENOW>
    <cfif timeleft GTE 1>
      <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
      <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
      <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
      <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
      <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & " +">
    <cfelse>
      <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
      <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
      <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
      <cfset minslabel = IIf(minsleft IS 1, DE("min"), DE("mins"))>
      <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
    </cfif>
  
    <!--- define started date format --->
    <cfset started = DateFormat(session.date_start, "mm/dd/yy") & " " & TimeFormat(session.date_start, "HH:mm:ss")>
  
    <!--- define ends date format --->
    <cfset ends = DateFormat(session.date_end, "mm/dd/yy") & " " & TimeFormat(session.date_end, "HH:mm:ss")>
  
    <!--- define seller's feedback rating --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="get_SellerFeedback" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS ratinglevel, COUNT(rating) AS totalfeed
          FROM feedback
         WHERE user_id = #session.user_id#
      </cfquery>
    
      <cfif get_SellerFeedback.totalfeed>
        <cfset ratingSeller = Round(get_SellerFeedback.ratinglevel)>
      <cfelse>
        <cfset ratingSeller = 0>
      </cfif>
    
      <cfcatch>
        <cfset ratingSeller = "not available">
      </cfcatch>
    </cftry>
  
    <!--- define "ask seller question" link value --->
    <cfif session.private>
      <cfset questionLinkSell = "/messages/index.cfm?user_id=" & session.user_id>
    <cfelse>
      <cfset questionLinkSell = "mailto:" & seller_email>
    </cfif>
  
    <!--- get high bidder info --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getHighBidder" datasource="#DATASOURCE#" maxrows="1">
        SELECT user_id
          FROM bids
         WHERE itemnum = #session.itemnum#
         ORDER BY bid DESC
      </cfquery>
    
      <cfquery username="#db_username#" password="#db_password#" name="getBidderInfo" datasource="#DATASOURCE#">
        SELECT nickname, email
          FROM users
         WHERE user_id = #getHighBidder.user_id#
      </cfquery>
    
      <cfquery username="#db_username#" password="#db_password#" name="getBidderRating" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS ratinglevel, COUNT(rating) AS totalfeed
          FROM feedback
         WHERE user_id = #getHighBidder.user_id#
      </cfquery>
    
      <cfif getBidderInfo.RecordCount>
        <cfset bidderNickname = Trim(getBidderInfo.nickname)>
        <cfset bidderEmail = Trim(getBidderInfo.email)>
        <cfset bidderId = getHighBidder.user_id>
      <cfelse>
        <cfset bidderNickname = "Not Available">
        <cfset bidderEmail = "Not Available">
      </cfif>
    
      <cfif getBidderRating.totalfeed>
        <cfset ratingBidder = Round(getBidderRating.ratinglevel)>
      <cfelse>
        <cfset ratingBidder = 0>
      </cfif>
    
      <cfcatch>
        <cfset bidderNickname = "Not Available">
        <cfset bidderEmail = "Not Available">
        <cfset ratingBidder = "not available">
        <cfset bidderId = "not available">
      </cfcatch>
    </cftry>
  
    <!--- define "mailto" link value --->
    <cfif session.private>
      <cfset questionLinkBid = "/messages/index.cfm?user_id=" & bidderId>
    <cfelse>
      <cfset questionLinkBid = "mailto:" & bidderEmail>
    </cfif>
  
    <!--- define payment options --->
    <cfmodule template="../functions/options_list.cfm"
      mode="PAYMENT"
      morder_ccheck="#Session.pay_morder_ccheck#"
      cod="#Session.pay_cod#"
      see_desc="#Session.pay_see_desc#"
      pcheck="#Session.pay_pcheck#"
      ol_escrow="#Session.pay_ol_escrow#"
      other="#Session.pay_other#"
      visa_mc="#Session.pay_visa_mc#"
      am_express="#Session.pay_am_express#"
      discover="#Session.pay_discover#">
  
    <!--- define shipping options --->
    <cfmodule template="../functions/options_list.cfm"
      mode="SHIPPING"
      sell_pays="#Session.ship_sell_pays#"
      buy_pays_act="#Session.ship_buy_pays_act#"
      see_desc="#Session.ship_see_desc#"
      buy_pays_fxd="#Session.ship_buy_pays_fxd#"
      international="#Session.ship_international#">
  
    <!--- define pictureURL --->
    <cfif Right(session.picture, 4) IS ".gif" 
      OR Right(session.picture, 4) IS ".jpg"
      OR Right(session.picture, 4) IS ".png">
      <cfset isImage = "TRUE">
      <cfset pictureURL = Trim(session.picture)>
    <cfelse>
      <cfset isImage = "FALSE">
    </cfif>
  
    <!--- define soundURL --->
    <cfif Right(session.sound, 4) IS ".wav" 
      OR Right(session.sound, 3) IS ".au" 
      OR Right(session.sound, 3) IS ".ra" 
      OR Right(session.sound, 4) IS ".mp3" 
      OR Right(session.sound, 4) IS ".mid">
      <cfset isSound = "TRUE">
      <cfset soundURL = Trim(session.sound)>
    <cfelse>
      <cfset isSound = "FALSE">
    </cfif>
  
    <!--- define studioPictureURL --->
    <cfif session.studio>
      <cfif Right(session.picture_studio, 4) IS ".gif" 
        OR Right(session.picture_studio, 4) IS ".jpg"
        OR Right(session.picture_studio, 4) IS ".png">
        <cfset isStudioImage = "TRUE">
        <cfset studioPictureURL = Trim(session.picture_studio)>
      <cfelse>
        <cfset isStudioImage = "FALSE">
      </cfif>
    <cfelse>
      <cfset isStudioImage = "FALSE">
    </cfif>
  
    <!--- define studioSoundURL --->
    <cfif session.studio>
      <cfif Right(session.sound_studio, 4) IS ".wav" 
        OR Right(session.sound_studio, 3) IS ".au" 
        OR Right(session.sound_studio, 3) IS ".ra" 
        OR Right(session.sound_studio, 4) IS ".mp3" 
        OR Right(session.sound_studio, 4) IS ".mid">
        <cfset isStudioSound = "TRUE">
        <cfset studioSoundURL = Trim(session.sound_studio)>
      <cfelse>
        <cfset isStudioSound = "FALSE">
      </cfif>
    <cfelse>
      <cfset isStudioSound = "FALSE">
    </cfif>
  
    <!--- bidIncrement & minimumBid --->
    <cfif session.auction_type IS "E" OR session.auction_type IS "V">
      <cfset bidIncrement = IIf(session.increment, "session.increment_valu", "0.25")>
      <cfset minimumBid = numberFormat(Evaluate(bid_currently + bidIncrement),numbermask)>
     
	  <cfif get_HighBid.bidcount LT 1>
	   <cfset minimumBid = numberFormat(bid_currently,numbermask)>
	   </CFIF>
	    <cfset bidIncrement = numberFormat(bidIncrement,numbermask)>
    <cfelse>
      <cfset minimumBid = numberFormat(session.minimum_bid,numbermask)>
    </cfif>
    <cfset bid_currently = numberFormat(bid_currently,numbermask)>
  
    <!--- define userNickname if Session available --->
    <cftry>
      <cfif IsDefined("Session.nickname")>
        <cfset userNickname = Session.nickname>
      <cfelse>
        <cfset userNickname = "">
      </cfif>
    
      <cfcatch>
        <cfset userNickname = "">
      </cfcatch>
    </cftry>
  
    <!--- get default bid type --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getDefBidType" datasource="#DATASOURCE#">
          SELECT pair AS def_bidding
            FROM defaults
          WHERE name = 'def_bidding'
      </cfquery>
      <cfset defBidType = getDefBidType.def_bidding>
      <cfcatch>
        <cfset defBidType = "REGULAR">
      </cfcatch>
    </cftry>
  
    <!--- get enable_ssl --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getSSL" datasource="#DATASOURCE#">
          ELECT pair AS enable_ssl
           FROM defaults
          WHERE name = 'enable_ssl'
      </cfquery>
      <cfset enableSSL = getSSL.enable_ssl>
      <cfcatch>
        <cfset enableSSL = "FALSE">
      </cfcatch>
    </cftry>
  </cfif> <!--- is valid, (line 59)--->


  <!--- Auction_mode = 0 continues ... --->
  <!--- output information --->
  <cfsetting enablecfoutputonly="No">

  <html>
    <head>
      <title><cfif isvalid>Item <cfoutput>#session.itemnum# (#Trim(session.title)#)</cfoutput><cfelse>Item Not Found</cfif></title>
      <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
    </head>
    <cfinclude template="../includes/bodytag.html">
    <center>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <IMG SRC="<cfoutput>#VAROOT#</cfoutput>/images/logohere.gif"> &nbsp; &nbsp; &nbsp; 
              <font size=2>
                <cfinclude template="../includes/menu_bar.cfm">
              </font>
              <br>
            </center>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td colspan=2>
            <font size=4>
              <b>
                <cfoutput>
                  <cfif isvalid><font size=3 color="0000ff"><center>This is how your item will be seen on the site:</center></font>

          </td>
        </tr>
        <tr>
        <td>
          <cfif #session.featured_studio# IS 1><IMG src="../../thumbs/#session.incoming#"></cfif> #Trim(session.title)#<cfelse>Not Found</cfif>
          </cfoutput>
          </b></font>
        </td>
        <td align=right valign=bottom>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td align=right>
                <cfif #mode# is not "relist"><form action="index.cfm" method="post"><cfelse><form action="<cfoutput>#VAROOT#</cfoutput>/personal/relist_info.cfm" method="post"></cfif>
                  <cfoutput>
                    <input type="hidden" name="itemnum" value="#itemnum#">
                    <input type="submit" name="submit" value="<< Back" width=75>
                  </cfoutput>
                 </form>
              </td>
              <td>&nbsp;</td>
              <td align=right>
                <form action="item_submit.cfm" method="post">                         
                <cfoutput>
                  <input type="hidden" name="itemnum" value="#itemnum#">
                  <input type="hidden" name="mode" value="#mode#">
                  <input type="submit" name="submit" value="Add Item" width=75>
                </cfoutput>
                </form>
              </td>            
            </tr>
          </table>      
        </td>
      </tr>
      <tr>
        <td colspan=2>
                   <hr size=1 color=#heading_color# width=100%>
          <cfif isvalid>
            <b>Item ## 
            <cfoutput>#session.itemnum#
              <cfif session.banner>
                - #session.banner_line#
              </cfif>
            </cfoutput>
            </b>
          </cfif>
        </td>
      </tr>
    </table>
      
      <cfif not isvalid>
        Item not found... please try another item.
        </center>
        </body>
        </html>
        <cfabort>
      </cfif>
      
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=2>
              <center>
                <br>
                <cfsetting enablecfoutputonly="Yes">
                <!--- output parents --->
                <cfloop index="i" from="#ArrayLen(parents_array)#" to="1" step="-1">
                  <cfoutput>#parents_array[i][1]#: </cfoutput>
                </cfloop>
                <cfoutput>#Variables.category_name#:</cfoutput>
                <cfsetting enablecfoutputonly="No">
              </center>
            </font>
          </td>
        </tr>
      </table>
      <!-- auction information -->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td rowspan=10 width=80 valign=top align=center>
            <font size=2>
              <br>
              <a href="##">Description</a>
              <br>
              <br>
              <br>
              <br>
              <a href="##">Bid</a>
            </font>
          </td>
          <td width=80 valign=top>
            <font size=2>
              Currently
            </font>
          </td>
          <td width=200 valign=top>
            <font size=2>
              <cfoutput><b>#bid_currently# #Trim(getCurrency.type)#</b> #reserve_met#</cfoutput>
            </font>
          </td>
          <td width=80 valign=top>
            <font size=2>
              First Bid
            </font>
          </td>
          <td width=200 valign=top>
            <font size=2>
              <cfoutput>#numberFormat(session.minimum_bid,numbermask)# #Trim(getCurrency.type)#</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Quantity
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <b><cfoutput>#session.quantity#</cfoutput></b>
            </font>
          </td>
          <td valign=top>
            <font size=2>
              # of Bids
            </font>
          </td>
          <td valign=top>
            <font size=2>
             <cfoutput><b>#bid_count#</b> (<a href="##">bid history</a>)</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Time Left
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <b><cfoutput>#timeleft#</cfoutput></b>
            </font>
          </td>
          <td valign=top>
            <font size=2>
              Location
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <b><cfoutput>#Trim(session.location)#</cfoutput></b>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Started
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <cfoutput>#started#</cfoutput>
            </font>
          </td>
          <td valign=top>
            <font size=2>
            Country
            </font>
          </td>
          <td valign=top>
            <font size=2>
            <b><cfoutput>#Trim(session.country)#</cfoutput></b>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Ends
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <cfoutput>#ends#</cfoutput>
            </font>
          </td>
          <td colspan=2 valign=top>
            <font size=2>
              (<a href="##">mail this auction to a friend</a>)
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Seller
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput><b><a href="##">#seller_nickname#</a> (<a href="##">#ratingSeller#</a>)</b></cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td></td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput>(<a href="##">view feedback on seller</a>) (<a href="##">view other auctions by seller</a>) (<a href="##">ask seller a question</a>)</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              High bid
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfif bidderNickname IS NOT "Not Available"><cfoutput><b><a href="##">#bidderNickname#</a> (<a href="##">#ratingBidder#</a>)</b></cfoutput></cfif>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Payment
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput>#paymentOpt#</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Shipping
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput>#shippingOpt#</cfoutput>
            </font>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <font size=2>
              Seller assumes all responsibility for listing this item.  You should contact 
              the seller to resolve any questions before bidding.  Currency is <cfoutput>#Trim(getCurrency.type)# (#currencyName#)</cfoutput> unless otherwise noted.
              <br>
              <br>
            </font>
          </td>
        </tr>
        <tr>
          <td>
            <font size=4>
              <b>
                Description
              </b>
            </font>
                     <hr size=1 color=#heading_color# width=100%>
          </td>
        </tr>
      </table>
      <!--- display description --->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <cfoutput>#Trim(session.description)#</cfoutput>
            <br>
            <br>
            <cfif isImage>
              <cfoutput><br><img src="#pictureURL#"></cfoutput>
            </cfif>
            <cfif isSound>
              <cfoutput><br><b>Sound:</b> <a href="#soundURL#">#soundURL#</a></cfoutput>
            </cfif>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=4>
              <b>Bidding</b>
            </font>
                     <hr size=1 color=#heading_color# width=100%>
          </td>
        </tr>
      </table>
      <!--- display bidding info --->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top align=center colspan=4>
            <cfoutput>#Trim(session.title)# (Item ###session.itemnum#)</cfoutput>
            <br>
            <br>
          </td>
        </tr>
        <cfif session.auction_type IS "E" OR session.auction_type IS "V">
          <tr>
            <td></td>
            <td align=left>
              <font size=2>
                Current Bid
              </font>
            </td>
            <td align=right>
              <cfoutput>#bid_currently# #Trim(getCurrency.type)#</cfoutput>
            </td>
            <td></td>
          </tr>
          <tr>
            <td></td>
            <td align=left>
              <font size=2>
                Bid Increment
              </font>
            </td>
            <td align=right>
              <cfoutput>#bidIncrement# #Trim(getCurrency.type)#</cfoutput>
            </td>
            <td></td>
          </tr>
        </cfif>
        <tr>
          <td width=180></td>
          <td width=140 align=left>
            <font size=2>
              <b>Minimum Bid</b>
            </font>
          </td>
          <td width=140 align=right>
            <cfoutput><b>#minimumBid# #Trim(getCurrency.type)#</b></cfoutput>
          </td>
          <td width=180></td>
        </tr>
        <tr>
         <td colspan=4>
          <br>
                   <hr size=1 color=#heading_color# width=100%>
          <br>
<!---
          <table border=0 cellspacing=0 cellpadding=0>
           <tr>                       
            <td><cfif #mode# is not "relist"><form action="index.cfm" method="post"><cfelse><form action="<cfoutput>#VAROOT#</cfoutput>/personal/relist_info.cfm" method="post"></cfif>
              <cfoutput>
               <input type="hidden" name="itemnum" value="#itemnum#">
               <input type="submit" name="submit" value="<< Back" width=75>
              </cfoutput>
             </form>
            </td>
            <td>&nbsp;</td>
            <td>
             <form action="item_submit.cfm" method="post">
              <cfoutput>
               <input type="hidden" name="itemnum" value="#itemnum#">
               <input type="hidden" name="mode" value="#mode#">
               <input type="submit" name="submit" value="Add Item" width=75>
              </cfoutput>
             </form>
            </td>            
            </tr>
          </table>
--->          
          Click the "back" button to go back and modify or correct information,<br>
          otherwise click the "add item" button to place your item up for auction.
          <br><br>
         </td>
        </tr>
<!--- 
       <tr>
          <td valign=top colspan=4>
            <font size=2>
              <br>
              <b>Registration Required.</b>  You must be a registered user in order to 
              place a bid.  <a href="<cfoutput>#VAROOT#</cfoutput>/registration/index.cfm">Click here</a> to find 
              out how to become a registered user.
            </font>
          </td>
        </tr> 
--->
        </table>
      <!--- display bidding form --->
        <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td>
              <!--- include menu bar --->
              <center>
                <font size=2>
                  <cfinclude template="../includes/menu_bar.cfm">
                </font>
                <br><br>
              </center>
            </td>
          </tr>
        </table>
        <br><br>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td align=left valign=top>
              <font size=2>
                <cfinclude template="../includes/copyrights.cfm">
                <br><br><br>
              </font>
            </td>
          </tr>
        </table>
      </center>
    </body>
  </html>











<!---------------------------------------------------------------------------------------------->
<cfelse>
<!-- Reverse Auction -->


<!--- Check for item storage session variables --->
<cfif #isDefined ("session.held_item")# is 1>
 <cfif #session.held_item# is "0">
  <cflocation url="index.cfm">
 </cfif>
<cfelse>
  <cflocation url="index.cfm">
</cfif>

<cfif #isDefined ("mode")# is 0>
 <cfset #mode# = "sell">
</cfif>

<cftry>
  <!--- include globals --->
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>
  
<!--- define found/not found --->
<cfset isvalid = "TRUE">
 

<!--- if valid item get rest of info --->
<cfif isvalid>
  <!--- enable Session state management --->
  <cfset mins_until_timeout = 60>
  <cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">
  
  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <!--- def currency name --->
  <cfmodule template="../functions/cf_currencies.cfm"
    mode="CODECONVERT"
    code="#Trim(getCurrency.type)#"
    return="currencyName">
  
  <cftry>
    <!--- get category name of item --->
    <cfquery username="#db_username#" password="#db_password#" name="get_CategoryInfo" datasource="#DATASOURCE#">
        SELECT name
          FROM categories
         WHERE category = #session.category1#
    </cfquery>
    
    <cfset category_name = Trim(get_CategoryInfo.name)>
    
    <cfcatch>
      <cfset category_name = "Not Available">
    </cfcatch>
  </cftry>
  
  <cftry>
    <!--- get current high bid --->
    <cfquery username="#db_username#" password="#db_password#" name="get_LowBid" datasource="#DATASOURCE#">
        SELECT Min(bid) AS lowest
          FROM bids
         WHERE itemnum = #session.itemnum#
    </cfquery>
    
    <cfif not get_LowBid.RecordCount>
      <cfthrow>
    </cfif>
    
    <cfset current_bid = get_LowBid.lowest>
    
    <cfcatch>
      <cfset current_bid = session.maximum_bid>
    </cfcatch>
  </cftry>
  
  <cftry>
    <!--- get seller's info --->
    <cfquery username="#db_username#" password="#db_password#" name="get_SellerInfo" datasource="#DATASOURCE#">
        SELECT nickname, email
          FROM users
         WHERE user_id = #session.user_id#
    </cfquery>
    
    <cfset seller_nickname = Trim(get_SellerInfo.nickname)>
    <cfset seller_email = Trim(get_SellerInfo.email)>
    
    <cfcatch>
      <cfset seller_nickname = "Not Available">
      <cfset seller_email = "Not Available">
    </cfcatch>
  </cftry>
  
  <cftry>
    <!--- get parents of this category --->
    <cfmodule template="../functions/parentlookup.cfm"
      CATEGORY="#session.category1#"
      DATASOURCE="#DATASOURCE#"
      RETURN="parents_array">
    
    <cfcatch>
      <cfset parents_array = ArrayNew(2)>
    </cfcatch>
  </cftry>
  
  <cftry>
    <!--- get current bid, number of bids, define reserve met --->
    <cfquery username="#db_username#" password="#db_password#" name="get_LowBid" datasource="#DATASOURCE#">
        SELECT MIN(bid) AS lowest, COUNT(bid) AS bidcount
          FROM bids
         WHERE itemnum = #session.itemnum#
    </cfquery>
    
    <cfset bid_currently = IIf(get_LowBid.bidcount, "get_LowBid.lowest", "session.maximum_bid")>
    <cfset bid_count = get_LowBid.bidcount>
    
    <cfif session.auction_type IS "V">
      <cfquery username="#db_username#" password="#db_password#" name="getSecondBid" datasource="#DATASOURCE#" maxrows=2>
          SELECT bid
            FROM bids
           WHERE itemnum = #session.itemnum#
           ORDER BY bid ASC
      </cfquery>
      
      <cfloop query="getSecondBid">
        <cfset secondBidder = getSecondBid.bid>
      </cfloop>
      
      <cfset reserve_met = IIf(secondBidder GT session.reserve_bid, DE("(reserve not met)"), DE(""))>
    <cfelse>
      <cfset reserve_met = IIf(bid_currently GT session.reserve_bid, DE("(reserve not met)"), DE(""))>
    </cfif>
    
    <cfcatch>
      <cfset bid_currently = "#session.maximum_bid#">
      <cfset reserve_met = "not available">
      <cfset bid_count = "Not Available">
    </cfcatch>
  </cftry>
  
  <!--- define time left --->
  <cfset timeleft = session.date_end - TIMENOW>
  <cfif timeleft GTE 1>
    <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
    <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
    <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
    <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
    <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & " +">
  <cfelse>
    <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
    <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
    <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
    <cfset minslabel = IIf(minsleft IS 1, DE("min"), DE("mins"))>
    <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
  </cfif>
  
  <!--- define started date format --->
  <cfset started = DateFormat(session.date_start, "mm/dd/yy") & " " & TimeFormat(session.date_start, "HH:mm:ss")>
  
  <!--- define ends date format --->
  <cfset ends = DateFormat(session.date_end, "mm/dd/yy") & " " & TimeFormat(session.date_end, "HH:mm:ss")>
  
  <!--- define seller's feedback rating --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="get_SellerFeedback" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS ratinglevel, COUNT(rating) AS totalfeed
          FROM feedback
         WHERE user_id = #session.user_id#
    </cfquery>
    
    <cfif get_SellerFeedback.totalfeed>
      <cfset ratingSeller = Round(get_SellerFeedback.ratinglevel)>
    <cfelse>
      <cfset ratingSeller = 0>
    </cfif>
    
    <cfcatch>
      <cfset ratingSeller = "not available">
    </cfcatch>
  </cftry>
  
  <!--- define "ask seller question" link value --->
  <cfif session.private>
    <cfset questionLinkSell = "/messages/index.cfm?user_id=" & session.user_id>
  <cfelse>
    <cfset questionLinkSell = "mailto:" & seller_email>
  </cfif>
  
  <!--- get high bidder info --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getLowBidder" datasource="#DATASOURCE#" maxrows="1">
        SELECT user_id
          FROM bids
         WHERE itemnum = #session.itemnum#
         ORDER BY bid ASC
    </cfquery>
    
    <cfquery username="#db_username#" password="#db_password#" name="getBidderInfo" datasource="#DATASOURCE#">
        SELECT nickname, email
          FROM users
         WHERE user_id = #getLowBidder.user_id#
    </cfquery>
    
    <cfquery username="#db_username#" password="#db_password#" name="getBidderRating" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS ratinglevel, COUNT(rating) AS totalfeed
          FROM feedback
         WHERE user_id = #getLowBidder.user_id#
    </cfquery>
    
    <cfif getBidderInfo.RecordCount>
      <cfset bidderNickname = Trim(getBidderInfo.nickname)>
      <cfset bidderEmail = Trim(getBidderInfo.email)>
      <cfset bidderId = getLowBidder.user_id>
    <cfelse>
      <cfset bidderNickname = "Not Available">
      <cfset bidderEmail = "Not Available">
    </cfif>
    
    <cfif getBidderRating.totalfeed>
      <cfset ratingBidder = Round(getBidderRating.ratinglevel)>
    <cfelse>
      <cfset ratingBidder = 0>
    </cfif>
    
    <cfcatch>
      <cfset bidderNickname = "Not Available">
      <cfset bidderEmail = "Not Available">
      <cfset ratingBidder = "not available">
      <cfset bidderId = "not available">
    </cfcatch>
  </cftry>
  
  <!--- define "mailto" link value --->
  <cfif session.private>
    <cfset questionLinkBid = "/messages/index.cfm?user_id=" & bidderId>
  <cfelse>
    <cfset questionLinkBid = "mailto:" & bidderEmail>
  </cfif>
  
  <!--- define payment options --->
  <cfmodule template="../functions/options_list.cfm"
    mode="PAYMENT"
    morder_ccheck="#Session.pay_morder_ccheck#"
    cod="#Session.pay_cod#"
    see_desc="#Session.pay_see_desc#"
    pcheck="#Session.pay_pcheck#"
    ol_escrow="#Session.pay_ol_escrow#"
    other="#Session.pay_other#"
    visa_mc="#Session.pay_visa_mc#"
    am_express="#Session.pay_am_express#"
    discover="#Session.pay_discover#">
  
  <!--- define shipping options --->
  <cfmodule template="../functions/options_list.cfm"
    mode="SHIPPING"
    sell_pays="#Session.ship_sell_pays#"
    buy_pays_act="#Session.ship_buy_pays_act#"
    see_desc="#Session.ship_see_desc#"
    buy_pays_fxd="#Session.ship_buy_pays_fxd#"
    international="#Session.ship_international#">
  
  <!--- define pictureURL --->
  <cfif Right(session.picture, 4) IS ".gif" 
   OR Right(session.picture, 4) IS ".jpg"
   OR Right(session.picture, 4) IS ".png">
    <cfset isImage = "TRUE">
    <cfset pictureURL = Trim(session.picture)>
  <cfelse>
    <cfset isImage = "FALSE">
  </cfif>
  
  <!--- define soundURL --->
  <cfif Right(session.sound, 4) IS ".wav" 
   OR Right(session.sound, 3) IS ".au" 
   OR Right(session.sound, 3) IS ".ra" 
   OR Right(session.sound, 4) IS ".mp3" 
   OR Right(session.sound, 4) IS ".mid">
    <cfset isSound = "TRUE">
    <cfset soundURL = Trim(session.sound)>
  <cfelse>
    <cfset isSound = "FALSE">
  </cfif>
  
  <!--- define studioPictureURL --->
  <cfif session.studio>
    <cfif Right(session.picture_studio, 4) IS ".gif" 
      OR Right(session.picture_studio, 4) IS ".jpg"
      OR Right(session.picture_studio, 4) IS ".png">
      <cfset isStudioImage = "TRUE">
      <cfset studioPictureURL = Trim(session.picture_studio)>
    <cfelse>
      <cfset isStudioImage = "FALSE">
    </cfif>
  <cfelse>
    <cfset isStudioImage = "FALSE">
  </cfif>
  
  <!--- define studioSoundURL --->
  <cfif session.studio>
    <cfif Right(session.sound_studio, 4) IS ".wav" 
      OR Right(session.sound_studio, 3) IS ".au" 
      OR Right(session.sound_studio, 3) IS ".ra" 
      OR Right(session.sound_studio, 4) IS ".mp3" 
      OR Right(session.sound_studio, 4) IS ".mid">
      <cfset isStudioSound = "TRUE">
      <cfset studioSoundURL = Trim(session.sound_studio)>
    <cfelse>
      <cfset isStudioSound = "FALSE">
    </cfif>
  <cfelse>
    <cfset isStudioSound = "FALSE">
  </cfif>
  
  <!--- bidIncrement & maximumBid --->
  <cfif session.auction_type IS "E" OR session.auction_type IS "V">
    <cfset bidIncrement = IIf(session.increment, "session.increment_valu", "0.25")>
    <cfset #bid_currently# = REReplace("#bid_currently#", "[^0123456789.]", "", "ALL")>
<cfset maximumBid = numberFormat(Evaluate(bid_currently - bidIncrement),numbermask)>
<cfif get_LowBid.bidcount LT 1>
<cfset maximumBid = numberFormat(bid_currently,numbermask)>
</CFIF>

    
    <cfset bidIncrement = numberFormat(bidIncrement,numbermask)>
  <cfelse>
    <cfset maximumBid = numberFormat(session.maximum_bid,numbermask)>
  </cfif>
  <cfset bid_currently = numberFormat(bid_currently,numbermask)>
  
  <!--- define userNickname if Session available --->
  <cftry>
    <cfif IsDefined("Session.nickname")>
      <cfset userNickname = Session.nickname>
    <cfelse>
      <cfset userNickname = "">
    </cfif>
    
    <cfcatch>
      <cfset userNickname = "">
    </cfcatch>
  </cftry>
  
  <!--- get default bid type --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getDefBidType" datasource="#DATASOURCE#">
        SELECT pair AS def_bidding
          FROM defaults
         WHERE name = 'def_bidding'
    </cfquery>
    
    <cfset defBidType = getDefBidType.def_bidding>
    
    <cfcatch>
      <cfset defBidType = "REGULAR">
    </cfcatch>
  </cftry>
  
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
</cfif>

<!--- output information --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title><cfif isvalid>Item <cfoutput>#session.itemnum# (#Trim(session.title)#)</cfoutput><cfelse>Item Not Found</cfif></title>

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
    <center>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <IMG SRC="<cfoutput>#VAROOT#</cfoutput>/images/logohere.gif"> &nbsp; &nbsp; &nbsp; 
              <font size=2>
                <cfinclude template="../includes/menu_bar.cfm">
              </font>
              <br>
            </center>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=4>
              <b>
              <cfset reverse = '<IMG SRC="../images/R_reverse.gif" width=22 height=17 border=0 alt="This is a Reverse Auction">'>
                <cfoutput>
                <cfif isvalid><font size=3 color="0000ff"><center>This is how your item will be seen on the site:</center><br><br></font><cfif #session.featured_studio# IS 1><IMG src="../../thumbs/#session.incoming#"></cfif> #Trim(session.title)##reverse#<cfelse>Not Found</cfif>
                </cfoutput>
              </b>
            </font>
                     <hr size=1 color=#heading_color# width=100%>
            <cfif isvalid><b>Item # <cfoutput>#session.itemnum#<cfif session.banner> - #session.banner_line#</cfif></cfoutput></b></cfif>
          </td>
        </tr>
      </table>
      
      <cfif not isvalid>
              Item not found... please try another item.
            </center>
          </body>
        </html>
        <cfabort>
      </cfif>
      
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=2>
              <center>
                <br>
                <cfsetting enablecfoutputonly="Yes">
                <!--- output parents --->
                <cfloop index="i" from="#ArrayLen(parents_array)#" to="1" step="-1">
                  <cfoutput>#parents_array[i][1]#: </cfoutput>
                </cfloop>
                <cfoutput>#Variables.category_name#:</cfoutput>
                <cfsetting enablecfoutputonly="No">
              </center>
            </font>
          </td>
        </tr>
      </table>
      <!-- auction information -->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td rowspan=10 width=80 valign=top align=center>
            <font size=2>
              <br>
              <a href="##">Description</a>
              <br>
              <br>
              <br>
              <br>
              <a href="##">Offer</a>
            </font>
          </td>
          <td width=80 valign=top>
            <font size=2>
              Currently
            </font>
          </td>
          <td width=200 valign=top>
            <font size=2>
              <cfoutput><b>#bid_currently# #Trim(getCurrency.type)#</b> #reserve_met#</cfoutput>
            </font>
          </td>
          <td width=80 valign=top>
            <font size=2>
              First Offer
            </font>
          </td>
          <td width=200 valign=top>
            <font size=2>
              <cfset session.maximum_bid = REReplace("#session.maximum_bid#", "[^0123456789.]", "", "ALL")>
              <cfoutput>#numberFormat(session.maximum_bid,numbermask)# #Trim(getCurrency.type)#</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Quantity
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <b><cfoutput>#session.quantity#</cfoutput></b>
            </font>
          </td>
          <td valign=top>
            <font size=2>
              # of Offers
            </font>
          </td>
          <td valign=top>
            <font size=2>
             <cfoutput><b>#bid_count#</b> (<a href="##">Offers history</a>)</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Time Left
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <b><cfoutput>#timeleft#</cfoutput></b>
            </font>
          </td>
          <td valign=top>
            <font size=2>
              Location
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <b><cfoutput>#Trim(session.location)#</cfoutput></b>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Started
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <cfoutput>#started#</cfoutput>
            </font>
          </td>
          <td valign=top>
            <font size=2>
            Country
            </font>
          </td>
          <td valign=top>
            <font size=2>
            <b><cfoutput>#Trim(session.country)#</cfoutput></b>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Ends
            </font>
          </td>
          <td valign=top>
            <font size=2>
              <cfoutput>#ends#</cfoutput>
            </font>
          </td>
          <td colspan=2 valign=top>
            <font size=2>
              (<a href="##">mail this auction to a friend</a>)
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Buyer
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput><b><a href="##">#seller_nickname#</a> (<a href="##">#ratingSeller#</a>)</b></cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td></td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput>(<a href="##">view feedback on buyer</a>) (<a href="##">view other auctions by buyer</a>) (<a href="##">ask buyer a question</a>)</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              High Offer
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfif bidderNickname IS NOT "Not Available"><cfoutput><b><a href="##">#bidderNickname#</a> (<a href="##">#ratingBidder#</a>)</b></cfoutput></cfif>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Payment
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput>#paymentOpt#</cfoutput>
            </font>
          </td>
        </tr>
        <tr>
          <td valign=top>
            <font size=2>
              Shipping
            </font>
          </td>
          <td colspan=3 valign=top>
            <font size=2>
              <cfoutput>#shippingOpt#</cfoutput>
            </font>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <font size=2>
              Buyer assumes all responsibility for listing this item.  You should contact 
              the buyer to resolve any questions before making an offer.  Currency is <cfoutput>#Trim(getCurrency.type)# (#currencyName#)</cfoutput> unless otherwise noted.
              <br>
              <br>
            </font>
          </td>
        </tr>
        <tr>
          <td>
            <font size=4>
              <b>
                Description
              </b>
            </font>
                     <hr size=1 color=#heading_color# width=100%>
          </td>
        </tr>
      </table>
      <!--- display description --->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top>
            <cfoutput>#Trim(session.description)#</cfoutput>
            <br>
            <br>



<!---  ---><!---  --->


            <cfif isImage>
              <cfoutput><br><img src="#pictureURL#"></cfoutput>
            </cfif>
            
            
<!---  ---><!---  ---> 
 
 
 
 
 
            
            
            
            <cfif isSound>
              <cfoutput><br><b>Sound:</b> <a href="#soundURL#">#soundURL#</a></cfoutput>
            </cfif>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <font size=4>
              <b>Offering</b>
            </font>
                     <hr size=1 color=#heading_color# width=100%>
          </td>
        </tr>
      </table>
      <!--- display offring info --->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td valign=top align=center colspan=4>
            <cfoutput>#Trim(session.title)# (Item ###session.itemnum#)</cfoutput>
            <br>
            <br>
          </td>
        </tr>
        <cfif session.auction_type IS "E" OR session.auction_type IS "V">
          <tr>
            <td></td>
            <td align=left>
              <font size=2>
                Current Offer
              </font>
            </td>
            <td align=right>
              <cfoutput>#bid_currently# #Trim(getCurrency.type)#</cfoutput>
            </td>
            <td></td>
          </tr>
          <tr>
            <td></td>
            <td align=left>
              <font size=2>
                Offer Decrement
              </font>
            </td>
            <td align=right>
              <cfoutput>#bidIncrement# #Trim(getCurrency.type)#</cfoutput>
            </td>
            <td></td>
          </tr>
        </cfif>
        <tr>
          <td width=180></td>
          <td width=140 align=left>
            <font size=2>
              <b>Maximum Offer</b>
            </font>
          </td>
          <td width=140 align=right>
            <cfoutput><b>#maximumBid# #Trim(getCurrency.type)#</b></cfoutput>
          </td>
          <td width=180></td>
        </tr>
        <tr>
         <td colspan=4>
          <br>
                   <hr size=1 color=#heading_color# width=100%>
          <br>
          <table border=0 cellspacing=0 cellpadding=0>
           <tr>                       
            <td><cfif #mode# is not "relist"><form action="index.cfm" method="post"><cfelse><form action="<cfoutput>#VAROOT#</cfoutput>/personal/relist_info.cfm" method="post"></cfif>
              <cfoutput>
               <input type="hidden" name="itemnum" value="#itemnum#">
               <input type="submit" name="submit" value="<< Back" width=75>
              </cfoutput>
             </form>
            </td>
            <td>&nbsp;</td>
            <td>
             <form action="item_submit.cfm" method="post">
              <cfoutput>
               <input type="hidden" name="itemnum" value="#itemnum#">
               <input type="hidden" name="mode" value="#mode#">
               <input type="submit" name="submit" value="Add Item" width=75>
              </cfoutput>
             </form>
            </td>            
            
           </tr>
          </table>
          Click the "back" button to go back and modify or correct information,<br>
          otherwise click the "add item" button to place your item up for auction.
          
          <br><br>
         </td>
        </tr>
      </table>
      <!--- display bidding form --->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <font size=2>
                <cfinclude template="../includes/menu_bar.cfm">
              </font>
              <br>
              <br>
            </center>
          </td>
        </tr>
      </table>
      <br>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td align=left valign=top>
             <font size=2>
               <cfinclude template="../includes/copyrights.cfm">
               <br>
               <br>
               <br>
            </font>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
</cfif>
