<!---
  
  auction_complete.cfm
  
  QUERIES TO DETERMINE IF STATUS OF AUCTION IS COMPLETE..
  accounts for dynamic close..
  
  Usage:
    
    <cfmodule template="auction_complete.cfm"
      iItemnum="[item number]">
      
  Structure returned: hAuctionComplete
  
  Keys:
    ##.aErrors      ;array (list of errors encountered while processing)
    ##.bComplete      ;bool (1 if auction complete,, accounts for dynamic close)
    ##.iSecsLeft      ;int (number of seconds left in auction)
    ##.tsDateEnd      ;time stamp (date/time auction ends,, accounts for dynamic close)
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- init global vars --->
<cfmodule template="../includes/app_globals.cfm" sStructName="hAppGlobals">

<!--- def TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- def vals --->
<cfset iSecsLeft = 0>

<cfset hTempStruct = StructNew()>
<cfset temp = StructInsert(hTempStruct, "aErrors", ArrayNew(1))>
<cfset temp = StructInsert(hTempStruct, "bComplete", "0")>
<cfset temp = StructInsert(hTempStruct, "iSecsLeft", Variables.iSecsLeft)>
<cfset temp = StructInsert(hTempStruct, "tsDateEnd", TIMENOW)>

<cfset bContinue1 = 1>

<!--- chk attribs defined --->
<cfloop index="e" list="iItemnum">
  
  <cfif not IsDefined("Attributes.#e#")>
    
    <cfset bContinue1 = 0>
    <cfset temp = ArrayAppend(hTempStruct.aErrors, """#e#"" attribute of auction_complete not defined.")>
  </cfif>
</cfloop>

<!--- chk itemnum numeric --->
<cfif Variables.bContinue1>
  
  <cfif not IsNumeric(Variables.bContinue1)>
    
    <cfset bContinue1 = 0>
    <cfset temp = ArrayAppend(hTempStruct.aErrors, "Given item number not numeric.")>
  </cfif>
</cfif>

<!--- chk auction exist & get info --->
<cfif Variables.bContinue1>
  
  <cfquery username="#db_username#" password="#db_password#" name="getDyInf" datasource="#hAppGlobals.DATASOURCE#">
      SELECT dynamic, dynamic_valu, date_end, quantity
        FROM items
       WHERE itemnum = #Attributes.iItemnum#
  </cfquery>
  
  <cfif not getDyInf.RecordCount>
    
    <cfset bContinue1 = 0>
    <cfset temp = ArrayAppend(hTempStruct.aErrors, "Given item number invalid or item no longer in database.")>
  </cfif>
</cfif>

<!--- if bContinue1 --->
<cfif Variables.bContinue1>

    <cfquery username="#db_username#" password="#db_password#" name="getTime" datasource="#hAppGlobals.DATASOURCE#">
       SELECT time_placed
       FROM bids
       WHERE itemnum = #Attributes.iItemnum#
	   ORDER BY time_placed DESC
	</cfquery>

	   <cfif getTime.RecordCount LT 1>
	   <cfset dynTime = "0">
	   <cfelse>
	   <cfloop query="getTime" startrow="1" endrow="1">
	   <cfset dynTime = time_placed>
	   </cfloop>
	   </cfif>
	   <!--- Only allow dynamic end if dynamic_valu number of minutes before auction end date-time --->
  <cfif #getDyInf.dynamic# is 1>
  <cfif datediff("n", "#timenow#", "#getDyInf.date_end#") lt #getDyInf.dynamic_valu# and getDyInf.quantity gt 0>
      <!--- Allow updating new date_end to item only if last bid date-time plus dynamic_valu  is greater than current date_end--->
		<cfif (dateadd("n", "#getDyInf.dynamic_valu#","#dynTime#")) GT getDyInf.date_end>
		
		 <cfset dynDate_end = #DateAdd("n", getDyInf.dynamic_valu, getDyInf.date_end)#>

		<cfif getDyInf.dynamic eq 1>
		<!--- Dont update date end if dynamic bidding is not enabled --->
		<CFQUERY NAME="New_dateEnd" username="#db_username#" password="#db_password#" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
			UPDATE items
			SET date_end = #dynDate_end#
			where itemnum = #Attributes.iItemnum#
		</CFQUERY> 
		 </cfif>
		<cfelse>
		 	<cfset dynDate_end = #getDyInf.date_end#>
		</cfif>
  <cfelse>
		 <cfset dynDate_end = #getDyInf.date_end#>
  </cfif>
  </cfif>
  <!--- chk status of auction --->
  <cfquery username="#db_username#" password="#db_password#" name="chkStatus" datasource="#hAppGlobals.DATASOURCE#">
      SELECT COUNT(itemnum) AS isComplete
        FROM items
       WHERE itemnum = #Attributes.iItemnum#
         AND (
              <!--- no dynamic close & past end date --->
                   dynamic = 0 
               AND  date_end < #TIMENOW#
              
              <!--- status closed --->
              OR status = 0
              
      <cfif getDyInf.dynamic>
              
              <!--- dynamic close w/ no bids in specified period --->
              OR dynamic = 1
              AND date_end < #TIMENOW#
              AND (SELECT COUNT(itemnum)
                     FROM bids
                    WHERE itemnum = #Attributes.iItemnum#
                      AND time_placed >= #DateAdd("n", -getDyInf.dynamic_valu, getDyInf.date_end)#) = 0
                      
              <!--- dynamic close w/ bids in specified period, but now past final close --->
              OR dynamic = 1
              AND date_end < #TIMENOW#
              AND (SELECT COUNT(itemnum)
                     FROM bids
                    WHERE itemnum = #Attributes.iItemnum#
                      AND time_placed >= #DateAdd("n", -getDyInf.dynamic_valu, getDyInf.date_end)#) = 1
              AND #DateAdd("n", getDyInf.dynamic_valu, getDyInf.date_end)# >= #TIMENOW#
                      
      </cfif>
             )
  </cfquery>
  
  <!--- def complete --->
  <cfset temp = StructUpdate(hTempStruct, "bComplete", chkStatus.isComplete)>
  
  <!--- def Date End (will be the same as in DB unless dynamic close effective) --->
  <cfset temp = StructUpdate(hTempStruct, "tsDateEnd", getDyInf.date_end)>
  
  <cfif getDyInf.dynamic
    AND DateCompare(TIMENOW, getDyInf.date_end) IS 1
    AND not chkStatus.isComplete>
    
    <cfset temp = StructUpdate(hTempStruct, "tsDateEnd", DateAdd("n", getDyInf.dynamic_valu, getDyInf.date_end))>
  </cfif>
  
  <!--- def seconds left --->
  <cfif not chkStatus.isComplete>
    
    <cfset temp = StructUpdate(hTempStruct, "iSecsLeft", DateDiff("s", TIMENOW, hTempStruct.tsDateEnd))>
  </cfif>
  
</cfif>

<!--- return vals to caller --->
<cfset Caller.hAuctionComplete = hTempStruct>

<cfsetting enablecfoutputonly="No">
