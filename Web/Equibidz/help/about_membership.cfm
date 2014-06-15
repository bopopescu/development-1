<!--- include globals --->

<cfset current_page="help">
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

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

<html>
 <head>
  <title>About Membership</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
 <cfinclude template="../includes/bodytag.html">
 <cfinclude template="../includes/menu_bar.cfm">
 
 
    
  <!--- The main table --->
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><b>About Membership</b></font></td></tr>
    <tr><td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td></tr>
    <tr>
     <td>


<table border=1 cellspacing=0 cellpadding=2 width=100%>

<cfoutput>
<tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#">
<b>To Become A Member</b></td></tr>
<tr>
<td>
<!--- enter content here --->
Log in to your <a href="#varoot#/personal/">Personal Page</a>, then select View/Edit your personal information.  
Be sure to select which form of payment you will be using.
<br><br>

				<cfloop query="get_memberships">
				  <cfset membership_fee = listgetat(pair,1,"_")>
				  <cfset membership_rate = listgetat(pair,2,"_")>
				  <cfset membership_name = listgetat(pair,3,"_")>
				  <cfset membership_cycle = listgetat(pair,4,"_")>
				  <b>#membership_name#</b> #membership_rate#% discount, #membership_fee# #getCurrency.type# fee for #membership_cycle# membership<br>
				</cfloop>
</td>
</tr>

</table></td></tr></table>

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
   </div></cfoutput>
</center>
</body>
</html>
