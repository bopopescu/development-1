<!-- prnt_ads. -->
<!--- Functions: HEADER, LISTING, BLANK, FOOTER --->
<cfsetting enablecfoutputonly="Yes">
<!--- echo header --->
<cfif Attributes.part IS "HEADER">
  
<!--- get currency type --->
<cfquery name="getCurrency" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
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
  
<!--- Echo Listings --->
<cfelseif Attributes.part IS "LISTING">

<!--- get bids --->
<cfquery name="Countoffers" datasource="#Attributes.DATASOURCE#" username="#Attributes.db_username#" password="#Attributes.db_password#">
	SELECT COUNT(adnum) AS total
    FROM ad_offers
    WHERE adnum = #attributes.adnum#
</cfquery>

<cfset totaloffers=Countoffers.total>

  <cfif attributes.currentrow MOD 2>
    <cfset rowcolor = ' bgcolor="' & attributes.rowcolor & '"'>
  <cfelse>
    <cfset rowcolor = "">
  </cfif>

  <!--- set new/(hot) --->
  <cfif totaloffers GTE attributes.bids4hot>
    <cfset new_icon = "<font size=1 color=ff0000><b>HOT</b></font> ">
  <cfelseif DateDiff("d", attributes.date_start, attributes.TIMENOW) LTE attributes.listingnew>
    <cfset new_icon = "<font size=1 color=ff0000>NEW!</font> ">
  <cfelse>
    <cfset new_icon = "">
  </cfif>
  
  <!--- set photo --->
  <cfif Right(attributes.picture_url, 4) IS ".gif" 
   OR Right(attributes.picture_url, 4) IS ".jpg"
   OR Right(attributes.picture_url, 4) IS ".png">
    <cfset pht_icon = " <font size=1 color=009900>PIC</font>">
  <cfelse>
    <cfset pht_icon = "">
  </cfif>

  <!--- set price --->
  <cfset price = "<b>" & numberformat(attributes.ask_price,attributes.numbermask) & "</b>">

  <!--- set offers --->
  <cfif Attributes.obo>
    <cfset bids = "N/A">
  <cfelse>
    <cfif totaloffers GT 0>
      <cfset bids = totaloffers>
    <cfelse>
      <cfset bids = "-">
    </cfif>
  </cfif>

  <!--- set ends --->
  <cfif DateDiff("h", attributes.TIMENOW, attributes.date_end) LTE attributes.hrsending>
    <cfset ends = "<font color=" & attributes.hrsending_color & ">" & DateFormat(attributes.date_end, "mm/dd") & " " & TimeFormat(attributes.date_end, "HH:mm") & "</font>">
  <cfelse>
    <cfset ends = DateFormat(attributes.date_end, "mm/dd") & " " & TimeFormat(attributes.date_end, "HH:mm")>
  </cfif>
<cfoutput><tr#rowcolor#><td>#new_icon#<a href="ad_details.cfm?adnum=#attributes.adnum#">#Trim(attributes.title)#</a>#pht_icon#</td><td align=right valign=top>#price#</td><td align=center valign=top>#bids#</td><td align=center valign=top>#ends#</td></tr></cfoutput>


<!--- echo blank listing --->
<cfelseif Attributes.part IS "BLANK">

  <cfoutput>
    <tr bgcolor="#Attributes.rowcolor#">
      <td align=center> - </td>
      <td align=center> - </td>
      <td align=center> - </td>
      <td align=center> - </td>
    </tr>
  </cfoutput>
  
<!--- echo footer --->
<cfelseif Attributes.part IS "FOOTER">

<cfoutput></table>
</cfoutput>

</cfif>