<!---
/sell/index.cfm
Auction bulk sell items listing form.
Includes Reverse auction and Studio upgrades.
11/29/99
--->

<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">
<!--- Include session tracking template, disabled, using hidden form fields and cookies 
except for session variables used by preview--->
<cfinclude template="../../includes/session_include.cfm">
<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>
<!--- Coming from index page set up or clear defaultlist--->
<cfif isdefined("url.auction_mode")>
	<cfset auction_mode = auction_mode>
</cfif>

<cfset error_message = "">

<cfparam name = "defaultlist" default = "">

<!--- put default list into session variable --->
	<cfif isdefined("form.defaultlist")>
		<cfset defaultlist = form.defaultlist>
	</cfif>
	
<!--- set defaults so variables in form values are defined --->
	<cfinclude template="setdefaults.cfm">
<!--- If self-submit Validate required fields --->	
	<cfif isdefined("form.submit")>
		<cfinclude template="bulkvalidate.cfm">
	</cfif>
<!--- If validating bulk sell defaults, set session variables --->
<cfif error_message eq "" and IsDefined("form.defaultlist")>
<!--- Make sure images and sounds begin with http:// --->
	<cfif ListFindNoCase(defaultlist,"picture")>
		<cfif (#picture# is "") or (#left (picture, 7)# is not "http://")>
	    <cfset #picture# = "http://#picture#">
	  </cfif>
		<cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
	    <cfset #picture_studio# = "http://#picture_studio#">
	  </cfif>
				</cfif>
	<cfif ListFindNoCase(defaultlist,"sound")>
		<cfif (#sound# is "") or (#left (sound, 7)# is not "http://")>
	    <cfset #sound# = "http://#sound#">
	  </cfif>
	  <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
	    <cfset #sound_studio# = "http://#sound_studio#">
	  </cfif>
	</cfif>
  	<!--- Don't think this is used in bulk loader, but comment out and test
  
<cflock timeout="15" throwontimeout="No" name="#session.sessionID#">
		<cfset #session.held_item# = "1">
	  <cfset #session.status# = "1">
		 <cfif #isDefined ("Form.thumb")#>
		 	<cfset #studio# = "1">
		<cfelse>
			<cfset #studio# = "0">
		</cfif>
	  <cfset #session.studio# = #studio#>
	  <cfset #session.picture_studio# = #picture_studio#>
	  <cfset #session.sound_studio# = #sound_studio#>
	  <cfset #session.billmeth# = "BM">
	  <cfset #session.remote_ip# = #cgi.remote_addr#>
		<cfset session.studio = #studio#>
	</cflock> --->
	<cfif ListFindNoCase(defaultlist,"title")>
		<cfset title = form.title>
			<cfif isdefined("form.bold_title")>
				<cfset bold_title = 1>
			<cfelse>
				<cfset bold_title = 0>
			</cfif>
	</cfif>
  <cfif ListFindNoCase(defaultlist,"banner")>
			<cfif isdefined("form.banner")>
				<cfset banner = 1>
			<cfelse>
				<cfset banner = 0>
			</cfif>
			<cfset banner_line = form.banner_line>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"quantity")>
			<cfset quantity = form.quantity>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"auction_type")>
			<cfset auction_type = form.auction_type>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"description")>
			<cfset description = form.description>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"desc_languages")>
			<cfif isdefined("form.desc_languages")>
				<cfset desc_languages = form.desc_languages>
			<cfelse>
				<cfset error_message = "You must select a description language">
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"location")>
			<cfset location = form.location>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"country")>
			<cfset country = form.country>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"date_start")>
			<cfset #start_time# = "#start_time##start_time_s#">
		  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
		  <cfset #start_min# = #timeFormat (start_time, 'm')#>
		  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, Second(Now()))#>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"duration")>
			<cfset date_end = dateAdd ("d", "#duration#", date_start)>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"category1")>
			<cfset category1 = form.category1>
			<cfset category2 = form.category2>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"thumb")>
			<cfset thumb = form.thumb>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"paymethod")>
		
			<cfif isdefined("form.pay_morder_ccheck")>
				<cfset pay_morder_ccheck = 1>
			<cfelse>
				<cfset pay_morder_ccheck = 0>
			</cfif>
			<cfif isdefined("form.pay_cod")>
				<cfset pay_cod = 1>
			<cfelse>
				<cfset pay_cod = 0>
			</cfif>
			<cfif isdefined("form.pay_see_desc")>
				<cfset pay_see_desc = 1>
			<cfelse>
				<cfset pay_see_desc = 0>
			</cfif>
			<cfif isdefined("form.pay_pcheck")>
				<cfset pay_pcheck = 1>
			<cfelse>
				<cfset pay_pcheck = 0>
			</cfif>
			<cfif isdefined("form.pay_ol_escrow")>
				<cfset pay_ol_escrow = 1>
			<cfelse>
				<cfset pay_ol_escrow = 0>
			</cfif>
			<cfif isdefined("form.pay_other")>
				<cfset pay_other = 1>
			<cfelse>
				<cfset pay_other = 0>
			</cfif>
			<cfif isdefined("form.pay_visa_mc")>
				<cfset pay_visa_mc = 1>
			<cfelse>
				<cfset pay_visa_mc = 0>
			</cfif>
			<cfif isdefined("form.pay_am_express")>
				<cfset pay_am_express = 1>
			<cfelse>
				<cfset pay_am_express = 0>
			</cfif>
			<cfif isdefined("form.pay_discover")>
				<cfset pay_discover = 1>
			<cfelse>
				<cfset pay_discover = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"shipping")>
			<cfif isdefined("form.ship_sell_pays")>
				<cfset ship_sell_pays = 1>
			<cfelse>
				<cfset ship_sell_pays = 0>
			</cfif>
			<cfif isdefined("form.ship_buy_pays_act")>
				<cfset ship_buy_pays_act = 1>
			<cfelse>
				<cfset ship_buy_pays_act = 0>
			</cfif>
			<cfif isdefined("form.ship_see_desc")>
				<cfset ship_see_desc = 1>
			<cfelse>
				<cfset ship_see_desc = 0>
			</cfif>
			<cfif isdefined("form.ship_buy_pays_fxd")>
				<cfset ship_buy_pays_fxd = 1>
			<cfelse>
				<cfset ship_buy_pays_fxd = 0>
			</cfif>
			<cfif isdefined("form.ship_international")>
				<cfset ship_international = 1>
			<cfelse>
				<cfset ship_international = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"minimum_bid")>
			<cfif Form.minimum_bid is "">
      	<cfset minimum_bid = "0">
	 	 <cfelse>
				<cfset minimum_bid = REReplace("#form.minimum_bid#", "[^0123456789.]", "", "ALL")>
		 </cfif>	
	</cfif>
	<cfif ListFindNoCase(defaultlist,"maximum_bid")>
			<cfif Form.maximum_bid is "">
      	<cfset maximum_bid = "0">
	 	 <cfelse>
				<cfset maximum_bid = REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
		 </cfif>	
	</cfif>
	<cfif ListFindNoCase(defaultlist,"reserve_bid")>
		<cfif auction_mode is 0><!--- normal --->
 			<cfif Form.reserve_bid is "">
  					<cfset reserve_bid = "0">
			<cfelse>
					<cfset reserve_bid = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
 			</cfif>
	  <cfelse><!--- reverse --->
    	<cfif #Form.reserve_bid# is "" or #form.reserve_bid# is 0>
  	 	    <cfset #reserve_bid# =REReplace("#form.maximum_bid#", "[^0123456789.]", "", "ALL")>
   	 <cfelse>
    	    <cfset #reserve_bid# = REReplace("#form.reserve_bid#", "[^0123456789.]", "", "ALL")>
   	  </cfif>
    </cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"increment_valu")>
			<cfif Form.increment_valu is "">
	      <cfset increment_valu = "0">
	    <cfelse>
				<cfset increment_valu = form.increment_valu>
			</cfif>
				<cfset increment = 1>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"dynamic_valu")>
			<cfif Form.dynamic_valu is "">
      	<cfset dynamic_valu = "0">
      <cfelse>
				<cfset dynamic_valu = form.dynamic_valu>
			</cfif>
			<cfif isdefined("form.dynamic")>
				<cfset dynamic = 1>
			<cfelse>
				<cfset dynamic = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured")>
			<cfif isdefined("form.featured")>
				<cfset featured = 1>
			<cfelse>
				<cfset featured = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured_cat")>
			<cfif isdefined("form.featured_cat")>
				<cfset featured_cat = 1>
			<cfelse>
				<cfset featured_cat = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured_studio")>
			<cfif isdefined("form.featured_studio")>
				<cfset featured_studio = 1>
			<cfelse>
				<cfset featured_studio = 0>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"auto_relist")>
			<cfif auto_relist eq "">
				<cfset auto_relist = "0">
			<cfelse>	
				<cfset auto_relist = form.auto_relist>
			</cfif>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"private")>
			<cfif isdefined("form.private")>
				<cfset private = 1>
			<cfelse>
				<cfset private = 0>
			</cfif>
	</cfif>
	<cfinclude template="postdefaults.cfm">
	<cfabort>
</cfif>

<!--- get increments info --->
<cfmodule template="../../functions/BidIncrements.cfm">
 
<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">

<!--- get currency type --->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
   SELECT pair AS type
     FROM defaults
    WHERE name = 'site_currency'
</cfquery>

<!--- Run a query to find all active categories --->
<cfquery username="#db_username#" password="#db_password#" name="get_cats" dataSource="#DATASOURCE#">
  SELECT name, category
    FROM categories
   WHERE active = 1
     AND allow_sales = 1
     AND parent > -1
   ORDER by name
</cfquery>

<!--- Run a query to find all durations --->
<cfquery username="#db_username#" password="#db_password#" name="get_durations" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'duration'
   ORDER BY pair
</cfquery>

<!--- Run a query to find the default duration --->
<cfquery username="#db_username#" password="#db_password#" name="get_def_duration" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'def_duration'
   ORDER BY pair
</cfquery>
 
<!--- get all dynamic closes --->
<cfquery username="#db_username#" password="#db_password#" name="get_dynamic" datasource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'dynamic'
       AND pair <> '0000'
     ORDER BY pair
</cfquery>

<!--- Run queries to find fees --->
<cfquery username="#db_username#" password="#db_password#" name="get_fee_banner" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_banner'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_bold" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_bold'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_studio" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_studio'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_studio" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_feat_studio'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_second_cat" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_second_cat'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_cat" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_feat_cat'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_listing" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_listing'
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_featured" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'fee_featured'
</cfquery>


<html>
 <head>
  <title>Sell Item Bulk Loader Set Defaults Page</title>
   
 </head>
<!--- Some JavaScript for the "Preview" buttons --->
<script language="JavaScript">

// Opens a new browser window with no titlebar and the given size, and
// loads the given URL into it.
function openWindow (URL, width, height){
  window.open (URL, "previewWindow", "toolbar=no,statusbar=no,width=" + width + ",height=" + height);
}

function doThis(){
  if (document.item_input.thumb.value==""){
    document.item_input.featured_studio.checked=false
    alert("Thumbnail Source above is empty.\nPlease indicate the thumbnail URL source.")
  } 
}   
  
function theRFlag(){
  if (document.forms[0].auction_mode.selectedIndex == "1"){
    document.theFlag.src="../images/r_reverse.gif"
    document.forms[0].maximum_bid.value=document.forms[0].minimum_bid.value
    document.forms[0].minimum_bid.value=0
    document.forms[0].reserve_bid.value = document.forms[0].maximum_bid.value
  }else{
    document.theFlag.src="../images/r_reverse_blank.gif"
    document.forms[0].minimum_bid.value=document.forms[0].maximum_bid.value
    document.forms[0].maximum_bid.value=0
    document.forms[0].reserve_bid.value = 0      
  }
} 
  
function singleItem(){ 
  if (document.forms[0].quantity.value > 1){
    document.forms[0].dynamic_valu.focus()
  }
}    

function reverseItem(){
  if (document.forms[0].auction_mode.selectedIndex == 1){
     document.forms[0].reserve_bid.value = document.forms[0].maximum_bid.value
//     document.forms[0].increment_valu.focus() 
  }
}    

function chk_minmax(parm){
  if ((parm == "min")&&(document.forms[0].auction_mode.selectedIndex == "1")){
    document.forms[0].maximum_bid.focus()
  }
  if ((parm == "max")&&(document.forms[0].auction_mode.selectedIndex == "0")){
    if (document.forms[0].minimum_bid.value == 0){
      document.forms[0].minimum_bid.focus()
    }else{
      document.forms[0].reserve_bid.focus()
    }      
  } 
}

</script>

<body>  

 <table border=0 cellspacing=0 cellpadding=2 width=640 align="center">
    <tr><td><center><cfoutput>&nbsp; &nbsp; &nbsp; <FONT SIZE=2><cfinclude template="../../includes/menu_bar.cfm"></FONT></center><br><br></td></tr>
    <tr>
			<td>
				<cfif auction_mode is 0>
		 			<font size=4><b>Bulk Load Set Defaults Normal Auction Page</b></font>
          <img src = "../../images/r_reverse_blank.gif" name="theFlag" width=22 height=17 border="0">
       	<cfelse>
					<font size=4><b>Bulk Load Set Defaults Reverse Auction Page</b></font>
           <img src = "../../images/r_reverse.gif" name="theFlag" width=22 height=17 border="0">
         </cfif>
			</td>
		</tr>
		<tr><td><img src=#varoot#/images/spacer.gif height=8 width=2></td></tr>
    <tr>
     <td>
      
       This page allows you to put multiple items up for online auction.  The first 
			 time you fill out the page, only fill out the fields which will be the same 
			 for all items, and check the checkbox for the default fields. The page will 
			 then display only the fields which change. You can submit as many items as 
			 you want, and the default settings will be remembered.
			 Please  fill out the following form to place your item(s) up for auction, remembering
       to be as accurate and honest as possible when describing your items, as set
       forth in the <A HREF="#VAROOT#/registration/user_agreement.html">User Agreement</A>.  You must be a <A HREF="#VAROOT#/registration/index.cfm">registered user</A> to sell an item.
      </font>
      <form action="index2.cfm" method="post" name="item_input" ENCTYPE="multipart/form-data">
       <input type="hidden" name="billmeth" value="BM">
			 <input type="hidden" name="remote_ip" value="#cgi.remote_addr#">
			 <input type="hidden" name="auction_mode" value="#auction_mode#">
      <center><font size=2><b>Required items are in <font color="0000ff">blue</font>; all others are optional.</b></font></center>

      

      <cfif #error_message# is not "">
         <br><font face="Helvetica" size=2 color=ff0000><b>ERROR:</b> #error_message#<br></font>
      </cfif> 

      <img src=#varoot#/images/spacer.gif height=8 width=2>
      <table border=0 cellspacing=0 cellpadding=2 width=100%>

      
			 <td valign="top"><input type="checkbox" name="defaultlist" value="title" <cfif ListFindNoCase(defaultlist,"title")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Title:</b></td>
			 <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td><input name="title" type="text" size=35 maxlength=45 value="#title#"></td><td>&nbsp;<input name="bold_title" type="checkbox" value="1">&nbsp;Bold title<cfif #get_fee_bold.pair# GT 0> <font size=2>(a #DecimalFormat(get_fee_bold.pair)# #Trim(getCurrency.type)# fee)</font></cfif></td></tr></table></td>
      </tr>
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="banner" <cfif ListFindNoCase(defaultlist,"banner")> checked </cfif>></td>
       <td><b>Banner:</b></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td><input name="banner_line" type="text" size=35 maxlength=45 value="#banner_line#"></td><td>&nbsp;<input name="banner" type="checkbox" value="1">&nbsp;Enable banner<cfif #get_fee_banner.pair# GT 0> <font size=2>(a #DecimalFormat(get_fee_banner.pair)# #Trim(getCurrency.type)# fee)</font></cfif></td></tr></table></td>
      </tr>
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="quantity" <cfif ListFindNoCase(defaultlist,"quantity")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Quantity:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="quantity" type="text" size=5 maxlength=6 value="#quantity#"></td>
      </tr>
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="auction_type" <cfif ListFindNoCase(defaultlist,"auction_type")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Auction Type:</b></td>
       <td>&nbsp;</td>   
       <td>
        <select name="auction_type">
         <option value="E"<cfif #auction_type# is "E"> selected</cfif>>English (Normal)</option>
         <option value="D"<cfif #auction_type# is "D"> selected</cfif>>Dutch</option>
         <option value="Y"<cfif #auction_type# is "Y"> selected</cfif>>Yankee</option>
         <option value="V"<cfif #auction_type# is "V"> selected</cfif>>Vickrey</option>
        </select>
       </td>
      </tr>
     <tr valign="top"  bgcolor="##D9D9D9">
		   <td valign="top"><input type="checkbox" name="defaultlist" value="description" <cfif ListFindNoCase(defaultlist,"description")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Item<br>Description:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><textarea name="description" rows=5 cols=50 wrap=virtual>#description#</textarea></td>
      </tr>
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="desc_languages" <cfif ListFindNoCase(defaultlist,"desc_languages")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Description<br>Languages:</b></td>
       <td>&nbsp;</td></cfoutput> 
       <td colspan=2>
			 
        <cfmodule template="..\..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="desc_languages" selected="#desc_languages#" size=5 multiple="yes">
       </td>
      </tr>
      <cfoutput> 
			<tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="location" <cfif ListFindNoCase(defaultlist,"location")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Location:</b></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="location" type="text" size=35 maxlength=100 value="#location#"></td>
      </tr>
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="country" <cfif ListFindNoCase(defaultlist,"country")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Country:</b></td>
       <td>&nbsp;</td>
			 </cfoutput> 
       <td colspan=2>
        <CFMODULE TEMPLATE="..\..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="#country#"
                  MULTIPLE="0"
                  SIZE="1">
       </td>
      </tr>
      <cfoutput> 
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="date_start" <cfif ListFindNoCase(defaultlist,"date_start")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Start Date/Time:</b></td>
       <td>&nbsp;</td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr valign="top" >
          <cfset #the_month# = #datePart ("m", "#now ()#")#>
          <cfset #the_day# = #datePart ("d", "#now ()#")#>
          <cfset #the_year# = #datePart ("yyyy", "#now ()#")#>
          <cfset #the_time# = #timeFormat ("#now ()#", 'hh:mm')#>
          <cfset #the_time_s# = #timeFormat ("#now ()#", 'tt')#>
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
           </select>
          </td>
          <td><input name="start_day" type="text" size=2 maxlength=2 value="#the_day#">,</td>
          <td><input name="start_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
          <td>&nbsp;at&nbsp;</td>
          <td><input name="start_time" type="text" size=5 maxlength=5 value="#the_time#"></td>
          <td>
           <select name="start_time_s">
            <option value="AM">AM</option>
            <option value="PM">PM</option>
           </select>
          </td>
         </tr>
        </table>
       </td>
      </tr>
			<tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="duration" <cfif ListFindNoCase(defaultlist,"duration")> checked </cfif>></td>
       <td><font size=3 color="0000ff"><b>Auction Duration:</b></td>
       <td>&nbsp;</td>   
       <td>
        <table border=0 cellspacing=0 cellpadding=0>
         <tr valign="top" >
          <cfset #the_duration# = #dateDiff ("d", date_start, date_end)#> 
          <td><select name="duration">                 
           <cfloop query="get_durations">
            <option value="#int (pair)#"<cfif (#int (pair)# is #the_duration#) or (#int (pair)# is #int (get_def_duration.pair)#)> selected</cfif>>#int (pair)#</option>
           </cfloop>
           </select></td>
          <td>&nbsp;day(s)</td>
         </tr>
        </table>
       </td>
      </tr>
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="category1" <cfif ListFindNoCase(defaultlist,"category1")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Categories<br>Auctioned In:</b></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top">
        </cfoutput><cfmodule template="..\..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category1"
                  selected="#category1#"><cfoutput>
        <br>
        <table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td></cfoutput><cfmodule template="..\..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category2"
                  show_none="yes"
                  selected="#category2#"><cfoutput></td><td><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a #DecimalFormat(get_fee_second_cat.pair)# #Trim(getCurrency.type)# fee for 2nd category)</font><cfelse>&nbsp;</cfif></td></tr></table>
       </td>
      </tr>
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      
      
      <tr valign="top"  bgcolor="##D9D9D9">
			  <td valign="top"><input type="checkbox" name="defaultlist" value="picture" <cfif ListFindNoCase(defaultlist,"picture")> checked </cfif>></td>
        <td><b>Picture URL:</b></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr valign="top" ><td><input name="picture" type="text" size=43 maxlength=250 value="#picture#" >
            </td><td align=center><input type="button" name="previewImage" value="Preview" 
            onClick="if (document.item_input.picture.value != 'http://') 
            openWindow ('preview_image.cfm?image=' + escape(document.item_input.picture.value) 
            + '&title=' + escape(document.item_input.title.value), 450, 300);">
            </td></tr>
          </table>
         </td>
      </tr>         
      <tr valign="top" >
				<td valign="top"><input type="checkbox" name="defaultlist" value="thumb" <cfif ListFindNoCase(defaultlist,"thumb")> checked </cfif>></td>
        <td valign=top><b>Thumbnail<br>source:</b></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr valign="top" ><td>
              <input name="thumb" type="file" size=43 maxlength=250><br>
              <font size=2>A <cfif #get_fee_studio.pair# GT 0>#DecimalFormat(get_fee_studio.pair)# #Trim(getCurrency.type)#</cfif> fee for Studio inclusion.
		<br>Only JPEG and GIF images are supported.  Image dimensions preferred: 124 width, 110 height pixels.  Other sizes will try to fit, and may display distorted.</td></tr>
          </table>
        </td>
      </tr>   

     <tr valign="top"  bgcolor="##D9D9D9">  
				<td valign="top"><input type="checkbox" name="defaultlist" value="sound" <cfif ListFindNoCase(defaultlist,"sound")> checked </cfif>></td>
        <td><b>Sound URL:</b></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr valign="top" >
              <td>
                <input name="sound" type="text" size=43 maxlength=250 value="#sound#">
              </td>
              <td>
                <input type="button" name="previewSound" value="Preview"  onClick="openWindow ('preview_image.cfm?image=' + escape(document.item_input.thumb_url.value) 
                + '&title=' + escape(document.item_input.title.value), 450, 300);">
              </td>
            </tr>
          </table>
        </td>
      </tr>
      
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 

     <input name="picture_studio" type=hidden value="#picture_studio#">
     <input name="sound_studio" type=hidden value="#sound_studio#">
 
      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="paymethod" <cfif ListFindNoCase(defaultlist,"paymethod")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Accepted<br>Payment<br>Methods:</b></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="pay_morder_ccheck" type="checkbox" value="1"<cfif #pay_morder_ccheck# is "1"> checked</cfif>>&nbsp;Cashier's Check/Money Order</td>
          <td width=25>&nbsp;</td>
          <td><input name="pay_am_express" type="checkbox" value="1"<cfif #pay_am_express# is "1"> checked</cfif>>&nbsp;American Express card</td>
         </tr>
         <tr>
          <td><input name="pay_cod" type="checkbox" value="1"<cfif #pay_cod# is "1"> checked</cfif>>&nbsp;Collect-on-delivery (COD)</td>
          <td>&nbsp;</td>
          <td><input name="pay_discover" type="checkbox" value="1"<cfif #pay_discover# is "1"> checked</cfif>>&nbsp;Discover card</td>
         </tr>
         <tr>
          <td><input name="pay_pcheck" type="checkbox" value="1"<cfif #pay_pcheck# is "1"> checked</cfif>>&nbsp;Personal check</td>
          <td>&nbsp;</td>
          <td><input name="pay_ol_escrow" type="checkbox" value="1"<cfif #pay_ol_escrow# is "1"> checked</cfif>>&nbsp;Online escrow</td>
         </tr>
         <tr>
          <td><input name="pay_visa_mc" type="checkbox" value="1"<cfif #pay_visa_mc# is "1"> checked</cfif>>&nbsp;VISA/MasterCard</td>
          <td>&nbsp;</td>
          <td><input name="pay_other" type="checkbox" value="1"<cfif #pay_other# is "1"> checked</cfif>>&nbsp;Other/Not listed here</td>
         </tr>
         <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1"<cfif #pay_see_desc# is "1"> checked</cfif>>&nbsp;See item description for payment information</td></tr>
        </table>
       </td>
      </tr>
      <tr valign="top" >

       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="shipping" <cfif ListFindNoCase(defaultlist,"shipping")> checked </cfif>></td>
       <td valign="top"><font size=3 color="0000ff"><b>Shipping<br>Info:</b></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="ship_sell_pays" type="checkbox" value="1"<cfif #ship_sell_pays# is "1"> checked</cfif>>&nbsp;Seller pays shipping costs</td>
         </tr>
         <tr>
          <td><input name="ship_buy_pays_act" type="checkbox" value="1"<cfif #ship_buy_pays_act# is "1"> checked</cfif>>&nbsp;Buyer pays actual shipping costs</td>
         </tr>
         <tr>
          <td><input name="ship_buy_pays_fxd" type="checkbox" value="1"<cfif #ship_buy_pays_fxd# is "1"> checked</cfif>>&nbsp;Buyer pays fixed shipping costs</td>
         </tr>
         <tr>
          <td><input name="ship_international" type="checkbox" value="1"<cfif #ship_international# is "1"> checked</cfif>>&nbsp;Allow international shipping</td>
         </tr>
         <tr>
          <td><input name="ship_see_desc" type="checkbox" value="1"<cfif #ship_see_desc# is "1"> checked</cfif>>&nbsp;See item description for shipping information</td>
         </tr>
        </table>
       </td>
      </tr>
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr>

	<!--- Display Minimum & Maximum bids according to mode settings --->
	<cfset str_minimum_bid = "Minimum Bid:">
	<cfset str_maximum_bid = "Maximum Bid:">
	<cfset str_min_description = "The minimum price at which you, the seller, are willing to start the bidding in a regular auction.">
	<cfset str_max_description = "The maximum price you, the buyer, are willing to pay in a <img src = ""../images/r_reverse.gif"" name=flag width=22 height=17 border=0>reverse auction.">

	<cfset str_input_min = "<input name=""minimum_bid"" type=""text"" size=7 maxlength=9 value=""#minimum_bid#"" onFocus=""chk_minmax('min')"">">
	<cfset str_input_max = "<input name=""maximum_bid"" type=""text"" size=7 maxlength=9 value=""#maximum_bid#"" onFocus=""chk_minmax('max')"">">

	<cfset str_min_layout = "<tr>" & 
	  "  <td><input type=""checkbox"" name=""defaultlist"" value=""minimum_bid""></td> " &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_minimum_bid# </b></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_min#" &
		"    &nbsp;&nbsp;  #str_min_description# </td>" &
		"</tr>">

	<cfset str_max_layout = "<tr>" &
	"  <td><input type=""checkbox"" name=""defaultlist"" value=""maximum_bid""></td> " &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_maximum_bid# </b></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_max#" &
		"    &nbsp;&nbsp;  #str_max_description# </td>" &
		"</tr>">
		<cfif auction_mode is 0>
			#str_min_layout#
			<input type="Hidden" name="maximum_bid" value="0">
		<cfelse>
			#str_max_layout#
			<input type="Hidden" name="minimum_bid" value="0">
		</cfif>


    <tr valign="top"  bgcolor="##D9D9D9">
		  <td valign="top"><input type="checkbox" name="defaultlist" value="reserve_bid" <cfif ListFindNoCase(defaultlist,"reserve_bid")> checked </cfif>></td>
      <td><b>Reserve Bid:</b></td>
      <td><b>&nbsp;</b></td>
      <td><input name="reserve_bid" type="text" size=7 maxlength=9 value="#reserve_bid#" onFocus="reverseItem()"> &nbsp; &nbsp;<b>(For single-quantity items only that are not reverse or buyer's auctions)</b></td>
    </tr>
	
    <tr valign="top" >
		  <td valign="top"><input type="checkbox" name="defaultlist" value="increment_valu" <cfif ListFindNoCase(defaultlist,"increment_valu")> checked </cfif>></td>
      <td><b>Bid Increment:</b></td>
      <td><b>&nbsp;</b></td>
      <td>
        <table border=0 cellspacing=0 cellpadding=0>
          <tr valign="top" >
            <td>
              <select name="increment_valu" size=1 onFocus="singleItem()">
              <cfloop index="i" from="1" to="#ArrayLen(hBidIncrements.aIncrements)#">
              <option value="#hBidIncrements.aIncrements[i]#"<cfif increment_valu IS hBidIncrements.aIncrements[i]> selected</cfif>>#DecimalFormat(hBidIncrements.aIncrements[i])#</option>
              </cfloop>
              </select>
            </td>
            <td>&nbsp;</td>
            <td><input type="hidden" name="increment" value="1"<!--- <cfif #increment# is "1"> checked</cfif> --->>&nbsp;&nbsp;&nbsp;&nbsp;<b>(Increment is ignored if selling more than one item.)</b></td>
          </tr>
        </table>
       </td> 
      </tr>
      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="dynamic_valu" <cfif ListFindNoCase(defaultlist,"dynamic_valu")> checked </cfif>></td>
       <td><b>Dynamic Bid<br>Time (minutes):</b></td>
       <td>&nbsp;</td>
       <td valign=top><table border=0 cellspacing=0 cellpadding=0><tr valign="top" ><td><select name="dynamic_valu" size=1><cfloop query="get_dynamic"><option value="#pair#"<cfif #dynamic_valu# is #pair#> selected</cfif>>#Int(pair)#</option></cfloop></select></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"<cfif #dynamic# is "1"> checked</cfif>>&nbsp;Enabled</td></tr></table></td> 
      </tr>
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr>

      <tr valign="top" >
			 <td valign="top"><input type="checkbox" name="defaultlist" value="featured" <cfif ListFindNoCase(defaultlist,"featured")> checked </cfif>><br>
			 <input type="checkbox" name="defaultlist" value="featured_cat" <cfif ListFindNoCase(defaultlist,"featured_cat")> checked </cfif>><br>
			 <input type="checkbox" name="defaultlist" value="featured_studio" <cfif ListFindNoCase(defaultlist,"featured_studio")> checked </cfif>>
			 </td>
       <td valign=top><b>Other Settings:</b></td>
       <td>&nbsp;</td>
       
       <td colspan=2><input type="checkbox" name="featured" value="1"<cfif #featured# is "1"> checked</cfif>>&nbsp;Feature this item on the front page<cfif #get_fee_featured.pair# GT 0> <font size=2>(a #DecimalFormat(get_fee_featured.pair)# #Trim(getCurrency.type)# fee)</font></cfif></font>
	<br><input type="checkbox" name="featured_cat" value="1"<cfif #featured_cat# is "1"> checked</cfif>>&nbsp;Feature this item in its category(s)<cfif #get_fee_feat_cat.pair# GT 0> <font size=2>(a #DecimalFormat(REReplace(get_fee_feat_cat.pair, "[^0-9.]", "", "ALL"))# #Trim(getCurrency.type)# fee)</font></cfif></font>
	<br><input type="checkbox" name="featured_studio" value="1"<cfif #featured_studio# is "1">checked</cfif> onClick="doThis()">&nbsp;Feature this item in Studio.<cfif #get_fee_feat_studio.pair# GT 0> <font size=2>(a #DecimalFormat(REReplace(get_fee_feat_studio.pair, "[^0-9.]", "", "ALL"))# #Trim(getCurrency.type)# fee)</font></cfif></td> 
      </tr>


      <tr valign="top"  bgcolor="##D9D9D9">
			 <td valign="top"><input type="checkbox" name="defaultlist" value="auto_relist" <cfif ListFindNoCase(defaultlist,"auto_relist")> checked </cfif>></td>
       <td><B>Auto Relist</B></td>
       <td>&nbsp;</td>
	   <TD><INPUT TYPE="Text" NAME="auto_relist" VALUE="#auto_relist#" SIZE="2" MAXLENGTH="1"> &nbsp;&nbsp;The number of times an item will automatically relist if it does not sell.</TD>
      </tr>


      <tr valign="top" >
			<td valign="top"><input type="checkbox" name="defaultlist" value="private" <cfif ListFindNoCase(defaultlist,"private")> checked </cfif>></td>
	  <td><B>Private Auction</B></td>
       <td>&nbsp;</td>
       <td colspan=2>
	   <input type="checkbox" name="private" value="1" <cfif #private# is "1"> checked</cfif>>&nbsp;Auction is private (hide E-Mail addresses)</td> 
      </tr>
			<tr valign="top" >
			<td valign="top"><input type="checkbox" name="defaultlist" value="orig_cost" <cfif ListFindNoCase(defaultlist,"orig_cost")> checked </cfif>></td>
	  <td><B>Original Cost</B></td>
       <td>&nbsp;</td>
       <td colspan=2><input type="text" name="orig_cost" value="#orig_cost#" size="10">
	   &nbsp;</td> 
      </tr>
      <tr valign="top" >
       <td colspan=4><img src=#varoot#/images/spacer.gif height=8 width=2></td>
      </tr> 
      <tr valign="top" >
       <td colspan=4><input type="submit" id="submit" name="submit" value="Set bulk load defaults" width=75>&nbsp;&nbsp;&nbsp;<input type="reset" id="submit" value="Clear" width=75></td>
      </tr> 
     </table>
    </td>
   </tr>
      </form>
    <tr valign="top" ><td><br><br><img src=#varoot#/images/spacer.gif height=8 width=2></td></tr>
    <tr valign="top" ><td align="left"><cfinclude template="../../includes/copyrights.cfm"></td></tr>
    </form>
   </table>
   </center>
   <br>
  </cfoutput>
 </body>
</html>



</body>
</html>
