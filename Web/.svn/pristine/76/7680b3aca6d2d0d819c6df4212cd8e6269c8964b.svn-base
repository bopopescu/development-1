<cfsetting enablecfoutputonly="yes">
<!---
  support/amdin/eml_answer.cfm
  eml_answer.cfm
  e-mail sent to user after support staff answers question
  06/16/00 TLingard
--->

<cfinclude template = "../../includes/app_globals.cfm">

<cfquery name="getsubject" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
SELECT subjects
FROM faqsubject
WHERE sub_id = #Attributes.sub_id#
</cfquery>


<cfmail to="#Attributes.email#" from="#SERVICE_EMAIL##domain#" subject="RE: Support Question - #getsubject.subjects#">
#Attributes.username# -

In response to your question :

	#Attributes.question#

Answer :

	#Attributes.answer#

<cfif #Attributes.active# is 1>
Your Question has been added to the Support page.
You may view it here:
http://#CGI.SERVER_NAME##VAROOT#/support/faqquest.cfm?subject=#Attributes.sub_id#
</cfif>
---
Customer Support
http://#domain#

</cfmail>