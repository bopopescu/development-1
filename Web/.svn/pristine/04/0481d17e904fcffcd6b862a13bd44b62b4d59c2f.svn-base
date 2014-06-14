<!---

  checkpassword.cfm

  This ColdFusion module will check a password for containing both alpha
  and numeric characters, as well as a minimum length of 5 characters.

  If the password doesn't fit these constraints, an error is returned.

  Parameters          
    password       : The password string to check.

  Returns
    password_good  : "1" if the password is OK.
                     "0" if it failed the tests.
    result_message : An error message or blank if none.

  Usage Example:
 
    <CFMODULE TEMPLATE="checkpassword.cfm" password="test123">
    <cfif #password_good# is "1">
     Password OK.<br>
    <cfelse>
     Invalid - it must contain letters and numbers and be >=5 chars long.<br>
    </cfif>

  Jason Johnson (jason@atcg.com)

--->
<cfsetting enablecfoutputonly="YES">

<!--- Initialize --->
<cfset #password# = #Trim(Attributes.password)#>

<!--- Stripping all alpha chars from a copy of the password --->
<cfset #temp# = #REReplace(password, "[A-Za-z]", "", "ALL")#>

<!--- Check for minimum length violation --->
<cfif #Len(password)# LT 5>
  
  <cfset #Caller.password_good# = "0">
  <cfset #Caller.result_message# = "Password too short; it must be at least 5 characters.">
  
<cfelseif #IsNumeric(temp)# IS 0
  OR #Len(temp)# IS #Len(password)#>
  
  <cfset #Caller.password_good# = "0">
  <cfset #Caller.result_message# = "Password not secure enough; it must contain both numbers and letters.">
  
<cfelse>
  <cfset #Caller.password_good# = "1">
  <cfset #Caller.result_message# = "">
</cfif>

<cfsetting enablecfoutputonly="NO">