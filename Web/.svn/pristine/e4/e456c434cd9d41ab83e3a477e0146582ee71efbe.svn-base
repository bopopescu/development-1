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

<cfloop index="l" list="to,from,subject,itemnum,itemTitle,nickname,bid,quantity,bidType,date,date_end,domain,remoteHost,user_id">
  <cfif not IsDefined("Attributes." & l)>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfif>
</cfloop>

<!-- chk IEscrow enabled/disabled -->
<cfmodule template="../functions/iescrow.cfm"
  sOpt="ChkStatus">
  
  <!-- get currency type -->
<cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#datasource#">
    SELECT pair AS type
      FROM defaults
     WHERE name = 'site_currency'
</cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#datasource#">
      SELECT U.*, I.date_start, I.date_end, I.quantity
        FROM users U, items I
       WHERE I.itemnum = #Attributes.itemnum#
	   AND U.user_id = I.user_id
  </cfquery>
  
  <cfquery username="#db_username#" password="#db_password#" name="getbidders" datasource="#datasource#">
      SELECT *
        FROM users
       WHERE nickname = '#Attributes.nickname#'
	   AND user_id = #Attributes.user_id#
  </cfquery>

<!--- send email --->
<cfsetting enablecfoutputonly="No">

<cfmail to="#getInfo.email#" from="#Attributes.from#" subject="#Attributes.subject#"
>The following user has successfully bought on:

    Item Number: #Trim(Attributes.itemnum)#
    Item Title: #Trim(Attributes.itemTitle)#
    Date Started: #DateFormat(getInfo.date_start, "mm/dd/yyyy")# #TimeFormat(getInfo.date_start, "HH:mm:ss")#
    Date Ended: #DateFormat(getInfo.date_end, "mm/dd/yyyy")# #TimeFormat(getInfo.date_start, "HH:mm:ss")#
         
   <!--- Nickname: #Trim(Attributes.nickname)#
    Email: #Trim(getBidders.email)#
    Quantity Desired: 1
	Quantity Available: 1--->
    Buy Now Price: #numberformat(Attributes.bid,numbermask)# #Trim(getCurrency.type)#
    
    Equibidz.Com will be sending you all of the contact information in the services documentation as soon as possible.
  

    Click here for the complete results of your auction: http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#


Thank you!
Equibidz.Com 
#DOMAIN#


</cfmail>
