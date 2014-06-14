<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
<cfinclude template = "../includes/app_globals.cfm">
<!--- Include session tracking template (also sets link colors) --->
<cfinclude template="../includes/session_include.cfm">


<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>

<cfif #trim(submit)# is "Close">
    <script language="JavaScript">window.close( 'this' )</script>
</cfif>

<cfif #trim(submit)# is "Add" AND #sel_pair# is not "">
  <cfset sel_id = #selected_tab_item#>
  <cfquery username="#db_username#" password="#db_password#" name="add_tabitem" datasource="#DATASOURCE#">
      INSERT INTO defaults (name, pair) VALUES ('#tab#', '#sel_pair#')
  </cfquery>
</cfif>

<cfif #trim(submit)# is "Save" AND #sel_pair# is not "">
  <cfset sel_id = #selected_tab_item#>
  <cfquery username="#db_username#" password="#db_password#" name="sav_tabitem" datasource="#DATASOURCE#">
      UPDATE defaults
      SET pair = '#sel_pair#'
      WHERE id = #sel_id#
  </cfquery>
</cfif>

<cfif #trim(submit)# is "Delete">
  <cfset sel_id = #selected_tab_item#>
  <cfquery username="#db_username#" password="#db_password#" name="del_tabitem" datasource="#DATASOURCE#">
     DELETE FROM defaults WHERE id = #sel_id#
  </cfquery>       
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_tabdata" datasource="#DATASOURCE#">
   SELECT id, pair
   FROM defaults
   WHERE name = '#tab#'
   ORDER BY pair ASC
</cfquery>

<cfif #trim(submit)# is "Retrieve">
  <cfset sel_id = #selected_tab_item#>
  <cfquery username="#db_username#" password="#db_password#" name="get_tabitem" datasource="#DATASOURCE#">
      SELECT id, pair
      FROM defaults
      WHERE id = #sel_id#
  </cfquery>
  <cfset sel_id = #get_tabitem.id#>
  <cfset sel_pair = #get_tabitem.pair#>
<cfelse>
  <cfset sel_id = #get_tabdata.id#>
  <cfset sel_pair = "">
</cfif>


<cfif #tab# is "breed">
  <cfset tabname ="Breed">
<cfelseif #tab# is "color">
  <cfset tabname ="Color">
<cfelseif #tab# is "height">
  <cfset tabname ="Height">
<cfelseif #tab# is "bloodline">
  <cfset tabname ="Bloodline">
<cfelseif #tab# is "discipline">
  <cfset tabname ="Discipline">
<cfelseif #tab# is "experience">
  <cfset tabname ="Experience">
<cfelseif #tab# is "attributes">
  <cfset tabname ="Attributes">
<cfelseif #tab# is "temperament">
  <cfset tabname ="Temperament">
<cfelseif #tab# is "location">
  <cfset tabname ="Location">
<cfelseif #tab# is "list_type">
  <cfset tabname ="List Type">
<cfelseif #tab# is "dollar_type">
  <cfset tabname ="Dollar Type">
<cfelseif #tab# is "Sex">
  <cfset tabname ="Sex">
</cfif>
<cfoutput>

<html>
 <head>
  <title>Equibidz Auction Server Administrator [Auctions]</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>
<body>

<center>
<form name="TabForm" action="./auctions_sub1.cfm" method="post">
<input type="hidden" name="tab" value="#tab#">
<table border=0 cellspacing=0 cellpadding=0 width=300>
    <tr><td colspan=3>
       <font size=4 color="000000"><b>#tabname# Table Update</b></font><br>
       <font size=2 color="000000">You can update the table from here.</font><br>
    </td></tr>
    <tr><td colspan=3>&nbsp;</td></tr>
    <tr><td colspan=1>
        <select name="selected_tab_item" size=10 width=100>
           <cfif #get_tabdata.recordcount# gt 0>
               <cfset fpair = #get_tabdata.pair#>
               <cfloop query="get_tabdata">
                   <option value="#id#"<cfif #id# is #sel_id#> selected</cfif>>#pair#</option>
               </cfloop>
           <cfelse>
               <option value="0" selected>< No Data ></option>
           </cfif>
        </select>
        </td>
        <td width=5>&nbsp;</td>
        <td align="left" valign="top">
          <table border=0 cellspacing=0 cellpadding=0>
             <tr><td align="left"><font size=2 color="000000">&nbsp;Add/Update List Item here:</font></td></tr>
             <tr><td align="left"><input type="text" name="sel_pair" value="#sel_pair#" size=24></td></tr>
             <tr><td align="center">
                 <cfif #trim(submit)# is "Retrieve">
                    <input type="submit" name="submit" value="Save">
                    <input type="submit" name="submit" value="Cancel">
                 <cfelse>
                    <input type="submit" name="submit" value="Add">
                 </cfif>   
             </td></tr>           
          </table>   
        </td>
    </tr>    
    <tr><td colspan=3 align="left">
        <input type="submit" name="submit" value="Retrieve">
        <input type="submit" name="submit" value="Delete">
        <input type="submit" name="submit" value="Close">
    </td></tr>
</table>
</form>
</cfoutput>
</center>
</body>
</html>