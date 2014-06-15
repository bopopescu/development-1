<!--- classified/post_ad.cfm
	Inserts ad into database;
	runs billing( bill_adver.cfm );
	sends confirm email.
	04/28/00 
	classified ver 1.0a 
--->


<cfinclude template = "../includes/app_globals.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Setup Session Information --->
<cfinclude template="../includes/session_include.cfm">


<!--- Include Global variables --->
<cfinclude template="../includes/global_vars.cfm">

<cfquery name="getCols" datasource="#DATASOURCE#" maxrows=1 dbtype="ODBC">SELECT * FROM adv_info</cfquery>

<cfquery name="get_user" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT user_id, email, cc_number, cc_name, cc_expiration, name, nickname
  FROM users
  WHERE user_id=#session.user_id#
</cfquery>

<cfif IsDefined("post")>
  <cfset session.user_id=#session.user_id#>
  <cfset session.adnum="">
  <cfset session.title="">
  <cfset session.date_start = "#timenow#">
  <cfset session.duration="">
  <cfset session.set_session=0>
  <cflocation url="index.cfm">

<cfelseif IsDefined("home")>
  <cflocation url="../index.cfm">
</cfif>

<cfif IsDefined("back")>
  <cflocation url="index.cfm">
<cfelse> 
  <cfset user_id=#session.user_id#>
  <cfset adnum=#session.adnum#>
  <cfset title=#session.title#>
  <cfset date_start=#session.date_start#>
  <cfset duration=#session.duration#>
  <cfset picture=#session.picture#>
 </cfif>
 
<cfset date_start=#date_start#>
<cfset date_end=#DateAdd("m","#duration#","#date_start#")#>

<cfif IsNumeric("session.user_id") IS 0>
  <cfquery name="get_user_info" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
  SELECT user_id, email, cc_number, cc_name, cc_expiration
  FROM users
  WHERE nickname='#session.nickname#'
 </cfquery>

 <cfset user_id = get_user_info.user_id>
</cfif>

<cfquery name="get_fee" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#" maxrows="1">
  SELECT ad_fee
  FROM adv_defaults
  WHERE ad_dur = #duration#
</cfquery>

<cfquery name="check_doubleSubmit" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
   SELECT adnum FROM adv_info
   WHERE adnum=#adnum#
</cfquery>

<cfif check_doubleSubmit.RecordCount IS NOT 0>

<cfoutput>
<html>
  <head>
    <title>Duplicate Ad</title>
    
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/menu_bar.cfm">





<table align="center"  cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td>

    <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=700>
<tr>
<td>
<center>

</td>
</tr>
        <tr>
          <td><font size=4><b>Duplicate Ad</b></font></td>
        </tr>
        <tr>
          <td>            <hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
        </tr>
        




<tr>
  <td colspan="2" align="left" valign="top">
    <div class="newsheader">
<font size=3>
    You have already submitted your ad.</font></div>

  </div></td>
</tr>


         </table><cfoutput>
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
		</td>
	</tr>
</table>
    
  </body>
</html>
</cfoutput>
  <cfabort>
</cfif>



<cfset billable_fee = get_fee.ad_fee>
<cfparam name="session.picture1" default="">
<cfparam name="session.picture2" default="">
<cfparam name="session.picture3" default="">
<cfparam name="session.picture4" default="">

<!--- insert ad record --->
<cfquery name="store_ad" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
INSERT INTO adv_info
        (adnum,
    date_created,    
    status,
    webaddress,
    user_id,
    picture,
    date_start,
    date_end,
	 ad_dur,
	 ad_fee)
VALUES (#adnum#,
    #timenow#,
    0,
    '#title#',
    #session.user_id#,
    '#picture#',
    #createODBCDateTime (date_start)#,
    #createODBCDateTime (date_end)#,
	 #duration#,
	 #billable_fee#)
</cfquery>

<!---Email Address to receive Ad Request--->
<cfmail to="info@#DOMAIN#" from="#get_user.email#"
        subject="Advertisement Application">
        Please review my application for ad number #adnum#.
    
    User ID Number: #session.user_id#
    
    Web Link for Ad: #title#
    
  Thanks,
    
  #COMPANY_NAME#
</cfmail>


<!--- page layout --->
<html>
<head>
  <title>Advertisment Posting Completed</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
</head>
<cfinclude template = "../includes/bodytag.html">
<cfinclude template = "../includes/menu_bar.cfm">
<table align="center" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td>
<div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
  <tr>    
    <td align="left" valign="top"><br><br><font size="4"><b>Your Advertisement Has Been Submitted.  Please Process Payment Using Pay Now Key Below</b><br>
      <hr width=100% size=1 color="#heading_color#" noshade><br>
    </td>
  </tr>
  <tr>
    <td align="left" valign="middle"><font size="3">You will be adviced thru Email onced your advertisement is approved.<br><br>
  </tr>
  <tr>
    <td align="leftr" height="52"><form action="post_ad.cfm" method="post" ><!---<input type="submit" name="post" value="Post Another Ad">&nbsp;&nbsp;<input type="submit" name="Home" value="Home Page"></form></td>--->
  </tr>
  
  <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="LXYQF43P8WTFE">
<table>
<tr><td><input type="hidden" name="on0" value="Month Duration">Month Duration</td></tr><tr><td><select name="os0">
	<option value="WEB Ad 1 Month">WEB Ad 1 Month $30.00 USD</option>
	<option value="WEB Ad 2 Months">WEB Ad 2 Months $55.00 USD</option>
	<option value="WEB Ad 3 Months">WEB Ad 3 Months $75.00 USD</option>
	<option value="WEB Ad 4 Months">WEB Ad 4 Months $90.00 USD</option>
	<option value="WEB Ad 5 Months">WEB Ad 5 Months $105.00 USD</option>
	<option value="WEB Ad 6 Months">WEB Ad 6 Months $115.00 USD</option>
</select> </td></tr>
</table>
<input type="hidden" name="currency_code" value="USD">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>

  
  
  <tr><td><br><br><br><br><br><br></td></tr>
  </table><cfoutput>
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
</div>
		</td>
	</tr>
</table>
<!-- Log new classified ad into transaction log -->
<cfmodule template="../functions/addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="Advertisement Application"
    itemnum="#Session.adnum#"
    details="#Session.title#"
    user_id="#Session.user_id#">
</BODY>
</HTML>
