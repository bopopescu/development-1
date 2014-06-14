<html>
 <head>
  <title>Equibidz Auction Server Administrator [Users Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <!--- Check for access permission. --->
<cfquery username="#db_username#" password="#db_password#" name="check_access" datasource="#DATASOURCE#">
 SELECT *
   FROM access

  WHERE login = '#Trim(session.username)#'
    AND is_active = 1
	AND login = '#check_password.login#'


</cfquery>
 
<CFIF check_access.recordcount NEQ 0>
	<cfset session.admin_access = #check_access.admin_access#>
	<cfset session.defaults_access = #check_access.defaults_access#>
	<cfset session.users_access = #check_access.users_access#>
	<cfset session.accounts_access = #check_access.accounts_access#>
	<cfset session.categories_access = #check_access.categories_access#>
	<cfset session.auctions_access = #check_access.auctions_access#>
	<cfset session.siteinfo_access = #check_access.siteinfo_access#>
	<cfset session.reports_access = #check_access.reports_access#>
	<cfset session.classified_access = #check_access.classified_access#>
	<cfset session.access_access = #check_access.access_access#>
	
	<cfif #check_access.admin_access# eq 0>
		<cflocation url="./access_error.cfm?access_cat=Admin." addtoken="No">
	</cfif>
<cfelse>
	<cflock timeout="30" name="#session.sessionid#" type="exclusive">
		<cfset structdelete(session, "username")>
		<cfset structdelete(session, "password")>
	</cflock>
	<cflocation url="login.cfm?failed=2" addtoken="No">
</cfif>
 
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

 <!--- Set default for "submit" if not defined --->
 <cfif (#isDefined ("submit")# is 0) or (#clear# is "1")>
  <cfset #submit# = "enter">

  <!--- Set global defaults --->
  <!--- <cfset #user_id# = #EPOCH#> --->
  <cfset #name# = "">
  <cfset #login# = "">
  <cfset #password# = "">
  <cfset is_active = "">
  <cfset the_selected_user = "">
 <cfelse>
  <cfset #submit# = #trim (submit)#>
 </cfif>

 <!--- Set default for "error_message" --->
 <cfset #error_message# = "">

 <!--- Make sure bit variables (checkboxes) exist as "1" or "0" --->
 <cfif #isDefined ("is_active")#>
  <cfset #is_active# = "1">
 <cfelse>
  <cfset #is_active# = "0">
 </cfif>
 

 <!--- Check for invalid/missing form data --->
 <cfset #bad_data# = "0">
 <cfif (#submit# is "Add User") or (#submit# is "Update User")>
  <cfset #error_message# = "">

  <!--- First, check for missing data --->
  <cfif #name# is "">
   <cfset #error_message# = "#error_message#<br><font color='ff0000'>Missing Data - You must specify a user name.</font>">
  </cfif>
 
   <cfif #login# is "">
    <cfset #error_message# = "#error_message#<br><font color='ff0000'>Missing Data - You must specify a login for this user.</font>">
   </cfif>

  
   <cfif #password# is "">
    <cfset #error_message# = "#error_message#<br><font color='ff0000'>Missing Data - You must specify a login password.</font>">
   </cfif>
  
  

  <!--- Next, make sure password is alphanumeric --->
  <!--- <cfif #error_message# is "">
   <cfmodule template="../functions/checkpassword.cfm" password=#password#>
   <cfif #password_good# is not "1">
    <cfset #error_message# = "<font color='ff0000'>#result_message#</font>">
   </cfif>      
  </cfif> --->

  <!--- Check to see if their login is already in use --->
  <cfif #login# is not "">
    
    <cfquery username="#db_username#" password="#db_password#" name="check_login" datasource="#DATASOURCE#">
        SELECT login
          FROM administrators
		WHERE login LIKE '#login#'
      <cfif IsNumeric(login)>
            OR login = #login#
      </cfif>
    </cfquery>
	    
    <cfif check_login.recordCount GT 0
      AND check_login.login IS NOT login>
      
      <cfset #error_message# = "<font color='ff0000'>Sorry, the login ""#login#"" is already in use by another user.  Please choose another.</font>">
    </cfif>
  </cfif>
  
  <cfif #error_message# is not "">
   <cfset #bad_data# = "1">
  </cfif>

 </cfif>

  <!--- Check if they wanted to inactivate a user --->
  <cfif (#submit# is "Disable")>
    
    <cfquery username="#db_username#" password="#db_password#" name="disable_user" datasource="#DATASOURCE#">
        UPDATE administrators
           SET is_active = 0
         WHERE admin_id = #selected_user#
    </cfquery>
    
    <!--- log account set inactive --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Admin Account Deactivated by Administrator"
      details="USER ID: #selected_user#">
    
    <cfset #error_message# = "<font color='0000ff'>Operation successful - User set to inactive.</font>">
    <cfset #submit# = "Retrieve">
	<cfset the_selected_user = #selected_user#>
  </cfif>

  <!--- Check if they wanted to add a new user ---> 
  <cfif (#submit# is "Add User") and (#bad_data# is "0")> 
    
    <!--- <cfset #user_id# = #EPOCH#> --->
    
    
    <!--- if no errors --->
    <cfif not Len(error_message)>
    
     
      <!--- JJK feature7 --->
      <cfquery username="#db_username#" password="#db_password#" name="" datasource="#DATASOURCE#">
          INSERT INTO administrators
                 (name,
                  login,
                  password,
                  date_created,
                  sec_level,
                  is_active)

     VALUES     ('#name#',
                 '#login#',
                 '#password#',
                 #now ()#,
                 10,
                 #is_active#)
      </cfquery>
	  <cfquery name="getNew" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">
SELECT admin_id FROM administrators
ORDER BY admin_id DESC
</cfquery>

<CFSET NewAdminID = #getNew.admin_id# + 1>

<!--- <cfset new_admin_id = getNew.admin_id> --->

	  <cfquery username="#db_username#" password="#db_password#" name="insertaccess" datasource="#DATASOURCE#">
  		INSERT INTO access 
		(name,login,admin_access,defaults_access,users_access,accounts_access,categories_access,auctions_access,siteinfo_access,reports_access,access_access,is_active,admin_id,classified_access,support_access,banner_access) 
		VALUES 
		('#name#','#login#','1','1','1','1','1','1','1','1','1','1',#NewAdminID#,'1','1','1')
	</cfquery>
      
      <!--- log account creation --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Created & Finalized by Administrator"
        details="NAME: #name#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record added.</font>">
      <!--- <cfif (#isDefined ("selected_user")# is 0)>
	  	<cfset the_selected_user = "#name#">
	  <cfelse>
	  	<cfset the_selected_user = "#selected_user#">
	  </cfif> --->
	</cfif>
  </cfif>

  <!--- Check if they wanted to update a user ---> 
  <cfif (#submit# is "Update User") and (#bad_data# is "0")> 
    
    <!--- if last login date prev 1969 & user now active,
      define last login date to Now() --->
    
    <!--- <cfif IsDefined("Form.is_active")
      AND DateCompare(Form.last_login_date, '12/31/1969') IS 0>
      
      <cfset last_login_date = #CreateODBCDateTime(now())#>
    <cfelse>
      <cfset last_login_date = CreateODBCDateTime(Form.last_login_date)>
    </cfif> --->
    
    <!--- if no errors --->
    <cfif not Len(error_message)>
      <!---  CC_info fields populated with default of 0 --->
      
	  <!--- JJK feature7 --->
      <cfquery username="#db_username#" password="#db_password#" name="update_user" datasource="#DATASOURCE#">
          UPDATE administrators
             SET name = '#name#',
			     login = '#login#',
                 password = '#password#',
                 is_active= #is_active#
           WHERE admin_id = #admin_id#
      </cfquery>
	  
	  <cfquery username="#db_username#" password="#db_password#" name="update_access" datasource="#DATASOURCE#">
          UPDATE	access
          SET		name = '#name#',
		  			login = '#login#',
					is_active= #is_active#
		 WHERE		admin_id = #admin_id#
      </cfquery>
      
      <!--- log account updated --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Information Updated by Administrator"
        details="NAME: #name#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record updated.</font>">
    <!---   <cfset the_selected_user = "#selected_user#"> --->
	</cfif>
  </cfif>
<!--- JJK feature7 --->
 <!--- Check to see if they wanted to retrieve a user's record --->
 <cfif #submit# is "Retrieve">
  <cfquery username="#db_username#" password="#db_password#" name="get_user" datasource="#DATASOURCE#">
     SELECT name,
          login,
          password,
          is_active,
		  admin_id
     FROM administrators
    WHERE admin_id = #selected_user# 
	
  </cfquery>
  
  <!--- Set global defaults --->
  <cfset #name# = #get_user.name#>
  <cfset #login# = #get_user.login#>
  <cfset #password# = #get_user.password#>
  <cfset #is_active# = #get_user.is_active#>
  <cfset #admin_id# = #get_user.admin_id#>
  <!--- <cfset the_selected_user = #selected_user#> --->
 </cfif>

  <!--- Check if they wanted to delete a user (from the retrieval form) 
  <cfif #submit# is "Delete User">
    
     <!---  <cfquery username="#db_username#" password="#db_password#" name="delete" dataSource="#DATASOURCE#">
          DELETE FROM users
           WHERE user_id = #user_id#
      </cfquery>
      
      <!--- log account deletion --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Deleted by Administrator"
        details="USER ID: #user_id#"> --->
      
    <!---   <cfset #error_message# = "<font color='0000ff'>Operation successful - User record deleted.</font>"> --->
     <!---  <cfset the_selected_user = #selected_user#> --->
  </cfif>
--->
  <!--- Check if they wanted to delete a user (from the retrieval form) --->
  <cfif #submit# is "Delete">
    
      <cfquery username="#db_username#" password="#db_password#" name="" dataSource="#DATASOURCE#">
          DELETE FROM administrators
           WHERE admin_id = #selected_user#
      </cfquery>
	  
	   <cfquery username="#db_username#" password="#db_password#" name="delete_access" dataSource="#DATASOURCE#">
          DELETE FROM access
           WHERE admin_id = #selected_user#
      </cfquery>
      
      <!--- log account deletion --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Account Deleted by Administrator"
        details="USER ID: #selected_user#">
      
      <cfset #error_message# = "<font color='0000ff'>Operation successful - User record deleted.</font>">
      <!--- <cfset the_selected_user = #selected_user#> --->
	  
	  <cfset #name# = "">
  	  <cfset #login# = "">
  	  <cfset #password# = "">
  </cfif>

 <!--- Run a query to get a list of users --->
 <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
  SELECT login,
         name,
         password, 
         is_active,
		 admin_id
    FROM administrators
 <cfif #isDefined ("search")# and #submit# is "Search">
  <cfif #trim (search)# is not "">
   WHERE name LIKE '%#search#%'
      OR login LIKE '%#search#%'
  <cfelse>
  <!---  WHERE 1=1 --->
  </cfif>
  
 <cfelseif isDefined('selected_user') and selected_user neq 0>
 <cfif submit neq "Delete">
    WHERE admin_id = #selected_user#
	</cfif>
 </cfif>
   ORDER BY name
 </cfquery>

 <!--- <cfif #isDefined ("search")# and #submit# is "Search">
  <cfif #trim (search)# is not "">
  	
  </cfif>
 </cfif> --->
 <cfparam name="selected_user" default = "0">
 
 <cfquery username="#db_username#" password="#db_password#" name="get_active_users" datasource="#DATASOURCE#">
  SELECT login
    FROM administrators
   <!--- WHERE is_active = 1 --->
   ORDER BY login
 </cfquery>

 <!--- Get next admin_id number 
 <cfquery username="#db_username#" password="#db_password#" name="get_max_admin" datasource="#DATASOURCE#">
  SELECT MAX(admin_id)+1 AS next_admin_id
    FROM administrators
 </cfquery>
 --->
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
      <cfset #page# = "admin">
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
               Use this page to administer the administrators in your <i>Auction Server</i> software.  If you do not
               know<br> how to use this administration tool, please <!--- consult your user manual or --->
               click the help button in the upper right corner<br> of this window.
<hr size=1            color=<cfoutput>#heading_color#</cfoutput> width=100%>
              </font>
             </td>
            </tr>
            <tr>
             <td valign="top">
              <form name="userform" action="admin.cfm" method="post">
               <!--- <cfoutput><input type="hidden" name="login" value="#login#"></cfoutput> --->
			   <cfif #submit# is "Retrieve">
			   		<cfoutput><input type="hidden" name="admin_id" value="#admin_id#"></cfoutput>
			   </cfif>
			   <!--- <cfoutput><input type="hidden" name="new_admin_id" value="#get_max_admin.next_admin_id#"></cfoutput> --->
               <!--- <cfoutput><input type="hidden" name="date_registered" value="#date_registered#"></cfoutput>
               <cfoutput><input type="hidden" name="last_login_date" value="#last_login_date#"></cfoutput> --->
               <cfif #error_message# is not ""><cfoutput><font face="helvetica" size=2><b>Status Message:</b> #error_message#</font><br><br></cfoutput></cfif>
               &nbsp;<font face="Helvetica" size=2 color=000080><b>USER INFORMATION:</b><br>&nbsp;<font color="000000">(Fields in <font color="0000ff">blue</font> are required)</font></font>
               <cfoutput>
               <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                <tr>
                 <td>
                  <table border=0 cellspacing=0 cellpadding=2>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>Last Account Created:</b></font></td>
                    <td><font face="helvetica" size=2 color=000000>#dateFormat (now(), 'dd-mmm-yyyy')#</font></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"></td>
                    <td><font face="arial" color=ff0000 size="2">
IMPORTANT: When creating an account the Name and Login must match (including case).<font></td>
                    <td>&nbsp;</td>
                   </tr>
   <!---                <tr>
                    <td align="right"><font face="helvetica" size=2 color=000000><b>User ID ##:</b></font></td>
                    <td><font face="helvetica" size=2 color=000000>#user_id#</font></td>
                    <td>&nbsp;</td>
                   </tr> --->
                   <tr>
                    <td colspan=3>            <hr size=1 color=#heading_color# width=100%> </td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=0000ff><b>Name:</b></font></td>
                    <td><table border=0 cellspacing=0 cellpadding=0><tr><td><input name="name" type="text" size=20 maxlength=65 value="#name#"></td><td>&nbsp;&nbsp;<font face="helvetica" size=2><b><!--- ID ##: ---></b> </font></td></tr></table></td>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=0000ff><b>Login:</b></font></td>
                    <td><input name="login" type="text" size=12 maxlength=12 value="#login#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   
                   <tr>
                    <td align="right"><font face="helvetica" size=2 color=0000ff><b>Password:</b></font></td>
                    <td><input name="password" type="text" size=12 maxlength=12 value="#password#"></td>
                    <td>&nbsp;</td>
                   </tr>
                   
				   <tr><TD align="right"></TD><TD></TD><TD>&nbsp;</TD></tr>
				   <tr><TD align="right"></TD><TD><font face="helvetica" size=1 color=000000>Login name and Password are limited to 12 characters</font></TD><TD>&nbsp;</TD></tr>
				   <TR><TD align="right"></TD><TD></TD><TD>&nbsp;</TD></TR>
                   <tr>
                    <td align="right" valign="top"><font face="helvetica" size=2 color=000000><b>Misc. Flags:</b></font></td>
                    <td>
                     <table border=0 cellspacing=0 cellpadding=0>
                      <tr>
                       <td><input name="is_active" type="checkbox" value="1"<cfif #is_active# is "1"> checked</cfif>></td>
                       <td>&nbsp;&nbsp;<font face="helvetica" size=2 color=000000>User is Active</font></td>
                      </tr>
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
                        SELECT login, admin_id
                          FROM administrators
                         WHERE login = '#login#'
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
                   <tr>                    
                    <td><select name="selected_user" size=15 width=231>
                     <cfif #get_users.recordCount# GT 0>
                      <cfloop query="get_users">
<!---                       <cfoutput><option value=#the_user_id#<cfif #the_user_id# is #user_id#> selected<cfelseif #currentRow# is 1> selected</cfif>><cfif #is_active# is 0>[</cfif>#nickname# (#name#)<cfif #is_active# is 0>]</cfif></option></cfoutput> --->
            <!---            <cfoutput><option value=#name#<cfif #selected_user# is #name#> selected<cfelseif #currentRow# is 1> selected</cfif>><cfif #is_active# is 0>[</cfif>#name#<cfif #is_active# is 0>]</cfif></option></cfoutput> --->

                      <cfoutput><option value="#admin_id#" <cfif #selected_user# is #admin_id#> selected</cfif>><cfif #is_active# is 0>[</cfif>#name#<cfif #is_active# is 0>]</cfif></option></cfoutput>
					  </cfloop>
                     <cfelse>
                      <option value="-1" selected>< empty ></option>
                     </cfif>
                    </select><br><center><font face="helvetica" size=2><i>Inactive users are in [brackets]</i></font></center><br></td>
                   </tr>
                   <cfif #get_users.recordCount# GT 0>
                    <tr>
                     <td>
                      <table border=0 cellspacing=0 cellpadding=0>
                       <tr>                    
                        <td><input type="submit" name="submit" value="Retrieve" width=73></td>
                        <td>&nbsp;<input type="submit" name="submit" value="Disable" width=73</td>
                        <td>&nbsp;<input type="submit" name="submit" value="Delete" width=73></td>
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


<td>






<cfoutput>
<table border=1 width=240 bordercolor=000080 cellspacing=0 cellpadding=2><tr><td>
 <a href="../event5/event.cfm?from=admin">Refresh Category Auction count</a><br> 
<cfif isDefined('refresh_complete')><font face="arial" color=ff0000 size="2"><b>Refresh Complete.</b></cfif></font>

<form  name=duh1 action="../event5/event.cfm" method=post target=_blank>
<font face="arial" color=ff0000 size="1">
The site will be updated every 2 hours. If you want to update the site  manually, please click on the "Refresh" button.(aka  update the number auctions and categories)
</font>
<br><br>
<input type="submit" value="Refresh">
</form>
<form  name=duh3 action="../event1/event.cfm" method=post target=_blank>

<font face="arial" color=ff0000 size="1">
Click on the "Run Event1" button to update the future watch.(aka send out email to users when auctions that match their keyword were posted.)
</font><br><br>
<input type="submit" name="submit2" value="Run Event1">
</form>

<form  name=duh2 action="../event2/event.cfm" method=post target=_blank>

<font face="arial" color=ff0000 size="1">
Click on the "Run Event2" button to manually relist expired auctions, send out invoices to users,...etc. (if the scheduled tasks were setup as specified in http://#CGI.SERVER_NAME##VAROOT#/setup.txt and they are working properly, then you don't need to click on this button).
</font><br><br>
<input type="submit" name="submit1" value="Run Event2">
</form>




<form  name=duh2 action="http://#CGI.SERVER_NAME##VAROOT#/clearcache/clearcache.cfm" method=post target=_blank>

<font face="arial" color=ff0000 size="1">
Click on the "Delete cached files" button to manually update the site. This is the same as when you click on the "Refresh" button; however, it's a lot faster.
</font><br><br>

<input type="submit" name="submit3" value="Delete Cached Files">
</form>
<!--- 
<form  name=duh4 action="gen_all_cats.cfm" method=post target=_blank>

<font face="arial" color=ff0000 size="1">
Click on the "Update categories" button to manually update the categories.
</font><br><br>
<input type="submit" name="submit1" value="Update categories page">
</form>
 --->

<!---
<hr>
 --->

</td></tr>





</td></tr>
               </table>
</cfoutput>

</td>
           </tr>











          </table>


         </td>
        </tr>


       </table>


<!---


<cfoutput>
<table border=0 width=240 cellspacing=0 cellpadding=2><tr><td>
<!--- <a href="../event5/event.cfm?from=admin">Refresh</a><br> --->
<cfif isDefined('refresh_complete')><font face="arial" color=ff0000 size="2"><b>Refresh Complete.</b></cfif></font>

<form  name=duh1 action="../event5/event.cfm" method=post >
<font face="arial" color=ff0000 size="1">
The site will be updated every 2 hours. If you want to update the site  manually, please click on the "Refresh" button.(aka  update the number auctions and categories)
</font>
<br><br>
<input type="submit" value="Refresh">
</form>
<form  name=duh3 action="../event1/event.cfm" method=post>

<font face="arial" color=ff0000 size="1">
Click on the "Run Event1" button to update the future watch.(aka send out email to users when auctions that match their keyword were posted.)
</font><br><br>
<input type="submit" name="submit2" value="Run Event1">
</form>

<form  name=duh2 action="../event2/event.cfm" method=post>

<font face="arial" color=ff0000 size="1">
Click on the "Run Event2" button to manually relist expired auctions, send out invoices to users,...etc. (if the scheduled tasks were setup as specified in http://#CGI.SERVER_NAME##VAROOT#/setup.txt and they are working properly, then you don't need to click on this button).
</font><br><br>
<input type="submit" name="submit1" value="Run Event2">
</form>




<form  name=duh2 action="http://#CGI.SERVER_NAME##VAROOT#/clearcache/clearcache.cfm" method=post>

<font face="arial" color=ff0000 size="1">
Click on the "Delete cached files" button to manually update the site. This is the same as when you click on the "Refresh" button; however, it's a lot faster.
</font><br><br>

<input type="submit" name="submit3" value="Delete Cached Files">
</form>

<form  name=duh4 action="gen_all_cats.cfm" method=post>

<font face="arial" color=ff0000 size="1">
Click on the "Update categories" button to manually update the categories.
</font><br><br>
<input type="submit" name="submit1" value="Update categories page">
</form>


<!---
<hr>
 --->

</td></tr>


<hr size=1     color=<cfoutput>#heading_color#</cfoutput> width=80%>


</td></tr>
               </table>
</cfoutput>



--->


      </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>
