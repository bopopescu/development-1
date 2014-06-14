<!---
  prnt_listing.cfm
  includes reverse auction and studio
  11/30/99
 
  prints out listing info...
  
  HEADER - the opening table, column headers, etc
  LISTING - a listing w/ its info, opt. params required
  BLANK - a blank listing, for no records, requires "rowcolor"
  FOOTER - closing table, etc.
  
  <cfmodule template="prnt_listing.cfm"
    part="[HEADER|LISTING|BLANK|FOOTER]"
    [datasource="[system dsn (for HEADER)]"]
    [itemnum="[item number]"]
    [itemtitle="[item title]"]
    [currentrow="[row number]"]
    [rowcolor="[row bgcolor]"
    [boldtitle="[bold_title]"]
    [picture="[picture url]"]
    [sound="[sound url]"]
    [banner="[banner]"]
    [banner_line="[banner line]"]
    [highest="[highest bid]"]
    [minimum_bid="[minimum bid]"]
    [totalbids="[number of bids]"]
    [hotbids="[number of bids for hot]"]
    [TIMENOW="[TIMENOW]"]
    [listingnew="[days listing new]"]
    [date_start="[date auction started]"]
    [date_end="[date auction ends]"]
    [listingending="[# hrs considered ending]"]
    [endingcolor="[color for listing ending]"]
    [VAROOT="[global var VAROOT]"]>
--->



<cfsetting enablecfoutputonly="Yes">
<cfinclude template="../../includes/app_globals.cfm">


<cfif isDefined('Attributes.itemnum')>
  <cfquery username="#db_username#" password="#db_password#" NAME="getMode" DATASOURCE="#DATASOURCE#">
    SELECT auction_mode, featured_studio, status
      FROM items
     WHERE itemnum = #Attributes.itemnum#
  </CFQUERY>
  <cfif getmode.auction_mode is 0>
    <cfset auction_mode = 0>
  <cfelse>
    <cfset auction_mode = 1>
  </cfif>
</cfif>
<CFPARAM NAME="auction_mode" DEFAULT="0">




<!--- def vals --->
<cfparam name="Attributes.VAROOT" default="">

<!--- echo header --->
<cfif Attributes.part IS "HEADER">


  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.datasource#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  <cfoutput>
  <table border=0 cellspacing=0 cellpadding=2 noshade width=640>
    <tr>
      <td width=420 align=center><font size=2><b>Item</b></font></td>
      <td width=90 align=center><font size=2><b>Price (#Trim(getCurrency.type)#)</b></font></td>
      <td width=90 align=center><font size=2><b>Ends</b></font></td>
    </tr>
  </table>
  

  <table border=0 cellspacing=0 cellpadding=2 noshade width=640>
    <tr>
      <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
     </tr>
  </cfoutput>

<!--- echo listing --->
<cfelseif Attributes.part IS "LISTING">

  <!--- set row bgcolor, 1st opt is odd row --->
  <cfif Attributes.currentrow MOD 2>
    <cfset rowcolor = ' bgcolor="' & Attributes.rowcolor & '"'>
  <cfelse>
    <cfset rowcolor = "">
  </cfif>
  
  <!--- set boldtitle --->
  <cfset boldstart = IIf(Attributes.boldtitle, DE("<b>"), DE(""))>
  <cfset boldend = IIf(Attributes.boldtitle, DE("</b>"), DE(""))>
  
  <!--- set photo --->
  <cfif Right(Attributes.picture, 4) IS ".gif" 
    OR Right(Attributes.picture, 4) IS ".jpg"
    OR Right(Attributes.picture, 4) IS ".png">
    <cfset pht_icon = " <font size=1 color=00ff00>PIC!</font>">
  <cfelse>
    <cfset pht_icon = "">
  </cfif>
  
  <!--- set sound --->
  <cfif Right(Attributes.sound, 4) IS ".wav" 
   OR Right(Attributes.sound, 3) IS ".au" 
   OR Right(Attributes.sound, 3) IS ".ra" 
   OR Right(Attributes.sound, 4) IS ".mp3" 
   OR Right(Attributes.sound, 4) IS ".mid">
    <cfset snd_icon = " <font size=1 color=ffa500>SOUND!</font>">
  <cfelse>
    <cfset snd_icon = "">
  </cfif>
  
  <!--- set banner info --->
  <cfif Attributes.banner>
    <cfset ban_info = "<br>&nbsp;&nbsp;<font size=1 color=ee82ee>BANNER!</font> " & Trim(Attributes.banner_line)>
  <cfelse>
    <cfset ban_info = "">
  </cfif>

  
    <!--- set price --->
    <cfset price = Attributes.price>
  

  <!--- set bids --->
  <cfif Attributes.totalbids>
    <cfset bids = Attributes.totalbids>
  <cfelse>
    <cfset bids = "-">
  </cfif>
  

  <!--- set new/(hot) --->
  <cfif Attributes.totalbids GTE Attributes.hotbids>
    <cfset new_icon = "">
  <cfelseif DateDiff("d", Attributes.date_start, Attributes.TIMENOW) LTE Attributes.listingnew>
    <cfset new_icon = "<font size=1 color=ff0000>NEW!</font> ">
  <cfelse>
    <cfset new_icon = "">
  </cfif>


  <!--- set ends --->
  <cfif DateDiff("h", Attributes.TIMENOW, Attributes.date_end) LTE Attributes.listingending>
    <cfset ends = "<font color=" & Attributes.endingcolor & ">" & DateFormat(Attributes.date_end, "mm/dd") & " " & TimeFormat(Attributes.date_end, "HH:mm") & "</font>">
  <cfelse>
    <cfset ends = DateFormat(Attributes.date_end, "mm/dd") & " " & TimeFormat(Attributes.date_end, "HH:mm")>
  </cfif>

  <cfif #getMode.auction_mode# is 1>
    <cfset reverse = '<IMG SRC="../../images/R_reverse.gif" width=22 height=17 border=0 alt="This is a Reverse Auction">'>
  <cfelse>
    <cfset reverse = "">    
  </cfif>



  <cfif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "personal">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"personal\","thumbs\")#>
  <cfelseif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "listings\featured\">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\featured\","thumbs\")#>
  <cfelseif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "listings">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\","thumbs\")#>
  <cfelseif   GetDirectoryFromPath(GetTemplatePath()) CONTAINS "search">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"search\","thumbs\")#>
  <cfelse>    
  </cfif> 

     

  <cfif #Attributes.featured_studio# IS 1 and #Attributes.show_thumbs# IS 1>
    <cfif fileExists("#thePath##Attributes.itemnum#.jpg")>
      <cfset theThumb = "<td align=center><IMG src=#varoot#/thumbs/#Attributes.itemnum#.jpg></td>">
    <cfelseif fileExists("#thePath##Attributes.itemnum#.gif")>
      <cfset theThumb = "<td align=center><IMG src=#varoot#/thumbs/#Attributes.itemnum#.gif></td>">
    <cfelse>
      <cfset theThumb = "<td width=124>&nbsp;</td>">
    </cfif>      
  </cfif>

  
  <cfoutput>
  <cfif #Attributes.featured_studio# IS 1 and #Attributes.show_thumbs# IS 1>
    <tr#rowcolor#>#theThumb#<td width=296>&nbsp;#new_icon#<a href="#Attributes.VAROOT#/classified/ad_details.cfm?adnum=#Attributes.itemnum#">#boldstart##Trim(Attributes.itemtitle)##boldend#</a>#reverse##pht_icon##snd_icon##ban_info#</td><td width=90 align=right valign=middle>#price#</td><td width=40 align=center valign=middle></td><td width=90 align=center valign=middle>#ends#</td></tr>
  <cfelse>
    <tr#rowcolor#><td>&nbsp;</td><td width=420>&nbsp;#new_icon#<a href="#Attributes.VAROOT#/classified/ad_details.cfm?adnum=#Attributes.itemnum#">#boldstart##Trim(Attributes.itemtitle)##boldend#</a>#reverse##pht_icon##snd_icon##ban_info#</td><td width=90 align=right valign=middle>#price#</td><td width=40 align=center valign=middle></td><td width=90 align=center valign=middle>#ends#</td></tr>
  </cfif>
  </cfoutput>
  
  

<!--- echo blank listing --->
<cfelseif Attributes.part IS "BLANK">

  <cfoutput>
    <tr bgcolor="#Attributes.rowcolor#">
      <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    </tr>
  </cfoutput>

<!--- echo footer --->
<cfelseif Attributes.part IS "FOOTER">

<cfoutput></table>
</cfoutput>

</cfif>
<cfsetting enablecfoutputonly="No">
