<!---
  eml_watch.cfm
  
  email file for future watch..
  sent to user when system finds auction meeting keywords..
  
  <cfmodule template="eml_watch.cfm"
    to="[user's email]"
    from="[site's email]"
    subject="[email subject]"
    aSearchResults="[array of search results]"
    userNickname="[user's nickname]"
    companyName="[company name]">
    
  aSearchResults:
    1 = item title
    2 = item number
    
  Author: John Adams
  Date: 07/08/1999
  
--->

<!--- inc app_globals --->
<cfinclude template="../../includes/app_globals.cfm">

<!--- chk attribs defined --->
<cfloop index="l" list="to,from,subject,aSearchResults,userNickname,companyName">
  
  <cfif not IsDefined("Attributes." & l)>
    
    <cfoutput>
      <!-- debug >> #l# attribute of eml_watch not defined -->
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def values --->
<cfset sNl = Chr(13) & Chr(10)>
<cfset sEmailMessage = "">

<!--- setup message --->
<cfloop index="i" from="1" to="#ArrayLen(Attributes.aSearchResults)#">
  
  <cfset sEmailMessage = sEmailMessage & "#Attributes.aSearchResults[i][1]##sNl#http://#cgi.server_name##VAROOT#/listings/details/index.cfm?itemnum=#Attributes.aSearchResults[i][2]##sNl##sNl#">
</cfloop>

<!--- send email --->
<cfmail to="#Attributes.to#"
  from="#Attributes.from#"
  subject="#Attributes.subject#"
  
>Dear #Attributes.userNickname#,

Based on the information you have supplied us in your future watch settings, the following auctions, which have recently started on our site, would be of interest to you.

#Variables.sEmailMessage#

Thank you!
#Attributes.companyName#


</cfmail>
