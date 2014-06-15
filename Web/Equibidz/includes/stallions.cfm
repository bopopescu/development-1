<cfsetting enablecfoutputonly="yes">
<!---
	Stallions Page:



--->


<!--- include globals --->
<cfinclude template="includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="functions/timenow.cfm">

<!--- Get their info if they're logged in --->
<cfif #isDefined ("session.nickname")#>
  <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
      SELECT user_id,
             nickname,
             name,
             password,
             email
        FROM users
       WHERE nickname = '#session.nickname#'
  </cfquery>
  
  <cfset temp_var = find (" ", get_user_info.name) - 1>
  <cfif temp_var lt 0>
    <cfset not_less_than_one = 1>
  <cfelse>
    <cfset not_less_than_one = temp_var>
  </cfif>
  
  <cfset user_fname = left (get_user_info.name, not_less_than_one)>
<cfelse>
  <cfset #user_fname# = "">
</cfif>

<cfoutput>
<html>
<head>
	<title>Stallions Page</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>
<cfinclude template="includes/menu_bar.cfm"> 

<body>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td align="center">
		
			<!--- Start: Main Body --->
			<table border='0' width='800' style="background-image: url('images/bg_table.jpg')" cellpadding="0" cellspacing="0">
			<tr>
				<td height="20"></td>
			</tr>
			<tr>
				<td align='center' valign='top'>
					<!--- The main table --->
					<table border='0' cellspacing='0' cellpadding='3' width='800' style="color:white;">
					<tr>
						<td colspan='2'>Chocolate Chic Olena (Entry 772) - Stallion Services</td>
					</tr>
					<tr>
						<td colspan='2'><hr /></td>
					</tr>
					<tr>
						<td align='center' valign='top'>
							<img src='/images/horse2.jpg'>
							
							<div style='border:1px solid white; margin-top:10px; padding:5px;'>
								Chocolate Chic Olena is an AQHA 1993 chestnut stallion.
							</div>
							
							<div style='border:1px solid white; margin-top:10px; padding:5px;'>
								Auction Info:<br />
							</div>						
						</td>
						<td width='250' valign='top'>
							<div style='border:1px solid white; margin-top:10px; padding:5px;'>
								$500 USD <input type='button' value='Buy Now'>
							</div>
							<div style='border:1px solid white; margin-top:10px; padding:5px;'>
								Time remaining:<br />
								159 day(s), 9 hour(s)
							</div>
							<div style='border:1px solid white; margin-top:10px; padding:5px;'>
								<a href=''>Add to watch list</a><br />
								<a href=''>Tell a friend</a><br />
								<a href=''>Share this</a><br />
							</div>	
							<div style='border:1px solid white; margin-top:10px; padding:5px;'>
								Seller Info:<br />
								Phone: (651) 433 - 5051<br />
								Forest Lake MN 55025<br />
								United States<br />
								<a href=''>Contact Seller</a><br />
								<a href=''>Website</a><br />
								<a href=''>Seller's Terms</a><br />
							</div>	
						</td>
					</tr>
					<tr>
						<td colspan='2' valign='top'>
							<hr />
							<ul>
								<li>The end time of this listing will extend as long as active bidding contiues.</li>
								<li>Seller accepts: Check, Money Order, Bank Transfer.</li>
								<li>Pyaments must be by check, wire transfer (foreign transactions only) or money order, paid to NCRHA within two weeks of the end of the sale. We cannot accept credit card payments.</li>
								<li>Complete payment information will be sent to the winning bidder by email when the bidding closes.</li>
								<li>Unsold listings are now available for immediate purchase through this website.</li>
							</ul>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="50"></td>
			</tr>
			<tr>
				<td>
					<cfinclude template="includes/copyrights.cfm">
				</td>
			</tr>			
			</table>
		</td>
	</tr>
	</table>			
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
