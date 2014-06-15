<!---
  eml_outbiduser.cfm
  
  email file sent to user who was outbid..
  
  <cfmodule template="eml_outbiduser.cfm"
    to="[to email address]"
    from="[from email address]"
    subject="[email subject]"
    itemnum="[item number]"
    itemTitle="[item title]"
    oldBid="[old high bid]"
    newHighUser="[new high user]"
    newBid="[new high bid]">

--->
<cfsetting enablecfoutputonly="Yes">

<!--- inc app_globals.cfm --->
<cfinclude template="../includes/app_globals.cfm">

 
<cfif session.auction_mode is 0>

<!-- Regular Auction --> 
<!--- verify required params --->
<!--- <cfloop index="l" list="to,from,subject,itemnum,itemTitle,oldBid,newHighUser,newBid"> --->

<cfloop index="l" list="to,from,subject,itemnum,itemTitle,oldbid,newHighUser">
 
  <cfif not IsDefined("Attributes." & l)>
  
      <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfif>
</cfloop>

<cfsetting enablecfoutputonly="No">
 
<!--- send email --->
<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#"
>Your bid of $#Attributes.oldBid# on auction number #Attributes.itemnum# ("#Trim(Attributes.itemTitle)#") has been outbid by another bidder.

Click on the link below to try again.

http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#

Thank you!
Customer Service
#DOMAIN#
 
</cfmail>
<cfelse>
 
<!-- Reverse Auction -->
<!--- verify required params --->
<cfloop index="l" list="to,from,subject,itemnum,itemTitle,oldBid,newLowUser,newBid">
 
  <!--- <cfif not IsDefined("Attributes." & l)>
  
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfif> --->
</cfloop>

<cfsetting enablecfoutputonly="No">

<!--- send email --->
<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#"
>Your offer of #Attributes.oldBid# on auction number #Attributes.itemnum# ("#Trim(Attributes.itemTitle)#") has been outbid by #Attributes.newLowUser#.

http://#CGI.SERVER_NAME##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#

Thank you!
Customer Service


</cfmail>
</cfif>
