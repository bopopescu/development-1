<cfinclude template = "../../includes/app_globals.cfm">

<!-- define TIMENOW -->
  <cfmodule template="../../functions/timenow.cfm">
  

<!--- Include EPOCH module  --->
 <CFMODULE TEMPLATE="../../functions/epoch.cfm">
 
  <!--- Include session tracking template --->
 <cfinclude template="../../includes/session_include.cfm">

 
	
<!--- Save all posted vars into session variables --->
   <cfset #session.held_item# = "1"> 
   <cfset #itemnum# = #attributes.itemnum#>
   <cfset old_itemnum = #attributes.itemnum#>
  
<cfquery username="#db_username#" password="#db_password#" name="get_item" datasource="#DATASOURCE#">
SELECT *
FROM items
where itemnum = #itemnum#
</cfquery>
<cfset date_start_org = dateformat(get_Item.date_start, "mm/dd/yy")>
<cfset date_end_org = dateformat(get_Item.date_end, "mm/dd/yy")>
<cfset duration = datediff("d","#date_start_org#","#date_end_org#")>
<cfset new_date_end = dateadd("d","#duration#", "#dateformat(now())#")> 
<cfset new_date_end = DateFormat(new_date_end, "mm/dd/yy") & " " & TimeFormat(now(), "HH:mm:ss")>

  
  <!--- Check to see if the EPOCH value has been used before ---> 
<!--- Set the Condition of the loop to true --->
<cfset #loop_again# = "1">
<cfloop condition="loop_again IS 1">
  <cfquery username="#db_username#" password="#db_password#" name="EPOCH_check" DATASOURCE="#DATASOURCE#">
       SELECT itemnum
         FROM items
        WHERE itemnum = #EPOCH#
  </cfquery>
  <cfif EPOCH_check.recordcount GT 0>
    <cfset #EPOCH#=#EPOCH# + 1>
  <cfelse>
    <cfset #loop_again#=0>
  </cfif>
</cfloop>

<!--- Fill in vars for the old item, but with a new item # --->
  <cfset #itemnum# = "#EPOCH#">
  
  <!--- Rename thumbnail with item number --->
  <cfset #curPath# = GetTemplatePath()> 
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"event2","thumbs")>
<cfif get_item.studio eq 1>
  <cfif FileExists(#directory#&#old_itemnum#&".jpg")>
    <cffile action="rename"
     SOURCE = "#directory##old_itemnum#.jpg"
     DESTINATION = "#directory##itemnum#.jpg">
	 
  <cfelseif FileExists(#directory#&#old_itemnum#&".gif")>
    <cffile action="rename"
      SOURCE = "#directory##old_itemnum#.gif" 
      DESTINATION = "#directory##itemnum#.gif">
  </cfif> 
</cfif>
  
  
  <cfset #user_id# = "#get_item.user_id#">
  <cfset #category1# = "#get_item.category1#">
  <cfset #category2# = "#get_item.category2#">
  <cfset #title# = "#get_item.title#">
  <cfset #location# = "#get_item.location#">
  <cfset #country# = "#get_item.country#">
  <cfset #description# = "#get_item.description#">
  <cfset #desc_languages# = "#get_item.desc_languages#">
  <cfset #picture# = "#get_item.picture#">
  <cfset #picture1# = "#get_item.picture1#">
  <cfset #picture2# = "#get_item.picture2#">
  <cfset #picture3# = "#get_item.picture3#">
  <cfset #picture4# = "#get_item.picture4#">
  <cfset #sound# = "#get_item.sound#"> 
  <cfset #picture_studio# = "#get_item.picture_studio#">
  <cfset #sound_studio# = "#get_item.sound_studio#">
  <cfset #quantity# = "#get_item.quantity#">
  <cfset #minimum_bid# = #REReplace("#get_item.minimum_bid#", "[^0-9.]", "", "ALL")#>
  <cfset #maximum_bid# = #REReplace("#get_item.maximum_bid#", "[^0-9.]", "", "ALL")#>
  <cfset #increment_valu# = #REReplace("#get_item.increment_valu#", "[^0-9.]", "", "ALL")#>
  <cfset #dynamic_valu# = "#get_item.dynamic_valu#">
  <cfset #reserve_bid# = #REReplace("#get_item.reserve_bid#", "[^0-9.]", "", "ALL")#>
  <cfset #banner_line# = "#get_item.banner_line#">
  <cfset #date_start# = "#now()#">
  <cfset #date_end# = "#new_date_end#">

  <cfset #bold_title# = "#get_item.bold_title#">
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
  <cfset #increment# = "#get_item.increment#">
  <cfset #dynamic# = "#get_item.dynamic#">
  <cfset #featured# = "#get_item.featured#">
  <cfset #featured_cat# = "#get_item.featured_cat#">
  <cfset #private# = "#get_item.private#">
<!---  <cfset #inspector# = "#get_item.inspector#"> --->
  <cfset #banner# = "#get_item.banner#">
  <cfset #studio# = "#get_item.studio#">
  <cfset #featured_studio# = "#get_item.featured_studio#">
  <cfset #auction_type# = "#get_item.auction_type#">
  <cfset #billmeth# = "BM">
  <cfset #remote_ip# = "#get_item.remote_ip#">
  <cfset #auction_mode# = #get_item.auction_mode#>
  <cfset #hide# = #get_item.hide#>
  <cfset #auto_relist# = #get_item.auto_relist# - 1>
  <cfset #buynow_price# = #get_item.buynow_price#>
  <cfset #buynow# = #get_item.buynow#>
  <cfset #org_quantity# = #get_item.quantity#>
  
  <!--- Rename full size image with item number --->
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"event2","fullsize_thumbs")>
<cfif picture1 neq "" and picture1 neq "http://">
 <cfif right(picture1,3) eq "jpg" or right(picture1,3) eq "JPG">
  <cfif FileExists(#directory2#&#old_itemnum#&".jpg")>
    <cffile action="rename"
     SOURCE = "#directory2##old_itemnum#.jpg"
     DESTINATION = "#directory2##itemnum#.jpg">
	 <cfset picture1 = "#itemnum#.jpg">
  </cfif>
 <cfelseif right(picture,3) eq "gif" or right(picture,3) eq "GIF">
  <cfif FileExists(#directory2#&#old_itemnum#&".gif")>
    <cffile action="rename"
      SOURCE = "#directory2##old_itemnum#.gif" 
      DESTINATION = "#directory2##itemnum#.gif">
	  <cfset picture1 = "#itemnum#.gif">
  </cfif>
 </cfif>
</cfif>
  
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"event2","fullsize_thumbs1")>
<cfif picture2 neq "" and picture2 neq "http://">
 <cfif right(picture2,3) eq "jpg" or right(picture2,3) eq "JPG">
  <cfif FileExists(#directory2#&#old_itemnum#&".jpg")>
    <cffile action="rename"
     SOURCE = "#directory2##old_itemnum#.jpg"
     DESTINATION = "#directory2##itemnum#.jpg">
	 <cfset picture2 = "#itemnum#.jpg">
  </cfif>
 <cfelseif right(picture2,3) eq "gif" or right(picture2,3) eq "GIF">
  <cfif FileExists(#directory2#&#old_itemnum#&".gif")>
    <cffile action="rename"
      SOURCE = "#directory2##old_itemnum#.gif" 
      DESTINATION = "#directory2##itemnum#.gif">
	  <cfset picture2 = "#itemnum#.gif">
  </cfif>
 </cfif>
</cfif>
  
  <!--- Rename full size image #3 with item number --->
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"event2","fullsize_thumbs2")>
<cfif picture3 neq "" and picture3 neq "http://">
 <cfif right(picture3,3) eq "jpg" or right(picture3,3) eq "JPG">
  <cfif FileExists(#directory2#&#old_itemnum#&".jpg")>
    <cffile action="rename"
     SOURCE = "#directory2##old_itemnum#.jpg"
     DESTINATION = "#directory2##itemnum#.jpg">
	 <cfset picture3 = "#itemnum#.jpg">
  </cfif>
 <cfelseif right(picture3,3) eq "gif" or right(picture3,3) eq "GIF">
  <cfif FileExists(#directory2#&#old_itemnum#&".gif")>
    <cffile action="rename"
      SOURCE = "#directory2##old_itemnum#.gif" 
      DESTINATION = "#directory2##itemnum#.gif">
	  <cfset picture3 = "#itemnum#.gif">
  </cfif>
 </cfif>
</cfif>

<!--- Rename full size image #4 with item number --->
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"event2","fullsize_thumbs3")>
<cfif picture4 neq "" and picture4 neq "http://">
 <cfif right(picture4,3) eq "jpg" or right(picture4,3) eq "JPG">
  <cfif FileExists(#directory2#&#old_itemnum#&".jpg")>
    <cffile action="rename"
     SOURCE = "#directory2##old_itemnum#.jpg"
     DESTINATION = "#directory2##itemnum#.jpg">
	 <cfset picture4 = "#itemnum#.jpg">
  </cfif>
 <cfelseif right(picture4,3) eq "gif" or right(picture4,3) eq "GIF">
  <cfif FileExists(#directory2#&#old_itemnum#&".gif")>
    <cffile action="rename"
      SOURCE = "#directory2##old_itemnum#.gif" 
      DESTINATION = "#directory2##itemnum#.gif">
	  <cfset picture4 = "#itemnum#.gif">
  </cfif>
 </cfif>
</cfif>


  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"event2","fullsize_thumbs3")>
<cfif picture4 neq "" and picture4 neq "http://">
 <cfif right(picture4,3) eq "jpg" or right(picture4,3) eq "JPG">
  <cfif FileExists(#directory2#&#old_itemnum#&".jpg")>
    <cffile action="rename"
     SOURCE = "#directory2##old_itemnum#.jpg"
     DESTINATION = "#directory2##itemnum#.jpg">
	 <cfset picture4 = "#itemnum#.jpg">
  </cfif>
 <cfelseif right(picture4,3) eq "gif" or right(picture4,3) eq "GIF">
  <cfif FileExists(#directory2#&#old_itemnum#&".gif")>
    <cffile action="rename"
      SOURCE = "#directory2##old_itemnum#.gif" 
      DESTINATION = "#directory2##itemnum#.gif">
	  <cfset picture4 = "#itemnum#.gif">
  </cfif>
 </cfif>
</cfif>

 <cfquery username="#db_username#" password="#db_password#" name="getlvls" DATASOURCE="#DATASOURCE#">
select lvl_1,lvl_2,lvl_3,lvl_4,lvl_5,lvl_6,lvl_7,lvl_8 from categories where category =
             #category1# 
			 and category > 0
</cfquery>
<cfif getlvls.recordcount>
 <cfset lvl_1 = getlvls.lvl_1>
 <cfset lvl_2 = getlvls.lvl_2>
 <cfset lvl_3 = getlvls.lvl_3>
 <cfset lvl_4 = getlvls.lvl_4>
 <cfset lvl_5 = getlvls.lvl_5>
 <cfset lvl_6 = getlvls.lvl_6>
 <cfset lvl_7 = getlvls.lvl_7>
 <cfset lvl_8 = getlvls.lvl_8>
<cfelse>
<cfset lvl_1 = 0>
 <cfset lvl_2 = 0>
 <cfset lvl_3 = 0>
 <cfset lvl_4 = 0>
 <cfset lvl_5 = 0>
 <cfset lvl_6 = 0>
 <cfset lvl_7 = 0>
 <cfset lvl_8 = 0>
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="getlvls2" DATASOURCE="#DATASOURCE#">
select lvl_1,lvl_2,lvl_3,lvl_4,lvl_5,lvl_6,lvl_7,lvl_8 from categories where category =
             #category2# 
			 AND category > 0
</cfquery>
<cfif getlvls2.recordcount>
 <cfset cat2_lvl_1 = getlvls2.lvl_1>
 <cfset cat2_lvl_2 = getlvls2.lvl_2>
 <cfset cat2_lvl_3 = getlvls2.lvl_3>
 <cfset cat2_lvl_4 = getlvls2.lvl_4>
 <cfset cat2_lvl_5 = getlvls2.lvl_5>
 <cfset cat2_lvl_6 = getlvls2.lvl_6>
 <cfset cat2_lvl_7 = getlvls2.lvl_7>
 <cfset cat2_lvl_8 = getlvls2.lvl_8>  
<cfelse>
<cfset cat2_lvl_1 = 0>
 <cfset cat2_lvl_2 = 0>
 <cfset cat2_lvl_3 = 0>
 <cfset cat2_lvl_4 = 0>
 <cfset cat2_lvl_5 = 0>
 <cfset cat2_lvl_6 = 0>
 <cfset cat2_lvl_7 = 0>
 <cfset cat2_lvl_8 = 0> 

</cfif>

<!--- Insert the item into the database --->
 <cfquery username="#db_username#" password="#db_password#" name="insert_item" datasource="#DATASOURCE#">
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
			picture1,
			picture2,
			picture3,
			picture4,
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
<!---            inspector, --->
            banner,
            banner_line,
            studio,
            featured_studio,
            picture_studio,
            sound_studio,
            date_start,
            date_end,
            itemnum,
            billmeth,
            remote_ip,
            auction_type,
			auction_mode,
			hide,
			auto_relist,
			buynow_price,
			buynow,
			org_quantity<cfif #getlvls.recordcount#>
	,lvl_1,
	lvl_2,
	lvl_3,
	lvl_4,
	lvl_5,
	lvl_6,
	lvl_7,
	lvl_8</cfif><cfif #getlvls2.recordcount#>
	,cat2_lvl_1,
	cat2_lvl_2,
	cat2_lvl_3,
	cat2_lvl_4,
	cat2_lvl_5,
	cat2_lvl_6,
	cat2_lvl_7,
	cat2_lvl_8</cfif>)
     VALUES (1,
             #user_id#,
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
			 '#picture1#',
			 '#picture2#',
			 '#picture3#',
			 '#picture4#',
             '#sound#',
             #org_quantity#,
             #minimum_bid#,
			 #maximum_bid#,
             #increment#,
             #increment_valu#,
             #dynamic#,
             #dynamic_valu#,
             #reserve_bid#,
             #bold_title#,
             #featured#,
             #featured_cat#,
             #private#,
<!---             '#inspector#', --->
             #banner#,
             '#banner_line#',
             #studio#,
             #featured_studio#,
             '#picture_studio#',
             '#sound_studio#',
             #createODBCDateTime (date_start)#,
             #createODBCDateTime (date_end)#,
             #epoch#,
             '#billmeth#',
             '#remote_ip#',
             '#auction_type#',
			 #auction_mode#,
			 #hide#,
			 #auto_relist#,
			 #buynow_price#,
			 #buynow#,
			 #org_quantity#<cfif getlvls.recordcount>
	,#lvl_1#,
	#lvl_2#,
	#lvl_3#,
	#lvl_4#,
	#lvl_5#,
	#lvl_6#,
	#lvl_7#,
	#lvl_8#</cfif><cfif getlvls2.recordcount>
	,#cat2_lvl_1#,
	#cat2_lvl_2#,
	#cat2_lvl_3#,
	#cat2_lvl_4#,
	#cat2_lvl_5#,
	#cat2_lvl_6#,
	#cat2_lvl_7#,
	#cat2_lvl_8#</cfif>)
</cfquery> 
<!-- hide original auction -->
    <cfquery username="#db_username#" password="#db_password#" name="updAuction" datasource="#DATASOURCE#">
        UPDATE items
           SET hide = 1, status = 0
	    WHERE itemnum = #old_itemnum#
    </cfquery>
