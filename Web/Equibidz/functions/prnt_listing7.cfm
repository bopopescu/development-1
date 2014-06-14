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
<cfinclude template="../includes/app_globals.cfm">

<!--- define TIMENOW --->
  <cfmodule template="./timenow.cfm">

<cfif isDefined('Attributes.itemnum')>
  <cfquery username="#db_username#" password="#db_password#" NAME="getMode" DATASOURCE="#DATASOURCE#">
    SELECT auction_mode, featured_studio, status, date_end, user_id
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
    

  <table border=1 cellspacing=1 cellpadding=2 noshade width=100%>
  <tr>
      <td width=120 align=center valign=top><font size=2><b>Item</b></font></td>
	  <td width=80 align=center valign=top><font size=2><b>Start<br> Price</b></font></td>
      <td width=80 align=center valign=top><font size=2><b>Current<br> Price (#Trim(getCurrency.type)#)</b></font></td>
      <td width=60 align=center valign=top><font size=2><b>Qty</b></font></td>
	  <td width=60 align=center valign=top><font size=2><b>Bids</b></font></td>
	  <td width=80 align=center valign=top><font size=2><b>Start<br> Date</b></font></td>
      <td width=80 align=center valign=top><font size=2><b>End Date</b></font></td>
	  <td width=80 align=center valign=top><font size=2><b>Time<br> Left</b></font></td> 
	  
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
      <cfset price = NumberFormat(Attributes.highest,numbermask)>
    <cfelse>
      <cfset price = NumberFormat(Attributes.minimum_bid,numbermask)>
    </cfif>
  <cfelse>
    <cfif IsNumeric(Attributes.lowest)>
      <cfset price = NumberFormat(Attributes.lowest,numbermask)>
    <cfelse>
      <cfset price = NumberFormat(Attributes.maximum_bid,numbermask)>
    </cfif>
  </cfif>
  <!--- ************** --->
 
 <cfquery username="#db_username#" password="#db_password#" name="temsp" datasource="#DATASOURCE#">
   update items
   set current_price4=#price#
   WHERE itemnum = #Attributes.itemnum#
    
 </cfquery>  
 
  <cfset startprice = "<b>" & DecimalFormat(Attributes.minimum_bid) & "</b>"> 
  
  
   <!--- set bids --->
  <cfif Attributes.quantity>
    <cfset qty = Attributes.quantity>
  <cfelse>
    <cfset qty = "-">
  </cfif>
  
  <!--- set bids --->
  <cfif Attributes.totalbids>
    <cfset bids = Attributes.totalbids>
  <cfelse>
    <cfset bids = "-">
  </cfif>

  <!--- set new/(hot) --->
  <cfif Attributes.totalbids GTE Attributes.hotbids>
    <cfset new_icon = "<font size=1 color=ff0000><b>HOT</b></font> ">
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
  
   <!--- set started --->
  <cfif DateDiff("h", Attributes.TIMENOW, Attributes.date_start) LTE Attributes.listingending>
    <cfset started = "<font color=" & Attributes.endingcolor & ">" & DateFormat(Attributes.date_start, "mm/dd") & " " & TimeFormat(Attributes.date_start, "HH:mm") & "</font>">
  <cfelse>
    <cfset started = DateFormat(Attributes.date_start, "mm/dd") & " " & TimeFormat(Attributes.date_start, "HH:mm")>
  </cfif>

  <!--- *********** --->
  <!--- define time left --->
 	
 
    <cfset timeleft = (Attributes.date_end) - TIMENOW>
    <cfif timeleft GT 1>
      <cfset daysleft = IIf(Int(timeleft) LT 0, DE("0"), "Int(timeleft)")>
      <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
      <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
      <cfset dayslabel = IIf(daysleft IS 1, DE("day"), DE("days"))>
      <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
      <cfset timeleft = daysleft & " " & dayslabel & ", " & hrsleft & " " & hrslabel & " +">
    <cfelse>
      <cfset hrsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('h', timeleft)")>
      <cfset minsleft = IIf(Int(timeleft) LT 0, DE("0"), "DatePart('n', timeleft)")>
      <cfset hrslabel = IIf(hrsleft IS 1, DE("hour"), DE("hours"))>
      <cfset minslabel = IIf(minsleft IS 1, DE("min"), DE("mins"))>
      <cfset timeleft = hrsleft & " " & hrslabel & ", " & minsleft & " " & minslabel & " +">
    </cfif>

	
    
  <!--- *********** --->
  
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
	
	
	<!--- get seller info--->
  <cfquery username="#db_username#" password="#db_password#" name="get_seller_info" datasource="#datasource#">
  	SELECT user_id, nickname
	FROM users
	WHERE user_id = #getMode.user_id#
  </cfquery>
	
	<!--- get winning bidder --->
  <cfquery username="#db_username#" password="#db_password#" name="get_winning_bidder" datasource="#datasource#">
  	SELECT U.user_id, U.nickname
	FROM bids B, users U
	WHERE B.winner = 1
	AND B.itemnum = #Attributes.itemnum#
	AND B.user_id = U.user_id
  </cfquery>
  
  <!--- check if auction has buynow --->
  <cfquery username="#db_username#" password="#db_password#" name="check_buynow" datasource="#datasource#">
  	SELECT buynow
	FROM items
	WHERE itemnum = #Attributes.itemnum#
  </cfquery>
  
  <!--- check if auction has auction_cancel --->
  <!--- <cfquery username="#db_username#" password="#db_password#" name="check_auction_cancel" datasource="#datasource#">
  	SELECT auction_cancel
	FROM items
	WHERE auction_cancel = 1
	AND itemnum = #Attributes.itemnum#
  </cfquery> --->
  
  <cfoutput>

    <tr#rowcolor#>
	<!--- <td width="124">&nbsp;</td>  --->
	<td width=120>&nbsp;#new_icon#<a href="#Attributes.VAROOT#/listings/details/index.cfm?itemnum=#Attributes.itemnum#">#boldstart##Trim(Attributes.itemtitle)##boldend#</a>#reverse##pht_icon##snd_icon#<cfif check_buynow.buynow eq 1>&nbsp;<img src="#VAROOT#/images/buynow.jpg" border="0"></cfif>#ban_info#</td>
	<td width=80 align=center valign=middle>#startprice#</td>
	<td width=80 align=center valign=middle>#price#</td>
	<td width=60 align=center valign=middle>#qty#</td>
	<td width=60 align=center valign=middle>#bids#</td>
	<td width=80 align=center valign=middle>#started#</td>
	<td width=80 align=center valign=middle>#ends# CST</td>
	<td width=80 align=center valign=middle>#timeleft#</td> 
	</tr>
  <!--- </cfif> --->
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



