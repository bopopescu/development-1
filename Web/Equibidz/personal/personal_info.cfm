<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>

 <!--- Check for submits --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>

 <!--- Reset error code strings --->
 <cfset #error_list# = "">
 <cfset #cc_name_error# = "">
 <cfset #cc_number_error# = "">
 <cfset #cc_expiration_error# = "">
 <cfset #error_message# = "">
 <cfparam name="same_address" default="0">
 <cfparam name="bid_confirm_email" default="0">
 <cfparam name="outbid_email" default="0">
 <cfparam name="autobid_email" default="0">
 
 
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
 <!--- get currency type --->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
   SELECT pair AS type
     FROM defaults
    WHERE name = 'site_currency'
</cfquery>

<!--- apply membership --->
<cfif isdefined("apply_membership")>
	<cfif membership neq "">
		<cfparam name="paid" default="0">
		<cfset membership_fee = listgetat(membership,1,"_")>
		<cfset membership_cycle = listgetat(membership,4,"_")>
		
		<cfquery name="get_user_info" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			SELECT nickname, cc_number, cc_name, cc_expiration
			FROM users
			WHERE user_id = #session.user_id#
		</cfquery>

		<cfif membership_payment_type eq 1>
			<cfif get_user_info.cc_number neq 0 and isnumeric(get_user_info.cc_number) neq 1>
				<cfset cc_number = Decrypt(get_user_info.cc_number, "umbala")>
			<cfelse>
				<cfset cc_number = get_user_info.cc_number>
			</cfif>
			<cfset cc_name = get_user_info.cc_name>
			<cfset cc_expiration = get_user_info.cc_expiration>
			
			<cfif cc_number eq 0 or isnumeric(cc_number) is 0>
				<cfset #error_message# = "<font color='ff0000'>Incomplete - You have selected membership and credit card as payment method.  In order to proceed, You need to update your credit card information before apply or renew membership.</font>">
			<cfelse>
				<cfinclude template="../includes/cf_mod10.cfm">
			</cfif>
			<cfif error_message eq "">
			<!-- RUN AUTOMATED MODULES (CYBERCASH, ETC.), UPDATE PAID VALUE,STATUS -->
	    	<cfmodule template="../event2/expire/automated_payment.cfm"
			user_id="#session.user_id#"
    		itemnum="0"
			title="New Membership (#get_user_info.nickname#)"
			invoice_total="#membership_fee#">
		
			<cfif isdefined("billing_status") and billing_status IS "ok" AND paid GT 0>
				<cfif membership_cycle eq "Monthly">
					<cfset membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#>
				<cfelseif membership_cycle eq "LifeTime">
					<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#>
				<cfelse>
					<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#>
				</cfif>
				<cfset membership_status = 1>
			</cfif>
			</cfif>
		</cfif>
		
		<cfif error_message eq "">
		<cfif apply_membership eq "Renew">
			<cfquery name="upd_expire_membership" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
				UPDATE users
				SET membership_status = 0
				WHERE user_id = #session.user_id#
			</cfquery>
			<cfset membership_status = 0>
		</cfif>
   		<!--- update membership --->
  		<cfquery name="upd_membership_info" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			UPDATE users
			SET membership = '#membership#'
			   <cfif isdefined("billing_status") and billing_status IS "ok" AND paid GT 0>
			   ,membership_exp = #membership_exp#,
			   membership_status = 1
			   </cfif>
			WHERE user_id = #session.user_id#
		</cfquery>
   		
		<!--- send email --->
		<cfmodule template="../registration/eml_membership.cfm"
			itemnum="0"
			title="New Membership (#get_user_info.nickname#)"
			invSubTotal="#membership_fee#"
			user_id="#session.user_id#"
			paid="#paid#">
    
	
    		<!--- log creation of membership created ---> 
    		<cfmodule template="../functions/addTransaction.cfm"
      		datasource="#DATASOURCE#"
      		description="New Membership (#get_user_info.nickname#)"
      		details="MEMBERSHIP FEE: #membership_fee#    MEMBERSHIP OPTION: #membership#"
      		user_id="#session.user_id#">
	  
	  	</cfif>

   <cfelse>
   		<cfset #error_message# = "<font color='ff0000'>Missing Data - You must select membership option to renew.</font>">
   </cfif>
</cfif>
 

 <!--- Get their info from the database --->
 <cfif #submit# is "Cancel">
  <cflocation url="main_page.cfm">
 </cfif>

 <cfif #submit# is "">
  <cfquery username="#db_username#" password="#db_password#" name="get_user" datasource="#DATASOURCE#">
   SELECT email,
          password,
          keyword,
          date_registered,
          name,
          nickname,
          company,
          address1,
          address2,
          city,
          state,
          postal_code,
          country,
          phone1,
          phone2,
          fax,
          language,
          heard_from,
          promotion_code,
          friends_email,
          use_for,
          interested,
          age,
          education,
          income,
          survey,
          gender,
          mailing,
          balance,
          statement_date,
          last_login_date,
          is_active,
          cc_name,
          cc_number,
          cc_expiration,
		  same_address,
		  shipping_address1,
		  shipping_address2,
		  shipping_city,
		  shipping_state,
		  shipping_postal_code,
		  shipping_country,
		  bid_confirm_email,
		  outbid_email,
		  autobid_email,
		  membership,
		  membership_exp,
		  membership_status
     FROM users
    WHERE user_id = #session.user_id#
  </cfquery>

  <!--- Set global defaults --->
  <cfset #email# = #get_user.email#>
  <cfset #password# = #get_user.password#>
  <cfset #password2# = #get_user.password#>
  <cfset #keyword# = #get_user.keyword#>
  <cfset #name# = #get_user.name#>
  <cfset #nickname# = #get_user.nickname#>
  <cfset #company# = #get_user.company#>
  <cfset #address1# = #get_user.address1#>
  <cfset #address2# = #get_user.address2#>
  <cfset #city# = #get_user.city#>
  <cfset #state# = #get_user.state#>
  <cfset #postal_code# = #get_user.postal_code#>
  <cfset #country# = #get_user.country#>
  <cfset #phone1# = #get_user.phone1#>
  <cfset #phone2# = #get_user.phone2#>
  <cfset #fax# = #get_user.fax#>
  <cfset #language# = #get_user.language#>
  <cfset #heard_from# = #get_user.heard_from#>
  <cfset #promotion_code# = #get_user.promotion_code#>
  <cfset #friends_email# = #get_user.friends_email#>
  <cfset #use_for# = #get_user.use_for#>
  <cfset #interested# = #get_user.interested#>
  <cfset #age# = #get_user.age#>
  <cfset #education# = #get_user.education#>
  <cfset #income# = #get_user.income#>
  <cfset #survey# = #get_user.survey#>
  <cfset #gender# = #get_user.gender#>
  <cfset #mailing# = #get_user.mailing#>
  <cfset #is_active# = #get_user.is_active#>
  <cfset #date_registered# = #get_user.date_registered#>
  <cfset #last_login_date# = #get_user.last_login_date#>
  <cfset #cc_name# = #get_user.cc_name#>
 <cfif get_user.cc_number neq 0 and isnumeric(get_user.cc_number) neq 1 >
  <cfset cc_number = Decrypt(get_user.cc_number, "umbala")>
  <cfset #cc_number# = "************" & #right(cc_number, 4)#>
  <cfelse>
  <cfset #cc_number# = #get_user.cc_number#>
  </cfif>
  <cfset #cc_expiration# = #get_user.cc_expiration#>
  <cfset #same_address# = #get_user.same_address#>
  <cfset #shipping_address1# = #get_user.shipping_address1#>
  <cfset #shipping_address2# = #get_user.shipping_address2#>
  <cfset #shipping_city# = #get_user.shipping_city#>
  <cfset #shipping_state# = #get_user.shipping_state#>
  <cfset #shipping_postal_code# = #get_user.shipping_postal_code#>
  <cfset #shipping_country# = #get_user.shipping_country#>
  <cfset #bid_confirm_email# = #get_user.bid_confirm_email#>
  <cfset #outbid_email# = #get_user.outbid_email#>
  <cfset #autobid_email# = #get_user.autobid_email#>
  <cfset #membership# = #get_user.membership#>
  <cfset #membership_exp# = #get_user.membership_exp#>
  <cfset #membership_status# = #get_user.membership_status#>

 <cfelseif #submit# is "Update">

  <!--- Get the non-editable stuff --->
  <cfquery username="#db_username#" password="#db_password#" name="get_user" datasource="#DATASOURCE#">
   SELECT date_registered,
          name,
		  nickname,
          address1,
          address2,
          city,
          state,
          postal_code,
          country,
          phone1,
          heard_from,
          promotion_code,
          friends_email,
          use_for,
          gender
     FROM users
    WHERE user_id = #session.user_id#
  </cfquery>

  <cfset #name# = #get_user.name#>
  <cfset #nickname# = #get_user.nickname#>
  <!--- <cfset #address1# = #get_user.address1#>
  <cfset #address2# = #get_user.address2#>
  <cfset #city# = #get_user.city#>
  <cfset #state# = #get_user.state#>
  <cfset #postal_code# = #get_user.postal_code#> 
  <cfset #country# = #get_user.country#>
  <cfset #phone1# = #get_user.phone1#> --->
  <cfset #heard_from# = #get_user.heard_from#>
  <cfset #promotion_code# = #get_user.promotion_code#>
  <cfset #friends_email# = #get_user.friends_email#>
  <cfset #use_for# = #get_user.use_for#>
  <cfset #gender# = #get_user.gender#>
  <cfset #date_registered# = #get_user.date_registered#>

  <!--- First, check for missing data --->
  <cfif #error_message# is "">
   <cfif #nickname# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a nickname or alias for this user.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #email# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify an e-mail address.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #password# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a login password.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #password# is not #password2#>
    <cfset #error_message# = "<font color='ff0000'>Error - You must type the same password twice to confirm.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #keyword# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a keyword.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #address1# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify your address.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #city# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify city.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #state# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify state.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #postal_code# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify postal code.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif same_address eq 0 and #shipping_address1# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify your shipping address.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif same_address eq 0 and #shipping_city# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify shipping city.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif same_address eq 0 and #shipping_state# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify shipping state.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif same_address eq 0 and #shipping_postal_code# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify shipping postal code.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #phone1# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify phone number.</font>">
   </cfif>
  </cfif>

  <!--- Next, make sure E-Mail address is valid --->
  <cfif #error_message# is "">
   <CFMODULE TEMPLATE="../functions/Mailtest.cfm" EMail=#email#>
   <cfif #EMail_Level# GT 0>
    <cfset #error_message# = "<font color='ff0000'>Bad E-Mail Address - #EMail_Message#.</font>">
   </cfif>
  </cfif>

  <!--- Next, make sure password is alphanumeric --->
  <cfif #error_message# is "">
   <cfmodule template="../functions/checkpassword.cfm" password=#password#>
   <cfif #password_good# is not "1">
    <cfset #error_message# = "<font color='ff0000'>#result_message#</font>">
   </cfif>      
  </cfif>

  <!--- Check to see if their nickname is already in use --->
  <cfif #nickname# is not "">
    <cfquery username="#db_username#" password="#db_password#" name="check_nickname" datasource="#DATASOURCE#">
        SELECT user_id
          FROM users
         WHERE nickname LIKE '#nickname#'
         
      <cfif IsNumeric(nickname)>
            OR user_id = #nickname#
      </cfif>
    </cfquery>
    
    <cfif check_nickname.recordCount GT 0
      AND check_nickname.user_id IS NOT session.user_id>
      
      <cfset #error_message# = "<font color='ff0000'>Sorry, the nickname ""#nickname#"" is already in use by another user.  Please choose another.</font>">
    </cfif>
  </cfif>
  
    <!--- Validate credit card infomation --->
	<!--- <cfif (#trim (cc_name)# is not 0 or #trim (cc_name)# is "") or (#trim (cc_number)# is "" or #trim (cc_number)# is not 0) or (#trim (cc_expiration)# is not 0 or #trim (cc_expiration)# is "")>
	  <cfinclude template="../includes/cf_mod10.cfm">
	</cfif> --->
<cfif cc_number contains "*" is 0>
	<cfif (#trim (cc_name)# is not 0 or #trim (cc_name)# is "")>
	  <cfinclude template="../includes/cf_mod10.cfm">
	  <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_number")#>
        <cfset #cc_number_error# = "Invalid credit card number.">
      </cfif>
      <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
        <cfset #error_message# = #listAppend (error_message, "cc_name")#>
        <cfset #cc_name_error# = "Invalid cardholder name.">
      </cfif>
      <cfif #len (cc_expiration)# neq 5 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_expiration")#>
        <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
      </cfif>
	</cfif>
	
	<cfif (#trim (cc_number)# is not 0 or #trim (cc_number)# is "")>
	  <cfinclude template="../includes/cf_mod10.cfm">
	  <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_number")#>
        <cfset #cc_number_error# = "Invalid credit card number.">
      </cfif>
      <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
        <cfset #error_message# = #listAppend (error_message, "cc_name")#>
        <cfset #cc_name_error# = "Invalid cardholder name.">
      </cfif>
      <cfif #len (cc_expiration)# neq 5 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_expiration")#>
        <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
      </cfif>
	</cfif>  
	
	<cfif (#trim (cc_expiration)# is not 0 or #trim (cc_expiration)# is "")>
	  <cfinclude template="../includes/cf_mod10.cfm">
	    <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
        <cfset #error_message# = #listAppend (error_message, "cc_number")#>
        <cfset #cc_number_error# = "Invalid credit card number.">
      </cfif>
      <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
        <cfset #error_message# = #listAppend (error_message, "cc_name")#>
        <cfset #cc_name_error# = "Invalid cardholder name.">
      </cfif>
      <cfif len (cc_expiration) neq 5 or find ("/", cc_expiration) is 0 > 
	    <cfset #error_message# = #listAppend (error_message, "cc_expiration")#>
        <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' ">
        <cfset #error_message# = #listAppend (error_message, "#cc_expiration_error#")#>
      </cfif>
	</cfif>  
</cfif>
	
  <cfif not Len(error_message)>
    <!--- cc encryption --->
	<cfif form.cc_number contains "*" is 0 and cc_number neq "" and cc_number neq 0>
	<cfset cc_number = Encrypt(cc_number, "umbala")>
	</cfif>
    
    <cfquery username="#db_username#" password="#db_password#" name="update_user" datasource="#DATASOURCE#">
        UPDATE users
           SET email = '#email#',
               password = '#password#',
               keyword = '#keyword#',
               nickname = '#nickname#',
               company = '#company#',
			   address1 = '#address1#',
			   address2 = '#address2#',
			   city = '#city#',
			   state = '#state#',
			   postal_code = '#postal_code#',
			   country = '#country#',
			   phone1 = '#phone1#',
               phone2 = '#phone2#',
               fax = '#fax#',
               language = '#language#',
               interested = '#interested#',
               age = '#age#',
               education = '#education#',
               income = '#income#',
               survey = #survey#,
			   <cfif form.cc_number contains "*" is 0>
               cc_name = '#cc_name#',
               cc_number = '#cc_number#',
               cc_expiration = '#cc_expiration#',
			   </cfif>
               mailing = #mailing#,
			   same_address = #same_address#,
			   shipping_address1 = '#shipping_address1#',
			   shipping_address2 = '#shipping_address2#',
			   shipping_city = '#shipping_city#',
			   shipping_state = '#shipping_state#',
			   shipping_postal_code = '#shipping_postal_code#',
			   shipping_country = '#shipping_country#',
			   bid_confirm_email = '#bid_confirm_email#',
			   outbid_email = '#outbid_email#',
			   autobid_email = '#autobid_email#'
         WHERE user_id = #session.user_id#
    </cfquery>
    
    <cfset #session.password# = #password#>
    
    <!--- log update of account info --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Account Information Updated"
      user_id="#Session.user_id#">
    
    <cflocation url="main_page.cfm">
  </cfif>
 </cfif>

<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Personal Page: View/Edit Your Information</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">

 <cfoutput>

  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4 color="000000"><b>Personal Page - View &amp; Edit Your Information</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       The following section contains your account information.  From here you may 
       change those parts which are editable.  Due to legal reasons the information 
       that is not editable may only be changed by our staff.  If you wish to change these portions you 
       will need to contact us via phone or <a href="mailto:#SERVICE_EMAIL##DOMAIN#">email</a>.  
       Once you have finished making changes to your information, click the "Update" button 
       at the bottom of the page to finalize them.<br>
       <br>
       <cfif #error_message# is not "">
       <FONT FACE="" COLOR="Red"><b>
	 #error_message#</b></FONT><br><br>
       </cfif>

       <form action="personal_info.cfm" method="post">
        <input type="hidden" name="remote_ip" value="#cgi.remote_addr#">
        <table border=0 cellspacing=0 cellpadding=2 width=100%>
		 <tr bgcolor="#heading_color#"><td colspan=3 style="color:#heading_fcolor#; font-family:#heading_font#"><b>Personal Information</b></td></tr>
         <tr><td><b>User Name</b></td><td width=10>&nbsp;</td><td>#name#</td></tr>
         <tr><td><b>User ID Number</b></td><td width=10>&nbsp;</td><td>#session.user_id#</td></tr>
         <tr><td colspan=3>&nbsp;</td></tr>
         <!--- <tr><td><b>Nickname</b></td><td width=10>&nbsp;</td><td><input type="text" name="nickname" value="#nickname#" size=20 maxlength=20></td></tr> --->
		 <tr><td><b>Nickname</b></td><td width=10>&nbsp;</td><td>#nickname#</td></tr>
         <tr><td><b>Password</b></td><td width=10>&nbsp;</td><td><input type="password" name="password" value="#password#" size=12 maxlength=12></td></tr>
         <tr><td><b>(again to confirm)</b></td><td width=10>&nbsp;</td><td><input type="password" name="password2" value="#password2#" size=12 maxlength=12></td></tr>
         <tr><td><b>Keyword</b></td><td width=10>&nbsp;</td><td><input type="text" name="keyword" value="#keyword#" size=15 maxlength=20></td></tr>
         <tr><td><b>Company</b></td><td width=10>&nbsp;</td><td><input type="text" name="company" value="#company#" size=25 maxlength=65></td></tr>
		 <tr><td><b>Email Address</b></td><td width=10>&nbsp;</td><td><input type="text" name="email" value="#email#" size=35 maxlength=65></td></tr>
		 <tr>
                <td valign="top"><b>Email me when</b></td>
				<td width=10>&nbsp;</td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>
					<input type="Checkbox" name="bid_confirm_email" value="1" <cfif bid_confirm_email eq 1>checked</cfif>>&nbsp;<font size=2>My bid is successful</font><br>
					<input type="Checkbox" name="outbid_email" value="1" <cfif outbid_email eq 1>checked</cfif>>&nbsp;<font size=2>I am outbid</font><br>
					<input type="Checkbox" name="autobid_email" value="1" <cfif autobid_email eq 1>checked</cfif>>&nbsp;<font size=2>My bid is automatically raised via auto bid feature</font>
					</td></tr></table>
				</td>
              </tr>
         <tr><td><b>Primary Phone ##</b></td><td width=10>&nbsp;</td><td><input type="text" name="phone1" value="#phone1#" size=15 maxlength=20></td></tr>
         <tr><td><b>Secondary Phone ##</b></td><td width=10>&nbsp;</td><td><input type="text" name="phone2" value="#phone2#" size=15 maxlength=20></td></tr>
         <tr><td><b>Fax ##</b></td><td width=10>&nbsp;</td><td><input type="text" name="fax" value="#fax#" size=15 maxlength=20></td></tr>
		 <tr><td><b>Primary Language</b></td><td width=10>&nbsp;</td><td><cfmodule template="..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="language" selected="#language#" size="1" multiple="NO"></td></tr>
		 <tr><td colspan=3>&nbsp;</td></tr>
		 <tr><td colspan=3><font size="1">Notice: To edit credit card information begin with the credit card number.</font></td></tr>
         <tr>
          <td><font <cfif #listFind (error_message, "Card number is incorrect.")# or #listFind (error_message, "cc_number")#>color="ff0000"<cfelse>color="000000"</cfif>><b>Credit card number</b></font></td><td width=10>&nbsp;</td>
          <td><input type="text" name="cc_number" size=16 maxlength=16 value="#cc_number#"></td>
         </tr>
         <tr>
          <td><font <cfif #listFind (error_message, "cc_name")#>color="ff0000"<cfelse>color="000000"</cfif>><b>Name of cardholder</b></font></td><td width=10>&nbsp;</td>
          <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input type="text" name="cc_name" size=16 maxlength=100 value="#cc_name#"></td><td align="right"><font size=2>&nbsp;&nbsp;&nbsp;(Exactly as printed on the card)</font></td></tr></table></td>
         </tr>
         <tr>
          <td><font <cfif #listFind (error_message, "Credit Card Expired.")# or #listFind (error_message, "cc_expiration")#>color="ff0000"<cfelse>color="000000"</cfif>><b>Expiration date</b></font></td><td width=10>&nbsp;</td>
          <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input type="text" name="cc_expiration" size=7 maxlength=7 value="#cc_expiration#"></td><td align="right"><font size=2>&nbsp;&nbsp;&nbsp;(Exactly as printed on the card)</font></td></tr></table></td>
         </tr>
		 
		 <tr><td colspan=3>&nbsp;</td></tr>
         <tr><td><b>Address</b></td><td width=10>&nbsp;</td><td><input type="text" name="address1" value="#address1#" size=25 maxlength=65></td></tr>
         <tr><td><b>Address (line 2)</b></td><td width=10>&nbsp;</td><td><input type="text" name="address2" value="#address2#" size=25 maxlength=65></td></tr>
         <tr><td><b>City</b></td><td width=10>&nbsp;</td><td><input type="text" name="city" value="#city#" size=25 maxlength=65></td></tr>
         <tr><td><b>State</b></td><td width=10>&nbsp;</td><td><input type="text" name="state" value="#state#" size=25 maxlength=65></td></tr>
         <tr><td><b>Postal Code</b></td><td width=10>&nbsp;</td><td><input type="text" name="postal_code" value="#postal_code#" size=25 maxlength=65></td></tr>
         <tr><td><b>Country</b></td><td width=10>&nbsp;</td><td><CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="country" SELECTED="#country#" MULTIPLE="0" SIZE="1"></td></tr>
		 <tr bgcolor="#heading_color#"><td valign="top" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Shipping Information</b></td><td width=10>&nbsp;</td><td style="color:#heading_fcolor#; font-family:#heading_font#"><input type="checkbox" name="same_address" value="1" <cfif same_address eq 1>checked</cfif>>&nbsp;<font size=2>Check here if your shipping address is the same as the address above.<br>(Check means you can ignore the shipping address fields below.)</font></td></tr>
		 <tr><td><b>Shipping Address</b></td><td width=10>&nbsp;</td><td><input type="text" name="shipping_address1" value="#shipping_address1#" size=25 maxlength=65></td></tr>
         <tr><td><b>Shipping Address (line 2)</b></td><td width=10>&nbsp;</td><td><input type="text" name="shipping_address2" value="#shipping_address2#" size=25 maxlength=65></td></tr>
         <tr><td><b>Shipping City</b></td><td width=10>&nbsp;</td><td><input type="text" name="shipping_city" value="#shipping_city#" size=25 maxlength=65></td></tr>
         <tr><td><b>Shipping State</b></td><td width=10>&nbsp;</td><td><input type="text" name="shipping_state" value="#shipping_state#" size=25 maxlength=65></td></tr>
         <tr><td><b>Shipping Postal Code</b></td><td width=10>&nbsp;</td><td><input type="text" name="shipping_postal_code" value="#shipping_postal_code#" size=25 maxlength=65></td></tr>
         <tr><td><b>Shipping Country</b></td><td width=10>&nbsp;</td><td><CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="shipping_country" SELECTED="#shipping_country#" MULTIPLE="0" SIZE="1"></td></tr>
		 <tr><td colspan=3>&nbsp;</td></tr>
		 
		 <tr><td colspan=3 bgcolor="#heading_color#" style="color:#heading_fcolor#; font-family:#heading_font#"><b>Optional Information</b></td></tr>
         
         <cfif get_membership_status.pair eq 1>
			  <tr>
                <td valign="bottom"><b><cfif membership neq "" and membership_exp gt timenow>Your </cfif>Membership</b><br><a href="../help/about_membership.cfm" target="_blank"><font size="-2">about membership</font></a></td>
				<td width=10>&nbsp;</td>
                <td>
				  <cfif membership neq "" and (membership_exp gt timenow or membership_status eq 0)>
				  <input type="Hidden" name="membership" value="#membership#">
				  <input type="Hidden" name="membership_exp" value="#membership_exp#">
				  <input type="Hidden" name="membership_status" value="#membership_status#">
				  <cfset membership_fee = listgetat(membership,1,"_")>
				  <cfset membership_pct = listgetat(membership,2,"_")>
				  <cfset membership_name = listgetat(membership,3,"_")>
				  <cfset membership_cycle = listgetat(membership,4,"_")>
				  #membership_name# #membership_pct#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership.<br><cfif membership_status eq 1 and membership_exp gt timenow>(exp. #dateformat(membership_exp,"mm/dd/yyyy")#)<cfelse><b>Status: INACTIVE</b></cfif>
				  <cfelse>
				  <input type="Hidden" name="membership_exp" value="#membership_exp#">
				  <input type="Hidden" name="membership_status" value="#membership_status#">
				  <b>Payment Method:</b> <input type="Radio" name="membership_payment_type" value="1" <cfif link_point neq "no">checked<cfelse>disabled</cfif>> Credit Card <input type="Radio" name="membership_payment_type" value="2" <cfif link_point eq "no">checked</cfif>> Send a Check<cfif isdefined("paypal") and paypal eq "yes">/PayPal</cfif><br>
                  <select name="membership">
                  <option value="">-- Select an option --</option>
                  <cfloop query="get_memberships">
				  <cfset membership_fee = listgetat(pair,1,"_")>
				  <cfset membership_pct = listgetat(pair,2,"_")>
				  <cfset membership_name = listgetat(pair,3,"_")>
				  <cfset membership_cycle = listgetat(pair,4,"_")>
				  <option value="#pair#"<cfif #membership# is pair> selected</cfif>>#membership_name# #membership_pct#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership</option>
				  </cfloop>
                  </select>&nbsp;&nbsp;<input type="Submit" name="apply_membership" value=<cfif membership neq "">Renew<cfelse>Apply</cfif>>
				  </cfif>
                </td>
			  </tr>
			  <cfelse>
			  	<input type="Hidden" name="membership" value="#membership#">
			  </cfif>
         <tr><td><b>Interested in</b></td><td width=10>&nbsp;</td><td><input type="text" name="interested" value="#interested#" size=35 maxlength=50></td></tr>
         <tr>
          <td><b>Age Range</b></td><td width=10>&nbsp;</td>
          <td>
           <select name="age">
            <option value=""<cfif #age# is ""> selected</cfif>>-- Select a range --</option>
            <option value="18-24"<cfif #age# is "18-24"> selected</cfif>>18-24</option>
            <option value="25-34"<cfif #age# is "25-34"> selected</cfif>>25-34</option>
            <option value="35-50"<cfif #age# is "35-50"> selected</cfif>>35-50</option>
            <option value="51-65"<cfif #age# is "51-65"> selected</cfif>>51-65</option>
            <option value="Over 65"<cfif #age# is "Over 65"> selected</cfif>>Over 65</option>
           </select>
          </td>
         </tr>
         <tr>
          <td><b>Education Completed</b></td><td width=10>&nbsp;</td>
          <td>
           <select name="education">
            <option value=""<cfif #education# is ""> selected</cfif>>-- Select an education --</option>
            <option value="High School"<cfif #education# is "High School"> selected</cfif>>High School</option>
            <option value="College"<cfif #education# is "College"> selected</cfif>>College</option>
            <option value="Graduate School"<cfif #education# is "Graduate School"> selected</cfif>>Graduate School</option>
            <option value="Other"<cfif #education# is "Other"> selected</cfif>>Other</option>
           </select>
          </td>
         </tr>
         <tr>
          <td><b>Annual Income</b></td><td width=10>&nbsp;</td>
          <td>
            <select name="income">
             <option value=""<cfif #income# is ""> selected</cfif>>-- Select a range --</option>
             <option value="Under $25,000"<cfif #income# is "Under $25,000"> selected</cfif>>Under $25,000</option>
             <option value="$25,000 - $35,000"<cfif #income# is "$25,000 - $35,000"> selected</cfif>>$25,000 - $35,000</option>
             <option value="$36,000 - $49,000"<cfif #income# is "$36,000 - $49,000"> selected</cfif>>$36,000 - $49,000</option>
             <option value="$50,000 - $75,000"<cfif #income# is "$50,000 - $75,000"> selected</cfif>>$50,000 - $75,000</option>
             <option value="Over $75,000"<cfif #income# is "Over $75,000"> selected</cfif>>Over $75,000</option>
            </select>
          </td>
         </tr>

         <tr>
          <td><b>Participate in Survey?</b></td><td width=10>&nbsp;</td>
          <td>
           <select name="survey">
            <option value="1"<cfif #survey# is "1"> selected</cfif>>Yes</option>
            <option value="0"<cfif #survey# is "0"> selected</cfif>>No thanks</option>
           </select>
          </td>
         </tr>

         <tr>
          <td><b>On mailing list?</b></td><td width=10>&nbsp;</td>
          <td>
           <select name="mailing">
            <option value="1"<cfif #mailing# is "1"> selected</cfif>>Yes</option>
            <option value="0"<cfif #mailing# is "0"> selected</cfif>>No thanks</option>
           </select>
          </td>
         </tr>

         
         <tr><td colspan=3>&nbsp;</td></tr>
         <tr>
          <td colspan=3><hr size=1 color=#heading_color# width=100%><input type="submit" name="submit" value="Update" width=75>&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Cancel" width=75></td>
         </tr>
        </table>

        <br>
       </font>
      </form>
     </td>
    </tr>
    <tr><td>
     <br><br>
   <div align="center">

 <cfinclude template="nav.cfm">
</div>
      </td></tr></table></div><div align="center">
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
      </table></cfoutput></div>
 </body>
</html>




