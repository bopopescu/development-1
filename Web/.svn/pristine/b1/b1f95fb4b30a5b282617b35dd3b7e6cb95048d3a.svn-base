<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->

<cfmodule template="../functions/timenow.cfm">

<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif isDefined("selected_ad_info")>
   <cfset selected_ad=#selected_ad_info#>
<cfelse>
   <cfset selected_ad=0>
</cfif>
<cfif isDefined("adnum") AND #trim(submit)# neq "Close">
   <cfset adnum=#adnum#>
<cfelse>
   <cfset adnum="">
</cfif>   

<cfif #trim(submit)# is "Duration & Fees">
  <cflocation url = "advertise_sub.cfm">
</cfif>

<!--- upload full size image --->
<cfif isdefined("form.picture") and form.picture is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","advertise\images")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture = #File.ServerFile#>
  <CFIMAGE ACTION="RESIZE" SOURCE="#directory##File.ServerFile#" DESTINATION="#directory##File.ServerFile#" NAME="#File.ServerFile#" HEIGHT="120" WIDTH="340" OVERWRITE="YES">
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##picture#")>
        <cffile action="rename"
          SOURCE = "#directory##picture#"  
          DESTINATION = "#directory##adnum#.jpg">
      </cfif>
</cfif>
<cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
</cfif>

<cfif isDefined("status")>
   <cfset status=#status#>
<cfelse>
   <cfset status=0>
</cfif>   
<cfif isDefined("paused")>
   <cfset paused=#paused#>
<cfelse>
   <cfset paused=0>
</cfif>   
<cfif isDefined("picture")>
   <cfset picture=#picture#>
<cfelse>
   <cfset picture="">
</cfif>   
<cfif isDefined("relist_status")>
   <cfset relist_status=#relist_status#>
<cfelse>
   <cfset relist_status="">
</cfif>   

<cfif #trim(submit)# is "Back">
   <cflocation url="advertise.cfm">
</cfif>
<cfif #trim(submit)# is "Close">
   <cfset selected_ad = #adnum#>
</cfif>

<cfif #trim(submit)# is "Retrieve">
    <cfquery username="#db_username#" password="#db_password#" name="get_ad_info" datasource="#DATASOURCE#">
           SELECT adnum,webaddress,date_start,date_end,date_created,ad_dur,ad_fee,status,picture,paused,
         		(SELECT nickname FROM users WHERE adv_info.user_id = users.user_id) AS nickname
           FROM adv_info
           WHERE adnum = #selected_ad#
    </cfquery> 
    <cfset adnum = #get_ad_info.adnum#>
    <cfset webaddress = #get_ad_info.webaddress#>
    <cfset nickname = #get_ad_info.nickname#>
    <cfset date_created = #get_ad_info.date_created#>
    <cfset date_start = #get_ad_info.date_start#>
    <cfset date_end = #get_ad_info.date_end#>
    <cfset ad_dur_sel = #get_ad_info.ad_dur#>
    <cfset status = #get_ad_info.status#>
    <cfset prev_status = #get_ad_info.status#>
    <cfset paused = #get_ad_info.paused#>    
    <cfset picture = #get_ad_info.picture#>
    <cfset ad_durdesc = #get_ad_info.ad_dur# & " Days  " & #dollarformat(get_ad_info.ad_fee)#>
    <cfset #relist_status# = #get_ad_info.status#>
</cfif>   
<cfif #trim(submit)# is "Update">
    <cfif #adnum# neq "">
        <cfset date_end = #DateAdd('m', #duration#, date_start)#>
        <!-----send email-------->
        <cfif #prev_status# is 0 AND #status# is 1>
           <cfquery username="#db_username#" password="#db_password#" name="get_item_user" datasource="#DATASOURCE#">
              SELECT adnum,webaddress,date_start,date_end,ad_dur,status,
      		      (SELECT nickname FROM users WHERE adv_info.user_id = users.user_id) AS nickname,
      		      (SELECT name FROM users WHERE adv_info.user_id = users.user_id) AS name,
      		      (SELECT email FROM users WHERE adv_info.user_id = users.user_id) AS email
              FROM adv_info
              WHERE adnum = #adnum#
           </cfquery> 
           <cfmail to="#get_item_user.email#" from="customer_service@#domain#" subject="Advertisement Approval">
              Dear #get_item_user.name# (#get_item_user.nickname#),
           
              Your Advertisement application for #webaddress# (#adnum#) has been approved.
              Publishing starts: #dateformat(date_start,"mm/dd/yyyy")# ends: #dateformat(date_end,"mm/dd/yyyy")#
           
              You may view this Advertisement at http://www.kangoauctions.com once it starts.

              Thank you,
              #company_name#
           </cfmail>
        </cfif>
        <!-----send email-------->
        <cfquery username="#db_username#" password="#db_password#" name="upd_ad_info" datasource="#DATASOURCE#">
          UPDATE adv_info 
                 SET status = #status#,
                     paused = #paused#,
                     date_start = #date_start#,
                     date_end = #date_end#,
                     webaddress = '#webaddress#',
                     <cfif #picture# NEQ "">
                        picture = '#adnum#.jpg',
                     </cfif>   
                     ad_dur = #duration#
          WHERE adnum = #adnum#
       </cfquery>       
       <cfset selected_ad = #adnum#>
       <cfset adnum = "">
    </cfif>   
</cfif>
<cfif #trim(submit)# is "Delete">
    <cfquery username="#db_username#" password="#db_password#" name="upd_ad_info" datasource="#DATASOURCE#">
        DELETE FROM adv_info WHERE adnum = #adnum#
    </cfquery>       
    <cfset adnum = "">
</cfif>
<!--- get possible ad durations/prices --->
<cfquery name="get_duration" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT ad_dur, ad_fee
      FROM adv_defaults
    ORDER BY ad_dur ASC
</cfquery>

<html>
 <head>
  <title>Visual Auction Server Administrator [Advertisement Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 
 	<script type="text/javascript">

						function showAdinfoWindow()
						{
						window.open("adinfo.cfm","AdinfoWindow","status=no,scrollbar=yes,width=400,height=180,left=300,top=150");
						}

						function showAdForm()
						{
						window.open("admin_ad.cfm","AdinfoWindow","status=no,scrollbar=yes,width=400,height=180,left=300,top=150");
						}
						
						
	</script>
 
 
 </head>

 <script type="text/javascript">
 	function val_imagename() {
        var pic = document.item_input.picture.value;
        var iChars = "!@#$%^&*()+=-[]';,/{}|\"<>?~ ";         
        for (var i = 0; i < pic.length; i++) {
  	        if (iChars.indexOf(pic.charAt(i)) != -1) {
  	           alert ("Your Image contains characters not allowed as filename.");
  	           return false;
  	        }
        }
  	    len = pic.length;
  	    if(len > 0) {
	      pos = pic.lastIndexOf( '.' );
	      ext = pic.substr( pos + 1, len - pos )
  	      if( ext != 'jpg' && ext != 'jpeg' && ext != 'gif' && ext != 'JPG' && ext != 'JPEG' && ext != 'GIF' ) {
             alert ("Uploaded Image is not valid image file.");
             return false; 	    
          }   
        }        
        var reply = confirm("Please Confirm?");
        if (reply == false) {
           return false;
        }
	} 
 </script>
 <script type="text/javascript">
 	function preview_link() {
        var weblink = document.item_input.webaddress.value;
        if (weblink == "" || (weblink.indexOf(".com")==-1 && weblink.indexOf(".net")==-1 && weblink.indexOf(".org")==-1 && weblink.indexOf(".gov")==-1 && weblink.indexOf(".edu")==-1)) {
           alert("Please input a valid Web Link");
           return false;
        }   
        if (weblink.indexOf("http://")>-1 || weblink.indexOf("https://")>-1) {
    	   window.open( weblink, '_blank' );
        } else {
           weblink = "http://"+weblink;
    	   window.open( weblink, '_blank' );
	    }
	}    
 </script>
 <!--- Main page body --->
 <body bgcolor=465775>
  <form name="item_input" action="./advertise.cfm" method="post" enctype="multipart/form-data">
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
      <cfset #page# = "advertise">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>

        <!--- A table encapsulating the main page content;
              with a thin black border --->
        <table border=0 bordercolor=000000 cellspacing=0 cellpadding=3 width=100%>
         <tr>
          <td>
           <font face="helvetica" size=2 color=000000>
            Use this page to administer the advertisement applications in your
            <i>Auction Server</i> software.<br>If you do not know how to use
            this administration tool, please <!---consult your user manual or<br>--->
			click the help button<br>in the upper right corner of this window.<br><br>
            &nbsp;Related Table:
            <input type="submit" name="submit" value="Duration & Fees">&nbsp;<input type="submit" value="Advertisement Information" onclick="showAdinfoWindow()">
			<input type="submit" name="newad" onClick="showAdForm()">
          </td>
          <tr><td><hr></td></tr>
         </tr>
        </table>
        <cfquery username="#db_username#" password="#db_password#" name="get_ad_info" datasource="#DATASOURCE#">
           SELECT adnum,webaddress,date_start,date_created,date_end,status,paused,
         		(SELECT nickname FROM users WHERE adv_info.user_id = users.user_id) AS nickname
           FROM adv_info
           ORDER BY adnum DESC                            
        </cfquery> 
        <cfset cur_selected_ad = #get_ad_info.adnum#>
        <table border=0 cellspacing=10 cellpadding=0>
        <tr>
        <cfif #adnum# eq "">
        <td valign="top">        
        <table border=0 cellspacing=0 cellpadding=0>
        <tr><td align="left"><b>Advertisements Applications</b></td></tr>        
        <tr><td>        
           <tr>
           <td align="left">
           <select name="selected_ad_info" size=25 width=500 <cfif #trim(submit)# is "Retrieve">Disabled</cfif>>
              <cfif #get_ad_info.recordcount# gt 0>
                   <cfloop query="get_ad_info">
                      <cfoutput><option value="#adnum#" <cfif #adnum# EQ #cur_selected_ad#> selected</cfif>>#adnum#&nbsp;-&nbsp;#nickname#&nbsp;
                      <cfif #status# EQ 1 AND #paused# EQ 0 AND #date_start# LTE #TIMENOW# AND #date_end# GT #TIMENOW#>
                         [Active]
                      <cfelseif #status# EQ 1 AND #paused# EQ 0 AND #date_start# GT #TIMENOW#>
                         [Approved-Upcoming]
                      <cfelseif #status# EQ 1 AND #paused# EQ 1 AND #date_end# GT #TIMENOW#>
                         [Suspended]
                      <cfelseif #status# EQ 1 AND #paused# EQ 0 AND #date_end# LT #TIMENOW#>
                         [Completed]
                      <cfelseif #status# EQ 0 AND #date_end# LT #TIMENOW#>
                         [Expired]
                      <cfelse>
                         [Pending]
                      </cfif>
                      </option></cfoutput>
                   </cfloop>
              <cfelse>
                   <cfoutput><option value="0" selected>< empty ></option></cfoutput>
              </cfif>
              </select>
            </td>
           </tr>
        </table>    
        </cfif>
        <td valign="top">
        <cfoutput>
        <table border=0 cellspacing=0 cellpadding=0>
        <cfif #adnum# neq "">
           <tr><td colspan=2 align="left"><b>Advertisement</b></td></tr>        
           <tr><td colspan=2><font size=2>Ad Number:</font></td></tr>
           <tr><td colspan=2><input type="text" readonly="true" name="adnum" value="#adnum#" size=20>&nbsp;
              <b>
              <cfif #status# EQ 1 AND #paused# EQ 0 AND #date_start# LTE #TIMENOW# AND #date_end# GT #TIMENOW#>
                [Active]
              <cfelseif #status# EQ 1 AND #paused# EQ 0 AND #date_start# GT #TIMENOW#>
                [Approved-Upcoming]
              <cfelseif #status# EQ 1 AND #paused# EQ 1 AND #date_end# GT #TIMENOW#>
                [Suspended]
              <cfelseif #status# EQ 1 AND #paused# EQ 0 AND #date_end# LT #TIMENOW#>
                [Completed]
              <cfelseif #status# EQ 0 AND #date_end# LT #TIMENOW#>
                [Expired]
              <cfelse>
                [Pending]
              </cfif>
             </b>
           </td>
           </tr>  
           <tr>
              <td><font size=2>Username:</font></td>
              <td><font size=2>Date Created:</font></td>
           </tr>
           <tr>
              <td><input type="text" readonly="true" name="nickname" value="#nickname#" size=20></td>
              <td><input type="text" readonly="true" name="date_created" value="#date_created#" size=20></td>
           </tr>        
           <tr><td colspan=2><font size=2>Web Link:</font></td></tr>
           <tr><td colspan=2><textarea wrap="vistual" cols=38 name="webaddress" rows=3 value="#webaddress#">#webaddress#</TEXTAREA></td></tr>
           <tr><td colspan=2><input type="button" name="prevlink" value="Preview Link" onClick="return preview_link()">&nbsp;<font size=2>(ex. http://www.yahoo.com)</font></td></tr>
           <tr>
              <td colspan=2><font size=2>Date Start:</font></td>
           </tr>
           <tr>
              <td colspan=2>
                 <table border=0 cellspacing=0 cellpadding=1>
                 <tr>
                    <td>
					<cfset the_month = #datePart ("m", "#date_start#")#>
					<cfset the_day = #datePart ("d", "#date_start#")#>
					<cfset the_year = #datePart ("yyyy", "#date_start#")#>
					<cfset the_time = #timeFormat ("#date_start#", 'hh:mm')#>
					<cfset the_time_s = #timeFormat ("#date_start#", 'tt')#>
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
              <td colspan=2><font size=2>Duration:</font></td>
           </tr>
           <tr>
             <td colspan=2>
               <select name="duration">
                 <cfloop query="get_duration">
                   <option value="#ad_dur#" <cfif ad_dur EQ #ad_dur_sel#> selected</cfif>>#ad_dur# Month(s) - $#numberformat(ad_fee,numbermask)#
                 </cfloop>
               </select>
             </td>
           </tr>  
           <cfif #status# EQ 0 AND #paused# EQ 0 AND #date_end# GT #TIMENOW#>
               <tr><td colspan=2><input type="checkbox" name="status" value="1" <cfif status eq 1>checked</cfif>>&nbsp;Approve Application</td></tr>
               <input type="hidden"  name="paused" value="#paused#">               
           <cfelseif #status# is 1 AND #paused# EQ 0 AND #date_end# LT #TIMENOW#>
               <tr><td colspan=2><input type="checkbox" name="status" value="1" <cfif status eq 1>checked</cfif>>&nbsp;Relist/Approve Advertisement</td></tr>
               <input type="hidden"  name="paused" value="#paused#">  
           <cfelseif #status# is 1 AND #date_start# LT #TIMENOW# AND #date_end# GT #TIMENOW#>
               <tr><td colspan=2><input type="checkbox" name="paused" value="1" <cfif paused eq 1>checked</cfif>>&nbsp;Suspend/Stop Advertisement</td></tr>
               <input type="hidden"  name="status" value="#status#">  
           <cfelse>
               <input type="hidden"  name="paused" value="#paused#">               
               <input type="hidden"  name="status" value="#status#">  
           </cfif>   
           <input type="hidden"  name="prev_status" value="#prev_status#">  
           <tr><td colspan=2>&nbsp;</td></tr>
        </cfif>
        <tr><td colspan=2>
            <cfif #adnum# eq "">
               <input type="submit" name="submit" value="Retrieve">
            <cfelse>
               <input type="submit" name="submit" value="Update" onClick="return val_imagename();">
               <input type="submit" name="submit" value="Delete" onClick="return confirm('Please Confirm?')">
               <input type="submit" name="submit" value="Close">
            </cfif>   
            <input type="submit" name="submit" value="Back">
            <cfif #adnum# eq ""><br><font size=1>Select an item from the List<br>and click RETRIEVE"</font></cfif>
        </td></tr>          
        </table>                
        <td valign="top">
        <table border=0 cellspacing=0 cellpadding=0>
        <cfif #picture# neq "" AND #adnum# neq "">
            <tr><td align="left"><b>Ad Banner</b></td></tr>        
            <tr><td><img src="../advertise/images/#picture#" border=1 height=150 width=130></td></tr>
            <tr><td>&nbsp;</td></tr>
		    <tr><td><font face="helvetica" size=2><font size=2>Upload/Replace Ad Banner:(150H X 130W)</font><br><input name="picture" type="file" size=45 maxlength=250></td></tr>
		    <tr><td><a href="advertise.cfm?selected_ad_info=#adnum#&submit=Retrieve"><font size=1>Click here </a>if the the image did not update auctomatically.</font></td></tr>
        <cfelse>
            <tr><td>&nbsp;</td></tr>
        </cfif>    
        </table>  
        </cfoutput>  
        </td></tr>
       </td>
      </tr>
     </table>
    </center>
   </font>
  </form>
 </body>
</html>
