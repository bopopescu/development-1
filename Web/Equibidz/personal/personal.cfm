<!---
	Personal Page:
--->

<!--- include globals --->
<cfset current_page="register">
<cfinclude template="../includes/app_globals.cfm">

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


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
<cfif #submit# is "Update">
	<!--- Trim data before comparing it ---> 
	<cfset #password# = #trim (password)#>
	<cfset #password2# = #trim (password2)#>
	<cfset #email# = #trim (email)#>
	<cfset #email_confirm# = #trim (email_confirm)#>
	<cfset #name# = #trim (name)#>
	<cfset #address1# = #trim (address1)#>
	<cfset #city# = #trim (city)#>
	<cfset #state# = #trim (state)#>
	<cfset province = trim(province)>
	<cfset #postal_code# = #trim (postal_code)#>
	<cfset #phone1# = #trim (phone1)#>
	<cfset #phone2# = #trim (phone2)#>
	<cfset #fax# = #trim (fax)#>
	<!---<cfset #cc_name# = #trim (cc_name)#>
	<cfset #cc_number# = #trim (cc_number)#>--->
	<!---<cfset #cc_expiration# = #trim (cc_expiration)#>--->

	<!--- Check to see if the same e-mail was used for an inactive user ---> 
	<cfquery username="#db_username#" password="#db_password#" name="check_inactive_users" datasource="#DATASOURCE#">
		SELECT user_id
		FROM users
		WHERE email LIKE '#email#'
		AND is_active = 0
	</cfquery>
	
	<!--- Check for password invalid data ---> 
	<CFMODULE TEMPLATE="../functions/checkpassword.cfm" password="#password#">
	<cfif #password# is not #password2#>
		<cfset #error_list# = #listAppend (error_list, "password")#>
		<cfset #error_list# = #listAppend (error_list, "password2")#>
		<cfset #password_error# = "The passwords you typed didn't match. Please type the same password twice.">
	<cfelse>
		<cfif #password_good# is not "1">
			<cfset #error_list# = #listAppend (error_list, "password")#>
			<cfset #error_list# = #listAppend (error_list, "password2")#>
			<cfset #password_error# = "The password  must be at least 5 characters long and contain numbers and letters.">
		</cfif>
	</cfif>
  
	<!--- Check for errors in data ---> 
	<cfif #email# is not #email_confirm#>
		<cfset #error_list# = #listAppend (error_list, "email")#>
		<cfset #error_list# = #listAppend (error_list, "email_confirm")#>
	</cfif>

	<cfmodule template="../functions/Mailtest.cfm" email=#email#>
	<cfif #email_level# GT 0>
		<cfset #error_list# = #listAppend (error_list, "email")#>
	</cfif>

	<!---<!---<cfif #cc_number# is not "">
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
		</cfif>--->
	</cfif>
	
	<!---<cfif #cc_name# is not "">
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
		</cfif>--->
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
	<cfif #len (phone1)# LT 6>
		<cfset #error_list# = #listAppend (error_list, "phone1")#>
	</cfif>
		
	<cfif len(#error_list#) EQ 0>
	  <cfquery username="#db_username#" password="#db_password#" name="add_user" datasource="#DATASOURCE#">
  	    UPDATE users
        SET password = '#password#',
            email = '#email#',
            name = '#name#',
            address1 = '#address1#',
            city = '#city#',
            <cfif #country# eq "USA">            
               state = '#state#',
            <cfelse>
               state = '#province#',
            </cfif>   
            country = '#country#',
            postal_code = '#postal_code#',
            phone1 = '#phone1#',
            phone2 = '#phone2#',
            fax = '#fax#',
            license = '#license#',
            tax_id = '#tax_id#'<!---,
            
           cc_name = '#cc_name#',
            cc_number = '#cc_number#',
            cc_expiration = '#cc_expiration#',
            bank_name = '#bank_name#',
            bank_city = '#bank_city#',
            --->
            
            <!---bank_phone = '#bank_phone#'--->
        
        WHERE user_id = #session.user_id# 
	  </cfquery>   
	</cfif>
</cfif>
<cfquery username="#db_username#" password="#db_password#" name="get_user" datasource="#DATASOURCE#">
   SELECT *
   FROM users
   WHERE user_id = #session.user_id#
</cfquery>
<cfset nickname = #get_user.nickname#>
<cfset password = #get_user.password#>
<cfset password2 = #get_user.password#>
<cfset email = #get_user.email#>
<cfset email_confirm = #get_user.email#>
<cfset name = #get_user.name#>
<cfset address1 = #get_user.address1#>
<cfset city = #get_user.city#>
<cfset state = #get_user.state#>
<cfset province = "">
<cfset country = #get_user.country#>
<cfset postal_code = #get_user.postal_code#>
<cfset phone1 = #get_user.phone1#>
<cfset phone2 = #get_user.phone2#>
<cfset fax = #get_user.fax#>
<cfset license = #get_user.license#>
<cfset tax_id = #get_user.tax_id#>

<!---<cfset cc_name = #get_user.cc_name#>
<cfset cc_number = #get_user.cc_number#>
<cfset cc_expiration = #get_user.cc_expiration#>
<cfset bank_name = #get_user.bank_name#>
<cfset bank_city = #get_user.bank_city#>--->
<!---<cfset bank_phone = #get_user.bank_phone#>--->

<cfoutput>
<html>
	<head>
		<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	</head>
					<!--- START: The main table --->
	<div align="left">
    <table border='0' cellspacing='0' cellpadding='0' width='600'>
    <tr><td>	
					<form name="reg_form" action="my_accounts.cfm?my_no=11" method="post">
					<table border='0' cellspacing='0' cellpadding='0' width='600' style="color:white;">
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td colspan='2'>
							<cfif #error_list# is not "">
								<span class='error'>
									<b>INCOMPLETE:</b> Please verify that the highlighted items are correct.
								</span>
								<br />
							</cfif>		
							<cfif #cc_number_error# is not "">
								<font color="ff0000">#cc_number_error#</font><br />
							</cfif>
							<cfif #password_error# is not "">
								<font color="ff0000">#password_error#</font><br />
							</cfif>
							<cfif #email_msg# is not "">
								<font size=3 color=ff0000>#email_msg#</font><br />
							</cfif>
							<cfif Len(Variables.sBlockedMsg)>
								<font size=3 color=ff0000>#Variables.sBlockedMsg#</font><br />
							</cfif>
							<cfif IsDefined("Variables.nickname_error")>
								<cfif Len(Variables.nickname_error)>
									<font size=3 color=ff0000>#Variables.nickname_error#</font><br />
								</cfif>
							</cfif>
							<cfif #error_message# is not "">
								<font size=3 color=ff0000>#error_message#</font><br />
							</cfif>							
						</td>
					</tr>					
					<tr <cfif #listFind (error_list, "name")#>bgcolor='red'</cfif>>
						<td width='220' valign='top'><b>Full Name:</b></td>
						<td>
							<input type='text' name='name' size='35' value='#name#' style='width:220px'>
						</td>
					</tr>
					<tr <cfif #listFind (error_list, "address1")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Street Address:</b></td>
						<td>
							<input type='text' name='address1' size='50' value='#address1#' style='width:220px'>
						</td>
					</tr>
					<tr <cfif #listFind (error_list, "city")#>bgcolor='red'</cfif>>
						<td valign='top'><b>City:</b></td>
						<td>
							<input type='text' name='city' value='#city#' style='width:220px'>
						</td>
					</tr>		
					<tr <cfif #listFind (error_list, "state")#>bgcolor='red'</cfif>>
						<td valign='top'><b>State / Province:</b></td>
						<td>
							<CFMODULE TEMPLATE="..\functions\cf_states.cfm"	SELECTNAME="state" SELECTED="#state#" MULTIPLE="0" SIZE="1" ANY="1">
							<b>Non US Province:</b><input name="province" size='15' maxlength='50' value="#province#">
						</td>
					</tr>
					<tr <cfif #listFind (error_list, "postal_code")#>bgcolor='red'</cfif>>
						<td><b>Zip code:</b></td>
						<td>
							<input type='text' name='postal_code' size='15' value='#postal_code#' style='width:220px'>
						</td>
					</tr>
					<tr <cfif #listFind (error_list, "country")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Country:</b></td>
						<td>
							<CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="country" SELECTED="#country#" MULTIPLE="0" SIZE="1">
						</td>
					</tr>
					<tr <cfif #listFind (error_list, "phone1")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Home Phone:</b></td>
						<td>
							<input type='text' name='phone1' value='#phone1#' style='width:220px'>			
						</td>
					</tr>	
					<tr <cfif #listFind (error_list, "phone2")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Work Phone:</b></td>
						<td>
							<input type='text' name='phone2' value='#phone2#' style='width:220px'>
						</td>
					</tr>	
					<tr <cfif #listFind (error_list, "fax")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Fax:</b></td>
						<td>
							<input type='text' name='fax' value='#fax#' style='width:220px'>
						</td>
					</tr>	
					<tr <cfif #listFind (error_list, "email")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Email:</b></td>
						<td>
							<input type='text' name='email' value='#email#' style='width:220px'>
						</td>
					</tr>	
					<tr <cfif #listFind (error_list, "email_confirm")#>bgcolor='red'</cfif>>
						<td><b>Enter email again:</b></td>
						<td>
							<input type='text' name='email_confirm' value='#email_confirm#' style='width:220px'>
						</td>
					</tr>
					<tr>
						<td valign='top'><b>Driver's License:</b></td>
						<td>
							<input type='text' name='license' value='#license#' style='width:220px'>
						</td>
					</tr>	
					<tr>
						<td valign='top'><b>Tax ID:</b></td>
						<td>
							<input type='text' name='tax_id' value='#tax_id#' style='width:220px'>
						</td>
					</tr>
					<tr>
						<td colspan='2'><hr /></td>
					</tr>		
					<!---<cfif #listFind (error_list, "cc_name")#>bgcolor='red'</cfif>>
						<td><b>Credit Card name:</b></td>
						<td>
							<input type="text" name="cc_name" size='16' maxlength='16' value="#cc_name#" style='width:220px'>--->
							
						<!---<CFMODULE TEMPLATE="..\functions\cf_ccardname.cfm"
                 						SELECTNAME="cc_name"
                  						SELECTED="#cc_name#"
                  						MULTIPLE="0"
                  						SIZE="1">	
							
							<br /><span class='error'><cfif #listFind (error_list, "cc_name")#>#cc_name_error#</cfif></span>--->
						<!---</td>
					</tr>	
						</td>
					
					<tr <cfif #listFind (error_list, "cc_number")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Credit Card number:</b></td>
						<td>
							<input type="text" name="cc_number" size='16' maxlength='16' value="#cc_number#" style='width:220px'>
							<br /><span class='error'><cfif #listFind (error_list, "cc_number")#>#cc_number_error#</cfif></span>
						</td>
					</tr>	--->	
					<!---<tr <cfif #listFind (error_list, "cc_expiration")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Credit Card Expiration:</b></td>
						<td>
							<input type="text" name="cc_expiration" size='7' maxlength='7' value="#cc_expiration#" style='width:220px'>
							<br /><span class='error'><cfif #listFind (error_list, "cc_expiration")#>#cc_expiration_error#</cfif></span>
						</td>
					</tr>--->		
					<!---<tr>
						<td><b>Bank Name:</b></td>
						<td>
							<input type='text' name='bank_name' value='#bank_name#' style='width:220px'>
						</td>
					</tr>		
					<tr>
						<td valign='top'><b>Bank City & State:</b></td>
						<td>
							<input type='text' name='bank_city' value='#bank_city#' style='width:220px'>
						</td>
					</tr>	--->	
					<!---<tr>
						<td valign='top'><b>Bank Phone:</b></td>
						<td>
							<input type='text' name='bank_phone' value='#bank_phone#' style='width:220px'>
						</td>
					</tr>--->
					<tr>
						<td colspan='2'><hr /></td>
					</tr>						
					<tr <cfif #listFind (error_list, "nickname")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Username:</b></td>
						<td valign='top'><b>#nickname#</b></td>
					</tr>
					<tr <cfif #listFind (error_list, "password")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Password:</b></td>
						<td>
							<input type='password' name='password' value='#password#' style='width:220px'>
							<br /><span class='error'><cfif #listFind (error_list, "password")#>#password_error#</cfif></span>
						</td>
					</tr>		
					<tr <cfif #listFind (error_list, "password2")#>bgcolor='red'</cfif>>
						<td valign='top'><b>Confirm Password:</b></td>
						<td>
							<input type='password' name='password2' value='#password2#' style='width:220px'>
							&nbsp;<span class='error'><cfif #listFind (error_list, "password2")#>Not the same</cfif></span>
						</td>
					</tr>		
					<tr>
						<td colspan='2' align='center'><br><br>
							<input type="submit" name="submit" value="Update" width='75'>							
							<input type="submit" name="submit" value="Reset" width='75'>							
						</td>
					</tr>							
					</table>
					</form>
					<!--- END: The main table --->
				</td>
			</tr>
	</td></tr>		
	</table>
	</div>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
