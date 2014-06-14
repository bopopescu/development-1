<html>
 <head>
  <title>Personal Page: Item Edit Preview </title>
 </head>

 <cfsetting enablecfoutputonly="Yes">

  <!--- Set a default value for "submit2" and "submit3" if nonexistent --->
 <cfif #isDefined ("submit2")# is 0>
  <cfset #submit2# = "enter">
 <cfelse>
  <cfset #submit2# = #trim (submit2)#>
 </cfif>
 
  <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
 
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 <cfif isdefined('url.selected_item')>
 <cfquery username="#db_username#" password="#db_password#" NAME="getMode" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
SELECT auction_mode FROM items
WHERE itemnum = #url.selected_item#
</CFQUERY>
</CFIF>


 <cfif #isDefined ('selected_category')#>
  <cfset #selected_category# = "0">
 </cfif>
 
 <!--- Check to see if we are done looking at the page --->
 <!---<cfif #submit# is "Continue">
  <cfoutput><cflocation url="main_page.cfm"></cfoutput>
 </cfif>
 --->
 <!--- Get a list of active users --->
 <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
  SELECT user_id, name, nickname
    FROM users
   WHERE user_id = #session.user_id#
   ORDER BY nickname
 </cfquery>

 <!--- Get the last user they chose as the seller --->
 <cfquery username="#db_username#" password="#db_password#" name="get_seller" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'last_seller'
 </cfquery>
 <cfif isDefined("session.itemnum")>
<cfset selected_item = #session.itemnum#>
<cfelse><cfset selected_item = #session.adnum#>
</cfif>
 <!--- Get item information --->
<cfquery username="#db_username#" password="#db_password#" name="get_item" dataSource="#DATASOURCE#">
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
		  maximum_bid,
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
          auction_type,
		  auction_mode
     FROM items
    WHERE itemnum = #selected_item#
  </cfquery>
  <cfset #selected_category# = #get_item.category1#>

  <!--- Get the seller's email address --->
  <cfquery username="#db_username#" password="#db_password#" name="get_seller_email" datasource="#DATASOURCE#">
   SELECT email
     FROM users
    WHERE user_id = #get_item.user_id#
  </cfquery>
  <cfset #seller_email# = "#get_seller_email.email#">
  <cfset #session.seller_email# = "#get_seller_email.email#">

  <cfset #itemnum# = "#get_item.itemnum#">
  <cfset #session.itemnum# = "#get_item.itemnum#">
  <cfset #the_item# = "#get_item.itemnum#">
  <cfset #session.the_item# = "#get_item.itemnum#">
  <cfset #status# = "#get_item.status#">
  <cfset #user_id# = "#get_item.user_id#">
  <cfset #session.user_id# = "#get_item.user_id#">
  <cfset #category1# = "#get_item.category1#">
  <cfset #category2# = "#get_item.category2#">
  <cfset #title# = "#get_item.title#">
  <cfset #session.title# = "#get_item.title#">
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
  <cfset #maximum_bid# = "#get_item.maximum_bid#">
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
  <cfset #studio# = "#get_item.studio#">
  <cfset #featured_studio# = "#get_item.featured_studio#">
  <cfset #picture_studio# = #trim ("#get_item.picture_studio#")#>
  <cfset #sound_studio# = #trim ("#get_item.sound_studio#")#>
  <cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
   <cfset #picture_studio# = "http://#picture_studio#">
  </cfif>
  <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
   <cfset #sound_studio# = "http://#sound_studio#">
  </cfif>
  <cfset #date_start# = "#get_item.date_start#">
  <cfset #date_end# = "#get_item.date_end#">
  <cfset #selected_user# = "#get_item.user_id#">
  <cfset #selected_auction_type# = "#get_item.auction_type#">
  <cfset #auction_mode# = "#get_item.auction_mode#">
  
  <cfset #isvalid# = "true"> 

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

<!--- output information --->
<cfsetting enablecfoutputonly="No">
<!--- Test to see if we are coming back to edit another item or return to the personal page--->
<cfif #submit2# is "Edit Another">
<cflocation url="edititem.cfm">
</cfif>
<cfif #submit2# is "Cancel">
<cflocation url="main_page.cfm">
</cfif>
<html>
  <head>
    <title><cfif #isdefined ("selected_item")# is 1>Item <cfoutput>#session.itemnum# (#Trim(session.title)#)</cfoutput><cfelse>Item Not Found</cfif></title>

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
   <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <br>
              <br>
             <!--- Browse the <a href="<cfoutput>#VAROOT#</cfoutput>/studio/index.html">studio</a> for items.
            ---></center>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
        <tr>
          <td><CFOUTPUT>
           <form name="item_pre" action="edit_pre_new.cfm" method="post">
		   <Font color="RED" size="+1"> The changes that you have made to <BR> Item:</font> <Font size="+1">(#itemnum#) #title# have taken effect.</font><br><br>
		   <input type="submit" name="submit2" value="Edit Another" width=75>&nbsp; <input type="submit" name="submit2" value="Cancel" width=75>
		   </form>
		  </cfoutput></td>
        </tr>
      </table>
    </div>
  </body>
</html>
