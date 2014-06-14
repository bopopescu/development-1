<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <title>Auction Server Administrator [Defaults Module]</title>
  <script language="JavaScript">
  	function per_auc_alert(){
		alert("Please disable/delete monthly billing schedule task")
	}
	
	function monthly_alert(){
		alert("Please enable/create monthly billing schedule task")
	}
  </script>

 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">

<link rel="stylesheet" href="accordian.css" type="text/css" />
<script type="text/javascript" src="accordian.js"></script>

 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">
  <!--- Reset error code strings --->
 <cfset #error_list# = "">
 <cfset #error_message# = "">
 
 
 
 
 <!--- Add default membership for the site if it doesn't exist --->
<cfquery username="#db_username#" password="#db_password#" name="chck_membership_sta" datasource="#DATASOURCE#">
SELECT pair FROM defaults
WHERE name = 'membership_sta'
</cfquery>
<cfif chck_membership_sta.recordcount eq 0>
 <CFQUERY username="#db_username#" password="#db_password#" NAME="ins_membership_sta" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
  INSERT INTO defaults
  (name, pair) 
  VALUES
  ('membership_sta', '0')
 </CFQUERY>
 </CFIF>
 
 
 <!--- Find out if any auctions are running --->
 <cfquery username="#db_username#" password="#db_password#" name="getActiveAuctions" DATASOURCE="#DATASOURCE#">
SELECT MAX(date_end) AS last FROM items
WHERE date_end >= #now()#
</CFQUERY>
 <!-- Get current Switch  Status -->

<cfquery username="#db_username#" password="#db_password#" name="getSwitchStatus" datasource="#DATASOURCE#">
SELECT pair FROM defaults
WHERE name = 'mode_switch'
</cfquery>

<cfif getSwitchStatus.recordcount LT 1>
<CFQUERY username="#db_username#" password="#db_password#" NAME="insert_mode_switch" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
INSERT INTO defaults
(name, pair) 
VALUES
('mode_switch', 'Dual')
</CFQUERY>
<CFELSE>
<CFSET mode_switch = getSwitchStatus.pair>
</CFIF>



<CFIF isDefined('form.mode_switch')>

<!-- Change  Mode Switch -->
<cfquery username="#db_username#" password="#db_password#" name="update0" datasource="#DATASOURCE#" >
UPDATE defaults 
SET pair = '#form.mode_switch#'
WHERE name = 'mode_switch'
</cfquery>
</CFIF> 

<!--- Get Current Auction mode setting --->

<cfquery username="#db_username#" password="#db_password#" name="getModeStatus" datasource="#DATASOURCE#">
SELECT pair FROM defaults
WHERE name = 'auction_mode'
</cfquery>

<CFIF getModeStatus.recordcount LT 1>
<CFQUERY username="#db_username#" password="#db_password#" NAME="insert_auction_mode" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
INSERT INTO defaults
(name, pair) 
VALUES
('auction_mode', 0)
</CFQUERY>
<CFELSE>
<CFSET auction_mode = getModeStatus.pair>

</CFIF>



<CFSET auction_mode = getModeStatus.pair>

<CFIF isDefined('form.auction_mode')>

<!-- Change Auction Mode  -->
<cfquery username="#db_username#" password="#db_password#" name="update2" datasource="#DATASOURCE#" >
UPDATE defaults 
SET pair = '#form.auction_mode#'
WHERE name = 'auction_mode'
</cfquery>
</CFIF>

<!--- add domain block --->
<cfif IsDefined("Form.subAddDomainBlock")
  AND CGI.HTTP_REFERER CONTAINS "/admin/defaults.cfm">
  
  <!--- if vals defined --->
  <cfif IsDefined("Form.sNewDomainBlock")>
    
    <cfmodule template="../functions/emailBlocks.cfm"
      action="INS-DOMAIN"
      datasource="#DATASOURCE#"
      address="#Form.sNewDomainBlock#">
  </cfif>
</cfif>

<!--- add account block --->
<cfif IsDefined("Form.subAddAccountBlock")
  AND CGI.HTTP_REFERER CONTAINS "/admin/defaults.cfm">
  
  <!--- if vals defined --->
  <cfif IsDefined("Form.sNewAccountBlock")>
    
    <cfmodule template="../functions/emailBlocks.cfm"
      action="INS-ACCOUNT"
      datasource="#DATASOURCE#"
      address="#Form.sNewAccountBlock#">
  </cfif>
</cfif>

<!--- del domain block --->
<cfif IsDefined("Form.subDelDomainBlock")
  AND CGI.HTTP_REFERER CONTAINS "/admin/defaults.cfm">
  
  <!--- if vals defined --->
  <cfif IsDefined("Form.lBlockedDomains")>
    
    <cfmodule template="../functions/emailBlocks.cfm"
      action="DEL-DOMAIN"
      datasource="#DATASOURCE#"
      address="#Form.lBlockedDomains#">
  </cfif>
</cfif>

<!--- del account block --->
<cfif IsDefined("Form.subDelAccountBlock")
  AND CGI.HTTP_REFERER CONTAINS "/admin/defaults.cfm">
  
  <!--- if vals defined --->
  <cfif IsDefined("Form.lBlockedAccounts")>
    
    <cfmodule template="../functions/emailBlocks.cfm"
      action="DEL-ACCOUNT"
      datasource="#DATASOURCE#"
      address="#Form.lBlockedAccounts#">
  </cfif>
</cfif>

 <!--- Set defaults of they're here for the first time --->
 <cfif #isDefined ("submit2")#>
  <cfset #submit2# = #trim (submit2)#>
 <cfelse>
  <cfset #submit2# = "">
 </cfif>
 <cfif #isDefined ("submit3")#>
  <cfset #submit3# = #trim (submit3)#>
 <cfelse>
  <cfset #submit3# = "">
 </cfif>
 <cfif #isDefined ("submit4")#>
  <cfset #submit4# = #trim (submit4)#>
 <cfelse>
  <cfset #submit4# = "">
 </cfif>
 <cfif #isDefined ("submit5")#>
  <cfset #submit5# = #trim (submit5)#>
 <cfelse>
  <cfset #submit5# = "">
 </cfif>

 <cfif #isDefined ("root_le_active")# is 1>
  <cfset #root_le_active# = "1">
 <cfelse>
 <cfset #root_le_active# = "0">
  </cfif>
 <cfif #isDefined ("primary_le_active")# is 1>
  <cfset #primary_le_active# = "1">
 <cfelse>
  <cfset #primary_le_active# = "0">
 </cfif>
 <cfif #isDefined ("categories_le_active")# is 1>
  <cfset #categories_le_active# = "1">
 <cfelse>
  <cfset #categories_le_active# = "0">
 </cfif>
 <cfif #isDefined ("featured_le_active")# is 1>
  <cfset #featured_le_active# = "1">
 <cfelse>
  <cfset #featured_le_active# = "0">
 </cfif>
 <cfif #isDefined ("studio_le_active")# is 1>
  <cfset #studio_le_active# = "1">
 <cfelse>
  <cfset #studio_le_active# = "0">
 </cfif>
 <cfif #isDefined ("free_trial")# is 1>
  <cfset #free_trial# = "1">
 <cfelse>
  <cfset #free_trial# = "0">
 </cfif>
 <cfif #isDefined ("enable_ssl")# is 1>
  <cfset #enable_ssl# = "1">
 <cfelse>
  <cfset #enable_ssl# = "0">
 </cfif>
 <cfif #isDefined ("enable_cat_fee")# is 1>
  <cfset #enable_cat_fee# = "1">
 <cfelse>
  <cfset #enable_cat_fee# = "0">
 </cfif>
<cfif #isDefined ("enable_thumbs")# is 1>
  <cfset #enable_thumbs# = "1">
 <cfelse>
  <cfset #enable_thumbs# = "0">
 </cfif> 
 
 <cfif #isDefined ("enable_iescrow")# is 1>
  <cfset #enable_iescrow# = "1">
 <cfelse>
  <cfset #enable_iescrow# = "0">
 </cfif>



 
<!---Update membership--->
 <cfif isDefined("upd_membership")>
  <cfparam name="membership_sta" default="0">
  <cfquery username="#db_username#" password="#db_password#" name="upd_membership_status" datasource="#DATASOURCE#">
    UPDATE defaults
      SET pair = '#membership_sta#'
     WHERE name=  'membership_sta'
  </cfquery>
	<cfif membership_sta eq 1><cfset #error_message# = "<font color='blue'>UPDATE COMPLETE: Please check that you have membership options available. </font>"></cfif>
  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update membership setting"
      details="MEMBERSHIP STATUS: #membership_sta#">
 </cfif>
 <!--- add membership option --->
 <cfif isDefined("add_membership_opt")>
   <cfif len(trim(new_mbs_name)) lt 1 or find(" ",new_mbs_name) neq 0 or find("_",new_mbs_name) neq 0>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership name must be one word and can not be blank or contain a _ letter. </font>">
   </cfif>
   <cfif len(trim(new_mbs_pct)) lt 1 or isnumeric(new_mbs_pct) is 0>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership percentage must be numeric and can not be blank or alphabet. </font>">
   </cfif>
   <cfif len(trim(new_mbs_fee)) lt 1 or isnumeric(new_mbs_fee) is 0>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership fee must be numeric and can not be blank. </font>">
   </cfif>
   <cfif len(trim(new_mbs_cycle)) lt 1>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership cycle must be selected. </font>">
   </cfif>
 
  <cfif error_message eq "">
  <cfquery username="#db_username#" password="#db_password#" name="add_membership_opt" datasource="#DATASOURCE#">
    INSERT INTO defaults
     (name, pair) VALUES('membership_opt', '#new_mbs_fee#_#new_mbs_pct#_#new_mbs_name#_#new_mbs_cycle#')
  </cfquery>
  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Insert new membership option"
      details="NEW MEMBERSHIP OPTION: #new_mbs_fee#_#new_mbs_pct#_#new_mbs_name#_#new_mbs_cycle#">
  </cfif>
 </cfif>
 <!--- update membership option --->
 <cfif isDefined("upd_membership_opt")>
  <cfif selected_membership neq "-1">
   <cfif len(trim(new_mbs_name)) lt 1 or find(" ",new_mbs_name) neq 0 or find("_",new_mbs_name) neq 0>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership name must be one word and can not be blank or contain a _ letter. </font>">
   </cfif>
   <cfif len(trim(new_mbs_pct)) lt 1 or isnumeric(new_mbs_pct) is 0>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership percentage must be numeric and can not be blank or alphabet. </font>">
   </cfif>
   <cfif len(trim(new_mbs_fee)) lt 1 or isnumeric(new_mbs_fee) is 0>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership fee must be numeric and can not be blank. </font>">
   </cfif>
   <cfif len(trim(new_mbs_cycle)) lt 1>
		<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: New membership cycle must be selected. </font>">
   </cfif>
 
  <cfif error_message eq "">
  <cfquery username="#db_username#" password="#db_password#" name="upd_membership_opt" datasource="#DATASOURCE#">
    UPDATE defaults
      SET pair = '#new_mbs_fee#_#new_mbs_pct#_#new_mbs_name#_#new_mbs_cycle#'
     WHERE pair=  '#selected_membership#'
  </cfquery>
  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Edit membership option"
      details="NEW MEMBERSHIP OPTION: #new_mbs_fee#_#new_mbs_pct#_#new_mbs_name#_#new_mbs_cycle#     OLD MEMBERSHIP OPTION: #selected_membership#">
  </cfif>
  <cfelse>
  	<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: To Edit/Delete membership, You must select the existing membership to proceed. </font>">
  </cfif>
 </cfif>
 <!--- delete membership option --->
 <cfif isDefined("del_membership_opt")>
  <cfif selected_membership neq "-1">
  <cfquery username="#db_username#" password="#db_password#" name="del_membership_opt" datasource="#DATASOURCE#">
    DELETE FROM defaults
     WHERE pair=  '#selected_membership#'
  </cfquery>
  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Delete membership option"
      details="DELETE MEMBERSHIP OPTION: #selected_membership#">
  <cfelse>
  	<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: To Edit/Delete membership, You must select the existing membership to proceed. </font>">
  </cfif>
 </cfif>



 <cfif (#submit2# is "") and (#submit3# is "")>

  <!--- Run queries to find the Footer/LE settings --->
  <cfquery username="#db_username#" password="#db_password#" name="get_le_root" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='le_root_listing'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="get_le_primary" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='le_prm_listing'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="get_le_featured" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='le_feat_listing'
  </cfquery>

  <cfquery username="#db_username#" password="#db_password#" name="get_le_studio" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='le_std_listing'
  </cfquery>

  <cfquery username="#db_username#" password="#db_password#" name="get_le_categories" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='le_categories'
  </cfquery>

  <!--- Run queries to get billing type settings --->
  <cfquery username="#db_username#" password="#db_password#" name="get_billing_type" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='billing_type'
  </cfquery>
  <cfset #billing_type# = #get_billing_type.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_credit_limit" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='credit_limit'
  </cfquery>
  <cfset #credit_limit# = #get_credit_limit.pair#>
  <!--- Run queries to find auction settings --->
  <cfquery username="#db_username#" password="#db_password#" name="get_listing_new" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='listing_new'
  </cfquery>
  <cfset #listing_new# = #get_listing_new.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_category_new" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='category_new'
  </cfquery>
  <cfset #category_new# = #get_category_new.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_bids4hot" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='bids4hot'
  </cfquery>
  <cfset #bids4hot# = #get_bids4hot.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_siteCurrency" datasource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'site_currency'
  </cfquery>
  <cfset siteCurrency = Trim(get_siteCurrency.pair)>
  <cfquery username="#db_username#" password="#db_password#" name="get_def_duration" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='def_duration'
  </cfquery>
  <cfset #def_duration# = #get_def_duration.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_hrsending" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='hrsending'
  </cfquery>
  <cfset #hrsending# = #get_hrsending.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_featcolspage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='featcolspage'
  </cfquery>
  <cfset #featcolspage# = #get_featcolspage.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_featitemspage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='featitemspage'
  </cfquery>
  <cfset #featitemspage# = #get_featitemspage.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_itemsperpage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='itemsperpage'
  </cfquery>
  <cfset #itemsperpage# = #get_itemsperpage.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_feedsperpage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fb_per_page'
  </cfquery>
  <cfset #feedsperpage# = #get_feedsperpage.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_def_bidding" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='def_bidding'
  </cfquery>
  <cfset #def_bidding# = #get_def_bidding.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_limitcat_frontpage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='limitcat_frpage'
  </cfquery>
  <cfset #limitcat_frpage# = #get_limitcat_frontpage.pair#>
  
  
  <!--- get/setup proxy maxout/default --->
  <cfmodule template="../functions/setupDefProxyMax.cfm"
    datasource="#DATASOURCE#"
    rtnMaxout="bMaxoutProxies"
    rtnMaxoutFlag="sMaxoutProxiesFlag">
  
  <!--- get PairLoginPass val --->
  <cfmodule template="../functions/PairLoginPass.cfm">
  
  <cfquery username="#db_username#" password="#db_password#" name="get_def_dynamic" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='def_dynamic'
  </cfquery>
  <cfset #def_dynamic# = #get_def_dynamic.pair#>

  <!--- Run queries to find free trial period settings --->
  <cfquery username="#db_username#" password="#db_password#" name="get_free_trial_days" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='free_trial_days'
  </cfquery>
  <cfset #free_trial_days# = #get_free_trial_days.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_free_trial" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='free_trial'
  </cfquery>
  <cfset #free_trial# = #get_free_trial.pair#>

  <!--- Run queries to find fee settings --->
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_listing" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_listing'
  </cfquery>
  <cfset #fee_listing# = #get_fee_listing.pair#>
  <!--- Run queries to find cat_fee enable --->
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_cat_fee" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_cat_fee'
  </cfquery>
  <cfset #enable_cat_fee# = #get_enable_cat_fee.pair#>
<!---  <cfquery username="#db_username#" password="#db_password#" name="get_fee_percentage" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_percentage'
  </cfquery>
  <cfset #fee_percentage# = #evaluate ("get_fee_percentage.pair * 100")#> --->
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_bold" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_bold'
  </cfquery>
  <cfset #fee_bold# = #get_fee_bold.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_featured" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_featured'
  </cfquery>
  <cfset #fee_featured# = #get_fee_featured.pair#>

  <cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_cat" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_feat_cat'
  </cfquery>
  <cfset #fee_feat_cat# = #get_fee_feat_cat.pair#>

  <!--- <cfquery username="#db_username#" password="#db_password#" name="get_exclusive_cat" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='exclusive_cat'
  </cfquery>
  <cfset #exclusive_cat# = #get_exclusive_cat.pair#> --->
  
 <cfquery username="#db_username#" password="#db_password#" name="get_fee_banner" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_banner'
  </cfquery>
  <cfset #fee_banner# = #get_fee_banner.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_second_cat" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_second_cat'
  </cfquery>
  <cfset #fee_second_cat# = #get_fee_second_cat.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_studio" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_studio'
  </cfquery>
  <cfset #Variables.fee_studio# = #get_fee_studio.pair#>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_studio" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_feat_studio'
  </cfquery>
  <cfset #Variables.fee_feat_studio# = #get_fee_feat_studio.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_reserve_bid" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_reserve_bid'
  </cfquery>
  <cfset #Variables.fee_reserve_bid# = #get_fee_reserve_bid.pair#>

  <cfquery username="#db_username#" password="#db_password#" name="get_top_seller" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='top_seller'
  </cfquery>
  <cfset #Variables.top_seller# = #get_top_seller.pair#>

  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture1" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture1'
  </cfquery>
  <cfset #Variables.fee_picture1# = #get_fee_picture1.pair#>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture2" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture2'
  </cfquery>
  <cfset #Variables.fee_picture2# = #get_fee_picture2.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture3" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture3'
  </cfquery>
  <cfset #Variables.fee_picture3# = #get_fee_picture3.pair#>
   <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture4" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture4'
  </cfquery>
  <cfset #Variables.fee_picture4# = #get_fee_picture4.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_late_charge" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_late_charge'
  </cfquery>
  <cfset #fee_late_charge# = #get_fee_late_charge.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_ssl" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_ssl'
  </cfquery>
  <cfset #enable_ssl# = #get_enable_ssl.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_iescrow" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_iescrow'
  </cfquery>
  <cfset #enable_iescrow# = #get_enable_iescrow.pair#>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_thumbs" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_thumbs'
  </cfquery>
 
  <cfif get_enable_thumbs.recordcount LT 1>
  <CFQUERY username="#db_username#" password="#db_password#" NAME="insert_enable_thumbs" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
INSERT INTO defaults
(name, pair) 
VALUES
('enable_thumbs', 0)
</CFQUERY>
<CFELSE>
 <cfset #enable_thumbs# = #get_enable_thumbs.pair#>

</CFIF>

  
 

  <!--- Set defaults --->
  <cfset #root_le_active# = #get_le_root.pair#>
  <cfset #primary_le_active# = #get_le_primary.pair#>
  <cfset #categories_le_active# = #get_le_categories.pair#>
  <cfset #featured_le_active# = #get_le_featured.pair#>
  <cfset #studio_le_active# = #get_le_studio.pair#>

 </cfif>

 <!--- If they clicked "Save Changes" --->
 <cfif #submit2# is "Save Changes">
  
  <!--- Write new HTML files for the footer and LE codes --->
  <cfif copyright_code contains "cfftp" is 0 and copyright_code contains "cfhttp" is 0 and copyright_code contains "cfcontent" is 0 and copyright_code contains "cfdirectory" is 0 and copyright_code contains "cffile" is 0 and copyright_code contains "cfobject" is 0 and copyright_code contains "cfregistry" is 0 and copyright_code contains "cfadminsecurity" is 0 and copyright_code contains "cfexecute" is 0>
  <cffile action="write"
          file=#expandPath ("..\includes\copyrights.cfm")#
          output=#trim (copyright_code)#>
  <cfelse>
  	<cfset error_message = "<font color=red>INCOMPLETE: You are not allowed to post these tags in copyright footer (cfftp, cfhttp, cfcontent, cfdirectory, cffile, cfobject, cfregistry, cfadminsecurity, cfexecute).</font>">
  </cfif>
  <cfif root_le_code contains "cfftp" is 0 and root_le_code contains "cfhttp" is 0 and root_le_code contains "cfcontent" is 0 and root_le_code contains "cfdirectory" is 0 and root_le_code contains "cffile" is 0 and root_le_code contains "cfobject" is 0 and root_le_code contains "cfregistry" is 0 and root_le_code contains "cfadminsecurity" is 0 and root_le_code contains "cfexecute" is 0>
  <cffile action="write"
          file=#expandPath ("..\includes\le_root.html")#
          output=#trim(root_le_code)#>
  <cfelse>
  	<cfset error_message = "<font color=red>INCOMPLETE: You are not allowed to post these tags in front page banner code (cfftp, cfhttp, cfcontent, cfdirectory, cffile, cfobject, cfregistry, cfadminsecurity, cfexecute).</font>">
  </cfif>
  <cfif primary_le_code contains "cfftp" is 0 and primary_le_code contains "cfhttp" is 0 and primary_le_code contains "cfcontent" is 0 and primary_le_code contains "cfdirectory" is 0 and primary_le_code contains "cffile" is 0 and primary_le_code contains "cfobject" is 0 and primary_le_code contains "cfregistry" is 0 and primary_le_code contains "cfadminsecurity" is 0 and primary_le_code contains "cfexecute" is 0>
  <cffile action="write"
          file=#expandPath ("..\includes\le_primary.html")#
          output=#trim(primary_le_code)#>
  <cfelse>
  	<cfset error_message = "<font color=red>INCOMPLETE: You are not allowed to post these tags in listings banner code (cfftp, cfhttp, cfcontent, cfdirectory, cffile, cfobject, cfregistry, cfadminsecurity, cfexecute).</font>">
  </cfif>
  <cfif categories_le_code contains "cfftp" is 0 and categories_le_code contains "cfhttp" is 0 and categories_le_code contains "cfcontent" is 0 and categories_le_code contains "cfdirectory" is 0 and categories_le_code contains "cffile" is 0 and categories_le_code contains "cfobject" is 0 and categories_le_code contains "cfregistry" is 0 and categories_le_code contains "cfadminsecurity" is 0 and categories_le_code contains "cfexecute" is 0>
  <cffile action="write"
          file=#expandPath ("..\includes\le_categories.html")#
          output=#trim(categories_le_code)#>
  <cfelse>
  	<cfset error_message = "<font color=red>INCOMPLETE: You are not allowed to post these tags in categories banner code (cfftp, cfhttp, cfcontent, cfdirectory, cffile, cfobject, cfregistry, cfadminsecurity, cfexecute).</font>">
  </cfif>
  <cfif featured_le_code contains "cfftp" is 0 and featured_le_code contains "cfhttp" is 0 and featured_le_code contains "cfcontent" is 0 and featured_le_code contains "cfdirectory" is 0 and featured_le_code contains "cffile" is 0 and featured_le_code contains "cfobject" is 0 and featured_le_code contains "cfregistry" is 0 and featured_le_code contains "cfadminsecurity" is 0 and featured_le_code contains "cfexecute" is 0>
  <cffile action="write"
          file=#expandPath ("..\includes\le_featured.html")#
          output=#trim(featured_le_code)#>
  <cfelse>
  	<cfset error_message = "<font color=red>INCOMPLETE: You are not allowed to post these tags in featured auctions banner code (cfftp, cfhttp, cfcontent, cfdirectory, cffile, cfobject, cfregistry, cfadminsecurity, cfexecute).</font>">
  </cfif>

  <!--- Update the settings in the database --->
  <cfquery username="#db_username#" password="#db_password#" name="update1" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#root_le_active#'
    WHERE name='le_root_listing'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update2" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#primary_le_active#'
    WHERE name='le_prm_listing'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update3" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#categories_le_active#'
    WHERE name='le_categories'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update4" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#featured_le_active#'
    WHERE name='le_feat_listing'
  </cfquery>

	<cfset Variables.listing_new 	= REReplace( Form.listing_new, 		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.listing_new)) lt 1>
		<cfset Variables.listing_new = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update6" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.listing_new#'
    WHERE name='listing_new'
  </cfquery>

	<cfset Variables.category_new 	= REReplace( Form.category_new, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.category_new)) lt 1>
		<cfset Variables.category_new = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update7" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.category_new#'
    WHERE name='category_new'
  </cfquery>

	<cfset Variables.bids4hot 	= REReplace( Form.bids4hot, 		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.bids4hot)) lt 1>
		<cfset Variables.bids4hot = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update8" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.bids4hot#'
    WHERE name='bids4hot'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update8b" datasource="#DATASOURCE#">
    UPDATE defaults
       SET pair = '#siteCurrency#'
     WHERE name = 'site_currency'
  </cfquery>

	<cfset Variables.def_duration 	= REReplace( Form.def_duration,		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.def_duration)) lt 1>
		<cfset Variables.def_duration = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update9" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.def_duration#'
    WHERE name='def_duration'
  </cfquery>

	<cfset Variables.hrsending 	= REReplace( Form.hrsending, 		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.hrsending)) lt 1>
		<cfset Variables.hrsending = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update10" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.hrsending#'
    WHERE name='hrsending'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="update33" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#featcolspage#'
    WHERE name='featcolspage'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="update34" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#featitemspage#'
    WHERE name='featitemspage'
  </cfquery>
  
	<cfset Variables.itemsperpage 	= REReplace( Form.itemsperpage,		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.itemsperpage)) lt 1>
		<cfset Variables.itemsperpage = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update11" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.itemsperpage#'
    WHERE name='itemsperpage'
  </cfquery>

	<cfset Variables.feedsperpage 	= REReplace( Form.feedsperpage,		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.feedsperpage)) lt 1>
		<cfset Variables.feedsperpage = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update11_2" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.feedsperpage#'
    WHERE name='feedsperpage'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update12" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#def_bidding#'
    WHERE name='def_bidding'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="update_limitcat_frpage" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#limitcat_frpage#'
    WHERE name='limitcat_frpage'
  </cfquery>
  
  <!--- get flag name --->
  <cfmodule template="../functions/setupDefProxyMax.cfm"
    datasource="#DATASOURCE#"
    rtnMaxoutFlag="sMaxoutProxiesFlag">
  
  <cfquery username="#db_username#" password="#db_password#" name="update12b" datasource="#DATASOURCE#">
      UPDATE defaults
         SET pair = '#bMaxoutProxies#'
       WHERE name = '#sMaxoutProxiesFlag#'
  </cfquery>
  
  <!--- set PairLoginPass value --->
  <!--- <cfmodule template="../functions/PairLoginPass.cfm"
    sAction="SET"
    bNewVal="#Form.bPairLoginPass#"> --->
    
  <!--- set IE front page icon value --->
  <!--- <cfmodule template="../functions/IEscrowIcons.cfm"
    sOpt="SET/FRONTPAGE"
    sNewFile="#Form.sIEIconFrontPage#"> --->
    
  <cfquery username="#db_username#" password="#db_password#" name="update13" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#def_dynamic#'
    WHERE name='def_dynamic'
  </cfquery>
  
  <!--- upd def increment --->
  <cfmodule template="../functions/BidIncrements.cfm"
    sOpt="SET/DEF/INCREMENT"
    fNewDefInc="#def_increment#">
    
	<cfset Variables.free_trial_days 	= REReplace( Form.free_trial_days, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.free_trial_days)) lt 1>
		<cfset Variables.free_trial_days = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update15" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.free_trial_days#'
    WHERE name='free_trial_days'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update16" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#free_trial#'
    WHERE name='free_trial'
  </cfquery>

	<cfset Variables.fee_listing 		= REReplace( Form.fee_listing, 		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_listing)) lt 1>
		<cfset Variables.fee_listing = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update17" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_listing#'
    WHERE name='fee_listing'
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="update_enable_cat_fee" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.enable_cat_fee#'
    WHERE name='enable_cat_fee'
  </cfquery>

<!---  <cfquery username="#db_username#" password="#db_password#" name="update18" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#evaluate ("fee_percentage / 100")#'
    WHERE name='fee_percentage'
  </cfquery> --->


	<cfset Variables.fee_bold 		= REReplace( Form.fee_bold, 		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_bold)) lt 1>
		<cfset Variables.fee_bold = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update19" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_bold#'
    WHERE name='fee_bold'
  </cfquery>

	<cfset Variables.fee_featured 		= REReplace( Form.fee_featured, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_featured)) lt 1>
		<cfset Variables.fee_featured = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update20" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_featured#'
    WHERE name='fee_featured'
  </cfquery>

	<cfset Variables.fee_banner 		= REReplace( Form.fee_banner, 		"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_featured)) lt 1>
		<cfset Variables.fee_featured = "0">
	</cfif>


<cfif form.fee_banner is "">

<cfset variables.fee_banner= "0">
</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="update21" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_banner#'
    WHERE name='fee_banner'
  </cfquery>

	<cfset Variables.fee_second_cat 	= REReplace( Form.fee_second_cat, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_second_cat)) lt 1>
		<cfset Variables.fee_second_cat = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update22" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_second_cat#'
    WHERE name='fee_second_cat'
  </cfquery>

	<cfset Variables.fee_studio	= REReplace( Form.fee_studio,	 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_studio)) lt 1>
		<cfset Variables.fee_studio = "0">
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="update23" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_studio#'
    WHERE name='fee_studio'
  </cfquery>


	 <cfset Variables.fee_feat_studio 	= REReplace( Form.fee_feat_studio, 	"[^0123456789.]", "", "ALL")> 
	<cfif len(trim(Variables.fee_feat_studio)) lt 1>
		<cfset Variables.fee_feat_studio = "0">
	</cfif> 
   <cfquery username="#db_username#" password="#db_password#" name="update24" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_feat_studio#'
    WHERE name='fee_feat_studio'
  </cfquery>
  
  <cfset Variables.fee_reserve_bid 		= REReplace( Form.fee_reserve_bid, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_reserve_bid)) lt 1>
		<cfset Variables.fee_reserve_bid = "0">
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="upd_fee_reserve_bid" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#fee_reserve_bid#'
    WHERE name='fee_reserve_bid'
  </cfquery>
  
  <cfset Variables.fee_picture1 		= REReplace( Form.fee_picture1, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_picture1)) lt 1>
		<cfset Variables.fee_picture1 = "0">
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="upd_fee_picture1" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#fee_picture1#'
    WHERE name='fee_picture1'
  </cfquery>

  <cfset Variables.fee_picture2 		= REReplace( Form.fee_picture2, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_picture2)) lt 1>
		<cfset Variables.fee_picture2 = "0">
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="upd_fee_picture2" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#fee_picture2#'
    WHERE name='fee_picture2'
  </cfquery>
  
  <cfset Variables.fee_picture3 		= REReplace( Form.fee_picture3, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_picture3)) lt 1>
		<cfset Variables.fee_picture3 = "0">
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="upd_fee_picture3" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#fee_picture3#'
    WHERE name='fee_picture3'
  </cfquery>
  
   <cfset Variables.fee_picture4 		= REReplace( Form.fee_picture4, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_picture4)) lt 1>
		<cfset Variables.fee_picture4 = "0">
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="upd_fee_picture4" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#fee_picture4#'
    WHERE name='fee_picture4'
  </cfquery>
  
	<cfset Variables.fee_late_charge 	= REReplace( Form.fee_late_charge, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_late_charge)) lt 1>
		<cfset Variables.fee_late_charge = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update25" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.fee_late_charge#'
    WHERE name='fee_late_charge'
  </cfquery>




	<cfset Variables.top_seller 	= REReplace( Form.top_seller, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.top_seller)) lt 1>
		<cfset Variables.top_seller = "20">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update65" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.top_seller#'
    WHERE name='top_seller'
  </cfquery>


	<cfset Variables.fee_feat_cat 		= REReplace( Form.fee_feat_cat, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.fee_feat_cat)) lt 1>
		<cfset Variables.fee_feat_cat = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update26" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#fee_feat_cat#'
    WHERE name='fee_feat_cat'
  </cfquery>
  
	<!--- <cfset Variables.exclusive_cat 		= REReplace( Form.exclusive_cat, 	"[^0123456789.]", "", "ALL")>
	<cfif len(trim(Variables.exclusive_cat)) lt 1>
		<cfset Variables.exclusive_cat = "0">
	</cfif>

  <cfquery username="#db_username#" password="#db_password#" name="update26" datasource="#DATASOURCE#">
   UPDATE defaults 
      SET pair='#REReplace(exclusive_cat, "[^0123456789.]", "", "ALL")#'
    WHERE name='exclusive_cat'
  </cfquery> --->
 
  <cfquery username="#db_username#" password="#db_password#" name="update27" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#enable_ssl#'
    WHERE name='enable_ssl'
  </cfquery>
  <cfquery username="#db_username#" password="#db_password#" name="update28" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#enable_iescrow#'
    WHERE name='enable_iescrow'
  </cfquery>
  <!--- <cfquery username="#db_username#" password="#db_password#" name="update29" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#Variables.exclusive_cat#'
    WHERE name='exclusive_cat'
  </cfquery> --->

  <cfquery username="#db_username#" password="#db_password#" name="update30" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#enable_thumbs#'
    WHERE name='enable_thumbs'
  </cfquery>
  
  <!--- update accounting type --->
  <cfquery username="#db_username#" password="#db_password#" name="update31" datasource="#DATASOURCE#">
   UPDATE defaults
      SET pair='#billing_type#'
    WHERE name='billing_type'
  </cfquery>

  <cfquery username="#db_username#" password="#db_password#" name="update32" datasource="#DATASOURCE#">
   UPDATE defaults
<cfif #credit_limit# neq "">
      SET pair='#credit_limit#'
<cfelse>
      SET pair=0
</cfif> 
    WHERE name='credit_limit'
  </cfquery>

  <!--- log updates to defaults --->
  <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Site Defaults Modified">
 </cfif>


  <!--- Check to see if they chose to add a duration --->
  <cfif #submit2# is "Add">
    
    <cfif (#trim (new_duration)# is not "") and (#new_duration# GT 0) and (#isNumeric (new_duration)# is "1")>
      
      <cfloop list="#new_duration#" index="val">
        
        <cfquery username="#db_username#" password="#db_password#" name="add_duration" datasource="#DATASOURCE#">
            INSERT INTO defaults (name, pair)
            VALUES ('duration', '#repeatString ("0", evaluate (4 - len (val)))##val#')
        </cfquery>
        
        <!--- log new duration --->
        <cfmodule template="../functions/addTransaction.cfm"
          datasource="#DATASOURCE#"
          description="Auction Duration Added"
          details="NEW DURATION: #repeatString ("0", evaluate (4 - len (val)))##val#">
        
      </cfloop>
    </cfif>
  </cfif>

  <!--- Check to see if they chose to delete a duration --->
  <cfif #submit2# is "Delete">
    
    <cfif #trim (selected_duration)# is not "">
      
      <cfquery username="#db_username#" password="#db_password#" name="delete_duration" datasource="#DATASOURCE#">
          DELETE FROM defaults
           WHERE name='duration'
             AND pair='#selected_duration#'
      </cfquery>
      
      <!--- log duration deleted --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Auction Duration Deleted"
        details="DELETED DURATION: #selected_duration#">
        
    </cfif>
  </cfif>
  
  <!--- if they chose to add an increment --->
  <cfif #submit3# is "Add">
    
    <cfif Trim(new_increment) IS NOT ""
      AND IsNumeric(new_increment)>
      
      <cfmodule template="../functions/BidIncrements.cfm"
        sOpt="INS/INCREMENT"
        fNewInc="#new_increment#">
        
    </cfif>
  </cfif>
  
  <!--- if they chose to delete a bid increment --->
  <cfif #submit3# is "Delete">
    
    <cfif Trim(selected_increment) IS NOT "">
      
      <cfmodule template="../functions/BidIncrements.cfm"
        sOpt="DEL/INCREMENT"
        fDelInc="#selected_increment#">
        
    </cfif>
  </cfif>
  
  <!--- Check to see if they chose to add a dynamic closing value --->
  <cfif #submit4# is "Add">
    <cfif (#trim (new_dynamic)# is not "") and (#int (val(new_dynamic))# GT 0) and (#isNumeric (new_dynamic)# is "1")>
       <cfloop list="#new_dynamic#" index="val">
       
        <cfquery username="#db_username#" password="#db_password#" name="add_dynamic" datasource="#DATASOURCE#">
            INSERT INTO defaults (name, pair)
            VALUES ('dynamic', '#repeatString ("0", evaluate (4 - len (val)))##val#')
        </cfquery>
        
        <!--- log new dynamic close --->
        <cfmodule template="../functions/addTransaction.cfm"
          datasource="#DATASOURCE#"
          description="Dynamic Close Value Added"
          details="NEW DYNAMIC CLOSE VALUE: #repeatString ("0", evaluate (4 - len (val)))##val#">
          
      </cfloop>
    </cfif>
  </cfif>
  
  <!--- Check to see if they chose to delete a dynamic closing value --->
  <cfif #submit4# is "Delete">
    
    <cfif (#trim (selected_dynamic)# is not "") and (#int (val(selected_dynamic))# GT 0)>
      
      <cfquery username="#db_username#" password="#db_password#" name="delete_dynamic" datasource="#DATASOURCE#">
          DELETE FROM defaults
           WHERE name='dynamic'
             AND pair='#selected_dynamic#'
      </cfquery>
      
      <!--- log dynamic close deleted --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Dynamic Close Value Deleted"
        details="DELETED DYNAMIC CLOSE VALUE: #selected_dynamic#">
        
    </cfif>
  </cfif>
 
  <!--- Check to see if they chose to add a fee and segment value --->
  <cfif #submit5# is "Add">
    <cfset #new_value# = #replace (new_value, "$", "", "ALL")#>
    
    <cfif #right (new_value, 1)# is "%">
      <cfset #new_type# = "P">
      <cfset #new_value# = #left ("#new_value#", evaluate ("len (new_value) - 1"))#>
      <cfset #new_value# = new_value / 100>
	   <cfset #new_value# = #replace (new_value, "[^0-9.]", "", "ALL")#>
    <cfelse>
      <cfset #new_type# = "F">
    </cfif>
    
    <cfif (#trim (new_segment)# is not "") and (#isNumeric (new_segment)# is "1") and (#trim (new_value)# is not "") and (#isNumeric (new_value)# is "1")>
      <cfquery username="#db_username#" password="#db_password#" name="add_segment" datasource="#DATASOURCE#">
          INSERT INTO defaults (name, pair)
          VALUES ('scale_segment', '#repeatString ("0", evaluate (8 - len (new_segment)))##new_segment#,#new_type#,#new_value# ' )
      </cfquery>
      
      <!--- log segment added --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Fee Segment Added"
        details="NEW FEE SEGMENT: #repeatString ("0", evaluate (8 - len (new_segment)))##new_segment#,#new_type#,#new_value#">
        
    </cfif>
  </cfif>
  
  <!--- Check to see if they chose to delete a fee segment value --->
  <cfif #submit5# is "Delete">
    
    <cfif #trim (selected_segment)# is not "">
      
      <cfquery username="#db_username#" password="#db_password#" name="delete_segment" datasource="#DATASOURCE#">
          DELETE FROM defaults
           WHERE name='scale_segment'
             AND pair='#selected_segment#'
      </cfquery>
      
      <!--- log segment deleted --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Fee Segment Deleted"
        details="DELETED FEE SEGMENT: #selected_segment#">
        
    </cfif>
  </cfif>
  
  
  <!--- Add blocked ip --->
  <cfif isdefined("add_blocked_ip")>
  	<cfif new_blocked_ip neq "">
  	 <cfquery username="#db_username#" password="#db_password#" name="add_blocked_ip" datasource="#DATASOURCE#">
          INSERT INTO blocked_ip (blocked_ip)
          VALUES ('#new_blocked_ip#')
     </cfquery>
	 
	 <!--- log segment add blocked ip --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Add New Blocked IP"
        details="NEW BLOCKED IP: #new_blocked_ip#">
	 
	</cfif>
  </cfif>
  
  <!--- Delete blocked ip --->
  <cfif isdefined("delete_blocked_ip")>
  	 <cfquery username="#db_username#" password="#db_password#" name="get_del_blocked_ip" datasource="#DATASOURCE#">
          SELECT blocked_ip FROM blocked_ip
          WHERE id = #blockedip_id#
     </cfquery>
  	 <cfquery username="#db_username#" password="#db_password#" name="del_blocked_ip" datasource="#DATASOURCE#">
          DELETE FROM blocked_ip
          WHERE id = #blockedip_id#
     </cfquery>
	 
	 <!--- log segment add blocked ip --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Delete Blocked IP"
        details="DELETE BLOCKED IP: #get_del_blocked_ip.blocked_ip#">
	 
  </cfif>
  
  
  <!--- Add free no invoice user --->
  <cfif isdefined("add_noinv_user")>
  	<cfif new_noinv_user neq "">
	 <cfquery username="#db_username#" password="#db_password#" name="get_noinvuserid" datasource="#DATASOURCE#">
          SELECT user_id
		  FROM users
		  WHERE nickname = '#new_noinv_user#'
     </cfquery>
	 <cfif get_noinvuserid.recordcount gt 0>
  	 <cfquery username="#db_username#" password="#db_password#" name="add_noinvuser" datasource="#DATASOURCE#">
          INSERT INTO defaults (name, pair)
          VALUES ('noinv_user','#get_noinvuserid.user_id#')
     </cfquery>
	 
	 <!--- log segment add blocked ip --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Add New No Invoice User (#new_noinv_user#)"
        details="NEW NO INVOICE USER: #new_noinv_user#">
	  </cfif>
	</cfif>
  </cfif>
  
  <!--- Delete blocked ip --->
  <cfif isdefined("del_noinv_user")>
  	 <cfquery username="#db_username#" password="#db_password#" name="get_noinvuser_nickname" datasource="#DATASOURCE#">
          SELECT nickname
		  FROM users
		  WHERE user_id = #selected_noinv_user#
     </cfquery>
  	 <cfquery username="#db_username#" password="#db_password#" name="del_noinvuser" datasource="#DATASOURCE#">
          DELETE FROM defaults
          WHERE name = 'noinv_user'
		  AND pair = '#selected_noinv_user#'
     </cfquery>
	 
	 <!--- log segment add blocked ip --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Delete No Invoice User (#get_noinvuser_nickname.nickname#)"
        details="DELETE NO INVOICE USER: #get_noinvuser_nickname.nickname#">
	 
  </cfif>
  
 
 <!--- Run a query to find all durations --->
 <cfquery username="#db_username#" password="#db_password#" name="get_durations" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'duration'
   ORDER BY pair
 </cfquery>
 
 <!--- Run a query to find all dynamic close values --->
 <cfquery username="#db_username#" password="#db_password#" name="get_dynamics" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'dynamic'
     AND pair <> '0000'
   ORDER BY pair
 </cfquery>
 
 <!--- Run a query to find membership status  --->
 <cfquery username="#db_username#" password="#db_password#" name="get_membership_status" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'membership_sta'
    ORDER BY pair
 </cfquery>
 <!--- Run a query to find all membership  --->
 <cfquery username="#db_username#" password="#db_password#" name="get_memberships" dataSource="#DATASOURCE#">
  SELECT name, pair
    FROM defaults
   WHERE name = 'membership_opt'
    ORDER BY pair
 </cfquery>
 <!--- Run a query to find the fee scale --->
 <cfquery username="#db_username#" password="#db_password#" name="get_fee_scale" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'scale_segment'
   ORDER BY pair
 </cfquery>
 <!--- Run query to get all blocked ip --->
 <cfquery username="#db_username#" password="#db_password#" name="get_blocked_ip" datasource="#DATASOURCE#">
	SELECT * FROM blocked_ip
 </cfquery>
 <!--- Run query to get all no invoice users --->
 <cfquery username="#db_username#" password="#db_password#" name="get_noinv_users" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='noinv_user'
  </cfquery>
 
 <!--- Read the copyright footer file into a variable --->
 <cftry>
  <cffile action="read" file=#expandPath ("..\includes\copyrights.cfm")# variable="copyright_code">
  <cfcatch type="any">
   <cfset #copyright_code# = "">
  </cfcatch>
 </cftry>
 
 <!--- Read the link exchange files into variables --->
 <cftry>
  <cffile action="read" file=#expandPath ("..\includes\le_root.html")# variable="root_le_code">
  <cfcatch type="any">
   <cfset #root_le_code# = "">
  </cfcatch>
 </cftry>
 <cftry>
  <cffile action="read" file=#expandPath ("..\includes\le_primary.html")# variable="primary_le_code">
  <cfcatch type="any">
   <cfset #primary_le_code# = "">
  </cfcatch>
 </cftry>
 <cftry>
  <cffile action="read" file=#expandPath ("..\includes\le_categories.html")# variable="categories_le_code">
  <cfcatch type="any">
   <cfset #categories_le_code# = "">
  </cfcatch>
 </cftry>
 <cftry>
  <cffile action="read" file=#expandPath ("..\includes\le_featured.html")# variable="featured_le_code">
  <cfcatch type="any">
   <cfset #featured_le_code# = "">
  </cfcatch>
 </cftry>
 

 <!--- if not defined, get bid increments info --->
<cfif not IsDefined("hBidIncrements")>
  
  <cfmodule template="../functions/BidIncrements.cfm">
</cfif>

<!--- get domain blocks --->
<cfmodule template="../functions/emailBlocks.cfm"
  action="RET-DOMAINS"
  datasource="#DATASOURCE#"
  retArray="aDomainBlocks">

<!--- get account blocks --->
<cfmodule template="../functions/emailBlocks.cfm"
  action="RET-ACCOUNTS"
  datasource="#DATASOURCE#"
  retArray="aAccountBlocks">

<!--- get PairLoginPass val --->
<cfmodule template="../functions/PairLoginPass.cfm">

<!--- get iescrow icon info --->
<cfmodule template="../functions/IEscrowIcons.cfm"
  sOpt="DISP/FRONTPAGE">
  
 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 <body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999 onload="slider.init('slider',1)">
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
       <cfset #page# = "defaults">
       <cfinclude template="menu_include.cfm">
	 </table>
	 </td></tr>
       <tr>   
         <td colspan=5 bgcolor=bac1cf>
           <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=900>	    
             <tr>
               <td>
                 <table border=0 cellspacing=0 cellpadding=5 width=970 bgcolor=bac1cf>
                   <tr>
                     <td colspan=2>
                       <font face="helvetica" size=2 color=000000>Use this page to set the defaults for the operation of your auction site.  <hr size=1 color=<cfoutput>#heading_color#</cfoutput>>
                       </font>
                     </td>
                   </tr>
                   <tr>
                     <form name="defaultsForm" action="defaults.cfm" method="post">
                     <td valign="top" align="left">&nbsp;<font face="Helvetica" size=2 color=000000><b>AUCTION SITE DEFAULT SETTINGS:<cfif isdefined("error_message") and error_message neq ""> <cfoutput>#error_message#</cfoutput></cfif></b></font><br>
                       <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2 width=900>
                         <tr>

                           <td align=center>
<!--- ******************************************************* --->
<div id="slider">
                         
<!--- ******************************************************* --->
<div class="header" id="mode-header">Auction Mode</div>
  <div class="content" id="mode-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>

<tr bgcolor=687997 align="center"> 
<td colspan=4><font face="helvetica" size=2>
<b>Entire Site Auction Mode Setting</b></font></td>
                               </tr>
                               <tr>
                                 <td valign="top"><font face="helvetica" size=2>

<b>Current Settings</b></font></td>
                                 <td width=5>&nbsp;</td>
                                 <td>Mode Switch: <B><CFOUTPUT>#mode_switch#</CFOUTPUT></B> <cfif mode_switch is "Single"> All auctions will have the same mode setting.<BR>
Auction Mode: <cfif auction_mode is 0><B>Regular or Sellers Auction.</B> All auctions will accept bids which <b>increase</b> in value. <cfelse><B>Reverse or Buyers Auction.</B>  All auctions will accept bids which <b>decrease</b> in value.</cfif>
<cfelse>Each auction will have it's own mode setting.<br><br>
</cfif>
                                 </td>
                               </tr>
                           
                               
                               <!--- Change Auction Mode Settings --->
                               <tr bgcolor=687997 align="center">
                                 <td colspan=4><font face="helvetica" size=2><b>Change Entire Site Auction Mode Setting</b></font></td>
                               </tr>
                               <tr>
                                 <td valign="top"><font face="helvetica" size=2><b>New Settings</b></font></td>
                                 <td width=5>&nbsp;</td>
                                 <td>
                                 <!---change 'gte' to 'is' to disable changing modes while aucitons. are running  --->
                                 <CFIF getActiveAuctions.recordcount gte 0>
                                   <select name="mode_switch">
                                   <option value="Single"<CFIF mode_switch is "single">selected
                                 </CFIF>>Single - All auctions are either regular or reverse. </option>
	   	<option value="Dual" <CFIF mode_switch is "dual">selected
</CFIF>>Dual - Auctions can be either regular or reverse.</option>
		</select>
	<br>   




<cfif isDefined('mode_switch')>

<cfif mode_switch is "Single">


<input type="Radio" name="auction_mode" value="0" <CFIF auction_mode is 0>checked
</CFIF>> Regular or Seller's Auctions.<br>
<input type="Radio" name="auction_mode" value="1" <CFIF auction_mode is 1>checked
</CFIF>> Reverse or Buyer's Auctions.<br>


</cfif>  </cfif>

</CFIF>
<FONT FACE="" COLOR="Red">Do not change Auction mode settings  while there are active auctions running.</FONT> <BR>The last auction will end on <CFOUTPUT>#dateformat(getActiveAuctions.last,"mm/dd/yyyy")# #timeformat(getActiveAuctions.last,"HH:mm:ss")#</CFOUTPUT>
</td>
                  </tr>

</table>

</div></div>
<!--- ******************************************************* --->

<!--- ******************************************************* --->
<div class="header" id="footer-header">Header/Footer</div>
  <div class="content" id="footer-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>

                  <!--- Footer settings --->
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>Page Footer / Banner Settings</b></font></td></tr>
                  <!--- <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Copyright Footer<br>(HTML/CFML)</b></font></td>
                   <td width=5>&nbsp;</td>
                   <cfoutput><td><textarea name="copyright_code" rows=5 cols=64>#HTMLEditFormat (copyright_code)#</textarea></td></cfoutput>
                  </tr> ---><cfoutput><input type="Hidden" name="copyright_code" value="#HTMLEditFormat (copyright_code)#"></cfoutput>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Front Page<br>Banner Code:</b><br><br><input type="checkbox" name="root_le_active"<cfif #root_le_active# is "1"> checked</cfif>>Enabled</font></td>
                   <td width=5>&nbsp;</td>
                   <cfoutput><td><textarea name="root_le_code" rows=5 cols=64>#HTMLEditFormat (root_le_code)#</textarea></td></cfoutput>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Listings<br>Banner Code:</b><br><br><input type="checkbox" name="primary_le_active"<cfif #primary_le_active# is "1"> checked</cfif>>Enabled</font></td>
                   <td width=5>&nbsp;</td>
                   <cfoutput><td><textarea name="primary_le_code" rows=5 cols=64>#HTMLEditFormat (primary_le_code)#</textarea></td></cfoutput>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Categories<br>Banner Code:</b><br><br><input type="checkbox" name="categories_le_active"<cfif #categories_le_active# is "1"> checked</cfif>>Enabled</font></td>
                   <td width=5>&nbsp;</td>
                   <cfoutput><td><textarea name="categories_le_code" rows=5 cols=64>#HTMLEditFormat (categories_le_code)#</textarea></td></cfoutput>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Featured Auctions<br>Banner Code:</b><br><br><input type="checkbox" name="featured_le_active"<cfif #featured_le_active# is "1"> checked</cfif>>Enabled</font></td>
                   <td width=5>&nbsp;</td>
                   <cfoutput><td><textarea name="featured_le_code" rows=5 cols=64>#HTMLEditFormat (featured_le_code)#</textarea></td></cfoutput>
                  </tr>
 
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><!---<b>Auction Studio<br>Banner Code:</b><br><br><input type="checkbox" name="studio_le_active"<cfif #studio_le_active# is "1"> checked</cfif>>Enabled</font>---></td>
                   <td width=5>&nbsp;</td>
                   <cfoutput><td><!--- <textarea name="studio_le_code" rows=5 cols=64>#HTMLEditFormat (studio_le_code)#</textarea> ---></td></cfoutput>
                  </tr>
                  <tr><td colspan=3>&nbsp;</td></tr>
</table>
</div></div>
<!---****************************************************************--->


<!---****************************************************************--->
<div class="header" id="billing-header">Billing Types</div>
  <div class="content" id="billing-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>
				  <!--- Billing type settings --->
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>Billing Type Settings</b></font></td></tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Billing type:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><font face="helvetica" size=2><input type="radio" name="billing_type" value="per_auction" onclick="javascript:per_auc_alert()"<cfif #billing_type# is "per_auction"> checked</cfif>>Per auction&nbsp;&nbsp;&nbsp;<input type="radio" name="billing_type" value="monthly" onclick="javascript:monthly_alert()"<cfif #billing_type# is "monthly"> checked</cfif>>Monthly</font></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Site credit limit:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><cfoutput><input type="text" name="credit_limit" size=7 maxlength=10 value="#REReplace(credit_limit, "[^0-9.]", "", "ALL")#"></cfoutput><font face="helvetica" size=2>Monthly billing charges credit card of seller when auction fees plus balance reach to credit limit.</font></td>
                  </tr>
</table>
</div></div>
<!---****************************************************************--->

<!---****************************************************************--->
<div class="header" id="auction-header">Auction Settings</div>
  <div class="content" id="auction-content">
    <div class="text">
<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>
                  <!--- Auction settings --->
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>Global Auction Settings</b></font></td></tr>
  <tr>
                    <td><font face="helvetica" size=2><b>Full Graphics Mode:</b></font></td>
                    <td>&nbsp;</td>
                    <td>
                      <input type="checkbox" name="enable_thumbs"<cfif #enable_thumbs# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enable thumbnails display with featured items in first page and all listings.</font>
                   </td>
                  </tr>
<tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput>> </td></tr>

                  <tr>
                   <td><font face="helvetica" size=2><b>Items are new for:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td>
                       <select name="listing_new" width=48>
                        <cfloop from="1" to="30" index="idx"><cfoutput><option value="#idx#"<cfif #listing_new# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop>
                       </select>
                      </td>                     
                      <td><font face="helvetica" size=2>day(s)</font></td>
                     </tr>
                    </table>
                   </td> 
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Categories are<br>new for:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td>
                       <select name="category_new" width=48>
                        <cfloop from="1" to="30" index="idx"><cfoutput><option value="#idx#"<cfif #category_new# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop>
                       </select>
                      </td>                     
                      <td><font face="helvetica" size=2>day(s)</font></td>
                     </tr>
                    </table>
                   </td> 
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Bids required for<br>item to be "hot":</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td>
                       <select name="bids4hot" width=48>
                        <cfloop from="1" to="50" index="idx"><cfoutput><option value="#idx#"<cfif #bids4hot# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop>
                       </select>
                      </td>                     
                      <td><font face="helvetica" size=2>bid(s)</font></td>
                     </tr>
                    </table>
                   </td> 
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Site currency:</b></td>
                   <td width=5>&nbsp;</td>
                   <td>
                    <cfmodule template="../functions/cf_currencies.cfm"
                      mode="SELECTBOX"
                      boxname="siteCurrency"
                      selected="#siteCurrency#">
                   </td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput>> </td></tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Auction Durations:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td><select name="selected_duration" size=1 width=64><cfloop query="get_durations"><cfoutput><option value="#pair#">#int(val(pair))#</cfoutput></cfloop></select></td>
                      <td>&nbsp;</td>
                      <td><cfif #get_durations.recordcount# GT 0><input type="submit" name="submit2" value="Delete" width=64><cfelse>&nbsp;</cfif></td>
                     </tr>
                     <tr>
                      <td><input type="text" name="new_duration" size=7 maxlength=50></td>
                      <td>&nbsp;</td>
                      <td><input type="submit" name="submit2" value="Add" width=64>
                     </tr>
                    </table>
                   </td>
                  </tr>

                  <tr>                 
                   <td><font face="helvetica" size=2><b>Default duration:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="def_duration" size=1 width=48><cfloop query="get_durations"><cfoutput><option value="#pair#"<cfif #def_duration# is #int (val(pair))#> selected</cfif>>#int(val(pair))#</cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>day(s)</font></td></tr></table></td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput>></td></tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Item end date</br>turns color:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="hrsending" size=1 width=48><cfloop from="1" to="24" index="idx"><cfoutput><option value="#idx#"<cfif #hrsending# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>hours(s) before closing</font></td></tr></table></td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput>> </td></tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Category front page:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="limitcat_frpage" size=1 width=48><cfloop from="2" to="30" step="2" index="idx"><cfoutput><option value="#idx#"<cfif #limitcat_frpage# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>top level categories</font></td></tr></table></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Featured front page:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="featitemspage" size=1 width=48><cfloop from="2" to="30" step="2" index="idx"><cfoutput><option value="#idx#"<cfif #featitemspage# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>items in&nbsp;</font></td><td><select name="featcolspage" size=1 width=48><cfloop from="1" to="4" step="1" index="idx"><cfoutput><option value="#idx#"<cfif #featcolspage# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>column(s)</font></td></tr></table></td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Listings/page:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="itemsperpage" size=1 width=48><cfloop from="20" to="200" step="10" index="idx"><cfoutput><option value="#idx#"<cfif #itemsperpage# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>items</font></td></tr></table></td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Feedbacks/page:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="feedsperpage" size=1 width=48><cfloop from="5" to="100" step="5" index="idx"><cfoutput><option value="#idx#"<cfif #feedsperpage# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>feedback reports</font></td></tr></table></td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> > </td></tr>
                  <tr>
                   <td><font face="helvetica" size=2><b>Default bidding:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><font face="helvetica" size=2><input type="radio" name="def_bidding" value="regular"<cfif #def_bidding# is "regular"> checked</cfif>>Regular&nbsp;&nbsp;&nbsp;<input type="radio" name="def_bidding" value="proxy"<cfif #def_bidding# is "proxy"> checked</cfif>>Auto (Auto incrementing)</font></td>
                  </tr>
                  <tr>
                    <td>
                      <font face="helvetica" size=2>
                        <b>Max Auto Bids:</b>
                      </font>
                    </td>
                    <td width=5>&nbsp;</td>
                    <td>
                      <font face="helvetica" size=2>
                        <select name="bMaxoutProxies">
                          <option value="1" <cfif bMaxoutProxies>selected</cfif>>Yes</option>
                          <option value="0" <cfif not bMaxoutProxies>selected</cfif>>No</option>
                        </select>
                        Auto bids placed at full amount when below reserve bid.
                      </font>
                    </td>
                  </tr>
                  <!--- <tr>
                    <td>
                      <font face="helvetica" size=2>
                        <b>Login&nbsp;&&nbsp;Password:</b>
                      </font>
                    </td>
                    <td width=5>&nbsp;</td>
                    <td>
                      <font face="helvetica" size=2>
                        <select name="bPairLoginPass">
                          <option value="1" <cfif hPairLoginPass.bPair>selected</cfif>>Yes</option>
                          <option value="0" <cfif not hPairLoginPass.bPair>selected</cfif>>No</option>
                        </select>
                        Display user's login and password together on the site and in emails.
                      </font>
                    </td>
                  </tr> --->
                  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> ></td></tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Bid Increments:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>&nbsp;</b></font></td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td>
                        <select name="selected_increment" size=1 width=64>
                        <cfloop index="i" from="1" to="#ArrayLen(hBidIncrements.aIncrements)#">
                        <cfoutput><option value="#hBidIncrements.aIncrements[i]#" <cfif i IS 1>selected</cfif>>#numberformat(hBidIncrements.aIncrements[i],numbermask)#</option></cfoutput>
                        </cfloop>
                        </select>
                      </td>
                      <td>&nbsp;</td>
                      <td><input type="submit" name="submit3" value="Delete" width=64>
                     </tr>
                     <tr>
                      <td><input type="text" name="new_increment" size=7 maxlength=50></td>
                      <td>&nbsp;</td>
                      <td><input type="submit" name="submit3" value="Add" width=64>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Default value:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>&nbsp;</b></font></td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                      <tr>
                        <td>
                          <select name="def_increment" size=1 width=64>
                          <cfloop index="i" from="1" to="#ArrayLen(hBidIncrements.aIncrements)#">
                          <cfoutput><option value="#hBidIncrements.aIncrements[i]#" <cfif hBidIncrements.aIncrements[i] IS hBidIncrements.fDefIncrement>selected</cfif>>#numberformat(hBidIncrements.aIncrements[i],numbermask)#</option></cfoutput>
                          </cfloop>
                          </select>
                        </td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                  </tr>
                  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> > </td></tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Dynamic Closing:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td><select name="selected_dynamic" size=1 width=64><cfloop query="get_dynamics"><cfoutput><option value="#pair#">#int(val(pair))#</cfoutput></cfloop></select></td>
                      <td>&nbsp;</td>
                      <td><cfif #get_durations.recordcount# GT 0><input type="submit" name="submit4" value="Delete" width=64><cfelse>&nbsp;</cfif></td>
                     </tr>
                     <tr>
                      <td><input type="text" name="new_dynamic" size=7 maxlength=50></td>
                      <td>&nbsp;</td>
                      <td><input type="submit" name="submit4" value="Add" width=64>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Default value:</b></font></td>
                   <td width=5>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0 ><tr><td><select name="def_dynamic" size=1 width=64><option value="0000"<cfif #int (val(def_dynamic))# is "0"> selected</cfif>>None</option><cfloop query="get_dynamics"><cfoutput><option value="#pair#"<cfif #def_dynamic# is #int (val(pair))#> selected</cfif>>#int(val(pair))#</cfoutput></cfloop></select></td><td>&nbsp;</td><td><font face="helvetica" size=2>minute(s)</font></td></tr></table></td>
                  </tr>
                  <tr><td colspan=3>&nbsp;</td></tr>
</table>
</div></div>
<!---****************************************************************--->

<!---****************************************************************--->
<div class="header" id="free-header">Free Users</div>
  <div class="content" id="free-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>
				  
				  <!--- Free no invoice users --->
				  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>Free (Non- Invoiced) Users</b></font></td></tr>
				  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Nickname:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td><select name="selected_noinv_user" size=1 width=64>
					  	<cfloop query="get_noinv_users">
							<cfquery username="#db_username#" password="#db_password#" name="get_noinvuser_nickname" datasource="#DATASOURCE#">
          					SELECT nickname
		  					FROM users
		  					WHERE user_id = #pair#
     						</cfquery>
						<cfoutput><option value="#pair#">#get_noinvuser_nickname.nickname#</cfoutput></cfloop>
						</select>
					  </td>
                      <td>&nbsp;</td>
                      <td><cfif #get_noinv_users.recordcount# GT 0><input type="submit" name="del_noinv_user" value="Delete" width=64><cfelse>&nbsp;</cfif></td>
                     </tr>
                     <tr>
                      <td><input type="text" name="new_noinv_user" size=7 maxlength=50></td>
                      <td>&nbsp;</td>
                      <td><input type="submit" name="add_noinv_user" value="Add" width=64>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr><td colspan=3>&nbsp;</td></tr>
</table>
</div></div>
<!---****************************************************************--->

<!---****************************************************************--->
<div class="header" id="fee-header">Fees</div>
  <div class="content" id="fee-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>

                  <!--- Fee settings --->
                  <cfoutput>
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>Listing Fees &amp; Other Charges</b></font></td></tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2><b>Per item sale fee<br>sliding scale:</b></font></td>
                   <td colspan=2>
                    <table border=0 cellspacing=0 cellpadding=0 >
                     <tr>
                      <td>&nbsp;</td>
                      <td>
                       <select name="selected_segment" size=1 width=64>
                        <cfif #get_fee_scale.recordcount# gt 0>
                         <cfset #lastval# = #listGetAt ("#get_fee_scale.pair#", 1)#>
                         <cfset #lasttype# = #listGetAt ("#get_fee_scale.pair#", 2)#>
                         <cfset #lastfee# = #listGetAt ("#get_fee_scale.pair#", 3)#>
                         <cfset #last_pair# = #get_fee_scale.pair#>
                         <cfset #curval# = #listGetAt ("#get_fee_scale.pair#", 1)#>
                         <cfset #curtype# = #listGetAt ("#get_fee_scale.pair#", 2)#>
                         <cfset #curfee# = #listGetAt ("#get_fee_scale.pair#", 3)#>
                         <cfloop query="get_fee_scale" startrow=2>
                          <cfset #curval# = #listGetAt ("#pair#", 1)#>
                          <cfset #curtype# = #listGetAt ("#pair#", 2)#>
                          <cfset #curfee# = #listGetAt ("#pair#", 3)#>
                          <option value="#last_pair#">#numberformat (lastval,numbermask)# #Trim(siteCurrency)# - #numberformat (evaluate ("curval - 0.01"),numbermask)# #Trim(siteCurrency)# = <cfif #lasttype# is "P">#evaluate ("lastfee * 100")#%<cfelse>#numberformat (lastfee,numbermask)# #Trim(siteCurrency)#</cfif></option>
                          <cfset #lastval# = #curval#>
                          <cfset #lasttype# = #curtype#>
                          <cfset #lastfee# = #curfee#>
                          <cfset #last_pair# = #pair#>
                         </cfloop>
                         <cfloop query="get_fee_scale" startrow=#get_fee_scale.recordcount# endrow=#get_fee_scale.recordcount#><option value="#pair#">#numberformat (lastval,numbermask)# #Trim(siteCurrency)#+ = <cfif #curtype# is "P">#evaluate ("curfee * 100")#%<cfelse>#numberformat (curfee,numbermask)# #Trim(siteCurrency)#</cfif></option></cfloop>
                        <cfelse>
                         <option value="-1">< none ></option>
                        </cfif>
                       </select>
                      </td>
                      <td>&nbsp;</td>
                      <td><cfif #get_fee_scale.recordcount# gt 0><input type="submit" name="submit5" value="Delete" width=64><cfelse>&nbsp;</cfif></td>
                     </tr>
                     <tr>
                      <td>&nbsp;<!--- <font face="helvetica" size=2><b>$</b>&nbsp;</font> ---></td>
                      <td>
                       <table border=0 cellspacing=0 cellpadding=0 >
                        <tr>
                         <td align="center"><font face="arial" size=1>Segment:</font></td>
                         <td>&nbsp;</td>
                         <td align="center"><font face="arial" size=1>Value:</font></td>
                        </tr>
                        <tr>
                         <td><input type="text" name="new_segment" size=7 maxlength=50></td>
                         <td>&nbsp;</td>
                         <td><input type="text" name="new_value" size=7 maxlength=50></td>
                        </tr>
                       </table>
                      </td>
                      <td>&nbsp;</td>
                      <td valign="bottom"><input type="submit" name="submit5" value="Add" width=64>
                     </tr>
                    </table>
                   </td>
                  </tr>

                <!---  <tr>                 
                   <td><font face="helvetica" size=2><b>Percentage<br>of sale fee:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input type="text" name="fee_percentage" size=4 maxlength=7 value="#fee_percentage#"><font face="helvetica" size=3>&nbsp;<b>%</b></font></td>
                  </tr>
--->                  
                  
                  
                  <tr><td colspan=3>            <hr size=1 color=#heading_color# > </td></tr>
                  <tr>                 
                   <td valign="top"><font face="helvetica" size=2><b>Default Listing fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><table ><tr><td valign="top"><input type="text" name="fee_listing" size=7 maxlength=10 value="#REReplace(fee_listing, "[^0-9.]", "", "ALL")#"></td><td valign="top">&nbsp;&nbsp;&nbsp;<input type="checkbox" name="enable_cat_fee"<cfif #enable_cat_fee# is "1"> checked</cfif>></td><td valign="top"> Enable listing fee based on category setting<br><font size="1">Notice: Once you enable this function you need to set fees for individual categories in the category section.</font></td></tr></table></td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Bold name fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_bold" size=7 maxlength=10 value="#REReplace(fee_bold, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Banner line fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_banner" size=7 maxlength=10 value="#REReplace(fee_banner, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  <cfif enable_cat_fee eq 0>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Second category<br>fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_second_cat" size=7 maxlength=10 value="#REReplace(fee_second_cat, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  <cfelse>
				  <input type="hidden" name="fee_second_cat" size=7 maxlength=10 value="#REReplace(fee_second_cat, "[^0-9.]", "", "ALL")#">
				  </cfif>
<!---             <tr><td colspan=3>            <hr size=1 color=#heading_color# > </td></tr> 
--->
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Featured in<br>front page fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_featured" size=7 maxlength=10 value="#REReplace(fee_featured, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
      
      
      
      
      
      
      
      
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Featured in<br>category fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_feat_cat" size=7 maxlength=10 value="#REReplace(fee_feat_cat, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  
        				  <!--- <tr>                 
                   <td><font face="helvetica" size=2><b>Exclusive category<br> Listing fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="exclusive_cat" size=7 maxlength=10 value="#REReplace(exclusive_cat, "[^0-9.]", "", "ALL")#"></td>
                  </tr> --->

                 <tr>                 
                   <td><font face="helvetica" size=2><b>Studio<br>inclusion fee:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_studio" size=7 maxlength=10 value="#REReplace(fee_studio, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Featured in studio<br>fee:</b></font></td> 
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_feat_studio" size=7 maxlength=10 value="#REReplace(fee_feat_studio, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Image1 upload fee:</b></font></td> 
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_picture1" size=7 maxlength=10 value="#REReplace(fee_picture1, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Image2 upload fee:</b></font></td> 
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_picture2" size=7 maxlength=10 value="#REReplace(fee_picture2, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Image3 upload fee:</b></font></td> 
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_picture3" size=7 maxlength=10 value="#REReplace(fee_picture3, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Image4 upload fee:</b></font></td> 
                   <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_picture4" size=7 maxlength=10 value="#REReplace(fee_picture4, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
                  
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Reserve bid fee:</b></font></td> 
                  <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td><input type="text" name="fee_reserve_bid" size=7 maxlength=10 value="#REReplace(fee_reserve_bid, "[^0-9.]", "", "ALL")#"></td>
                  </tr> 


    <tr><td colspan=3>            <hr size=1 color=#heading_color# > </td></tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Top Sellers. :</b></font></td>
 <td align="right"><font face="helvetica" size=2><b></b></td>
                   <td>
<font size=1>
Enter the number of active auctions the seller needs to meet to become a top seller:</br>
</font>
<input type="text" name="Top_seller" size=7 maxlength=255 value="#top_seller#">

</td>
                  </tr>



                  <tr><td colspan=3>            <hr size=1 color=#heading_color# > </td></tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Late payment<br>charge:</b></font></td>
                   <td align="right"><font face="helvetica" size=2><b>$</b></td>
                   <td><input type="text" name="fee_late_charge" size=7 maxlength=10 value="#REReplace(fee_late_charge, "[^0-9.]", "", "ALL")#"></td>
                  </tr>
                  </cfoutput>
                  <tr><td colspan=3>&nbsp;</td></tr>

</table>
</div></div>
<!---****************************************************************--->

<!---****************************************************************--->
<div class="header" id="security-header">Security</div>
  <div class="content" id="security-content">
    <div class="text">

 <table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>                 
                  <!--- Email blocking --->
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>Email Blocking</b></font></td></tr>
                  <tr>
                    <td valign=top>
                      <font face="helvetica" size=2>
                        <b>Blocked Domains:</b><br>
                        <cfif not ArrayLen(aDomainBlocks)>
                          <center>
                            (None Defined)
                          </center>
                        </cfif>
                      </font>
                    </td>
                    <td align="right"><font face="helvetica" size=2>&nbsp;</font></td>
                    <td>
                      <table border=0 cellpadding=1 cellspacing=0 >
                        <cfif ArrayLen(aDomainBlocks)>
                          <tr>
                            <td>
                              <select name="lBlockedDomains">
                                <cfloop index="i" from="1" to="#ArrayLen(aDomainBlocks)#">
                                  <cfoutput><option value="#aDomainBlocks[i]#" <cfif i IS 1>selected</cfif>>#aDomainBlocks[i]#</option></cfoutput>
                                </cfloop>
                              </select>
                            </td>
                            <td><input name="subDelDomainBlock" type=submit value="Delete" width=64></td>
                          </tr>
                        </cfif>
                        <tr>
                          <td><input name="sNewDomainBlock" type=text value="" size=15></td>
                          <td><input name="subAddDomainBlock" type=submit value=" Add " width=64></td>
                        </tr>
                      </table>
                      <font size=1 face="helvetica">
                        (ie. hotmail.com, juno.com, yahoo.com, zzn.com, anti-social.com, <a href="http://fepg.net/providers.html"><font color=000080>Click for more...</font></a>)
                      </font>
                    </td>
                  </tr>
                  <tr>
                    <td valign=top>
                      <font face="helvetica" size=2>
                        <b>Blocked Accounts:</b><br>
                        <cfif not ArrayLen(aAccountBlocks)>
                          <center>
                            (None Defined)
                          </center>
                        </cfif>
                      </font>
                    </td>
                    <td align="right"><font face="helvetica" size=2>&nbsp;</font></td>
                    <td>
                      <table border=0 cellpadding=1 cellspacing=0 >
                        <cfif ArrayLen(aAccountBlocks)>
                          <tr>
                            <td>
                              <select name="lBlockedAccounts">
                                <cfloop index="i" from="1" to="#ArrayLen(aAccountBlocks)#">
                                  <cfoutput><option value="#aAccountBlocks[i]#" <cfif i IS 1>selected</cfif>>#aAccountBlocks[i]#</option></cfoutput>
                                </cfloop>
                              </select>
                            </td>
                            <td><input name="subDelAccountBlock" type=submit value="Delete" width=64></td>
                          </tr>
                        </cfif>
                        <tr>
                          <td><input name="sNewAccountBlock" type=text value="" size=15></td>
                          <td><input name="subAddAccountBlock" type=submit value=" Add " width=64></td>
                        </tr>
                      </table>
                      <font size=1 face="helvetica">
                        (ie. username@hotmail.com, username@juno.com)
                      </font>
                      <br>
                      <br>
                    </td>
                  </tr>
				  
				  <!--- IP blocking --->
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>IP Blocking</b></font></td></tr>
				  <tr>
                    <td><font face="helvetica" size=2><b>Blocked IP:</b></font></td>
					<td>&nbsp;</td>
                   	<td><select name="blockedip_id" size=1 width=20><option value="-1"><cfloop query="get_blocked_ip"><cfoutput><option value="#id#">#blocked_ip#</cfoutput></option></cfloop></select>
					<cfif #get_blocked_ip.recordcount# GT 0>&nbsp;<input type="submit" name="delete_blocked_ip" value="Delete" width=64><cfelse>&nbsp;</cfif>
					</td>
                  </tr>
				  <tr>
					<td><font face="helvetica" size=2><b>New Blocking IP:</b></font></td> 
					<td>&nbsp;</td>
					<td>
					<input type="Text" name="new_blocked_ip" size="10" maxlength="50">
					<input type="submit" name="add_blocked_ip" value="Add" width=64><br><font size=1 face="helvetica">(ie. 192.168.0.111, 192.168.0.254)</font></td>
					</td>
                  </tr>
				  <tr><td colspan=3>&nbsp;</td></tr>
				  
                  <!--- IEscrow --->
                  <!--- <tr bgcolor=687997 align="center">
                    <td colspan=4><font face="helvetica" size=2><b>eNetSettle</b></font></td>
                  </tr>
                  <tr>
                    <td><font face="helvetica" size=2><b>Use eNetSettle:</b></font></td>
                    <td>&nbsp;</td>
                    <td>
                      <input type="checkbox" name="enable_iescrow"<cfif #enable_iescrow# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enabled</font>
                    </td>
                  </tr>
                  <tr>
                    <td valign=top>
                      <font face="helvetica" size=2>
                        <b>Icon Displayed:</b><br>
                      </font>
                    </td>
                    <td align="right"><font face="helvetica" size=2>&nbsp;</font></td>
                    <td>
                      <select name="sIEIconFrontPage">
                      <cfloop index="i" from="1" to="#ArrayLen(hIEscrowIcons.aIconOptions)#">
                        <cfoutput><option value="#hIEscrowIcons.aIconOptions[i].sFile#" <cfif hIEscrowIcons.aIconOptions[i].sFile IS hIEscrowIcons.sCurrentOption>selected</cfif>>#hIEscrowIcons.aIconOptions[i].sName#</option></cfoutput>
                      </cfloop>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td valign=top>
                      <font face="helvetica" size=2>
                        <b>Icon Options:</b><br>
                      </font>
                    </td>
                    <td align="right"><font face="helvetica" size=2>&nbsp;</font></td>
                    <td valign=top>
                      <font face="helvetica" size=2>
                        <cfloop index="i" from="1" to="#ArrayLen(hIEscrowIcons.aIconOptions)#">
                          <cfoutput><img src="#hIEscrowIcons.sURL##hIEscrowIcons.aIconOptions[i].sFile#" border=0 align=top> </cfoutput>
                        </cfloop>
                        <br>
                        <br>
                      </font>
                    </td>
                  </tr> ---><input type="hidden" name="enable_iescrow" value="0">
                  
                  <!--- Misc. settings --->
                  <tr bgcolor=687997 align="center"><td colspan=4><font face="helvetica" size=2><b>SSL</b></font></td></tr>
                  <!--- <tr>
                   <td><font face="helvetica" size=2><b>New seller<br>free trial days:</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <select name="free_trial_days"><cfloop from="1" to="90" index="idx"><cfoutput><option value="#idx#"<cfif #free_trial_days# is #idx#> selected</cfif>>#idx#</option></cfoutput></cfloop></select>
                    &nbsp;&nbsp;&nbsp;<input type="checkbox" name="free_trial"<cfif #free_trial# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enabled</font>
                   </td>
                  </tr> ---><input type="hidden" name="free_trial" value="0"><input type="hidden" name="free_trial_days" value="0">
                  <tr>
                   <td><font face="helvetica" size=2><b>Secure Sockets Layer (SSL):</b></font></td>
                   <td>&nbsp;</td>
                   <td>
                    <input type="checkbox" name="enable_ssl"<cfif #enable_ssl# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Enabled</font>
                   </td>
                  </tr>
                  
<!---  --->
<!---  --->
<!---  --->
<!---  --->
</table>
</div></div>
<!---****************************************************************--->

<!--- ******************************************************* --->
<div class="header" id="membership-header">Membership</div>
  <div class="content" id="membership-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>    
  <!--- membership  --->
				  <tr><td colspan=3>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td></tr>
                  <tr>
					<td colspan=3>
                    <table border=0 cellspacing=5 cellpadding=0>
					<tr>
					 <td align="left"><font face="helvetica" size=2><b>Membership:</b></font></td>
					 <td><cfoutput><input type="checkbox"   name="membership_sta" value="1" <cfif get_membership_status.pair eq "1">checked</cfif>> Enable</cfoutput></td> 
					 <td colspan="2"><input type="submit" name="upd_membership" value="On/Off" width=64></td> 
                     </tr>
					 <tr>
                    <td valign="bottom"><font face="helvetica" size=2><b>Membership Options:</b></font></td>
                   	 <td colspan="3">fee_percentage_name_cycle<br><select name="selected_membership" size=1 width=20><option value="-1"><cfloop query="get_memberships"><cfoutput><option value="#pair#">#get_memberships.pair#</cfoutput></option></cfloop></select>
					 <cfif #get_memberships.recordcount# GT 0>&nbsp;<input type="submit" name="del_membership_opt" value="Delete" width=64><cfelse>&nbsp;</cfif>
					 </td>
                     </tr>
					 <tr>
					 <td>&nbsp;</td>
					  <td>New Fee<br><input type="Text" name="new_mbs_fee" size="3" maxlength="3"></td>
					  <td>New %<br><input type="Text" name="new_mbs_pct" size="3" maxlength="3"></td>
                      <td>New Name(1 word)<br><input type="Text" name="new_mbs_name" size="15" maxlength="15"></td>
					  <td>New cycle<br><select name="new_mbs_cycle"><option value=""><option value="LifeTime">LifeTime<option value="Annual">Annual<option value="Monthly">Monthly</select>&nbsp;<input type="submit" name="add_membership_opt" value="Add New" width=64><cfif #get_memberships.recordcount# GT 0>&nbsp;&nbsp;&nbsp;<input type="submit" name="upd_membership_opt" value="Update" width=64><cfelse>&nbsp;</cfif></td>
                     </tr>
					 
                    </table>
</table>

</div></div>
<!---****************************************************************--->

</div><!---**********************************************---> 				  


                   </td>
                  </tr>
				  
<!---  --->
<!---  --->                  
 </table>
<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=96%>                  
                  
                  
                 
                  

                  <!--- The bottom buttons --->
                  <tr><td colspan=3>    <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td></tr>
                  <tr>
                   <td colspan=3>
                    <table border=0 cellspacing=0 cellpadding=0 width=100%>
                     <tr>
                      <td><input type="submit" name="submit2" value="Save Changes"><br><br></td>
                     </tr>
                    </table>

                   </td>
                  </tr>
                 </table>
                </td>
               </tr>
              </table>
             </td>
            </form>
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



