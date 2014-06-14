<!--
  eml_seller_results.cfm
  
  email file used for emailing seller results of his auction..
  used by gen_seller_results.cfm..
  
  <!---

  <cfmodule template="eml_seller_results.cfm"
    to=""
    from=""
    subject=""
    message="">
   
   --->
-->


<!-- define values -->
<cfset isGood = "TRUE">

<!-- chk required params -->
<cfloop index="l" list="to,from,subject,message">
  <cfif not IsDefined("Attributes." & l)>
    <cfset isGood = "FALSE">
  </cfif>
</cfloop>

<!-- if good send email -->
<cfif isGood>

<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#"
>Thank you for holding your auction with us.  Following are the results of your auction.

#Attributes.message#

Thank you!
Customer Service


</cfmail>
</cfif>
