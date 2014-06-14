
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
    <cfset pht_icon = " <img src=./images/pic.gif width=27 height=11>">
  <cfelse>
    <cfset pht_icon = "">
  </cfif>
<!--- set price --->
  <cfset price = "<b>" & numberformat(attributes.ask_price,numbermask) & "</b>">

<!--- set offers --->
  <cfif obo>
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

