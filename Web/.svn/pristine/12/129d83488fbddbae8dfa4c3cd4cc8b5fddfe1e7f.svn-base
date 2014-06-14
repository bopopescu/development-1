
<cfinclude template = "../includes/app_globals.cfm">



<CFSET duration = "#form.duration#">
<CFSET fee = "#form.fee#">

<cfset ad_dur = REReplace(duration,"[^0-9]","","ALL")>


<cfset ad_fee = REReplace(fee,"[^0-9.]","","ALL")>


<CFIF isDefined('form.add')>
<CFIF ad_dur IS "" OR ad_fee IS "">
<CFLOCATION URL="admin.cfm?refuse=2">

<CFELSE>

<CFQUERY NAME="getAd_dur" DATASOURCE="#DATASOURCE#">
SELECT ad_dur FROM ad_defaults
WHERE ad_dur = #ad_dur#
</CFQUERY>
</CFIF>
<CFIF #getAd_dur.ad_dur# IS ad_dur>
<CFLOCATION URL="admin.cfm?refuse=1">
<cfelse>
<CFQUERY DATASOURCE="#DATASOURCE#">
INSERT INTO ad_defaults
(ad_dur,ad_fee)
VALUES(#ad_dur#,#ad_fee#)

</CFQUERY>

<cflocation url="admin.cfm">
</CFIF>

<CFELSEIF isDefined('form.delete')>
<CFSET duration = #trim(duration)#>
<CFQUERY DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
DELETE FROM ad_defaults
WHERE ad_dur = #duration#
</CFQUERY>

<cflocation url="admin.cfm">

</CFIF>



