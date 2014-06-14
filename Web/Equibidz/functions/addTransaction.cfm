<!---
  
  addTransaction.cfm
  
  module for adding a transaction entry to the "transaction_log" table..
  called where needed in software..
  
  required params:
    datasource (DSN)
    description of transaction
    
  all others optional..
    if not given will be defined to default unassigned value
    
  
  <cfmodule template="addTransaction.cfm"
    datasource="#DATASOURCE#"
    description="[description of trans]"
    [itemnum="[opt. affected item number]"]
    [details="[opt. details about transaction]"]
    [amount="[opt. $ amount related to transaction]"]
    [user_id="[opt. user id related to transaction]"]>
    
    
  Makes use of:
    - /functions/timenow.cfm
    - /functions/epoch.cfm
    
  Author: John Adams
  Date: 08/06/1999
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- customize vals --->
<cfset sDefDesc = "No Description Available">      <!--- desc. used if none given, or given null --->
<cfset iDefItemnum = 0>      <!--- itemnum used if none given, or given not numeric --->
<cfset sDefDetails = "No Details Available">      <!--- details used if none given, or given null --->
<cfset fDefAmount = 0.00>      <!--- amount used if none given, or given not numeric --->
<cfset iDefUserId = 0>      <!--- user id used if none given, or given not numeric --->

<!--- def vals --->
<cfset bUseDesc = 0>
<cfset bUseItemnum = 0>
<cfset bUseDetails = 0>
<cfset bUseAmount = 0>
<cfset bUseUserId = 0>

<cfparam name="Attributes.itemnum" default="0">
<cfparam name="Attributes.details" default="">
<cfparam name="Attributes.amount" default="0.00">
<cfparam name="Attributes.user_id" default="0">

<cfset lAllAttribs = "datasource,description,itemnum,details,amount,user_id">
<cfset lReqAttribs = "datasource,description">

<!--- def TIMENOW --->
<cfmodule template="timenow.cfm">

<!--- def Epoch --->
<cfmodule template="epoch.cfm">

<!--- chk req params --->
<cfloop index="e" list="#Variables.lReqAttribs#">
  
  <cfif not IsDefined("Attributes." & e)>
    
    <cfoutput>
      <br>
      <b>ERROR:</b> #e# attribute of addTransaction not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def DATASOURCE --->
<cfset DATASOURCE = Attributes.datasource>

<!--- def which attribs to use --->
<cfif Len(Trim(Attributes.description))>
  <cfset bUseDesc = 1>
</cfif>

<cfif IsDefined("Attributes.itemnum")>
  <cfif Len(Trim(Attributes.itemnum)) AND IsNumeric(Attributes.itemnum)>
    <cfset bUseItemnum = 1>
  </cfif>
</cfif>

<cfif IsDefined("Attributes.details")>
  <cfif Len(Trim(Attributes.details))>
    <cfset bUseDetails = 1>
  </cfif>
</cfif>

<cfif IsDefined("Attributes.amount")>
  <cfif Len(Trim(Attributes.amount)) AND IsNumeric(Attributes.amount)>
    <cfset bUseAmount = 1>
  </cfif>
</cfif>

<cfif IsDefined("Attributes.user_id")>
  <cfif Len(Trim(Attributes.user_id)) AND IsNumeric(Attributes.user_id)>
    <cfset bUseUserId = 1>
  </cfif>
</cfif>



<!--- assign vals for ins --->
<cfset tsDatePosted = TIMENOW>
<cfset sDesc = IIf(Variables.bUseDesc, "Attributes.description", "Variables.sDefDesc")>
<cfset iItemnum = IIf(Variables.bUseItemnum, "Attributes.itemnum", "Variables.iDefItemnum")>
<cfset sDetails = IIf(Variables.bUseDetails, "Attributes.details", "Variables.sDefDetails")>
<cfset fAmount = IIf(Variables.bUseAmount, "Attributes.amount", "Variables.fDefAmount")>
<cfset iUserId = IIf(Variables.bUseUserId, "Attributes.user_id", "Variables.iDefUserId")>
<cfset sRemoteIP = CGI.REMOTE_ADDR>

<!--- ins into transaction log --->
<cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
    INSERT INTO transaction_log
      (
       date_posted,
       itemnum,
       description,
       details,
       amount,
       remote_ip,
       user_id
      )
    VALUES
      (
       #Variables.tsDatePosted#,
       #Variables.iItemnum#,
       '#Variables.sDesc#',
       '#Variables.sDetails#',
       #Variables.fAmount#,
       '#Variables.sRemoteIP#',
       #Variables.iUserId#
      )
</cfquery>

<cfsetting enablecfoutputonly="No">
