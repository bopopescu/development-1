<!--- 
  cf_mod10.cfm
  
  Code to validate credit card number.  Includes Lunh check,
  (check digit validation) which uses modulo 10 as part of
  its computation.
  
--->

<cfset cc_number = Trim(cc_number)>
<CFSET #CurDigit# = #Left(cc_number, 1)#>
<cfset FullNumLen = Len(cc_number)>
<CFSET #NumLen# = #FullNumLen# - 1>
<cfparam name="error_message" default="">


<cfif #isnumeric(fullnumlen)# is 0>
  <cfset #error_message# = "Invalid card number.">
  <cfset #cc_number_error# = "Invalid character in number field">
<cfelse>

<CFIF  (#CurDigit# IS "3") AND (#FullNumLen# IS NOT 15)>
	<cfset #error_message# = #listAppend (error_message, "Card number is incorrect.")#>
  <cfset #cc_number_error# = "Card number should be 15 digits long.">

<CFELSEIF  (#CurDigit# IS "4") AND (#FullNumLen# IS NOT 13) AND (#FullNumLen# IS NOT 16)>
  <cfset #error_message# = #listAppend (error_message, "Card number is incorrect.")#>
  <cfset #cc_number_error# = "Card number should be either 13 or 16 digits long.">

<CFELSEIF  (#CurDigit# IS "5") AND (#FullNumLen# IS NOT 16)>
	<cfset #error_message# = #listAppend (error_message, "Card number is incorrect.")#>
  <cfset #cc_number_error# = "Card number should be 16 digits long.">

<CFELSEIF (#CurDigit# IS "6") AND (#FullNumLen# IS NOT 14) AND (#FullNumLen# IS NOT 16)>
	<cfset #error_message# = #listAppend (error_message, "Card number is incorrect.")#>
  <cfset #cc_number_error# = "Card number should be either 14 or 16 digits long.">
  
<CFELSEIF #cc_number# is "0">
	<cfset #error_message# = #listAppend (error_message, "Card number is incorrect.")#>
  <cfset #cc_number_error# = "Card number should be 16 digits long.">  
  
<CFSET #Multiplier# = 2>
<CFSET #Sum# = 0>
<CFLOOP INDEX="LoopIndex" FROM=#NumLen# TO="1" STEP="-1">
	<CFSET #CurDigit# = #Mid(cc_number, LoopIndex, 1)#>
	<CFSET #Product# = #Multiplier# * #CurDigit#>
	<CFIF #Product# GT 9>
		<CFSET #Sum# = #Sum# + #Product# - 9>
	<CFELSE>
  		<CFSET #Sum# = #Sum# + #Product#>
	</CFIF>
	<CFSET #Multiplier# = 3 - #Multiplier#>
</CFLOOP>
<CFSET #Sum# = #Sum# MOD 10>
	<CFIF #Sum# IS NOT 0>
		<CFSET #Sum# = 10 - #Sum#>
	</CFIF>
	<CFIF #Sum# IS NOT #Right(cc_number, 1)#>
 		<cfset #error_message# = #listAppend (error_message, "Card number is incorrect.")#>
  		<cfset #cc_number_error# = "Card number is incorrect.">
	</CFIF>	
</CFIF>

<cfif not (cc_name is "" or cc_name is "0")>
     <cfif #len (cc_name)# LT 3 or #isNumeric (cc_name)# is 1>
       <cfset #error_message# = #listAppend (error_message, "Invalid cardholder name.")#>
       <cfset #cc_name_error# = "Invalid cardholder name.">
     </cfif>
</cfif>

<cfif not (cc_expiration is "" or cc_expiration is "0")>
<cfif len(cc_expiration) LT 4 or not find ("/", cc_expiration)>
<cfset #error_message# = #listAppend (error_message, "Invalid credit card expiration date.")#>
<cfelse>
<cfset cc_expiration = Replace(cc_expiration, "-", "/", "All")>
  <cfset cc_ExpirArray = ListToArray(cc_expiration, "/")>
  <cfset cc_goodthru_month = Trim(cc_ExpirArray[1])>
  <cfset cc_goodthru_year  = Trim(cc_ExpirArray[2])>
    <cfset cc_expire_on_dt = DateAdd("m", 1, CreateDate(cc_goodthru_year, cc_goodthru_month, 1))>
   <cfif len(cc_expiration) LT 4 or not find ("/", cc_expiration)
        or not IsNumeric(cc_goodthru_month) or cc_goodthru_month LT 1
        or cc_goodthru_month GT 12 or not IsNumeric(cc_goodthru_year)
        or cc_goodthru_year GT 9999>
    <cfset #error_message# = #listAppend (error_message, "Invalid credit card expiration date.")#>
    <cfset #cc_expiration_error# = "Invalid credit card expiration date.  It must be in the form 'mm/yy' or 'mm/yyyy'.">
  <cfelse>
    <cfif Len(cc_goodthru_year) is 2>
      <cfset cc_goodthru_year = "20" & cc_goodthru_year>
    </cfif> 
	 </cfif>
    <cfif cc_expire_on_dt LT TIMENOW>
      <cfset error_message = listAppend(error_message, "Credit Card Expired.")>
      <cfset cc_expiration_error = "Credit Card Expired.  Please use an unexpired card.">
    <cfelseif cc_expire_on_dt GE DateAdd("yyyy", 8, TIMENOW)>
      <cfset error_message = listAppend(error_message, "Invalid credit card expiration date.")>
      <cfset cc_expiration_error = "Invalid credit card expiration date.  Date out of range.">
    </cfif>
  </cfif>
</cfif> 


</cfif>
