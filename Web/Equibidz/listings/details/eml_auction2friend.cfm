<!---
  eml_auction2friend.cfm
  
  email file for sending auction information to a friend...
  called from emailauction.cfm...
  
  <cfmodule template="eml_auction2friend.cfm"
    to="[recipient's email addr]"
    from="[sender's email addr]"
    subject="[subject]"
    message="[email message]"
    mimeType="[TEXT|HTML]">
    
--->
<cfsetting enablecfoutputonly="Yes">



<!--- chk required params --->
<cfloop index="l" list="to,from,subject,message,mimeType">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</B> #l# attribute of eml_auction2friend not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- send email --->
<cfsetting enablecfoutputonly="No">

<cfif Attributes.mimeType IS "HTML">
  <cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#" TYPE="#Attributes.mimeType#">#Attributes.message#</cfmail>
<cfelse>
  <cfmail to="#Attributes.to#" from="#Attributes.from#" subject="#Attributes.subject#">#Attributes.message#</cfmail>
</cfif>
