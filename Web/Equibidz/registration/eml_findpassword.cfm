<!---
  eml_passwordfinder.cfm
  
  email sent to user containing account password...
  used by findpassword.cfm...
  
  <cfmodule template="eml_findpassword.cfm"
    to="[recipient's email addr]"
    from="[sender's email addr]"
    subject="[subject of email]"
    password="[recipient's password]"
    date="[date/time of request]"
    requestHost="[addr of host who made request]">
    
--->
<cfsetting enablecfoutputonly="Yes">

<!--- chk required params --->
<cfloop index="l" list="to,from,subject,password,date,requestHost">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</b> Missing "#l#" attribute of eml_passwordfinder.<br>
      <br>
      <cfabort>
    </cfoutput>
  </cfif>
</cfloop>

<!--- send email --->
<cfsetting enablecfoutputonly="No">

<cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#"
>Thank you for using the Password Finder!

A request for your account password was made on #Attributes.date# from host "#Attributes.requestHost#".  Here is your password:

#Attributes.password#

Thank you!
Customer Service

</cfmail>