<!--
  eml_invoice.cfm
  
  email file for sending seller invoice..
  used by gen_invoice.cfm..
  passed fee info..
  
  <!---

  <cfmodule template="eml_invoice.cfm"
    to=""
    from=""
    subject=""
    message=""
    itemnum="">
    
   --->

-->

<!-- inc app_globals -->
<cfinclude template="../includes/app_globals.cfm">

<!-- chk required params -->
<cfloop index="l" list="to,from,subject,message">
  <cfif not IsDefined("Attributes." & l)>
    <cfabort>
  </cfif>
</cfloop>

<!--- get currency type --->
  <cfquery name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  <!--- PayPal only support CAD, EUR, GBP, JPY AND USD --->
  <cfif getCurrency.type eq "CAD" or getCurrency.type eq "EUR" or getCurrency.type eq "GBP" or getCurrency.type eq "JPY" or getCurrency.type eq "USD">
  	<cfset currency_type = getCurrency.type>
  <cfelse>
  	<cfset currency_type = "USD">
  </cfif>

<!-- send email -->
<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#" type="HTML">

Thank you for using our site.<br><br>

The following is a statement of the amount you used our services.  Please keep this statement for your personal records.<br><br>

#Attributes.message#

<cfif isdefined("Attributes.paid") and Attributes.paid eq 0>
  <cfif isdefined("paypal") and paypal eq "yes">
  Click on the PayPal logo below to pay the balance amount:<br>
  <form action="https://www.paypal.com/cgi-bin/webscr" method="post"><input type="hidden" name="return" value="#paypal_return#"><input type="hidden" name="cancel_return" value="#paypal_cancel_return#"><input type="hidden" name="notify_url" value="#paypal_notify_url#"><input type="hidden" name="cmd" value="_xclick"><input type="hidden" name="business" value="#paypal_business_acct#"><input type="hidden" name="item_name" value="#Attributes.title#"><input type="hidden" name="item_number" value="#Attributes.itemnum#"><input type="hidden" name="amount" value="#numberformat(Attributes.newBalance, numbermask)#"><input type="hidden" name="custom" value="#Attributes.user_id#"><input type="hidden" name="currency_code" value="#currency_type#"><input type="image" src="#paypal_bttn#" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!"></form>
  <br>Prompt payment of this invoice is greatly appreciated.<br><br>
  </cfif>
</cfif>
Click <a href="http://#CGI.SERVER_NAME##VAROOT#/">HERE </a>to visit the site<br><br>

Thank you!<br>
Customer Service


</cfmail>
