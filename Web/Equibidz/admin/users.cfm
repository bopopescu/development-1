<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/USERS.CFM $ $Revision: 5 $ $Date: 1/29/00 6:11p $ $Author: Davidh1 $ --->


<html>
 <head>
  <title>Visual Auction Server Administrator [Users Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
 
 <!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

 <cfsetting EnableCFOutputOnly="YES">

 <!--- Include this module to obtain a unique ID for the user --->
 <CFMODULE TEMPLATE="../functions/epoch.cfm">

 <!--- See if they clicked the "Clear Form" button --->
 <cfset #clear# = "0">
 <cfif #isDefined ("submit")# is 1>
  <cfif (#trim (submit)# is "Clear Form") or (#trim (submit)# is "Delete User")>
   <cfset #clear# = "1">
  </cfif>
 </cfif>

 <!--- activate membership --->
 <cfif isdefined("activate_membership")>
 	<cfset membership_cycle = listgetat(membership,4,"_")>
	<cfif membership_cycle eq "Monthly">
		<cfset membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#>
	<cfelseif membership_cycle eq "LifeTime">
		<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#>
	<cfelse>
		<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#>
	</cfif>
 	<cfquery name="upd_expire_membership" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
		UPDATE users
		SET membership_status = 1,
			membership_exp = #membership_exp#
		WHERE user_id = #user_id#
	</cfquery>
	
	<!--- log activate membership  ---> 
    <cfmodule template="../functions/addTransaction.cfm"
      	datasource="#DATASOURCE#"
      	description="Activate Membership (#nickname#)"
      	details="MEMBERSHIP OPTION: #membership#   MEMBERSHIP EXP.: #membership_exp#"
      	user_id="#user_id#">
		
		<cfoutput><cflocation url="users.cfm?submit=retrieve&selected_user=#user_id#"></cfoutput>
 </cfif>






 <cfif isdefined("deactivate_membership")>
 	<cfset membership_cycle = listgetat(membership,4,"_")>
	<cfif membership_cycle eq "Monthly">
		<cfset membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#>
	<cfelseif membership_cycle eq "LifeTime">
		<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#>
	<cfelse>
		<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#>
	</cfif>
 	<cfquery name="deactivacte" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
		UPDATE users
		SET membership_status = 0

		WHERE user_id = #user_id#
	</cfquery>
	
	<!--- log deactivate membership  ---> 
    <cfmodule template="../functions/addTransaction.cfm"
      	datasource="#DATASOURCE#"
      	description="Deactivate Membership (#nickname#)"
      	details="MEMBERSHIP OPTION: #membership#   MEMBERSHIP EXP.: #membership_exp#"
      	user_id="#user_id#">
		
		<cfoutput><cflocation url="users.cfm?submit=retrieve&selected_user=#user_id#"></cfoutput>
 </cfif>
 

 
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
 
 <!--- Set default for "submit" if not defined --->
 <cfif (#isDefined ("submit")# is 0) or (#clear# is "1")>
  <cfset #submit# = "enter">

  <!--- Set global defaults --->
  <cfset #user_id# = #EPOCH#>
  <cfset #email# = "">
  <cfset #password# = "">
  <cfset #keyword# = "">
   <cfparam name="balance" default="0.00">
   <cfparam name="credit" default="0.00">
  <cfset #name# = "">
<!---   <cfoutput> ---><cfset #nickname# = "#user_id#"><!--- </cfoutput> --->
  <cfset #company# = "">
  <cfset #address1# = "">
  <cfset #address2# = "">
  <cfset #city# = "">
  <cfset #state# = "">
  <cfset #postal_code# = "">
  <cfset #country# = "USA">
  <cfset #phone1# = "">
  <cfset #phone2# = "">
  <cfset #fax# = "">
  <cfset #language# = "en">
  <cfset #heard_from# = "">
  <cfset #promotion_code# = "">
  <cfset #friends_email# = "">
  <cfset #use_for# = "P">
  <cfset #interested# = "">
  <cfset #age# = "25-34">
  <cfset #education# = "College">
  <cfset #income# = "$25,000 - $35,000">
  <cfset #survey# = "1">
  <cfset #gender# = "N">
  <cfset #mailing# = "1">
  <cfset #is_active# = "1">
  <cfset #full_control# = "0">
 <!---  <cfset #store_control# = "0"> --->
  <cfset #date_registered# = #timenow#>
  <cfset #last_login_date# = "">
  <cfset #cc_name# = "">
  <cfset #cc_number# = "">
  <cfset #cc_expiration# = "">
  <cfset #shipping_address1# = "">
  <cfset #shipping_address2# = "">
  <cfset #shipping_city# = "">
  <cfset #shipping_state# = "">
  <cfset #shipping_postal_code# = "">
  <cfset #shipping_country# = "USA">
  <cfset #same_address# = 1>
  <cfset #bid_confirm_email# = 1>
  <cfset #outbid_email# = 1>
  <cfset #autobid_email# = 1>
  <cfset #membership# = "">
  <cfset #membership_exp# = "">
  <cfset #membership_status# = 0>
  <cfset #confirmation# = "1">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>

 <!--- Set default for "error_message" --->
 <cfset #error_message# = "">

 <!--- Make sure bit variables (checkboxes) exist as "1" or "0" --->
 <cfif #isDefined ("survey")#>
  <cfset #survey# = "1">
 <cfelse>
  <cfset #survey# = "0">
 </cfif>
 <cfif #isDefined ("is_active")#>
  <cfset #is_active# = "1">
 <cfelse>
  <cfset #is_active# = "0">
 </cfif>

 <cfif #isDefined ("full_control")#>
  <cfset #full_control# = "1">
 <cfelse>
  <cfset #full_control# = "0">
 </cfif>
<!--- 
 <cfif #isDefined ("store_control")#>
  <cfset #store_control# = "1">
 <cfelse>
  <cfset #store_control# = "0">
 </cfif> --->
 <cfif #isDefined ("confirmation")#>
  <cfset #confirmation# = "1">
 <cfelse>
  <cfset #confirmation# = "0">
 </cfif>
 <cfif #isDefined ("mailing")#>
  <cfset #mailing# = "1">
 <cfelse>
  <cfset #mailing# = "0">
 </cfif>
 <cfparam name="same_address" default="0">
 <cfparam name="bid_confirm_email" default="0">
 <cfparam name="outbid_email" default="0">
 <cfparam name="autobid_email" default="0">

 <!--- Check for invalid/missing form data --->
 <cfset #bad_data# = "0">
 <cfif (#submit# is "Add User") or (#submit# is "Update User")>
  <cfset #error_message# = "">

  <!--- First, check for missing data --->
  <cfif #name# is "">
   <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a user name.</font>">
  </cfif>
  <cfif #error_message# is "">
   <cfif #nickname# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a nickname or alias for this user.</font>">
   </cfif>
  </cfif>
<!---  <cfif #error_message# is "">
   <cfif #company# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a company.</font>">
   </cfif>
  </cfif> --->
  <cfif #error_message# is "">
   <cfif #address1# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a street address.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #city# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a city of residence.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #state# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a state of residence.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #postal_code# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a zip or postal code.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif #country# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a country of residence.</font>">
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
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a primary phone number.</font>">
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
   <cfif #keyword# is "">
    <cfset #error_message# = "<font color='ff0000'>Missing Data - You must specify a keyword.</font>">
   </cfif>
  </cfif>
  <cfif #error_message# is "">
   <cfif balance is "">
    <cfset balance = 0.00>
   </cfif>
  </cfif>
   <cfif #error_message# is "">
   <cfif credit is "">
    <cfset credit = 0.00>
   </cfif>
  </cfif>

  <!--- Next, make sure E-Mail address is valid --->
  <cfif #error_message# is "">
   <CFMODULE TEMPLATE="../functions/Mailtest.cfm" EMail=#email#>
   <cfif #EMail_Level# GT 0>
    <cfoutput><cfset #error_message# = "<font color='ff0000'>Bad E-Mail Address - #EMail_Message#.</font>"></cfoutput>
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
      AND check_nickname.user_id IS NOT user_id>
      
      <cfset #error_message# = "<font color='ff0000'>Sorry, the nickname ""#nickname#"" is already in use by another user.  Please choose another.</font>">
    </cfif>
  </cfif>
  
  <cfif #error_message# is not "">
   <cfset #bad_data# = "1">
  </cfif>

 </cfif>

  <!--- Check if they wanted to inactivate a user --->
  <cfif (#submit# is "Disable")>
    
    <cfquery username="#db_username#" password="#db_password#" name="disable_user" datasource="#DATASOURCE#">
        UPDATE users
           SET is_active = 0
         WHERE user_id = #selected_user#
    </cfquery>
    
    <!--- log account set inactive --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Account Deactivated by Administrator"
      details="USER ID: #selected_user#">


<cfquery name="reset_admin" datasource="#datasource#">
update ocadministrator set status = 0 where store_user_id = #selected_user#

</cfquery>


<cfquery name="reset_admin1" datasource="#datasource#">
update ocproductlist set status = 0 where store_user_id = #selected_user#

</cfquery>

<cfquery name="reset_admin2" datasource="#datasource#">
update ocadmindisplay set store_enable = 0 where store_user_id = #user_id#

</cfquery>
    
    <cfset #error_message# = "<font color='0000ff'>Operation successful - User set to inactive.</font>">
    <cfset #submit# = "Retrieve">
  </cfif>

  <!--- Check if they wanted to add a new user ---> 
  <cfif (#submit# is "Add User") and (#bad_data# is "0")> 
    
    <cfset #user_id# = #EPOCH#>
    <cfset fCredit = 0.00>
    <cfset fBalance = 0.00>
    
    <!--- if no errors --->
    <cfif not Len(error_message)>
    
     <!---  CC_info fields populated with default of 0 --->
	  <cfif cc_number is "">
<cfset cc_number = 0>
</cfif>

<cfif cc_name is "">
<cfset cc_name = 0>
</cfif>

<cfif cc_expiration is "">
<cfset cc_expiration = 0>
</cfif>

<cfif company is "">
<cfset company = "none">
</cfif>

<cfif fax is "">
<cfset fax = "none">
</cfif>
      
	<!--- cc encryption --->
	<cfif form.cc_number contains "*" is 0 and form.cc_number neq "" and form.cc_number neq 0>
	<cfset cc_number = cfusion_Encrypt(cc_number, "umbala")>
	</cfif>
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
                  credit,
                  statement_date,
                  is_active,
                  last_login_date,
                  cc_name,
                  cc_number,
                  cc_expiration,
				  confirmation,
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
,full_control<!--- ,store_control --->                  )

     VALUES     (#user_id#,
                 '#email#',
                 '#password#',
                 '#keyword#',
                 #timenow#,
                 '#name#',
                 '#nickname#',
                 '#company#',
                 '#address1#',
                 '#address2#',
                 '#city#',
                 '#state#',
                 '#postal_code#',
                 '#country#',
                 '#phone1#',
                 '#phone2#',
                 '#fax#',
                 '#language#',
                 '#heard_from#',
                 '#promotion_code#',
                 '#friends_email#',
                 '#use_for#',
                 '#interested#',
                 '#age#',
                 '#education#',
                 '#income#',
                 #survey#,
                 '#gender#',
                 #mailing#,
                 #Variables.fBalance#,
                 #Variables.fCredit#,
                 #timenow#,
                 #is_active#,
                 #CreateODBCDateTime(timenow)#,
                 '#cc_name#',
                 '#cc_number#',
                 '#cc_expiration#',
				 #confirmation#,
				 #same_address#,
			     '#shipping_address1#',
			     '#shipping_address2#',
			     '#shipping_city#',
			     '#shipping_state#',
			     '#shipping_postal_code#',
			     '#shipping_country#',
			     #bid_confirm_email#,
			     #outbid_email#,
			     #autobid_email#,#full_control#<!--- ,#store_control# --->
				 )
      </cfquery>








<!---

<CFIF STORE_CONTROL eq 1>


<cfquery name="check_store" datasource="#datasource#">
select store_user_id from 
ocAdminDisplay where store_user_id = #user_id#

</cfquery>



<cfif check_store.recordcount>

<cfelse>

<cfquery name="get_default_store" datasource="#datasource#">
select * from ocadmindisplay where displayid = 1

</cfquery>



<cfquery name="set_admin" datasource="#datasource#">
insert into ocadministrator (adminname,password,adminfullname,store_user_id,status) values ('#nickname#','#password#','#name#',#user_id#,1)

</cfquery>


<cfloop query="get_default_store">
<cfquery name="insert_store" datasource="#datasource#">
insert into ocadmindisplay (ADMINEMAIL , 	ALTEMAIL1 ,	ALTEMAIL2 , 	ALTEMAIL3 ,	SUBFOLDER1 ,	ADMINFOLDER ,	WHITETABLE ,	BLACKTABLE , 	SILVERTABLE1 , 	SILVERTABLE2 , 
	MAINTABLE1 ,
	MAINTABLE2 ,	COMPANYNAME , 	ADDRESS1 , 	ADDRESS2 , 	CITYSTATEZIP ,	TELEPHONE1 ,	TELEPHONE2 ,BODYTEXT ,	BGCOLOR ,	LINK , 	VLINK ,	ALINK ,	ROWDISPLAY , 	MEASURETYPE ,	ATTACHMENTPATH , 	SERVERPATH ,	SERVERPATHDELETE ,	IMAGEPATH , 	SSLINPLACE , 	DBPRE , 	MISCPRICE ,	CVV2INPLACE ,	AUTHDISCPW , 	AUTHDISCINPLACE , 	AUTHDISCRATE,store_user_id,logo,shopping_logo,style_sheet )

values ('#Trim(email)#',
'#Trim(email)#',
'#Trim(email)#',
 '#Trim(email)#',
 '#Trim(SUBFOLDER1)#',
 '#Trim(ADMINFOLDER)#',
 '#Trim(WHITETABLE)#',
'#Trim(BLACKTABLE)#',
'#Trim(SILVERTABLE1)#',
'#Trim(SILVERTABLE2)#',
 '#Trim(MAINTABLE1)#',
 '#Trim(MAINTABLE2)#',
'#Trim(company)#',
'#Trim(ADDRESS1)#',
'#Trim(ADDRESS2)#',
 '#Trim(city)##Trim(state)##Trim(postal_code)#',
 '#Trim(PHONE1)#',
 '#Trim(PHONE2)#',

 '#Trim(BODYTEXT)#',
 '#Trim(BGCOLOR)#',
'#Trim(LINK)#',
 '#Trim(VLINK)#',
 '#Trim(ALINK)#',
#Val(ROWDISPLAY)#,
 '#Trim(MEASURETYPE)#',
'#Trim(ATTACHMENTPATH)#',
 '#Trim(SERVERPATH)#',
 '#Trim(SERVERPATHDELETE)#',
'#Trim(IMAGEPATH)#',
#Val(SSLINPLACE)#,
'#Trim(DBPRE)#',
 #MISCPRICE#,
 #Val(CVV2INPLACE)#,
'#Trim(AUTHDISCPW)#',
#Val(AUTHDISCINPLACE)#,
'#Trim(AUTHDISCRATE)#',#user_id#

,'#trim(logo)#','#trim(shopping_logo)#','#trim(style_sheet)#')

</cfquery>

</cfloop>
</cfif>


<cfmail to="#email#"
  from="customer_service@#domain#"
  subject="Your store has been setup" type="HTML">

Congratulation!
Your store has been setup.<br>


You now can log into your store admin at  <a href="http://#site_address#/store/admin">http://#site_address#/store/admin</a> using your nickname as the admin name, and your current password as the admin password.

<br>
#domain# Team.


</cfmail>



<cfelse>


<cfquery name="reset_admin" datasource="#datasource#">
update ocadministrator set status = 0 where store_user_id = #user_id#

</cfquery>


<cfquery name="reset_admin1" datasource="#datasource#">
update ocproductlist set status = 0 where store_user_id = #user_id#

</cfquery>

<cfquery name="reset_admin2" datasource="#datasource#">
update ocadmindisplay set store_enable = 0 where store_user_id = #user_id#

</cfquery>


</cfif>
--->


	  <!--- cc decryption --->
      <cfif form.cc_number contains "*" is 0 and form.cc_number neq "" and form.cc_number neq 0>
  		<cfset cc_number = cfusion_Decrypt(cc_number, "umbala")>
  		<cfset #cc_number# = "************" & #right(cc_number, 4)#>
  	  <cfelse>
  		<cfset #cc_number# = #cc_number#>
  	  </cfif>
	  
	  <!--- membership --->
   <cfif get_membership_status.pair eq 1 and membership neq "" and (membership_exp eq "" or membership_exp lt timenow)>
   		<cfset membership_fee = #listgetat(membership,1,"_")#>
		<cfset membership_cycle = listgetat(membership,4,"_")>
		<cfif membership_cycle eq "Monthly">
			<cfset membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#>
		<cfelseif membership_cycle eq "LifeTime">
			<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#>
		<cfelse>
			<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#>
		</cfif>
		<cfset membership_status = 1>
		
		<!--- <cfif membership_payment_type eq 1>
	     <!-- RUN AUTOMATED MODULES (CYBERCASH, ETC.), UPDATE PAID VALUE,STATUS -->
	    <cfmodule template="../registration/membership_automated_billing.cfm"
		user_id="#user_id#"
    	itemnum="0"
		title="New Membership (#nickname#)"
		invoice_total="#membership_fee#">
		</cfif> --->
		
   		<!--- update membership --->
  		<cfquery name="insert_member_bal" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			UPDATE users
			SET membership = '#membership#'
			   <!--- <cfif isdefined("billing_status") and billing_status IS "ok" AND paid GT 0> --->
			   ,membership_exp = #membership_exp#,
			   membership_status = 1
			   <!--- </cfif> --->
			WHERE user_id = #user_id#
		</cfquery>
   		
		<!--- send email --->
		<!--- <cfmodule template="../registration/eml_membership.cfm"
			invSubTotal="#membership_fee#"
			user_id="#user_id#"
			paid="#paid#"> --->
		
    	<!--- log creation of new membership  ---> 
    	<cfmodule template="../functions/addTransaction.cfm"
      		datasource="#DATASOURCE#"
      		description="New Membership (#nickname#)"
      		details="MEMBERSHIP FEE: #membership_fee#    MEMBERSHIP OPTION: #membership#"
      		user_id="#user_id#">
   </cfif>
      
      <!--- log account creation --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Created & Finalized by Administrator"
        details="USER ID: #user_id#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record added.</font>">
    </cfif>
  </cfif>

  <!--- Check if they wanted to update a user ---> 
  <cfif (#submit# is "Update User") and (#bad_data# is "0")> 
    
    <!--- if last login date prev 1969 & user now active,
      define last login date to Now() --->
    
	<cfif last_login_date neq "">
    <cfif IsDefined("Form.is_active")
      AND DateCompare(#dateformat(Form.last_login_date)#, '12/31/1969') IS 0>
      
      <cfset last_login_date = #CreateODBCDateTime(timenow)#>
    <cfelse>
      <cfset last_login_date = CreateODBCDateTime(Form.last_login_date)>
    </cfif>
	<cfelse>
		<cfset last_login_date = #CreateODBCDateTime(timenow)#>
	</cfif>
    
    <!--- if no errors --->
    <cfif not Len(error_message)>
      <!---  CC_info fields populated with default of 0 --->
	  <cfif cc_number is "">
<cfset cc_number = 0>
</cfif>

<cfif cc_name is "">
<cfset cc_name = 0>
</cfif>

<cfif cc_expiration is "">
<cfset cc_expiration = 0>
</cfif>


<cfif company is "">
<cfset company = "none">
</cfif>

<cfif fax is "">
<cfset fax = "none">
</cfif>
      
	  	<!--- cc encryption --->
		<cfif form.cc_number contains "*" is 0 and form.cc_number neq "" and form.cc_number neq 0>
		<cfset cc_number = cfusion_Encrypt(cc_number, "umbala")>


		</cfif>

   <cfif get_membership_status.pair eq 1 and membership neq "" and (membership_exp eq "" or membership_exp lt timenow)>

<cfset membership_fee = #listgetat(membership,1,"_")#>
		<cfset membership_cycle = listgetat(membership,4,"_")>

<cfset membership_pct = listgetat(membership,2,"_")>


<cfset membership_name = listgetat(membership,3,"_")>
		<cfif membership_cycle eq "Monthly">
			<cfset membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#>
		<cfelseif membership_cycle eq "LifeTime">
			<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#>
		<cfelse>
			<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#>
		</cfif>

  		<cfquery name="temp2" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			UPDATE users
			SET membership = '#membership#'
	
			   ,membership_exp = #membership_exp#,
			   membership_status = 1
			  
			WHERE user_id = #user_id#
		</cfquery>

<cfset amount= #membership_fee# + #balance#>

<cfif #amount# gte #credit# >

<cfset balance1 = #amount# - #credit#>

<cfelse>
<cfset balance1 = #credit# - #amount#>
</cfif>


<cfmail to="#email#"
  from="customer_service@#domain#"
  subject="Your membership has been changed" type="HTML">


Your membership has been changed to  #membership_name#. It entitles you to a #membership_pct#% discount on all auction fees

A fee of #balance1# (including credit) has been applied to your account.


</cfmail>


<cfquery name="temp3" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			UPDATE users
			SET  balance = #balance1#	  
			WHERE user_id = #user_id#
		</cfquery>



<cfmodule template="../functions/addTransaction.cfm"
      		datasource="#DATASOURCE#"
      		description=" Membership updated for (#nickname#)"
      		details="MEMBERSHIP FEE: #membership_fee#    MEMBERSHIP OPTION: #membership#"
      		user_id="#user_id#">

</cfif>
	  
      <cfquery username="#db_username#" password="#db_password#" name="update_user" datasource="#DATASOURCE#">
          UPDATE users
             SET email = '#email#',
                 password = '#password#',
                 keyword = '#keyword#',
                 name = '#name#',
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
                 heard_from = '#heard_from#',
                 promotion_code = '#promotion_code#',
                 friends_email = '#friends_email#',
                 use_for = '#use_for#',
                 interested = '#interested#',
                 age = '#age#',
                 education = '#education#',
                 income = '#income#',
                 survey = #survey#,
                 gender = '#gender#',
                 mailing = #mailing#,
                 is_active = #is_active#,
                 last_login_date = #last_login_date#,
                 cc_name = '#cc_name#',
                 <cfif form.cc_number contains "*" is 0>cc_number = '#cc_number#',</cfif>
                 cc_expiration = '#cc_expiration#',
				 <!--- balance = #balance#,
				 credit = #credit#, --->
				 same_address = #same_address#,
			     shipping_address1 = '#shipping_address1#',
			     shipping_address2 = '#shipping_address2#',
			     shipping_city = '#shipping_city#',
			     shipping_state = '#shipping_state#',
			     shipping_postal_code = '#shipping_postal_code#',
			     shipping_country = '#shipping_country#',
			     bid_confirm_email = '#bid_confirm_email#',
			     outbid_email = '#outbid_email#',
			     autobid_email = '#autobid_email#',
				 confirmation = #confirmation#
,full_control =#full_control#<!--- 
,store_control = #store_control# --->
           WHERE user_id = #user_id#
      </cfquery>
<cfquery name="get_user_again" datasource="#datasource#">
select * from users where user_id =#user_id#
</cfquery>
<!---
<CFIF STORE_CONTROL eq 1>


<cfquery name="check_store" datasource="#datasource#">
select store_user_id from 
ocAdminDisplay where store_user_id = #user_id#

</cfquery>



<cfif check_store.recordcount>

<cfelse>

<cfquery name="get_default_store" datasource="#datasource#">
select * from ocadmindisplay where displayid = 1

</cfquery>



<cfquery name="set_admin" datasource="#datasource#">
insert into ocadministrator (adminname,password,adminfullname,store_user_id,status) values ('#get_user_again.nickname#','#get_user_again.password#','#get_user_again.name#',#get_user_again.user_id#,1)

</cfquery>


<cfloop query="get_default_store">
<cfquery name="insert_store" datasource="#datasource#">
insert into ocadmindisplay (ADMINEMAIL , 	ALTEMAIL1 ,	ALTEMAIL2 , 	ALTEMAIL3 ,	SUBFOLDER1 ,	ADMINFOLDER ,	WHITETABLE ,	BLACKTABLE , 	SILVERTABLE1 , 	SILVERTABLE2 , 
	MAINTABLE1 ,
	MAINTABLE2 ,	COMPANYNAME , 	ADDRESS1 , 	ADDRESS2 , 	CITYSTATEZIP ,	TELEPHONE1 ,	TELEPHONE2 ,	COMPANYURL , 	BODYTEXT ,	BGCOLOR ,	LINK , 	VLINK ,	ALINK ,	ROWDISPLAY , 	MEASURETYPE ,	ATTACHMENTPATH , 	SERVERPATH ,	SERVERPATHDELETE ,	IMAGEPATH , 	SSLINPLACE , 	DBPRE , 	MISCPRICE ,	CVV2INPLACE ,	AUTHDISCPW , 	AUTHDISCINPLACE , 	AUTHDISCRATE,store_user_id,logo,shopping_logo )

values ('#Trim(get_user_again.email)#',
'#Trim(get_user_again.email)#',
'#Trim(get_user_again.email)#',
 '#Trim(get_user_again.email)#',
 '#Trim(SUBFOLDER1)#',
 '#Trim(ADMINFOLDER)#',
 '#Trim(WHITETABLE)#',
'#Trim(BLACKTABLE)#',
'#Trim(SILVERTABLE1)#',
'#Trim(SILVERTABLE2)#',
 '#Trim(MAINTABLE1)#',
 '#Trim(MAINTABLE2)#',
'#Trim(get_user_again.company)#',
'#Trim(get_user_again.ADDRESS1)#',
'#Trim(get_user_again.ADDRESS2)#',
 '#Trim(get_user_again.city)##Trim(get_user_again.state)##Trim(get_user_again.postal_code)#',
 '#Trim(get_user_again.PHONE1)#',
 '#Trim(get_user_again.PHONE2)#',
'#Trim(get_user_again.URL_page)#',
 '#Trim(BODYTEXT)#',
 '#Trim(BGCOLOR)#',
'#Trim(LINK)#',
 '#Trim(VLINK)#',
 '#Trim(ALINK)#',
#Val(ROWDISPLAY)#,
 '#Trim(MEASURETYPE)#',
'#Trim(ATTACHMENTPATH)#',
 '#Trim(SERVERPATH)#',
 '#Trim(SERVERPATHDELETE)#',
'#Trim(IMAGEPATH)#',
#Val(SSLINPLACE)#,
'#Trim(DBPRE)#',
 #MISCPRICE#,
 #Val(CVV2INPLACE)#,
'#Trim(AUTHDISCPW)#',
#Val(AUTHDISCINPLACE)#,
'#Trim(AUTHDISCRATE)#',#user_id#

,'#trim(logo)#','#trim(shopping_logo)#')

</cfquery>

</cfloop>
</cfif>


<cfmail to="#get_user_again.email#"
  from="customer_service@#domain#"
  subject="Your store has been setup" type="HTML">

Congratulation!
Your store has been setup.<br>


You now can log into your store admin at  <a href="http://#site_address#/store/admin">http://#site_address#/store/admin</a> using your nickname as the admin name, and your current password as the admin password.

<br>
#domain# Team.


</cfmail>



<cfelse>


<cfquery name="reset_admin" datasource="#datasource#">
update ocadministrator set status = 0 where store_user_id = #user_id#

</cfquery>


<cfquery name="reset_admin1" datasource="#datasource#">
update ocproductlist set status = 0 where store_user_id = #user_id#

</cfquery>

<cfquery name="reset_admin2" datasource="#datasource#">
update ocadmindisplay set store_enable = 0 where store_user_id = #user_id#

</cfquery>


</cfif>--->
	  <!--- cc decryption --->
      <cfif form.cc_number contains "*" is 0 and form.cc_number neq "" and form.cc_number neq 0>
  		<cfset cc_number = cfusion_Decrypt(cc_number, "umbala")>
  		<cfset #cc_number# = "************" & #right(cc_number, 4)#>
  	  <cfelse>
  		<cfset #cc_number# = #cc_number#>
  	  </cfif>
      
	  <!--- membership --->
   <cfif get_membership_status.pair eq 1 and membership neq "" and (membership_exp eq "" or membership_exp lt timenow)>
   		<cfset membership_fee = #listgetat(membership,1,"_")#>
		<cfset membership_cycle = listgetat(membership,4,"_")>
		<cfif membership_cycle eq "Monthly">
			<cfset membership_exp = #createODBCDateTime(dateadd("m",1,timenow))#>
		<cfelseif membership_cycle eq "LifeTime">
			<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",100,timenow))#>
		<cfelse>
			<cfset membership_exp = #createODBCDateTime(dateadd("yyyy",1,timenow))#>
		</cfif>
		<cfset membership_status = 1>
		
		<!--- <cfif membership_payment_type eq 1>
	     <!-- RUN AUTOMATED MODULES (CYBERCASH, ETC.), UPDATE PAID VALUE,STATUS -->
	    <cfmodule template="../registration/membership_automated_billing.cfm"
		user_id="#user_id#"
    	itemnum="0"
		title="New Membership (#nickname#)"
		invoice_total="#membership_fee#">
		</cfif> --->
		
   		<!--- update membership --->
  		<cfquery name="insert_member_bal" password="#db_password#" datasource="#DATASOURCE#" dbtype="ODBC">
			UPDATE users
			SET membership = '#membership#'
			   <!--- <cfif isdefined("billing_status") and billing_status IS "ok" AND paid GT 0> --->
			   ,membership_exp = #membership_exp#,
			   membership_status = 1
			   <!--- </cfif> --->
			WHERE user_id = #user_id#
		</cfquery>
   		
		<!--- send email --->
		<!--- <cfmodule template="../registration/eml_membership.cfm"
			invSubTotal="#membership_fee#"
			user_id="#user_id#"
			paid="#paid#"> --->
		
    	<!--- log creation of new membership  ---> 
    	<cfmodule template="../functions/addTransaction.cfm"
      		datasource="#DATASOURCE#"
      		description="New Membership (#nickname#)"
      		details="MEMBERSHIP FEE: #membership_fee#    MEMBERSHIP OPTION: #membership#"
      		user_id="#user_id#">
   </cfif>
	  
      <!--- log account updated --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Information Updated by Administrator"
        details="USER ID: #user_id#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record updated.</font>">
    </cfif>
  </cfif>

 <!--- Check to see if they wanted to retrieve a user's record --->
 <cfif #submit# is "Retrieve">
  <cfquery username="#db_username#" password="#db_password#" name="get_user" datasource="#DATASOURCE#">
   SELECT user_id,
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
		  credit,
          statement_date,
		  is_active,
          last_login_date,
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
		  membership_status,
		  confirmation,full_control<!--- ,store_control --->
          
     FROM users
    WHERE user_id = #selected_user#
  </cfquery>

  <!--- Set global defaults --->
  <cfset #email# = #get_user.email#>
  <cfset #password# = #get_user.password#>
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
  <cfset #full_control# = #get_user.full_control#>
  <!--- <cfset #store_control# = #get_user.store_control#> --->
  <cfset #user_id# = #get_user.user_id#>
  <cfset #date_registered# = #get_user.date_registered#>
  <cfset #error_message# = "<font color='0000ff'>Operation successful - User record retrieved.</font>">
  <cfset #last_login_date# = #get_user.last_login_date#>
  <cfset #cc_name# = #get_user.cc_name#>
  <cfif get_user.cc_number neq 0 and isnumeric(get_user.cc_number) neq 1>
  <cfset cc_number = cfusion_Decrypt(get_user.cc_number, "umbala")>
  <cfset #cc_number# = "************" & #right(cc_number, 4)#>
  <cfelse>
  <cfset #cc_number# = #get_user.cc_number#>
  </cfif>
  <cfset #cc_expiration# = #get_user.cc_expiration#>
  <cfset #balance# = #get_user.balance#>
  <cfset credit = #get_user.credit#>
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
  <cfset #confirmation# = #get_user.confirmation#>
 </cfif>

  <!--- Check if they wanted to delete a user (from the retrieval form) --->
  <cfif #submit# is "Delete User">
    
    <cfquery username="#db_username#" password="#db_password#" name="chkAuctions" datasource="#DATASOURCE#">
        SELECT COUNT(itemnum) AS found
          FROM items
         WHERE user_id = #user_id#
           AND status = 1
    </cfquery>
    <cfquery username="#db_username#" password="#db_password#" name="chkInvoices" datasource="#DATASOURCE#">
        SELECT COUNT(itemnum) AS found
          FROM invoices
         WHERE user_id = #user_id#
           AND paid < invoice_total
    </cfquery>
    
    <cfset allowDel = IIf(chkAuctions.found OR chkInvoices.found, DE("FALSE"), DE("TRUE"))>
    
    <cfif allowDel>
      <cfquery username="#db_username#" password="#db_password#" name="delete" dataSource="#DATASOURCE#">
          DELETE FROM users
           WHERE user_id = #user_id#
      </cfquery>
    



<cfquery name="reset_admin" datasource="#datasource#">
update ocadministrator set status = 0 where store_user_id = #user_id#

</cfquery>


<cfquery name="reset_admin1" datasource="#datasource#">
update ocproductlist set status = 0 where store_user_id = #user_id#

</cfquery>

  

<cfquery name="reset_admin2" datasource="#datasource#">
update ocadmindisplay set store_enable = 0 where store_user_id = #user_id#

</cfquery>

      <!--- log account deletion --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Deleted by Administrator"
        details="USER ID: #user_id#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record deleted.</font>">
    <cfelse>
      <cfset #error_message# = "<font color='0000ff'>Operation Failed - Account has active auctions and/or unpaid invoices.</font>">
    </cfif>
  </cfif>

  <!--- Check if they wanted to delete a user (from the retrieval form) --->
  <cfif #submit# is "Delete">
    
    <cfquery username="#db_username#" password="#db_password#" name="chkAuctions" datasource="#DATASOURCE#">
        SELECT COUNT(itemnum) AS found
          FROM items
         WHERE user_id = #selected_user#
           AND status = 1
    </cfquery>
    <cfquery username="#db_username#" password="#db_password#" name="chkInvoices" datasource="#DATASOURCE#">
        SELECT COUNT(itemnum) AS found
          FROM invoices
         WHERE user_id = #selected_user#
           AND paid < invoice_total
    </cfquery>
    
    <cfset allowDel = IIf(chkAuctions.found OR chkInvoices.found, DE("FALSE"), DE("TRUE"))>
    
    <cfif allowDel>
      <cfquery username="#db_username#" password="#db_password#" name="" dataSource="#DATASOURCE#">
          DELETE FROM users
           WHERE user_id = #selected_user#
      </cfquery>
      
      <!--- log account deletion --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Deleted by Administrator"
        details="USER ID: #selected_user#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record deleted.</font>">
    <cfelse>
      <cfset #error_message# = "<font color='0000ff'>Operation Failed - Account has active auctions and/or unpaid invoices.</font>">
    </cfif>
  </cfif>

 <!--- Run a query to get a list of users --->
 <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
  SELECT user_id AS the_user_id,
         name,
         nickname, 
         is_active,
		 confirmation
    FROM users
 <cfif #isDefined ("search")# and #submit# is "Search">
  <cfif #trim (search)# is not "">
   WHERE name LIKE '%#search#%'
      OR nickname LIKE '%#search#%'
      OR user_id LIKE '%#search#%'
      OR company LIKE '%#search#%'
      OR keyword LIKE '%#search#%'
      OR email LIKE '%#search#%'
  <cfelse>
   WHERE 1=1
  </cfif>
 </cfif>
   ORDER BY nickname
 </cfquery>

 <cfquery username="#db_username#" password="#db_password#" name="get_active_users" datasource="#DATASOURCE#">
  SELECT user_id
    FROM users
   WHERE is_active = 1
   ORDER BY nickname
 </cfquery>

 <cfsetting EnableCFOutputOnly="NO">
 
 <!--- Main page body --->
 <body bgcolor=465775>
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
      <cfset #page# = "users">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
         <tr>
          <td>
           <table border=0 cellspacing=0 cellpadding=5 width=100%>
            <tr>
             <td colspan=2>
              <font face="helvetica" size=2 color=000000>
Use this page to manage all the users on your auction site.
                           
              </font>
             </td>
            </tr>
            <tr>
             <td valign="top">
			  <!--- Edit/Delete feedback --->
				<form action="feedback_list.cfm" method="post" target="_blank">
				<cfif #submit# is "Retrieve" or #submit# is "Update User" or #submit# is "Add User"><cfoutput><input type=hidden name="user_id" value="#user_id#"></cfoutput></cfif>
				<input type=submit name="edit_feedback" value="Edit/Delete Feedback">
				</form>
				
              <form name="userform" action="users.cfm" method="post">
               <cfoutput><input type="hidden" name="user_id" value="#user_id#"></cfoutput>
               <cfoutput><input type="hidden" name="date_registered" value="#date_registered#"></cfoutput>
               <cfoutput><input type="hidden" name="last_login_date" value="#last_login_date#"></cfoutput>
               <cfif #error_message# is not ""><cfoutput><font face="helvetica" size=2><b>Status Message:</b> #error_message#</font><br><br></cfoutput></cfif>
               &nbsp;<font face="Helvetica" size=2 color=000080><b>USER INFORMATION:</b><br>&nbsp; <font size=3><b>* Indicates a required item; all others are optional.</b></font>
               <cfoutput>
               <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                <tr>
                 <td>
                  <table border=0 cellspacing=0 cellpadding=2>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Account Created:</b></font></td>
                    <td><font face="helvetica" size=2 color=000000>#dateFormat (date_registered, 'dd-mmm-yyyy')#</font></td>
                    <td>&nbsp;</td>
                   </tr>
                   <!--- <tr>
                    <!--- <td align="right"><font face="helvetica" size=2 color=000000><b>Last Login Date:</b></font></td> --->
                    <td><font face="helvetica" size=2 color=000000><cfif #last_login_date# is not "">#dateFormat (last_login_date, 'dd-mmm-yyyy')#<cfelse>Never</cfif></font></td>
                    <td>&nbsp;</td>
                   </tr> --->
   <!---                <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>User ID ##:</b></font></td>
                    <td><font face="helvetica" size=2 color=000000>#user_id#</font></td>
                    <td>&nbsp;</td>
                   </tr> --->
                   <tr>
                    <td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td>
                   </tr>
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Name:</b></font></td>
                    <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="name" type="text" size=20 maxlength=65 value="#name#"></td><td>&nbsp;&nbsp;<font face="helvetica" size=2><b>User ID ##:</b> #user_id#</font></td></tr></table></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Nickname:</b></font></td>
                    <td><input name="nickname" type="text" size=15 maxlength=20 value="#nickname#"></td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Password:</b></font></td>
                    <td><input name="password" type="text" size=12 maxlength=12 value="#password#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Keyword:</b></font></td>
                    <td><input name="keyword" type="text" size=12 maxlength=20 value="#keyword#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Company:</b></font></td>
                    <td><input name="company" type="text" size=30 maxlength=65 value="#company#"></td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  E-Mail Address:</b></font></td>
                    <td><input name="email" type="text" size=30 maxlength=65 value="#email#"></td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr>
                	<td valign="top" align="right"><font face="helvetica" size=2><b>Email me when:</b></font></td>
                	<td colspan="2"><table border=0 cellspacing=0 cellpadding=0 width=100%><tr><td>
					<input type="Checkbox" name="bid_confirm_email" value="1" <cfif bid_confirm_email eq 1>checked</cfif>>&nbsp;<font face="helvetica" size=2>My bid is successful</font><br>
					<input type="Checkbox" name="outbid_email" value="1" <cfif outbid_email eq 1>checked</cfif>>&nbsp;<font face="helvetica" size=2>I am outbid</font><br>
					<input type="Checkbox" name="autobid_email" value="1" <cfif autobid_email eq 1>checked</cfif>>&nbsp;<font face="helvetica" size=2>My bid is automatically raised via auto bid feature</font>
					</td></tr></table>
					</td>
              	   </tr>
				   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Phone 1:</b></font></td>
                    <td><input name="phone1" type="text" size=20 maxlength=20 value="#phone1#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Phone 2:</b></font></td>
                    <td><input name="phone2" type="text" size=20 maxlength=20 value="#phone2#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Fax:</b></font></td>
                    <td><input name="fax" type="text" size=20 maxlength=20 value="#fax#"></td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Balance:</b></font></td>
                    <td><input name="balance" type="hidden" size=12 maxlength=20 value="#balance#"><font face="helvetica" size=2>#numberformat(balance,numbermask)#</font></td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Credit:</b></font></td>
                    <td><input name="credit" type="hidden" size=12 maxlength=20 value="#credit#"><font face="helvetica" size=2>#numberformat(credit,numbermask)#</font></td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr><TD align="right"><font face="helvetica" size=2><b>Credit Card Holder:</b></font></TD><TD><input name="cc_name" type="text" size=20 maxlength=20 value="#cc_name#"></TD><TD>&nbsp;</TD></tr>
				   <tr><TD align="right"><font face="helvetica" size=2><b>Credit Card Number:</b></font></TD><TD><input name="cc_number" type="text" size=16 maxlength=16 value="#cc_number#"></TD><TD>&nbsp;</TD></tr>
				   <TR><TD align="right"><font face="helvetica" size=2><b>Credit Card Expiration:</b></font></TD><TD><input name="cc_expiration" type="text" size=08 maxlength=08 value="#cc_expiration#"></TD><TD>&nbsp;</TD></TR>
				   <tr><td colspan=3>&nbsp;</td></tr>
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Address:</b></font></td>
                    <td><input name="address1" type="text" size=30 maxlength=65 value="#address1#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Address:</b></font></td>
                    <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="address2" type="text" size=30 maxlength=65 value="#address2#"></td><td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>(Line 2)</font></td></tr></table></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  City:</b></font></td>
                    <td><input name="city" type="text" size=20 maxlength=65 value="#city#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>                    
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  State/Province:</b></font></td>
                    <td><input name="state" type="text" size=12 maxlength=50 value="#state#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Postal Code:</b></font></td>
                    <td><input name="postal_code" type="text" size=5 maxlength=20 value="#postal_code#"></td>
                    <td>&nbsp;</td>
                   </tr>
<!---                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Country:</b></font></td>
                    <td><input name="country" type="text" size=20 maxlength=50 value="#country#"></td>
                    <td>&nbsp;</td>
                   </tr> --->
                   <tr>
                    <td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Country:</b></font></td>
                    <td><CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                         SELECTNAME="country"
                         SELECTED="#country#"
                         MULTIPLE="0"
                         SIZE="1">
                    </td>
                    <td>&nbsp;</td>
                   </tr>
		 		   <tr bgcolor="687997"><td valign="top" align="right"><font face="helvetica" size=2><b>Shipping Information:</b></font></td><td colspan="2"><input type="checkbox" name="same_address" value="1" <cfif same_address eq 1>checked</cfif>>&nbsp;<font size=2>Check here if your shipping address is the same as the address above.<br>(Check means you can ignore the shipping address fields below.)</font></td></tr>
				   <tr><td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Shipping Address:</b></font></td><td><input type="text" name="shipping_address1" value="#shipping_address1#" size=25 maxlength=65></td><td>&nbsp;</td></tr>
         		   <tr><td align="right"><font face="helvetica" size=2><b>Shipping Address (line 2):</b></font></td><td><input type="text" name="shipping_address2" value="#shipping_address2#" size=25 maxlength=65></td><td>&nbsp;</td></tr>
         		   <tr><td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Shipping City:</b></font></td><td><input type="text" name="shipping_city" value="#shipping_city#" size=25 maxlength=65></td><td>&nbsp;</td></tr>
         		   <tr><td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Shipping State:</b></font></td><td><input type="text" name="shipping_state" value="#shipping_state#" size=25 maxlength=65></td><td>&nbsp;</td></tr>
         		   <tr><td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Shipping Postal Code:</b></font></td><td><input type="text" name="shipping_postal_code" value="#shipping_postal_code#" size=25 maxlength=65></td><td>&nbsp;</td></tr>
         		   <tr><td align="right"><font color="#get_layout.heading_fcolor#"><b>*

  Shipping Country:</b></font></td><td><CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="shipping_country" SELECTED="#shipping_country#" MULTIPLE="0" SIZE="1"></td><td>&nbsp;</td></tr>
				   <tr><td colspan=3>&nbsp;</td></tr>
				   <tr bgcolor="687997"><td colspan=3><font face="helvetica" size=2 color=000000><b>Optional Information</b></font></td></tr>
				   
				   <cfif get_membership_status.pair eq 1>
			  <tr>
                <td valign="bottom" align="right"><font face="helvetica" size=2><b><cfif membership neq "" and membership_exp gt timenow>Your</cfif> Membership:</b></font><br><a href="../help/about_membership.cfm" target="_blank"><font face="helvetica" size="-2">about membership</font></a></td>
				
                <td>
				  <cfif membership neq "" and (membership_exp gt timenow or membership_status eq 0)>
				  <input type="Hidden" name="membership" value="">
				  <input type="Hidden" name="membership_exp" value="#membership_exp#">
				  <input type="Hidden" name="membership_status" value="#membership_status#">
				  <cfset membership_fee = listgetat(membership,1,"_")>
				  <cfset membership_pct = listgetat(membership,2,"_")>
				  <cfset membership_name = listgetat(membership,3,"_")>
				  <cfset membership_cycle = listgetat(membership,4,"_")>
				  <font face="helvetica" size=2>#membership_name# #membership_pct#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership. <br><cfif membership_status eq 1>(exp. #dateformat(membership_exp,"mm/dd/yyyy")#)<input type="Submit" name="deactivate_membership" value="Deactivate"><cfelse><b>Status: INACTIVE &nbsp;<input type="Submit" name="activate_membership" value="Activate"></b></cfif></font><br>
          <select name="membership">
                  <option value="">-- Select an option --</option>
                  <cfloop query="get_memberships">
				  <cfset membership_fee = listgetat(pair,1,"_")>
				  <cfset membership_pct = listgetat(pair,2,"_")>
				  <cfset membership_name = listgetat(pair,3,"_")>
				  <cfset membership_cycle = listgetat(pair,4,"_")>
				  <option value="#pair#"<cfif #membership# is pair> selected</cfif>>#membership_name# #membership_pct#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership</option>
				  </cfloop>
                  </select>
				  <cfelse>
				  <input type="Hidden" name="membership_exp" value="#membership_exp#">
				  <input type="Hidden" name="membership_status" value="#membership_status#">
                  <select name="membership">
                  <option value="">-- Select an option --</option>
                  <cfloop query="get_memberships">
				  <cfset membership_fee = listgetat(pair,1,"_")>
				  <cfset membership_pct = listgetat(pair,2,"_")>
				  <cfset membership_name = listgetat(pair,3,"_")>
				  <cfset membership_cycle = listgetat(pair,4,"_")>
				  <option value="#pair#"<cfif #membership# is pair> selected</cfif>>#membership_name# #membership_pct#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership</option>
				  </cfloop>
                  </select>
				  </cfif>
                </td>
				<td width=10>&nbsp;</td>
			  </tr>
			  <cfelse>
			  	<input type="Hidden" name="membership" value="#membership#">
			  </cfif>
				   
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Referred By:</b></font></td>
                    <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="friends_email" type="text" size=30 maxlength=65 value="#friends_email#"></td><td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>E-Mail</font></td></tr></table></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Language:</b></font></td>
                    <td><cfmodule template="..\functions\cf_languages.cfm" option="SELECT" langset="E" selectname="language" selected="#language#" size="1" multiple="NO"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Heard From:</b></font></td>
                    <td>
                     <select name="heard_from">
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
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Site Use:</b></font></td>
                    <td>
                     <select name="use_for">
                      <option value="P"<cfif #use_for# is "P"> selected</cfif>>Personal</option>
                      <option value="B"<cfif #use_for# is "B"> selected</cfif>>Business</option>
                      <option value="A"<cfif #use_for# is "A"> selected</cfif>>Personal &amp; Business</option>
                     </select>
                    </td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Interested In:</b></font></td>
                    <td><input name="interested" type="text" size=20 maxlength=50 value="#interested#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Education Level:</b></font></td>
                     <td>
                      <select name="education">
                       <option value="High School"<cfif #education# is "High School"> selected</cfif>>High School</option>
                       <option value="College"<cfif #education# is "College"> selected</cfif>>College</option>
                       <option value="Graduate School"<cfif #education# is "Graduate School"> selected</cfif>>Graduate School</option>
                       <option value="Other"<cfif #education# is "Other"> selected</cfif>>Other</option>
                      </select>
                     </td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Annual Income:</b></font></td>
                    <td><table border=0 cellspacing=0 cellpadding=0><tr>
                     <td>
                      <select name="income">
                       <option value="Under $25,000"<cfif #income# is "Under $25,000"> selected</cfif>>Under $25,000</option>
                       <option value="$25,000 - $35,000"<cfif #income# is "$25,000 - $35,000"> selected</cfif>>$25,000 - $35,000</option>
                       <option value="$36,000 - $49,000"<cfif #income# is "$36,000 - $49,000"> selected</cfif>>$36,000 - $49,000</option>
                       <option value="$50,000 - $75,000"<cfif #income# is "$50,000 - $75,000"> selected</cfif>>$50,000 - $75,000</option>
                       <option value="Over $75,000"<cfif #income# is "Over $75,000"> selected</cfif>>Over $75,000</option>
                      </select>
                     </td>
                     <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>(US Dollars)</font></td></tr>
                     </table>
                    </td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Promotion Code:</b></font></td>
                    <td><input name="promotion_code" type="text" size=10 maxlength=10 value="#promotion_code#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Age Range:</b></font></td>
                    <td>
                     <select name="age">
                      <option value="18-24"<cfif #age# is "18-24"> selected</cfif>>18-24</option>
                      <option value="25-34"<cfif #age# is "25-34"> selected</cfif>>25-34</option>
                      <option value="35-50"<cfif #age# is "35-50"> selected</cfif>>35-50</option>
                      <option value="51-65"<cfif #age# is "51-65"> selected</cfif>>51-65</option>
                      <option value="Over 65"<cfif #age# is "Over 65"> selected</cfif>>Over 65</option>
                     </select>
                    </td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Gender:</b></font></td>
                    <td>
                     <select name="gender">
                      <option value="M"<cfif #gender# is "M"> selected</cfif>>Male</option>
                      <option value="F"<cfif #gender# is "F"> selected</cfif>>Female</option>
                      <option value="N"<cfif #gender# is "N"> selected</cfif>>Not Disclosed</option>
                     </select>
                    </td>
                    <td>&nbsp;</td>
                   </tr>
                   
				   

				   <tr>
                    <td align="right" valign="top"><font face="helvetica" size=2 color=000000><b>Misc. Flags:</b></font></td>
                    <td>
                     <table border=0 cellspacing=0 cellpadding=0>
                      <tr>
                       <td><input name="survey" type="checkbox" value="1"<cfif #survey# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>Would like to participate in surveys</font></td>
                      </tr>
                      <tr>
                       <td><input name="mailing" type="checkbox" value="1"<cfif #mailing# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>On the mailing list</font></td>
                      </tr>
                      <tr>
                       <td><input name="is_active" type="checkbox" value="1"<cfif #is_active# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>User is Active</font></td>
                      </tr>
					  <tr>
                       <td><input name="confirmation" type="checkbox" value="1"<cfif #confirmation# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>Confirmation</font></td>
                      </tr>



		  <tr>
                       <td><input name="Full_control" type="checkbox" value="0"<cfif #full_control# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>Full Control </font>(<font color=red size=1> &nbsp;Allow seller to delete bids as well as cancel or delete their auctions)</font></td>
                      </tr>

	  <!--- <tr>
                       <td><input name="store_control" type="checkbox" value="0"<cfif #store_control# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>Store </font>(<font color=red size=1> &nbsp;Allow users to have their own store )</font></td>
                      </tr> --->
                     </table>
                    </td>
                    <td>&nbsp;</td>
                   </tr>
				   <tr>
                    <td colspan=3>
                     <table border=0 cellspacing=0 cellpadding=0>
                      <tr>
                       <td>&nbsp;<input type="submit" name="submit" value="Clear Form"></td>

                       <!--- Only show an "Update User" button if they're editing an existing user --->
                       <cfquery username="#db_username#" password="#db_password#" name="check_existing" datasource="#DATASOURCE#">
                        SELECT user_id
                          FROM users
                         WHERE user_id = #user_id#
                       </cfquery>
                       <cfif (#submit# is not "enter") and (#check_existing.recordCount# GT 0)>
                        <td>&nbsp;<input type="submit" name="submit" value="Update User"></td>
                        <td><!--- &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Delete User"> ---></td>
		       <cfelse>
			<td><input type="submit" name="submit" value="Add User"></td>
                       </cfif>
                      </tr>
                     </table>
                    </td>
                   </tr>
                  </table>
                  </cfoutput>
                 </td>
                 <td valign="top">
                  <table border=0 cellspacing=0 cellpadding=2>
                   <tr>                    
                    <td><font face="helvetica" size=2 color=000000><b>List of Current Users:</b><br>
                    <cfif #isDefined ("search")# and #submit# is "Search"><cfoutput>#get_users.recordcount# matching record(s) found.</cfoutput><cfelse><cfoutput>(#get_users.recordcount# total users, #get_active_users.recordcount# active)</cfoutput></cfif></font><br></td>
                   </tr>
                   <tr>
                    <td>
                     <input type="text" name="search" size=20 maxlength=255<cfif #isDefined ("search")#><cfoutput> value="#search#"</cfoutput></cfif>>
                     <input type="submit" name="submit" value="Search">
                    </td>
                   </tr>
<CFOUTPUT>
<CFIF #ParameterExists(StartRow)# IS "No">
	<CFSET StartRow = 1>
<CFELSE>
	<CFSET StartRow = (StartRow + 500)>
	<CFSET LastRow = (#StartRow# - 1000)>
</CFIF>

<cfparam name="search" default="none">

<CFIF #get_users.Recordcount# LT (StartRow + 499)>
	<CFSET EndRow = #get_users.Recordcount#>
<CFELSEIF #get_users.Recordcount# GT (StartRow + 499)>
	<CFSET EndRow = (StartRow + 499)>
</CFIF>
</CFOUTPUT>
                   <tr>                    
                    <td><select name="selected_user" size=15 width=231>
                     <cfif #get_users.recordCount# GT 0>
                      <!--- <cfloop query="get_users"> --->
<!---                       <cfoutput><option value=#the_user_id#<cfif #the_user_id# is #user_id#> selected<cfelseif #currentRow# is 1> selected</cfif>><cfif #is_active# is 0>[</cfif>#nickname# (#name#)<cfif #is_active# is 0>]</cfif></option></cfoutput> --->
                      <!---  <cfoutput><option value=#the_user_id#<cfif #the_user_id# is #user_id#> selected<cfelseif #currentRow# is 1> selected</cfif>><cfif #is_active# is 0>[</cfif><cfif #trim (nickname)# is not #user_id#>#nickname#<cfelse>#name#</cfif><cfif #is_active# is 0>]</cfif></option></cfoutput>
                      </cfloop> --->
<CFOUTPUT QUERY="get_users" STARTROW=#StartRow# MAXROWS=500>

<option value=#the_user_id#<cfif #the_user_id# is #user_id#> selected<cfelseif #currentRow# is 1> selected</cfif>><cfif #is_active# is 0>[</cfif><cfif #trim (nickname)# is not #user_id#>#nickname#<cfelse>#name#</cfif><cfif #is_active# is 0>]</cfif><cfif get_users.confirmation eq 0>*</cfif></option>

</CFOUTPUT>
                     <cfelse>
                      <option value="-1" selected>< empty ></option>
                     </cfif>
                    </select><br><center><font face="helvetica" size=2><i>Inactive users are in [brackets]<br>* : Users are not confirmed</i></font></center><br></td>
                   </tr>
<CFOUTPUT>						 
<CFIF #get_users.Recordcount# GT 500 OR #get_users.Recordcount# LT 500>

<tr>
<td width="231" height="8" valign="middle"><font color="red" size="2"><strong><p
align="center">#StartRow# - #EndRow#&nbsp; of&nbsp; #get_users.Recordcount#</strong></font></td>
</tr>

</CFIF>

<CFIF #get_users.Recordcount# GT 500 AND #search# is "none">
<CFIF (StartRow) LT 500>

<tr>
<td width="231" height="20" valign="top"><font color="black" size="2"><strong><p
align="center">&lt;&lt;&nbsp;<a href="users.cfm?StartRow=#StartRow#">Next</a>&nbsp;&gt;&gt;</strong></font></td>
</tr>

<CFELSEIF (StartRow) GT 500 AND (StartRow + 499) LT #get_users.Recordcount#>

<tr>
<td width="231" height="20" valign="top"><font color="black" size="2"><strong><p
align="center">&lt;&lt;&nbsp;<a href="users.cfm?StartRow=#LastRow#">Back</a>&nbsp; <a href="users.cfm?StartRow=#StartRow#">Next</a>&nbsp;&gt;&gt;</strong></font></td>
</tr>

<CFELSEIF (StartRow + 499) GT #get_users.Recordcount#>

<tr>
<td width="231" height="20" valign="top"><font color="black" size="2"><strong><p
align="center">&lt;&lt;&nbsp;<a href="users.cfm?StartRow=#LastRow#">Back</a>&nbsp;&gt;&gt;</strong></font></td>
</tr>


</CFIF>

<CFELSEIF #get_users.Recordcount# GT 500 AND #search# is not "none">
<CFIF (StartRow) LT 500>

<tr>
<td width="231" height="20" valign="top"><font color="black" size="2"><strong><p
align="center">&lt;&lt;&nbsp;<a href="users.cfm?search=#search#&type=Search&StartRow=#StartRow#">Next</a>&nbsp;&gt;&gt;</strong></font></td>
</tr>

<CFELSEIF (StartRow) GT 500 AND (StartRow + 499) LT #get_users.Recordcount#>

<tr>
<td width="231" height="20" valign="top"><font color="black" size="2"><strong><p
align="center">&lt;&lt;&nbsp;<a href="users.cfm?search=#search#&type=Search&StartRow=#LastRow#">Back</a>&nbsp; <a href="users.cfm?search=#search#&type=Search&StartRow=#StartRow#">Next</a>&nbsp;&gt;&gt;</strong></font></td>
</tr>

<CFELSEIF (StartRow + 499) GT #get_users.Recordcount#>

<tr>
<td width="231" height="20" valign="top"><font color="black" size="2"><strong><p
align="center">&lt;&lt;&nbsp;<a href="users.cfm?search=#search#&type=Search&StartRow=#LastRow#">Back</a>&nbsp;&gt;&gt;</strong></font></td>
</tr>

</CFIF>
</CFIF>							 
</CFOUTPUT>

                   <tr>
                    <td width="231" height="20" valign="top" align="center">&nbsp;</td>
                   </tr>
                   <cfif #get_users.recordCount# GT 0>
                    <tr>
                     <td>
                      <table border=0 cellspacing=0 cellpadding=0>
                       <tr>                    
                        <td><input type="submit" name="submit" value="Retrieve" width=73></td>
                        <td>&nbsp;<input type="submit" name="submit" value="Disable" width=73</td>
                        <td>&nbsp;<input type="submit" name="submit" value=" Delete " width=73></td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </cfif>
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
