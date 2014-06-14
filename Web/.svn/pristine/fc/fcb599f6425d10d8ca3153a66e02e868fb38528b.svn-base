<!-- header. -->
<!--- First time through is the header --->
<cfsetting enablecfoutputonly="Yes">
<cfinclude template="../includes/app_globals.cfm">
<!--- echo header --->

  
  <!--- get currency type --->
  <cfquery name="getCurrency" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
 
<cfoutput>
<table border=0 cellspacing=0 cellpadding=2 noshade width=640>
  <tr>
  	<td width=395 align=center><font size=2><b>Item</b></font></td>
    <td width=115 align=center><font size=2><b>Asking Price (#Trim(getCurrency.type)#)</b></font></td>
    <td width=40 align=center><font size=2><b>Offers</b></font></td>
    <td width=90 align=center><font size=2><b>Ends</b></font></td>
  </tr>
</cfoutput>
  