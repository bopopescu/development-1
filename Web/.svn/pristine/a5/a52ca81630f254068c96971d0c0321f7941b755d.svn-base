<html>
<head>
	<title>Ad Details Page</title>
  <link rel=stylesheet href="../includes/stylesheet.css" type="text/css">
</head>

<cfinclude template = "../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">

<cfif IsDefined("adnum")>
	<cfset session.adnum = #adnum#>
<cfelse>
	<cfif IsDefined("session.adnum")>
		<cfset adnum=#session.adnum#>
	</cfif>
</cfif>

<cfif IsDefined("session.user_id")>
<cfset user_id = #session.user_id#>
<cfset password = "">
<cfelse>
<cfset user_id = "">
<cfset password= "">
</cfif>
<cfif IsDefined("session.offer")>
<cfset offer=session.offer>
<cfelse>
<cfset offer="">
</cfif>
<!--- Include Global variables --->
<cfinclude template="../includes/global_vars.cfm">

<cfquery name="get_ad_info" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT 	adnum,
		title,
		status,
		user_id,
		category1,
		category2,
		ad_body,
		ask_price,
		obo,
	   	picture_url,
		date_start,
		date_end,
		community_ad,picture1,picture2,picture3,picture4
FROM ad_info
WHERE adnum=#adnum#
</cfquery>

<cfquery name="get_offer_info" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#" maxrows="1">
select offer,
	   user_id
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
 <cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Classified Ad Offer"
    itemnum="#Session.adnum#"
    details="Classified Ad Offer"
    user_id="#user_id#">
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
<cfinclude template = "../includes/bodytag.html">
<cfinclude template = "../includes/menu_bar.cfm">
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=<cfoutput>#get_layout.page_width#</cfoutput>>
  <tr> 

    <td colspan="2" align="center" valign="top"> <div align="center"><font size="2"></font></div></td>
  </tr>
  <tr> 
    <td width="28%" colspan="3" align="center" valign="middle"><font size="4"><b><font color="#0000FF">Ad Details</font></b></font></td>
  </tr>
  <tr> 
    <td colspan="3" height="52"><cfoutput><font face="arial" color="blue">Ad Number:</font> <font face="arial" color="black">#get_ad_info.adnum#</font><br><font face="arial" color="blue" size="+1">Title: </font><font face="arial" color="black" size="+1">#get_ad_info.title#</font><!--<cfif #get_ad_info.community_ad# IS 1><br>This ad is brought to you as a community service</cfif>--><br><hr width=100% size=1 color="#heading_color#" noshade><cfif IsDefined("session.error_message")><cfif #session.error_message# IS NOT ""><br>#session.error_message#</cfif></cfif><br>Category: #get_cat_name.name#<br></cfoutput></td>
  </tr>
  <cfoutput><tr> 
    <td align="left" valign="top" colspan="2" height="52">Ad Body:<hr width=100% size=1 color="#heading_color#" noshade>#get_ad_info.ad_body# <cfif #Len(get_ad_info.picture_url)# GT 7><br><img src="#get_ad_info.picture_url#" border="0"></cfif></td>
    <td align="left" valign="top" width="33%" height="52">Ad Ends: #TimeFormat("#get_ad_info.date_end#", 'hh:mm:sstt')# #DateFormat("#get_ad_info.date_end#", "mm/dd/yyyy")# <hr width=100% size=1 color="#heading_color#" noshade>Asking Price: #numberFormat(get_ad_info.ask_price,numbermask)#&nbsp;&nbsp;<cfif get_ad_info.obo>Or Best Offer</cfif><br>
<font size="-1"><B>Contact seller:</B> <a href="mailto:#get_seller_email.email#">#get_seller_email.nickname#</a><cfif get_ad_info.obo><hr width=100% size=1 color="#heading_color#" noshade>Current Offer: &nbsp;&nbsp;<cfif IsNumeric(cur_offer)>#numberFormat(get_offer_info.offer,numbermask)#<cfelse>#cur_offer#</cfif></cfif></td>
  </tr>

<cfif get_ad_info.picture1 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs/#get_ad_info.picture1#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>


<cfif get_ad_info.picture2 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs0/#get_ad_info.picture2#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>


<cfif get_ad_info.picture3 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs1/#get_ad_info.picture3#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>
<cfif get_ad_info.picture4 is not "">
<tr>
<td>
<img src="#varoot#/classified/fullsize_thumbs2/#get_ad_info.picture4#" border =0>
</td>

</tr>
<tr>
<td>
&nbsp;
</td>
</tr>
</cfif>

</cfoutput>
  
  <tr>
    <CFOUTPUT><td colspan="3" width="100%"><hr width=100% size=1 color="#heading_color#" noshade><form action="ad_offer.cfm" method="post">

<cfif isdefined("session.user_id") and session.user_id is not "" and isdefined("session.password") and session.password is not "">
<input type="hidden" name="user_id" value="#session.user_id#">

<input type="hidden" name="password" value="#session.password#">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Offer Amount: <input type="text" name="offer" value="">&nbsp;&nbsp;<br>
<cfelse>
User Name: <input type="text" name="user_id" value="#user_id#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Offer Amount: <input type="text" name="offer" value="">&nbsp;&nbsp;<br>Password: &nbsp;&nbsp;<input type="password" name="password" value="#password#">
</cfif>
<input type="hidden" name="adnum" value="#get_ad_info.adnum#"><br><br><input type="submit" name="offer_btn" value="Make an Offer">&nbsp;&nbsp;
   
    <input type="submit" name="return" value="Return to Listings"></form>&nbsp;</td></cfoutput>
  </tr>
   
  </table>
<cfoutput>
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
</BODY>
</HTML>