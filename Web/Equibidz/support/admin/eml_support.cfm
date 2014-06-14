<cfsetting enablecfoutputonly="yes">
<!---
  Support/FAQ
  eml_support.cfm
  e-mail sent to support staff after user submits question
  06/16/00 TLingard
--->

<cfinclude template = "../includes/app_globals.cfm">

<cfmail to="#SERVICE_EMAIL##domain#" from="#Attributes.email_sub#" subject="Support Question - #Attributes.subject_sub#">
Question From : #Attributes.name_sub#   #Attributes.email_sub#   

Subject : #Attributes.subject_sub#

Question : #Attributes.quest_sub#

---
Automated Support E-Mail
</cfmail><!--- <!--- #Attributes.phone_sub# ---> --->