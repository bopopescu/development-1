<!--
  eml_badaccount.cfm
  
  email file sent to customer service if user account on auction is no longer valid..
  
  <!--- send email to customer service

  <cfmodule template="eml_badaccount.cfm"
    to="[email address to]"
    from="[email address from]"
    subject="[subject of email]"
    itemnum="[item number]"
    user_id="[account number]">


   --->

-->

<cfset continue = "TRUE">

<!-- check required params -->
<cfloop index="l" list="to,from,subject,itemnum,user_id">
  <cfif not IsDefined("Attributes." & l)>
    <cfset continue = "FALSE">
    <cfbreak>
  </cfif>
</cfloop>

<!-- send email -->
<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#">
Attention...

The user account... #Attributes.user_id# ...listed on auction number... #Attributes.itemnum# ...appears to have been deleted.. and/or is no longer valid.

Since no accounting measures are possible without a valid account this auction has been set inactive and will be ignored.

Thank you!
Event2, #CGI.SERVER_NAME#

</cfmail>
