<cfsetting enablecfoutputonly="yes">

 <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Verify their username and password --->
 <cfif (#isDefined ("submit")# is 1)>
  <cfif #trim (submit)# is "Next >>">
   <cfquery username="#db_username#" password="#db_password#" name="verify_login" datasource="#DATASOURCE#">
    SELECT user_id
      FROM users
     WHERE nickname = '#user_id#'
     <cfif #isNumeric (user_id)# is 1>
        OR user_id = #user_id#
     </cfif>
       AND password = '#password#'
	   and is_active = 1
   </cfquery>
   <cfif #verify_login.recordCount# is 0>
    <cflocation url="index.cfm?failed=1">
   <cfelse>
    <cfset #session.user_id# = #verify_login.user_id#>
    <cfset #session.password# = #password#>
   </cfif>
  </cfif>
 </cfif>

 <!--- Resolves a nickname into a userid --->
 <cfif #isDefined ("session.user_id")# is 0>
  <cflocation url="index.cfm">
 </cfif>
 
 <!--- Get their expired auction --->
  <cfquery username="#db_username#" password="#db_password#" name="get_item" datasource="#DATASOURCE#">
   SELECT itemnum,
          status,
          user_id,
          category1,
          category2,
          auction_type,
          title,
          location,
          country,
          pay_morder_ccheck,
          pay_cod,
          pay_pcheck,
          pay_ol_escrow,
          pay_other,
          pay_visa_mc,
          pay_am_express,
          pay_discover,
          pay_see_desc,
          ship_sell_pays,
          ship_buy_pays_act,
          ship_see_desc,
          ship_buy_pays_fxd,
          ship_international,
          description,
          desc_languages,
          picture,
          sound,
          quantity,
          minimum_bid,
          increment,
          increment_valu,
          dynamic,
          dynamic_valu,
          reserve_bid,
          bold_title,
          featured,
          featured_cat,
          private,
          banner,
          banner_line,
          studio,
          featured_studio,
          picture_studio,
          sound_studio,
          date_start,
          date_end,
          billmeth,
          remote_ip
     FROM items
    WHERE itemnum=#itemnum#
  </cfquery>
 
<cfoutput>

 <!--- Check to see if we're saving an auction item --->
 <cfif #submit# is "Add Item">
  <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
 </cfif>
 <cfif (#submit# is "Add Item") and (#error_message# is "")>

   <!--- Make sure images and sounds begin with http:// --->
   <cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
    <cfset #picture# = "http://#picture#">
   </cfif>
   <cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
    <cfset #sound# = "http://#sound#">
   </cfif>
   <cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
    <cfset #picture_studio# = "http://#picture_studio#">
   </cfif>
   <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
    <cfset #sound_studio# = "http://#sound_studio#">
   </cfif>

   <!--- Save all posted vars into session variables --->
   <cfset #session.held_item# = "1">
   <cfset #session.itemnum# = #itemnum#>
<!---   <cfset #session.status# = #status#> --->
   <cfset #session.status# = "1">
   <cfset #session.password# = #password#>
   <cfset #session.user_id# = #selected_user#>
   <cfset #session.category1# = #category1#>
   <cfset #session.category2# = #category2#>
   <cfset #session.auction_type# = #auction_type#>
   <cfset #session.title# = #title#>
   <cfset #session.location# = #location#>
   <cfset #session.country# = #country#>

   <cfset #session.pay_morder_ccheck# = #pay_morder_ccheck#>
   <cfset #session.pay_cod# = #pay_cod#>
   <cfset #session.pay_see_desc# = #pay_see_desc#>
   <cfset #session.pay_pcheck# = #pay_pcheck#>
   <cfset #session.pay_ol_escrow# = #pay_ol_escrow#>
   <cfset #session.pay_other# = #pay_other#>
   <cfset #session.pay_visa_mc# = #pay_visa_mc#>
   <cfset #session.pay_am_express# = #pay_am_express#>
   <cfset #session.pay_discover# = #pay_discover#>
   <cfset #session.ship_sell_pays# = #ship_sell_pays#>
   <cfset #session.ship_buy_pays_act# = #ship_buy_pays_act#>
   <cfset #session.ship_see_desc# = #ship_see_desc#>
   <cfset #session.ship_buy_pays_fxd# = #ship_buy_pays_fxd#>
   <cfset #session.ship_international# = #ship_international#>

   <cfif #isDefined ("pay_morder_ccheck")#>
    <cfset #session.pay_morder_ccheck# = 1>
   <cfelse>
    <cfset #session.pay_morder_ccheck# = 0>
   </cfif>
   <cfif #isDefined ("pay_cod")#>
    <cfset #session.pay_cod# = 1>
   <cfelse>
    <cfset #session.pay_cod# = 0>
   </cfif>   
   <cfif #isDefined ("pay_see_desc")#>
    <cfset #session.pay_see_desc# = 1>
   <cfelse>
    <cfset #session.pay_see_desc# = 0>
   </cfif>   
   <cfif #isDefined ("pay_pcheck")#>
    <cfset #session.pay_pcheck# = 1>
   <cfelse>
    <cfset #session.pay_pcheck# = 0>
   </cfif>
   <cfif #isDefined ("pay_ol_escrow")#>
    <cfset #session.pay_ol_escrow# = 1>
   <cfelse>
    <cfset #session.pay_ol_escrow# = 0>
   </cfif>
   <cfif #isDefined ("pay_other")#>
    <cfset #session.pay_other# = 1>
   <cfelse>
    <cfset #session.pay_other# = 0>
   </cfif>
   <cfif #isDefined ("pay_visa_mc")#>
    <cfset #session.pay_visa_mc# = 1>
   <cfelse>
    <cfset #session.pay_visa_mc# = 0>
   </cfif>
   <cfif #isDefined ("pay_am_express")#>
    <cfset #session.pay_am_express# = 1>
   <cfelse>
    <cfset #session.pay_am_express# = 0>
   </cfif>
   <cfif #isDefined ("pay_discover")#>
    <cfset #session.pay_discover# = 1>
   <cfelse>
    <cfset #session.pay_discover# = 0>
   </cfif>
   <cfif #isDefined ("ship_sell_pays")#>
    <cfset #session.ship_sell_pays# = 1>
   <cfelse>
    <cfset #session.ship_sell_pays# = 0>
   </cfif>
   <cfif #isDefined ("ship_buy_pays_act")#>
    <cfset #session.ship_buy_pays_act# = 1>
   <cfelse>
    <cfset #session.ship_buy_pays_act# = 0>
   </cfif>
   <cfif #isDefined ("ship_see_desc")#>
    <cfset #session.ship_see_desc# = 1>
   <cfelse>
    <cfset #session.ship_see_desc# = 0>
   </cfif>
   <cfif #isDefined ("ship_buy_pays_fxd")#>
    <cfset #session.ship_buy_pays_fxd# = 1>
   <cfelse>
    <cfset #session.ship_buy_pays_fxd# = 0>
   </cfif>
   <cfif #isDefined ("ship_international")#>
    <cfset #session.ship_international# = 1>
   <cfelse>
    <cfset #session.ship_international# = 0>
   </cfif>  
 
   <cfset #session.description# = #description#>
   <cfset #session.desc_languages# = #desc_languages#>
   <cfset #session.picture# = #picture#>
   <cfset #session.sound# = #sound#>
   <cfset #session.quantity# = #quantity#>
   <cfset #session.minimum_bid# = #minimum_bid#>
   <cfset #session.increment# = #increment#>
   <cfset #session.increment_valu# = #increment_valu#>
   <cfset #session.dynamic# = #dynamic#>
   <cfset #session.dynamic_valu# = #dynamic_valu#>
   <cfset #session.reserve_bid# = #reserve_bid#>
   <cfset #session.bold_title# = #bold_title#>
   <cfset #session.featured# = #featured#>
   <cfset #session.featured_cat# = #featured_cat#>
   <cfset #session.private# = #private#>
   <cfset #session.banner# = #banner#>
   <cfset #session.banner_line# = #banner_line#>
   <cfset #session.studio# = #studio#>
   <cfset #session.featured_studio# = #featured_studio#>
   <cfset #session.picture_studio# = #picture_studio#>
   <cfset #session.sound_studio# = #sound_studio#>
   <cfset #session.date_start# = #date_start#>
   <cfset #session.date_end# = #date_end#>
   <cfset #session.billmeth# = "BM">
   <cfset #session.remote_ip# = #cgi.remote_addr#>

   <cflocation url="item_preview.cfm?itemnum=#itemnum#">
   </cfif>

</cfoutput>
<cfsetting enablecfoutputonly="no">
