<!--- classified/edit_info.cfm
      Personal Page: Classified Ad Edit 
--->
<cfsetting enablecfoutputonly="Yes">

  
 
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 
  <!--- def vals --->
  <cfset sDescAddendumNote = '<br><br><hr size=1 color=#heading_color# width=100%><font face="helvetica">On #DateFormat(Now(), "mm/dd/yyyy")# at #TimeFormat(Now(), "HH:mm:ss")#, advertiser added the following information:</font><br><br>'>
 
 <!--- Load this module for creating unique IDs --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">

 <cfif #isDefined ("selected_category")# is 0>
  <cfset #selected_category# = "0">
 </cfif>
 
 <!--- If they're not selecting an item, set a default one --->
 <!---<cfif #isDefined ("selected_ad")# is "0">
  <cfset #selected_ad# = "#EPOCH#">
 </cfif>
--->

  <!--- Set a default value for "submit2" and "submit3" if nonexistent --->
 <cfif #isDefined ("submit2")# is 0>
  <cfset #submit2# = "enter">
 <cfelse>
  <cfset #submit2# = #trim (submit2)#>
 </cfif>
 <cfif #isDefined ("submit3")# is 1>
  <cfset #submit3# = #trim (submit3)#>
 <cfelse>
  <cfset #submit3# = "enter">
 </cfif>
 <cfif #submit2# is "enter">
  <cfset #session.query_done# = "not">
 </cfif>

 <!--- Check to see if they're cancelling. --->
 <cfif #submit2# is "Cancel">
  <cfoutput><cflocation url="main_page.cfm"></cfoutput>
 </cfif>
 <!--- Check to see if they're editing Another Item. --->
 <cfif #submit3# is "Edit Another">
  <cfoutput><cflocation url="edititem.cfm"></cfoutput>
 </cfif>
 
 <cfif #isDefined ("selected_ad")# is 0>
<cfset #selected_ad# = "#adnum#">
</cfif>
<cfif #isDefined ("the_ad")# is 0>
  <cfset #the_ad# = "#selected_ad#">
 </cfif>
 
 <cfif #isDefined ("desc_languages")# is 0>
  <cfset #desc_languages# = "">
 </cfif>

<!--- Set a default value for "User ID" if nonexistent --->
 <cfif #isDefined ("user_id")# is 0>
  <cfset #user_id# = "session.user_id">
 <cfelse>
  <cfset #user_id# = #trim (user_id)#>
 </cfif> 
 

<!--- Set a default value for the missing submit button --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "Edit">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>
 
<!--- Check for a value on the Session.adnum variable --->
<!---<cfset #selected_ad# = "#adnum#">--->
<!--- <cfif #isDefined ("session.adnum")# is 0>
  <cfset #session.adnum# = "adnum">
 <cfelse>
  <cfset #session.adnum# = #trim (session.adnum)#>
  </cfif>
<cfset #selected_ad#="#session.adnum#">--->
 <!--- Set defaults depending on whether we're editing or adding --->



 <cfif (#submit# is "Edit") and (#submit2# is "Enter")>
  <cfset #adnum#="#adnum#">
 <cfelseif #submit# is "Add">
  <cfset #adnum#="#EPOCH#">
 </cfif> 
 
 <!--- Get a list of active users --->
 <cfquery name="get_users" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT user_id, name, nickname
    FROM users
   WHERE user_id = #session.user_id#
   ORDER BY nickname
 </cfquery>

 <!--- Get the last user they chose as the advertiser --->
 <cfquery name="get_advertiser" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT pair
    FROM defaults
   WHERE name = 'last_seller' <!--- **** --->
 </cfquery>



 <!--- Check to see if we need to delete an item. --->
 <cfif #submit2# is "Delete" or #submit# is "Delete">
  <cfquery name="delete_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
   DELETE FROM ads
    WHERE adnum = #selected_ad#
  </cfquery>
  <cfoutput><cflocation url="../personal/main_page.cfm"></cfoutput>
 </cfif>

 <!--- If defined, merge the separate date and time objects into 1 object --->
 <cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
 </cfif>

 <cfif #isDefined ("status")#>
  <cfset #status# = "1">
 <cfelse>
  <cfset #status# = "0">
 </cfif>












 <cfif #isDefined ("selected_user")# is 0>
  <cfset #selected_user# = "0">
 </cfif>




 <!--- Set defaults for all the form variables --->
 <cfif ((#submit# is "Edit") or (#submit# is "Add")) and (#submit2# is "enter")>
  
  <cfif #submit# is "Add">
   <cfset #selected_ad# = "#EPOCH#">
   <cfset #selected_user# = "#get_advertiser.pair#">
  </cfif>
  <cfset #status# = "">
  <cfset #user_id# = "">
  <cfset #category1# = "#selected_category#">
  <cfset #category2# = "">
  <cfset #title# = "">
  <cfset #ad_body# = "">
  <cfset #picture_url# = "http://">
  <cfset #asking_price# = "">
  <cfset #date_start# = "#now ()#">
  <cfset #date_end# = "#now ()#">
  <cfset #seller_email# = ""><!--- **** --->




 </cfif>

 <!--- Check to see if we're editing an ad --->
 <cfif (#submit2# is "enter") and (#session.query_done# is "not")>
 
  <cfquery name="get_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
   SELECT adnum,
          status,
          user_id,
          category1,
          category2,
          title,
          ad_body,
          picture_url,
          ask_price,
          date_start,
          date_end
     FROM ad_info
    WHERE adnum = #selected_ad#
  </cfquery>
  <cfset #selected_category# = #get_ad.category1#>

<!--- Security Check --->
<CFIF #get_ad.user_id# neq #get_users.user_id#>
<CFABORT>
</CFIF>

  <!--- Get the advertiser's email address --->
  <cfquery name="get_advertiser_email" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
   SELECT email
     FROM users
    WHERE user_id = #get_ad.user_id#
  </cfquery>
  <cfset #seller_email# = "#get_advertiser_email.email#">
  <cfset #session.seller_email# = "#get_advertiser_email.email#">

  <cfset #adnum# = "#get_ad.adnum#">
  <cfset #session.adnum# = "#get_ad.adnum#">
  <cfset #the_ad# = "#get_ad.adnum#">
  <cfset #session.the_ad# = "#get_ad.adnum#">
  <cfset #status# = "#get_ad.status#">
  <cfset #user_id# = "#get_ad.user_id#">
  <cfset #session.user_id# = "#get_ad.user_id#">
  <cfset #category1# = "#get_ad.category1#">
  <cfset #category2# = "#get_ad.category2#">
  <cfset #title# = "#get_ad.title#">
  <cfset #session.title# = "#get_ad.title#">
  <cfset #ad_body# = "#get_ad.ad_body#">
  <cfset #picture_url# = #trim ("#get_ad.picture_url#")#>
  <cfif (#picture_url# is "") or (#left (picture_url, 7)# is not "http://")>
   <cfset #picture_url# = "http://#picture_url#">
  </cfif>
  <cfset #ask_price# = "#get_ad.ask_price#">
  <cfset #date_start# = "#get_ad.date_start#">
  <cfset #date_end# = "#get_ad.date_end#">
  <cfset #selected_user# = "#get_ad.user_id#">
  <cfset #session.query_done# = "done"> 
</cfif> 

 <!--- Run a query to find all active categories --->
 <cfquery name="get_cats" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT name, category, user_id
    FROM categories
   WHERE active = 1
     AND parent > -1
   ORDER by name
 </cfquery>

 <!--- Run a query to find all durations --->
 <cfquery name="get_durations" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT pair
    FROM defaults
   WHERE name = 'duration'
   ORDER BY pair
 </cfquery>

 <!--- Run a query to find the default duration --->
 <cfquery name="get_def_duration" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT pair
    FROM defaults
   WHERE name = 'def_duration'
   ORDER BY pair
 </cfquery>
 
  <!--- Get user_id from new category selection --->
<cfif isDefined("Form.category1")>
 <CFQUERY NAME="getcat1_user_id" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT user_id FROM categories
WHERE category = #form.category1#
</CFQUERY></cfif>

<cfif isDefined("form.category2")>  
<CFQUERY NAME="getcat2_user_id" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT user_id FROM categories
WHERE category = #form.category2#
</CFQUERY>

<cfif #getcat2_user_id.recordcount# gt 0>
<cfset cat2user_id = "#getcat2_user_id.user_id#">
    <cfelse>
   <cfset cat2user_id = 0>
  </cfif></cfif>
  

 <!--- Reset the error message string --->
 <cfset #error_message# = "">

 <!--- Check the form for valid data --->
 <cfif #submit2# is "Save">
  <cfif #trim (title)# is "">
   <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
   <!--- 
  <cfelseif #trim (description)# is "">
   <cfset #error_message# = "<font color=ff0000>Please enter a description of this item.</font>"> 
   --->

<!--check for exclusive category and match logon user_id with category user_id -->

<CFELSEIF #getcat1_user_id.user_id# is not 0>
<cfif (#selected_user# is not #getcat1_user_id.user_id#)>
<cfset #error_message# = "You are not authorized to advertise in this category. Please contact the site administrator to advertise in your own exclusive category.">
</CFIF>

<cfif isDefined("getcat2_user_id.user_id")>
<CFELSEIF (#getcat2_user_id.user_id# is not 0) and (#cat2user_id# is not 0)>
<cfif (#selected_user# is not #getcat2_user_id.user_id#) or (#selected_user# is not #cat2user_id#)>
<cfset #error_message# = "You are not authorized to advertise in this category. Please contact the site administrator to advertise in your own exclusive category.">
</CFIF> </cfif>>
 <!-- end check --->
  </cfif>
 </cfif>

  <!--- Check to see if we're saving an auction item --->
  <cfif #submit2# is "Save">
    <cfset #date_end# = #dateAdd ("d", "#duration#", date_start)#>
  </cfif>
  
  <cfif (#submit2# is "Save") and (#error_message# is "")>
    
    <cfif #submit# is "Edit">
      
	  <cfif isDefined("picture_url")>
      <!--- Make sure images and sounds begin with http:// --->
      <cfif (#picture_url# is "") or (#left (picture_url, 7)# is not "http://")>
        <cfset #picture_url# = "http://#picture_url#">
      </cfif>
     
      <!--- update ad info --->
      <cfquery name="update_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#"> 
          UPDATE ad_info
             SET status = #status#,
                 user_id = #selected_user#,
                 category1 = #category1#,
                 title = '#title#',
                 picture_url = '#picture_url#',
<!--- 		These three variables have been rem out because they switch ON when editing an auction --->				 
<!---                 featured = #featured#,
                 featured_cat = #featured_cat#,
                 private = #private#, --->
                 date_start = #createODBCDateTime (date_start)#,
                 date_end = #createODBCDateTime (date_end)#
           WHERE adnum = #selected_ad#
      </cfquery></cfif>
      
      <!--- if should append to desc --->
	  <cfif isDefined("ad_body")>
	       <cfif Len(Trim(ad_body))>
        
        <!--- get old desc --->
        <cfquery name="getOldDesc" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
            SELECT ad_body
              FROM ad_info
             WHERE adnum = #selected_ad#
        </cfquery>
        
        <!--- def desc --->
        <cfset sNewDesc = Trim(getOldDesc.ad_body) & Variables.sDescAddendumNote & Trim(ad_body)>
        
        <!--- append desc --->
        <cfquery name="update_item" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#"> 
            UPDATE ad_info
               SET ad_body = '#Variables.sNewDesc#'
             WHERE adnum = #selected_ad#
        </cfquery>
      </cfif></cfif>
      

      <!--- log update to transactions --->
<!---       <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        db_username="#db_username#"
        db_password="#db_password#"
        ad_body="Auction Updated"
        adnum="#selected_ad#"
        details="#title#"
        user_id="#selected_user#"> ---><!--- **** --->
        
      
      <!--- Keep track of who they used as the seller ---><!--- **** --->
      <cfquery name="update_last_seller" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
          UPDATE defaults
             SET pair = '#selected_user#'
           WHERE name = 'last_seller'
      </cfquery>
      
    </cfif>
    
    <cfoutput><cflocation url="editad_info.cfm?selected_category=#selected_category#&submit=expand&selected_ad=#selected_ad#&submit3=Another"></cfoutput>
  </cfif>
  
<cfsetting EnableCFOutputOnly="NO">
<html>
 <head>
  <title>Personal Page: Classified Ad Edit </title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <body bgcolor=ffffff>
 
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
      <table border=0 cellspacing=0 cellpadding=0 width=640>
     <tr><td><center><IMG SRC="<cfoutput>#VAROOT#</cfoutput>/images/logohere.gif"> &nbsp; &nbsp; &nbsp; 


<FONT SIZE=2><cfinclude template="../includes/menu_bar_bid.cfm"></FONT></center><br><br></td></tr>
    <tr><td><font size=4><b>Edit Classified Ad Page</b></font></td></tr>
	<tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
	<tr>
     <td>
      <font size=3>
       This page will allow you to edit an ad you currently have listed.
       You may change most of the information about your
       item.<!--- , but please note that some of the information such as the
       item's price and bidding type/increment cannot be changed. --->
      </font>
     <tr>
     <!--- Include the menubar --->
    <!--- <cfset #page# = "auctions">
     <cfinclude template="menu_include.cfm">
--->
     <tr>
      <td colspan=5 bgcolor=ffffff>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
       <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
            <td colspan=2>
             <font face="helvetica" size=2 color=000000>
              Please fill out or modify the following form for this ad. Click "Save" to save your<br>
              changes in the database, or click "Cancel" to ignore changes and return to the previous page.
              <hr size=1 color=#heading_color# width=100%>
             </font>
            </td>
           </tr>
           <tr>
            <td valign="top"><!-- This is a test Comment, Top of form  -->
             <form name="adform" action="editad_info.cfm" method="post">          
              &nbsp;<font face="Helvetica" size=2 color=000080><b>CLASSIFIED AD INFORMATION:</b><br></font>
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
                <input type="hidden" name="selected_ad" value="#selected_ad#">
               <cfelseif #submit# is "Add">
                <input type="hidden" name="selected_ad" value="#EPOCH#">
               </cfif>
              <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
               <tr>
                <td>
                 <table border=0 cellspacing=0 cellpadding=2>
                  <tr>
                   <td><font face="helvetica" size=2 color="000000"><b>Ad ID ##:</b></font></td>
                   <td>&nbsp;</td>
                   <td><!--- #adnum# --->#selected_ad#</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Advertiser:</b></font></td>
                   <td>&nbsp;</td>
                   <td><select name="selected_user"><cfloop query="get_users"><option value="#user_id#"<cfif #selected_user# is #user_id#> selected</cfif>>#nickname# (#name#)</option></cfloop></select>&nbsp;&nbsp;&nbsp;</td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>Title:</b></font></td>
                   <td>&nbsp;</td>
                   <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="title" type="hidden" size=35 maxlength=45 value="#session.title#">#session.title# </td><td>(former bold title stuff)</td></tr></table></td>
                  </tr>
<!---                   <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Description<br>Addendum:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2><textarea name="description" rows=5 cols=50></textarea></td>
                  </tr>
 --->
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
                       <input name="start_month" type=hidden size=3 maxlength=3 value="#the_month#">
                      <cfif #the_month# is "1">Jan </cfif>
					  <cfif #the_month# is "2">Feb </cfif>
					  <cfif #the_month# is "3">Mar </cfif>
					  <cfif #the_month# is "4">Apr </cfif>
					  <cfif #the_month# is "5">May </cfif>
					  <cfif #the_month# is "6">Jun </cfif>
					  <cfif #the_month# is "7">Jul </cfif>
					  <cfif #the_month# is "8">Aug </cfif>
					  <cfif #the_month# is "9">Sep </cfif>
					  <cfif #the_month# is "10">Oct </cfif>
					  <cfif #the_month# is "11">Nov </cfif>
					  <cfif #the_month# is "12">Dec </cfif>
					  </td>
                      <td><input name="start_day" type="hidden" size=2 maxlength=2 value="#the_day#">#the_day#, </td>
                      <td><input name="start_year" type="hidden" size=4 maxlength=4 value="#the_year#">#the_year# </td>
                      <td><font face="helvetica" size=2>&nbsp;at&nbsp;</font></td>
                      <td><input name="start_time" type="hidden" size=5 maxlength=5 value="#the_time#">#the_time#</td>
                      <td>
                       <input name="start_time_s" type="hidden" size=2 maxlength=2 value="#the_time_s#"> #the_time_s#
                      </td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td><font face="helvetica" size=2 color="0000ff"><b>AD Duration:</b></font></td>
                   <td>&nbsp;</td>   
                   <td>
                    <table border=0 cellspacing=0 cellpadding=0>
                     <tr>
                      <cfset #the_duration# = #dateDiff ("d", date_start, date_end)#>
                      <td><input name="duration" type="hidden" value="#the_duration#">#the_duration#                 
                      
                       </select></td>
                      <td><font face="helvetica" size=2>&nbsp;day(s)</font></td>
                     </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td valign="top"><font face="helvetica" size=2 color="0000ff"><b>Category:</b></font></td>
                   <td>&nbsp;</td>
                   <td colspan=2 valign="top">
                    <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              db_username="#db_username#"
                              db_password="#db_password#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#category1#">
                   </td>
                  </tr>
                    </table>
                   </td>
                  </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr>
                  <tr>
                   <td colspan=4><hr size=1 color=#heading_color# width=100%></td>
                  </tr> 
                  <tr>
                   <td colspan=4><cfif #submit3# is "Another">
				   <!---<input type="submit" name="submit3" value="Edit Another" width=75>&nbsp;---><cflocation url="editad_pre_new.cfm?submit=enter&selected_ad=#session.adnum#">
					<cfelse><input type="submit" name="submit2" value="Save" width=75>&nbsp;
				   </cfif><input type="submit" name="submit2" value="Cancel" width=75></td>
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