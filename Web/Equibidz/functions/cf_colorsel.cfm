<cfsetting EnableCFOutputOnly="YES">
<!---

     cf_colorsel.cfm

     Written by Jason Johnson
     February 22, 1999
     Beyond Solutions, Inc.

     This ColdFusion module displays a dropdown box for color selection, and
     provides an "other" choice and a textbox for entering a custom hex color
     value.

     Usage example: 
  
     <cfmodule template="..\functions\cf_colorsel.cfm"
               selectname="link"
               selected="ffffff">

--->

<!--- Verify correct parameters --->
<cfif not IsDefined ("Attributes.selectname")>
 Attribute not specified for cf_colorsel... Aborting...<br>
 <cfabort>
<cfelse>

 <!--- Output a select box first --->
 <cfoutput><td width=100></cfoutput>
  <cfset #color_codes# = "000000,000080,008000,800000,008080,800080,808000,772c1b,aaaaaa,0000bb,00bb00,bb0000,00bbbb,bb00bb,bbbb00,ff8000,4040ff,40ff40,ff0000,00ffff,ff00ff,ffff00,b5715a,ffffff,custom">
  <cfset #color_names# = "00 - Black,01 - Dark Blue,02 - Dark Green,03 - Dark Red,04 - Dark Cyan,05 - Dark Violet,06 - Dark Yellow,07 - Dark Brown,08 - Gray,09 - Blue,10 - Green,11 - Red,12 - Cyan,13 - Violet,14 - Yellow,15 - Orange,16 - Light Blue,17 - Light Green,18 - Light Red,19 - Light Cyan,20 - Light Violet,21 - Light Yellow,22 - Light Brown,23 - White,Custom Color">
  <cfif #listContains (color_codes, Attributes.selected)# is 0>
   <cfset #custom# = "1">
  <cfelse>
   <cfset #custom# = "0">
  </cfif>
  <cfoutput><select name="#attributes.selectname#"></cfoutput>
   <cfloop from="1" to="#listLen(color_codes)#" index="idx">
    <cfset #cur_code# = "#listGetAt (color_codes, idx)#">
    <cfset #cur_name# = "#listGetAt (color_names, idx)#">
    <cfoutput><option value="#listGetAt (color_codes, idx)#"<cfif (#Attributes.selected# is #cur_code#) or (#custom# is "1" and #cur_code# is "custom")> selected</cfif>>#cur_name#</option></cfoutput>
   </cfloop>
  <cfoutput></select></cfoutput>
 <cfoutput></td></cfoutput>
 <cfoutput>
  <td><input name="custom_#Attributes.selectname#" type="text" size=6 maxlength=6 <cfif #custom# is 1>value="#Attributes.selected#"</cfif>></td>
 </cfoutput>
</cfif>
<cfsetting EnableCFOutputOnly="NO">