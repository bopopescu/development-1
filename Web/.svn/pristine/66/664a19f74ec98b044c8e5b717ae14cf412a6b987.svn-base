
<cfinclude template = "../../includes/app_globals.cfm">



<CFSET duration = "#form.duration#">
<CFSET fee = "#form.fee#">

<cfset ad_dur = REReplace(duration,"[^0-9]","","ALL")>


<cfset ad_fee = REReplace(fee,"[^0-9.]","","ALL")>




<CFIF isDefined('form.add')>
<CFIF ad_dur IS "" OR ad_fee IS "">
<CFLOCATION URL="ad_mngr.cfm?refuse=2">

<CFELSE>

<CFQUERY NAME="getAd_dur" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
SELECT ad_dur FROM ad_defaults
WHERE ad_dur = #ad_dur#
</CFQUERY>
</CFIF>
<CFIF #getAd_dur.ad_dur# IS ad_dur>
<CFLOCATION URL="ad_mngr.cfm?refuse=1">
<cfelse>
<CFQUERY datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
INSERT INTO ad_defaults
(ad_dur,ad_fee)
VALUES(#ad_dur#,#ad_fee#)

</CFQUERY>

<cflocation url="ad_mngr.cfm">
</CFIF>

<CFELSEIF isDefined('form.delete')>



<CFIF ad_dur IS "" OR ad_fee IS "">
<CFLOCATION URL="ad_mngr.cfm?refuse=2">

<cfelse>
<CFSET duration = #trim(duration)#>
<CFQUERY datasource="#DATASOURCE#" username="#db_username#" password="#db_password#" DBTYPE="ODBC">
DELETE FROM ad_defaults
WHERE ad_dur = #duration#
</CFQUERY>
</cfif>
<cflocation url="ad_mngr.cfm">

</CFIF>



