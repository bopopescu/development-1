<!---
  
  options_list.cfm
  
  defines payment or shipping options list from given fields..
  returns:
    paymentOpt
    or
    shippingOpt
  
  <cfmodule template="options_list.cfm"
    mode="[PAYMENT|SHIPPING]"
    [morder_ccheck="[0|1]"
     cod="[0|1]"
     see_desc="[0|1]"
     pcheck="[0|1]"
     ol_escrow="[0|1]"
     other="[0|1]"
     visa_mc="[0|1]"
     am_express="[0|1]"
     discover="[0|1]"]
    [sell_pays="[0|1]"
     buy_pays_act="[0|1]"
     see_desc="[0|1]"
     buy_pays_fxd="[0|1]"
     international="[0|1]"]>
    
--->
<cfsetting enablecfoutputonly="Yes">

<cfloop index="l" list="mode">
  <cfif not IsDefined("Attributes." & l)>
    <cfabort>
  </cfif>
</cfloop>

<cfif Attributes.mode IS "PAYMENT">
  
  <!--- define payment options --->
  <cfset paymentOpt = "">
  <cfset paymentOpt = IIf(Attributes.morder_ccheck, "ListAppend(paymentOpt, 'Money Order/Cashiers Check', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.cod, "ListAppend(paymentOpt, 'Collect On Delivery', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.see_desc, "ListAppend(paymentOpt, 'See item description for payment options', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.pcheck, "ListAppend(paymentOpt, 'Personal Check', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.ol_escrow, "ListAppend(paymentOpt, 'PayPal', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.other, "ListAppend(paymentOpt, 'Other', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.visa_mc, "ListAppend(paymentOpt, 'Visa/MasterCard', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.am_express, "ListAppend(paymentOpt, 'American Express', ', ')", "paymentOpt")>
  <cfset paymentOpt = IIf(Attributes.discover, "ListAppend(paymentOpt, 'Discover', ', ')", "paymentOpt")>
  
  <!--- return val --->
  <cfset Caller.paymentOpt = paymentOpt>
  
<cfelseif Attributes.mode IS "SHIPPING">
  
  <!--- define shipping options --->
  <cfset shippingOpt = "">
  <cfset shippingOpt = IIf(Attributes.sell_pays, "ListAppend(shippingOpt, 'Seller Pays', ', ')", "shippingOpt")>
  <cfset shippingOpt = IIf(Attributes.buy_pays_act, "ListAppend(shippingOpt, 'Buyer Pays Actual Amount', ', ')", "shippingOpt")>
  <cfset shippingOpt = IIf(Attributes.see_desc, "ListAppend(shippingOpt, 'See item description for shipping options', ', ')", "shippingOpt")>
  <cfset shippingOpt = IIf(Attributes.buy_pays_fxd, "ListAppend(shippingOpt, 'Buyer Pays Fixed Amount', ', ')", "shippingOpt")>
  <cfset shippingOpt = IIf(Attributes.international, "ListAppend(shippingOpt, 'Seller ships internationally', ', ')", "shippingOpt")>
  
  <!--- return val --->
  <cfset Caller.shippingOpt = shippingOpt>
  
</cfif>

<cfsetting enablecfoutputonly="No">