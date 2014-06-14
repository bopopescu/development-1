
<cfinclude template="session_include.cfm">
<cfparam name="app_globals_flag" default="0">


<cfif app_globals_flag eq 0>

<cfsetting enablecfoutputonly="yes">
<!---
epoch.cfm

defines Unix time
seconds since 12/31/1999 24:00:00 GMT

set "zone_adjust" +/- to calc GMT from your server time

<CFMODULE TEMPLATE="epoch.cfm">

--->

<!--- define # of hours to adjust server time to get GMT time --->
<CFSET zone_adjust = 8>

<!--- define GMT time --->
<CFSET GMTtime = DateAdd("h", zone_adjust, Now())>

<!--- set EPOCH in Caller --->
<CFSET Caller.EPOCH = DateDiff("s", "12-31-1979 00:00:00", GMTtime)>


<cfif IsDefined("url.cr_set") OR IsDefined("Attributes.sStructName") >
  <!--- DON'T DO ANYTHING HERE
    if this file is being called as a module, or
    if this file is being called a second time or more.
  --->
<cfelse>
<cfoutput>
  <!--
  Equibidz Auction 10.0 Copyright 2010 Equibidz, LLC  All Rights Reserved.
  WWW: http://www.equibidz.com/
  Sales: sales@equibidz.com
  Tech-Support: support@equibidz.com
  -->
</cfoutput>
  <cfset url.cr_set = "true">
</cfif>

<!--- Change Here --->
<!--- ************************************************************* ---> 
<cfset DATASOURCE = "c148196-h218913">
<cfset DOMAIN = "equibidz.com">
<cfset SITE_ADDRESS = iif(cgi.HTTP_HOST contains "localhost", de("localhost"), de("www.equibidz.com"))> <!--- If you want a live website use www.equibidz.com if you want local developement use localhost --->
<!--- ************************************************************* ---> 

<cfquery name="get_layout" datasource="#datasource#">
	SELECT *
	FROM layout
	WHERE id=1
</cfquery>
 
<cfset vlink_color = get_layout.vlink_color>
<cfset hlink_color = get_layout.hlink_color>
<cfset text_color = get_layout.text_color>
<cfset set_text_font = get_layout.text_font>
<cfset bg_color = get_layout.bg_color> 
<cfset hrsending_color = get_layout.hrsending_color> 
<cfset listing_bgcolor = get_layout.listing_bgcolor>
<cfset set_heading_color = get_layout.heading_color> 
<cfset set_heading_fcolor = get_layout.heading_fcolor>  
<cfset set_heading_font = get_layout.heading_font>
<cfset set_heading_font_size = get_layout.heading_fsize>
<cfset ListingNew = get_layout.ListingNew>


<!--- Check block IP --->
<cfquery name=get_blocked_ip datasource="#datasource#">
SELECT blocked_ip
FROM blocked_ip
WHERE blocked_ip = '#cgi.remote_addr#'
</cfquery>

<cfif get_blocked_ip.recordcount eq 0>

<CFIF ( lcase(cgi.server_name) does not contain lcase(DOMAIN))
  and ( lcase(cgi.server_name) does not contain lcase(SITE_ADDRESS))
  and ( lcase(cgi.server_name) does not contain "visualauction.com")
  and   isDefined("Prompt") is 0
  and   len(cgi.server_name) GT 0>
  <!--- this last line allows old browsers, ones which may not send the HOST header
	(aka. browsers which aren't HTTP/1.1 compliant), to work with our software.
  --->
  <cflocation url="http://www.beyondsolutions.com/notregisteredurl.cfm?domain=#DOMAIN#">
</cfif>

<cfelse>

<cflocation url="../404b.htm">

</cfif>

<cfinclude template="global_vars.cfm">
<cfinclude template="cache_control.cfm">

<cfset demo_domain = "www.visualauction.com">


<cfset classified_valid = "yes">
<cfset store_on = "0"> 
<cfset offline_on = "0">

<cfset cc_mandatory = "no"> <!--- Make Credit card mandatory for Classifieds --->




<!------------------------------------------------------------------------->
<!--- for calling app_globals as module and returning vals in structure --->
  <!---
    makes for easier implementation of global variables in future scripts
    w/o the fear of name conflicts

    Usage:

      <cfmodule template="app_globals.cfm"
        sStructName="[name of structure to hold globals]">

    Returned Keys:
      ##.DATASOURCE
      ##.DOMAIN
      ##.SITE_ADDRESS
      ##.VAROOT
      ##.COMPANY_NAME
      ##.FEE_URL
      ##.PROBLEM_EMAIL
      ##.QUESTION_EMAIL
      ##.SERVICE_EMAIL
      ##.TIME_ZONE
      ##.CYBERCASH_ERROR_EMAIL
      ##.CC_MERCHANT_KEY
      ##.CC_CYBERCASH_ID
      ##.CYBER_CASH
      ##.MODE_SWITCH
      ##.AUCTION_MODE

  --->

<cfif IsDefined("Attributes.sStructName")>

  <!--- def vals --->
  <cfset bValidName = 0>

  <cfif Len(Trim(Attributes.sStructName))
    AND not Find(" ", Attributes.sStructName)>

    <!--- def vals --->
    <cfset bValidName = 1>
    <cfset hTmpStruct = StructNew()>

    <cfif IsDefined("Variables.DATASOURCE")>
      <cfset temp = StructInsert(hTmpStruct, "DATASOURCE", Variables.DATASOURCE)>
    </cfif>
    <cfif IsDefined("Variables.DOMAIN")>
      <cfset temp = StructInsert(hTmpStruct, "DOMAIN", Variables.DOMAIN)>
    </cfif>
    <cfif IsDefined("Variables.SITE_ADDRESS")>
      <cfset temp = StructInsert(hTmpStruct, "SITE_ADDRESS", Variables.SITE_ADDRESS)>
    </cfif>
    <cfif IsDefined("Variables.VAROOT")>
      <cfset temp = StructInsert(hTmpStruct, "VAROOT", Variables.VAROOT)>
    </cfif>
    <cfif IsDefined("Variables.COMPANY_NAME")>
      <cfset temp = StructInsert(hTmpStruct, "COMPANY_NAME", Variables.COMPANY_NAME)>
    </cfif>
    <cfif IsDefined("Variables.FEE_URL")>
      <cfset temp = StructInsert(hTmpStruct, "FEE_URL", Variables.FEE_URL)>
    </cfif>
    <cfif IsDefined("Variables.PROBLEM_EMAIL")>
      <cfset temp = StructInsert(hTmpStruct, "PROBLEM_EMAIL", Variables.PROBLEM_EMAIL)>
    </cfif>
    <cfif IsDefined("Variables.QUESTION_EMAIL")>
      <cfset temp = StructInsert(hTmpStruct, "QUESTION_EMAIL", Variables.QUESTION_EMAIL)>
    </cfif>
    <cfif IsDefined("Variables.SERVICE_EMAIL")>
      <cfset temp = StructInsert(hTmpStruct, "SERVICE_EMAIL", Variables.SERVICE_EMAIL)>
    </cfif>
    <cfif IsDefined("Variables.TIME_ZONE")>
      <cfset temp = StructInsert(hTmpStruct, "TIME_ZONE", Variables.TIME_ZONE)>
    </cfif>
    <cfif IsDefined("Variables.CYBERCASH_ERROR_EMAIL")>
      <cfset temp = StructInsert(hTmpStruct, "CYBERCASH_ERROR_EMAIL", Variables.CYBERCASH_ERROR_EMAIL)>
    </cfif>
    <cfif IsDefined("Variables.CC_MERCHANT_KEY")>
      <cfset temp = StructInsert(hTmpStruct, "CC_MERCHANT_KEY", Variables.CC_MERCHANT_KEY)>
    </cfif>
    <cfif IsDefined("Variables.CC_CYBERCASH_ID")>
      <cfset temp = StructInsert(hTmpStruct, "CC_CYBERCASH_ID", Variables.CC_CYBERCASH_ID)>
    </cfif>
    <cfif IsDefined("Variables.CYBER_CASH")>
      <cfset temp = StructInsert(hTmpStruct, "CYBER_CASH", Variables.CYBER_CASH)>
    </cfif>
    <cfif IsDefined("Variables.MODE_SWITCH")>
      <cfset temp = StructInsert(hTmpStruct, "MODE_SWITCH", Variables.MODE_SWITCH)>
    </cfif>
    <cfif IsDefined("Variables.AUCTION_MODE")>
      <cfset temp = StructInsert(hTmpStruct, "AUCTION_MODE", Variables.AUCTION_MODE)>
    </cfif>

    <!--- ret vals --->
    <cfset temp = "Caller.#Trim(Attributes.sStructName)#">
    <cfset "#temp#" = hTmpStruct>

  </cfif>

  <cfif not Variables.bValidName>

    <cfoutput>
      <!-- debug >> Invalid structure name.  App_globals structure not returned. -->
    </cfoutput>
  </cfif>
</cfif>

<cfsetting enablecfoutputonly="no">

<cfset app_globals_flag = 1>

</cfif>

<!--- Define image dimensions for display consistency --->
<cfset resizedImageWidth = 300>