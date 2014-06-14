<!---
  eml_bidconfirmation.cfm
  
  email sent to bidder after a bid is placed...
  confirmation email...
  
  <cfmodule template="eml_bidconfirmation.cfm"
    to=""
    from=""
    subject=""
    itemnum=""
    itemTitle=""
    nickname
    bid=""
    quantity=""
    bidType=""
    date=""
    date_end=""
    domain=""
    remoteHost="">
    
--->
<cfsetting enablecfoutputonly="Yes">

<!--- inc app_globals --->
<cfinclude template="../includes/app_globals.cfm">

<cfloop index="l" list="to,from,subject,itemnum,itemTitle,nickname,bid,quantity,bidType,date,date_end,domain,remoteHost,buynow">
  <cfif not IsDefined("Attributes." & l)>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfif>
</cfloop>

<!--- send email --->
<cfsetting enablecfoutputonly="No">

<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#"
><cfif #Attributes.buynow# eq "yes">
Congratulations #Attributes.nickname#. You have successfully won #Attributes.itemTitle#.



Below are the final details of the auction.

#Attributes.itemTitle#

Number: #Attributes.itemnum#

Nickname/User ID: #Attributes.nickname#
Your Buy Now Price: $ #numberformat(Attributes.bid,numbermask)#
Total: $ #numberformat(Attributes.bid,numbermask)# USD
Date Placed: #DateFormat(Attributes.date, "mm/dd/yy")# #TimeFormat(Attributes.date, "HH:mm:ss")#

Your Host Address: #Attributes.remoteHost#

You may view other details of this auction at http://#Attributes.domain##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum# .

Thank you for your patronage.

Customer Service
#DOMAIN#

<cfelse>

Congratulations #Attributes.nickname#,
	
	Your current bid on #Attributes.itemTitle# was a successful bid.

Below are the current details of the auction.

#Attributes.itemTitle#

Number: #Attributes.itemnum#

Nickname/User ID: #Attributes.nickname#
Your Bid: $ #numberformat(Attributes.bid,numbermask)#

Total Bid: $ #numberformat(Attributes.bid,numbermask)#
Bid Type: #Attributes.bidType#
Date Placed: #DateFormat(Attributes.date, "mm/dd/yy")# #TimeFormat(Attributes.date, "HH:mm:ss")#
Your Host Address: #Attributes.remoteHost#

You may view this auction in progress at http://#Attributes.domain##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum# until its close on #DateFormat(Attributes.date_end, "mm/dd/yy")# #TimeFormat(Attributes.date_end, "HH:mm:ss")#.

Thank you for your patronage.

Customer Service
#DOMAIN#
</cfif>
</cfmail>
