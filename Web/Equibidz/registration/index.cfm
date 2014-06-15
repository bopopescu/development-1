<!---
	Main Registration Page:

--->

 <!--- include globals --->
<cfset current_page="register">
 <cfinclude template="../includes/app_globals.cfm">
 
 
  
 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

 <!--- Get the listing background color ---> 
<cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
<cfset #header_bg# = #get_listing_bgcolor.pair#>
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

<!--- Define template globals --->
<cfset #error_message# = "">
<cfset #error_list# = "">
<cfset #email_msg# = "">
<cfset sBlockedMsg = "">
<!--- Check to see what to do next ---> 
<cfif #isDefined ("submit")#>
  <cfset #submit# = #trim (submit)#>
  <cfelse>
  <cfset #submit# = "">
</cfif>
<cfset #password_error# = "">
<cfset #cc_number_error# = "">
<cfset #cc_name_error# = "">
<cfset #cc_expiration_error# = "">
<cfparam name="same_address" default="0">
<cfparam name="bid_confirm_email" default="0">
<cfparam name="outbid_email" default="0">
<cfparam name="autobid_email" default="0">
<cfparam name="paid" default="0">


<!--- Check for form submission ---> 
<cfif #submit# is "Next">
  <!--- Trim data before comparing it ---> 
  <cfset #nickname# = #trim (nickname)#>
  <cfset #password# = #trim (password)#>
  <cfset #password2# = #trim (password2)#>
  <cfset #email# = #trim (email)#>
  <cfset #email_confirm# = #trim (email_confirm)#>
  <cfset #name# = #trim (name)#>
  <cfset #company# = #trim (company)#>
  <cfset #address1# = #trim (address1)#>
  <cfset #address2# = #trim (address2)#>
  <cfset #city# = #trim (city)#>
  <cfset #state# = #trim (state)#>
  <cfset province = trim(province)>
  <cfset #postal_code# = #trim (postal_code)#>
  <cfset #phone1# = #trim (phone1)#>
  <cfset #phone2# = #trim (phone2)#>
  <cfset #fax# = #trim (fax)#>
  <!--- 3/25/2013 JM <cfset #promotion_code# = #trim (promotion_code)#>--->
  <cfset #friends_email# = #trim (friends_email)#>
  <cfset #interested# = #trim (interested)#>
  <!--- 3/25/2013 JM <cfset #cc_name# = #trim (cc_name)#>
  <cfset #cc_number# = #trim (cc_number)#>
  <cfset #cc_expiration# = #trim (cc_expiration)#>--->
  <!--- Check to see if the same e-mail was used for an inactive user ---> 
  <cfquery username="#db_username#" password="#db_password#" name="check_inactive_users" datasource="#DATASOURCE#">
      SELECT user_id
        FROM users
       WHERE email LIKE '#email#'
         AND is_active = 0
  </cfquery>
  <cfif #check_inactive_users.recordcount# GT 0>
    <cfset #email_msg# = "<font color='ff0000'>Sorry, your account is disabled; you cannot re-register.</font>">
  </cfif>
  <!--- chk domain isn't blocked ---> 
  <cfmodule template="../functions/emailBlocks.cfm"
    action="CHK-DOMAIN"
    datasource="#DATASOURCE#"
    address="#email#"
    retBlocked="bDomainBlocked">
  <cfif Variables.bDomainBlocked>
    <cfset sBlockedMsg = '<font color="ff0000">Sorry, the domain name of your email account has been blocked from our server.</font>'>
  </cfif>
  <!--- chk email account isn't blocked ---> 
  <cfif not Variables.bDomainBlocked>
    <cfmodule template="../functions/emailBlocks.cfm"
      action="CHK-ACCOUNT"
      datasource="#DATASOURCE#"
      address="#email#"
      retBlocked="bAccountBlocked">
    <cfif Variables.bAccountBlocked>
      <cfset sBlockedMsg = '<font color="ff0000">Sorry, your email account has been blocked from our server.</font>'>
    </cfif>
  </cfif>
  <!--- chk nickname ---> 
  <cfquery username="#db_username#" password="#db_password#" name="check_nickname" datasource="#DATASOURCE#">
      SELECT user_id
        FROM users
       WHERE nickname LIKE '#nickname#'
    
    <cfif IsNumeric(nickname)>
          OR user_id = #nickname#
    </cfif>
  </cfquery>
  <cfif #check_nickname.recordcount# GT 0>
    <cfset #error_list# = #listAppend (error_list, "nickname")#>
    <cfset #nickname_error# = "The nickname you chose is already in use.  Please choose another.">
    <cfelseif #len (nickname)# LT 5>
    <cfset #error_list# = #listAppend (error_list, "nickname")#>
    <cfset #nickname_error# = "Nickname too short; it must be at least 5 characters long.">
  </cfif>
  <!--- Check for password invalid data ---> 
  <CFMODULE TEMPLATE="..\functions\checkpassword.cfm" password="#password#">
  <cfif #password# is not #password2#>
    <cfset #error_list# = #listAppend (error_list, "password")#>
    <cfset #error_list# = #listAppend (error_list, "password2")#>
    <cfset #password_error# = "The passwords you typed didn't match. Please type the same password twice.">
    <cfelse>
    <cfif #password_good# is not "1">
      <cfset #error_list# = #listAppend (error_list, "password")#>
      <cfset #error_list# = #listAppend (error_list, "password2")#>
      <cfset #password_error# = "The password you entered is not secure enough; it must be at least 5 characters long and contain numbers and letters.">
    </cfif>
  </cfif>
  <cfif #len (keyword)# LT 3>
    <cfset #error_list# = #listAppend (error_list, "keyword")#>
    <cfset #keyword_error# = "You must specify a keyword at least 3 characters long.">
  </cfif>
  <!--- Check for errors in data ---> 
  <cfif #email# is not #email_confirm#>
    <cfset #error_list# = #listAppend (error_list, "email")#>
    <cfset #error_list# = #listAppend (error_list, "email_confirm")#>
  </cfif>
  <cfmodule template="..\functions\Mailtest.cfm" email=#email#>
  <cfif #email_level# GT 0>
    <cfset #error_list# = #listAppend (error_list, "email")#>
  </cfif>
  <cfmodule template="..\functions\Mailtest.cfm" email=#friends_email#>
  <cfif #email_level# GT 1>
    <cfset #error_list# = #listAppend (error_list, "friendsemail")#>
  </cfif>
  <!--- 3/25/2013 JM <cfif #cc_number# is not "">
  <cfinclude template="../includes/cf_mod10.cfm">
    <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
      <cfset #error_list# = #listAppend (error_list, "cc_number")#>
      <cfset #cc_number_error# = "Invalid credit card number.">
    </cfif>
    <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
      <cfset #error_list# = #listAppend (error_list, "cc_name")#>
      <cfset #cc_name_error# = "Invalid cardholder name.">
    </cfif>
    <cfif #len (cc_expiration)# LT 3 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
      <cfset #error_list# = #listAppend (error_list, "cc_expiration")#>
      <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
    </cfif>
  </cfif>
  <cfif #cc_name# is not "">
  <cfinclude template="../includes/cf_mod10.cfm">
    <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
      <cfset #error_list# = #listAppend (error_list, "cc_number")#>
      <cfset #cc_number_error# = "Invalid credit card number.">
    </cfif>
    <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
      <cfset #error_list# = #listAppend (error_list, "cc_name")#>
      <cfset #cc_name_error# = "Invalid cardholder name.">
    </cfif>
    <cfif #len (cc_expiration)# LT 3 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
      <cfset #error_list# = #listAppend (error_list, "cc_expiration")#>
      <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
    </cfif>
  </cfif>
  <cfif #cc_expiration# is not "">
  <cfinclude template="../includes/cf_mod10.cfm">
    <cfif (#len (cc_number)# LT 8 or #isNumeric (cc_number)# is 0)>
      <cfset #error_list# = #listAppend (error_list, "cc_number")#>
      <cfset #cc_number_error# = "Invalid credit card number.">
    </cfif>
    <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
      <cfset #error_list# = #listAppend (error_list, "cc_name")#>
      <cfset #cc_name_error# = "Invalid cardholder name.">
    </cfif>
    <cfif #len (cc_expiration)# LT 3 or (#find ("/", cc_expiration)# is 0 and #find ("-", cc_expiration)# is 0)>
      <cfset #error_list# = #listAppend (error_list, "cc_expiration")#>
      <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
    </cfif>
  </cfif>--->
  <cfif #len (name)# LT 5>
    <cfset #error_list# = #listAppend (error_list, "name")#>
  </cfif>
  <cfif #len (address1)# LT 1>
    <cfset #error_list# = #listAppend (error_list, "address1")#>
  </cfif>
  <cfif #len (city)# LT 1>
    <cfset #error_list# = #listAppend (error_list, "city")#>
  </cfif>
  <cfif country eq "USA">
  <cfif #len (state)# LT 2>
    <cfset #error_list# = #listAppend (error_list, "state")#>
  </cfif>
  <cfelse>
  <cfif #len (province)# LT 2>
    <cfset #error_list# = #listAppend (error_list, "province")#>
  </cfif>
  </cfif>
  <cfif #len (postal_code)# LT 3>
    <cfset #error_list# = #listAppend (error_list, "postal_code")#>
  </cfif>
  <cfif same_address eq 0 and #len (shipping_address1)# LT 1>
    <cfset #error_list# = #listAppend (error_list, "shipping_address1")#>
  </cfif>
  <cfif same_address eq 0 and #len (shipping_city)# LT 1>
    <cfset #error_list# = #listAppend (error_list, "shipping_city")#>
  </cfif>
  <cfif shipping_country eq "USA">
  <cfif same_address eq 0 and #len (shipping_state)# LT 2>
    <cfset #error_list# = #listAppend (error_list, "shipping_state")#>
  </cfif>
  <cfelse>
  <cfif same_address eq 0 and #len (shipping_province)# LT 2>
    <cfset #error_list# = #listAppend (error_list, "shipping_province")#>
  </cfif>
  </cfif>
  <cfif same_address eq 0 and #len (shipping_postal_code)# LT 3>
    <cfset #error_list# = #listAppend (error_list, "shipping_postal_code")#>
  </cfif>
  <cfif #len (phone1)# LT 6>
    <cfset #error_list# = #listAppend (error_list, "phone1")#>
  </cfif>
  <!--- 3/25/2013 JM <cfif get_membership_status.pair eq 1>
  <cfif membership neq "" and membership_payment_type eq 1 and cc_number eq "">
    <cfset #error_list# = #listAppend (error_list, "membership")#>
	<cfset #error_message# = "INCOMPLETE: You have selected membership and credit card as payment method.  In order to proceed, You need to provide credit card information.">
  </cfif>
  </cfif>--->
	
	
	
  <!--- If everything is OK, put them in the database and go to next page ---> 
  <cfif #error_list# is ""
    AND #error_message# IS ""
    AND #email_msg# IS ""
    AND not Len(Variables.sBlockedMsg)>
    <!--- Include this module to obtain a unique ID for the user ---> 
    <CFMODULE TEMPLATE="../functions/epoch.cfm">
    <cfset #user_id# = #EPOCH#>
    <!--- <cfset #password# = #lcase ("#left (name, 1)##right (name, 1)##randRange (100, 999)##left (state,1)##randRange (1000, 9999)#")#> ---> 
	<!--- cc encryption --->
	<!---<cfif cc_number neq "" and cc_number neq 0>
	<cfset cc_number = Encrypt(cc_number, "umbala")>
	</cfif> --->
	
	
    <cfquery username="#db_username#" password="#db_password#" name="add_user" datasource="#DATASOURCE#">
   INSERT INTO users
               (user_id,
                email,
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
                <!--- 3/25/2013 JM promotion_code,--->
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
                is_active,
                last_login_date,
                credit,
				<!--- 3/25/2013 JM cc_name,
                cc_number,
                cc_expiration,--->
				same_address,
				shipping_address1,
				shipping_address2,
				shipping_city,
				shipping_state,
				shipping_postal_code,
				shipping_country,
				bid_confirm_email,
				outbid_email,
				autobid_email
				)

   VALUES     (#user_id#,
               '#email#',
               '#password#',
               '#keyword#',
               #createODBCDateTime(timenow)#,
               '#name#',
               '#nickname#',
               '#company#',
               '#address1#',
               '#address2#',
               '#city#',
			   <cfif country eq "USA">
               '#state#',
			   <cfelse>
			   '#province#',
			   </cfif>
               '#postal_code#',
               '#country#',
               '#phone1#',
               '#phone2#',
               '#fax#',
               '#language#',
               '#heard_from#',
              <!--- 3/25/2013 JM  '#promotion_code#',--->
               '#friends_email#',
               '#use_for#',
               '#interested#',
               '#age#',
               '#education#',
               '#income#',
               #survey#,
               '#gender#',
               #mailing#,
               0,
               '2010-01-01',
               1,
               #createODBCDateTime(timenow)#,
               0.00,
			   <!--- 3/25/2013 JM <cfif cc_name neq "">'#cc_name#'<cfelse>'0'</cfif>,
			   <cfif cc_number neq "">'#cc_number#'<cfelse>'0'</cfif>,
			   <cfif cc_expiration neq "">'#cc_expiration#'<cfelse>'0'</cfif>,--->
			   #same_address#,<cfif same_address eq 1>
			   '#address1#',
               '#address2#',
               '#city#',
               <cfif country eq "USA">
               '#state#',
			   <cfelse>
			   '#province#',
			   </cfif>
               '#postal_code#',
               '#country#',			   
			   <cfelse>
			   '#shipping_address1#',
			   '#shipping_address2#',
			   '#shipping_city#',
			   <cfif shipping_country eq "USA">
               '#shipping_state#',
			   <cfelse>
			   '#shipping_province#',
			   </cfif>
			   <!--- '#shipping_state#', --->
			   '#shipping_postal_code#',
			   '#shipping_country#',</cfif>
			   #bid_confirm_email#,
			   #outbid_email#,
			   #autobid_email#
			   )
   </cfquery>
   
   <!--- membership --->
   <!--- 03272013 JM <cfif get_membership_status.pair eq 1 and membership neq "">
   		<cfset membership_fee = #listgetat(membership,1,"_")#>
		<cfset membership_cycle = listgetat(membership,4,"_")>
		
		<cfif membership_payment_type eq 1>
	     <!-- RUN AUTOMATED MODULES (CYBERCASH, ETC.), UPDATE PAID VALUE,STATUS -->
<cfif link_point eq "YES" >
<cfmodule template="../event2/expire/automated_payment.cfm"
		user_id="#user_id#"
    	itemnum="0"
		title="New Membership (#nickname#)"
		invoice_total="#membership_fee#">
	
</cfif>
<cfif authorize_net_aim eq "YES">
<cfmodule template="../event2/expire/auth_net_automated_billing.cfm"
		user_id="#user_id#"
    	itemnum="0"
		title="New Membership (#nickname#)"
		invoice_total="#membership_fee#">


		</cfif>

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
		
		</cfif>--->
		
   		<!--- update membership --->
  		<!--- 03272013 JM <cfquery name="insert_member_bal" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			UPDATE users
			SET membership = '#membership#'
			   <cfif isdefined("billing_status") and billing_status IS "ok" AND paid GT 0>
			   ,membership_exp = #membership_exp#,
			   membership_status = 1
			   </cfif>
			WHERE user_id = #user_id#
		</cfquery>--->
   		
		<!--- send email --->
		<!--- 03272013 JM <cfmodule template="eml_membership.cfm"
			itemnum="0"
			title="New Membership (#nickname#)"
			invSubTotal="#membership_fee#"
			user_id="#user_id#"
			paid="#paid#">--->
		
    	<!--- log creation of new membership  ---> 
    	<!--- 03272013 JM <cfmodule template="../functions/addTransaction.cfm"
      		datasource="#DATASOURCE#"
      		description="New Membership (#nickname#)"
      		details="MEMBERSHIP FEE: #membership_fee#    MEMBERSHIP OPTION: #membership#"
      		user_id="#user_id#">
   </cfif>
   --->
   
    <!--- log creation of new account ---> 
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Account Created"
      details="EMAIL: #email#"
      user_id="#user_id#">
    <cflocation url="thankyou.cfm?user_id=#user_id#">
  </cfif>
  <cfelse>
  <!--- They came to the page for the first time, set defaults ---> 
  <cfset nickname = "">
  <cfset password = "">
  <cfset password2 = "">
  <cfset keyword = "">
  <cfset #email# = "">
  <cfset #email_confirm# = "">
  <cfset #name# = "">
  <cfset #company# = "">
  <cfset #address1# = "">
  <cfset #address2# = "">
  <cfset #city# = "">
  <cfset #state# = "">
  <cfset province = "">
  <cfset #postal_code# = "">
  <cfset #country# = "USA">
  <cfset #language# = "en">
  <cfset #phone1# = "">
  <cfset #phone2# = "">
  <cfset #fax# = "">
  <cfset #heard_from# = "">
  <cfset #promotion_code# = "">
  <cfset #friends_email# = "">
  <cfset #use_for# = "">
  <cfset #interested# = "">
  <cfset #age# = "">
  <cfset #education# = "">
  <cfset #income# = "">
  <cfset #survey# = "">
  <cfset #gender# = "N">
  <cfset #mailing# = "">
  <cfset #cc_name# = "">
  <cfset #cc_number# = "">
  <cfset #cc_expiration# = "">
  <cfset #cc_number_error# = "">
  <cfset #cc_name_error# = "">
  <cfset #cc_expiration_error# = "">
  <cfset #shipping_address1# = "">
  <cfset #shipping_address2# = "">
  <cfset #shipping_city# = "">
  <cfset #shipping_state# = "">
  <cfset shipping_province = "">
  <cfset #shipping_postal_code# = "">
  <cfset #shipping_country# = "USA">
  <cfset #same_address# = 1>
  <cfset #bid_confirm_email# = 1>
  <cfset #outbid_email# = 1>
  <cfset #autobid_email# = 1>
  <cfset #membership# = "">
</cfif>

<cfoutput>


  
    <title>New User Registration</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">


<html>
  <head>
    <title>New User Registration</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">

		<cfif isdefined("submitted") and submitted eq "Accept">
		<cfelseif isdefined("submitted") and submitted eq "Decline">
		<div align="center>

      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width=800>
       
        <tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
      <P align=center>
                    <FONT SIZE="+1">
                      New User Registration
                    </FONT></P>
                  </td>
        </tr></table></div>
		<div align="center>

      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width=800>
		<tr>
			<td>
			<br>
                  We regret to inform you that by declining to accept the terms and conditions
                  of our User Agreement, your registration could not be finalized, and you will not
                  have access to our site.  You may, however, still register by following the same
                  instructions at a later date if you feel you've changed your mind and wish to
                  continue with your registration.<br>
                  <br>
                  If you have any questions, please contact <a href="mailto:#QUESTION_EMAIL##DOMAIN#">Customer Service</a>.<br>
                  <br>
                  Thank you for your cooperation,<br>
                  <i>#COMPANY_NAME#</i>
				  
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
		
		<cfabort>
		<cfelse>
			<cflocation url="user_agreement.cfm">
		</cfif>
		<div align="center>

      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width=800>
       
        <tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
      <P align=center>
                    <FONT SIZE="+1">
                      New User Registration
                    </FONT></P>
                  </td>
        </tr></table></div>
		<div align="center">

      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            
            <font size=3>   
                    <b>Complete Registration Form</b><br>
                    Fill out the form below as accurately as possible.  Be sure to include a 
                    valid e-mail address where you can be reached, since this is where your 
                    password will be sent.<br>
                    <br>
                    
                    <font size=2>
                      <b>Note:</b> You must be at least 18 years of age to register as a user on this 
                      site.  Be aware that we will not give out your information to any other company, 
                      but will use it only for our own internal use.  Please make sure your mail 
                      reading program doesn't have filters enabled which would block email from our 
                      server.  You will not be able to access the site without the information in 
                      your confirmation email.<br>
                    </font>
                    <br>
            </font>
          </td>
        </tr>
        <tr>
          <td>         <hr size=1 color=#heading_color# width=100%></td>
        </tr></table></div>
        <form name="reg_form" action="index.cfm" method="get">
		<input type="Hidden" name="submitted" value="#submitted#">
		<div align="center">
		<table width="800" border=0>
        <tr>
          <td>
            <!---       #error_list# --->
            
              <font size=3><b>* Indicates a required item; all others are optional.</b></font>
              <br>
            
            <cfif #error_list# is not "">
              <font size=3 color=ff0000><b>INCOMPLETE:</b> Please verify that the highlighted items are correct.</font><br>
            </cfif>
			          <cfif #cc_number_error# is not "">
                      <font color="ff0000">#cc_number_error#</font>
                      </cfif>
                      <cfif #password_error# is not "">
                        <font color="ff0000">#password_error#</font>
                      </cfif>
            <cfif #email_msg# is not "">
              
              <font size=3 color=ff0000>#email_msg#</font><br>
              <br>
            </cfif>
            <cfif Len(Variables.sBlockedMsg)>
              
              <font size=3 color=ff0000>#Variables.sBlockedMsg#</font><br>
              <br>
            </cfif>
            <cfif IsDefined("Variables.nickname_error")>
              <cfif Len(Variables.nickname_error)>
                
                <font size=3 color=ff0000>#Variables.nickname_error#</font><br>
                <br>
              </cfif>
            </cfif>
			<cfif #error_message# is not "">
              
              <font size=3 color=ff0000>#error_message#</font><br>
              <br>
            </cfif></td></tr></table></div>
			<div align="center">
            <table border=1 width=800 cellspacing=0 cellpadding=4 bordercolor="#heading_fcolor#">
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "nickname")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Choose a Username:</b></font></td>
                <td>
                  <table border=0 cellspacing=0 cellpadding=0 width=100%>
                    <tr>
                      <td><input type="text" name="nickname" size=14 maxlength=14 value="#nickname#"></td>
                      <td align="right">&nbsp;&nbsp;<font size=2>(5 chars minimum; you will use this<br>or your ID number to log in)</font></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td width=210 bgcolor="#heading_color#"><font <cfif #listFind (error_list, "password")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Choose a Password:</b></font></td>
                <td width=420><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input type="Password" name="password" size=30 maxlength=65 value="#password#"></td><td align="right">&nbsp;<font size=2>(5 chars minimum and contain <b>both</b> numbers and letters)</font>&nbsp;&nbsp;<font size=2>&nbsp;</font></td></tr></table></td>
              </tr>
              <tr>
                <td width=210 bgcolor="#heading_color#"><font <cfif #listFind (error_list, "password2")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Confirm Password:</b></font></td>
                <td width=420><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input type="Password" name="password2" size=30 maxlength=65 value="#password2#"></td><td align="right">&nbsp;<font size=2>(5 chars minimum and contain <b>both</b> numbers and letters)</font>&nbsp;&nbsp;<font size=2>&nbsp;</font></td></tr></table></td>
              </tr>
			  <tr>
                <td width=210 bgcolor="#heading_color#"><font <cfif #listFind (error_list, "keyword")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Choose a keyword:</b></font></td>
                <td width=420><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input type="text" name="keyword" size=14 maxlength=14 value="#keyword#"></td><td align="right"><font size=2>(Something to help you remember your password)</font></td></tr></table></td>
              </tr>
              <tr>
                <td width=210 bgcolor="#heading_color#"><font <cfif #listFind (error_list, "email")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* E-mail address:</b></font></td>
                <td width=420><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="email" size=30 maxlength=65 value="#email#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., person@somewhere.com)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "email_confirm")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Confirm E-mail address:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="email_confirm" size=30 maxlength=65 value="#email_confirm#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., person@somewhere.com)</font></td></tr></table></td>
              </tr>
			  <tr>
                <td bgcolor="#heading_color#" valign="top"><b>Email me when</b></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>
					<input type="Checkbox" name="bid_confirm_email" value="1" <cfif bid_confirm_email eq 1>checked</cfif>>&nbsp;<font size=2>My bid is successful</font><br>
					<input type="Checkbox" name="outbid_email" value="1" <cfif outbid_email eq 1>checked</cfif>>&nbsp;<font size=2>I am outbid</font><br>
					<input type="Checkbox" name="autobid_email" value="1" <cfif autobid_email eq 1>checked</cfif>>&nbsp;<font size=2>My bid is automatically raised via auto bid feature</font>
					</td></tr></table>
				</td>
              </tr>
			  
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "name")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Full name:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="name" size=30 maxlength=65 value="#name#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., John M Doe)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><b>Company:</b></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="company" size=30 maxlength=65 value="#company#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., Doe Mfg Co., Inc.)</font></td></tr></table></td>
              </tr>
			  <tr>
                <td bgcolor="#heading_color#"><font color="#heading_fcolor#"><b>What language do you prefer?</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><cfmodule template="..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="language" selected="#language#" size="1" multiple="NO"></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "phone1")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Primary phone ##:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="phone1" size=20 maxlength=20 value="#phone1#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., (714) 555-1212)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><b>Secondary phone ##:</b></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="phone2" size=20 maxlength=20 value="#phone2#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., (714) 555-1213)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><b>Fax ##:</b></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="fax" size=20 maxlength=20 value="#fax#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., (714) 555-1213)</font></td></tr></table></td>
              </tr>
              
                      <!--- 3/25/2013 JM <tr>
                        <td bgcolor="#heading_color#"><font <cfif #cc_number_error# is not "">color="ff0000"<cfelse>color="ffffff"</cfif>><b>Credit card number:</b></font></td>
                        <td>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td><input type="text" name="cc_number" size=16 maxlength=16 value="#cc_number#"></td>
                            </tr>
                          </table>
                        </td>
					  </tr>--->
					 <!--- <cfif #cc_number_error# is not "">
                      <tr>
                        <td>&nbsp;</td>
                        <td><font color="ff0000">#cc_number_error#</font></td>
                      </tr>
                      </cfif>
                      <tr>
                        <td bgcolor="#heading_color#"><font <cfif #cc_name_error# is not "">color="ff0000"<cfelse>color="ffffff"</cfif>><b>Name of cardholder:<font size="2"> </font></b></font></td>
                        <td>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td><input type="text" name="cc_name" size=16 maxlength=100 value="#cc_name#"></td>
                              <td align="right"><font size=2>(Exactly as printed on the card)</font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <cfif #cc_name_error# is not "">
                      <tr>
                        <td>&nbsp;</td>
                        <td><font color="ff0000">#cc_name_error#</font></td>
                      </tr>
                      </cfif>
                      <tr>
                        <td bgcolor="#heading_color#"><font <cfif #cc_expiration_error# is not "">color="ff0000"<cfelse>color="ffffff"</cfif>><b>Expiration date: </b></font></td>
                        <td>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td><input type="text" name="cc_expiration" size=7 maxlength=7 value="#cc_expiration#"></td>
                              <td align="right"><font size=2>(Exactly as printed on the card)</font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <cfif #cc_expiration_error# is not "">
                      <tr>
                        <td>&nbsp;</td>
                        <td><font color="ff0000">#cc_expiration_error#</font></td>
                      </tr>
                      </cfif>--->
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "address1")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Address:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="address1" size=30 maxlength=65 value="#address1#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., 1234 East Street)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Address (Line 2):</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="address2" size=30 maxlength=65 value="#address2#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., Suite 100-A)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "city")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* City:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="city" size=20 maxlength=65 value="#city#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., Chicago)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif listFind(error_list, "state") or listFind(error_list, "province")>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* State/Province:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>
				<CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                  SELECTNAME="state"
                  SELECTED="#state#"
                  MULTIPLE="0"
                  SIZE="1"
				  ANY="1">
				
				<!--- <input name="state" size=15 maxlength=50 value="#state#"> ---></td><td><b>Non US Province:</b> <input name="province" size=15 maxlength=50 value="#province#"></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "postal_code")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Zip Code:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="postal_code" size=6 maxlength=20 value="#postal_code#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., 85672)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="#heading_fcolor#"><b>Country:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="country" SELECTED="#country#" MULTIPLE="0" SIZE="1"></td></tr></table></td>
              </tr>
			  <tr>
                <td bgcolor="#heading_color#" valign="top"><font color="ffffff"><b>Shipping Information:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>
					<input type="Checkbox" name="same_address" value="1" <cfif same_address eq 1>checked</cfif>>&nbsp;<font size=2>Check here if your shipping address is the same as the address above.<br>(Check means you can ignore the shipping address fields below.)</font>	
					</td></tr></table>
				</td>
              </tr>
			  <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "shipping_address1")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Shipping Address:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="shipping_address1" size=30 maxlength=65 value="#shipping_address1#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., 1234 East Street)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Shipping Address (Line 2):</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="shipping_address2" size=30 maxlength=65 value="#shipping_address2#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., Suite 100-A)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "shipping_city")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Shipping City:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="shipping_city" size=20 maxlength=65 value="#shipping_city#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., Chicago)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif listFind(error_list, "shipping_state") or  listFind(error_list, "shipping_province")>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Shipping State/Province:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>
				<CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                  SELECTNAME="shipping_state"
                  SELECTED="#shipping_state#"
                  MULTIPLE="0"
                  SIZE="1"
				  ANY="1">
				
				<!--- <input name="shipping_state" size=15 maxlength=50 value="#shipping_state#"> ---></td><td><b>Non US Province:</b> <input name="shipping_province" size=15 maxlength=50 value="#shipping_province#"></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "shipping_postal_code")#>color="ff0000"<cfelse>color="#heading_fcolor#"</cfif>><b>* Shipping Zip Code:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><input name="shipping_postal_code" size=6 maxlength=20 value="#shipping_postal_code#"></td><td align="right">&nbsp;&nbsp;<font size=2>(e.g., 85672)</font></td></tr></table></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="#heading_fcolor#"><b>Shipping Country:</b></font></td>
                <td><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td><CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="shipping_country" SELECTED="#shipping_country#" MULTIPLE="0" SIZE="1"></td></tr></table></td>
              </tr>
              
            </table>
            <table border=1 width=800 cellspacing=0 cellpadding=4 bordercolor="ffffff">
              <tr>
                <td width=210 bgcolor="#heading_color#">
                  <font color="ffffff">
                    <b>Optional Info</b>
                  </font>
                </td>
                <td width=420>&nbsp;</td>
              </tr>
			  <!--- 3/25/2013 JM <cfif get_membership_status.pair eq 1>
			  <tr>
                <td bgcolor="#heading_color#" valign="bottom"><font color="ffffff"><b>Membership </b></font><br><a href="../help/about_membership.cfm" target="_blank"><font size="-2">about membership</font></a></td>
                <td>
				  <b>Payment Method:</b> <input type="Radio" name="membership_payment_type" value="1" <cfif link_point neq "no" or authorize_net_aim neq "no">checked<cfelse>disabled</cfif>> Credit Card <input type="Radio" name="membership_payment_type" value="2" <cfif link_point eq "no">checked</cfif>> <!---Send a Check---><cfif isdefined("paypal") and paypal eq "yes">/PayPal</cfif><br>
                  <select name="membership">
                  <option value="">-- Select an option --</option>
                  <cfloop query="get_memberships">
				  <cfset membership_fee = listgetat(pair,1,"_")>
				  <cfset membership_rate = listgetat(pair,2,"_")>
				  <cfset membership_name = listgetat(pair,3,"_")>
				  <cfset membership_cycle = listgetat(pair,4,"_")>
				  <option value="#pair#"<cfif #membership# is pair> selected</cfif>>#membership_name# #membership_rate#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership</option>
				  </cfloop>
                  </select>
                </td>
			  </tr>
			  <cfelse>
			  	<input type="Hidden" name="membership" value="">
			  </cfif>--->
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>How did you hear about us?</b></font></td>
                <td>
                  <select name="heard_from">
                  <option value="">-- Select an option --</option>
                  <option value="Business Associate"<cfif #heard_from# is "Business Associate"> selected</cfif>>Business Associate</option>
                  <option value="Friend or Family"<cfif #heard_from# is "Friend or Family"> selected</cfif>>Friend or Family</option>
                  <option value="Internet Web Site"<cfif #heard_from# is "Internet Web Site"> selected</cfif>>Internet Web Site</option>
                  <option value="News Story"<cfif #heard_from# is "News Story"> selected</cfif>>News Story</option>
                  <option value="Magazine or Newspaper Ad"<cfif #heard_from# is "Magazine or Newspaper Ad"> selected</cfif>>Magazine or Newspaper Ad</option>
                  <option value="Radio Ad"<cfif #heard_from# is "Radio Ad"> selected</cfif>>Radio Ad</option>
                  <option value="Trade Show or Event"<cfif #heard_from# is "Trade Show or Event"> selected</cfif>>Trade Show or Event</option>
                  <option value="Other"<cfif #heard_from# is "Other"> selected</cfif>>Other</option>
                  </select>
                </td>
              </tr>
              <!--- 3/25/2013 JM <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Promotion code:</b></font></td>
                <td><input name="promotion_code" type="text" size=10 maxlength=10 value="#promotion_code#"></td>
              </tr>--->
              <tr>
                <td bgcolor="#heading_color#"><font <cfif #listFind (error_list, "friendsemail")#> color="ff0000"<cfelse>color="ffffff"</cfif>><b>If a friend referred you<br>to us, enter their email address:</b></font></td>
                <td><input name="friends_email" type="text" size=30 maxlength=65 value="#friends_email#"></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>What do you use our site for?</b></font></td>
                <td>
                  <select name="use_for">
                  <option value=""<cfif #use_for# is ""> selected</cfif>>-- Select an option --</option>
                  <option value="P"<cfif #use_for# is "P"> selected</cfif>>Personal</option>
                  <option value="B"<cfif #use_for# is "B"> selected</cfif>>Business</option>
                  <option value="A"<cfif #use_for# is "A"> selected</cfif>>Personal &amp; Business</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>I am most interested in:</b></font></td>
                <td><input name="interested" type="text" size=30 maxlength=50 value="#interested#"></td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Age:</b></font></td>
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
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Education completed:</b></font></td>
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
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Annual household income:</b></font></td>
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
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Do you wish to participate in our online survey?</b></font></td>
                <td>
                  <select name="survey">
                  <option value="1"<cfif #survey# is "1"> selected</cfif>>Yes I would</option>
                  <option value="0"<cfif #survey# is "0"> selected</cfif>>No thank you</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Would you like to be on our mailing list?</b></font></td>
                <td>
                  <select name="mailing">
                  <option value="1"<cfif #mailing# is "1"> selected</cfif>>Yes I would</option>
                  <option value="0"<cfif #mailing# is "0"> selected</cfif>>No thank you</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td bgcolor="#heading_color#"><font color="ffffff"><b>Gender:</b></font></td>
                <td>
                  <select name="gender">
                  <option value="M"<cfif #gender# is "M"> selected</cfif>>Male</option>
                  <option value="F"<cfif #gender# is "F"> selected</cfif>>Female</option>
                  <option value="N"<cfif #gender# is "N"> selected</cfif>>Not Disclosed</option>
                  </select>
                </td>
              </tr>
            </table>
            <br>
            <input type="submit" name="submit" value="Next" width=75>&nbsp;&nbsp;&nbsp;<input type="reset" value="Clear" width=75>
          </td>
        </tr></form>
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
      </table>
</div>
    
  
    
 
    
  


</body>
</html>

</cfoutput>

