<cfsetting enablecfoutputonly="yes">
<!---
	Help Page:



--->

<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

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
		<title>Help Page</title>
		<meta name="keywords" content="#get_layout.keywords#">
		<meta name="description" content="#get_layout.descriptions#">
		<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	</head>

	<cfinclude template="../includes/bodytag.html">
	<cfinclude template="../includes/menu_bar.cfm"> 
	
	<table border='0' cellspacing='0' cellpadding='0' width='700'>
		<tr>
			<td><font size=4><br><br><b>Help & Auction Tips</b></font></td>
		</tr>
		<tr>
            <td><hr size=1 color="616362" width=100%></td>
		</tr>
		<tr><td>
					<!--- The main table --->
					<div class="body-text">
					<table border='0' cellspacing='0' cellpadding='3' width='700' style="color:white;">
					<tr>
						<td>
							<ol>
								<b><li>Registration</b>
									<p class="p2">Select the BIDDER REGISTRATION link located at the top left of all auction pages and enter your information in the form provided. To be approved for bidding you must also review and agree to the Sale Terms and Conditions.</font><p></li>
								<b><li>User ID</b>
									<p class="p2">After you have registered and been approved for bidding, your User ID and Password will be confirmed by e-mail. Please remember your Password and User ID. Your Password and User ID are valid for this auction only.</font><p></li>
								<b><li>Credit Cards</b>
									<p class="p2">Each bidder is required to submit a credit card number for verification which is a totally secure process. In this way bidders will know that all other bidders using this site are valid and have registered in the same manner.</font><p></li>
								<b><li>Bidding</b> 
									<p class="p2">Each lot has a starting bid posted. Some lots may have reserve bids. You will be notified on the horse�s page if the reserve has or has not been met. Bidding will be open during the time designated on the homepage. Enter your User ID and Password to submit your bid(s). NOTE: During the course of bidding you must REFRESH the page to make sure you are viewing the most current information.</font><p></li>
								<b><li>Bid Increments</b>
									<p class="p2">A bid increment is the minimum amount a bid must be raised. Bid increments are a minimum of $100.00 up to $3,000.00, and a minimum of $250 over $3,000.00. You must bid in these increments or enter a maximum bid amount.</font><p></li>
								<b><li>Maximum Bids</b>
									<p class="p2">A maximum bid is the highest amount you will pay for a horse at a certain time. It is suggested you bid the maximum amount you are willing to pay for a lot because you may be outbid minutes before closing and not be able to enter another bid.</font><p></li>
								<b><li>Absentee Bidding</b>
									<p class="p2">Absentee bidding means a bidder can enter a maximum bid amount and the auction will automatically bid in their absence, executing their bid for them and trying to keep the bid price as low as possible. A bidder doesn't have to watch the auction every minute to make sure they are not outbid. However, when you are the highest bidder and you have been out-bid by another user, you will not receive an email notification so you must monitor the bidding periodically.</font><p></li>
								<b><li>Ending the Auction</b>
									<p class="p2">Bidding will end on the date and time specified on each individual lot in groups of two horses every ten (10) minutes. For example: Lots 1-2 will close at 1:00 pm, Lots 3-4 will close at 1:10 pm, Lots 5-6 will close at 1:20 pm, etc. If bids are received less than one minute apart within 10 minutes of closing time, bidding will be extended five minutes beyond the stated closing time. If a lot number is closed, no more bids will be taken. See lot numbers for exact closing times.</font><p></li>
								<b><li>Winning Bids</b>
									<p class="p2">Winning bidders will be sent a conformation e-mail with payment instructions. If you do not receive a conformation e-mail within 24 hours after the close of the auction please contact our office immediately. The winning bidder�s credit card will immediately be charged a non-refundable amount equal to ten percent (10%) of the selling price plus a three & one-half percent (3.5%) credit card surcharge calculated on the ten percent (10%) dollar amount. The balance of the selling price is due and payable by credit card, check, money order, or cashier�s check to Equbidz no later than the end of the third (3rd) business day after the bidding closes on the last day of the sale.</font><p></li>
								<b><li>For More Information</b>
									<p class="p2">Each lot number includes contact information for the seller. If you have any questions about a horse, need directions to the farm to view a horse or for delivery questions, please contact the seller. We strongly encourage you to contact the seller for more information.</font><p></li>
									<b><li>For Someone to Call</b>
									<p class="p2">Each lot number includes contact information for the seller. If you have any questions about a horse, need directions to the farm to view a horse or for delivery questions, please contact the seller. We strongly encourage you to contact the seller for more information.</font><p></li>
							</ol>						
						</td>
					</tr>
					</table>					
				</td>
			</tr>
					<tr><td align="center">
						<input type="button" name="back" value=" << Back " onClick="JavaScript:history.back(1)"><br><br><br><br>
					</td></tr>					
			</table>		
	<table width=100%>					
			
			<tr>
				<td>
					<hr width='#get_layout.page_width#' size=1 color="#heading_color#" noshade>
				</td>
			</tr>			
			<tr>
				<td align="left">
					<cfinclude template="../includes/copyrights.cfm">
				</td>
			</tr>
	</table>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
