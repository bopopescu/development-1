<!--
  chk_dynamic.cfm
  
  checks an auction that has a dynamic close to see if it should be left open..
  returns value leaveOpen = TRUE|FALSE
  
  <!---


  <cfmodule template="chk_dynamic.cfm"
    itemnum="[item number]"
    datasource="[datasource name]"
    timenow="[time now]">

  --->

-->


<cfif isdefined("db_password") is not true>
	<cfinclude template="../../includes/app_globals.cfm">
</cfif>

<!-- get auction info -->
<cfquery username="#db_username#" password="#db_password#" name="getAuction" datasource="#Attributes.datasource#">
    SELECT dynamic, dynamic_valu, date_end
      FROM items
     WHERE itemnum = #Attributes.itemnum#
</cfquery>

<!-- set start/end of dynamic period -->
<cfset startDynamic = DateAdd("n", -getAuction.dynamic_valu, getAuction.date_end)>
<cfset endDynamic = DateAdd("n", getAuction.dynamic_valu, getAuction.date_end)>

<cfif getAuction.dynamic eq 1>
<!-- get bids placed on item after start of period -->
<cfquery username="#db_username#" password="#db_password#" name="getBids" datasource="#Attributes.datasource#">
    SELECT COUNT(quantity) AS found
      FROM bids
     WHERE itemnum = #Attributes.itemnum#
       AND time_placed >= #startDynamic#
</cfquery>

<!-- return leaveOpen value -->
<cfif getBids.found AND Attributes.timenow LT endDynamic>
  <cfset Caller.leaveOpen = "TRUE">
 
<cfelse>
  <cfset Caller.leaveOpen = "FALSE">
</cfif>
<cfelse>
<cfset Caller.leaveOpen = "FALSE">
</cfif>
