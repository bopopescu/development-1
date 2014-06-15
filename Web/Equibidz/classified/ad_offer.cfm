<!--- add_offer.cfm
      Make an offer on an ad
--->

<cfinclude template = "../includes/app_globals.cfm">

<!--- Check for return to listings --->
<cfif IsDefined("return")>
<cflocation url="index.cfm">
</cfif>

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">

<!--- Set Session variables --->

<!---
<cfif IsDefined("user_id")>
<cfset session.user_id=#user_id#>
</cfif>



<cfif IsDefined("password")>
<cfset session.password=#password#>
</cfif>
--->
<cfif IsDefined("adnum")>
<cfset session.user_id=#user_id#>
</cfif>
<cfif IsDefined("offer")>
<cfset session.offer=REReplace("#offer#", "[^0123456789.]", "", "ALL")>
</cfif>

 <!--- Check for valid login & password --->
  <cfquery name="check_login" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
      SELECT user_id, is_active,password,nickname
        FROM users
       WHERE 
<cfif isdefined("session.user_id") and session.user_id is not "" and isdefined("session.password") and session.password is not "">
user_id =#session.user_id# and password = '#session.password#'
<cfelse>

       <cfif #isNumeric(user_id)#>
               user_id = #user_id# 
       <cfelse>
 nickname = '#user_id#'            
       </cfif>
         AND password = '#password#'
</cfif>

  </cfquery>
<cfquery NAME="getOffers" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT offer FROM ad_offers
     WHERE adnum = #adnum#
     ORDER BY offer DESC
</cfquery>

<cfset session.error_message = "">

<cfif #check_login.recordcount#>

<cfset session.user_id =#check_login.user_id# >
<cfset session.password =#check_login.password# >
</cfif>
<cfif #check_login.recordcount# is 0>
   <cfset #session.error_message# = "<font color=ff0000>Login incorrect. Please try again.</font>">
<cfelseif #session.offer# LTE 0>
   <cfset #session.error_message# = "<font color=ff0000>You must enter a number greater than Zero for your offer.</font>">

</cfif>

<cfif #session.error_message# IS NOT "">
<cflocation url="ad_details.cfm">
</cfif>

<cfquery name="insert_offer" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
INSERT INTO ad_offers
         (adnum,
          offer,
          user_id)
  VALUES (#session.adnum#,
          #session.offer#,
          #check_login.user_id#)
</cfquery>

<cfquery name="get_ad_info" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT adnum,
       title,
       status,
       user_id,
       category1,
       ad_body,
       ask_price,
       picture_url,
       date_start,
       date_end,
       community_ad
  FROM ad_info
 WHERE adnum=#adnum#
</cfquery>

<cfquery name="get_offer_info" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#" maxrows="1">
select offer, user_id
FROM ad_offers
WHERE adnum=#adnum#
ORDER BY offer DESC
</cfquery>

<cfif get_offer_info.recordcount IS 0>
<cfset cur_offer="No Offers">
<cfset offer_id="">

<cfelse>

<cfset cur_offer=#get_offer_info.offer#>

<cfquery name="convert_id" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT nickname
FROM users
WHERE user_id=#get_offer_info.user_id#
</cfquery>

<cfset offer_id=#convert_id.nickname#>
</cfif>

<cfquery name="get_cat_name" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT name
FROM categories
WHERE category=#get_ad_info.category1#
</cfquery>

<cfquery name="get_seller_email" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT email, nickname
FROM users
WHERE user_id=#get_ad_info.user_id#
</cfquery>

<cfquery name="get_offer_email" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT email, name
FROM users
WHERE user_id=#check_login.user_id#
</cfquery>

<!-- get currency type -->
<cfquery name="getCurrency" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
    SELECT pair AS type
      FROM defaults
     WHERE name = 'site_currency'
</cfquery>



<CFMAIL TO="#get_seller_email.email#" FROM="#get_offer_email.email#" SUBJECT="You have an offer on #get_ad_info.title#">
#get_offer_email.name# has made an offer of #session.offer# #getCurrency.type# on  #get_ad_info.title#.

You may contact him/her at mailto:#get_offer_email.email#.

Thank you for advertising with #company_name#.
</CFMAIL>

<HTML>
<HEAD>
<TITLE>Classified Ad Offer</TITLE>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel=stylesheet href="../includes/stylesheet.css" type="text/css">
</HEAD>
<body><cfoutput>
<cfinclude template = "../includes/menu_bar.cfm">
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=#get_layout.page_width#>
  <tr>

    <td colspan="2" align="center" valign="top"> <div align="center"><font size="2"></font></div></td>
  </tr>
  <tr>
    <td width="28%" colspan="3" align="center" valign="middle"><font size="4"><b><font color="##0000FF">Your Offer Has been Entered</font></b></font></td>
  </tr>
  <tr>
    <td colspan="3" height="52"><font face="arial" color="blue">Ad Number:</font> <font face="arial" color="black">#get_ad_info.adnum#</font><br><font face="arial" color="blue" size="+1">Title: </font><font face="arial" color="black" size="+1">#get_ad_info.title#</font><cfif #get_ad_info.community_ad# IS 1><br>This ad is brought to you as a community service</cfif><br><hr width=100% size=1 color="#heading_color#" noshade><cfif IsDefined("session.error_message")><cfif #session.error_message# IS NOT ""><br>#session.error_message#</cfif></cfif><br>Category: #get_cat_name.name#<br></td>
  </tr>
  <tr>
    <td align="left" valign="top" colspan="2" height="52">Ad Body:<hr width=100% size=1 color="#heading_color#" noshade>#get_ad_info.ad_body# <cfif #Len(get_ad_info.picture_url)# GT 7><br><img src="#get_ad_info.picture_url#" border="0"></cfif></td>
    <td align="left" valign="top" height="52">Ad Ends: #TimeFormat("#get_ad_info.date_end#", 'hh:mm:sstt')# #DateFormat("#get_ad_info.date_end#", "mm/dd/yyyy")# <hr width=100% size=1 color="#heading_color#" noshade>Asking Price: #numberFormat(get_ad_info.ask_price,numbermask)#&nbsp;&nbsp;<font size="-1">Contact seller: <a href="mailto:#get_seller_email.email#">#get_seller_email.nickname#</a><hr width=100% size=1 color="#heading_color#" noshade>Current Offer: &nbsp;&nbsp;<cfif IsNumeric(cur_offer)>#numberFormat(cur_offer,numbermask)#<cfelse>#cur_offer#</cfif></td>
  </tr>
  <tr>
    <td colspan="3" width="100%"><form action="ad_offer.cfm" method="get"><input type="submit" name="return" value="Return to Listings"></form>&nbsp;</td>
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
      </table></cfoutput></div>


</body>
</html>
