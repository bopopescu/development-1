<!--- Set this for large image file uploads --->
<!---<cfsetting requesttimeout="300">--->

<!--- SourceSafe $Logfile: /Visual-Auction-4/sell/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
<cfelse>
   <cflocation url="#VAROOT#/login.cfm?login=1" addtoken="No">
</cfif>

<cfif #isDefined ("submit")# is 0>
   <cfset submit = 0>
</cfif>
<cfif #trim(submit)# is "<< Back">
   <cflocation url="#VAROOT#/listings/index.cfm?curr_cat=#curr_cat#&curr_lvl=0&from_search=0">
</cfif>

<!-------------upload image #1---------------->
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs/")>
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
  <cfset picture1 = file.ServerFile>
  <!--- Note: "name" attribute for the cfimage tag should be a new variable name which the coldfusion server will use to create a struct containing information such as colormodel, height, source, etc... about the image.  Use cfdump for the variable name see see all the attributes. --->
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="cfimage_picture_1" WIDTH="#resizedImageWidth#" HEIGHT="" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture1#")>
        <cffile action="rename"
          SOURCE = "#directory##picture1#"
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture1 = "#itemnum#.jpg">
<cfelse>
  <cfset picture1 = "">
</cfif>
<!-------------upload image #2---------------->
<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs1/")>
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
  <cfset picture2 = File.ServerFile>
  <!--- Note: "name" attribute for the cfimage tag should be a new variable name which the coldfusion server will use to create a struct containing information such as colormodel, height, source, etc... about the image.  Use cfdump for the variable name see see all the attributes. --->
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="cfimage_picture_2" WIDTH="#resizedImageWidth#" HEIGHT="" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture2#")>
        <cffile action="rename"
          SOURCE = "#directory##picture2#"
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture2 = "#itemnum#.jpg">
<cfelse>
  <cfset picture2 = "">
</cfif>
<!-------------upload image #3---------------->
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs2/")>
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
  <cfset picture3 = File.ServerFile>
  <!--- Note: "name" attribute for the cfimage tag should be a new variable name which the coldfusion server will use to create a struct containing information such as colormodel, height, source, etc... about the image.  Use cfdump for the variable name see see all the attributes. --->
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="cfimage_picture_3" WIDTH="#resizedImageWidth#" HEIGHT="" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture3#")>
        <cffile action="rename"
          SOURCE = "#directory##picture3#"
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture3 = "#itemnum#.jpg">
<cfelse>
  <cfset picture3 = "">
</cfif>
<!-------------upload image #4---------------->
<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs3/")>
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
  <cfset picture4 = File.ServerFile>
  <!--- Note: "name" attribute for the cfimage tag should be a new variable name which the coldfusion server will use to create a struct containing information such as colormodel, height, source, etc... about the image.  Use cfdump for the variable name see see all the attributes. --->
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="cfimage_picture_4" WIDTH="#resizedImageWidth#" HEIGHT="" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture4#")>
        <cffile action="rename"
          SOURCE = "#directory##picture4#"
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture4 = "#itemnum#.jpg">
<cfelse>
  <cfset picture4 = "">
</cfif>
<!-------------upload image #5---------------->
<cfif isdefined("form.picture5") and form.picture5 is not "">
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs4/")>
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
  <cfset picture5 = File.ServerFile>
  <!--- Note: "name" attribute for the cfimage tag should be a new variable name which the coldfusion server will use to create a struct containing information such as colormodel, height, source, etc... about the image.  Use cfdump for the variable name see see all the attributes. --->
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="cfimage_picture_5" WIDTH="#resizedImageWidth#" HEIGHT="" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture5#")>
        <cffile action="rename"
          SOURCE = "#directory##picture5#"
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture5 = "#itemnum#.jpg">
<cfelse>
  <cfset picture5 = "">
</cfif>
<!-------------upload image #6---------------->
<cfif isdefined("form.picture6") and form.picture6 is not "">
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs5/")>
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
  <cfset picture6 = File.ServerFile>
  <!--- Note: "name" attribute for the cfimage tag should be a new variable name which the coldfusion server will use to create a struct containing information such as colormodel, height, source, etc... about the image.  Use cfdump for the variable name see see all the attributes. --->
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="cfimage_picture_6" WIDTH="#resizedImageWidth#" HEIGHT="" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture6#")>
        <cffile action="rename"
          SOURCE = "#directory##picture6#"
          DESTINATION = "#directory##itemnum#.jpg">
      </cfif>
  <cfset picture6 = "#itemnum#.jpg">
<cfelse>
  <cfset picture6 = "">
</cfif>

<cfif isDefined("itemnum")>
   <cfset itemnum = itemnum>
<cfelse>
   <cfset itemnum = EPOCH>
</cfif>
<cfif isDefined("gencat")>
   <cfset gencat = gencat>
<cfelse>
   <cfset gencat = "S">
</cfif>
<cfif isDefined("category1")>
   <cfset category1 = category1>
<cfelse>
   <cfif isDefined("session.category1") AND submit NEQ 0>
      <cfset category1 = session.category1>
   <cfelse>
      <cfset category1 = curr_cat>
   </cfif>
</cfif>
<cfif isDefined("selected_auction_type")>
   <cfset auction_type = selected_auction_type>
<cfelse>
   <cfif isDefined("session.auction_type") AND submit NEQ 0>
      <cfset auction_type = session.auction_type>
   <cfelse>
      <cfset auction_type = "E">
   </cfif>
</cfif>
<cfif isDefined("selected_auction_mode") is "">
   <cfset auction_mode = selected_auction_mode>
<cfelse>
   <cfif isDefined("session.auction_mode") AND submit NEQ 0>
      <cfset auction_mode = session.auction_mode>
   <cfelse>
      <cfset auction_mode = 0>
   </cfif>
</cfif>
<cfif isDefined("name")>
   <cfset name = name>
<cfelse>
   <cfif isDefined("session.name") AND submit NEQ 0>
      <cfset name = session.name>
   <cfelse>
      <cfset name = "">
   </cfif>
</cfif>
<cfif isDefined("registration")>
   <cfset registration = registration>
<cfelse>
   <cfif isDefined("session.registration") AND submit NEQ 0>
      <cfset registration = session.registration>
   <cfelse>
      <cfset registration = "">
   </cfif>
</cfif>
<cfif isDefined("sire")>
   <cfset sire = sire>
<cfelse>
   <cfif isDefined("session.sire") AND submit NEQ 0>
      <cfset sire = session.sire>
   <cfelse>
      <cfset sire = "">
   </cfif>
</cfif>
<cfif isDefined("dam")>
   <cfset dam = dam>
<cfelse>
   <cfif isDefined("session.dam") AND submit NEQ 0>
      <cfset dam = session.dam>
   <cfelse>
      <cfset dam = "">
   </cfif>
</cfif>
<cfif isDefined("selected_pri_breed")>
   <cfset pri_breed = selected_pri_breed>
<cfelse>
   <cfif isDefined("session.pri_breed") AND submit NEQ 0>
      <cfset pri_breed = session.pri_breed>
   <cfelse>
      <cfset pri_breed = "Not Disclosed">
   </cfif>
</cfif>
<cfif isDefined("selected_sec_breed")>
   <cfset sec_breed = selected_sec_breed>
<cfelse>
   <cfif isDefined("session.sec_breed") AND submit NEQ 0>
      <cfset sec_breed = session.sec_breed>
   <cfelse>
      <cfset sec_breed = "Not Disclosed">
   </cfif>
</cfif>
<!---
<cfif isDefined("pure_breed")>
    <cfset pure_breed = 1>
<cfelse>
    <cfset pure_breed = 0>
</cfif>
--->
<cfif isDefined("selected_bloodline")>
   <cfset bloodline = selected_bloodline>
<cfelse>
   <cfif isDefined("session.bloodline") and submit neq 0>
      <cfset bloodline = session.bloodline>
   <cfelse>
      <cfset bloodline = "Not Disclosed">
   </cfif>
</cfif>
<cfif isDefined("year_foaled")>
   <cfset year_foaled = year_foaled>
<cfelse>
   <cfif isDefined("session.year_foaled") and submit neq 0>
      <cfset year_foaled = session.year_foaled>
   <cfelse>
      <cfset year_foaled = "">
   </cfif>
</cfif>
<cfif isDefined("selected_color")>
   <cfset color = selected_color>
<cfelse>
   <cfif isDefined("session.color") and submit neq 0>
      <cfset color = session.color>
   <cfelse>
      <cfset color = "">
   </cfif>
</cfif>
<cfif isDefined("dob")>
   <cfset dob = dob>
<cfelse>
   <cfif isDefined("session.dob") and submit neq 0>
      <cfset dob = session.dob>
   <cfelse>
      <cfset dob = "#dateAdd("yyyy", -10, TIMENOW)#">
   </cfif>
</cfif>
<cfif isDefined("selected_sex")>
   <cfset sex = selected_sex>
<cfelse>
   <cfif isDefined("session.sex") and submit neq 0>
      <cfset sex = session.sex>
   <cfelse>
      <cfset sex = "">
   </cfif>
</cfif>
<cfif isDefined("selected_height")>
   <cfset height = selected_height>
<cfelse>
   <cfif isDefined("session.height") and submit neq 0>
      <cfset height = session.height>
   <cfelse>
      <cfset height = "">
   </cfif>
</cfif>
<cfif isDefined("selected_discipline")>
   <cfset discipline = selected_discipline>
<cfelse>
   <cfif isDefined("session.discipline") and submit neq 0>
      <cfset discipline = session.discipline>
   <cfelse>
      <cfset discipline = "Not Disclosed">
   </cfif>
</cfif>
<cfif isDefined("selected_experience")>
   <cfset experience = selected_experience>
<cfelse>
   <cfif isDefined("session.experience") and submit neq 0>
      <cfset experience = session.experience>
   <cfelse>
      <cfset experience = "Not Disclosed">
   </cfif>
</cfif>
<cfif isDefined("selected_attributes")>
   <cfset attributes = selected_attributes>
<cfelse>
   <cfif isDefined("session.attributes") and submit neq 0>
      <cfset attributes = session.attributes>
   <cfelse>
      <cfset attributes = "Not Disclosed">
   </cfif>
</cfif>
<cfif isDefined("selected_temperament")>
   <cfset temperament = selected_temperament>
<cfelse>
   <cfif isDefined("session.temperament") and submit neq 0>
      <cfset temperament = session.temperament>
   <cfelse>
      <cfset temperament = "Not Disclosed">
   </cfif>
</cfif>
<cfif isDefined("nominations")>
   <cfset nominations = nominations>
<cfelse>
   <cfif isDefined("session.nominations") and submit neq 0>
      <cfset nominations = session.nominations>
   <cfelse>
      <cfset nominations = "">
   </cfif>
</cfif>
<!--- JM <cfif isDefined("location")>
   <cfset location = selected_location>
<cfelse>
   <cfif isDefined("session.location") and submit neq 0>
      <cfset location = session.location>
   <cfelse>
      <cfset location = "">
   </cfif>
</cfif>--->
<cfif isDefined("city")>
   <cfset city = city>
<cfelse>
   <cfif isDefined("session.city") and submit neq 0>
      <cfset city = session.city>
   <cfelse>
      <cfset city = "">
   </cfif>
</cfif>
<cfif isDefined("state")>
   <cfset state = state>
<cfelse>
   <cfif isDefined("session.state") and submit neq 0>
      <cfset state = session.state>
   <cfelse>
      <cfset state = "">
   </cfif>
</cfif>
<cfif isDefined("province")>
   <cfset province = province>
<cfelse>
   <cfif isDefined("session.province") and submit neq 0>
      <cfset province = session.province>
   <cfelse>
      <cfset province = "">
   </cfif>
</cfif>
<cfif isDefined("zipcode")>
   <cfset zipcode = zipcode>
<cfelse>
   <cfif isDefined("session.zipcode") and submit neq 0>
      <cfset zipcode = session.zipcode>
   <cfelse>
      <cfset zipcode = "">
   </cfif>
</cfif>
<cfif isDefined("country")>
   <cfset country = country>
<cfelse>
   <cfif isDefined("session.country") and submit neq 0>
      <cfset country = session.country>
   <cfelse>
      <cfset country = "USA">
   </cfif>
</cfif>
<cfif isDefined("comments")>
   <cfset comments = comments>
<cfelse>
   <cfif isDefined("session.comments") and submit neq 0>
      <cfset comments = session.comments>
   <cfelse>
      <cfset comments = "">
   </cfif>
</cfif>
<cfif isDefined("selected_isfoal")>
   <cfset isfoal = selected_isfoal>
<cfelse>
   <cfif isDefined("session.isfoal") and submit neq 0>
      <cfset isfoal = session.isfoal>
   <cfelse>
      <cfset isfoal = "N">
   </cfif>
</cfif>
<cfif isDefined("last_bred_date")>
   <cfset last_bred_date = last_bred_date>
<cfelse>
   <cfif isDefined("session.last_bred_date") and submit neq 0>
      <cfset last_bred_date = session.last_bred_date>
   <cfelse>
      <cfset last_bred_date = "">
   </cfif>
</cfif>
<cfif isDefined("regular_fee")>
   <cfset regular_fee = regular_fee>
<cfelse>
   <cfif isDefined("session.regular_fee") and submit neq 0>
      <cfset regular_fee = session.regular_fee>
   <cfelse>
      <cfset regular_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("selected_shipped_semen")>
   <cfset shipped_semen = selected_shipped_semen>
<cfelse>
   <cfif isDefined("session.shipped_semen") and submit neq 0>
      <cfset shipped_semen = session.shipped_semen>
   <cfelse>
      <cfset shipped_semen = "N">
   </cfif>
</cfif>
<cfif isDefined("selected_frozen_semen")>
   <cfset frozen_semen = selected_frozen_semen>
<cfelse>
   <cfif isDefined("session.frozen_semen") and submit neq 0>
      <cfset frozen_semen = session.frozen_semen>
   <cfelse>
      <cfset frozen_semen = "N">
   </cfif>
</cfif>
<cfif isDefined("shipped_semen_fee")>
   <cfset shipped_semen_fee = shipped_semen_fee>
<cfelse>
   <cfif isDefined("session.shipped_semen_fee") and submit neq 0>
      <cfset shipped_semen_fee = session.shipped_semen_fee>
   <cfelse>
      <cfset shipped_semen_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("intl_shipped_semen_fee")>
   <cfset intl_shipped_semen_fee = intl_shipped_semen_fee>
<cfelse>
   <cfif isDefined("session.intl_shipped_semen_fee") and submit neq 0>
      <cfset intl_shipped_semen_fee = session.intl_shipped_semen_fee>
   <cfelse>
      <cfset intl_shipped_semen_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("booking_fee")>
   <cfset booking_fee = booking_fee>
<cfelse>
   <cfif isDefined("session.booking_fee") and submit neq 0>
      <cfset booking_fee = session.booking_fee>
   <cfelse>
      <cfset booking_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("counter_fee")>
   <cfset counter_fee = counter_fee>
<cfelse>
   <cfif isDefined("session.counter_fee") and submit neq 0>
      <cfset counter_fee = session.counter_fee>
   <cfelse>
      <cfset counter_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("mare_care_fee")>
   <cfset mare_care_fee = mare_care_fee>
<cfelse>
   <cfif isDefined("session.mare_care_fee") and submit neq 0>
      <cfset mare_care_fee = session.mare_care_fee>
   <cfelse>
      <cfset mare_care_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("performance")>
   <cfset performance = performance>
<cfelse>
   <cfif isDefined("session.performance") and submit neq 0>
      <cfset performance = session.performance>
   <cfelse>
      <cfset performance = "">
   </cfif>
</cfif>
<cfif isDefined("produce")>
   <cfset produce = produce>
<cfelse>
   <cfif isDefined("session.produce") and submit neq 0>
      <cfset produce = session.produce>
   <cfelse>
      <cfset produce = "">
   </cfif>
</cfif>
<cfif isDefined("sire_performance")>
   <cfset sire_performance = sire_performance>
<cfelse>
   <cfif isDefined("session.sire_performance") and submit neq 0>
      <cfset sire_performance = session.sire_performance>
   <cfelse>
      <cfset sire_performance = "">
   </cfif>
</cfif>
<cfif isDefined("dam_performance")>
   <cfset dam_performance = dam_performance>
<cfelse>
   <cfif isDefined("session.dam_performance") and submit neq 0>
      <cfset dam_performance = session.dam_performance>
   <cfelse>
      <cfset dam_performance = "">
   </cfif>
</cfif>
<cfif isDefined("stallion_incentive")>
   <cfset stallion_incentive = stallion_incentive>
<cfelse>
   <cfif isDefined("session.stallion_incentive") and submit neq 0>
      <cfset stallion_incentive = session.stallion_incentive>
   <cfelse>
      <cfset stallion_incentive = "">
   </cfif>
</cfif>
<cfif isDefined("date_start")>
   <cfset date_start = date_start>
<cfelse>
   <cfif isDefined("session.date_start") and submit neq 0>
      <cfset date_start = session.date_start>
   <cfelse>
      <cfset date_start = TIMENOW>
   </cfif>
</cfif>
<cfif isDefined("date_end")>
   <cfset date_end = date_end>
<cfelse>
   <cfif isDefined("session.date_end") and submit neq 0>
      <cfset date_end = session.date_end>
   <cfelse>
      <cfset date_end = TIMENOW>
   </cfif>
</cfif>
<cfif isDefined("duration")>
   <cfset duration = selected_duration>
<cfelse>
   <cfif isDefined("session.duration") and submit neq 0>
      <cfset duration = session.duration>
   <cfelse>
      <cfset duration = 30>
   </cfif>
</cfif>
<cfif isDefined("auto_relist")>
   <cfset auto_relist = selected_auto_relist>
<cfelse>
   <cfif isDefined("session.auto_relist") and submit neq 0>
      <cfset auto_relist = session.auto_relist>
   <cfelse>
      <cfset auto_relist = 0>
   </cfif>
</cfif>
<cfif isDefined("minimum_bid")>
   <cfset minimum_bid = minimum_bid>
<cfelse>
   <cfif isDefined("session.minimum_bid") and submit neq 0>
      <cfset minimum_bid = session.minimum_bid>
   <cfelse>
      <cfset minimum_bid = 0.00>
   </cfif>
</cfif>
<cfif isDefined("maximum_bid")>
   <cfset maximum_bid = maximum_bid>
<cfelse>
   <cfif isDefined("session.maximum_bid") and submit neq 0>
      <cfset maximum_bid = session.maximum_bid>
   <cfelse>
      <cfset maximum_bid = 0.00>
   </cfif>
</cfif>
<cfif isDefined("reserve_bid")>
   <cfset reserve_bid = reserve_bid>
<cfelse>
   <cfif isDefined("session.reserve_bid") and submit neq 0>
      <cfset reserve_bid = session.reserve_bid>
   <cfelse>
      <cfset reserve_bid = 0.00>
   </cfif>
</cfif>
<cfif isDefined("selected_increment_valu")>
   <cfset increment_valu = selected_increment_valu>
<cfelse>
   <cfif isDefined("session.increment_valu") and submit neq 0>
      <cfset increment_valu = session.increment_valu>
   <cfelse>
      <cfset increment_valu = 100.00>
   </cfif>
</cfif>
<cfif isDefined("buynow_price")>
   <cfset buynow_price = buynow_price>
<cfelse>
   <cfif isDefined("session.buynow_price") and submit neq 0>
      <cfset buynow_price = session.buynow_price>
   <cfelse>
      <cfset buynow_price = 0.00>
   </cfif>
</cfif>
<cfif isDefined("shipping_fee")>
   <cfset shipping_fee = shipping_fee>
<cfelse>
   <cfif isDefined("session.shipping_fee") and submit neq 0>
      <cfset shipping_fee = session.shipping_fee>
   <cfelse>
      <cfset shipping_fee = 0.00>
   </cfif>
</cfif>
<cfif isDefined("salestax")>
   <cfset salestax = salestax>
<cfelse>
   <cfif isDefined("session.salestax") and submit neq 0>
      <cfset salestax = session.salestax>
   <cfelse>
      <cfset salestax = 0>
   </cfif>
</cfif>
<cfif isDefined("dollar_type")>
   <cfset dollar_type = selected_dollar_type>
<cfelse>
   <cfif isDefined("session.dollar_type") and submit neq 0>
      <cfset dollar_type = session.dollar_type>
   <cfelse>
      <cfset dollar_type = "">
   </cfif>
</cfif>
<cfif isDefined("terms")>
   <cfset terms = terms>
<cfelse>
   <cfif isDefined("session.terms") and submit neq 0>
      <cfset terms = session.terms>
   <cfelse>
      <cfset terms = "">
   </cfif>
</cfif>
<cfif isDefined("youtube")>
   <cfset youtube = youtube>
<cfelse>
   <cfif isDefined("session.youtube") and submit neq 0>
      <cfset youtube = session.youtube>
   <cfelse>
      <cfset youtube = "">
   </cfif>
</cfif>
<cfif isDefined("selected_list_type")>
   <cfset list_type = selected_list_type>
<cfelse>
   <cfif isDefined("session.list_type") and submit neq 0>
      <cfset list_type = session.list_type>
   <cfelse>
      <cfset list_type = "Horse for Sale">
   </cfif>
</cfif>
<cfif isDefined("earnings")>
   <cfset earnings = earnings>
<cfelse>
   <cfif isDefined("session.earnings") and submit neq 0>
      <cfset earnings = session.earnings>
   <cfelse>
      <cfset earnings = 0.00>
   </cfif>
</cfif>
<cfif isDefined("weblink")>
   <cfset weblink = weblink>
<cfelse>
   <cfif isDefined("session.weblink") and submit neq 0>
      <cfset weblink = session.weblink>
   <cfelse>
      <cfset weblink = "">
   </cfif>
</cfif>
<cfif isDefined("ped4")>
   <cfset ped4 = ped4>
<cfelse>
   <cfif isDefined("session.ped4") and submit neq 0>
      <cfset ped4 = session.ped4>
   <cfelse>
      <cfset ped4 = "">
   </cfif>
</cfif>
<cfif isDefined("ped5")>
   <cfset ped5 = ped5>
<cfelse>
   <cfif isDefined("session.ped5") and submit neq 0>
      <cfset ped5 = session.ped5>
   <cfelse>
      <cfset ped5 = "">
   </cfif>
</cfif>
<cfif isDefined("ped6")>
   <cfset ped6 = ped6>
<cfelse>
   <cfif isDefined("session.ped6") and submit neq 0>
      <cfset ped6 = session.ped6>
   <cfelse>
      <cfset ped6 = "">
   </cfif>
</cfif>
<cfif isDefined("ped7")>
   <cfset ped7 = ped7>
<cfelse>
   <cfif isDefined("session.ped7") and submit neq 0>
      <cfset ped7 = session.ped7>
   <cfelse>
      <cfset ped7 = "">
   </cfif>
</cfif>
<cfif isDefined("ped8")>
   <cfset ped8 = ped8>
<cfelse>
   <cfif isDefined("session.ped8") and submit neq 0>
      <cfset ped8 = session.ped8>
   <cfelse>
      <cfset ped8 = "">
   </cfif>
</cfif>
<cfif isDefined("ped9")>
   <cfset ped9 = ped9>
<cfelse>
   <cfif isDefined("session.ped9") and submit neq 0>
      <cfset ped9 = session.ped9>
   <cfelse>
      <cfset ped9 = "">
   </cfif>
</cfif>
<cfif isDefined("ped10")>
   <cfset ped10 = ped10>
<cfelse>
   <cfif isDefined("session.ped10") and submit neq 0>
      <cfset ped10 = session.ped10>
   <cfelse>
      <cfset ped10 = "">
   </cfif>
</cfif>
<cfif isDefined("ped11")>
   <cfset ped11 = ped11>
<cfelse>
   <cfif isDefined("session.ped11") and submit neq 0>
      <cfset ped11 = session.ped11>
   <cfelse>
      <cfset ped11 = "">
   </cfif>
</cfif>
<cfif isDefined("ped12")>
   <cfset ped12 = ped12>
<cfelse>
   <cfif isDefined("session.ped12") and submit neq 0>
      <cfset ped12 = session.ped12>
   <cfelse>
      <cfset ped12 = "">
   </cfif>
</cfif>
<cfif isDefined("ped13")>
   <cfset ped13 = ped13>
<cfelse>
   <cfif isDefined("session.ped13") and submit neq 0>
      <cfset ped13 = session.ped13>
   <cfelse>
      <cfset ped13 = "">
   </cfif>
</cfif>
<cfif isDefined("ped14")>
   <cfset ped14 = ped14>
<cfelse>
   <cfif isDefined("session.ped14") and submit neq 0>
      <cfset ped14 = session.ped14>
   <cfelse>
      <cfset ped14 = "">
   </cfif>
</cfif>
<cfif isDefined("ped15")>
   <cfset ped15 = ped15>
<cfelse>
   <cfif isDefined("session.ped15") and submit neq 0>
      <cfset ped15 = session.ped15>
   <cfelse>
      <cfset ped15 = "">
   </cfif>
</cfif>
<cfif isDefined("pay_morder_ccheck")>
    <cfset pay_morder_ccheck = 1>
<cfelse>
    <cfset pay_morder_ccheck = 0>
</cfif>
<cfif isDefined("pay_am_express")>
    <cfset pay_am_express = 1>
<cfelse>
    <cfset pay_am_express = 0>
</cfif>
<cfif isDefined("pay_cod")>
    <cfset pay_cod = 1>
<cfelse>
    <cfset pay_cod = 0>
</cfif>
<cfif isDefined("pay_discover")>
    <cfset pay_discover = 1>
<cfelse>
    <cfset pay_discover = 0>
</cfif>
<cfif isDefined("pay_pcheck")>
    <cfset pay_pcheck = 1>
<cfelse>
    <cfset pay_pcheck = 0>
</cfif>
<cfif isDefined("pay_ol_escrow")>
    <cfset pay_ol_escrow = 1>
<cfelse>
    <cfset pay_ol_escrow = 0>
</cfif>
<cfif isDefined("pay_visa_mc")>
    <cfset pay_visa_mc = 1>
<cfelse>
    <cfset pay_visa_mc = 0>
</cfif>
<cfif isDefined("pay_other")>
    <cfset pay_other = 1>
<cfelse>
    <cfset pay_other = 0>
</cfif>
<cfif isDefined("pay_see_desc")>
    <cfset pay_see_desc = 1>
<cfelse>
    <cfset pay_see_desc = 0>
</cfif>
<cfif isDefined("ship_sell_pays")>
    <cfset ship_sell_pays = 1>
<cfelse>
    <cfset ship_sell_pays = 0>
</cfif>
<cfif isDefined("ship_buy_pays_act")>
    <cfset ship_buy_pays_act = 1>
<cfelse>
    <cfset ship_buy_pays_act = 0>
</cfif>
<cfif isDefined("ship_buy_pays_fxd")>
    <cfset ship_buy_pays_fxd = 1>
<cfelse>
    <cfset ship_buy_pays_fxd = 0>
</cfif>
<cfif isDefined("ship_international")>
    <cfset ship_international = 1>
<cfelse>
    <cfset ship_international = 0>
</cfif>
<cfif isDefined("ship_see_desc")>
    <cfset ship_see_desc = 1>
<cfelse>
    <cfset ship_see_desc = 0>
</cfif>
<cfif trim(submit) is "Next >>">
   <cfset start_time = "#start_time##start_time_s#">
   <cfset start_hour = timeFormat (start_time, 'H')>
   <cfset start_min = timeFormat (start_time, 'm')>
   <cfset date_start = createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)>
   <cfset date_end = dateAdd ("d", selected_duration, date_start)>
   <cfset dob = createDateTime (dob_year, dob_month, start_day, start_hour, start_min, 0)>

   <!---<cfset session.category = category>--->
   <cfset session.category1 = category1>
   <cfset session.auction_type = auction_type>
   <cfset session.auction_mode = auction_mode>
   <cfset session.name = name>
   <cfset session.registration = registration>
   <cfset session.sire = sire>
   <cfset session.dam = dam>
   <cfset session.pri_breed = pri_breed>
   <cfset session.sec_breed = sec_breed>
   <!---
   <cfset session.pure_breed = pure_breed>
   --->
   <cfset session.bloodline = bloodline>
   <cfset session.year_foaled = year_foaled>
   <cfset session.color = color>
   <cfset session.dob = dob>
   <cfset session.sex = sex>
   <cfset session.height = height>
   <cfset session.discipline = discipline>
   <cfset session.experience = experience>
   <cfset session.attributes = attributes>
   <cfset session.temperament = temperament>
   <cfset session.nominations = nominations>
   <!--- JM <cfset session.location = location>--->
   <cfset session.city = city>
   <cfset session.state = state>
   <cfset session.province = province>
   <cfset session.country = country>
   <cfset session.zipcode = zipcode>
   <cfset session.comments = comments>
   <cfset session.isfoal = isfoal>
   <cfset session.last_bred_date = last_bred_date>
   <cfset session.regular_fee = regular_fee>
   <cfset session.shipped_semen = shipped_semen>
   <cfset session.frozen_semen = frozen_semen>
   <cfset session.shipped_semen_fee = shipped_semen_fee>
   <cfset session.intl_shipped_semen_fee = intl_shipped_semen_fee>
   <cfset session.booking_fee = booking_fee>
   <cfset session.counter_fee = counter_fee>
   <cfset session.mare_care_fee = mare_care_fee>
   <cfset session.performance = performance>
   <cfset session.produce = produce>
   <cfset session.sire_performance = sire_performance>
   <cfset session.dam_performance = dam_performance>
   <cfset session.stallion_incentive = stallion_incentive>
   <cfset session.date_start = date_start>
   <cfset session.date_end = date_end>
   <cfset session.duration = duration>
   <cfset session.auto_relist = auto_relist>
   <cfset session.minimum_bid = minimum_bid>
   <cfset session.maximum_bid = maximum_bid>
   <cfset session.reserve_bid = reserve_bid>
   <cfset session.increment_valu = increment_valu>
   <cfset session.buynow_price = buynow_price>
   <cfset session.shipping_fee = shipping_fee>
   <cfset session.salestax = salestax>
   <cfset session.dollar_type = dollar_type>
   <cfset session.terms = terms>
   <cfset session.picture1 = picture1>
   <cfset session.picture2 = picture2>
   <cfset session.picture3 = picture3>
   <cfset session.picture4 = picture4>
   <cfset session.picture5 = picture5>
   <cfset session.picture6 = picture6>
   <cfset session.youtube = youtube>
   <cfset session.list_type = list_type>
   <cfset session.earnings = earnings>
   <cfset session.weblink = weblink>
   <cfset session.ped4 = ped4>
   <cfset session.ped5 = ped5>
   <cfset session.ped6 = ped6>
   <cfset session.ped7 = ped7>
   <cfset session.ped8 = ped8>
   <cfset session.ped9 = ped9>
   <cfset session.ped10 = ped10>
   <cfset session.ped11 = ped11>
   <cfset session.ped12 = ped12>
   <cfset session.ped13 = ped13>
   <cfset session.ped14 = ped14>
   <cfset session.ped15 = ped15>
   <cfset session.pay_morder_ccheck = pay_morder_ccheck>
   <cfset session.pay_am_express = pay_am_express>
   <cfset session.pay_cod = pay_cod>
   <cfset session.pay_discover = pay_discover>
   <cfset session.pay_pcheck = pay_pcheck>
   <cfset session.pay_ol_escrow = pay_ol_escrow>
   <cfset session.pay_visa_mc = pay_visa_mc>
   <cfset session.pay_other = pay_other>
   <cfset session.pay_see_desc = pay_see_desc>
   <cfset session.ship_sell_pays = ship_sell_pays>
   <cfset session.ship_buy_pays_act = ship_buy_pays_act>
   <cfset session.ship_buy_pays_fxd = ship_buy_pays_fxd>
   <cfset session.ship_international = ship_international>
   <cfset session.ship_see_desc = ship_see_desc>
   <cflocation url="item_preview.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=0&from_search=0">
</cfif>
<!---
<cfif isDefined("session.pure_breed") and submit neq 0>
    <cfset pure_breed = session.pure_breed>
<cfelse>
    <cfset pure_breed = pure_breed>
</cfif>
--->
<cfif isDefined("session.pay_morder_ccheck") and submit neq 0>
    <cfset pay_morder_ccheck = session.pay_morder_ccheck>
<cfelse>
    <cfset pay_morder_ccheck = pay_morder_ccheck>
</cfif>
<cfif isDefined("session.pay_am_express") and submit neq 0>
    <cfset pay_am_express = session.pay_am_express>
<cfelse>
    <cfset pay_am_express = pay_am_express>
</cfif>
<cfif isDefined("session.pay_cod") and submit neq 0>
    <cfset pay_cod = session.pay_cod>
<cfelse>
    <cfset pay_cod = pay_cod>
</cfif>
<cfif isDefined("session.pay_discover") and submit neq 0>
    <cfset pay_discover = session.pay_discover>
<cfelse>
    <cfset pay_discover = pay_discover>
</cfif>
<cfif isDefined("session.pay_pcheck") and submit neq 0>
    <cfset pay_pcheck = session.pay_pcheck>
<cfelse>
    <cfset pay_pcheck = pay_pcheck>
</cfif>
<cfif isDefined("session.pay_ol_escrow") and submit neq 0>
    <cfset pay_ol_escrow = session.pay_ol_escrow>
<cfelse>
    <cfset pay_ol_escrow = pay_ol_escrow>
</cfif>
<cfif isDefined("session.pay_visa_mc") and submit neq 0>
    <cfset pay_visa_mc = session.pay_visa_mc>
<cfelse>
    <cfset pay_visa_mc = pay_visa_mc>
</cfif>
<cfif isDefined("session.pay_other") and submit neq 0>
    <cfset pay_other = session.pay_other>
<cfelse>
    <cfset pay_other = pay_other>
</cfif>
<cfif isDefined("session.pay_see_desc") and submit neq 0>
    <cfset pay_see_desc = session.pay_see_desc>
<cfelse>
    <cfset pay_see_desc = pay_see_desc>
</cfif>
<cfif isDefined("session.ship_sell_pays") and submit neq 0>
    <cfset ship_sell_pays = session.ship_sell_pays>
<cfelse>
    <cfset ship_sell_pays = ship_sell_pays>
</cfif>
<cfif isDefined("session.ship_buy_pays_act") and submit neq 0>
    <cfset ship_buy_pays_act = session.ship_buy_pays_act>
<cfelse>
    <cfset ship_buy_pays_act = ship_buy_pays_act>
</cfif>
<cfif isDefined("session.ship_buy_pays_fxd") and submit neq 0>
    <cfset ship_buy_pays_fxd = session.ship_buy_pays_fxd>
<cfelse>
    <cfset ship_buy_pays_fxd = ship_buy_pays_fxd>
</cfif>
<cfif isDefined("session.ship_international") and submit neq 0>
    <cfset ship_international = session.ship_international>
<cfelse>
    <cfset ship_international = ship_international>
</cfif>
<cfif isDefined("session.ship_see_desc") and submit neq 0>
    <cfset ship_see_desc = session.ship_see_desc>
<cfelse>
    <cfset ship_see_desc = ship_see_desc>
</cfif>

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
   <!--- JM ORDER BY pair ASC --->
   	ORDER by pair+0
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
   <!--- JM ORDER BY pair ASC --->
   ORDER BY pair+0
</cfquery>
<!--- JM <cfquery username="#db_username#" password="#db_password#" name="get_location" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'location'
   ORDER BY pair ASC
</cfquery>--->
<cfquery username="#db_username#" password="#db_password#" name="get_dollar_type" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'dollar_type'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_list_type" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'list_type'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_sex" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'sex'
   ORDER BY pair DESC
</cfquery>

<cfif isDefined("cat")>
   <cfset cat = cat>
<cfelse>
   <cfset cat = "S">
</cfif>
<html>

<!---------------OUT TEXT FOR TEST-------------->
<head>
   <title>Equibidz-Post Auction</title>
   <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
   <script>
	$(document).ready(function() {
			$('.addDiscipline').click(function(){
				$('#cb').slideToggle("fast");
			});

			$('.addAttributes').click(function(){
				$('#cb2').slideToggle("fast");
			});
	});
   </script>
   <script>
		function updateDiscipline() {
			var allVals = [];
			$('#cb :checked').each(function() {
				allVals.push($(this).val());
			});
			$('#txtdiscipline').val(allVals)
		}

		$(function() {
			$('#cb input').click(updateDiscipline);
			updateDiscipline();
		});

		function updateAttributes() {
			var allVals = [];
			$('#cb2 :checked').each(function() {
				allVals.push($(this).val());
			});
			$('#txtattributes').val(allVals)
		}
		
		$(function() {
			$('#cb2 input').click(updateAttributes);
	       updateAttributes();
		});
	</script>
	<style type="text/css">
		.cb {
			height:200px;
			width:200px;
			overflow:scroll;
			display:none;
			margin-bottom:20px;
		}

		.cb2 {
			height:200px;
			width:300px;
			overflow:scroll;
			display:none;
			margin-bottom:20px;
		}

		.addDiscipline {
			cursor:pointer
		}

		.addAttributes {
			cursor:pointer
		}
	</style>
</head>

<script language="JavaScript">
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
        var xname = document.listForm.name.value;
        //var xregistration = document.listForm.registration.value;
        var xcity = document.listForm.city.value;
        //var xyear_foaled = document.listForm.year_foaled.value;
        var xreserve_bid = document.listForm.reserve_bid.value;
        var xminimum_bid = document.listForm.minimum_bid.value;
        var pic1 = document.listForm.picture1.value;
        var pic2 = document.listForm.picture2.value;
        var pic3 = document.listForm.picture3.value;
        var pic4 = document.listForm.picture4.value;
        var pic5 = document.listForm.picture5.value;
        var pic6 = document.listForm.picture6.value;
        var pay1 = document.listForm.pay_morder_ccheck;
        var pay2 = document.listForm.pay_am_express;
        var pay3 = document.listForm.pay_cod;
        var pay3 = document.listForm.pay_discover;
        var pay4 = document.listForm.pay_pcheck;
        var pay5 = document.listForm.pay_ol_escrow;
        var pay6 = document.listForm.pay_visa_mc;
        var pay7 = document.listForm.pay_other;
        var pay8 = document.listForm.pay_see_desc;
        var shp1 = document.listForm.ship_sell_pays;
        var shp2 = document.listForm.ship_buy_pays_act;
        var shp3 = document.listForm.ship_buy_pays_fxd;
        var shp4 = document.listForm.ship_international;
        var shp5 = document.listForm.ship_see_desc;

        if (xname == "") {
           alert("Please input Horse Name!");
           return false;
        }
        // JM if (xregistration == "") {
        //   alert("Please input Registration Number!");
        //  return false;
        //}
        if (xcity == "") {
           alert("Please input City!");
           return false;
        }
        //if (xyear_foaled == "") {
        //   alert("Please input Year Foaled!");
        //   return false;
        //}
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
        if (pay1.checked || pay2.checked || pay3.checked || pay4.checked || pay5.checked || pay6.checked || pay7.checked || pay8.checked) {
        } else {
           alert ("You must select at least one payment method.");
           return false;
        }

        if (shp1.checked || shp2.checked || shp3.checked || shp4.checked || shp5.checked) {
        } else {
           alert ("You must select at least one shipping arrangement.");
           return false;
        }
        if (pic1 == "" && pic2 == "" && pic3 == "" && pic4 == "" && pic5 == "" && pic6 == "") {
           var reply = confirm("Just to remind you that no Images/Photos has been uploaded! However, if you don't want any Images/Photos, click OK to continue.?");
           if (reply == false) {
              return false;
           }
        }
        tr = document.getElementById( "trLOD" );
        tr.style.display = "table-row";
    }
</script>

<cfinclude template="../includes/menu_bar.cfm">
<body>
<cfoutput>
<!--- JM style="background-image: url('#VAROOT#/images/bg_table.jpg') --->
<table border='0' width="100%" cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
	<!--- Start: Main Body --->
	<div align="center">
	<table border=0 width=800 cellpadding="0" cellspacing="0">
	<form name="listForm" action="index.cfm" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="curr_cat" value="#gencat#">
	    <input type="hidden" name="itemnum" value="#itemnum#">
	    <tr><td colspan=3>&nbsp;</td></tr>
	    <tr><td colspan=3><font size=4><b>Auction Item Posting</b></font></td></tr>
		<tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
		<tr>
		   <td colspan=3><font size=3>
              This page allows you to put an item up for online auction.  Please
              fill out the following form to place your item(s) up for auction, remembering
              to be as accurate and honest as possible when describing your items, as set
              forth in the <a href="../terms.cfm">Terms & Conditions</a>.  You must be a <a href="#VAROOT#/registration/index.cfm">registered user</a>
              to sell an item. Picture files must be 2.5 Mb or smaller.
           </font></td>
		</tr>
	    <tr><td colspan=3>&nbsp;</td></tr>
		<tr><td><font size=3><b>* Indicates a required item; all others are optional.</b></font></td></tr>
		<tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
	    <tr><td colspan=3>&nbsp;</td></tr>
	    <tr><td>
 	    <table border=0 width=800 cellpadding="2" cellspacing="2">
           <tr>
               <td><font size=3><b>*Category :</b></font></td>
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
           <!--- Jm 05/01/2013<tr>
               <td><font size=3><b>*Category Type:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_list_type">
                   <cfloop query="get_list_type">
                    <option value="#pair#"<cfif #list_type# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>

                 </select>
               </td>
           </tr>--->
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr><td><font size=3><b>*Horse Name:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="name" value="#name#" size=40></td>
           </tr>
           <!--- JM <tr><td><font size=3><b>Registration Number:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="registration" value="#registration#" size=30></td>
           </tr>--->
           <tr><td><font size=3><b>Lifetime Earnings:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="earnings" value="#earnings#" size=15>&nbsp;<font size=3>in USD</font></td>
           </tr>
           <tr>
               <td><font size=3><b>Primary Breed:</b></font></td>
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
               <td><font size=3><b>Secondary Breed:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_sec_breed">
                   <option value=""<cfif #sec_breed# is ""> selected</cfif>>---Not Applicable---</option>
                   <cfloop query="get_breed">
                    <option value="#pair#"<cfif #sec_breed# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
		   <!---
           <tr><td><font size=3><b>Pure Bred:</b></font></td>
              <td>&nbsp;</td>
              <td><input type="checkbox" name="pure_breed" value="1"<cfif #pure_breed# is "1"> checked</cfif>><font size=3>&nbsp;check if Pure Bred</font></td>
           </tr>
		   --->
           <tr style="display:none;">
               <td><font size=3><b>Bloodline:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_bloodline">
                   <cfloop query="get_bloodline">
                    <option value="#pair#"<cfif #bloodline# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr style="display:none;"><td><font size=3><b>Year Foaled:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="year_foaled" value="#year_foaled#" size=10></td>
           </tr>
           <tr>
               <td><font size=3><b>Color:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_color">
                   <cfloop query="get_color">
                    <option value="#pair#"<cfif #color# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=3><b>Date of Birth:</b></font></td>
               <td>&nbsp;</td>
               <td>
                   <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfset the_month = #datePart ("m", "#dob#")#>
                      <cfset the_year = #datePart ("yyyy", "#dob#")#>
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
           </tr
           ><tr>
               <td><font size=3><b>Sex:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                     <select name="selected_sex">
					 <cfloop query="get_sex">
                      <option>#pair#</option>
					</cfloop>
                     </select>
               </td>
           </tr>
           <td>&nbsp; </td>
		   <td>&nbsp; </td>
		    <td valign="left"><font size=2>(M = Mares S = Stallions G = Geldings)</font></td>
				<td>&nbsp; </td>

		   <tr><td><font size=3><b>Height:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_height">
                   <cfloop query="get_height">
                    <option value="#pair#"<cfif #height# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
			<!---Testing for Drop Down entry list--->
		   <tr>
               <td valign='top'><font size=3><b>Discipline:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_discipline" multiple>
                    <cfloop query="get_discipline">
                    <option value="#pair#"<cfif #discipline# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
		   <td>&nbsp; </td>
		   <td>&nbsp; </td>
		    <td valign="left"><font size=2>(To select multiple disciplines, you must hold down the CTRL ("Control") button on your keyboard while using your mouse to click on each discipline you want.)</font></td>
				<td>&nbsp; </td>

		   <!---<tr>
               <td valign="top"><font size=3><b>Discipline:</b></font></td>
               <td>&nbsp;</td>
               <td>

				   <div class="addDiscipline"> <input type="textbox" id="txtdiscipline" size="50" name="selected_discipline"> <font size="2px"> Show/Hide</font></div>
				   <div class="cb" id="cb">
                   <cfloop query="get_discipline">
                    <input type="checkbox" value="#pair#"<cfif #discipline# is #pair#> selected</cfif>>#pair# <br>
                   </cfloop>
				   </div>
				 </cfform>
                      </td>
           </tr>--->


		   <tr>
               <td><font size=3><b>Experience:</b></font></td>
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
               <td valign='top'><font size=3><b>Attributes:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_attributes" multiple>
                    <cfloop query="get_attributes">
                    <option value="#pair#"<cfif #attributes# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
		   <td>&nbsp; </td>
		   <td>&nbsp; </td>
               <td valign="left"><font size=2>(To select multiple attributes, you must hold down the CTRL ("Control") button on your keyboard while using your mouse to click on each attributes you want.)</font></td>
		   <td>&nbsp; </td>

           <!---<tr>
               <td valign="top"><font size=3><b>Attributes:</b></font></td>
               <td>&nbsp;</td>
               <td>


			   	   <div class="addAttributes"> <input type="textbox" id="txtattributes" size="50" name="selected_attributes"><font size="2px"> Show/Hide</font></div>
				   <div class="cb2" id="cb2">
                   <cfloop query="get_attributes">
                    <input type="checkbox" value="#pair#"<cfif #attributes# is #pair#> selected</cfif>>#pair# <br>
                   </cfloop>
				   </div>



               </td>
           </tr>--->
           <tr>
               <td><font size=3><b>Temperament:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_temperament">
                   <cfloop query="get_temperament">
                    <option value="#pair#"<cfif #temperament# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr><td><font size=3><b>Nominations & Enrollments:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="nominations" rows=3 cols=50>#nominations#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Comments:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="comments" rows=3 cols=50>#comments#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Performance Record:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="performance" rows=3 cols=50>#performance#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Produce Record:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="produce" rows=3 cols=50>#produce#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Sire's Performace<br>and Produce Record:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="sire_performance" rows=3 cols=50>#sire_performance#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Dam's Performance<br>and Produce Record:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="dam_performance" rows=3 cols=50>#dam_performance#</textarea></td>
           </tr>
           <tr><td><font size=3><b>Incentive Enrollment<br>Program:</b></font></td>
               <td>&nbsp;</td>
               <td><textarea name="stallion_incentive" rows=3 cols=50>#stallion_incentive#</textarea></td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr><td valign="top"><font size=3><b>Pedigree:</b></font></td>
               <td>&nbsp;</td>
               <td valign="top">
                  <table cellspacing=1 cellpadding=1 border=0>
                    <tr>
                    <td valign="middle">
                       Sire:&nbsp;<input type="text" name="sire" value="#sire#" size=23><br>
                    </td>
                    <td valign="middle">
                       <input type="text" name="ped4" value="#ped4#" size=23><br><br>
                       <input type="text" name="ped5" value="#ped5#" size=23><br>
                    </td>
                    <td valign="top">
                       <input type="text" name="ped8" value="#ped8#" size=23><br>
                       <input type="text" name="ped9" value="#ped9#" size=23><br>
                       <input type="text" name="ped10" value="#ped10#" size=23><br>
                       <input type="text" name="ped11" value="#ped11#" size=23><br>
                    </td>
                    </tr>
                  </table>
                  <br>
                  <table cellspacing=1 cellpadding=1 border=0>
                    <tr>
                    <td valign="middle">
                       Dam:&nbsp;<input type="text" name="dam" value="#dam#" size=23>
                    </td>
                    <td valign="middle">
                       <input type="text" name="ped6" value="#ped6#" size=23><br><br>
                       <input type="text" name="ped7" value="#ped7#" size=23><br>
                    </td>
                    <td valign="top">
                       <input type="text" name="ped12" value="#ped12#" size=23><br>
                       <input type="text" name="ped13" value="#ped13#" size=23><br>
                       <input type="text" name="ped14" value="#ped14#" size=23><br>
                       <input type="text" name="ped15" value="#ped15#" size=23><br>
                    </td>
                    </tr>
                  </table>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr>
               <td align="left"><font size=3><b>If this listing is for MARE<br>will need this additional<br>information:</b></font></td>
               <td>&nbsp;</td>
               <td align="left" valign="top">
               <table width="100%" cellspacing=0 cellpadding=0>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;In Foal:</font></td>
                   <td>
                     <select name="selected_isfoal">
                      <option value="Y"<cfif #isfoal# is "Y"> selected</cfif>>Yes</option>
                      <option value="N"<cfif #isfoal# is "N"> selected</cfif>>No</option>
                    </select>
                  </td>
                  <td width=150>&nbsp;</td>
                 </tr>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;Last Bred Date:</font></td>
                   <td><input type="text" name="last_bred_date" value="#last_bred_date#" size=20></td>
                   <td width=150>&nbsp;</td>
                 </tr>
               </table>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr><td align="left" valign="top"><font size=3><b>If this listing is for<br>STALLION STUD SERVICE<br>will need this additional<br>information:</b></font></td>
               <td>&nbsp;</td>
               <td align="left" valign="top">
               <table width="100%" cellspacing=0 cellpadding=0>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;Shipped Semen:</font></td>
                   <td>&nbsp;</td>
                   <td>
                     <select name="selected_shipped_semen">
                      <option value="A"<cfif #shipped_semen# is "A"> selected</cfif>>Available</option>
                      <option value="N"<cfif #shipped_semen# is "N"> selected</cfif>>Not Available</option>
                    </select>
                   </td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr>
                   <td><font size=3>&nbsp;&nbsp;Frozen Semen:</font></td>
                   <td>&nbsp;</td>
                   <td>
                     <select name="selected_frozen_semen">
                      <option value="A"<cfif #frozen_semen# is "A"> selected</cfif>>Available</option>
                      <option value="N"<cfif #frozen_semen# is "N"> selected</cfif>>Not Available</option>
                    </select>
                   </td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Regualar Fee:</font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="regular_fee" value="#regular_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Shipped Semen Fee:</font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="shipped_semen_fee" value="#shipped_semen_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Int'l Shipped Semen Fee:</font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="intl_shipped_semen_fee" value="#intl_shipped_semen_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Counter-to-Counter Fee:</font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="counter_fee" value="#counter_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Booking Fee:</font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="booking_fee" value="#booking_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
                   <td width=150>&nbsp;</td>
                 </tr>
                 <tr><td><font size=3>&nbsp;&nbsp;Mare Care per day:</font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="mare_care_fee" value="#mare_care_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
                   <td width=150>&nbsp;</td>
                 </tr>
               </table>
               </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr><td colspan=3><font size=2>Only JPG (not progressive) and GIF images are supported. (NO Larger then 2.5 Mb file - Height:300 by Width:380)</font></td></tr>
		   <tr>
		       <td><font size=3><font size=3><b>Upload Image 1:</b></font></td>
               <td>&nbsp;</td>
  		       <td><input name="picture1" type="file" value="#picture1#" size=45 maxlength=250></td>
  		   </tr>
		   <tr>
		       <td><font size=3><font size=3><b>Upload Image 2:</b></font></td>
               <td>&nbsp;</td>
  		       <td><input name="picture2" type="file" size=45 maxlength=250></td>
  		   </tr>
		   <tr>
		       <td><font size=3><font size=3><b>Upload Image 3:</b></font></td>
               <td>&nbsp;</td>
  		       <td><input name="picture3" type="file" size=45 maxlength=250></td>
  		   </tr>
		   <tr>
		       <td><font size=3><font size=3><b>Upload Image 4:</b></font></td>
               <td>&nbsp;</td>
  		       <td><input name="picture4" type="file" size=45 maxlength=250></td>
  		   </tr>
		   <tr>
		       <td><font size=3><font size=3><b>Upload Image 5:</b></font></td>
               <td>&nbsp;</td>
  		       <td><input name="picture5" type="file" size=45 maxlength=250></td>
  		   </tr>
		   <tr>
		       <td><font size=3><font size=3><b>Upload Image 6:</b></font></td>
               <td>&nbsp;</td>
  		       <td><input name="picture6" type="file" size=45 maxlength=250></td>
  		   </tr>
           <tr><td><font size=3><b>Youtube/Video:</b></font><br><font size=1>(Paste your Youtube<br>embedded code here)</font><br></td>
               <td>&nbsp;</td>
               <td><textarea name="youtube" rows=3 cols=50>#youtube#</textarea></td>
           </tr>
           <!---JM <tr><td><font size=3><b>Web Link:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="weblink" value="#weblink#" size=40>&nbsp;<font size=3>(Horse Website Link)</font></td>
           </tr>--->
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
               <tr><td><font size=3><b>*City:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="city" value="#city#" size=30></td>
           </tr>
           <tr>
               <td><font size=3><b>*State:</font></td>
               <td>&nbsp;</td>
               <td>
          		  <CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                  SELECTNAME="state"
                  SELECTED="#state#"
                  MULTIPLE="0"
                  SIZE="1">
               </td>
           </tr>
           <tr><td><font size=3><b>Province (Non US):</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="province" value="#province#" size=30></td>
           </tr>
           <tr>
               <td><font size=3><b>*Country:</font></td>
               <td>&nbsp;</td>
               <td>
                  <CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1">
               </td>
           </tr>
           <tr><td><font size=3><b>Zip Code:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="zipcode" value="#zipcode#" size=10>&nbsp;(US Only)</td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr style="display:none;">
               <td><font size=3><b>*Auction Type:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <select name="selected_auction_type">
                      <option value="E"<cfif #auction_type# is "E"> selected</cfif>>English (Normal)</option>
                      <option value="D"<cfif #auction_type# is "D"> selected</cfif>>Dutch</option>
                      <option value="Y"<cfif #auction_type# is "Y"> selected</cfif>>Yankee</option>
                      <option value="V"<cfif #auction_type# is "V"> selected</cfif>>Vickrey</option>
                    </select>
               </td>
           </tr>
           <tr style="display:none;">
               <td><font size=3><b>*Auction Mode:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
	                <select name="selected_auction_mode" onChange="getAuctionMode( this.value)">
                      <option value="0"<cfif #auction_mode# is "0"> selected</cfif>>Normal  - Seller's Auction </option>
                      <option value="1"<cfif #auction_mode# is "1"> selected</cfif>>Reverse - Buyer's Auction </option>
                    </select>
                    <cfif #auction_mode# is 0>
                       <img src = "../images/r_reverse_blank.gif" name="theFlag" width=22 height=17 border=0">
                    <cfelse>
                       <img src = "../images/r_reverse.gif" name="theFlag" width=22 height=17 border=0">
                    </cfif>
               </td>
           </tr>
           <tr><td><font size=3><b>*Start Date  (Tentative pending Approval):</b></font></td>
               <td>&nbsp;</td>
               <td>
                   <table border=0 cellspacing=0 cellpadding=1>
                     <tr>
                      <cfset the_month = #datePart ("m", "#date_start#")#>
                      <cfset the_day = #datePart ("d", "#date_start#")#>
                      <cfset the_year = #datePart ("yyyy", "#date_start#")#>
                      <cfset the_time = #timeFormat ("#date_start#", 'hh:mm')#>
                      <cfset the_time_s = #timeFormat ("#date_start#", 'tt')#>
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
                      <td><input name="start_day" type="text" size=3 maxlength=2 value="#the_day#">,</td>
                      <td><input name="start_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
                      <td><font face="helvetica" size=3>&nbsp;at&nbsp;</font></td>
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
               <td><font size=3><b>*Auction Duration:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                     <select name="selected_duration">
                      <option value=7<cfif #duration# is 7> selected</cfif>>7 Days</option>
                      <option value=14<cfif #duration# is 14> selected</cfif>>14 Days</option>
                      <option value=30<cfif #duration# is 30> selected</cfif>>30 Days</option>

				<!--- JM 4/10/2013 <option value=120<cfif #duration# is 120> selected</cfif>>120 Days</option>
                      <option value=150<cfif #duration# is 150> selected</cfif>>150 Days</option>
                      <option value=180<cfif #duration# is 180> selected</cfif>>180 Days</option>--->

				    </select>
               </td>
           </tr>
           <!---JM 05/01/2013<tr>
               <td><font size=3><b>Auto Relist:</b></font></td>
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
                    </select>&nbsp;<font size=3>(Times to Relist if not sold)</font>
               </td>
           </tr>      --->
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr style="display:none;">
               <td><font size=3><b>Dollar Type:</b></font></td>
               <td>&nbsp;</td>
               <td>
                 <select name="selected_dollar_type">
                   <cfloop query="get_dollar_type">
                    <option value="#pair#"<cfif #dollar_type# is #pair#> selected</cfif>>#pair#</option>
                   </cfloop>
                 </select>
               </td>
           </tr>
           <tr>
               <td><font size=3><b>Buy Now Price:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="buynow_price" value="#buynow_price#" size=10>&nbsp;<font size=3>in USD</td>
           </tr>
           <tr><td><font size=3><b>*Reserve Bid:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="reserve_bid" value="#reserve_bid#" size=10>&nbsp;<font size=3>in USD</td>
           </tr>
           <tr>
               <td><font size=3><b>*Minimum Bid:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="minimum_bid" value="#minimum_bid#" size=10>&nbsp;<font size=3>in USD</td>
           </tr>
           <tr style="display: none;">
               <td><font size=3><b>*Maximum Bid:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="maximum_bid" value="#maximum_bid#" size=10>&nbsp;<font size=3>in USD</td>
           </tr>
           <tr><td><font size=3><b>*Bid Increment:</b></font></td>
               <td>&nbsp;</td>
                   <td>
                     <select name="selected_increment_valu">
                      <option value=10.00<cfif #increment_valu# is 10.00> selected</cfif>>10.00</option>
                      <option value=20.00<cfif #increment_valu# is 20.00> selected</cfif>>20.00</option>
                      <option value=50.00<cfif #increment_valu# is 50.00> selected</cfif>>50.00</option>
                      <option value=100.00<cfif #increment_valu# is 100.00> selected</cfif>>100.00</option>
                      <option value=200.00<cfif #increment_valu# is 200.00> selected</cfif>>200.00</option>
                      <option value=500.00<cfif #increment_valu# is 500.00> selected</cfif>>500.00</option>
                      <option value=600.00<cfif #increment_valu# is 600.00> selected</cfif>>600.00</option>
                      <option value=700.00<cfif #increment_valu# is 700.00> selected</cfif>>700.00</option>
                      <option value=800.00<cfif #increment_valu# is 800.00> selected</cfif>>800.00</option>
                      <option value=900.00<cfif #increment_valu# is 900.00> selected</cfif>>900.00</option>
					  <option value=1000.00<cfif #increment_valu# is 1000.00> selected</cfif>>1,000.00</option>
                      <option value=0.00<cfif #increment_valu# is 0.00> selected</cfif>>0.00</option>
                    </select>&nbsp;<font size=3>in USD</td>
					<!--- JM </select>&nbsp;<font size=3>in USD <i>(Decrement for Reverse Auction)</i></font>
               </td> --->
           </tr>
           <!--------------terms-of-sale--------------->
           <tr id="tr1" style="display:table-row;"><td><font size=3><b>Terms of Sales and<br>Shipping Info:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="button" name="submit" value=" Click Here " onClick="get_terms(1)"></td>
           </tr>
           <tr id="tr2" style="display:none;">
              <td colspan=3 align="center">
				<table width="100%" border=0 cellspacing=0 cellpadding=0>
				    <tr><td><hr size=1 color="616362"></td></tr>
					<tr><td><font size=3><b>Terms of Sales & Shipping Info</b>&nbsp;(Enter your terms here)</font></td></tr>
					<tr><td><textarea name="terms" value="#terms#" cols=96 rows=24>#terms#</textarea></td></tr>
					<tr height=10><td></td></tr>
					<tr><td align="center"><input type="button" name="terms" value=" Close & Continue " onClick="get_terms(0)"></td></tr>
				</table>
              </td>
           </tr>
           <!--------------end-terms-of-sale----------->
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr>
           <td valign="top"><font size=3><b>*Accepted<br>Payment<br>Methods:</b></font></td>
           <td>&nbsp;</td>
           <td valign="top" colspan=2>
              <table border=0 cellspacing=0 cellpadding=1>
                <tr>
                  <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>><font size=3>&nbsp;Cashier's Check, Money Order, Bank Transfer</font></td>
                  <td width=25>&nbsp;</td>
                  <td><input name="pay_am_express" type="checkbox" value="1"<cfif #pay_am_express# is "1"> checked</cfif>><font size=3>&nbsp;American Express card</font></td>
                </tr>
                <tr>
                  <td><input name="pay_cod" type="checkbox" value="1"<cfif #pay_cod# is "1"> checked</cfif>><font size=3>&nbsp;Collect-on-delivery (COD)</font></td>
                  <td>&nbsp;</td>
                  <td><input name="pay_discover" type="checkbox" value="1"<cfif #pay_discover# is "1"> checked</cfif>><font size=3>&nbsp;Discover card</font></td>
                </tr>
                <tr>
                  <td><input name="pay_pcheck" type="checkbox" value="1"<cfif #pay_pcheck# is "1"> checked</cfif>><font size=3>&nbsp;Personal check</font></td>
                  <td>&nbsp;</td>
                  <td><input name="pay_ol_escrow" type="checkbox" value="1"<cfif #pay_ol_escrow# is "1"> checked</cfif>><font size=3>&nbsp;PayPal</font></td>
                </tr>
                <tr>
                  <td><input name="pay_visa_mc" type="checkbox" value="1"<cfif #pay_visa_mc# is "1"> checked</cfif>><font size=3>&nbsp;VISA/MasterCard</font></td>
                  <td>&nbsp;</td>
                  <td><input name="pay_other" type="checkbox" value="1"<cfif #pay_other# is "1"> checked</cfif>><font size=3>&nbsp;Other/Not listed here</font></td>
                </tr>
                <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>><font size=3>&nbsp;See item comments for payment information</font></td></tr>
              </table>
           </td>
           </tr>
           <tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr>
              <td valign="top"><font size=3><b>*Shipping<br>Info:</b></font></td>
              <td>&nbsp;</td>
              <td valign="top" colspan=2>
              <table border=0 cellspacing=0 cellpadding=1>
                <tr>
                  <td><input name="ship_sell_pays" type="checkbox" value="1"<cfif #ship_sell_pays# is "1"> checked</cfif>><font size=3>&nbsp;Seller pays shipping costs</font></td>
                </tr>
                <tr>
                  <td><input name="ship_buy_pays_act" type="checkbox" value="1"<cfif #ship_buy_pays_act# is "1"> checked</cfif>><font size=3>&nbsp;Buyer pays actual shipping costs</font></td>
                </tr>
                <tr>
                  <td><input name="ship_buy_pays_fxd" type="checkbox" value="1"<cfif #ship_buy_pays_fxd# is "1"> checked</cfif>><font size=3>&nbsp;Buyer pays fixed shipping costs</font></td>
                </tr>
                <tr>
                  <td><input name="ship_international" type="checkbox" value="1"<cfif #ship_international# is "1"> checked</cfif>><font size=3>&nbsp;Allow international shipping</font></td>
                </tr>
                <tr>
                  <td><input name="ship_see_desc" type="checkbox" value="1"<cfif #ship_see_desc# is "1"> checked</cfif>><font size=3>&nbsp;See item description for shipping information</font></td>
                </tr>
              </table>
              </td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
           <tr><td><font size=3><b>Shipping Fee:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="shipping_fee" value="#shipping_fee#" size=10>&nbsp;<font size=3>in USD</font></td>
           </tr>
           <tr style="display:none;"><td><font size=3><b>Sales Tax:</b></font></td>
               <td>&nbsp;</td>
               <td><input type="text" name="salestax" value="#salestax#" size=10>&nbsp;<font size=3>%</font></td>
           </tr>
           <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
        </table>
        </td></tr>
        <tr id="trLOD" style="display:none;">
            <td align="center"><img src="/images/loader.gif" width="220" height="19" border="0"></td>
        </tr>
        <tr><td colspan=3 align="center"><br>
            <input type="submit" name="submit" value=" Next >> " onClick="return val_entries()">
            <input type="submit" name="submit" value=" << Back ">
            <br><br><br><br>
        </td></tr>
    </form>
    </table>
    </td>
    </div>
</tr>
		<tr>
			<td>
				<hr width='#get_layout.page_width#' size=1 color="#heading_color#" noshade>
			</td>
		</tr>
		<tr>
			<td align="left">
				<cfinclude template="../includes/copyrights.cfm">
			</td>
		</tr>
</table>
</body>
</cfoutput>
</html>
