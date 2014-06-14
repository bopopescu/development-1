<html>
 <head>
  <title>Auction Server 3.0 Administrator [Auctions Module: Edit/Add Item]</title>
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfif #isDefined ("submit")#>
  <cfif #submit# is "Done">
   <cflocation url="./auctions.cfm">
  </cfif>
 <cfelse>
  <cfset #submit# = "">
 </cfif>
 
 <cfsetting EnableCFOutputOnly="YES">

 <!--- Load this module for creating unique IDs --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">

 <!--- Define a dummy user for now --->
 <cfset #user_id# = "0">

 <cfif #isDefined ("selected_category")# is 0>
  <cfset #selected_category# = "0">
 </cfif>
 
 <!--- If they're not selecting an item, set a default one --->
 <cfif #isDefined ("selected_item")# is "0">
  <cfset #selected_item# = "#EPOCH#">
 </cfif>

 <cfif #isDefined ("the_item")# is 0>
  <cfset #the_item# = "#selected_item#">
 </cfif>
 
 <cfif #isDefined ("desc_languages")# is "0">
  <cfset #desc_languages# = "">
 </cfif>

 <!--- Set a default value for "submit2" if nonexistent --->
 <cfif #isDefined ("submit2")# is 0>
  <cfset #submit2# = "enter">
 <cfelse>
  <cfset #submit2# = #trim (submit2)#>
 </cfif>


 <!--- Set defaults depending on whether we're editing or adding --->
<!--- <cfif #submit# is "Edit">
  <cfset #itemnum#="#itemnum#">
 <cfelseif #submit# is "Add">
  <cfset #itemnum#="#EPOCH#">
 </cfif> --->

 <!--- Get a list of active users --->
 <cfquery name="get_users" datasource="#DATASOURCE#">
  SELECT user_id, name, nickname
    FROM users
   WHERE is_active = 1
   ORDER BY nickname
 </cfquery>

 <!--- Get the last user they chose as the seller --->
 <cfquery name="get_seller" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'last_seller'
 </cfquery>

 <!--- Check to see if they're cancelling. --->
 <cfif #submit2# is "Cancel">
  <cfoutput><cflocation url="./auctions.cfm?selected_category=#selected_category#&submit=expand&selected_item=#selected_item#"></cfoutput>
 </cfif>

  <!--- Check to see if we need to delete an item. --->
  <cfif #submit2# is "Delete" or #submit# is "Delete">
    
    <cfquery name="delete_item" datasource="#DATASOURCE#">
        DELETE
          FROM items
         WHERE itemnum = #selected_item#
    </cfquery>
    
    <!--- log deletion of item --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Auction Deleted by Administrator"
      itemnum="#selected_item#">
      
    <cfoutput><cflocation url="./auctions.cfm?selected_category=#selected_category#&submit=expand"></cfoutput>
  </cfif>

 <!--- If defined, merge the seperate date and time objects into 1 object --->
 <cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
 </cfif>

 <cfif #isDefined ("dynamic_valu")#>
  <cfif #dynamic_valu# is "">
   <cfset #dynamic_valu# = "0">
  </cfif>
 </cfif>
 <cfif #isDefined ("increment_valu")#>
  <cfif #increment_valu# is "">
   <cfset #increment_valu# = "0">
  </cfif>
 </cfif>
 <cfif #isDefined ("minimum_bid")#>
  <cfif #minimum_bid# is "">
   <cfset #minimum_bid# = "0">
  </cfif>
 </cfif>
 <cfif #isDefined ("reserve_bid")#>
  <cfif #reserve_bid# is "">
   <cfset #reserve_bid# = "0">
  </cfif>
 </cfif>

 <cfif #isDefined ("status")#>
  <cfset #status# = "1">
 <cfelse>
  <cfset #status# = "0">
 </cfif>
 <cfif #isDefined ("bold_title")#>
  <cfset #bold_title# = "1">
 <cfelse>
  <cfset #bold_title# = "0">
 </cfif>
 <cfif #isDefined ("pay_morder_ccheck")#>
  <cfset #pay_morder_ccheck# = "1">
 <cfelse>
  <cfset #pay_morder_ccheck# = "0">
 </cfif>
 <cfif #isDefined ("pay_cod")#>
  <cfset #pay_cod# = "1">
 <cfelse>
  <cfset #pay_cod# = "0">
 </cfif>
 <cfif #isDefined ("pay_see_desc")#>
  <cfset #pay_see_desc# = "1">
 <cfelse>
  <cfset #pay_see_desc# = "0">
 </cfif>
 <cfif #isDefined ("pay_pcheck")#>
  <cfset #pay_pcheck# = "1">
 <cfelse>
  <cfset #pay_pcheck# = "0">
 </cfif>
 <cfif #isDefined ("pay_ol_escrow")#>
  <cfset #pay_ol_escrow# = "1">
 <cfelse>
  <cfset #pay_ol_escrow# = "0">
 </cfif>
 <cfif #isDefined ("pay_other")#>
  <cfset #pay_other# = "1">
 <cfelse>
  <cfset #pay_other# = "0">
 </cfif>
 <cfif #isDefined ("pay_visa_mc")#>
  <cfset #pay_visa_mc# = "1">
 <cfelse>
  <cfset #pay_visa_mc# = "0">
 </cfif>
 <cfif #isDefined ("pay_am_express")#>
  <cfset #pay_am_express# = "1">
 <cfelse>
  <cfset #pay_am_express# = "0">
 </cfif>
 <cfif #isDefined ("pay_discover")#>
  <cfset #pay_discover# = "1">
 <cfelse>
  <cfset #pay_discover# = "0">
 </cfif>
 <cfif #isDefined ("ship_sell_pays")#>
  <cfset #ship_sell_pays# = "1">
 <cfelse>
  <cfset #ship_sell_pays# = "0">
 </cfif>
 <cfif #isDefined ("ship_buy_pays_act")#>
  <cfset #ship_buy_pays_act# = "1">
 <cfelse>
  <cfset #ship_buy_pays_act# = "0">
 </cfif>
 <cfif #isDefined ("ship_see_desc")#>
  <cfset #ship_see_desc# = "1">
 <cfelse>
  <cfset #ship_see_desc# = "0">
 </cfif>
 <cfif #isDefined ("ship_buy_pays_fxd")#>
  <cfset #ship_buy_pays_fxd# = "1">
 <cfelse>
  <cfset #ship_buy_pays_fxd# = "0">
 </cfif>
 <cfif #isDefined ("ship_international")#>
  <cfset #ship_international# = "1">
 <cfelse>
  <cfset #ship_international# = "0">
 </cfif>
 <cfif #isDefined ("increment")#>
  <cfset #increment# = "1">
 <cfelse>
  <cfset #increment# = "0">
 </cfif>
 <cfif #isDefined ("dynamic")#>
  <cfset #dynamic# = "1">
 <cfelse>
  <cfset #dynamic# = "0">
 </cfif>
 <cfif #isDefined ("featured")#>
  <cfset #featured# = "1">
 <cfelse>
  <cfset #featured# = "0">
 </cfif>
 <cfif #isDefined ("featured_cat")#>
  <cfset #featured_cat# = "1">
 <cfelse>
  <cfset #featured_cat# = "0">
 </cfif>
 <cfif #isDefined ("private")#>
  <cfset #private# = "1">
 <cfelse>
  <cfset #private# = "0">
 </cfif>
 <cfif #isDefined ("banner")#>
  <cfset #banner# = "1">
 <cfelse>
  <cfset #banner# = "0">
 </cfif>
 <!---<cfif #isDefined ("studio")#>
  <cfset #studio# = "1">
 <cfelse>
  <cfset #studio# = "0">
 </cfif>
 <cfif #isDefined ("featured_studio")#>
  <cfset #featured_studio# = "1">
 <cfelse>
  <cfset #featured_studio# = "0">
 </cfif>--->
 <cfif #isDefined ("selected_user")# is 0>
  <cfset #selected_user# = "0">
 </cfif>
 <cfif #isDefined ("selected_auction_type")# is 0>
  <cfset #selected_auction_type# = "E">
 </cfif>

 <!--- Set defaults for all the form variables --->
 <cfif ((#submit# is "Edit") or (#submit# is "Add")) and (#submit2# is "enter")>
  <cfif #submit# is "Add">
   <cfset #selected_item# = "#EPOCH#">
   <cfset #selected_user# = "#get_seller.pair#">
  </cfif>
  <cfset #status# = "">
  <cfset #user_id# = "">
  <cfset #category1# = "#selected_category#">
  <cfset #category2# = "">
  <cfset #title# = "">
  <cfset #location# = "">
  <cfset #country# = "USA">
  <cfset #description# = "">
  <cfset #desc_languages# = "">
  <cfset #picture# = "http://">
  <cfset #sound# = "http://">
  <!---<cfset #picture_studio# = "http://">
  <cfset #sound_studio# = "http://">--->
  <cfset #quantity# = "1">
  <cfset #minimum_bid# = "">
  <cfset #increment_valu# = "0">
  <cfset #dynamic_valu# = "0">
  <cfset #reserve_bid# = "0">
  <cfset #banner_line# = "">
  <cfset #date_start# = "#now ()#">
  <cfset #date_end# = "#now ()#">
  <cfset #seller_email# = "">
 </cfif>

  <!--- Check to see if we're editing an auction item --->
  <cfif (#submit# is "Edit") and (#submit2# is "enter")>
    
    <cfquery name="get_item" dataSource="#DATASOURCE#">
        SELECT itemnum,
               status,
               user_id,
               category1,
               category2,
               title,
               location,
               country,
               pay_morder_ccheck,
               pay_cod,
               pay_see_desc,
               pay_pcheck,
               pay_ol_escrow,
               pay_other,
               pay_visa_mc,
               pay_am_express,
               pay_discover,
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
               <!--- studio,
               featured_studio,
               picture_studio,
               sound_studio,--->
               date_start,
               date_end,
               auction_type
          FROM items
         WHERE itemnum = #selected_item#
    </cfquery>
    
    <cfset #selected_category# = #get_item.category1#>
    
    <!--- Get the seller's email address --->
    <cfquery name="get_seller_email" datasource="#DATASOURCE#">
        SELECT email
          FROM users
         WHERE user_id = #get_item.user_id#
    </cfquery>
    
    <cfset #seller_email# = "#get_seller_email.email#">
    
    
    <!---  <cfset #itemnum# = "#get_item.itemnum#"> --->
    <cfset #the_item# = "#get_item.itemnum#">
    <cfset #status# = "#get_item.status#">
    <cfset #user_id# = "#get_item.user_id#">
    <cfset #category1# = "#get_item.category1#">
    <cfset #category2# = "#get_item.category2#">
    <cfset #title# = "#get_item.title#">
    <cfset #location# = "#get_item.location#">
    <cfset #country# = "#get_item.country#">
    <cfset #pay_morder_ccheck# = "#get_item.pay_morder_ccheck#">
    <cfset #pay_cod# = "#get_item.pay_cod#">
    <cfset #pay_see_desc# = "#get_item.pay_see_desc#">
    <cfset #pay_pcheck# = "#get_item.pay_pcheck#">
    <cfset #pay_ol_escrow# = "#get_item.pay_ol_escrow#">
    <cfset #pay_other# = "#get_item.pay_other#">
    <cfset #pay_visa_mc# = "#get_item.pay_visa_mc#">
    <cfset #pay_am_express# = "#get_item.pay_am_express#">
    <cfset #pay_discover# = "#get_item.pay_discover#">
    <cfset #ship_sell_pays# = "#get_item.ship_sell_pays#">
    <cfset #ship_buy_pays_act# = "#get_item.ship_buy_pays_act#">
    <cfset #ship_see_desc# = "#get_item.ship_see_desc#">
    <cfset #ship_buy_pays_fxd# = "#get_item.ship_buy_pays_fxd#">
    <cfset #ship_international# = "#get_item.ship_international#">
    <cfset #description# = "#get_item.description#">
    <cfset #desc_languages# = "#get_item.desc_languages#">
    <cfset #picture# = #trim ("#get_item.picture#")#>
    <cfset #sound# = #trim ("#get_item.sound#")#>
    <cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
      <cfset #picture# = "http://#picture#">
    </cfif>
    <cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
      <cfset #sound# = "http://#sound#">
    </cfif>
    <cfset #quantity# = "#get_item.quantity#">
    <cfset #minimum_bid# = "#get_item.minimum_bid#">
    <cfset #increment# = "#get_item.increment#">
    <cfset #increment_valu# = "#get_item.increment_valu#">
    <cfset #dynamic# = "#get_item.dynamic#">
    <cfset #dynamic_valu# = "#get_item.dynamic_valu#">
    <cfset #reserve_bid# = "#get_item.reserve_bid#">
    <cfset #bold_title# = "#get_item.bold_title#">
    <cfset #featured# = "#get_item.featured#">
    <cfset #featured_cat# = "#get_item.featured_cat#">
    <cfset #private# = "#get_item.private#">
    <cfset #banner# = "#get_item.banner#">
    <cfset #banner_line# = "#get_item.banner_line#">
    <!---<cfset #studio# = "#get_item.studio#">
    <cfset #featured_studio# = "#get_item.featured_studio#">
    <cfset #picture_studio# = #trim ("#get_item.picture_studio#")#>
    <cfset #sound_studio# = #trim ("#get_item.sound_studio#")#>
    <cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
      <cfset #picture_studio# = "http://#picture_studio#">
    </cfif>
    <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
      <cfset #sound_studio# = "http://#sound_studio#">
    </cfif>--->
    <cfset #date_start# = "#get_item.date_start#">
    <cfset #date_end# = "#get_item.date_end#">
    <cfset #selected_user# = "#get_item.user_id#">
    <cfset #selected_auction_type# = "#get_item.auction_type#">
  </cfif>
  
 <!--- Run a query to find all active categories --->
 <cfquery name="get_cats" dataSource="#DATASOURCE#">
  SELECT name, category
    FROM categories
   WHERE active = 1
     AND parent > -1
   ORDER by name
 </cfquery>

 <!--- Run a query to find all durations --->
 <cfquery name="get_durations" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'duration'
   ORDER BY pair
 </cfquery>

 <!--- Run a query to find the default duration --->
 <cfquery name="get_def_duration" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'def_duration'
   ORDER BY pair
 </cfquery>
 
 <!--- Reset the error message string --->
 <cfset #error_message# = "">

 <!--- Check the form for valid data --->
 <cfif #submit2# is "Save">
  <cfif #trim (title)# is "">
   <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
  <cfelseif (#trim (quantity)# is "") or (#isNumeric (quantity)# is 0)>
   <cfset #error_message# = "<font color=ff0000>Please enter a valid quantity for this item.</font>"> 
  <cfelseif #trim (description)# is "">
   <cfset #error_message# = "<font color=ff0000>Please enter a description of this item.</font>"> 
  <cfelseif #isDefined ("desc_languages")# is "0">
   <cfset #error_message# = "<font color=ff0000>Please specify the language(s) the description is in.</font>"> 
   <cfset #desc_languages# = "">
  <cfelseif #trim (location)# is "">
   <cfset #error_message# = "<font color=ff0000>Please enter a location where this item will be shipped from.</font>"> 
  <cfelseif #trim (country)# is "">
   <cfset #error_message# = "<font color=ff0000>Please specify a country where this item will be shipped from.</font>"> 
  <cfelseif (#category1# is "-1") and (#category2# is "-1")>
   <cfset #error_message# = "<font color=ff0000>Please specify at least 1 auction category for this item.</font>"> 
  <cfelseif (#trim (minimum_bid)# is "") or (#minimum_bid# is "0") or (#isNumeric (minimum_bid)# is "0")>
   <cfset #error_message# = "<font color=ff0000>Please specify a minimum bid value for this item.</font>"> 
  </cfif>
 </cfif>

  <!--- Check to see if we're saving an auction item --->
  <cfif #submit2# is "Save">
    <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
  </cfif>
  
  <cfif (#submit2# is "Save") and (#error_message# is "")>
    
    <cfif #submit# is "Edit">
      
      <!--- Make sure images and sounds begin with http:// --->
      <cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
        <cfset #picture# = "http://#picture#">
      </cfif>
      <cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
        <cfset #sound# = "http://#sound#">
      </cfif>
      <!---<cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
        <cfset #picture_studio# = "http://#picture_studio#">
      </cfif>
      <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
        <cfset #sound_studio# = "http://#sound_studio#">
      </cfif>--->
      
      <cfquery name="update_item" datasource="#DATASOURCE#"> 
          UPDATE items
              SET status = #status#,
                  user_id = #selected_user#,
                  category1 = #category1#,
                  category2 = #category2#,
                  title = '#title#',
                  location = '#location#',
                  country = '#country#',
                 pay_morder_ccheck = #pay_morder_ccheck#,
                 pay_cod = #pay_cod#,
                 pay_see_desc = #pay_see_desc#,
                 pay_pcheck = #pay_pcheck#,
                 pay_ol_escrow = #pay_ol_escrow#,
                 pay_other = #pay_other#,
                 pay_visa_mc = #pay_visa_mc#,
                 pay_am_express = #pay_am_express#,
                 pay_discover = #pay_discover#,
                 ship_sell_pays = #ship_sell_pays#,
                 ship_buy_pays_act = #ship_buy_pays_act#,
                 ship_see_desc = #ship_see_desc#,
                 ship_buy_pays_fxd = #ship_buy_pays_fxd#,
                 ship_international = #ship_international#,
                 description = '#description#',
                 desc_languages = '#desc_languages#',
                 picture = '#picture#',
                 sound = '#sound#',
                  quantity = #quantity#,
                  minimum_bid = #minimum_bid#,
                  increment = #increment#,
                  increment_valu = #increment_valu#,
                  dynamic = #dynamic#,
                  dynamic_valu = #dynamic_valu#,
                  reserve_bid = #reserve_bid#,
                  bold_title = #bold_title#,
                  featured = #featured#,
                  featured_cat = #featured_cat#,
                  private = #private#,
                  banner = #banner#,
                  banner_line = '#banner_line#',
                 <!--- 
                 studio = #studio#,
                 featured_studio = #featured_studio#,
                 picture_studio = '#picture_studio#',
                 sound_studio = '#sound_studio#',
                 --->
                  date_start = #createODBCDateTime (date_start)#,
                  date_end = #createODBCDateTime (date_end)#
           WHERE itemnum = #selected_item#
      </cfquery>
      
      <!--- log update of auction --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Auction Information Updated by Administrator"
        itemnum="#selected_item#"
        details="TITLE: #title#     STATUS: #status#     DATE START: #createODBCDateTime (date_start)#     DATE END: #createODBCDateTime (date_end)#     QUANTITY: #quantity#     MINIMUM BID: #minimum_bid#     RESERVE BID: #reserve_bid#     USE BID INCREMENT: #increment#     INCREMENT VALUE: #increment_valu#     USE DYNAMIC CLOSE: #dynamic#     DYNAMIC VALUE: #dynamic_valu#     CATEGORY 1: #category1#     CATEGORY 2: #category2#     PRIVATE: #private#     USE BANNER: #banner#     BANNER LINE: #banner_line#     BOLD TITLE: #bold_title#     FEATURED: #featured#     FEATURED IN CATEGORY: #featured_cat#     LOCATION: #location#     COUNTRY: #country#"
        user_id="#selected_user#">
        
    <cfelse>
      
      <cfquery name="insert_item" datasource="#DATASOURCE#">
        <cfoutput>
          INSERT INTO items
            (status,
             user_id,
             category1,
             category2,
             title,
             location,
             country,
             pay_morder_ccheck,
             pay_cod,
             pay_see_desc,
             pay_pcheck,
             pay_ol_escrow,
             pay_other,
             pay_visa_mc,
             pay_am_express,
             pay_discover,
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
             <!---  studio,
             featured_studio,
             picture_studio,
             sound_studio,--->
             date_start,
             date_end,
             itemnum,
             billmeth,
             remote_ip,
             auction_type)
     VALUES (#status#,
             #selected_user#,
             #category1#,
             #category2#,
             '#title#',
             '#location#',
             '#country#',
             #pay_morder_ccheck#,
             #pay_cod#,
             #pay_see_desc#,
             #pay_pcheck#,
             #pay_ol_escrow#,
             #pay_other#,
             #pay_visa_mc#,
             #pay_am_express#,
             #pay_discover#,
             #ship_sell_pays#,
             #ship_buy_pays_act#,
             #ship_see_desc#,
             #ship_buy_pays_fxd#,
             #ship_international#,
             '#description#',
             '#desc_languages#',
             '#picture#',
             '#sound#',
             #quantity#,
             #minimum_bid#,
             #increment#,
             #increment_valu#,
             #dynamic#,
             #dynamic_valu#,
             #reserve_bid#,
             #bold_title#,
             #featured#,
             #featured_cat#,
             #private#,
             #banner#,
             '#banner_line#',
             <!---#studio#,
             #featured_studio#,
             '#picture_studio#',
             '#sound_studio#',--->
             #createODBCDateTime (date_start)#,
             #createODBCDateTime (date_end)#,
             #selected_item#,
             'BM',
             '',
             '#selected_auction_type#')
        </cfoutput>
      </cfquery>
      
      <!--- log creation of auction --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Auction Started by Administrator"
        itemnum="#selected_item#"
        details="TITLE: #title#     STATUS: #status#     DATE START: #createODBCDateTime (date_start)#     DATE END: #createODBCDateTime (date_end)#     QUANTITY: #quantity#     MINIMUM BID: #minimum_bid#     RESERVE BID: #reserve_bid#     USE BID INCREMENT: #increment#     INCREMENT VALUE: #increment_valu#     USE DYNAMIC CLOSE: #dynamic#     DYNAMIC VALUE: #dynamic_valu#     CATEGORY 1: #category1#     CATEGORY 2: #category2#     PRIVATE: #private#     USE BANNER: #banner#     BANNER LINE: #banner_line#     BOLD TITLE: #bold_title#     FEATURED: #featured#     FEATURED IN CATEGORY: #featured_cat#     LOCATION: #location#     COUNTRY: #country#"
        user_id="#selected_user#">
        
      <!--- Keep track of who they used as the seller --->
      <cfquery name="update_last_seller" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#selected_user#'
           WHERE name = 'last_seller'
      </cfquery>
      
    </cfif>
    
    <cfoutput><cflocation url="./auctions.cfm?selected_category=#selected_category#&submit=expand&selected_item=#selected_item#"></cfoutput>
  </cfif>

 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 <body bgcolor=465775>
  <!--- Some JavaScript for the "Preview" buttons --->
  <script language="JavaScript">

   // Opens a new browser window with no titlebar and the given size, and
   // loads the given URL into it.
   function openWindow (URL, width, height) {
      window.open (URL, "previewWindow", "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
   }
  </script>
  <font face="helvetica" size=2>
   <center>

    <!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900>
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>
<!---
<td></td>
<td></td>
--->
<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->


     <!--- Include the menubar --->
     <cfset #page# = "auctions">
     <cfinclude template="menu_include.cfm">

     <tr>
      <td colspan=5 bgcolor=a9ccd7>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=709>	    
       <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
            <td colspan=2>
             <font face="helvetica" size=2 color=000000>
              Please fill out or modify the following form for this auction item. Click "Save" to save your<br>
              changes in the database, or click "Cancel" to ignore changes and return to the previous page.
  <hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade>
             </font>
            </td>
           </tr>
           <tr>
            <td valign="top">
             <form name="itemform" action="auction_item.cfm" method="post">          
              &nbsp;<font face="Helvetica" size=2 color=000080><b>AUCTION ITEM INFORMATION:</b><br></font>
              &nbsp;<font color="000000">(Fields in <font color="0000ff">blue</font> are required)</font>
              <cfif #error_message# is not "">
               <cfoutput><font face="Helvetica" size=2 color=ff0000><br><br><b>ERROR:</b> #error_message#</font></cfoutput>
              </cfif>
              <cfoutput>
               <cfif #isDefined ("submit")#>
                <input type="hidden" name="submit" value="#submit#">
               </cfif>
               <input type="hidden" name="user_id" value="#user_id#">
               <input type="hidden" name="selected_category" value="#selected_category#">
               <cfif #submit# is "Edit">
                <input type="hidden" name="selected_item" value="#selected_item#">
               <cfelseif #submit# is "Add">
                <input type="hidden" name="selected_item" value="#EPOCH#">
               </cfif>
              <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
               <tr>
                <td>
                 <table border=0 cellspacing=0 cellpadding=2>
                  <tr>
                   <td><font face="helvetica" size=2 color="000000"><b>Item ID ##:</b></font></td>
                   <td>&nbsp;</td>
                   <td>#the_item#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Seller:</b></font></td>
                   <td>&nbsp;</td>
                   <td><select name="selected_user"><cfloop query="get_users"><option value="#user_id#"<cfif #selected_user# is #user_id#> selected</cfif>>#nickname# (#name#)</option></cfloop></select><cfif #seller_email# is not "">&nbsp;&nbsp;&nbsp;<font face="helvetica" size=2>(<a href="mailto:#seller_email#">#seller_email#</a>)</font></cfif></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Title:</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="text" size=35 maxlength=45 value="#title#"></td><td><input name="bold_title" type="checkbox" value="1"<cfif #bold_title# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Bold title</font></td></tr></table></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Banner:</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="banner_line" type="text" size=35 maxlength=45 value="#banner_line#"></td><td><input name="banner" type="checkbox" value="1"<cfif #banner# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Banner is active</font></td></tr></table></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Quantity:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><input name="quantity" type="text" size=5 maxlength=6 value="#quantity#"></td>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Item<br>Description:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><textarea name="description" rows=5 cols=50>#description#</textarea></td>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Description<br>Languages:</b></font></td>
                   <td>&nbsp;</td>
<!---                   <td colspan=2><input name="desc_languages" type="text" size=52 maxlength=250 value="#desc_languages#"></td> --->
                   <td colspan=2>
                    <cfmodule template="..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="desc_languages" selected="#desc_languages#" size=5 multiple="yes">
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Location:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><input name="location" type="text" size=35 maxlength=100 value="#location#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Country:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                 	<CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                	 SELECTNAME="country"
                     SELECTED="#country#"
                     MULTIPLE="0"
                     SIZE="1">
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr> 
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Start Date/Time:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfif #submit# is "Edit">
                       <cfset #the_month# = #datePart ("m", "#date_start#")#>
                       <cfset #the_day# = #datePart ("d", "#date_start#")#>
                       <cfset #the_year# = #datePart ("yyyy", "#date_start#")#>
                       <cfset #the_time# = #timeFormat ("#date_start#", 'hh:mm')#>
                       <cfset #the_time_s# = #timeFormat ("#date_start#", 'tt')#>
                      <cfelse>
                       <cfset #the_month# = #datePart ("m", "#now ()#")#>
                       <cfset #the_day# = #datePart ("d", "#now ()#")#>
                       <cfset #the_year# = #datePart ("yyyy", "#now ()#")#>
                       <cfset #the_time# = #timeFormat ("#now ()#", 'hh:mm')#>
                       <cfset #the_time_s# = #timeFormat ("#now ()#", 'tt')#>
                      </cfif>
                      <td>
                       <select name="start_month">
                        <option value="1"<cfif #the_month# is "1"> selected</cfif>>Jan</option>
                        <option value="2"<cfif #the_month# is "2"> selected</cfif>>Feb</option>
                        <option value="3"<cfif #the_month# is "3"> selected</cfif>>Mar</option>
                        <option value="4"<cfif #the_month# is "4"> selected</cfif>>Apr</option>
                        <option value="5"<cfif #the_month# is "5"> selected</cfif>>May</option>
                        <option value="6"<cfif #the_month# is "6"> selected</cfif>>Jun</option>
                        <option value="7"<cfif #the_month# is "7"> selected</cfif>>Jul</option>
                        <option value="8"<cfif #the_month# is "8"> selected</cfif>>Aug</option>
                        <option value="9"<cfif #the_month# is "9"> selected</cfif>>Sep</option>
                        <option value="10"<cfif #the_month# is "10"> selected</cfif>>Oct</option>
                        <option value="11"<cfif #the_month# is "11"> selected</cfif>>Nov</option>
                        <option value="12"<cfif #the_month# is "12"> selected</cfif>>Dec</option>
                       </select></td>
                      <td><input name="start_day" type="text" size=2 maxlength=2 value="#the_day#">,</td>
                      <td><input name="start_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
                      <td><font face="helvetica" size=2>&nbsp;at&nbsp;</font></td>
                      <td><input name="start_time" type="text" size=5 maxlength=5 value="#the_time#"></td>
                      <td>
                       <select name="start_time_s">
                        <option value="AM"<cfif #the_time_s# is "AM"> selected</cfif>>AM</option>
                        <option value="PM"<cfif #the_time_s# is "PM"> selected</cfif>>PM</option>
                       </select>
                      </td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Auction Duration:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0>
                     <tr>
                      <cfset #the_duration# = #dateDiff ("d", date_start, date_end)#>
                      <td><select name="duration">                 
                       <cfloop query="get_durations">
                        <option value="#int (pair)#"<cfif (#int (pair)# is #the_duration#) or (#int (pair)# is #int (get_def_duration.pair)#)> selected</cfif>>#int (pair)#</option>
                       </cfloop>
                       </select></td>
                      <td><font face="helvetica" size=2>&nbsp;day(s)</font></td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                 <cfif #submit# is "Add">
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Auction Type:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <select name="selected_auction_type">
                     <option value="E"<cfif #selected_auction_type# is "E"> selected</cfif>>English (Normal)</option>
                     <option value="D"<cfif #selected_auction_type# is "D"> selected</cfif>>Dutch</option>
                     <option value="Y"<cfif #selected_auction_type# is "Y"> selected</cfif>>Yankee</option>
                     <option value="V"<cfif #selected_auction_type# is "V"> selected</cfif>>Vickrey</option>
                    </select>
                   </td>
                  </tr>
                 <cfelse>
                  <tr>
                   <td><font face="helvetica" size=2 color="000000"><b>Auction Type:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <font face="helvetica" size=2>
                     <cfif #selected_auction_type# is "E">English</cfif>
                     <cfif #selected_auction_type# is "D">Dutch</cfif>
                     <cfif #selected_auction_type# is "Y">Yankee</cfif>
                     <cfif #selected_auction_type# is "V">Vickrey</cfif>
                    </font>
                   </td>
                  </tr>
                 </cfif>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Categories<br>Auctioned In:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2 valign="top">
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#category1#">
                    <br>
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category2"
                              show_none="yes"
                              selected="#category2#">
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Picture URL:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                    <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#"></td><td>&nbsp;</td><td><input type="button" name="previewImage" value="Preview" onClick="if (picture.value != 'http://') openWindow ('preview_image.cfm?image=#URLEncodedFormat (picture)#&title=#URLEncodedFormat (title)#', 450, 300);"></td></tr></table>
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Sound URL:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                    <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="sound" type="text" size=43 maxlength=250 value="#sound#"></td><td>&nbsp;</td><td>&nbsp;<!--- <input type="button" name="previewSound" value="Preview"> ---></td></tr></table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr> 
                  <tr>
                   <td><!---<font face="helvetica" size=2><b>Studio Thumbnail:</b></font>---></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                   <!--- <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="picture_studio" type="text" size=43 maxlength=250 value="#picture_studio#"></td><td>&nbsp;</td><td><input type="button" name="previewStudioImage" value="Preview" onClick="if (picture_studio.value != 'http://') openWindow ('preview_image.cfm?image=#URLEncodedFormat (picture_studio)#&title=#URLEncodedFormat (title)#', 450, 300);"></td></tr></table>--->
                   </td>
                  </tr>
                  <tr>
                   <td><!---<font face="helvetica" size=2><b>Studio Soundclip:</b></font>---></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
<!---                    <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="sound_studio" type="text" size=43 maxlength=250 value="#sound_studio#"></td><td>&nbsp;</td><td>&nbsp;---> <!--- <input type="button" name="previewStudioSound" value="Preview"> </td></tr></table>--->
                   </td>
                  </tr>
                  <tr>
                   <td colspan=2>&nbsp;</td>
                   <td><!---<input type="checkbox" name="featured_studio" value="1"<cfif #featured_studio# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Include this item in the studio</font>---></td> 
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr> 
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Accepted<br>Payment<br>Methods:</b></font></td>
                   <td>&nbsp;</td>
                   <td valign="top" colspan=2>
                    <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Cashier's Check/Money Order</font></td>
                      <td width=25>&nbsp;</td>
                      <td><input name="pay_am_express" type="checkbox" value="1"<cfif #pay_am_express# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;American Express card</font></td>
                     </tr>
                     <tr>
                      <td><input name="pay_cod" type="checkbox" value="1"<cfif #pay_cod# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Collect-on-delivery (COD)</font></td>
                      <td>&nbsp;</td>
                      <td><input name="pay_discover" type="checkbox" value="1"<cfif #pay_discover# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Discover card</font></td>
                     </tr>
                     <tr>
                      <td><input name="pay_pcheck" type="checkbox" value="1"<cfif #pay_pcheck# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Personal check</font></td>
                      <td>&nbsp;</td>
                      <td><input name="pay_ol_escrow" type="checkbox" value="1"<cfif #pay_ol_escrow# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Online eNetSettle</font></td>
                     </tr>
                     <tr>
                      <td><input name="pay_visa_mc" type="checkbox" value="1"<cfif #pay_visa_mc# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;VISA/MasterCard</font></td>
                      <td>&nbsp;</td>
                      <td><input name="pay_other" type="checkbox" value="1"<cfif #pay_other# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Other/Not listed here</font></td>
                     </tr>
                     <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;See item description for payment information</font></td></tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr> 
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Shipping<br>Info:</b></font></td>
                   <td>&nbsp;</td>
                   <td valign="top" colspan=2>
                    <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <td><input name="ship_sell_pays" type="checkbox" value="1"<cfif #ship_sell_pays# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Seller pays shipping costs</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_buy_pays_act" type="checkbox" value="1"<cfif #ship_buy_pays_act# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Buyer pays actual shipping costs</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_buy_pays_fxd" type="checkbox" value="1"<cfif #ship_buy_pays_fxd# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Buyer pays fixed shipping costs</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_international" type="checkbox" value="1"<cfif #ship_international# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Allow international shipping</font></td>
                     </tr>
                     <tr>
                      <td><input name="ship_see_desc" type="checkbox" value="1"<cfif #ship_see_desc# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;See item description for shipping information</font></td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Minimum Bid:</b></font></td>
                   <td><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input name="minimum_bid" type="text" size=7 maxlength=9 value="#minimum_bid#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Reserve Bid:</b></font></td>
                   <td><font face="helvetica" size=2><b>$</b></font></td>
                   <td><input name="reserve_bid" type="text" size=7 maxlength=9 value="#reserve_bid#"></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Bid Increment:</b></font></td>
                   <td><font face="helvetica" size=2><b>$</b></font></td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="increment_valu" type="text" size=7 maxlength=9 value="#increment_valu#"></td><td>&nbsp;</td><td><input type="checkbox" name="increment" value="1"<cfif #increment# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enabled &nbsp;&nbsp;&nbsp;&nbsp;<b>(For single-quantity items only)</b></font></td></tr></table></td> 
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Dynamic Bid<br>Time (minutes):</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="dynamic_valu" type="text" size=7 maxlength=9 value="#dynamic_valu#"></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"<cfif #dynamic# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enabled</font></td></tr></table></td> 
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr> 
                  <tr>
                   <td><font face="helvetica" size=2><b>Other Settings:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input type="checkbox" name="featured" value="1"<cfif #featured# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Feature this item in the main "featured" list</font></td> 
                  </tr>
                  <tr>
                   <td colspan=2>&nbsp;</td>
                   <td><input type="checkbox" name="featured_cat" value="1"<cfif #featured_cat# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Feature this item in its category(s)</font></td> 
                  </tr>
                  <tr>
                   <td colspan=2>&nbsp;</td>
                   <td><input type="checkbox" name="private" value="1"<cfif #private# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Auction is private (hide E-Mail addresses)</font></td> 
                  </tr>
                  <tr>
                   <td colspan=2>&nbsp;</td>
                   <td align="left"><input name="status" type="checkbox" value="1"<cfif #status# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Item is active</font></td>
                  </tr>
                  <tr>
                   <td colspan=4><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
                  </tr> 
                  <tr>
                   <td colspan=4><input type="submit" name="submit2" value="Save" width=75>&nbsp;<input type="submit" name="submit2" value="Cancel" width=75></td>
                  </tr> 
                 </table>
                 </cfoutput>
                </td>
               </tr>
              </table>
             </form>
            </td>
           </tr>
          </table>
         </td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>
