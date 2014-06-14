<!--- classified/admin/classified_item.cfm
      Visual Auction 4 Administrator [Classifieds Module: Edit/Add Classified Ad]
--->
<cfsetting EnableCFOutputOnly="YES">

<cfinclude template = "../../includes/app_globals.cfm">

 <!--- Always check for valid username/password --->
 <cfinclude template="../../admin/validate_include.cfm">
<!--- 
 <cfparam name="community_ad" default="0">
--->
 
 <cfif #isDefined ("submit")#>
  <cfif #submit# is "Done">
   <cflocation url="ad_mngr.cfm">
  </cfif>
 <cfelse>
  <cfset #submit# = "">
 </cfif>
 

 <!--- get a unique ID for adnum in case needed --->
 <CFMODULE TEMPLATE="../../functions/epoch.cfm">

 <!-- get currency type -->
<cfquery name="getCurrency" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT pair AS type
      FROM defaults
     WHERE name = 'site_currency'
</cfquery>
 
 <!--- Define a dummy user for now --->
 <cfset #user_id# = "0">

 <cfset category2 = 0><!--- Category 2 not implemented.  Supposed to be -1. --->

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
 <cfif #submit# is "Edit">
  <cfset #adnum#="#selected_item#">
 <cfelseif #submit# is "Add">
  <cfset #adnum#="#EPOCH#">
 </cfif>

 <!--- Get a list of active users --->
 <cfquery name="get_users" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT user_id, name, nickname
    FROM users
   WHERE is_active = 1
   ORDER BY nickname
 </cfquery>

 <!--- Get the last user they chose as the seller  --->
 <cfquery name="get_seller" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT pair
    FROM defaults
   WHERE name = 'last_seller'
 </cfquery>

 <!--- Check to see if they're cancelling. --->
 <cfif #submit2# is "Cancel">
  <cfoutput><cflocation url="./ad_mngr.cfm?selected_category=#selected_category#&submit=expand&selected_item=#selected_item#"></cfoutput>
 </cfif>

  <!--- Check to see if we need to delete an item. --->
  <cfif #submit2# is "Delete" or #submit# is "Delete">

    <cfquery name="delete_item" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
        DELETE
          FROM ad_info
         WHERE adnum = #selected_item#
    </cfquery>

    <!--- log deletion of item --->
    <cfmodule template="../../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      db_username="#db_username#"
      db_password="#db_password#"
      description="Ad Deleted by Administrator"
      itemnum="#selected_item#">

    <cfoutput><cflocation url="./ad_mngr.cfm?selected_category=#selected_category#&submit=expand"></cfoutput>
  </cfif>

 <!--- If defined, merge the separate date and time objects into 1 object --->
 <cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
 </cfif>

 <cfif #isDefined ("ask_price")#>
  <cfif #ask_price# is "">
   <cfset #ask_price# = "0">
  <cfelse>
   <cfset ask_price = Trim(REReplace("#ask_price#", "[^0123456789.]", "", "ALL"))>
  </cfif>
 </cfif>
 <cfif #isDefined ("status")#>
  <cfset #status# = 1>
 <cfelse>
  <cfset #status# = 0>
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

 <!--- Set defaults for all the form variables --->
 <cfif ((#submit# is "Edit") or (#submit# is "Add")) and (#submit2# is "enter")>
  <cfset #status# = "">
  <cfif #submit# is "Add">
   <cfset #selected_item# = "#EPOCH#">
   <cfset #selected_user# = "#get_seller.pair#">
   <cfset #status# = "1">
  </cfif>
  <cfset #user_id# = "">
  <cfset #category1# = "#selected_category#">
  <cfset #category2# = "">
  <cfset #title# = "">
  <cfset #ad_body# = "">
  <cfset #ask_price# = "">
  <cfset #picture_url# = "http://">
  <cfset #date_start# = #now ()#>
  <cfset #date_end# = #now ()#>
  <cfset #seller_email# = "">
<!---
  <cfset #ad_dur# = 0>
  <cfset #ad_fee# = 0>
--->
 </cfif>

  <!--- if we're editing an ad, ... --->
  <cfif (#submit# is "Edit") ><!--- or (#submit2# is "enter") **** Removed to fix Add function --->
    
    <cfquery name="get_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
        SELECT adnum,
               status,
               user_id,
               category1,
               category2,
               title,
               ad_body,
			            ask_price,
               picture_url,
               date_start,
               date_end,
			            <!--- community_ad, --->
			            ad_dur,
			            ad_fee
          FROM ad_info
         WHERE adnum = #selected_item#
    </cfquery>
    
    <cfset #selected_category# = #get_ad.category1#>
    
    <!--- Get the advertiser's email address --->
    <cfquery name="get_seller_email" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
        SELECT email
          FROM users
         WHERE user_id = #get_ad.user_id#
    </cfquery>
    
    <cfset #seller_email# = "#get_seller_email.email#">
    
    <cfset #adnum# = "#get_ad.adnum#"> 
    <cfset #the_item# = "#get_ad.adnum#">
    <cfset #status# = "#get_ad.status#">
    <cfset #user_id# = "#get_ad.user_id#">
    <cfset #category1# = "#get_ad.category1#">
    <cfset #category2# = "#get_ad.category2#">
    <cfset #title# = "#get_ad.title#">
    <cfset #ad_body# = "#get_ad.ad_body#">
    <cfset #ask_price# = "#get_ad.ask_price#">
    <cfset #picture_url# = #trim ("#get_ad.picture_url#")#>
    <cfif (#picture_url# is "") or (#left (picture_url, 7)# is not "http://")>
      <cfset #picture_url# = "http://#picture_url#">
    </cfif>
    <cfset #date_start# = "#get_ad.date_start#">
    <cfset #date_end# = "#get_ad.date_end#">
   <!---  <cfset #community_ad# = "#community_ad#"> --->
   <cfset #ad_dur# = "#get_ad.ad_dur#">
  	<cfset #ad_fee# = "#get_ad.ad_fee#">
   <cfset #selected_user# = "#get_ad.user_id#">
  </cfif>
  
 <!--- get all active categories --->
 <cfquery name="get_cats" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT name, category
    FROM categories
   WHERE active = 1
     AND parent > -1
   ORDER by name
 </cfquery>

 <!--- get all durations --->
 <cfquery name="get_durations" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT ad_dur, ad_fee
    FROM ad_defaults
 </cfquery>
 
 <!--- get the ad duration ---><!--- **** --->
 <cfquery name="get_ad_duration" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT ad_dur, ad_fee
    FROM ad_defaults
	  WHERE ad_fee in (SELECT ad_fee FROM ad_info
	                    WHERE adnum = #selected_item#)
 </cfquery>

 <!--- get the default duration 
 <cfquery name="get_def_duration" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT pair
    FROM defaults
   WHERE name = 'def_duration'
   ORDER BY pair
 </cfquery>
 --->

 <!--- Reset the error message string --->
 <cfset #error_message# = "">

 <!--- Check the form for valid data --->
 <cfif #submit2# is "Save">
  <cfif #trim (title)# is "">
   <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
  <cfelseif #trim (ad_body)# is "">
   <cfset #error_message# = "<font color=ff0000>Please enter a description of this item.</font>"> 
  <cfelseif (#category1# is "-1") and (#category2# is "-1")><!--- **** --->
   <cfset #error_message# = "<font color=ff0000>Please specify at least 1 category for this item.</font>"> 
  <cfelseif (#trim (ask_price)# is "") or (#isNumeric (ask_price)# is "0")>
   <cfset #error_message# = "<font color=ff0000>Please specify an asking price for this item.</font>"> 
  </cfif>
 </cfif>

  <!--- Check to see if we're saving an ad --->
  <cfif #submit2# is "Save">
    <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
  </cfif>

  <cfif (#submit2# is "Save") and (#error_message# is "")>

  <cfquery name="getFeeForSelectedDuration" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT ad_fee AS selected_fee
      FROM ad_defaults
     WHERE ad_dur = #duration#
  </cfquery>
    
    <cfif #submit# is "Edit">
      
      <!--- Make sure images begin with http:// --->
      <cfif (#picture_url# is "") or (#left (picture_url, 7)# is not "http://")>
        <cfset #picture_url# = "http://#picture_url#">
      </cfif>
      <!---<cfif (#picture_studio# is "") or (#left (picture_studio, 7)# is not "http://")>
        <cfset #picture_studio# = "http://#picture_studio#">
      </cfif>
      <cfif (#sound_studio# is "") or (#left (sound_studio, 7)# is not "http://")>
        <cfset #sound_studio# = "http://#sound_studio#">
      </cfif>--->
      
      <cfquery name="update_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
          UPDATE ad_info  
             SET status = #status#,
                 user_id = #Form.selected_user#,
                 category1 = #Form.category1#,
                 <!--- category2 = #category2#, --->
                 title = '#Form.title#',
                 ad_body = '#Form.ad_body#',
                 ask_price = #Form.ask_price#,
                 picture_url = '#Form.picture_url#',
                 date_start = #createODBCDateTime (date_start)#,
                 date_end = #createODBCDateTime (date_end)#,
			              <!---   community_ad = #community_ad#, --->
		               ad_dur = #Form.duration#,				  
			              ad_fee = #getFeeForSelectedDuration.selected_fee#				  
           WHERE adnum = #selected_item#
      </cfquery>
      
      <!--- log update of auction ---> <!--- **** A few more details to add, perhaps **** Redo for ad_trans_log --->
      <cfmodule template="../../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        db_username="#db_username#"
        db_password="#db_password#"
        description="Ad Information Updated by Administrator"
        itemnum="#selected_item#"
        details="TITLE: #title#     STATUS: #status#     DATE START: #createODBCDateTime(date_start)#    DATE END: #createODBCDateTime(date_end)#     ASK_PRICE: #ask_price#     CATEGORY 1: #category1#     CATEGORY 2: #category2#"
        user_id="#selected_user#">
        
    <cfelse>

      <cfquery name="insert_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
          INSERT INTO ad_info
            (adnum,
			          status,
             user_id,
             category1,
             category2,
             title,
             ad_body,
             ask_price,
             picture_url,
             date_start,
             date_end,
             <!--- community_ad, --->
             ad_dur,
			          ad_fee,             
             remote_ip)
     VALUES (#selected_item#,
	            #status#,
             #selected_user#,
             #category1#,
             #category2#,
             '#title#',
             '#ad_body#',
             #ask_price#,
             '#picture_url#',
             #createODBCDateTime (date_start)#,
             #createODBCDateTime (date_end)#,
             #duration#,
			          #getFeeForSelectedDuration.selected_fee#,
             '#CGI.remote_addr#')
      </cfquery>
      
      <!--- log creation of ad --->
      <cfmodule template="../../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        db_username="#db_username#"
        db_password="#db_password#"
        description="Ad Started by Administrator"
        itemnum="#selected_item#"
        details="TITLE: #title#     STATUS: #status#     DATE START: #createODBCDateTime (date_start)#     DATE END: #createODBCDateTime (date_end)#     CATEGORY 1: #category1#     CATEGORY 2: #category2#"
        user_id="#selected_user#">
        
      <!--- Keep track of who they used as the seller --->
      <cfquery name="update_last_seller" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
          UPDATE defaults
             SET pair = '#selected_user#'
           WHERE name = 'last_seller'
      </cfquery>
      
    </cfif><!--- edit (within save) --->
    
    <cfoutput><cflocation url="./ad_mngr.cfm?selected_category=#selected_category#&submit=expand&selected_item=#selected_item#"></cfoutput>
  </cfif><!--- save --->

 <cfsetting EnableCFOutputOnly="NO">

<!--- page layout --->
<html>
 <head>
  <title>Visual Auction 4 Administrator [Classifieds Module: Edit/Add Classified Ad]</title>
  <link rel=stylesheet href="../../includes/stylesheet.css" type="text/css">
 </head>

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
     <cfset #page# = "Classified">
     <cfinclude template="../../admin/menu_include.cfm">

     <cfoutput>
      <tr>
      <td colspan=5 bgcolor=a9ccd7>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=709>	    
       <tr>
         <td>
      		  <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
            <td colspan=2>
             <font face="helvetica" size=2 color="000000">
              Please fill out or modify the following form for this Classified ad. Click "Save" to save your<br>
              changes in the database, or click "Cancel" to ignore changes and return to the previous page.
             </font>
             <hr>
            </td>
           </tr>

      		   <tr>
            <td valign="top">
             <form name="itemform" action="classified_item.cfm" method="post">          
              &nbsp;<font face="Helvetica" size=2 color="000080"><b>CLASSIFIED AD INFORMATION:</b><br></font>
              &nbsp;<font color="000000">(Fields in <font color="0000ff">blue</font> are required)</font>
              <cfif #error_message# is not "">
               <font face="Helvetica" size=2 color=ff0000><br><br><b>ERROR:</b> #error_message#</font>
              </cfif>

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
                   <td><font face="helvetica" size=2 color="000000"><b>Ad ID ##:</b></font></td>
                   <td>&nbsp;</td>
                   <td>#the_item#</td>
                  </tr>
            				  <tr>
                   <td><font face="helvetica" size=2 color="000000"><b>Status:</b></font></td>
                   <td>&nbsp;</td>
                   <td><input type="Checkbox" name="status" <cfif status is 1>
checked</cfif>>&nbsp;&nbsp; Checked for Active</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Seller:</b></font></td>
                   <td>&nbsp;</td>
                   <td><select name="selected_user"><cfloop query="get_users"><option value="#user_id#"<cfif #selected_user# is #user_id#> selected</cfif>>#nickname# (#name#)</option></cfloop></select><cfif #seller_email# is not "">&nbsp;&nbsp;&nbsp;<font face="helvetica" size=2>(<a href="mailto:#seller_email#">#seller_email#</a>)</font></cfif></td>
                  </tr>
                  <tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Title:</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="text" size=45 maxlength=45 value="#title#"></td></tr></table></td>
                  </tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Item<br>Description:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><textarea name="ad_body" rows=5 cols=50>#ad_body#</textarea></td>
                  </tr>
                  <tr>
                   <td colspan=4><hr></td>
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
                   <td><font face="helvetica" size=2 color="0000ff"><b>Ad Duration:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0>
                     <tr>
                      <cfset #the_duration# = #dateDiff ("d", date_start, date_end)#><!--- **** Unused --->
                      <td><select name="duration">                 
                       <cfloop query="get_durations">
                        <option value="#ad_dur#"<cfif get_ad_duration.ad_dur is  get_durations.ad_dur> selected</cfif>>#ad_dur# days for $#numberformat(ad_fee,numbermask)#</option>
                       </cfloop>
                       </select></td>
                      <td><font face="helvetica" size=2>&nbsp;day(s)</font></td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                  </cfoutput>
                  <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Category<br>Advertised In:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2 valign="top">
                    <cfmodule template="../../functions/cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              db_username="#db_username#"
                              db_password="#db_password#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#category1#">
                    <br>
                   </td>
                  </tr>
                  <cfoutput>
				              <tr>
                   <td><font face="helvetica" size=2><b>Picture URL:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2>
                    <table border=0 cellspacing=0 cellpadding=0><tr><td><input name="picture_url" type="text" size=43 maxlength=250 value="#picture_url#"></td><td>&nbsp;</td><td><input type="button" name="previewImage" value="Preview" onClick="if (picture_url.value != 'http://') openWindow ('../../admin/preview_image.cfm?image=#URLEncodedFormat (picture_url)#&title=#URLEncodedFormat (title)#', 450, 300);"></td></tr></table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr></td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Asking Price:</b></font></td>
                   <td><font face="helvetica" size=2><b>#getCurrency.type#</b></font></td>
                   <td><input name="ask_price" type="text" size=9 maxlength=9 value="#numberformat(ask_price,numbermask)#"> &nbsp; &nbsp;
                   <!--- <input name="community_ad" type=checkbox><font face="helvetica" size=2 color="0000ff"><b>Community Ad</b></font> ---></td>
                  </tr>
                  <tr>
                   <td colspan=4><hr></td>
                  </tr> 
                  <tr>
                   <td colspan=4><input type="submit" name="submit2" value="Save" width=75>&nbsp;<input type="submit" name="submit2" value="Cancel" width=75></td>
                  </tr>
				              </cfoutput>
                 </table>
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
