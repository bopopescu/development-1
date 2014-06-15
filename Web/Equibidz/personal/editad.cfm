<!--- /classified/editad.cfm
      Personal Page: Edit a Classified Ad
--->
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  
 

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 

 <!--- Get the listing background color --->
 <cfquery name="get_listing_bgcolor" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#>

 <!--- Verify their username and password --->
 <cfif (#IsDefined ("submit")#)>
  <cfif #trim (submit)# is "Next >>">
   <cfquery name="verify_login" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT user_id
      FROM users
     WHERE nickname = '#user_id#'
     <cfif #isNumeric (user_id)#>
        OR user_id = #user_id#
     </cfif>
       AND password = '#password#'
	   and is_active = 1
   </cfquery>
   <cfif not #verify_login.recordCount#>
    <cflocation url="index.cfm?failed=1">
   <cfelse>
    <cfset #session.user_id# = #verify_login.user_id#>
    <cfset #session.password# = #password#>
   </cfif>
  </cfif>
 </cfif>

 <!--- Resolves a nickname into a userid ---><!--- **** --->
 <cfif not #isDefined ("session.user_id")#>
  <cflocation url="index.cfm">
 </cfif>
 
<!---  <cfif not IsNumeric("session.user_id")>
  <cfquery name="getUserId" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
   SELECT user_id
     FROM users
    WHERE nickname = '#session.user_id#'
  </cfquery>
  <cfset user_id = getUserID.user_id>
 </cfif>
 --->
 <!--- Get a list of their expired ads --->
<!--- ****Test
<cfoutput><pre>
  SELECT adnum, title
    FROM ad_info
   WHERE user_id = #session.user_id#
     AND status=1
	    AND date_end > #CreateODBCDate (now ())#
   ORDER BY title
</pre></cfoutput>
 --->
 <cfquery name="get_ads" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT adnum, title
    FROM ad_info
   WHERE user_id = #session.user_id#
     AND status=1
	    AND date_end > #CreateODBCDate (now ())#
   ORDER BY title
 </cfquery>
 
 <cfoutput>

<html>
 <head>
  <title>Personal Page: Edit a Classified Ad</title>
  <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/menu_bar.cfm">
   <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
   
    <tr><td><font size=4 color="000000"><b>Personal Page - Edit Your Active Classified Ads</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
	   This page will allow you to edit an ad you currently have running.
       Just select an ad from the list below and click the "Continue"
       button.  You will then see the page you saw when you originally
       ran your ad, where you may make changes.<!--- change most of the information about your
       item.  Please note that you will not be able to change some information such as the item number and title. --->
       <br><br>
       <b>Please select an ad from the following list (#get_ads.recordcount# ads found):</b><br>
       </cfoutput>
       <form action="editad_info.cfm" method="post">
        <select name="adnum" size=10 width=300>         
         <cfoutput query="get_ads">
          <option value="#adnum#"<cfif #currentrow# is 1> selected</cfif>>#title#&nbsp;&nbsp;(#adnum#)<!---<cfset #adnum#=#adnum#><cfset #session.title#=#title#>---> </option>
         </cfoutput>
		</select>
		<cfif #get_ads.recordcount# GT 0>
         <br><br>
		<!---<cfset session.adnum = "#adnum#">--->
		<input type="submit" name="submit" value="Edit">         
        </cfif>
       </form>
       <cfoutput>
       <br>
      </font>
     </td>
    </tr>
    </table>
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

