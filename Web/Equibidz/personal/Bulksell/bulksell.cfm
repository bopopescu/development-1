<!---
/sell/bulksell.cfm
Auction items listing form.
Includes Reverse auction and Studio upgrades.
07/07/00


--->

<!--- include globals --->
<cfinclude template="../../includes/app_globals.cfm">
<!--- Include session tracking template, mostly disabled, using hidden form fields and cookies --->
<cfinclude template="../../includes/session_include.cfm">
<!--- define TIMENOW --->
<cfmodule template="../../functions/timenow.cfm">
<!--- get increments info --->
<cfmodule template="../../functions/BidIncrements.cfm">

<!--- User must be logged in, or send to index --->
<cfif isdefined("cookie.user_id") eq 0 OR cookie.user_id eq "">
	<cflocation url="index.cfm" addtoken="No">
</cfif>

<!--- If cfincluded from item_submit, get item_num for message --->
<!--- <cfif #isDefined("itemnum")#>
  <cfset theMsg = "Your item no. " & itemnum & " has been added to the auction. You may add another item using the same defaults below.">
</cfif>  --->
<cfset error_trap = "no">


<!--- If coming from set defaults page (index2.cfm), there's no form fields, convert 
session variables into local variables --->
<cfif isdefined("form.submit_item") eq 0>
	<cfinclude template="setvariables.cfm">
</cfif>
<cfinclude template="setdefaults.cfm">
<html>
 <head>
  <title>Bulk Load Sell Item Page</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 
<cfsetting enablecfoutputonly="Yes">


 
<!--- Include this module to obtain a unique item number --->
<CFMODULE TEMPLATE="../../functions/epoch.cfm">


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
  
<!--- Auto Thumb resizing  --->

<cfif isdefined("form.thumb") and form.thumb is not "">
  <cfset curPath = GetTemplatePath()>
 <cfset directory = #GetDirectoryFromPath(curPath)#>


  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.thumb"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  <cfelse>
    <cffile action="upload"
      filefield="form.thumb"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
<cfset Img_width=124>
<cfset Img_height=110>
  
<!---  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#"> --->
  <cfset thumbName = #File.Serverfile#>
  <cfif Img_height GT 110 or Img_width GT 124>
    <cfif Img_height/Img_width*100 GT 88>
<!---      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" y="110"> --->
     <cfelse>
     <!--- <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##thumbName#" x="124"> --->
    </cfif>
  </cfif>
  <cfset session.incoming = #URLEncodedFormat(File.ServerFile)#>
  <cfset session.serverfile = #File.ServerFile#>
</cfif> 
<!---


 <cfset #pic_incoming# = #File.ServerFile#>
      <cfdirectory action="list" directory="#pic_directory#" name="pic_fileRead" filter="#pic_incoming#">
      <cfset #pic_weight# = 25000>
      <cfset #session.pic_file2big# = 0>
      <cfif #pic_fileRead.size# GT #pic_weight#>
        <cffile action="delete"	file="#pic_directory##pic_incoming#">
        <cfset #pic_size# = #pic_fileRead.size# / 1000> 
        <cfset #session.pic_file2big# = 1>
      </cfif>
  </cfif>
  <cfelse>
  <cfset session.pic_file2big = 0>  
</cfif> --->
 
<cfif #isDefined("pic_incoming")# is 0>
  <cfset #incoming# = "">
</cfif>   
<cfif #isDefined("incoming")# is 0>
  <cfset #incoming# = "">
</cfif>   
<cfif #isDefined("theMsg")# is 0>
  <cfset #theMsg# = "">
</cfif>  


<cfoutput><cfinclude template="../../includes/bodytag.html"></cfoutput>
 

<!--- get currency type --->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
   SELECT pair AS type
     FROM defaults
    WHERE name = 'site_currency'
</cfquery>

<!--- Set default params --->
<cfif #isDefined ("cat")# is 0>
  <cfset #cat# = "">
</cfif>

<cfif #isDefined ("submit")# is 1>
  <cfset #submit# = #trim (submit)#>
<cfelse>
  <cfset #submit# = "">
</cfif>

<cfset itemnum = EPOCH>

<!--- Run a query to find all active categories --->
<cfquery username="#db_username#" password="#db_password#" name="get_cats" dataSource="#DATASOURCE#">
  SELECT name, category
    FROM categories
   WHERE active = 1
     AND allow_sales = 1
     AND parent > -1
   ORDER by name
</cfquery>

<!--- Run a query to find all durations  --->
<cfquery username="#db_username#" password="#db_password#" name="get_durations" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'duration'
   ORDER BY pair
</cfquery>

<!--- Run a query to find the default duration  --->
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
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture" dataSource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'get_fee_picture'
</cfquery>
<cfsetting enablecfoutputonly="No">

<!--- Calculate minimum bid when low estimate field is set --->
  		<!--- <script language="JavaScript" type="text/javascript">
  			function calc_minimum_bid(low_est){
				if (document.forms[2].low_est.value > 0){
				document.forms[2].minimum_bid.value = (document.forms[2].low_est.value) * 0.5;
				}
				}
  		</script> --->

<cfoutput>



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
    alert("Thumbnail Source above is empty.\n Please indicate the thumbnail file.")
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

 
function setLocation(){

var selObj = document.getElementById('state');
	
	var txtLocationObj = document.getElementById('txtLocation');
	
	var selIndex = selObj.selectedIndex;
	txtLocationObj.value = selObj.options[selIndex].value;
}


</script>




<body>
	<!--- Error checking --->
	<cfif #isdefined("submit_item")#>
	
		<cfif form.buynow_price gt 0>
      		<cfset buynow = 1>
  		<cfelse>
	    	<cfset buynow = 0>
  		</cfif>
		
		<cfif #title# is "">
			<cfset themsg = themsg & "Please enter title.">
		</cfif>
		<cfif #quantity# is "">
			<cfset themsg = themsg & "Please enter quantity.">
		</cfif>
		<cfif (#quantity# GT 1) and (#auction_type# is "E" or #auction_type# is "V")>
      		<cfset themsg = themsg & "This type of auction only allows 1 unit of an item to be sold."> 
  		<cfelseif (#quantity# IS 1) and (#auction_type# is "D" or #auction_type# is "Y")>
      		<cfset themsg = themsg & "This type of auction does not allow 1 unit of an item to be sold."> 
		</cfif>
		<cfif #description# is "">
			<cfset themsg = themsg & "Please enter description.">
		</cfif>
		<cfif #location# is "">
     		<cfset themsg = themsg & "Please enter a location where this item will be shipped from."> 
		</cfif>
		<cfif #country# is "">
     		<cfset themsg = themsg & "Please select a state where this item will be shipped from."> 
		</cfif>
		<!--- <cfif #end_month# is "" or #end_day# is "" or #end_year# is "">
			<cfset themsg = themsg & "Please enter month, date and year when this item will be end.">
		</cfif> --->
		<cfif #minimum_bid# is "" or minimum_bid eq 0>
			<cfset themsg = themsg & "Please enter minimum bid.">
		</cfif>
		<cfif form.auction_mode is 0 and (#auction_type# is "D" or #auction_type# is "Y") and #trim (reserve_bid)# gt 0>
      		<cfset themsg = themsg & "Reserve bid is for single-quantity items only that are not reverse or buyer's auctions. the default is 0.">
		</cfif>
		<cfif buynow eq 1 and (not isNumeric(form.buynow_price) or #form.buynow_price# lt #minimum_bid#)>
			<cfset themsg = themsg & "Please double check the buy now price for this item.">
		</cfif>
		<cfif (#pay_morder_ccheck# or #pay_am_express# or #pay_cod# or #pay_discover#
				or #pay_pcheck# or #pay_ol_escrow# or #pay_visa_mc# or #pay_other# or #pay_see_desc#) is "1">
		<cfelse>
			<cfset themsg = themsg & "Please enter payment methods.">	
		</cfif>
		<cfif (#ship_sell_pays# or #ship_buy_pays_act# or #ship_buy_pays_fxd#
				or #ship_international# or #ship_see_desc#) is 1>
		<cfelse>
			<cfset themsg = themsg & "Please enter shipping information.">
		</cfif>
		<!--- <cfif #consignor# is "">
			<cfset themsg = "Please enter consignor.">
		</cfif> --->
	<!--- Set variable when error, so it can display the value in text box --->
		<cfif #themsg# is not "">
			<cfset error_trap = "yes">
		</cfif>
		
			<cfif form.buynow_price gt 0 and form.buynow_price gte #minimum_bid#>
				<cfset buynow = 1>
			<cfelse>
				<cfset buynow = 0>
			</cfif>
	<!--- If no error include item_submit.cfm to insert item into database --->
		<cfif #themsg# is "">
 			 <cfinclude template="item_submit.cfm">
		</cfif>
	</cfif>
	<!--- End of error checking --->
	  <cfinclude template="../../includes/menu_bar.cfm">
  <!--- The main table --->
  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
   
    <tr>
			<td>
		 		<cfif auction_mode is 0>
		 			<font size=4><b>Bulk Load Post Normal Auction Page</b></font>
          <img src = "../../images/r_reverse_blank.gif" name="theFlag" width=22 height=17 border="0">
       <cfelse>
			<font size=4><b>Bulk Load Post Reverse Auction Page</b></font>
           <img src = "../../images/r_reverse.gif" name="theFlag" width=22 height=17 border="0">
         </cfif>
			 </td>
			</tr>
    <tr><td>         <hr size=1 color=#heading_color# width=100%></td></tr>
		<tr><td>
			<table>
				<tr>
				<td><form action="index2.cfm" method="post">
	<!--- send default variables as hidden form fields --->
		<input type="hidden" name="defaultlist" value="#defaultlist#">
		<input type="hidden" name="auction_mode" value="#auction_mode#">
	<cfif ListFindNoCase(defaultlist,"category1")>
		<input type="hidden" name="category1" value="#category1#">
		<input type="hidden" name="category2" value="#category2#">
		
	</cfif>
	<cfif ListFindNoCase(defaultlist,"title")>
			<input type="hidden" name="title" value="#title#">
			<input type="hidden" name="bold_title" value="#bold_title#"
	</cfif>
	<cfif ListFindNoCase(defaultlist,"location")>
			<input type="hidden" name="location" value="#location#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"state")>
			<input type="hidden" name="state" value="#state#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"country")>
			<input type="hidden" name="country" value="#country#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"description")>
			<input type="hidden" name="description" value="#description#">
	</cfif>
	<!--- <cfif ListFindNoCase(defaultlist,"high_est")>
			<input type="hidden" name="high_est" value="#high_est#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"low_est")>
			<input type="hidden" name="low_est" value="#low_est#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"condition")>
			<input type="hidden" name="condition" value="#condition#">
	</cfif> --->
	<cfif ListFindNoCase(defaultlist,"desc_languages")>
			<input type="hidden" name="desc_languages" value="#desc_languages#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"Picture_file")>
			<input type="hidden" name="Picture" value="#Picture#">
			<input type="hidden" name="picture_studio" value="#picture_studio#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"sound")>
			<input type="hidden" name="sound" value="#sound#">
			<input type="hidden" name="sound_studio" value="#sound_studio#">
	</cfif>

	<cfif ListFindNoCase(defaultlist,"thumb")>
			<input type="hidden" name="thumb" value="#thumb#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"quantity")>
			<input type="hidden" name="quantity" value="#quantity#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"minimum_bid")>
			<input type="hidden" name="minimum_bid" value="#minimum_bid#">
			<input type="hidden" name="maximum_bid" value="0">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"maximum_bid")>
			<input type="hidden" name="maximum_bid" value="#maximum_bid#">
			<input type="hidden" name="minimum_bid" value="0">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"buynow")>
			<input type="hidden" name="buynow_price" value="#buynow_price#">
			<input type="hidden" name="buynow" value="#buynow#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"increment_valu")>
			<input type="hidden" name="increment_valu" value="#increment_valu#">
			<input type="hidden" name="increment" value="#increment#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"dynamic_valu")>
			<input type="hidden" name="dynamic_valu" value="#dynamic_valu#">
			<input type="hidden" name="dynamic" value="#dynamic#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"reserve_bid")>
			<input type="hidden" name="reserve_bid" value="#reserve_bid#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"banner")>
			<input type="hidden" name="banner" value="#banner#">
			<input type="hidden" name="banner_line" value="#banner_line#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"date_start")>
			<input type="hidden" name="date_start" value="#date_start#">
			<input type="hidden" name="start_time_s" value="#start_time_s#">
			<input type="hidden" name="start_time" value="#start_time#">
			<input type="hidden" name="start_year" value="#start_year#">
			<input type="hidden" name="start_day" value="#start_day#">
			<input type="hidden" name="start_min" value="#start_min#">
			<input type="hidden" name="start_hour" value="#start_hour#">
			<input type="hidden" name="start_month" value="#start_month#">
	</cfif>
	
	<!--- <cfif ListFindNoCase(defaultlist,"date_end")>
    <!-- date_end in defaultlist -->
			<input type="hidden" name="date_end" value="#date_end#">
	<input type="hidden" name="end_time_s" value="#end_time_s#"> 
			<input type="hidden" name="end_time" value="#end_time#">
			<input type="hidden" name="end_year" value="#end_year#">
			<input type="hidden" name="end_day" value="#end_day#">
			<input type="hidden" name="end_min" value="#end_min#">
			<input type="hidden" name="end_hour" value="#end_hour#">
			<input type="hidden" name="end_month" value="#end_month#">
	</cfif> --->
	<cfif ListFindNoCase(defaultlist,"duration")>
			<input type="hidden" name="date_end" value="#date_end#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"paymethod")>
			<input type="hidden" name="pay_morder_ccheck" value="#pay_morder_ccheck#">
			<input type="hidden" name="pay_cod" value="#pay_cod#">
			<input type="hidden" name="pay_see_desc" value="#pay_see_desc#">
			<input type="hidden" name="pay_pcheck" value="#pay_pcheck#">
			<input type="hidden" name="pay_ol_escrow" value="#pay_ol_escrow#">
			<input type="hidden" name="pay_other" value="#pay_other#">
			<input type="hidden" name="pay_visa_mc" value="#pay_visa_mc#">
			<input type="hidden" name="pay_am_express" value="#pay_am_express#">
			<input type="hidden" name="pay_discover" value="#pay_discover#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"shipping")>
			<input type="hidden" name="ship_sell_pays" value="#ship_sell_pays#">
			<input type="hidden" name="ship_buy_pays_act" value="#ship_buy_pays_act#">
			<input type="hidden" name="ship_see_desc" value="#ship_see_desc#">
			<input type="hidden" name="ship_buy_pays_fxd" value="#ship_buy_pays_fxd#">
			<input type="hidden" name="ship_international" value="#ship_international#">
	</cfif>

	<cfif ListFindNoCase(defaultlist,"featured")>
			<input type="hidden" name="featured" value="#featured#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured_cat")>
			<input type="hidden" name="featured_cat" value="#featured_cat#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"private")>
			<input type="hidden" name="private" value="#private#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"")>
			<input type="hidden" name="studio" value="#studio#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"featured_studio")>
			<input type="hidden" name="featured_studio" value="#featured_studio#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"auction_type")>
			<input type="hidden" name="auction_type" value="#auction_type#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"auto_relist")>
			<input type="hidden" name="auto_relist" value="#auto_relist#">
	</cfif>
	<!--- <cfif ListFindNoCase(defaultlist,"orig_cost")>
			<input type="hidden" name="orig_cost" value="#orig_cost#">
	</cfif> --->
	<!--- <cfif ListFindNoCase(defaultlist,"wh_location")>
			<input type="hidden" name="wh_location" value="#wh_location#">
	</cfif>
	<cfif ListFindNoCase(defaultlist,"consignor")>
			<input type="hidden" name="consignor" value="#consignor#">
	</cfif> --->	
	<input type="submit" name="Submit" value="Reset Defaults">
		</form></td>
		<td>&nbsp;</td>
		<td>
		<form action="logout_bulksell.cfm" method="post">
			<input type="Submit" name="logout_bulksell" value="Log out bulksell">
		</form>
		</td>
		</tr>
	</table>
	</td>
	</tr>
		
		<!--- END send default variables as hidden form fields --->
    
		<tr>
     <td>
      <font size=3>
       This page allows you to put an items up for online auction.  Only fields you did 
			 not specify as default in the checkboxes on the previous page will display. Please
       fill out the following form to place your item(s) up for auction, remembering
       to be as accurate and honest as possible when describing your items, as set
       forth in the <A HREF="#VAROOT#/registration/user_agreement.html">User Agreement</A>.  You must be a <A HREF="#VAROOT#/registration/index.cfm">registered user</A> to sell an item.
      </font>
      <form action="bulksell.cfm" method="post" name="item_input" ENCTYPE="multipart/form-data">
       <input type="hidden" name="itemnum" value="#itemnum#">          
          <input type="Hidden" name="defaultlist" value="#defaultlist#">
       <input type="Hidden" name="auction_mode" value="#auction_mode#">
      <center><font size=2><b>Required items are in <font color="0000ff">blue</font>; all others are optional.</b></font></center>

      <cfif #theMsg# is not "">
         <br><font face="Helvetica" size=2 color=ff0000>#theMsg#<br></font>
         <cfset #theMsg# = "">
      </cfif>

     

               <hr size=1 color=#heading_color# width=100%>
      <table border=0 cellspacing=0 cellpadding=2 width=100%>
      <!--- variable set from previous page <tr>
       <td><font size=3 color="0000ff"><b>User ID or Nickname:</b></font></td>
       <td>&nbsp;</td>
       <td><input name="login" type="text" size=12 maxlength=20 value="#login#"></td>
      </tr>
      <tr>
       <td><font size=3 color="0000ff"><b>Password:</b></font></td>
       <td>&nbsp;</td>
       <td><input name="password" type="password" size=12 maxlength=12 value=""></td>
      </tr>
      <tr><td colspan=3><hr size=1 noshade></td></tr> --->
    <cfif ListFindNoCase(defaultlist,"title")>
			<input type="Hidden" name="title" value="#title#">
			<input type="Hidden" name="bold_title" value="#Bold_title#">
		<cfelse>
			<tr>
       <td><font size=3 color="0000ff"><b>Title:</b></font></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="text" size=35 maxlength=75 <cfif #error_trap# is "yes">value="#title#"<cfelse>value=""</cfif>></td><td>&nbsp;<input name="bold_title" type="checkbox" value="1"><font size=3>&nbsp;Bold title<cfif #get_fee_bold.pair# GT 0> <font size=2>(a #numberFormat(get_fee_bold.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td></tr></table></td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"banner")>
			<input type="Hidden" name="banner" value="#banner#">
			<input type="Hidden" name="banner_line" value="#banner_line#">
		<cfelse>
      <tr>
       <td><font size=3><b>Banner:</b></font></td>
       <td>&nbsp;</td>
       <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="banner_line" type="text" size=35 maxlength=45 value=""></td><td>&nbsp;<input name="banner" type="checkbox" value="1"><font size=3>&nbsp;Enable banner<cfif #get_fee_banner.pair# GT 0> <font size=2>(a #numberFormat(get_fee_banner.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td></tr></table></td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"quantity")>
			<input type="Hidden" name="quantity" value="#quantity#">
		<cfelse>	
      <tr>
       <td><font size=3 color="0000ff"><b>Quantity:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="quantity" type="text" size=5 maxlength=6 <cfif #error_trap# is "yes">value="#quantity#"<cfelse>value=""</cfif>></td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"auction_type")>
			<input type="Hidden" name="auction_type" value="#auction_type#">
		<cfelse>
      <tr>
       <td><font size=3 color="0000ff"><b>Auction Type:</b></font></td>
       <td>&nbsp;</td>   
       <td>
        <select name="auction_type">
         <option value="E">English (Normal)</option>
         <option value="D">Dutch</option>
         <option value="Y">Yankee</option>
         <option value="V">Vickrey</option>
        </select>
       </td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"description")>
			<input type="Hidden" name="description" value="#description#">
		<cfelse>
     <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Item<br>Description:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><textarea name="description" rows=5 cols=50 wrap=virtual><cfif #error_trap# is "yes">#description#</cfif></textarea></td>
      </tr>
		</cfif>
		<!--- <cfif ListFindNoCase(defaultlist,"high_est")>
			<input type="Hidden" name="high_est" value="#high_est#">
		<cfelse>
     <tr>
       <td nowrap><font size=3><b>High estimate:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="high_est" type="text" size=7 maxlength=9 value="0"></td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"low_est")>
			<input type="Hidden" name="low_est" value="#low_est#">
		<cfelse>
     <tr>
       <td><font size=3><b>Low estimate:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="low_est" type="text" size=7 maxlength=9 value="#low_est#" onblur="calc_minimum_bid()"></td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"condition")>
			<input type="Hidden" name="condition" value="#condition#">
		<cfelse>
     <tr>
       <td><font size=3><b>Condition:</b></font></td>
       <td>&nbsp;</td>
       <td>
        <select name="condition">
		 <option value="">
         <option value="Mint"<cfif #condition# is "Mint"> selected</cfif>>Mint</option>
         <option value="Excellent+"<cfif #condition# is "Excellent+"> selected</cfif>>Excellent+</option>
         <option value="Excellent"<cfif #condition# is "Excellent"> selected</cfif>>Excellent</option>
         <option value="Excellent-"<cfif #condition# is "Excellent-"> selected</cfif>>Excellent-</option>
		 <option value="Very Good+"<cfif #condition# is "Very Good+"> selected</cfif>>Very Good+</option>
         <option value="Very Good"<cfif #condition# is "Very Good"> selected</cfif>>Very Good</option>
         <option value="Very Good-"<cfif #condition# is "Very Good-"> selected</cfif>>Very Good-</option>
         <option value="Good+"<cfif #condition# is "Good+"> selected</cfif>>Good+</option>
		 <option value="Good"<cfif #condition# is "Good"> selected</cfif>>Good</option>
         <option value="Good-"<cfif #condition# is "Good-"> selected</cfif>>Good-</option>
         <option value="Fair+"<cfif #condition# is "Fair+"> selected</cfif>>Fair+</option>
         <option value="Fair"<cfif #condition# is "Fair"> selected</cfif>>Fair</option>
		 <option value="Fair-"<cfif #condition# is "Fair-"> selected</cfif>>Fair-</option>
		 <option value="Poor"<cfif #condition# is "Poor"> selected</cfif>>Poor</option>
        </select>
       </td>
      </tr>
		</cfif> --->
		<cfif ListFindNoCase(defaultlist,"desc_languages")>
			<input type="Hidden" name="desc_languages" value="#desc_languages#">
		<cfelse>
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Description<br>Languages:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
        <cfmodule template="..\..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="desc_languages" selected="en" size=5 multiple="yes">
       </td>
      </tr>
		</cfif>
		
		<cfif ListFindNoCase(defaultlist,"state")>
				<input type="Hidden" name="state" value="#state#">
		<cfelse> 
      <tr>
       <td><font size=3 color="0000ff"><b>State:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
		</cfif>
        </cfoutput>
		
				<cfif ListFindNoCase(defaultlist,"state") is 0> 
					<CFMODULE TEMPLATE="..\..\functions\cf_states.cfm"
                  SELECTNAME="state"
                  SELECTED="#state#"
                  MULTIPLE="0"
                  SIZE="1"
				  ANY="1">
				</cfif> 
			<cfoutput>
									
		
		<cfif ListFindNoCase(defaultlist,"country")>
				<input type="Hidden" name="country" value="#country#">
		<cfelse> 
      <tr>
       <td><font size=3 color="0000ff"><b>Country:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
		</cfif>
        </cfoutput>
		
				<cfif ListFindNoCase(defaultlist,"country") is 0> 
					<CFMODULE TEMPLATE="..\..\functions\cf_countries.cfm"
                  SELECTNAME="country"
                  SELECTED="USA"
                  MULTIPLE="0"
                  SIZE="1">
				</cfif> 
			
									<cfoutput>
		<cfif ListFindNoCase(defaultlist,"location")>
			<input type="Hidden" name="location" value="#location#">
		<cfelse>
      <tr>
       <td><font size=3 color="0000ff"><b>Location:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2><input name="location" id="txtLocation" type="text" size=25 maxlength=100 <cfif #error_trap# is "yes">value="#location#"<cfelse>value=""</cfif>><br><font size=2>  <b>USA:</b> Populated by the seller's shipping state override by selecting state above. <b>Other Country:</b> Enter manually.</font
	   
	   <input name="location" type="text" size=35 maxlength=100 <cfif #error_trap# is "yes">value="#location#"<cfelse>value=""</cfif>></td>
      </tr>
		</cfif>
			<cfif ListFindNoCase(defaultlist,"country") is 0> 
       </td>
      </tr>
      <tr>
       <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"date_start")>
			<input type="hidden" name="date_start" value="#date_start#">
			<input type="hidden" name="start_time_s" value="#start_time_s#">
			<input type="hidden" name="start_time" value="#start_time#">
			<input type="hidden" name="start_year" value="#start_year#">
			<input type="hidden" name="start_day" value="#start_day#">
			<input type="hidden" name="start_min" value="#start_min#">
			<input type="hidden" name="start_hour" value="#start_hour#">
			<input type="hidden" name="start_month" value="#start_month#">	
		<cfelse> 
      <tr>
       <td><font size=3 color="0000ff"><b>Start Date/Time:</b></font></td>
       <td>&nbsp;</td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <cfset #the_month# = #datePart ("m", "#timenow#")#>
          <cfset #the_day# = #datePart ("d", "#timenow#")#>
          <cfset #the_year# = #datePart ("yyyy", "#timenow#")#>
          <cfset #the_time# = #timeFormat ("#timenow#", 'hh:mm')#>
          <cfset #the_time_s# = #timeFormat ("#timenow#", 'tt')#>
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
          <td><font size=3>&nbsp;at&nbsp;</font></td>
          <td><input name="start_time" type="text" size=5 maxlength=5 value="#rereplace(the_time,"APM","","all")#"></td>
          <td>
           <select name="start_time_s">
		   
        <option value="AM"<cfif #the_time_s# is "AM"> selected</cfif>>AM</option>
            <option value="PM"<cfif #the_time_s# is "PM">
			selected</cfif>>PM</option>
           </select>
          </td>
         </tr>
        </table>
       </td>
      </tr>
		</cfif>
        <!--- <cfif ListFindNoCase(defaultlist,"date_end")>
			<input type="hidden" name="date_end" value="#date_end#">
            <input type="hidden" name="end_time_s" value="#end_time_s#"> 
			<input type="hidden" name="end_time" value="#end_time#">
			<input type="hidden" name="end_year" value="#end_year#">
			<input type="hidden" name="end_day" value="#end_day#">
			<input type="hidden" name="end_min" value="#end_min#">
			<input type="hidden" name="end_hour" value="#end_hour#">
			<input type="hidden" name="end_month" value="#end_month#">
		<cfelse> 

		 <tr valign="top"  bgcolor="##D9D9D9">
			 <td><font size=3 color="0000ff"><b>End Date/Time:</b></font></td>
       <td>&nbsp;</td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr valign="top" >
          <cfset #End_month# = #datePart ("m", "#timenow#")#>
          <cfset #End_day# = #datePart ("d", "#timenow#")#>
          <cfset #End_year# = #datePart ("yyyy", "#timenow#")#>
          <cfset #End_time# = #timeFormat ("#timenow#", 'hh:mm')#>
          <cfset #End_time_s# = #timeFormat ("#timenow#", 'tt')#>
          <td align=left>
					<select name="end_month">
				<option value="" selected>&nbsp;</option>	
            <option value="1">Jan</option>
            <option value="2">Feb</option>
            <option value="3">Mar</option>
            <option value="4">Apr</option>
            <option value="5">May</option>
            <option value="6">Jun</option>
            <option value="7">Jul</option>
            <option value="8">Aug</option>
            <option value="9">Sep</option>
            <option value="10">Oct</option>
            <option value="11">Nov</option>
            <option value="12">Dec</option>
           </select>
		   
          </td>
          <td><input name="End_day" type="text" size=2 maxlength=2 value="">,
</td>
          <td><input name="End_year" type="text" size=4 maxlength=4 value="">
</td>
          <td><font size=3>&nbsp;at&nbsp;</font></td>
          <td><input name="End_time" type="text" size=5 maxlength=5 value="#rereplace(End_time,"APM","","all")#"></td>
          <td>
           <select name="End_time_s">
              <option value="AM"<cfif #end_time_s# is "AM"> selected</cfif>>AM</option>
            <option value="PM"<cfif #end_time_s# is "PM">
			selected</cfif>>PM</option>
           </select>
          </td>
         </tr>
        </table>
       </td>
      </tr>
	  <cfif isDefined('defaultlist')>
	  <cfif defaultlist contains "date_end">
		<INPUT TYPE="hidden" NAME="End_month_required" VALUE="You must select a month when the auction ends.">
	<input type="hidden" name="End_day_required" value="You must select a day when the auction ends.">	
	<input type="hidden" name="Endt_year_required" value="You must select a year when the auction ends.">	
	</CFIF>
		</cfif></CFIF> --->
		
		<cfif ListFindNoCase(defaultlist,"duration")>
				<input type="Hidden" name="date_end" value="#date_end#">
		<cfelse>
      <tr>
       <td><font size=3 color="0000ff"><b>Auction Duration:</b></font></td>
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
          <td><font size=3>&nbsp;day(s)</font></td>
         </tr>
        </table>
       </td>
      </tr>
			</cfif>
		<cfif ListFindNoCase(defaultlist,"category1")>
			<input type="Hidden" name="category1" value="#category1#">
			<input type="Hidden" name="category2" value="#category2#">
		<cfelse>
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Categories<br>Auctioned In:</b></font></td>
       <td>&nbsp;</td>
       <td colspan=2 valign="top">
       </cfif> 
		</cfoutput>
		<cfif ListFindNoCase(defaultlist,"category1") is 0>
			<cfmodule template="..\..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category1"
                  selected="#category1#">			
        <br>
        <table border=0 cellspacing=0 cellpadding=0><tr><td>
				<cfmodule template="..\..\functions\cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  parent="0"
                  type="SELECT"
                  selectname="category2"
                  show_none="yes"
                  selected="">
				</cfif><cfoutput>
			<cfif ListFindNoCase(defaultlist,"category1") is 0>	
					</td><td><cfif #get_fee_second_cat.pair# GT 0><font size=2>(a #numberFormat(get_fee_second_cat.pair,numbermask)# #Trim(getCurrency.type)# fee for 2nd category)</font><cfelse>&nbsp;</cfif></td></tr></table>
       </td>
      </tr>
     </cfif> 
	  <cfparam name="picture" default="http://">
	 
		<cfif ListFindNoCase(defaultlist,"picture_file")>
			<input type="Hidden" name="picture" value="#picture#">
		<cfelse>
      <tr>
        <td><font size=3><b>Picture URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td><input name="picture" type="text" size=43 maxlength=250 value="http://" >
            </td><td align=center><input type="button" name="previewImage" value="Preview" 
            onClick="if (document.item_input.picture.value != 'http://') 
            openWindow ('preview_image.cfm?image=' + escape(document.item_input.picture.value) 
            + '&title=' + escape(document.item_input.title.value), 450, 300);">
            </td></tr>
          </table>
         </td>
      </tr>   
		</cfif>
		
		<cfif ListFindNoCase(defaultlist,"picture1")>
			<input type="Hidden" name="picture1" value="#picture1#">
		<cfelse>
			<tr>
        <td valign=top><font size=3><b>Full Size<br>Image:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="picture1" type="file" size=43 maxlength=250><br>
              <!--- <font size=2>A <cfif #get_fee_studio.pair# GT 0>#numberFormat(get_fee_studio.pair,numbermask)# #Trim(getCurrency.type)#</cfif> fee for Studio inclusion.
		<br>Only JPEG and GIF images are supported.  Image dimensions preferred: 124 width, 110 height pixels.  Other sizes will try to fit, and may display distorted.</font> --->
            </td></tr>
          </table>
        </td>
      </tr>   
		</cfif>
		
		<cfif ListFindNoCase(defaultlist,"picture2")>
			<input type="Hidden" name="picture2" value="#picture2#">
		<cfelse>
			<tr>
        <td valign=top><font size=3><b>Full Size<br>Image2:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="picture2" type="file" size=43 maxlength=250><br>
             
            </td></tr>
          </table>
        </td>
      </tr>   
	  </cfif>
		
	  <cfif ListFindNoCase(defaultlist,"picture3")>
			<input type="Hidden" name="picture3" value="#picture3#">
		<cfelse>
			<tr>
        <td valign=top><font size=3><b>Full Size<br>Image3:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="picture3" type="file" size=43 maxlength=250><br>
              
            </td></tr>
          </table>
        </td>
      </tr>   
	</cfif>
	
	<cfif ListFindNoCase(defaultlist,"picture4")>
			<input type="Hidden" name="picture4" value="#picture4#">
		<cfelse>
			<tr>
        <td valign=top><font size=3><b>Full Size<br>Image4:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="picture4" type="file" size=43 maxlength=250><br>
              
            </td></tr>
          </table>
        </td>
      </tr>   
	</cfif>
	
		<cfif ListFindNoCase(defaultlist,"thumb")>
			<input type="Hidden" name="thumb" value="#thumb#">
		<cfelse>
			<tr>
        <td valign=top><font size=3><b>Thumbnail<br>source:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="thumb" type="file" size=43 maxlength=250><br>
              <font size=2><cfif #get_fee_studio.pair# GT 0>A #numberFormat(get_fee_studio.pair,numbermask)# #Trim(getCurrency.type)# fee for Studio inclusion.<br></cfif>
		Only JPEG and GIF images are supported.  Image dimensions preferred: 124 width, 110 height pixels.  Other sizes will try to fit, and may display distorted.</font>
            </td></tr>
          </table>
        </td>
      </tr>   
		</cfif>
		<!--- <cfif ListFindNoCase(defaultlist,"Picture_file")>
	 <input type="Hidden" name="Picture" value="#Picture_file#">
			<input type="Hidden" name="picture_studio" value="#picture_studio#">
		<cfelse>
      <tr>
        <td valign=top><font size=3><b>Picture<br>source:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr><td>
              <input name="Picture" type="file" size=43 maxlength=250><br>
              <font size=2><!--- A <cfif #get_fee_picture.pair# GT 0>#numberFormat(get_fee_picture.pair,numbermask)# #Trim(getCurrency.type)#</cfif> fee for Picture inclusion. --->
		Only JPG  images are supported. </font>
            </td></tr>
          </table>
        </td>
      </tr>     
		</cfif> --->
		<cfif ListFindNoCase(defaultlist,"sound")>
			<input type="Hidden" name="sound" value="#sound#">
			<input type="Hidden" name="sound_studio" value="#sound_studio#">
		<cfelse>
      <tr>      
        <td><font size=3><b>Sound URL:</b></font></td>
        <td>&nbsp;</td>
        <td>
          <table border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td>
                <input name="sound" type="text" size=43 maxlength=250 value="">
              </td>
              <td>&nbsp;
               <!---  <input type="button" name="previewSound" value="Preview"  onClick="openWindow ('preview_image.cfm?image=' + escape(document.item_input.thumb_url.value) 
                + '&title=' + escape(document.item_input.title.value), 450, 300);"> --->
              </td>
            </tr>
          </table>
        </td>
      </tr>
      
      <tr>
       <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
      </tr> 

     <input name="picture_studio" type=hidden value="#picture_studio#">
     <input name="sound_studio" type=hidden value="#sound_studio#">
   </cfif>
		<cfif ListFindNoCase(defaultlist,"paymethod")>
				<input type="Hidden" name="pay_morder_ccheck" value="#pay_morder_ccheck#">
				<input type="Hidden" name="pay_am_express" value="#pay_am_express#">
				<input type="Hidden" name="pay_cod" value="#pay_cod#">
				<input type="Hidden" name="pay_discover" value="#pay_discover#">
				<input type="Hidden" name="pay_pcheck" value="#pay_pcheck#">
				<input type="Hidden" name="pay_ol_escrow" value="#pay_ol_escrow#">
				<input type="Hidden" name="pay_visa_mc" value="#pay_visa_mc#">
				<input type="Hidden" name="pay_other" value="#pay_other#">
				<input type="Hidden" name="pay_see_desc" value="#pay_see_desc#">
		<cfelse>
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Accepted<br>Payment<br>Methods:</b></font></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="pay_morder_ccheck" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_morder_ccheck# is "1">checked</cfif>><font size=3>&nbsp;Cashier's Check/Money Order</font></td>
          <td width=25>&nbsp;</td>
          <td><input name="pay_am_express" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_am_express# is "1">checked</cfif>><font size=3>&nbsp;American Express card</font></td>
         </tr>
         <tr>
          <td><input name="pay_cod" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_cod# is "1">checked</cfif>><font size=3>&nbsp;Collect-on-delivery (COD)</font></td>
          <td>&nbsp;</td>
          <td><input name="pay_discover" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_discover# is "1">checked</cfif>><font size=3>&nbsp;Discover card</font></td>
         </tr>
         <tr>
          <td><input name="pay_pcheck" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_pcheck# is "1">checked</cfif>><font size=3>&nbsp;Personal check</font></td>
          <td>&nbsp;</td>
          <td><input name="pay_ol_escrow" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_ol_escrow# is "1">checked</cfif>><font size=3>&nbsp;Online escrow</font></td>
         </tr>
         <tr>
          <td><input name="pay_visa_mc" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_visa_mc# is "1">checked</cfif>><font size=3>&nbsp;VISA/MasterCard</font></td>
          <td>&nbsp;</td>
          <td><input name="pay_other" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_other# is "1">checked</cfif>><font size=3>&nbsp;Other/Not listed here</font></td>
         </tr>
         <tr><td colspan=3><input name="pay_see_desc" type="checkbox" value="1" <cfif #error_trap# is "yes" and #pay_see_desc# is "1">checked</cfif>><font size=3>&nbsp;See item description for payment information</font></td></tr>
        </table>
       </td>
      </tr>
      <tr>

       <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
      </tr> 
		</cfif>
		<cfif ListFindNoCase(defaultlist,"shipping")>
				<input type="Hidden" name="ship_sell_pays" value="#ship_sell_pays#">
				<input type="Hidden" name="ship_buy_pays_act" value="#ship_buy_pays_act#">
				<input type="Hidden" name="ship_buy_pays_fxd" value="#ship_buy_pays_fxd#">
				<input type="Hidden" name="ship_international" value="#ship_international#">
				<input type="Hidden" name="ship_see_desc" value="#ship_see_desc#">
		<cfelse>
      <tr>
       <td valign="top"><font size=3 color="0000ff"><b>Shipping<br>Info:</b></font></td>
       <td>&nbsp;</td>
       <td valign="top" colspan=2>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <td><input name="ship_sell_pays" type="checkbox" value="1" <cfif #error_trap# is "yes" and #ship_sell_pays# is "1">checked</cfif>><font size=3>&nbsp;Seller pays shipping costs</font></td>
         </tr>
         <tr>
          <td><input name="ship_buy_pays_act" type="checkbox" value="1" <cfif #error_trap# is "yes" and #ship_buy_pays_act# is "1">checked</cfif>><font size=3>&nbsp;Buyer pays actual shipping costs</font></td>
         </tr>
         <tr>
          <td><input name="ship_buy_pays_fxd" type="checkbox" value="1" <cfif #error_trap# is "yes" and #ship_buy_pays_fxd# is "1">checked</cfif>><font size=3>&nbsp;Buyer pays fixed shipping costs</font></td>
         </tr>
         <tr>
          <td><input name="ship_international" type="checkbox" value="1" <cfif #error_trap# is "yes" and #ship_international# is "1">checked</cfif>><font size=3>&nbsp;Allow international shipping</font></td>
         </tr>
         <tr>
          <td><input name="ship_see_desc" type="checkbox" value="1" <cfif #error_trap# is "yes" and #ship_see_desc# is "1">checked</cfif>><font size=3>&nbsp;See item description for shipping information</font></td>
         </tr>
        </table>
       </td>
      </tr>
      <tr>
       <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
      </tr>
		</cfif>
		
	<!--- Display Minimum & Maximum bids according to mode settings --->
	<cfset str_minimum_bid = "Minimum Bid:">
	<cfset str_maximum_bid = "Maximum Bid:">
	<cfset str_min_description = "The minimum price at which you, the seller, are willing to start the bidding in a regular auction.">
	<cfset str_max_description = "The maximum price you, the buyer, are willing to pay in a <img src = ""../images/r_reverse.gif"" name=flag width=22 height=17 border=0>reverse auction.">




	<cfif ListFindNoCase(defaultlist,"minimum_bid") is 0>
		<cfif #error_trap# is "yes">
			<cfset minimum_bid = #minimum_bid#>
		<cfelse>
			<cfset minimum_bid = 0>
		</cfif>
	</cfif>
		


	<cfset str_input_min = "<input name=""minimum_bid"" type=""text"" size=7 maxlength=9 value=""#minimum_bid#"">"><!---  onFocus=""chk_minmax('min')"" --->
	<cfset str_input_max = "<input name=""maximum_bid"" type=""text"" size=7 maxlength=9 value=""0"" onFocus=""chk_minmax('max')"">">







	<cfset str_min_layout = "<tr>" &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_minimum_bid# </b></font></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_min#" &
		"    &nbsp;&nbsp;  #str_min_description# </td>" &
		"</tr>">

	<cfset str_max_layout = "<tr>" &
		"  <td valign=top><font size=3 color=""0000ff""><b> #str_maximum_bid# </b></font></td>" &
		"  <td>&nbsp;</td>" &
		"  <td> #str_input_max#" &
		"    &nbsp;&nbsp;  #str_max_description# </td>" &
		"</tr>">

	<!--- <cfif mode_switch is "dual">
		<cfif ListFindNoCase(defaultlist,"minimum_bid")>
					<input type="Hidden" name="minimum_bid" value="#minimum_bid#">
		<cfelse>
			#str_min_layout#
		</cfif>
		<cfif ListFindNoCase(defaultlist,"maximum_bid")>
				<input type="Hidden" name="maximum_bid" value="#maximum_bid#">
		<cfelse>
			#str_max_layout#
		</cfif>
	<cfelse> --->
		<cfif auction_mode is 0>
			<cfif ListFindNoCase(defaultlist,"minimum_bid")>
				<input type="Hidden" name="minimum_bid" value="#minimum_bid#">
			<cfelse>
				#str_min_layout#
					<input type="Hidden" name="maximum_bid" value="0">
			</cfif>
		<cfelse>
			<cfif ListFindNoCase(defaultlist,"maximum_bid")>
					<input type="Hidden" name="maximum_bid" value="#maximum_bid#">
			<cfelse>
				#str_max_layout#
				<input type="Hidden" name="minimum_bid" value="0">
			</cfif>
		</cfif>
	<!--- </cfif> --->

	<cfif ListFindNoCase(defaultlist,"reserve_bid")>
				<input type="Hidden" name="reserve_bid" value="#reserve_bid#">
		<cfelse>
    <tr>
      <td><font size=3><b>Reserve Bid:</b></font></td>
      <td><font size=3><b>&nbsp;</b></font></td>
      <td><input name="reserve_bid" type="text" size=7 maxlength=9  <cfif #error_trap# is "yes">value="#reserve_bid#"</cfif>> &nbsp; &nbsp;<b>(For single-quantity items only that are not reverse or buyer's auctions)</b></td>
    </tr>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"buynow")>
				<input type="Hidden" name="buynow_price" value="#buynow_price#">
				<input type="Hidden" name="buynow" value="#buynow#">
		<cfelse>
    <tr>
       <td><font size=3><b>Buy Now:</b></font></td>
       <td>&nbsp;</td>
       <td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><input type="text" name="buynow_price" size="7" <cfif #error_trap# is "yes">value="#buynow_price#"<cfelse>value="0"</cfif>></td><!--- <td align="left"><input type="checkbox" name="buynow" value="1"<cfif #error_trap# is "yes"><cfif #buynow# is "1"> checked</cfif></cfif>><font size=3>&nbsp;<b>Enabled</b></font></td><td>&nbsp;</td> ---></tr></table></td> 
    </tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td>&nbsp;&nbsp;(Buy now function allow users buy at the setting price without bidding process)</td>
	</tr>
	</cfif>
	<cfif ListFindNoCase(defaultlist,"increment_valu")>
			<input type="Hidden" name="increment_valu" value="#increment_valu#">
			<input type="Hidden" name="increment" value="#increment#">
		<cfelse>
    <tr>
      <td><font size=3><b>Bid Increment:</b></font></td>
      <td><font size=3><b>&nbsp;</b></font></td>
      <td>
        <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td>
              <select name="increment_valu" size=1 onFocus="singleItem()">
              <cfloop index="i" from="1" to="#ArrayLen(hBidIncrements.aIncrements)#">
              <option value="#hBidIncrements.aIncrements[i]#"<cfif increment_valu IS hBidIncrements.aIncrements[i]> selected</cfif>>#numberFormat(hBidIncrements.aIncrements[i],numbermask)#</option>
              </cfloop>
              </select>
            </td>
            <td>&nbsp;</td>
            <td><!--- <input type="hidden" name="increment" value="1"<!--- <cfif #increment# is "1"> checked</cfif> --->><font size=3>&nbsp;&nbsp;&nbsp;&nbsp;<b>(Increment is ignored if selling more than one item.)</b></font> ---></td>
          </tr>
        </table>
       </td> 
      </tr>
		</cfif>
	<cfif ListFindNoCase(defaultlist,"dynamic_valu")>
			<input type="Hidden" name="dynamic_valu" value="#dynamic_valu#">
			<input type="Hidden" name="dynamic" value="#dynamic#">
		<cfelse>
      <tr>
       <td><font size=3><b>Dynamic Bid<br>Time (minutes):</b></font></td>
       <td>&nbsp;</td>
       <td valign=top><table border=0 cellspacing=0 cellpadding=0><tr><td><select name="dynamic_valu" size=1><cfloop query="get_dynamic"><option value="#pair#">#Int(pair)#</option></cfloop></select></td><td>&nbsp;</td><td><input type="checkbox" name="dynamic" value="1"><font size=3>&nbsp;Enabled</font></td></tr></table></td> 
      </tr>
		</cfif>
      <tr>
       <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
      </tr>

      <tr>
       <td colspan="4" valign=top><font size=3><b>Other Settings:</b></font></td>
      </tr>
		<cfif ListFindNoCase(defaultlist,"featured")>
				<input type="Hidden" name="featured" value="#featured#">
		<cfelse>
			<tr>
	       <td>&nbsp;</td>
	       <td>&nbsp;</td>
		   	 <td colsppan="2"><input type="checkbox" name="featured" value="1" <cfif #error_trap# is "yes" and featured eq 1>checked</cfif>><font size=3>&nbsp;Feature this item on the front page<cfif #get_fee_featured.pair# GT 0> <font size=2>(a #numberFormat(get_fee_featured.pair,numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td>
	     </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"featured_cat")>
					<input type="Hidden" name="featured_cat" value="#featured_cat#">
		<cfelse>
			 <tr>
	       <td>&nbsp;</td>
	       <td>&nbsp;</td>
		   	 <td colsppan="2"><input type="checkbox" name="featured_cat" value="1" <cfif #error_trap# is "yes" and featured_cat eq 1>checked</cfif>><font size=3>&nbsp;Feature this item in its category(s)<cfif #get_fee_feat_cat.pair# GT 0> <font size=2>(a #numberFormat(REReplace(get_fee_feat_cat.pair, "[^0-9.]", "", "ALL"),numbermask)# #Trim(getCurrency.type)# fee)</font></cfif></font></td>
	     </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"thumb")>
				<input type="Hidden" name="featured_studio" value="#featured_studio#">
		<cfelse> 
			 <tr>
	       <td>&nbsp;</td>
	       <td>&nbsp;</td>
		   	 <td colsppan="2"><input type="checkbox" name="featured_studio" value="1" onClick="doThis()" <cfif #error_trap# is "yes" and featured_studio eq 1>checked</cfif>><font size=3>&nbsp;Feature this item in Studio.<cfif #get_fee_feat_studio.pair# GT 0> <font size=2>(a #REReplace(get_fee_feat_studio.pair, "[^0-9.]", "", "ALL")# #Trim(getCurrency.type)# fee)</font></cfif></font></td>
	     </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"auto_relist")>
				<input type="Hidden" name="auto_relist" value="#auto_relist#">
		<cfelse>
      <tr>
       <td><font size=3><B>Auto Relist</B></font></td>
       <td>&nbsp;</td>
	   <TD><INPUT TYPE="Text" NAME="auto_relist" SIZE="2" MAXLENGTH="1" <cfif #error_trap# is "yes">VALUE="#auto_relist#"</cfif>> &nbsp;&nbsp;The number of times an item will automatically relist if it does not sell.</TD>
      </tr>
		</cfif>
		<cfif ListFindNoCase(defaultlist,"private")>
				<input type="Hidden" name="private" value="#private#">
		<cfelse>
      <tr>
	     <td><font size=3><B>Private Auction</B></font></td>
       <td>&nbsp;</td>
       <td colspan=2>
	   <input type="checkbox" name="private" value="1" <cfif #error_trap# is "yes" and private eq 1>checked</cfif>><font size=3>&nbsp;Auction is private (hide E-Mail addresses)</font>

	   </td> 
      </tr>
		</cfif>
		<!--- <cfif ListFindNoCase(defaultlist,"orig_cost")>
				<input type="Hidden" name="orig_cost" value="#orig_cost#">
		<cfelse>
			<tr valign="top" >
			  <td><B>Original Cost</B></td>
     	  <td>&nbsp;</td>
        <td colspan=2><input type="text" name="orig_cost" value="0" size="20" maxlength="20">
	   <font size=3>&nbsp;</font>
		 </td> 
      </tr>
		</cfif> --->
		
		<!--- <cfif ListFindNoCase(defaultlist,"wh_location")>
				<input type="Hidden" name="wh_location" value="#wh_location#">
		<cfelse>
			<tr valign="top" >
			  <td><B>Warehouse Location</B></td>
     	  <td>&nbsp;</td>
        <td colspan=2><input type="text" name="wh_location" value="" size="20" maxlength="20">
	   <font size=3>&nbsp;</font>
		 </td> 
      </tr>
		</cfif>
		
		<cfif ListFindNoCase(defaultlist,"consignor")>
				<input type="Hidden" name="consignor" value="#consignor#">
		<cfelse>
			<tr valign="top" >
			  <td><font size=3><B>Consignor</B></font></td>
     	  <td>&nbsp;</td>
        <td colspan=2><input type="text" name="consignor" <cfif #error_trap# is "yes">value="#consignor#"<cfelse>value=""</cfif> size="20" maxlength="20">
	   <font size=3>&nbsp;</font>
		 </td> 
      </tr>
		</cfif> --->
		
		
      <tr>
       <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
      </tr> 
      <tr>
       <td colspan=4><input type="submit" name="submit_item" value="Add Item" width=75>&nbsp;&nbsp;&nbsp;<input type="reset" value="Clear" width=75></td>
      </tr> 
     </table>
    </td>
   </tr></table>
      </form>
   <div align="center">
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
            
              <cfinclude template="../../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>
 </body>
</html>





