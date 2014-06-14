
<html>
 <head>
  <title>Visual Auction Server Administrator [Access Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <!--- Check for access permission. --->
<cfquery username="#db_username#" password="#db_password#" name="check_access" datasource="#DATASOURCE#">
 SELECT access_access
   FROM access
  WHERE login = '#Trim(session.username)#'
    AND is_active = 1
</cfquery>

	<CFIF check_access.access_access EQ 0>
		<cflocation url="./access_error.cfm?access_cat=Access.">
	</cfif>
 
 
 <cfsetting EnableCFOutputOnly="YES">

 <!--- Set a default value for "submit" if nonexistent --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "enter">
 </cfif>
 
 <cfif #isDefined ("adminaccess")# is 1>
  <cfset #p_adminaccess# = "1">
 <cfelse>
  <cfset #p_adminaccess# = "0">
 </cfif>
 <cfif #isDefined ("defaultsaccess")# is 1>
  <cfset #p_defaultsaccess# = "1">
 <cfelse>
  <cfset #p_defaultsaccess# = "0">
 </cfif>
 <cfif #isDefined ("usersaccess")# is 1>
  <cfset #p_usersaccess# = "1">
 <cfelse>
  <cfset #p_usersaccess# = "0">
 </cfif>
 <cfif #isDefined ("accountsaccess")# is 1>
  <cfset #p_accountsaccess# = "1">
 <cfelse>
  <cfset #p_accountsaccess# = "0">
 </cfif>
 <cfif #isDefined ("categoriesaccess")# is 1>
  <cfset #p_categoriesaccess# = "1">
 <cfelse>
  <cfset #p_categoriesaccess# = "0">
 </cfif>
 <cfif #isDefined ("auctionsaccess")# is 1>
  <cfset #p_auctionsaccess# = "1">
 <cfelse>
  <cfset #p_auctionsaccess# = "0">
 </cfif>
 <cfif #isDefined ("siteinfoaccess")# is 1>
  <cfset #p_siteinfoaccess# = "1">
 <cfelse>
  <cfset #p_siteinfoaccess# = "0">
 </cfif>
 <cfif #isDefined ("reportsaccess")# is 1>
  <cfset #p_reportsaccess# = "1">
 <cfelse>
  <cfset #p_reportsaccess# = "0">
 </cfif>
<cfif #isDefined ("supportaccess")# is 1>
  <cfset #p_supportaccess# = "1">
 <cfelse>
  <cfset #p_supportaccess# = "0">
 </cfif>

<cfif #isDefined ("banneraccess")# is 1>
  <cfset #p_banneraccess# = "1">
 <cfelse>
  <cfset #p_banneraccess# = "0">
 </cfif>

 <cfif #isDefined ("classifiedaccess")# is 1>
  <cfset #p_classifiedaccess# = "1">
 <cfelse>
  <cfset #p_classifiedaccess# = "0">
 </cfif>
 <cfif #isDefined ("accessaccess")# is 1>
  <cfset #p_accessaccess# = "1">
 <cfelse>
  <cfset #p_accessaccess# = "0">
 </cfif>
<cfif #isDefined ("isactive")# is 1>
  <cfset #p_isactive# = "1">
 <cfelse>
  <cfset #p_isactive# = "0">
 </cfif>

 
<!--- Set defaults for the user id --->
 <cfif #isDefined ("user_id")# is 0>
  <cfset #p_user_id# = "Non matching char string.">
 <cfelse>
  <cfset #p_user_id# = "#Trim(user_id)#">
  <cfquery username="#db_username#" password="#db_password#" name="accessexists" datasource="#DATASOURCE#">
          SELECT  	name
          FROM		access
		  WHERE		name = '#Trim(p_user_id)#'
		  OR login = '#session.username#'
  </cfquery>
  
  <CFIF #accessexists.recordcount# EQ 0>
  
   <cfquery username="#db_username#" password="#db_password#" name="getadinfo" datasource="#DATASOURCE#">
  		SELECT	name, login
		FROM	administrators
		WHERE	name = '#Trim(p_user_id)#' 
	</cfquery>
  
  	<cfquery username="#db_username#" password="#db_password#" name="insertaccess" datasource="#DATASOURCE#">
  		INSERT INTO access 
		(name,login,admin_access,defaults_access,
		users_access,accounts_access,
		categories_access,auctions_access,
		siteinfo_access,reports_access,access_access,is_active,support_access,banneraccess) 
		VALUES 
		('#Trim(getadinfo.name)#','#Trim(getadinfo.login)#','1','0','0','0','0','0','0','0','0','1','0','0')
	</cfquery>
  </cfif>
  
 </cfif>
 
 <!--- Set a default for "error_message" --->
 <cfset #error_message# = "<font color='0000ff'>Operation successful - Categories retrieved.</font>">
	
	<!--- Get existing administrator info. --->
    <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
        SELECT * FROM administrators
		<!---<CFIF #Trim(p_user_id)# NEQ "Non matching char string.">
			WHERE name = '#Trim(p_user_id)#'
		</cfif>
--->
    </cfquery>
    
    <cfif #trim (submit)# is "Update">
	  <!--- Update the new access into the database --->
      <cfquery username="#db_username#" password="#db_password#" name="update_access" datasource="#DATASOURCE#">
          UPDATE	access
          SET		admin_access = '#p_adminaccess#',
		  			defaults_access = '#p_defaultsaccess#',
					users_access = '#p_usersaccess#',
					accounts_access = '#p_accountsaccess#',
					categories_access = '#p_categoriesaccess#',
					auctions_access = '#p_auctionsaccess#',
					siteinfo_access = '#p_siteinfoaccess#',
					reports_access = '#p_reportsaccess#',
support_access = '#p_supportaccess#',
					classified_access = '#p_classifiedaccess#',
					banner_access = '#p_banneraccess#',
					access_access = '#p_accessaccess#',
					is_active = '1'
		 WHERE		name = '#Trim(p_user_id)#'
      </cfquery>
	  
	  <!--- log change of access --->
      <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Access changed"
      details="Access changed for #p_user_id#">
      
    <cfset #error_message# = "<font color='0000ff'>Operation successful - 1 category added.</font>">
  </cfif>
      
  <!--- Get existing access info. --->
    <cfquery username="#db_username#" password="#db_password#" name="get_access" datasource="#DATASOURCE#" maxrows=1>
        SELECT * 
		FROM access 
		WHERE name = '#Trim(p_user_id)#'
    </cfquery>
  
 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 <body bgcolor=ffffff>
  <form name="CatForm" action="./access.cfm" method="post">
  	<cfoutput><input type="Hidden" name="isactive" value="#get_access.is_active#"></cfoutput>
   <font face="helvetica" size=2>
    <center>

     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0>
      <tr bgcolor=0c546c>
       <td bgcolor=ffffff><img border=0 src="./images/left.gif"></td>
       <td><img border=0 src="./images/top_banner.gif"></td>
       <td><img border=0 src="./images/header_fill.gif" width=124 height=25></td>
<!--- old code --->
 		<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td bgcolor=ffffff><img border=0 src="./images/right.gif"></td> 

<!--- New code 
<td><img border=0 src="./images/help.gif"><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
--->
      </tr>

      <!--- Include the menubar --->
      <cfset #page# = "access">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=a9ccd7>

        <!--- A table encapsulating the main page content;
              with a thin black border --->
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=3 width=100%>
         <tr>
          <td>
           <font face="helvetica" size=2 color=000000>
            Use this page to allow access to  certain section(s) in your
            Visual Auction Administrator.<br>This is necessary when you have multiple site administrators.                        <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> 
           </font>
           <br>
		   <!--- <CFIF #p_user_id# EQ "Non matching char string.">
			<cfoutput>#p_user_id#</cfoutput>
		   <CFELSE>
		   	<cfoutput>#p_user_id#,#accessexists.recordcount#,#get_access.recordcount#,#submit#</cfoutput>
		   </cfif> --->
           &nbsp;<font face="Helvetica" size=2 color=000080><b>ACCESS:</b></font>
           <!--- The main table with the dark blue border;
                 encapsulates the category stuff --->
           <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
            <tr>
             <td>
                <table border=0 cellspacing=0 cellpadding=2> 
                 <tr bgcolor=badde8>
                  <td><font face="helvetica" size=2><b>User Name </b></font></td>
                  <td width=5>&nbsp;</td>
                  <td><font face="helvetica" size=2><b>Feature</b></font></td>
                  <td width=5>&nbsp;</td>
                  <td><font face="helvetica" size=2><b>Access </b></font></td>
                  <td width=5>&nbsp;</td>
                  
                  <td colspan=2></td>
                 </tr>
				 
                 <tr>
                    <td><select name="user_id" size=1>
                          <cfif #get_users.recordcount# gt 0>
                           <cfloop query="get_users">
                            <cfoutput><option value="#Trim(name)#"<cfif #name# EQ #Trim(p_user_id)#> selected</cfif>>&nbsp;#name#</option></cfoutput>
                           </cfloop>
                          <cfelse>
                           <cfoutput><option value="-1" selected>< empty ></option></cfoutput>
                          </cfif>
                         </select></td>
						 
					<!--- <td>&nbsp;</td>
                    <td></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr>  --->
				 
					<cfoutput query="get_access">
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Admins</font></td>
                    <td>&nbsp;</td>
                    <!--- <td><input name="adminaccess" type="checkbox" <cfif #admin_access# gt 0 >checked</cfif>></td>  --->
					<td><!--- <cfif #admin_id# is 105><input name="adminaccess" type=hidden value="1">&nbsp;N/A<!--- <img src="#VAROOT#/images/blue_checked.jpg"> ---><cfelse> ---><input name="adminaccess" type="checkbox" <cfif #admin_access# gt 0 >checked</cfif>><!--- </cfif> ---></td> 
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Defaults</font></td>
                    <td>&nbsp;</td>
                    <td><input name="defaultsaccess" type="checkbox" <cfif #defaults_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Users</font></td>
                    <td>&nbsp;</td>
                    <td><input name="usersaccess" type="checkbox" <cfif #users_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Accounts</font></td>
                    <td>&nbsp;</td>
                    <td><input name="accountsaccess" type="checkbox" <cfif #accounts_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Categories</font></td>
                    <td>&nbsp;</td>
                    <td><input name="categoriesaccess" type="checkbox" <cfif #categories_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Auctions</font></td>
                    <td>&nbsp;</td>
                    <td><input name="auctionsaccess" type="checkbox" <cfif #auctions_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Site Info</font></td>
                    <td>&nbsp;</td>
                    <td><input name="siteinfoaccess" type="checkbox" <cfif #siteinfo_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Reports</font></td>
                    <td>&nbsp;</td>
                    <td><input name="reportsaccess" type="checkbox" <cfif #reports_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr>

				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Support</font></td>
                    <td>&nbsp;</td>
                    <td><input name="supportaccess" type="checkbox" <cfif #support_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr>



 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Banners</font></td>
                    <td>&nbsp;</td>
                    <td><input name="banneraccess" type="checkbox" <cfif #banner_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr>
			<cfif classified_valid is "Yes">
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Classified</font></td>
                    <td>&nbsp;</td>
                    <td><input name="classifiedaccess" type="checkbox" <cfif #classified_access# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr>
			</cfif>
				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Access</font></td>
                    <td>&nbsp;</td>
                    <!--- <td><input name="accessaccess" type="checkbox" <cfif #access_access# gt 0 >checked</cfif>></td>   --->
					<td><!--- <cfif #admin_id# is 105><input name="accessaccess" type=hidden value="1">&nbsp;N/A<!--- <img src ="#VAROOT#/images/blue_checked.jpg"> ---><cfelse> ---><input name="accessaccess" type="checkbox" <cfif #access_access# gt 0 >checked</cfif>><!--- </cfif> ---></td>  
					
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr> 
<!--- 				 <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>Active</font></td>
                    <td>&nbsp;</td>
                    <td><input name="isactive" type="checkbox" <cfif #is_active# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                 </tr>  --->
				 </cfoutput>
	
                 <tr>
				  <td><input name="submit" type="submit" value="Retrieve"></td>
				  <td></td>
				  <td><input name="submit" type="submit" value="Update"></td>
				  <td></td>
				  <td><input type="reset" value="Undo"></td>
				  <td></td>
				  <td></td>
                 </tr>

                 </td>
                </table>
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
  </form>
 </body>
</html>
