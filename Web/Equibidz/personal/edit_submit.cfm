<!---

    edit_submit.cfm
    
      The submit to page for items coming from the edit preview page;
    this updates the data in the database from the session variables.
    
    08-Apr-1999
    Jason Johnson

--->

<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- Check for item storage session variables --->
<cfif #isDefined ("session.held_item")# is 1>
 <cfif #session.held_item# is "0">
  <cflocation url="index.cfm">
 </cfif>
<cfelse>
  <cflocation url="index.cfm">
</cfif>

<cftry>
  <!--- include globals --->
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<cfif #session.category2# is "">
 <cfset #session.category2# = "-1">
</cfif>

<!--- Update the item in the database --->
<cfquery username="#db_username#" password="#db_password#" name="update_item" datasource="#DATASOURCE#">
 UPDATE items
    SET category1=#session.category1#,
        category2=#session.category2#,
        pay_morder_ccheck=#session.pay_morder_ccheck#
    WHERE itemnum=#session.itemnum#
</cfquery>

<!--- Erase the session info --->
<cfset #session.held_item# = "0">

<!--- Redirect them to the final sell page --->
<cflocation url="main_page.cfm">
