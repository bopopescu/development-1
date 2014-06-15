<!--- classified/Place_ad.cfm
	Form for placing Classified's Ads;
	check for errors then goes to review_ad.cfm.
	04/28/00 
	classified ver 1.0a
---> 

<cfsetting enablecfoutputonly="Yes">
<cfinclude template = "../includes/app_globals.cfm">

<!--- Include this module to create a unique number for the ad --->
<cfmodule template="../functions/epoch.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">
<cfif isDefined('session.user_id') is 0>
<cflocation url="/login.cfm?login=1&path=#SCRIPT_NAME#">
</cfif>
<cfset error_message = "">
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

 <cfset error_message = ""> 
 <cfset #cc_name_error# = "">
 <cfset #cc_number_error# = "">
 <cfset #cc_expiration_error# = "">


<!--- Get ip address --->
<cfset remote_ip = #cgi.remote_addr#>

  <!--- upload full size image --->
<cfif isdefined("form.picture1") and form.picture1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory2 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"classified","classified\fullsize_thumbs")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture1"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture1 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory2##picture1#")>
        <cffile action="rename"
          SOURCE = "#directory2##picture1#"  
          DESTINATION = "#directory2##adnum##right(picture1,4)#">
      </cfif>
</cfif>
<!--- upload full size image --->
<cfif isdefined("form.picture2") and form.picture2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory3 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory3# = Replace(GetDirectoryFromPath("#curPath#"),"classified","classified\fullsize_thumbs0")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory3#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture2"
      DESTINATION="#directory3#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture2 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory3##picture2#")>
        <cffile action="rename"
          SOURCE = "#directory3##picture2#"  
          DESTINATION = "#directory3##adnum##right(picture2,4)#">
      </cfif>
</cfif>

<!--- upload full size image --->
<cfif isdefined("form.picture3") and form.picture3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory4 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory4# = Replace(GetDirectoryFromPath("#curPath#"),"classified","classified\fullsize_thumbs1")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory4#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture3"
      DESTINATION="#directory4#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture3 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory4##picture3#")>
        <cffile action="rename"
          SOURCE = "#directory4##picture3#"  
          DESTINATION = "#directory4##adnum##right(picture3,4)#">
      </cfif>
</cfif>


<cfif isdefined("form.picture4") and form.picture4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory5 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory5# = Replace(GetDirectoryFromPath("#curPath#"),"classified","classified\fullsize_thumbs2")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory5#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.picture4"
      DESTINATION="#directory5#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset picture4 = #File.ServerFile#>
  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory5##picture4#")>
        <cffile action="rename"
          SOURCE = "#directory5##picture4#"  
          DESTINATION = "#directory5##adnum##right(picture4,4)#">
      </cfif>
</cfif>

<!--- If defined, merge the separate date and time objects into 1 object --->
 <cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
 </cfif>

<!--- get possible ad durations/prices --->
<cfquery name="get_duration" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT ad_dur, ad_fee
      FROM ad_defaults
    ORDER BY ad_dur ASC
</cfquery>

<!--- get currency type --->
<cfquery name="getCurrency" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT pair AS type
    FROM defaults
    WHERE name = 'site_currency'
</cfquery>

<!--- Set default params --->


<cfparam name="cat" default="">


<!---

<cfset category1 =  #cat# >
--->



<!--- Determine if the form variables have been set yet --->

<!---
<cfif isdefined("cat") and #isnumeric("cat")# and not isdefined("category1")>

  <cfset category1 = #cat# >

<cfelseif IsDefined("category1") and not isdefined("cat")>
  <cfset category1 = #form.category1#>

<cfelse>
<cfset category1 = "">
</cfif>

--->
<cfif IsDefined("user_id")>
  <cfset user_id=#user_id#>
<cfelse>
  <cfset user_id="">
</cfif>
<cfif IsDefined("password")>
  <cfset password=#password#>
<cfelse>
  <cfset password="">
</cfif>
<cfif IsDefined("ad_body")>
  <cfset ad_body=#ad_body#>
<cfelse>
  <cfset ad_body="">
</cfif>
<cfif IsDefined("title")>
  <cfset title=#title#>
<cfelse>
  <cfset title="">
</cfif>
<cfif IsDefined("ask_price")>
  <cfset ask_price=#ask_price#>
<cfelse>
  <cfset ask_price="">
</cfif>

<cfif IsDefined("date_start")>
  <cfset date_start=#date_start#>
<cfelse>
  <cfset #date_start# = "#timenow#">
</cfif>
<cfif IsDefined("duration")>
  <cfset duration=#duration#>
<cfelse>
  <cfset duration="">
</cfif>
<cfif IsDefined("picture_url")>
  <cfset picture_url=#picture_url#>
<cfelse>
  <cfset picture_url="http://">
</cfif>
<cfif IsDefined('cc_name')>
  <cfset cc_name=#cc_name#>
<cfelse>
  <cfset cc_name="">
</cfif>
<cfif IsDefined('cc_number')>
  <cfset cc_number=#cc_number#>
<cfelse>
  <cfset cc_number="">
</cfif>
<cfif IsDefined('cc_expiration')>
  <cfset cc_expiration=#cc_expiration#>
<cfelse>
  <cfset cc_expiration="">
</cfif>
<cfparam name="obo" default="0">




<!--- Reviewing Place_ad & error checking--->

 <!-- Check for valid login & password --->
<cfif isDefined('form.review')>

  <cfquery name="check_login" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
      SELECT user_id, nickname, is_active, email,cc_name,cc_number,cc_expiration
      FROM users
		 
      WHERE

<cfif isdefined("session.user_id") and session.user_id is not "" and isdefined("session.password") and session.password is not "" and #isnumeric(session.user_id)#>
user_id =#session.user_id# and password = '#session.password#'
<cfelse>
 nickname = '#user_id#' AND password = '#password#'
        </cfif>     
  </cfquery>

  <cfif IsDefined("form.cc_name") AND 
	  IsDefined("form.cc_number") AND 
	  IsDefined("form.cc_expiration") AND
	  #Trim(form.cc_name)# Is Not "" AND
	  #Trim(form.cc_number)# Is Not "" AND
	  #Trim(form.cc_expiration)# Is Not "">
  	<cfset #session.cc_name# = #form.cc_name#>
  	<cfset #session.cc_number# = #form.cc_number#>
	  <cfset #session.cc_expiration# = #form.cc_expiration#>
<cfelseif IsDefined("check_login.cc_name") AND 
		  IsDefined("check_login.cc_number") AND 
		  IsDefined("check_login.cc_expiration") AND
		  #Trim(check_login.cc_name)# Is Not "" AND
		  #Trim(check_login.cc_number)# Is Not "" AND
		  #Trim(check_login.cc_expiration)# Is Not "">
    	<cfset #session.cc_name# = #check_login.cc_name#>
	    <cfset #session.cc_number# = #check_login.cc_number#>
    	<cfset #session.cc_expiration# = #check_login.cc_expiration#>
<cfelse>
	  <cfset #session.cc_name# = "">
	  <cfset #session.cc_number# = "">
	  <cfset #session.cc_expiration# = "">
</cfif>
  
<!--- set form fields to session variables --->
	<cfset session.user_id= #check_login.user_id# >
	<cfset session.password=form.password>
	<cfset session.email=check_login.email>
	<cfset session.adnum= form.adnum>
	<cfset session.title= form.title>
	<cfset session.category1 = form.cat>
	<cfset session.ad_body=#form.ad_body#>
	<cfset session.duration=#form.duration#>
	<cfset session.ask_price=REReplace("#form.ask_price#", "[^0123456789.]", "", "ALL")>
	<cfset session.picture_url=#form.picture_url#>
	<cfset session.obo=obo>
	<cfset session.set_session=1>
	<cfset session.date_start=date_start>
	
	<cfset #session.picture1# = #picture1#>
	<cfif #session.picture1# NEQ "">
		<cfset session.fullsize_name="#adnum#.#right(picture1,3)#">
	</cfif>
	<cfset #session.picture2# = #picture2#>
	<cfif #session.picture2# NEQ "">
		<cfset session.fullsize_name1="#adnum#.#right(picture2,3)#">
	</cfif>
	<cfset #session.picture3# = #picture3#>
	<cfif #session.picture3# NEQ "">
		<cfset session.fullsize_name2="#adnum#.#right(picture3,3)#">
	</cfif>


<cfset #session.picture4# = #picture4#>
	<cfif #session.picture4# NEQ "">
		<cfset session.fullsize_name3="#adnum#.#right(picture4,3)#">
	</cfif>
	
	<cfif cc_mandatory eq "no">
		<cfset session.payby = payby>
	<cfelse>
		<cfset session.payby = "none">
	</cfif>
	
<!--- set session to local variables --->
	<cfset user_id = session.user_id>
	<cfset password = session.password>
	<cfset email=session.email>
	<cfset adnum = session.adnum>
	<cfset title = session.title>
	<cfset category1 = session.category1>
	<cfset ad_body = session.ad_body>
	<cfset duration = session.duration>
	<cfset ask_price = session.ask_price>
	<cfset picture_url = session.picture_url>
	<cfset obo = session.obo>
	<cfset date_start = session.date_start>
	<cfset cc_name = session.cc_name>
	<cfset cc_number = session.cc_number>
	<cfset cc_expiration = session.cc_expiration>
	
	<cfif cc_mandatory eq "no">
		<cfset payby = session.payby>
	<cfelse>
		<cfset payby = session.payby>
	</cfif>

<!--- Error checking --->
<cfif #check_login.recordcount# is 0>  
  	 <cfset #error_message# = "<font color=ff0000>Login incorrect. Please try again.</font>">  
		<cfelseif #trim (title)# is "">
  	 <cfset #error_message# = "<font color=ff0000>Please specify a title for this item.</font>">
		<cfelseif #trim (ad_body)# is "">
  	 <cfset #error_message# = "<font color=ff0000>Please enter some text for this Ad.</font>"> 
		<cfelseif (#category1# is "-1")>
  	 <cfset #error_message# = "<font color=ff0000>Please specify a category for this Ad.</font>">
		<cfelseif (#trim (ask_price)# is "") or (#ask_price# is "0") or (#isNumeric (ask_price)# is "0")>
   	<cfset #error_message# = "<font color=ff0000>Please specify the Asking Price for the item.</font>"> 
	<cfelse>
    <cfif cc_mandatory is "Yes" or session.payby is "cc">
<!--- 	 	<cfif session.cc_number is "" or session.cc_number is "0" or session.cc_name is "" or session.cc_name is "0" or session.cc_expiration is "0" or session.cc_expiration is ""> --->
<!---     	<cfinclude template="../includes/cf_mod10.cfm"> --->
	    <cfif #cc_number# is not "">
      <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_number")#>
        <cfset #cc_number_error# = "Invalid credit card number.">
      </cfif>
<!---       <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
        <cfset #error_message# = #listAppend (error_message, "cc_name")#>
        <cfset #cc_name_error# = "Invalid cardholder name.">
      </cfif>
      <cfif #len (cc_expiration)# LT 3 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_expiration")#>
        <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
      </cfif> --->
    </cfif>
    
    <cfif #cc_name# is not "">
     <!---  <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_number")#>
        <cfset #cc_number_error# = "Invalid credit card number.">
      </cfif> --->
      <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
        <cfset #error_message# = #listAppend (error_message, "cc_name")#>
        <cfset #cc_name_error# = "Invalid cardholder name.">
      </cfif>
  <!---     <cfif #len (cc_expiration)# LT 3 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_expiration")#>
        <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
      </cfif> --->
    </cfif>
    
    <cfif #cc_expiration# is not "">
      <!--- <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_number")#>
        <cfset #cc_number_error# = "Invalid credit card number.">
      </cfif>
      <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
        <cfset #error_message# = #listAppend (error_message, "cc_name")#>
        <cfset #cc_name_error# = "Invalid cardholder name.">
      </cfif> --->
      <cfif #len (cc_expiration)# LT 3 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_expiration")#>
        <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
      </cfif>
    </cfif>
  </cfif>
  </cfif>
  	<cfif #error_message# is "">
 	 <cflocation url="review_ad.cfm?cat=#cat#">
	</cfif> 
</cfif> 


<!--- Determine the Ad Number --->
<cfif IsDefined("adnum")>
  <cfset adnum = #adnum#>
<cfelse>
  <cfset adnum=#EPOCH#>
</cfif>

<cfif adnum IS "">
  <cfset adnum=#EPOCH#>
</cfif>


<cfsetting enablecfoutputonly="No">
<cfoutput>
<HTML>
<HEAD>
<TITLE>Classified Ads Section -- Place Ad</TITLE>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
</HEAD>

<!--- Include the body tag --->
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
   
 
  <tr align="left" valign="top">
    <td height="191" colspan="2"> <font face="Arial, Helvetica, sans-serif" size="+2">Place
      your Classified Ad<br>
      </font>
      <hr width=100% size=1 color="#heading_color#" noshade>
      <cfif error_message is not "">
        <font color="red">#error_message#</font>
      </cfif>
      <br>
      <font face="Arial, Helvetica, sans-serif" size="+2"> </font>
      <form method="post" action="Place_ad.cfm"    enctype="multipart/form-data">
        <table  border="0" align="center">



          <tr>
            <td>
				
            <font color="000000"><b>Ad Number:</b></font>

            </td>

            <td>&nbsp;
            </td>

            <td > <input type="hidden" name="adnum" value="#adnum#"><font face="Arial, Helvetica, sans-serif" size="+1">#adnum# </font>
            </td>
          </tr>


          <tr>
            
            <td colspan="3"><font size=3>
       Please fill out the following form to place your ad, remembering
       to be as accurate and honest as possible when describing your offering, as set
       forth in the <A HREF="#VAROOT#/registration/user_agreement.html">User Agreement</A>.  You must be a <A HREF="#VAROOT#/registration/index.cfm">registered user</A> to advertise.<br>
            </font><br>
     <font size=3><b>* Indicates a required item; all others are optional.</b></font>
<hr width=100% size=1 color="#heading_color#" noshade>
            </td>
          </tr>
<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
         

 		<input name="user_id" type="hidden" value="#session.user_id#">
		<input name="password" type="hidden" value="#session.password#">

 	  <cfelse>


          <tr>
            <td>
				
            <font size=3 color="0000ff"><b>* User Name:</b></font>
            </td>
            <td ><input name="user_id" size="15" value="#user_id#" maxlength="20" >
            </td>

<!---
            <td rowspan="2">Ad Number: <input type="hidden" name="adnum" value="#adnum#"><font face="Arial, Helvetica, sans-serif" size="+1">#adnum#</font>
            </td>
--->
          </tr>
          <tr>
            <td><font size=3 color="0000ff"><b>* Password:</b></font>
            </td>
            <td>
           <input type="password" name="password" size="15" value="#password#" maxlength="12">
            </td>

          </tr> 



</cfif>
        
          </tr>
<!---
          <tr>
            <td colspan="3"><hr width=100% size=1 color="#heading_color#" noshade></td>
          </tr>
--->
          <tr>
          <td><font size=3 color="0000ff"><b>* Title:</b></font></td>
          <td colspan="2"><input name="title" value="#title#" size="45" ></td>
          </tr>
          <tr>
            <td><font size=3 color="0000ff"><b>* Category:</b></font>
            </td>
            <td>


<cfquery name="get_cats" datasource="#datasource#">
select name,category,parent from categories where category > 0
order by name ASC
</cfquery>

<select name="cat">
<cfloop query="get_cats">

<option value="#category#" <cfif isdefined("cat") and cat  eq category>selected</cfif>>#name#</option>
</cfloop>

</select>

<!---
        <cfmodule template="../functions/cf_category_tree.cfm"
                  datasource="#DATASOURCE#"
                  db_username="#db_username#"
                  db_password="#db_password#"
                  parent="0"

                  type="SELECT"
                  selectname="category1"
                  selected="#category1#">
--->

            </td>
            <td><!--- <input type="checkbox" name="community" value="1"<cfif #community# IS "1"> checked</cfif>>&nbsp;Request ad be placed as a community service. --->
            </td>
          </tr>
          <tr>
            <td align="left" valign="center"> <font size=3 color="0000ff"><b>* Ad Text:</b></font></td>
            <td colspan="2"><TEXTAREA WRAP="VIRTUAL" cols=60 name="ad_body" rows=5 value="#ad_body#">#ad_body#</TEXTAREA>
             </td>
          </tr>
          <tr>
       <td><font size=3 color="0000ff"><b>* Start Date/Time:</b></font></td>
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
            <td><font size=3 color="0000ff"><b>* Ad Duration:</b></font></td>
            <td colspan="2">
              <select name="Duration">
                <cfloop query="get_duration">
                 
                  <option value='#ad_dur#' selected>#ad_dur# Days - $#numberformat(ad_fee,numbermask)#
                </cfloop>
              </select>

            </td>
          </tr>
          <tr>
            <td><font size=3 color="0000ff"><b>* Asking Price:</b></font>
            </td>
          <td colspan="2"><input name="ask_price" value="#ask_price#" > &nbsp; (#Trim(getCurrency.type)#) &nbsp; <input name="obo" type="checkbox" value="1" <cfif obo is 1>CHECKED</CFIF>>Or Best Offer</TD>
          </tr>
          <tr>
            <td>Picture URL:</td>
            <td colspan="2">
              <input name="picture_url" size="45" maxlength="120" value="#picture_url#">
            </td>
          </tr>
		  <tr><td><font face="helvetica" size=2><b>Upload<br>Picture</b></font></td><td colspan="2"><input name="picture1" type="file" size=45 maxlength=250><br><font size="2">Do not put a space in image name.</font></td></tr>
		  <tr><td><font face="helvetica" size=2><b>Upload<br>Picture 2</b></font></td><td colspan="2"><input name="picture2" type="file" size=45 maxlength=250><br><font size="2">Do not put a space in image name.</font></td></tr>
		  <tr><td><font face="helvetica" size=2><b>Upload<br>Picture3</b></font></td><td colspan="2"><input name="picture3" type="file" size=45 maxlength=250><br><font size="2">Do not put a space in image name.</font></td></tr>

 <tr><td><font face="helvetica" size=2><b>Upload<br>Picture4</b></font></td><td colspan="2"><input name="picture4" type="file" size=45 maxlength=250><br><font size="2">Do not put a space in image name.</font></td></tr>

          <tr>
            <td colspan="3">
				<cfif cc_mandatory is "No">

		<table width="100%">
			<tr>
				<td colspan="2"><hr width=100% size=1 color="#heading_color#" noshade>
				<b><font size="4" color=0000ff>Payment Information</font></b></td>
			</tr>
			<tr>
				<td><input type="radio" name="payby" value="cc" checked> <b>Credit Card</b></td>
				<td><input type="radio" name="payby" value="cmo"> <b>Check/Money Order</b></td>
			</tr>
		</table>
</cfif>
				
				
				<TABLE><tr><td>
                    <br>
                    <b><font #IIf(cc_mandatory is "No", ('color=000000'), DE('color=0000ff'))#>Credit or Debit Card Information:</b> <br>
If you already have a credit card on file you may skip the following section.</font>
                    <!--- <font size=-1><i>All credit card numbers are secure and protected by the industry standard <b><a href="http://webopedia.internet.com/TERM/S/SSL.htm" target="_blank.htm">SSL.</a></b></i></font> ---></td></tr>
                   <tr>
                     <TD align=left valign="middle">

                     <table border=1 cellspacing=0 cellpadding=4 bordercolor="000000" width=100%>
                      <tr>
                        <td><font size=3 <cfif isDefined('cc_number_error') and #cc_number_error# is not "">  color="ff0000" </cfif>><b>Card Number:</b></font></td>
                        <td>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td><input type="text" name="cc_number" size=16 maxlength=16 value="#cc_number#"></td>
										<td align="right"><font size=2>&nbsp;(ex. "1234123412341234")</font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                     <cfif isDefined('cc_number_error') and #cc_number_error# is not "">
                      <tr>
                        <td>&nbsp;</td>
                        <td><font color="ff0000">#cc_number_error#</font></td>
                      </tr>
                     </cfif>
                      <tr>
                        <td><font size=3 <cfif isDefined('cc_name_error') and #cc_name_error# is not "">  color="ff0000" </cfif>><b>Name of cardholder:</b></font></td>
                        <td>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td><input type="text" name="cc_name" size=25 maxlength=65 value="#cc_name#"></td>
                              <td align="right"><font size=2>&nbsp;(Exactly as printed on the card)</font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                     <cfif isDefined('cc_name_error') and #cc_name_error# is not "">

                      <tr>
                        <td>&nbsp;</td>
                        <td><font color="ff0000">#cc_name_error#</font></td>
                      </tr>
                     </cfif>
                      <tr>
                        <td><font size=3  <cfif isDefined('cc_expiration_error') and #cc_expiration_error# is not "">  color="ff0000" </cfif>  ><b>Expiration date:</b></font></td>
                        <td>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td><input type="text" name="cc_expiration" size=7 maxlength=7 value="#cc_expiration#"><i><font size=-1> &nbsp; e.g., 01/00</font></i></td>
                              <td align="right"><font size=2>(Exactly as printed on the card)</font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                     <cfif isDefined('cc_expiration_error') and #cc_expiration_error# is not "">

                      <tr>
                        <td>&nbsp;</td>
                        <td><font color="ff0000">#cc_expiration_error#</font></td>
                      </tr>
                     </cfif>
                    </table>
                    <br></td></tr></TABLE>
           </td>
         </tr>
         <tr>
           <td colspan=3>

              <input type="submit" name="review" value="Review Ad"> &nbsp;
              <input type="reset" name="reset" value="Clear Form">

<!---
              <input type="hidden" name="cat" value="#cat#">

--->

            </td>
          </tr>

        </table>
      </form>
    </td>
  </tr>
   </table>
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
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></div>
</BODY>
</HTML></cfoutput>
