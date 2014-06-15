<cfsetting enablecfoutputonly="yes">
<!---
	New Terms Page:



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
		<title>Terms Page</title>
		<meta name="keywords" content="#get_layout.keywords#">
		<meta name="description" content="#get_layout.descriptions#">
		<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	</head>

	<cfinclude template="includes/bodytag.html">
	<cfinclude template="includes/menu_bar.cfm"> 
	
	<table border='0' cellspacing='0' cellpadding='0' width='700'>
		<tr>
			<td><font size=4><br><br><b>Terms & Condition</b></font></td>
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
								<b><li>Bidder Registration</b>
									<p class="p2">Bidders must be 18 years of age or older to register for this auction. Only persons who can enter into legally binding contracts under applicable law may bid. If you are registering as an agent or using a business name, you represent that you have authority to bind same to these Terms and Conditions.You are responsible for providing accurate registration information that will be used to identify you to this on-line auction and allow Equibidz, LLC to contact you. Please update any change in your contact information immediately. Any error caused by your failure to do so is not the responsibility of Equibidz, LLC. Your personal information will be protected as stated herein under the Privacy Policy. Equibidz, LLC reserves the right to approve/disapprove any bidder application. You will be banned from this site if you provide false registration information.</font><p></li>
								<b><li>Web Site Information</b>
									<p class="p2">Every effort has been made to ensure the correctness of the on-line sale information. Equibidz, LLC believes the descriptions of horses appearing in this on-line auction and in advertising for this auction are correct. Equibidz, LLC is not responsible for errors or omissions either verbal or written and assume no liability for same regarding horses sold. 
Equibidz, LLC is not responsible for the actions of the Owner/Seller and Bidder/Buyers before, during, and after the on-line auction, typographical errors, misprints, loss of money, damage or failure of equipment, due to visits to this site. Use of this site is at Bidders own risk. This on-line auction site contains links to other web sites and Equibidz, LLC is not responsible for their practices or content. 
Broodmares listed in foal to the stallion indicated are reported by the Owner/Seller and it is the Bidder/Buyers responsibility to have the mare vetted. Broodmares listed as exposed to the stallion indicated may or may not be in foal by sale time. The Owner/Seller reserve the right to withdraw a horse after being listed if necessary at any time. 
The Owner/Seller reserves the right to withdraw a lot after being listed if necessary at any time. A lot substitution may be made with the approval of Equibidz, LLC.</font><p></li>
								<b><li>Reserve Price</b>
									<p class="p2">A reserve price is the lowest price at which the lot will be sold however it will not be disclosed to Bidders. When the reserve price has been met it will say Reserve Price Met and then the horse will be sold to the highest bidder. If the reserve price is not met the lot will not be sold.</font><p></li>
								<b><li>Bidding</b> 
									<p class="p2">All bids are in US Dollars. All bidding will be done on the Internet by registered and approved Bidders. You are responsible to monitor bidding activity. You can setup absentee bidding which is listed below. While the pages are refreshed automatically you are advised to also refresh the pages on your own. 
It is suggested you bid the maximum amount you are willing to pay for a horse because you may be outbid minutes before the close of the on-line auction and may not be able to enter another bid. When bidding ends, all sales shall be considered final. There are no exchanges or refunds unless there is a statement to the contrary expressed herein. A bid by any person shall be deemed conclusive proof that such person is familiar with the Terms and Conditions as stated herein and that the Bidder agrees to be bound by them. 
Transmission time varies and bids are time stamped by the host computer with the time received. Bids must be received by the host computer prior to closeout to be accepted. 
Bidder/Buyers acknowledge that this on-line auction is conducted electronically and that Equibidz, LLC and other parties to the on-line auction must therefore rely on hardware and software that may malfunction without warning. In the event of malfunction by the host computer, the on-line auction will be stopped. If the malfunction has not affected the sale prior to the malfunction, the horse will be considered sold. Auction of any remaining horses will be completed upon correction of the malfunction. Bidding on the remaining horses will be open, with no bid positions given until resumption of the auction. Any malfunction by the Bidders computer or Internet service provider is not the responsibility of Equibidz, LLC. 
If a bid is the high/winning bid, that Bidder will be obligated to buy the horse at said price indicated. Placing a bid on this auction site, winning, then not paying for the horse is illegal in most states and prosecution can result. 
As a Bidder, you are responsible for any bids placed by you or your representative under your bidding number and password. The security of your Bidder information is your sole responsibility and the Bidder will be responsible for any and all bids placed under the assigned name and/or number. If, at any time, you feel that your Bidder number and password have been compromised due to lack of security on your part, notify Equibidz, LLC immediately. 
Bidders agree not to interfere or attempt to interfere with the functioning of this auction. Equibidz, LLC reserves the right to void bids believed not to have been made in good faith or are unlawful. A fraudulent bid may result in legal action.</font><p></li>
								<b><li>Absentee Bidding</b>
									<p class="p2">Absentee bidding means a bidder can enter a maximum bid amount and the auction will automatically bid in their absence, executing their bid for them and trying to keep the bid price as low as possible. A bidder doesn't have to watch the auction every minute to make sure they are not outbid. However, when you are the highest bidder and you have been out-bid by another user, you will not receive an email notification so you must monitor the bidding periodically.</font><p></li>
								<b><li>Bid Retractions</b>
									<p class="p2">A submitted bid is non-cancellable. Once a bid is made and confirmed, it cannot be retracted. When a bid is made you manifest your intent and ability to buy the lot at the bid price.</font><p></li>
								<b><li>Bid Closing</b>
									<p class="p2">Bidding will end on the date and time specified on each individual horse. If the auction is closed, no more bids will be taken. The highest bidder shall become the Bidder/Buyer. Title passes immediately to the highset Bidder/Buyer for the horse at the auction closing. At the of a winning auction the Owner/Seller will be responsible for completing the settlement process.The Owner/Seller and the Bidder/Buyer will be provided with the terms of the sale by email. The owner/seller and Bidder/Buyer are responsible to discuss and arange exchange of funds, hauling fees and any other required expense. All bids and purchases are a binding contract between Bidder/Buyer and Owner/Seller and shall be equally binding between both parties.</font><p></li>
								<b><li>Settlement</b>
									<p class="p2">Settlement is in US Dollars. Imediately after a winning auction is closed, the Seller will be invoiced for 5% settlement.  Once the settlement has been received then the seller will receive the sales agreement with all of the contact information for the winning Bidder/Buyer.  Each Bidder/Buyer, following his/her winning bid, will receive an acknowledgement of winning via e-mail.  Any settlement is due and payable to Equibidz, LLC no later than the end of the third (3rd) business day after the bidding closes on the last day of the sale.  If seller has not made payment to Equibidz,LLC within the time frame noted above, it will then be considered a default sale.  Any legal fees that may be incured by Equibidz,LLC including attorney fees and costs, will be the responsibility of the default seller.  Payments of the balance owed may be made through Paypal.  Purchases may be subject to state sales taxes which is the responsibility of the seller and Bidder/Buyer.</font><p></li>
								<b><li>Implied Warranty/Disclaimer</b>
									<p class="p2">Information used or shared in connection with this on-line auction that has been provided by the Owner/Seller is believed to be true and correct. Equibidz, LLC, its owner, agents 
and other representatives are not responsible for any misleading information that is provided in connection with this on-line auction sale. 
Bidder acknowledges that all horses were available for inspection prior to and during the on-line auction. Equibidz, LLC and Owner/Seller recommend that the Bidder inspect each horse in which Bidder has any interest. If Bidder failed to inspect any horse, this failure to inspect, or otherwise be fully informed as to the nature, quality, and condition of the horse, will not constitute grounds for any claim, adjustment, refund, termination of the contract for sale, or refusal to close the sale. These written terms constitute the final expression of the parties agreement and are a complete and exclusive statement of the terms of the contract for sale, or refusal to close the sale. 
Neither descriptions nor claims nor any oral statements concerning lots in this auction made by Equibidz, LLC, its owner, employees, representatives or the Owner/Seller concerning any horse shall be construed as a warranty either express or implied. 
The implied warranties of merchantability and fitness for a particular purpose and all other warranties, either expressed or implied, are specifically excluded from this contract for sale and this transaction and shall not apply to the merchandise that is the subject of this sale and this transaction.</font><p></li>
<b><li>Limit of Liability</b>
									<p class="p2">Equibidz, LLC, its owner, agents and other representatives shall not be liable for lost profits or any special, incidental, or consequential damages whatsoever arising out of or in connection with any sale or transaction. 
Equibidz, LLC through the computer system determines the winning bidders, is the single deciding authority if disputes should arise, and accepts no liability for any errors or omissions. Equibidz, LLC reserves the right to reopen bidding on any disputed bids or ties. 
Equibidz, LLC reserves the right to postpone or cancel a sale without notice if it is determined that such action is appropriate for whatever reason and is at Equibidz, LLCs sole discretion. Equibidz, LLC will neither have liability nor obligation to the intended bidders or consignors as a result of any withdrawal, cancellation, or postponement of the sale. 
Equibidz, LLC does not guarantee continuous or uninterrupted, or secure access to our on-line auction services, and operation of our on-line auction site may be interfered with by numerous factors outside of our control.</font><p></li>							
<b><li>Title and Delivery</b>
									<p class="p2">Title and all risks are assumed immediately by the high Bidder (Bidder/Buyer) after the settlement of the purchase between the Owner/seller. After settlement all risk of death, damage, or injury to each horse becomes the Buyers risk. Upon passage of settlement, Buyer agrees to indemnify and hold either Equibidz, LLC, its owner or employees or the Owner/Seller harmless for all loss, cost and expense arising from the following: (1) the illness, injury or death of purchased animal; (2) loss or damage to property; (3) injury or death of persons caused by purchased animal.  
Transportation is the sole responsibility of the Bidder/Buyer. Contact the Owner/Seller if you have any questions. Any person(s) picking up horses from this sale does so at his own risk.  
Buyer has the right to have a purchase examination done at Buyers expense. Exam must be scheduled at the time of settlement and done within three (3) days from the time of settlement. If a horse is found unsound, horse remains property of Owner/Seller. Contact the Owner/Seller if you have any questions.</font><p></li>								
<b><li>Registration Papers</b>
									<p class="p2">Registration papers, transfers, breeders certificates or registration applications will be transferred to Buyer after all checks, wire transfers, credit card charges and fees have cleared the bank and/or after acceptance of final payment, within 14 business days. Buyer is responsible for any registration and/or transfer fees.</font><p></li>								
<b><li>Heath Papers/Coggins</b>
									<p class="p2">All horses sell with a health certificate issued within 30 days of sale date including a negative test for equine infectious anemia (Coggins test), except for colts under 6 months of age, issued by a licensed veterinarian within 6 months of sale date.</font><p></li>								
<b><li>Default of Purchase</b>
									<p class="p2">If any person shall purchase a horse and fail to pay for it in the manner described above, the Owner/Seller shall have, in addition to all other legal rights, the right to resell the horse, or, at Owner/Seller’s option, bring an action for specific performance, in which event the defaulting Buyer agrees to pay all costs of such suit, together with all reasonable attorneys fees and expenses. In the event of a resale, the defaulting Buyer agrees to pay all costs of resale, plus any deficiency between the original purchase price and the total price upon resale. If Buyer brings a lawsuit against Equibidz, LLC and does not prevail, Buyer will reimburse Equibidz, LLC for all reasonable legal fees and expenses incurred in connection with said suit.
									</font><p></li>							
<b><li>Indemnification</b>
									<p class="p2">Bidders, Buyers and Owner/Sellers agree to indemnify and hold this on-line auction site, its owner, employees, and representatives harmless from any claim or demand, including reasonable attorneys fees, made by any third party due to or arising out of Bidders and Owner/Sellers use of the on-line auction service, the violation of these terms of service, the infringement of the service using Bidders computer, or of any intellectual property or other right of any person or entity.
									</font><p></li>								
<b><li>No Agency</b>
									<p class="p2">Bidder, Buyer, Owner/Seller and Equibidz, LLC are independent contractors, and no agency, partnership, joint venture, employee-employer, or franchiser-franchisee relationship is intended or created by agreeing to these Terms and Conditions.</font><p></li>
<b><li>Arbitration</b>
									<p class="p2">Any legal controversy or legal claim arising out of or relating to this Agreement or our on-line auction services shall be settled by binding arbitration in accordance with the commercial arbitration rules of the American Arbitration Association. Any such controversy or claim shall be arbitrated on an individual basis, and shall not be consolidated in any arbitration with any claim or controversy of any other party. The arbitration shall be conducted in Birmingham, Alabama, and judgment on the arbitration award may be entered by any court having jurisdiction thereof. Either you or Equibidz, LLC may seek interim or preliminary injunctive relief from a court of competent jurisdiction in Alabama to protect the rights or property of you or Equibidz, LLC pending the completion of arbitration. Should either party file an action contrary to this provision, the other party may recover reasonable attorneys fees and costs.
									</font><p></li>
<b><li>General</b>
									<p class="p2">Bidders shall comply with all applicable domestic and international laws, statutes, ordinances, and regulations regarding your use of this on-line auction service. 
This Agreement shall be governed in all respects by the laws of the State of Alabama; as such laws are applied to agreements entered into and to be performed entirely within Alabama between Alabama residents. Bidders expressly consent to jurisdiction over any dispute(s) that may arise hereunder or related hereto in the State of Alabama and venue in Birmingham, Alabama. 
If any provision or portion of a provision of this Agreement is held to be invalid or unenforceable for any reason, such provision or portion of a provision shall be struck and the remaining provisions shall be enforced. 
Equibidz, LLCs failure to act with respect to a breach by you or others does not waive our right to act with respect to subsequent or similar breaches. 
Equibidz, LLC provides a venue to bring Buyers and Owner/Sellers together over the Internet. Because we do not participate in the physical transaction between Buyers and Owners/Sellers, we do not have any control or assume any responsibility for the quality, safety, or legality of the horses advertised, the truth or accuracy of the listings, the right or ability of the Owners/Sellers to sell horses or the right or ability of Buyers to buy horses. Equibidz, LLC does not have control over whether Buyers or Owners/Sellers actually complete the transaction. 
By using the Service, you acknowledge that Equibidz, LLC, its owners, agents and other representatives, cannot possibly authenticate Bidders validity, and in the event of a dispute between Bidders, you release Equibidz, LLC, its owners, employees, and agents from claims, demands, and damages (actual and consequential) of every kind and nature, known and unknown, suspected and unsuspected, disclosed and undisclosed, arising out of or in any way connected with such disputes. 
Equibidz, LLC may amend these Terms and Conditions at any time by posting the amended terms on the auction web site.
</font><p></li>			
								<b><li>Privacy Policy </b>
									<p class="p2">By registering you are agreeing to the use of your information by Equibidz, LLC. Your information will only be used by the auction company and the Owner/Seller for record keeping and to contact you. Any use of this information by anyone else is prohibited. Equibidz, LLC will not give or sell your information to any entity. In the future we may use e-mail lists to contact you. If you wish to discontinue receiving these e-mails contact our office.</font><p></li>
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
					<cfinclude template="includes/copyrights.cfm">
				</td>
			</tr>
	</table>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
