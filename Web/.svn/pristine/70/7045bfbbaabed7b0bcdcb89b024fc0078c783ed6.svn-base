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
<!--- <cfinclude template="../includes/app_globals.cfm"> --->


<cfif isDefined('Attributes.itemnum')>
  <cfquery username="#Attributes.db_username#" password="#Attributes.db_password#" NAME="getMode" DATASOURCE="#Attributes.DATASOURCE#">
    SELECT auction_mode, featured_studio, status, studio
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
  <cfquery username="#Attributes.db_username#" password="#Attributes.db_password#" name="getCurrency" datasource="#Attributes.datasource#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <cfoutput>
  <table border=0 cellspacing=0 cellpadding=2 noshade width=800>
    <tr bgcolor="#Attributes.heading_color#">
      <td width=420 align=center style="color:#Attributes.heading_fcolor#; font-family:#Attributes.heading_font#"><b>Item</b></td>
      <td width=90 align=center style="color:#Attributes.heading_fcolor#; font-family:#Attributes.heading_font#"><b>Price (#Trim(getCurrency.type)#)</b></td>
      <td width=40 align=center style="color:#Attributes.heading_fcolor#; font-family:#Attributes.heading_font#"><b>Bids</b></td>
      <td width=90 align=center style="color:#Attributes.heading_fcolor#; font-family:#Attributes.heading_font#"><b>Ends</b></td>
    </tr>
  </table>

<cfset img_width=124>  
<cfset img_height=110>  

  <table border=0 cellspacing=0 cellpadding=2 noshade width=800>
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

  <cfif auction_mode is 0>
    <!--- set price --->
    <cfif IsNumeric(Attributes.highest)>
      <cfset price = numberFormat(Attributes.highest,Attributes.numbermask)>
    <cfelse>
      <cfset price = numberFormat(Attributes.minimum_bid,Attributes.numbermask)>
    </cfif>
  <cfelse>
    <cfif IsNumeric(Attributes.lowest)>
      <cfset price = numberFormat(Attributes.lowest,Attributes.numbermask)>
    <cfelse>
      <cfset price = numberFormat(Attributes.maximum_bid,Attributes.numbermask)>
    </cfif>
  </cfif>

  <!--- set bids --->
  <cfif Attributes.totalbids>
    <cfset bids = Attributes.totalbids>
  <cfelse>
    <cfset bids = "-">
  </cfif>
  

  <!--- set new/(hot) --->
  <cfif Attributes.totalbids GTE Attributes.hotbids>
    <cfset new_icon = "<font size=1 color=ff0000><b>HOT!</b></font> ">
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
  <cfelseif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "listings\categories\">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\categories\","thumbs\")#>
  <cfelseif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "listings\featured\">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\featured\","thumbs\")#>
  <cfelseif GetDirectoryFromPath(GetTemplatePath()) CONTAINS "listings">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\","thumbs\")#>
  <cfelseif   GetDirectoryFromPath(GetTemplatePath()) CONTAINS "search">
    <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"search\","thumbs\")#>
  <cfelse>    
  </cfif> 

     

  <cfif #getMode.studio# IS 1 and #Attributes.show_thumbs# IS 1>
    <cfif fileExists("#thePath##Attributes.itemnum#.jpg")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##Attributes.itemnum#.jpg">--->
<cfif img_height is "" or img_width is "">
 <cfset theThumb = "<td width=64><table bgcolor=000000><tr><td align=center width=64 height=64><a href=#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#><IMG src=#Attributes.varoot#/thumbs/#Attributes.itemnum#.jpg width=64 height=64 border=0></a></td></tr></table></td>">
<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 64>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 64>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>
      <cfset theThumb = "<td align=center><table bgcolor=000000><tr><td align=center width=64 height=64><a href=#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#><IMG src=#Attributes.varoot#/thumbs/#Attributes.itemnum#.jpg width=124 height=110 border=0></a></td></tr></table></td>">
</cfif>
    <cfelseif fileExists("#thePath##Attributes.itemnum#.gif")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##Attributes.itemnum#.gif">--->
<cfif img_height is "" or img_width is "">
 <cfset theThumb = "<td width=64><table bgcolor=000000><tr><td align=center width=64 height=64><a href=#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#><IMG src=#Attributes.varoot#/thumbs/#Attributes.itemnum#.gif width=64 height=64 border=0></a></td></tr></table></td>">
<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 64>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 64>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>
      <cfset theThumb = "<td align=center><table bgcolor=000000><tr><td align=center width=64 height=64><a href=#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#><IMG src=#Attributes.varoot#/thumbs/#Attributes.itemnum#.gif width=124 height=110 border=0></a></td></tr></table></td>">
</cfif>


    <cfelse>
      <cfset theThumb = "<td width=64>&nbsp;</td>">
    </cfif>      
  </cfif>

  <!--- check if auction has buynow --->
  <cfquery username="#Attributes.db_username#" password="#Attributes.db_password#" name="check_buynow" datasource="#Attributes.datasource#">
  	SELECT buynow, buynow_price
	FROM items
	WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  <cfoutput>
  <cfif #getMode.studio# IS 1 and #Attributes.show_thumbs# IS 1>
    <tr#rowcolor#>#theThumb#<td width=356><a href="#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#"><font color=green><b><i>#attributes.itemnum#</i></b></font></a>&nbsp;&nbsp;#new_icon#<a href="#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#">#boldstart##Trim(Attributes.itemtitle)##boldend#</a>#reverse##pht_icon##snd_icon#<cfif check_buynow.buynow eq 1><cfif price lte check_buynow.buynow_price>&nbsp;<img src="#Attributes.VAROOT#/images/buynow.gif" border="0"></cfif></cfif>#ban_info#</td><td width=90 align=right valign=middle><b>#price#</b></td><td width=40 align=center valign=middle>#bids#</td><td width=90 align=center valign=middle>#ends#</td></tr>
  <cfelse>
    <tr#rowcolor#><td>&nbsp;</td><td width=480><a href="#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#"><font color=green><b><i>#attributes.itemnum#</i></b></font></a>&nbsp;&nbsp;#new_icon#<a href="#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#">#boldstart##Trim(Attributes.itemtitle)##boldend#</a>#reverse##pht_icon##snd_icon#<cfif check_buynow.buynow eq 1><cfif price lte check_buynow.buynow_price>&nbsp;<img src="#Attributes.VAROOT#/images/buynow.gif" border="0"></cfif></cfif>#ban_info#</td><td width=90 align=right valign=middle><b>#price#</b></td><td width=40 align=center valign=middle>#bids#</td><td width=90 align=center valign=middle>#ends#</td></tr>
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
