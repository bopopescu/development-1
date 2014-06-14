<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/siteinfo.cfm $ $Revision: 2 $ $Date: 1/27/00 8:41p $ $Author: Davidh1 $ --->

<html>
 <head>
  <title>Visual Auction Server Administrator [Site Customization Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfparam name="error_message" default="">
 
 <cfsetting EnableCFOutputOnly="YES">

  <!--- Check to see what we need to do --->
  <cfif #isDefined ("submit")#>
    
    <cfif #trim (submit)# is "Apply">
      
      <!--- Check for custom colors --->
      <cfif #link_color# is "custom">
	  	<cfif custom_link_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for link.  </font>">
		</cfif>
        <cfset #link_color# = "#custom_link_color#">
      </cfif>
      <cfif #vlink_color# is "custom">
	  	<cfif custom_vlink_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for visited link.  </font>">
		</cfif>
        <cfset #vlink_color# = "#custom_vlink_color#">
      </cfif>
      <cfif #alink_color# is "custom">
	  	<cfif custom_alink_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for active link.  </font>">
		</cfif>
        <cfset #alink_color# = "#custom_alink_color#">
      </cfif>
      <cfif #text_color# is "custom">
	  	<cfif custom_text_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for page text.  </font>">
		</cfif>
        <cfset #text_color# = "#custom_text_color#">
      </cfif>
      <cfif #bg_color# is "custom">
	  	<cfif custom_bg_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for background.  </font>">
		</cfif>
        <cfset #bg_color# = "#custom_bg_color#">
      </cfif>
      <cfif #hrsending_color# is "custom">
	  	<cfif custom_hrsending_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for ending auction.  </font>">
		</cfif>
        <cfset #hrsending_color# = "#custom_hrsending_color#">
      </cfif>
      <cfif #listing_bgcolor# is "custom">
	  	<cfif custom_listing_bgcolor eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for listing background.  </font>">
		</cfif>
        <cfset #listing_bgcolor# = "#custom_listing_bgcolor#">
      </cfif>
      
	  <cfif error_message eq "">
      <!--- Update the database --->
      <cfquery username="#db_username#" password="#db_password#" name="update_link_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#link_color#'
           WHERE name = 'link_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_alink_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#alink_color#'
           WHERE name = 'alink_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_vlink_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#vlink_color#'
           WHERE name = 'vlink_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_text_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#text_color#'
           WHERE name = 'text_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_bg_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#bg_color#'
           WHERE name = 'bg_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_hrsending_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#hrsending_color#'
           WHERE name = 'hrsending_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_listing_bgcolor" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#listing_bgcolor#'
           WHERE name = 'listing_bgcolor'
      </cfquery>
      
      <!--- Write a new body tag include file --->
      <cffile action="write" file=#expandPath ("..\includes\bodytag.html")# output="<body bgcolor='#bg_color#' text='#text_color#' link='#link_color#' alink='#alink_color#' vlink='#vlink_color#'>">
      
      <!--- Write a new style sheet --->
      <cffile action="write" file=#expandPath ("../includes/stylesheet.css")# output="#trim (css_code)#">
      
      <!--- log update of site info --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Site Information Updated">
		
        </cfif>
    </cfif>
  </cfif>

 <!--- Pull default colors from the database --->
 <cfquery username="#db_username#" password="#db_password#" name="get_link_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'link_color'
 </cfquery>
 <cfset #link_color# = #get_link_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_alink_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'alink_color'
 </cfquery>
 <cfset #alink_color# = #get_alink_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_vlink_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'vlink_color'
 </cfquery>
 <cfset #vlink_color# = #get_vlink_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_text_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'text_color'
 </cfquery>
 <cfset #text_color# = #get_text_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_bg_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'bg_color'
 </cfquery>
 <cfset #bg_color# = #get_bg_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_hrsending_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'hrsending_color'
 </cfquery>
 <cfset #hrsending_color# = #get_hrsending_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #listing_bgcolor# = #get_listing_bgcolor.pair#>

 <!--- Read the style sheet file into a variable --->
 <cftry>
  <cffile action="read" file=#expandPath ("../includes/stylesheet.css")# variable="css_code">
  <cfcatch type="any"></cfcatch>
 </cftry>

 <cfsetting EnableCFOutputOnly="NO">
 
 <!--- Main page body --->
 <body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
  <font face="helvetica" size=2>
   <center>
    <!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900>
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>
<!---
<td></td>
<td></td>
--->
<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->

      <!--- Include the menubar --->
      <cfset #page# = "siteinfo">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=709>	    
         <tr>
          <td>
           <table border=0 cellspacing=0 cellpadding=5 width=100%>
            <tr>
             <td colspan=2>
              <font face="helvetica" size=2 color=000000>
               Use this page to administer the color settings of your <i>Auction Server</i> software.  If you do not<br>
               know how to use this administration tool, please <!---consult your user manual or --->
               click the help button in the upper right corner<br>
               of this window.
                           <hr size=1 color=#heading_color# width=100%> 
			   <cfif error_message neq "">
			   <table border=0 cellspacing=0 cellpadding=3>
                     <tr>
                      <td valign="top"><font face="helvetica" size=2><b>Status Messages: </b></font></td>
                      <td valign="top"><font face="helvetica" size=2><cfoutput>#error_message#</cfoutput></font></td>
                     </tr>
               	</table>
				</cfif>
              </font>
             </td>
            </tr>
            <tr>

             <!--- begin colors --->
             <form name="colorsForm" action="siteinfo.cfm" method="post">
             <td valign="top" align="left">
              &nbsp;<font face="Helvetica" size=2 color=000080><b>SITE COLOR CUSTOMIZATION:</b></font>
              <br>
              <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
               <tr bgcolor=bac1cf>
                <td>
                 <font face="helvetica" size=2>
                  <table border=0 cellspacing=0 cellpadding=0>
                   <tr bgcolor=cbeef9>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2><b>Color Selection</b></font></td>
                    <td><font face="helvetica" size=2><b>Custom</b></font></td>
                    <td align="right"><font face="helvetica" size=2><b>Sample</b></font>&nbsp;</td>
                   </tr>

                   <!--- Link color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Link:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="link_color" selected="#link_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#link_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>

                   <!--- VLink color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Visited link:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="vlink_color" selected="#vlink_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#vlink_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>
   
                   <!--- ALink color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Active link:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="alink_color" selected="#alink_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#alink_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>

                   <!--- Text color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Page text:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="text_color" selected="#text_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#text_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>
   
                   <!--- Background color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Background:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="bg_color" selected="#bg_color#">
                    <cfoutput>
                     <td align="right">
                      <table border=0 bordercolor=000000 cellspacing=0 cellpadding=2>
                       <tr>
                        <td bgcolor="#bg_color#">&nbsp;<font face="helvetica" size=2>Current</font>&nbsp;</td>
                       </tr>
                      </table>                      
                     </td>
                    </cfoutput>
                   </tr>
                   <tr>
                    <td colspan=4>            <hr size=1 color=#heading_color# width=100%> </td>
                   </tr>

                   <!--- Ending auction color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Ending auction:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="hrsending_color" selected="#hrsending_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#hrsending_color#">Current</font></cfoutput>
                    </td>
                   </tr>

                   <!--- Listing background color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Listing background:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="listing_bgcolor" selected="#listing_bgcolor#">
                    <cfoutput>
                     <td align="right">
                      <table border=0 bordercolor=000000 cellspacing=0 cellpadding=2>
                       <tr>
                        <td bgcolor="#listing_bgcolor#">&nbsp;<font face="helvetica" size=2>Current</font>&nbsp;</td>
                       </tr>
                      </table>                      
                     </td>
                    </cfoutput>
                   </tr>

                   <!--- Page stylesheet --->
                   <tr>
                    <td colspan=4>            <hr size=1 color=#heading_color# width=100%> </td>
                   </tr>
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Page CSS code:</b>&nbsp;
                     </font>
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="css_code" cols=30 rows=6>#trim (HTMLEditFormat (css_code))#</textarea></cfoutput>
                    </td>
                   </tr>

                   <!--- Color chart --->
                   <tr>
                    <td colspan=4>            <hr size=1 color=#heading_color# width=100%> </td>
                   </tr>
                   <tr>
                    <td valign="top">&nbsp;<font face="helvetica" size=2><b>Predefined<br>&nbsp;color<br>&nbsp;table:</b></font></td>
                    <td colspan=3>                      
                     <img border=0 src="./images/color_table.gif">&nbsp;
                    </td>
                   </tr>

                  </table>
                 </font>
                </td>
               </tr>
              </table>
             </td>
             <!--- end colors --->
		 
            </tr>
            <tr>
             <td><input type="submit" name="submit" value=" Apply "></td>
            </tr>
           </table>
          </form>
         </td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>
