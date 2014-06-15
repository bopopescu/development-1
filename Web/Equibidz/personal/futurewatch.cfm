<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
  

 

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">


  <!--- chk structure of "futurewatch" table --->
  <cfmodule template="chkTableStruct1.cfm"
    datasource="#DATASOURCE#">
    
 <!--- Check for invalid page access --->
 <cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="index.cfm">
 </cfif>

 <cfset #error_message# = "">

 <!--- Check for self-submission --->
 <cfif #isDefined ("submit")# is 0>
  <cfquery username="#db_username#" password="#db_password#" name="get_futurewatch" datasource="#DATASOURCE#">
   SELECT keywords, enabled
     FROM futurewatch
    WHERE user_id = #session.user_id#
  </cfquery>   
  <cfset #submit# = "">
  <cfif #get_futurewatch.recordcount# GT 0>
   <cfset #enabled# = "#get_futurewatch.enabled#">
   <cfset #keywords# = "#get_futurewatch.keywords#">
  <cfelse>
   <cfset #enabled# = "0">
   <cfset #keywords# = "">
  </cfif>
 <cfelse>
  <cfif #submit# is "Cancel">
   <cflocation url="main_page.cfm">
  </cfif>
  <cfset #submit# = #trim (submit)#>
  <cfif #isDefined ("enabled")# is 1>
   <cfset #enabled# = 1>
  <cfelse>
   <cfset #enabled# = 0>
  </cfif>
 </cfif>

 <!--- Check for update button --->
 <cfif #submit# is "Update">
  <cfif (#trim (keywords)# is "") and (#enabled# is 1)>
    <cfset #error_message# = "<font color=ff0000><b>ERROR:</b> You must specify 1 or more keywords to use this feature.</font>">
  <cfelse>
    <cfquery username="#db_username#" password="#db_password#" name="check_futurewatch" datasource="#DATASOURCE#">
        SELECT keywords, enabled
          FROM futurewatch
         WHERE user_id = #Session.user_id#
    </cfquery>   
    
    <cfif #check_futurewatch.recordcount# is 0>
      
     <cfset defLastSent = 0>
	 <cfinclude template = "inc_futurewatch_clean_kw.cfm">
	 
      <cfquery username="#db_username#" password="#db_password#" name="insert_futurewatch" datasource="#DATASOURCE#">
          INSERT INTO futurewatch
            (user_id, keywords, enabled, last_sent)
          VALUES
            (#Session.user_id#, '#keywords#', #enabled#, #defLastSent#);
      </cfquery>
    </cfif>
    <cfinclude template = "inc_futurewatch_clean_kw.cfm">
    <cfquery username="#db_username#" password="#db_password#" name="update_futurewatch" datasource="#DATASOURCE#">
        UPDATE futurewatch
           SET keywords = '#keywords#',
               enabled = #enabled#
         WHERE user_id = #Session.user_id#
    </cfquery>
    
    <!--- log update of future watch --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Future Watch Updated"
      details="KEYWORDS: #keywords#     ENABLED: #enabled#"
      user_id="#Session.user_id#">
    
    <cflocation url="main_page.cfm">
  </cfif>
 </cfif>

<cfsetting enablecfoutputonly="no">

<html>
 <head>
  <title>Personal Page: FutureWatch Settings</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">

 <cfoutput>

  <!--- The main table --->
  <!--- The main table --->
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4 color="000000"><b>Personal Page - FutureWatch Settings</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
       Our FutureWatch feature allows you to be automatically notified via email
       when certain items are placed up for auction.  You simply specify a list
       of keywords to look for in the title and description of new items, and
       we'll automatically notify you when items containing these keywords are
       added anywhere on the site.
       <br><br>
       <cfif #error_message# is not "">
        #error_message#<br>
       </cfif>
        <form action="futurewatch.cfm" method="post">
         <table border=0 cellspacing=0 cellpadding=3>
          <tr><td><b>Keywords:</b></td><td><input type="text" name="keywords" size=48 maxlength=255 value="#keywords#"></td><td>(Separated by commas)</td></tr>
          <tr><td><b>Enabled:</b></td><td><input type="checkbox" name="enabled"<cfif #enabled# is 1> checked</cfif>>&nbsp;Check this box to enable the FutureWatch feature.</td></tr>
<TR><TD><B>Example:</B></TD><TD>Sofa, Chair, Loveseat</TD></TR>
<TR><TD></TD><TD>Do not begin or end the list with a comma or use commas together. Also, do not use apostrophes or quotes.</TD></TR>
         </table>
         <br><br>
         <hr size=1 color=#heading_color# width=100%>
         <input type="submit" name="submit" value="Update" width=75>&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Cancel" width=75>
        </form>
      </font>
     </td>
    </tr>
    <tr><td>
     <br><br>
     <div align="center">

 <cfinclude template="nav.cfm">
</div>
      </td></tr></table></div><div align="center">
<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></cfoutput></div>
 </body>
</html>
