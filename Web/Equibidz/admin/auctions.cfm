<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<cfmodule template="../functions/timenow.cfm">
<cfmodule template="../functions/epoch.cfm">
 <!--- Always check for valid username/password --->
<cfinclude template="validate_include.cfm">

<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif #trim(submit)# is "Back">
   <cfset selected_item = 0>
</cfif>
<cfif isDefined("selected_item")>
    <cfset selected_item = #selected_item#>
<cfelse>
    <cfset selected_item = 0>
</cfif>
<cfif isDefined("status")>
    <cfset status = #status#>
<cfelse>
    <cfset status = 0>
</cfif>
<cfif isDefined("pure_breed")>
    <cfset pure_breed = #pure_breed#>
<cfelse>
    <cfset pure_breed = 0>
</cfif>
<cfif isdefined("item_exist")>
   <cfset item_exist = #item_exist#>
<cfelse>
   <cfset item_exist = 0>
</cfif>
<cfif isDefined("selected_sex")>
   <cfset sel_sex = #selected_sex#>
<cfelse>
   <cfif isDefined("sel_sex")>
      <cfset sel_sex = #sel_sex#>
   <cfelse>
      <cfset sel_sex = "">
   </cfif>   
</cfif>    

<!-------------upload image #1---------------->
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","fullsize_thumbs")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture1 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture1#")>
        <cffile action="rename"
          SOURCE = "#directory##picture1#"  
          DESTINATION = "#directory##selected_item#.jpg">
      </cfif>
</cfif>
<!-------------upload image #2---------------->
<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","fullsize_thumbs1")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture2 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture2#")>
        <cffile action="rename"
          SOURCE = "#directory##picture2#"  
          DESTINATION = "#directory##selected_item#.jpg">
      </cfif>
</cfif>
<!-------------upload image #3---------------->
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","fullsize_thumbs2")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture3 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture3#")>
        <cffile action="rename"
          SOURCE = "#directory##picture3#"  
          DESTINATION = "#directory##selected_item#.jpg">
      </cfif>
</cfif>
<!-------------upload image #4---------------->
<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","fullsize_thumbs3")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture4 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture4#")>
        <cffile action="rename"
          SOURCE = "#directory##picture4#"  
          DESTINATION = "#directory##selected_item#.jpg">
      </cfif>
</cfif>
<!-------------upload image #5---------------->
<cfif isdefined("form.picture5") and form.picture5 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","fullsize_thumbs4")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture5"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture5"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture5 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture5#")>
        <cffile action="rename"
          SOURCE = "#directory##picture5#"  
          DESTINATION = "#directory##selected_item#.jpg">
      </cfif>
</cfif>
<!-------------upload image #6---------------->
<cfif isdefined("form.picture6") and form.picture6 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","fullsize_thumbs5")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture6"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/png, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture6"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture6 = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="300" WIDTH="380" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture6#")>
        <cffile action="rename"
          SOURCE = "#directory##picture6#"  
          DESTINATION = "#directory##selected_item#.jpg">
      </cfif>
</cfif>

<cfif #trim(submit)# is "Pause Auction">
  <cfquery username="#db_username#" password="#db_password#" name="pause_auction" dataSource="#DATASOURCE#">
	UPDATE items
	SET status = 2
	WHERE itemnum=#selected_item#
  </cfquery>
</cfif>

<cfif #trim(submit)# is "Continue Auction">
  <cfquery username="#db_username#" password="#db_password#" name="continue_auction" dataSource="#DATASOURCE#">
	UPDATE items
	SET status = 1
	WHERE itemnum=#selected_item#
  </cfquery>
</cfif>
<cfif #trim(submit)# is "Delete">
    <cfquery username="#db_username#" password="#db_password#" name="delete_item" datasource="#DATASOURCE#">
       DELETE FROM items WHERE itemnum = #selected_item#
    </cfquery>       
    <cfset selected_item = 0>
</cfif>

<cfif #trim(submit)# is "Save">
    <cfoutput>
    <cfif #buynow_price# EQ 0>
       <cfset #buynow_price# = #reserve_bid#>
    </cfif>
    <cfset #start_time# = "#start_time##start_time_s#">
    <cfset #start_hour# = #timeFormat (start_time, 'H')#>
    <cfset #start_min# = #timeFormat (start_time, 'm')#>
    <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
    <cfset #date_end# = #dateAdd ("d", "#selected_duration#", date_start)#>
    <cfset #dob# = #createDateTime (dob_year, dob_month, start_day, start_hour, start_min, 0)#>    
    <cfif #item_exist# EQ 0>
      <cfquery username="#db_username#" password="#db_password#" name="insert_item" datasource="#DATASOURCE#">
        INSERT INTO items
            (status,
             category,
             category1,
             auction_type,
             auction_mode,
             list_type,
             itemnum,
             user_id,
             name,
             registration,
             sire,
             dam,
             pri_breed,
             sec_breed,
             pure_breed,
             title,
             year_foaled,
             color,
             dob,
             sex,
             height,
             discipline,
             experience,
             attributes,
             temperament,
             nominations,
             comments,
             performance,
             produce,
             sire_performance,
             dam_performance,
             stallion_incentive,
             earnings,
             weblink,
             ped4,
             ped5,
             ped6,
             ped7,
             ped8,
             ped9,
             ped10,
             ped11,
             ped12,
             ped13,
             ped14,
             ped15,
             isfoal,
             last_bred_date,
             regular_fee,
             shipped_semen,
             frozen_semen,
             shipped_semen_fee,
             intl_shipped_semen_fee,
             counter_fee,
             booking_fee,
             mare_care_fee,
             picture1,
             picture2,
             picture3,
             picture4,
             picture5,
             picture6,
             youtube,
             location,
             city,
             state,
             province,
             country,
             zipcode,
             date_start,
             date_end,
             duration,
             auto_relist,
             minimum_bid,
             maximum_bid,
             reserve_bid,
             buynow_price,
             increment_valu,
             increment,
             shipping_fee,
             salestax,
             terms,
             quantity)
        VALUES (#status#,
             'S',
             #category1#,
             'E',
             0,
             '#selected_list_type#',
             #selected_item#,
             #selected_user#,
             '#name#',
             '#registration#',
             '#sire#',
             '#dam#',
             '#selected_pri_breed#',
             '#selected_sec_breed#',
             #pure_breed#,
             '#name#',
             0,
             '#selected_color#',
             #dob#,
             '#selected_sex#',
             '#selected_height#',
             '#selected_discipline#',
             '#selected_experience#',
             '#selected_attributes#',
             '#selected_temperament#',
             '#nominations#',
             '#comments#',
             '#performance#',
             '#produce#',
             '#sire_performance#',
             '#dam_performance#',
             '#stallion_incentive#',
             #earnings#,
             '#weblink#',
             '#ped4#',
             '#ped5#',
             '#ped6#',
             '#ped7#',
             '#ped8#',
             '#ped9#',
             '#ped10#',
             '#ped11#',
             '#ped12#',
             '#ped13#',
             '#ped14#',
             '#ped15#',
             '#selected_isfoal#',
             '#last_bred_date#',
             #regular_fee#,
             '#selected_shipped_semen#',
             '#selected_frozen_semen#',
             #shipped_semen_fee#,
             #intl_shipped_semen_fee#,
             #counter_fee#,
             #booking_fee#,
             #mare_care_fee#,
			 <cfif #picture1# NEQ "">'#selected_item#.jpg'<cfelse>'#picture1#'</cfif>,
			 <cfif #picture2# NEQ "">'#selected_item#.jpg'<cfelse>'#picture2#'</cfif>,
			 <cfif #picture3# NEQ "">'#selected_item#.jpg'<cfelse>'#picture3#'</cfif>,
			 <cfif #picture4# NEQ "">'#selected_item#.jpg'<cfelse>'#picture4#'</cfif>,
			 <cfif #picture5# NEQ "">'#selected_item#.jpg'<cfelse>'#picture5#'</cfif>,
			 <cfif #picture6# NEQ "">'#selected_item#.jpg'<cfelse>'#picture6#'</cfif>,
             '#youtube#',
             '#selected_location#',
             '#city#',
             '#state#',
             '#province#',
             '#country#',
             '#zipcode#',
             #createODBCDateTime (date_start)#,
             #createODBCDateTime (date_end)#,
             #selected_duration#,
             #selected_auto_relist#,
             #minimum_bid#,
             #maximum_bid#,
             #reserve_bid#,
             #buynow_price#,
             #selected_increment#,
             1,
             #shipping_fee#,
             #salestax#,
             '#terms#',
             1)
      </cfquery>
    <cfelse>
      <cfquery username="#db_username#" password="#db_password#" name="update_item" datasource="#DATASOURCE#">
        UPDATE items
         SET status = #status#,
             category = 'S',
             category1 = #category1#,
             list_type = '#selected_list_type#',
             itemnum = #selected_item#,
             user_id = #selected_user#,
             name = '#name#',
             registration = '#registration#',
             sire = '#sire#',
             dam = '#dam#',
             pri_breed = '#selected_pri_breed#',
             sec_breed = '#selected_sec_breed#',
             pure_breed = #pure_breed#,
             title = '#name#',       
             color = '#selected_color#',
             dob = #dob#,
             sex = '#selected_sex#',
             height = '#selected_height#',
             discipline = '#selected_discipline#',
             experience = '#selected_experience#',
             attributes = '#selected_attributes#',
             temperament = '#selected_temperament#',
             nominations = '#nominations#',
             comments = '#comments#',
             performance = '#performance#',
             produce = '#produce#',
             sire_performance = '#sire_performance#',
             dam_performance = '#dam_performance#',
             stallion_incentive = '#stallion_incentive#',
             earnings = #earnings#,
             weblink = '#weblink#',
             ped4 ='#ped4#',
             ped5 = '#ped5#',
             ped6 = '#ped6#',
             ped7 = '#ped7#',
             ped8 = '#ped8#',
             ped9 = '#ped9#',
             ped10 = '#ped10#',
             ped11 = '#ped11#',
             ped12 = '#ped12#',
             ped13 = '#ped13#',
             ped14 = '#ped14#',
             ped15 = '#ped15#',
             isfoal = '#selected_isfoal#',
             last_bred_date = '#last_bred_date#',
             regular_fee = #regular_fee#,
             shipped_semen = '#selected_shipped_semen#',
             frozen_semen = '#selected_frozen_semen#',
             shipped_semen_fee = #shipped_semen_fee#,
             intl_shipped_semen_fee = #intl_shipped_semen_fee#,
             counter_fee = #counter_fee#,
             booking_fee = #booking_fee#,
             mare_care_fee = #mare_care_fee#,
 		     <cfif #picture1# NEQ "">picture1 = '#selected_item#.jpg',</cfif>
			 <cfif #picture2# NEQ "">picture2 = '#selected_item#.jpg',</cfif>
			 <cfif #picture3# NEQ "">picture3 = '#selected_item#.jpg',</cfif>
			 <cfif #picture4# NEQ "">picture4 = '#selected_item#.jpg',</cfif>
			 <cfif #picture5# NEQ "">picture5 = '#selected_item#.jpg',</cfif>
			 <cfif #picture6# NEQ "">picture6 = '#selected_item#.jpg',</cfif>
             youtube = '#youtube#',
             location = '#selected_location#',
             city = '#city#',
             state = '#state#',
             province = '#province#',
             country = '#country#',
             zipcode = '#zipcode#',
             date_start = #createODBCDateTime (date_start)#,
             date_end = #createODBCDateTime (date_end)#,
             duration = #selected_duration#,
             auto_relist = #selected_auto_relist#,
             minimum_bid = #minimum_bid#,
             maximum_bid = 0,
             reserve_bid = #reserve_bid#,
             buynow_price = #buynow_price#,
             increment_valu = #selected_increment#,
             shipping_fee = #shipping_fee#,
             salestax = #salestax#,
             terms = '#terms#'
        WHERE itemnum = #selected_item#     
      </cfquery>
    </cfif>  
    </cfoutput>
    <cfset selected_item = 0>
</cfif>

<cfif #trim(submit)# is "Retrieve" AND #selected_item_info# NEQ 0>
    <cfif #IsDefined("selected_item_info")#>
       <cfset selected_item=#selected_item_info#>
    <cfelse>
       <cfset selected_item=#selected_item#>
    </cfif>   
    <cfquery username="#db_username#" password="#db_password#" name="get_item_info" datasource="#DATASOURCE#">
           SELECT * , (SELECT nickname FROM users WHERE items.user_id = users.user_id) AS nickname           		  
           FROM items
           WHERE itemnum = #selected_item#
    </cfquery> 
    <cfset category1 = #get_item_info.category1#>
    <cfset selected_item = #get_item_info.itemnum#>
    <cfset auction_type = #get_item_info.auction_type#>
    <cfset auction_mode = #get_item_info.auction_mode#>    
    <cfset nickname = #get_item_info.nickname#>
    <cfset title = #get_item_info.title#>
    <cfset name = #get_item_info.name#>
    <cfset registration = #get_item_info.registration#>
    <cfset sire = #get_item_info.sire#>
    <cfset dam = #get_item_info.dam#>
    <cfset pri_breed = #get_item_info.pri_breed#>
    <cfset sec_breed = #get_item_info.sec_breed#>
    <cfset pure_breed = #get_item_info.pure_breed#>
    <cfset bloodline = #get_item_info.bloodline#>    
    <cfset year_foaled = #get_item_info.year_foaled#>
    <cfset color = #get_item_info.color#>
    <cfset dob = #get_item_info.dob#>
    <cfset sex = #get_item_info.sex#>
    <cfset height = #get_item_info.height#>
    <cfset discipline = #get_item_info.discipline#>
    <cfset experience = #get_item_info.experience#>
    <cfset attributes = #get_item_info.attributes#>
    <cfset temperament = #get_item_info.temperament#>
    <cfset nominations = #get_item_info.nominations#>
    <cfset location = #get_item_info.location#>
    <cfset city = #get_item_info.city#>
    <cfset state = #get_item_info.state#>
    <cfset province = #get_item_info.province#>
    <cfset country = #get_item_info.country#>
    <cfset zipcode = #get_item_info.zipcode#>
    <cfset comments = #get_item_info.comments#>
    <cfset isfoal = #get_item_info.isfoal#>
    <cfset last_bred_date = #get_item_info.last_bred_date#>
    <cfset regular_fee = #get_item_info.regular_fee#>
    <cfset shipped_semen = #get_item_info.shipped_semen#>
    <cfset frozen_semen = #get_item_info.frozen_semen#>
    <cfset shipped_semen_fee = #get_item_info.shipped_semen_fee#>
    <cfset intl_shipped_semen_fee = #get_item_info.intl_shipped_semen_fee#>
    <cfset booking_fee = #get_item_info.booking_fee#>
    <cfset counter_fee = #get_item_info.counter_fee#>
    <cfset mare_care_fee = #get_item_info.mare_care_fee#>
    <cfset performance = #get_item_info.performance#>
    <cfset produce = #get_item_info.produce#>
    <cfset sire_performance = #get_item_info.sire_performance#>
    <cfset dam_performance = #get_item_info.dam_performance#>
    <cfset stallion_incentive = #get_item_info.stallion_incentive#>
    <cfset date_start = #get_item_info.date_start#>
    <cfset date_end = #get_item_info.date_end#>
    <cfset duration = #get_item_info.duration#>
    <cfset auto_relist = #get_item_info.auto_relist#>
    <cfset minimum_bid = #get_item_info.minimum_bid#>
    <cfset maximum_bid = #get_item_info.maximum_bid#>
    <cfset reserve_bid = #get_item_info.reserve_bid#>
    <cfset increment_valu = #get_item_info.increment_valu#>
    <cfset buynow_price = #get_item_info.buynow_price#>
    <cfset shipping_fee = #get_item_info.shipping_fee#>
    <cfset salestax = #get_item_info.salestax#>
    <cfset picture1 = #get_item_info.picture1#>
    <cfset picture2 = #get_item_info.picture2#>
    <cfset picture3 = #get_item_info.picture3#>
    <cfset picture4 = #get_item_info.picture4#>
    <cfset picture5 = #get_item_info.picture5#>
    <cfset picture6 = #get_item_info.picture6#>
    <cfset youtube = #get_item_info.youtube#>
    <cfset status = #get_item_info.status#>
    <cfset category = #get_item_info.category#>
    <cfset list_title = #get_item_info.list_title#>
    <cfset list_type = #get_item_info.list_type#>    
    <cfset selected_user = #get_item_info.user_id#>
    <cfset earnings = #get_item_info.earnings#>
    <cfset weblink = #get_item_info.weblink#>
    <cfset ped4 = #get_item_info.ped4#>
    <cfset ped5 = #get_item_info.ped5#>
    <cfset ped6 = #get_item_info.ped6#>
    <cfset ped7 = #get_item_info.ped7#>
    <cfset ped8 = #get_item_info.ped8#>
    <cfset ped9 = #get_item_info.ped9#>
    <cfset ped10 = #get_item_info.ped10#>
    <cfset ped11 = #get_item_info.ped11#>
    <cfset ped12 = #get_item_info.ped12#>
    <cfset ped13 = #get_item_info.ped13#>
    <cfset ped14 = #get_item_info.ped14#>
    <cfset ped15 = #get_item_info.ped15#>
    <cfset terms = #get_item_info.terms#>
    <cfset item_exist = 1>
</cfif>   
<cfif #trim(submit)# is "Add">
    <cfset category1 = 0>
    <cfset selected_item = "#EPOCH#">
    <cfset auction_type = "E">
    <cfset auction_mode = 0>    
    <cfset title = "">
    <cfset name = "">
    <cfset registration = "">
    <cfset sire = "">
    <cfset dam = "">
    <cfset pri_breed = "">
    <cfset sec_breed = "">
    <cfset pure_breed = 0>
    <cfset bloodline = "">    
    <cfset year_foaled = "">
    <cfset color = "">
    <cfset dob = #dateAdd("yyyy", -10, TIMENOW)#>
    <cfset sex = "">
    <cfset height = "">
    <cfset discipline = "">
    <cfset experience = "">
    <cfset attributes = "">
    <cfset temperament = "">
    <cfset nominations = "">
    <cfset location = "">
    <cfset city = "">
    <cfset state = "">
    <cfset province = "">
    <cfset country = "USA">
    <cfset zipcode = "">
    <cfset comments = "">
    <cfset isfoal = "No">
    <cfset last_bred_date = "">
    <cfset regular_fee = 0>
    <cfset shipped_semen = "Not Available">
    <cfset frozen_semen = "Not Available">
    <cfset shipped_semen_fee = 0>
    <cfset intl_shipped_semen_fee = 0>
    <cfset booking_fee = 0>
    <cfset counter_fee = 0>
    <cfset mare_care_fee = 0>
    <cfset performance = "">
    <cfset produce = "">
    <cfset sire_performance = "">
    <cfset dam_performance = "">
    <cfset stallion_incentive = "">
    <cfset date_start = #TIMENOW#>
    <cfset date_end = #TIMENOW#>
    <cfset duration = ""><!--- JM 04/11/2013  30>--->
    <cfset auto_relist = 0>
    <cfset minimum_bid = 0>
    <cfset maximum_bid = 0>
    <cfset reserve_bid = 0>
    <cfset increment_valu = 0>
    <cfset buynow_price = 0>
    <cfset shipping_fee = 0>
    <cfset salestax = 0>
    <cfset picture1 = "">
    <cfset picture2 = "">
    <cfset picture3 = "">
    <cfset picture4 = "">
    <cfset picture5 = "">
    <cfset picture6 = "">
    <cfset youtube = "">
    <cfset status = 1>
    <cfset category = "">
    <cfset list_title = "">
    <cfset list_type = "">    
    <cfset selected_user = 0>
    <cfset earnings = 0>
    <cfset weblink = "">
    <cfset ped4 = "">
    <cfset ped5 = "">
    <cfset ped6 = "">
    <cfset ped7 = "">
    <cfset ped8 = "">
    <cfset ped9 = "">
    <cfset ped10 = "">
    <cfset ped11 = "">
    <cfset ped12 = "">
    <cfset ped13 = "">
    <cfset ped14 = "">
    <cfset ped15 = "">
    <cfset terms = "">
    <cfset item_exist = 0>
</cfif>
<cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
  SELECT user_id, nickname, name
    FROM users
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_breed" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'breed'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_bloodline" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'bloodline'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'color'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_height" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'height'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_discipline" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'discipline'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_experience" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'experience'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_attributes" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'attributes'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_temperament" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'temperament'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_location" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'location'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_list_type" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'list_type'
   ORDER BY pair ASC
</cfquery>

<html>
 <head>
  <title>Auction Tables</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>


<script language="JavaScript">
	function get_table( tab ) {
		w = 400;
		h = 300;
		left = 600;
		top = 30;
		specs = 'toolbar=no, location=no, directories=no, status=no, menubar=no, ' + 
				'scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', ' +
				'height=' + h + ', top=' + top + ', left=' + left;

		window.open( 'auctions_sub.cfm?tab=' + tab, '_blank', specs );		
	}

	function get_terms(vShow){
		if (vShow == 0) {
		    tr = document.getElementById( "tr1" );
		    tr.style.display = "table-row";
  	        tr = document.getElementById( "tr2" );
	        tr.style.display = "none";
			
		} else {
			tr = document.getElementById( "tr1" );
			tr.style.display = "none";
			tr = document.getElementById( "tr2" );
			tr.style.display = "table-row";		
		}	
        return true;        
	}
	
	function val_entries() {
        var xAuction = 0;
        var xtitle = document.listForm.title.value;
        var xname = document.listForm.name.value;
        var xregistration = document.listForm.registration.value;
        var xyear_foaled = document.listForm.year_foaled.value;
        var xheight = document.listForm.height.value;
        var xlocation = document.listForm.location.value;
        var xcity = document.listForm.city.value;
        var xzipcode = document.listForm.zipcode.value;
        var xreserve_bid = document.listForm.reserve_bid.value;
        if (xtitle == "") {
           alert("Please input a Listing Title!");
           return false;        
        } 
        if (xname == "") {
           alert("Please input Horse Name!");
           return false;        
        } 
        if (xregistration == "") {
           alert("Please input Registration Number!");
           return false;        
        } 
        if (xyear_foaled == "") {
           alert("Please input Year Foaled!");
           return false;        
        } 
        if (xheight == "") {
           alert("Please input Height!");
           return false;        
        } 
        if (xlocation == "") {
           alert("Please input Location/Address!");
           return false;        
        } 
        if (xcity == "") {
           alert("Please input City!");
           return false;        
        } 
        if (xzipcode == "") {
           alert("Please input Zip Code!");
           return false;        
        } 
        if (xreserve_bid == 0) {
           alert("Please input Reserve Bid!");
           return false;        
        } 
        if (xAuction == 0) {
           var xminimum_bid = document.listForm.minimum_bid.value;
           if (xminimum_bid == 0) {
              alert("Please input Minimuum Bid!");
              return false;        
           } 
           if (parseInt(xreserve_bid) < parseInt(xminimum_bid)) {
              alert("Reserve Bid must be greater than Minimum Bid  in a REGULAR Auction!");
              return false;        
           }
        } else {
           var xmaximum_bid = document.listForm.maximum_bid.value;
           if (xmaximum_bid == 0) {
              alert("Please input Maximum Bid!");
              return false;        
           } 
           if (parseInt(xreserve_bid) > parseInt(xmaximum_bid)) {
              alert("Reserve Bid must be less than Maximum Bid in a REVERSE Auction!");
              return false;        
           }
           
        } 
        
    }		
</script>


<cfset tab = "breed">

 <!--- Main page body --->
 <body bgcolor=465775>
  <form name="listForm" action="auctions.cfm" method="post" enctype="multipart/form-data">
   <input type="hidden" name="tab" value="#tab#">
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
       <td colspan=5 bgcolor=bac1cf>

        <!--- A table encapsulating the main page content;
              with a thin black border --->
        <table border=0 bordercolor=000000 cellspacing=0 cellpadding=3 width=100%>
         <tr>
          <td><cfoutput>
           <font face="helvetica" size=2 color=000000>
            &nbsp;Use this page to administer the classified ads applications in your<i>Auction Server</i> software.<br>
            &nbsp;If you do not know how to use this administration tool, please click the help button in the upper right corner of this window.<br><br>
            &nbsp;Related Tables:
            <input type="reset" name="submit" value="Breed" onClick="get_table('breed')">
			<input type="reset" name="submit" value="Sex" onClick="get_table('Sex')">
            <input type="reset" name="submit" value="Color" onClick="get_table('color')">
            <input type="reset" name="submit" value="Height" onClick="get_table('height')">
            <input type="reset" name="submit" value="Discipline" onClick="get_table('discipline')">
            <input type="reset" name="submit" value="Experience" onClick="get_table('experience')">
            <input type="reset" name="submit" value="Attributes" onClick="get_table('attributes')">
            <input type="reset" name="submit" value="Temperament" onClick="get_table('temperament')">
            <input type="reset" name="submit" value="Location" onClick="get_table('location')">
            <input type="reset" name="submit" value="Listing Type" onClick="get_table('list_type')">
            <input type="submit" name="submit" id="list_sex" value="Show List" style="visibility:hidden">
          </td></cfoutput>
         </tr> 
         <tr><td><hr></td></tr>
         <cfif #selected_item# neq 0>
           <tr bgcolor="gray" height=24><td align="center"><b>Listing Details</b></td></tr>        
         </cfif>   
        </table>
        <cfquery username="#db_username#" password="#db_password#" name="get_item_info" datasource="#DATASOURCE#">
           SELECT itemnum,title,name,date_start,date_end,duration,status,
         		(SELECT nickname FROM users WHERE items.user_id = users.user_id) AS nickname
           FROM items
           <cfif #sel_sex# NEQ "">
              WHERE sex = '#sel_sex#'
           </cfif>
           ORDER BY itemnum DESC                            
        </cfquery>
        <cfset cur_selected_item = #get_item_info.itemnum#>
        <table border=0 cellspacing=10 cellpadding=0>
        <tr>
        <cfif #selected_item# is 0>
        <td valign="top">        
        <table border=0 cellspacing=0 cellpadding=0>
        <tr><td align="left"><font size=2>
         <input type="Radio" name="sel_sex" value=""  onClick="document.getElementById('list_sex').click();" onMouseOver="style.cursor='hand'" <cfif #sel_sex# EQ "" >checked</cfif>><b>All</b> 
         <input type="Radio" name="sel_sex" value="S" onClick="document.getElementById('list_sex').click();" onMouseOver="style.cursor='hand'" <cfif #sel_sex# EQ "S">checked</cfif>><b>Stallions</b> 
         <input type="Radio" name="sel_sex" value="M" onClick="document.getElementById('list_sex').click();" onMouseOver="style.cursor='hand'" <cfif #sel_sex# EQ "M">checked</cfif>><b>Mares</b>
         <input type="Radio" name="sel_sex" value="G" onClick="document.getElementById('list_sex').click();" onMouseOver="style.cursor='hand'" <cfif #sel_sex# EQ "G">checked</cfif>><b>Geldings</b>
         </font>
        </td></tr>         
        <tr><td>        
           <tr>
           <td align="left">
           <select name="selected_item_info" size=25 width=500>
              <cfif #get_item_info.recordcount# gt 0>
                   <cfloop query="get_item_info">
                      <cfoutput><option value="#itemnum#"<cfif #itemnum# is #cur_selected_item#> selected</cfif>>#itemnum#&nbsp;&nbsp;&nbsp;#name#&nbsp;(#nickname#)&nbsp;
                      <cfif #status# EQ 1>
					 	 [Active]
	 				  <cfelseif #status# EQ 0>
                         [Pending or Closed]
                      <cfelse>
                         [Pending]
                      </cfif>
	 				  
	 				  </option></cfoutput>
                   </cfloop>
              <cfelse>
                   <cfoutput><option value="0" selected>< No Data exist for this selection ></option></cfoutput>
              </cfif>
              </select>
            </td>
           </tr>
        </table>    
        </cfif>
        <td valign="top">
        <cfoutput>
        <table border=0 cellspacing=0 cellpadding=2 width=100%>
        <input type="hidden" name="item_exist" value="#item_exist#">
        <cfif #selected_item# neq 0>
           <cfquery username="#db_username#" password="#db_password#" name="get_highBid" datasource="#DATASOURCE#">
              SELECT bid
              FROM bids
              WHERE itemnum = #selected_item#  AND winner = 1
           </cfquery>
           <tr>
               <td><font size=2><b>Seller:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                 <select name="selected_user">
                   <cfloop query="get_users">
                    <option value="#user_id#"<cfif #selected_user# is #user_id#> selected</cfif>>#nickname# (#name#)</option>
                   </cfloop>
                 </select>
               </td>
           </tr>    
           <tr><td><font size=2><b>Item Number:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" readonly="true" name="selected_item" value="#selected_item#" size=8>&nbsp;<font size=2>(auto-generated)</font></td> 
           </tr>
           <tr>
               <td><font size=2><b>Listing Title:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#category1#">
               </td>
           </tr>
           <tr>
               <td><font size=2><b>Listing Type:</b></font></td>
               <td>&nbsp;</td>   
               <td>
			
                 <select name="selected_list_type">
                   <cfloop query="get_list_type">
                    <option value="#pair#"<cfif #list_type# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=2><b>Web Link:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="weblink" value="#weblink#" size=40>&nbsp;<font size=2>(Horse Website Link)</font></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr>            
           <tr><td><font size=2><b>Horse Name:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="name" value="#name#" size=40></td> 
           </tr>
           <tr><td><font size=2><b>Registration Number:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="registration" value="#registration#" size=20></td> 
           </tr>
           <tr><td><font size=2><b>Lifetime Earnings:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="earnings" value="#earnings#" size=20>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr><td><font size=2><b>Sire:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="sire" value="#sire#" size=40></td> 
           </tr>
           <tr><td><font size=2><b>Dam:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="dam" value="#dam#" size=40></td> 
           </tr>
           <tr>
               <td><font size=2><b>Primary Breed:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_pri_breed">
                   <cfloop query="get_breed">
                    <option value="#pair#"<cfif #pri_breed# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=2><b>Secondary Breed:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_sec_breed">
                   <option value="" <cfif #sec_breed# is ""> selected</cfif>>---Not Applicable---</option>
                   <cfloop query="get_breed">
                    <option value="#pair#" <cfif #sec_breed# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=2><b>Pure Breed:</b></font></td>
              <td>&nbsp;</td>
              <td><input type="checkbox" name="pure_breed" value="1"<cfif #pure_breed# is "1"> checked</cfif>><font size=2>&nbsp;cheked if Pure Breed</font></td> 
           </tr>
           <tr style="display:none;">
               <td><font size=2><b>Bloodline:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_bloodline">
                   <cfloop query="get_bloodline">
                    <option value="#pair#"<cfif #bloodline# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr style="display:none;"><td><font size=2><b>Year Foaled:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="year_foaled" value="#year_foaled#" size=10></td> 
           </tr>
           <tr>
               <td><font size=2><b>Color:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_color">
                   <cfloop query="get_color">
                    <option value="#pair#"<cfif #color# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=2><b>Date of Birth:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                   <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfset #the_month# = #datePart ("m", "#dob#")#>
                      <cfset #the_year# = #datePart ("yyyy", "#dob#")#>
                      <td>
                         <select name="dob_month">
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
                      <td><input name="dob_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
                     </tr>
                   </table>
                 </td>  
           </tr>
           <tr>
               <td><font size=2><b>Sex:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_sex">
                      <option value="S"<cfif #sex# is "S"> selected</cfif>>Stallion</option>
                      <option value="M"<cfif #sex# is "M"> selected</cfif>>Mare</option>
                      <option value="G"<cfif #sex# is "G"> selected</cfif>>Gelding</option>
                     </select>
               </td>
           </tr>
           <tr><td><font size=2><b>Height:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                 <select name="selected_height">
                   <cfloop query="get_height">
                    <option value="#pair#"<cfif #height# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td> 
           </tr>
           <tr>
               <td><font size=2><b>Discipline:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_discipline">
                   <cfloop query="get_discipline">
                    <option value="#pair#"<cfif #discipline# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=2><b>Experience:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_experience">
                   <cfloop query="get_experience">
                    <option value="#pair#"<cfif #experience# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=2><b>Attributes:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_attributes">
                   <cfloop query="get_attributes">
                    <option value="#pair#"<cfif #attributes# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=2><b>Temperament:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_temperament">
                   <cfloop query="get_temperament">
                    <option value="#pair#"<cfif #temperament# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>           
           <tr><td><font size=2><b>Nominations & Enrollments:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="nominations" rows=3 cols=50>#nominations#</textarea></td>
           </tr>
           <tr><td><font size=2><b>Comments:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="comments" rows=5 cols=50>#comments#</textarea></td>
           </tr>
           <tr><td><font size=2><b>Performance Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="performance" rows=5 cols=50>#performance#</textarea></td>
           </tr>
           <tr><td><font size=2><b>Produce Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="produce" rows=5 cols=50>#produce#</textarea></td>
           </tr>
           <tr><td><font size=2><b>Sire's Performace<br>and Produce Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="sire_performance" rows=5 cols=50>#sire_performance#</textarea></td>
           </tr>
           <tr><td><font size=2><b>Dam's Performance<br>and Produce Record:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="dam_performance" rows=3 cols=50>#dam_performance#</textarea></td>
           </tr>
           <tr><td><font size=2><b>Stallion Incentive<br>Enrollment Program:</b></font></td>
               <td>&nbsp;</td>                   
               <td><textarea name="stallion_incentive" rows=3 cols=50>#stallion_incentive#</textarea></td>
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr>            
           <tr><td><font size=2><b>Pedigree:</b></font></td>
               <td>&nbsp;</td>              
               <td valign="top">
                  <table cellspacing=0 cellpadding=0 border=0>
                    <tr>
                    <td valign="middle">
                       <input type="text" name="ped4" value="#ped4#" size=30><br>
                       <input type="text" name="ped5" value="#ped5#" size=30><br>
                       <input type="text" name="ped6" value="#ped6#" size=30><br>
                       <input type="text" name="ped7" value="#ped7#" size=30>
                    </td>
                    <td valign="top">
                       <input type="text" name="ped8" value="#ped8#" size=30><br>
                       <input type="text" name="ped9" value="#ped9#" size=30><br>
                       <input type="text" name="ped10" value="#ped10#" size=30><br>
                       <input type="text" name="ped11" value="#ped11#" size=30><br>
                       <input type="text" name="ped12" value="#ped12#" size=30><br>
                       <input type="text" name="ped13" value="#ped13#" size=30><br>
                       <input type="text" name="ped14" value="#ped14#" size=30><br>
                       <input type="text" name="ped15" value="#ped15#" size=30>
                    </td>
                    </tr>
                  </table>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr>            
           <tr bgcolor="gray"><td colspan=3 align="left"><font size=2 color="000000"><b><i>&nbsp;&nbsp;If this listing is for MARE will need this additional information:</i></b></font></td></tr>        
           <tr bgcolor="gray">
               <td><font size=2>&nbsp;&nbsp;In Foal:</font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_isfoal">
                      <option value="Y"<cfif #isfoal# is "Y"> selected</cfif>>Yes</option>
                      <option value="N"<cfif #isfoal# is "N"> selected</cfif>>No</option>
                    </select>
               </td>
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Last Bred Date:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="last_bred_date" value="#last_bred_date#" size=20></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <tr bgcolor="gray"><td colspan=3 align="left"><font size=2 color="000000"><b><i>&nbsp;&nbsp;If this listing is for STALLION STUD SERVICE will need this additional information:</b></i></font></td></tr>        
           <tr bgcolor="gray">
               <td><font size=2>&nbsp;&nbsp;Shipped Semen:</font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_shipped_semen">
                      <option value="A"<cfif #shipped_semen# is "A"> selected</cfif>>Available</option>
                      <option value="N"<cfif #shipped_semen# is "N"> selected</cfif>>Not Available</option>
                    </select>
               </td>
           </tr>
           <tr bgcolor="gray">
               <td><font size=2>&nbsp;&nbsp;Frozen Semen:</font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_frozen_semen">
                      <option value="A"<cfif #frozen_semen# is "A"> selected</cfif>>Available</option>
                      <option value="N"<cfif #frozen_semen# is "N"> selected</cfif>>Not Available</option>
                    </select>
               </td>
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Regualar Fee:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="regular_fee" value="#regular_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Shipped Semen Fee:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="shipped_semen_fee" value="#shipped_semen_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Int'l Shipped Semen Fee:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="intl_shipped_semen_fee" value="#intl_shipped_semen_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Counter-to-Counter Fee:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="counter_fee" value="#counter_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Booking Fee:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="booking_fee" value="#booking_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr bgcolor="gray"><td><font size=2>&nbsp;&nbsp;Mare Care per day:</font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="mare_care_fee" value="#mare_care_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <cfif #picture1# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs/#picture1#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 1:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture1" type="file" value="#picture1#" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture2# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs1/#picture2#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 2:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture2" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture3# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs2/#picture3#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 3:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture3" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture4# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs3/#picture4#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 4:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture4" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture5# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs4/#picture5#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 5:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture5" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <cfif #picture6# NEQ "">
              <tr><td colspan=2>&nbsp;</td><td><img src="../fullsize_thumbs5/#picture6#" border=1 height=120 width=120></td></tr>
           </cfif>   
		   <tr>
		       <td><font size=2><font size=2><b>Upload Image 6:</b></font></td>
               <td>&nbsp;</td>                   
  		       <td><input name="picture6" type="file" size=45 maxlength=250></td>
  		   </tr>    
           <tr><td><font size=2><b>Youtube/Video:</b></font><br><font size=1>(Paste your Youtube<br>embedded code here)</font><br></td>
               <td>&nbsp;</td>                   
               <td><textarea name="youtube" rows=5 cols=50>#youtube#</textarea></td>
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <tr>
               <td><font size=2><b>Location:</b></font></td>
               <td>&nbsp;</td>   
               <td>
                 <select name="selected_location">
                   <cfloop query="get_location">
                    <option value="#pair#"<cfif #location# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=2><b>City:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="city" value="#city#" size=20></td> 
           </tr>
           <tr>
               <td><font size=2><b>State:</font></td>
               <td>&nbsp;</td>
               <td>
          		  <CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                  SELECTNAME="state"
                  SELECTED="#state#"
                  MULTIPLE="0"
                  SIZE="1"
				  ANY="1">
               </td>
           </tr>
           <tr><td><font size=2><b>Province:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="province" value="#province#" size=20></td> 
           </tr>
           <tr>
               <td><font size=2><b>Country:</font></td>
               <td>&nbsp;</td>
               <td>
                  <CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1">
               </td>
           </tr>
           <tr><td><font size=2><b>Zip Code:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="zipcode" value="#zipcode#" size=20></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <tr><td><font size=2><b>Start Date:</b></font></td>
               <td>&nbsp;</td>                   
               <td>
                   <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfset #the_month# = #datePart ("m", "#date_start#")#>
                      <cfset #the_day# = #datePart ("d", "#date_start#")#>
                      <cfset #the_year# = #datePart ("yyyy", "#date_start#")#>
                      <cfset #the_time# = #timeFormat ("#date_start#", 'hh:mm')#>
                      <cfset #the_time_s# = #timeFormat ("#date_start#", 'tt')#>
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
               <td><font size=2><b>Auction Duration:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_duration">
                      <option value=7<cfif #duration# is 7> selected</cfif>>7 Days</option>
                      <option value=14<cfif #duration# is 14> selected</cfif>>14 Days</option>
                      <option value=30<cfif #duration# is 30> selected</cfif>>30 Days</option>
                       <!--- Jm 04/11/2013<option value=120<cfif #duration# is 120> selected</cfif>>120 Days</option>
                      <option value=150<cfif #duration# is 150> selected</cfif>>130 Days</option>
                      <option value=180<cfif #duration# is 180> selected</cfif>>150 Days</option>--->
                    </select>
               </td>
           </tr>
           <tr>
               <td><font size=2><b>Auto Relist:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                     <select name="selected_auto_relist">
                      <option value=0<cfif #auto_relist# is 0> selected</cfif>>Do not Relist</option>
                      <option value=1<cfif #auto_relist# is 1> selected</cfif>>(1) Time</option>
                      <option value=2<cfif #auto_relist# is 2> selected</cfif>>(2) Times</option>
                      <option value=3<cfif #auto_relist# is 3> selected</cfif>>(3) Times</option>
                      <option value=4<cfif #auto_relist# is 4> selected</cfif>>(4) Times</option>
                      <option value=5<cfif #auto_relist# is 5> selected</cfif>>(5) Times</option>
                      <option value=6<cfif #auto_relist# is 6> selected</cfif>>(6) Time</option>
                      <option value=7<cfif #auto_relist# is 7> selected</cfif>>(7) Times</option>
                      <option value=8<cfif #auto_relist# is 8> selected</cfif>>(8) Times</option>
                      <option value=9<cfif #auto_relist# is 9> selected</cfif>>(9) Times</option>
                      <option value=10<cfif #auto_relist# is 10> selected</cfif>>(10) Times</option>
                    </select>&nbsp;<font size=2>(Times to Relist if not sold)</font>
               </td>
           </tr>           
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <tr id="trBUY" style="display: table-row;">
               <td><font size=2><b>Unit Price:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="buynow_price" value="#buynow_price#" size=10>&nbsp;<font size=2>in USD</td> 
           </tr>
           <tr><td><font size=2><b>Reserve Bid:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="reserve_bid" value="#reserve_bid#" size=10>&nbsp;<font size=2>in USD</td> 
           </tr>
           <tr id="trMIN" style="display: table-row;">
               <td><font size=2><b>Minimum Bid:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="minimum_bid" value="#minimum_bid#" size=10>&nbsp;<font size=2>in USD</td> 
           </tr>
           <tr id="trMAX" style="display: none;">
               <td><font size=2><b>Maximum Bid:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="maximum_bid" value="#maximum_bid#" size=10>&nbsp;<font size=2>in USD</td> 
           </tr>
           <tr><td><font size=2><b>Bid Increment/Decrement:</b></font></td>
               <td>&nbsp;</td>                   
                   <td>
                     <select name="selected_increment">
                      <option value=1.00<cfif #increment_valu# is 1.00> selected</cfif>>1.00</option>
                      <option value=2.00<cfif #increment_valu# is 2.00> selected</cfif>>2.00</option>
                      <option value=5.00<cfif #increment_valu# is 5.00> selected</cfif>>5.00</option>
                      <option value=10.00<cfif #increment_valu# is 10.00> selected</cfif>>10.00</option>
                      <option value=20.00<cfif #increment_valu# is 20.00> selected</cfif>>20.00</option>
                      <option value=50.00<cfif #increment_valu# is 50.00> selected</cfif>>50.00</option>
                      <option value=100.00<cfif #increment_valu# is 100.00> selected</cfif>>100.00</option>
                      <option value=500.00<cfif #increment_valu# is 500.00> selected</cfif>>500.00</option>
                      <option value=1000.00<cfif #increment_valu# is 1000.00> selected</cfif>>1,000.00</option>
                    </select>&nbsp;<font size=2>in USD</font>
               </td> 
           </tr>
           <!--------------terms-of-sale--------------->
           <tr id="tr1" style="display:table-row;"><td><font size=2><b>Terms of Sales and<br>Shipping Info:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="button" name="submit" value="Click Here" onClick="get_terms(1)"></td>
           </tr>
           <tr id="tr2" style="display:none;">
              <td colspan=3 align="center">
				<table width="100%" border=0 cellspacing=0 cellpadding=0>
				    <tr><td><hr size=1 color="616362"></td></tr>
					<tr><td><font size=2><b>Terms of Sales & Shipping Info</b>&nbsp;(You can paste/type document here)</font></td></tr>
					<tr><td><textarea name="terms" value="#terms#" cols=96 rows=24>#terms#</textarea></td></tr>    
					<tr height=10><td></td></tr>    
					<tr><td align="center"><input type="button" name="terms" value=" Close & Continue " onClick="get_terms(0)"></td></tr>
				</table>
              </td>
           </tr>           
           <!--------------end-terms-of-sale----------->
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <tr><td><font size=2><b>Shipping Fee:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="shipping_fee" value="#shipping_fee#" size=10>&nbsp;<font size=2>in USD</font></td> 
           </tr>
           <tr style="display:none;"><td><font size=2><b>Sales Tax:</b></font></td>
               <td>&nbsp;</td>                   
               <td><input type="text" name="salestax" value="#salestax#" size=10>&nbsp;<font size=2>%</font></td> 
           </tr>
           
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           <tr><td><font size=2><b>Status:</b></font></td>
              <td>&nbsp;</td>
              <td><input type="checkbox" name="status" value="1"<cfif #status# is "1"> checked</cfif>><font size=2>&nbsp;Listing is active</font></td> 
           </tr>
           <tr><td colspan=3><hr size=1 color="gray" width=100%></td></tr> 
           </table>
           
        </cfif>
        <tr><td colspan=3>
            <cfif #selected_item# eq 0><input type="submit" name="submit" value="Add"></cfif>
            <cfif #selected_item# eq 0><input type="submit" name="submit" value="Retrieve"></cfif>
            <cfif #selected_item# gt 0><input type="submit" name="submit" value="Save" onClick="return val_entries()"></cfif>   
            <cfif #selected_item# gt 0 AND #item_exist# eq 1><input type="submit" name="submit" value="Delete" onClick="return confirm('Please Confirm?')"></cfif>   
            <cfif #selected_item# gt 0><input type="submit" name="submit" value="Back"></cfif>   
            <cfif #selected_item# eq 0><br><font size=1>Press Add to enter new item. Or Select an<br>item from the List and click <b>Retrieve</b></font></cfif>
            <br><br>
        </td></tr>          
        </table>                
        </form>
        </table>  
        </cfoutput>  
        </td></tr>
       </td>
      </tr>
     </table>
    </center>
   </font>
 </body>
</html>
