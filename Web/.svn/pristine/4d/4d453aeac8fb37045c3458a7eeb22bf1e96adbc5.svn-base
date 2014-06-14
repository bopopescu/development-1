<!---
  
  BidIncrements.cfm
  
  module for manipulating bid increment values and the default increment..
  
  will return current vals in structure (always)..
  can insert new increment..
    - NOTE: will not allow duplicate value to be inserted..
    
  can delete increment..
    - NOTE: will not allow deletion of all increments..
            or deletion of increment that's default..
    
  can set default increment..
  
  Usage:
  
  <cfmodule template="BidIncrements.cfm">
  
  Interface Options:
    sOpt="INS/INCREMENT"
    sOpt="DEL/INCREMENT"
    sOpt="SET/DEF/INCREMENT"
    
  Structure returned: hBidIncrements
  
  Keys:
    ##.aIncrements      ;array (array of available increments)
    ##.fDefIncrement      ;int (default increment)
    ##.aErrors      ;array (errors encountered while processing)
    
  Author: John Adams
  Date: 1999/09/15
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- def vals --->
<cfparam name="Attributes.sOpt" default="">

<cfset sIncFlagName = "increment">      <!--- flag name for increment vals in "defaults" --->
<cfset sDefIncFlagName = "def_increment">      <!--- flag name for def increment val in "defaults" --->

<cfset fStartIncrement = 1>      <!--- val to ins if no increments present in "defaults" --->
<cfset fStartDefIncrement = Variables.fStartIncrement>
<cfset iIncHiLoLimit = 1000000000>      <!--- high/low limit on increments --->

<cfset hTempStruct = StructNew()>
<cfset temp = StructInsert(hTempStruct, "aIncrements", ArrayNew(1))>
<cfset temp = StructInsert(hTempStruct, "fDefIncrement", Variables.fStartDefIncrement)>
<cfset temp = StructInsert(hTempStruct, "aErrors", ArrayNew(1))>

<!--- init globals --->
<cfmodule template="../includes/app_globals.cfm"
  sStructName="hAppGlobals">

<!--- VERIFY SOME DATA EXISTS --->

<!--- chk one increment exists --->
<cfquery username="#db_username#" password="#db_password#" name="chkIncExists" datasource="#hAppGlobals.DATASOURCE#">
    SELECT COUNT(name) AS found
      FROM defaults
     WHERE name = '#Variables.sIncFlagName#'
</cfquery>

<!--- if no incs exists, create one --->
<cfif not chkIncExists.found>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
      INSERT INTO defaults
        (name, pair)
      VALUES
        ('#Variables.sIncFlagName#', '#Variables.fStartIncrement#')
  </cfquery>
</cfif>

<!--- chk def increment exists --->
<cfquery username="#db_username#" password="#db_password#" name="chkDefIncExists" datasource="#hAppGlobals.DATASOURCE#">
    SELECT COUNT(name) AS found
      FROM defaults
     WHERE name = '#Variables.sDefIncFlagName#'
</cfquery>

<!--- if no def inc exists, create one --->
<cfif not chkDefIncExists.found>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
      INSERT INTO defaults
        (name, pair)
      VALUES
        ('#Variables.sDefIncFlagName#', '#Variables.fStartDefIncrement#')
  </cfquery>
</cfif>

<!--- IF INSERT INCREMENT --->
<cfif Attributes.sOpt IS "INS/INCREMENT">
  
  <!---
    
    option used to insert a new bid increment into defaults..
    
    Usage:
    
    <cfmodule template="BidIncrements.cfm"
      sOpt="INS/INCREMENT"
      fNewInc="[new increment value]">
      
  --->
  
  <!--- def vals --->
  <cfset bContinue1 = 1>
  
  <!--- chk attribs defined --->
  <cfif not IsDefined("Attributes.fNewInc")>
    
    <cfset bContinue1 = 0>
    <cfset temp = ArrayAppend(hTempStruct.aErrors, """fNewInc"" attribute not defined.")>
  </cfif>
  
  <!--- chk new inc is numeric --->
  <cfif Variables.bContinue1>
    
    <cfif not IsNumeric(Attributes.fNewInc)>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, """fNewInc"" attribute not numeric.")>
    </cfif>
  </cfif>
  
  <!--- chk new inc LT 100 mil & GT -100 mil --->
  <cfif Variables.bContinue1>
    
    <cfif not Attributes.fNewInc LTE Variables.iIncHiLoLimit
      OR not Attributes.fNewInc GTE -Variables.iIncHiLoLimit>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "New increment not within allowed range of -#Variables.iIncHiLoLimit# to #Variables.iIncHiLoLimit#.")>
    </cfif>
  </cfif>
  
  <!--- chk new inc only two decimal places --->
  <cfif Variables.bContinue1>
    
    <cfif REFind("[0-9]*\.[0-9][0-9][1-9]+", Attributes.fNewInc, "1")>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "New increment cannot contain more then 2 decimal places.")>
    </cfif>
  </cfif>
  
  <!--- redef new inc --->
  <cfif Variables.bContinue1>
    
    <cfset fNewInc = Round(Attributes.fNewInc * 100) / 100>
  </cfif>
  
  <!--- chk new inc doesn't match existing inc --->
  <cfif Variables.bContinue1>
    
    <cfquery username="#db_username#" password="#db_password#" name="chkDuplicate" datasource="#hAppGlobals.DATASOURCE#">
        SELECT COUNT(name) AS found
          FROM defaults
         WHERE name = '#Variables.sIncFlagName#'
           AND pair = '#Variables.fNewInc#'
    </cfquery>
    
    <cfif chkDuplicate.found>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "Increment already exists, cannot create duplicate increment.")>
    </cfif>
  </cfif>
  
  <!--- if continue, add inc --->
  <cfif Variables.bContinue1>
    
    <!--- ins inc --->
    <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
        INSERT INTO defaults
          (name, pair)
        VALUES
          ('#Variables.sIncFlagName#', '#Variables.fNewInc#')
    </cfquery>
    
    <!--- log increment added --->
    <cfmodule template="addTransaction.cfm"
      datasource="#hAppGlobals.DATASOURCE#"
      description="Bidding Increment Added"
      details="NEW BIDDING INCREMENT: #Variables.fNewInc#">
      
  </cfif>
  
<!--- ELSE IF DELETE INCREMENT --->
<cfelseif Attributes.sOpt IS "DEL/INCREMENT">
  
  <!---
    
    option used for deleting a bid increment value..
    
    wont delete the default increment..
    wont delete the last increment if only one left..
    
    Usage:
    
    <cfmodule template="BidIncrements.cfm"
      sOpt="DEL/INCREMENT"
      fDelInc="[inc val to delete]">
      
  --->
  
  <!--- def vals --->
  <cfset bContinue1 = 1>
  
  <!--- chk attribs defined --->
  <cfif not IsDefined("Attributes.fDelInc")>
    
    <cfset bContinue1 = 0>
    <cfset temp = ArrayAppend(hTempStruct.aErrors, """fDelInc"" attribute not defined.")>
  </cfif>
  
  <!--- chk del option numeric --->
  <cfif Variables.bContinue1>
    
    <cfif not IsNumeric(Attributes.fDelInc)>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, """fDelInc"" attribute not numeric.")>
    </cfif>
  </cfif>
  
  <!--- chk not trying to del default inc --->
  <cfif Variables.bContinue1>
    
    <cfquery username="#db_username#" password="#db_password#" name="chkNotDefInc" datasource="#hAppGlobals.DATASOURCE#">
        SELECT COUNT(name) AS found
          FROM defaults
         WHERE name = '#Variables.sDefIncFlagName#'
           AND pair = '#Attributes.fDelInc#'
    </cfquery>
    
    <cfif chkNotDefInc.found>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "Cannot delete the default bid increment.")>
    </cfif>
  </cfif>
  
  <!--- chk more then one inc left --->
  <cfif Variables.bContinue1>
    
    <cfquery username="#db_username#" password="#db_password#" name="cntCurIncs" datasource="#hAppGlobals.DATASOURCE#">
        SELECT COUNT(name) AS found
          FROM defaults
         WHERE name = '#Variables.sIncFlagName#'
    </cfquery>
    
    <cfif cntCurIncs.found LTE 1>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "Cannot delete the last bid increment value.")>
    </cfif>
  </cfif>
  
  <!--- if continue, delete --->
  <cfif Variables.bContinue1>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
        DELETE
          FROM defaults
         WHERE name = '#Variables.sIncFlagName#'
           AND pair = '#Attributes.fDelInc#'
    </cfquery>
    
    <!--- log increment delete --->
    <cfmodule template="addTransaction.cfm"
      datasource="#hAppGlobals.DATASOURCE#"
      description="Bidding Increment Deleted"
      details="DELETED BIDDING INCREMENT: #Attributes.fDelInc#">
      
  </cfif>
  
<!--- ELSE IF SET DEFAULT INCREMENT --->
<cfelseif Attributes.sOpt IS "SET/DEF/INCREMENT">
  
  <!---
    
    option for setting the default bid increment..
    
    will only set to an existing increment..
    
    Usage:
    
    <cfmodule template="BidIncrements.cfm"
      sOpt="SET/DEF/INCREMENT"
      fNewDefInc="[new def inc val]">
      
  --->
  
  <!--- def vals --->
  <cfset bContinue1 = 1>
  
  <!--- chk attribs defined --->
  <cfif not IsDefined("Attributes.fNewDefInc")>
    
    <cfset bContinue1 = 0>
    <cfset temp = ArrayAppend(hTempStruct.aErrors, """fNewDefInc"" attribute not defined.")>
  </cfif>
  
  <!--- chk del option numeric --->
  <cfif Variables.bContinue1>
    
    <cfif not IsNumeric(Attributes.fNewDefInc)>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, """fNewDefInc"" attribute not numeric.")>
    </cfif>
  </cfif>
  
  <!--- chk increment exist --->
  <cfif Variables.bContinue1>
    
    <cfquery username="#db_username#" password="#db_password#" name="chkIncDefined" datasource="#hAppGlobals.DATASOURCE#">
        SELECT COUNT(name) AS found
          FROM defaults
         WHERE name = '#Variables.sIncFlagName#'
           AND pair = '#Attributes.fNewDefInc#'
    </cfquery>
    
    <cfif not chkIncDefined.found>
      
      <cfset bContinue1 = 0>
      <cfset temp = ArrayAppend(hTempStruct.aErrors, "Cannot set default bid increment to an increment that doesn't exist.")>
    </cfif>
  </cfif>
  
  <!--- if continue, set def inc --->
  <cfif Variables.bContinue1>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
        UPDATE defaults
           SET pair = '#Attributes.fNewDefInc#'
         WHERE name = '#Variables.sDefIncFlagName#'
    </cfquery>
  </cfif>
  
</cfif>

<!--- GET CURRENT VALS --->

<!--- get current increments --->
<cfquery username="#db_username#" password="#db_password#" name="getIncs" datasource="#hAppGlobals.DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = '#Variables.sIncFlagName#'
</cfquery>

<!--- set current increments in array --->
<cfif getIncs.RecordCount>
  
  <cfloop query="getIncs">
    
    <cfset temp = ArrayAppend(hTempStruct.aIncrements, Trim(getIncs.pair))>
  </cfloop>
</cfif>

<!--- sort array of increments --->
<cfset temp = ArraySort(hTempStruct.aIncrements, "numeric")>

<!--- get current def increment --->
<cfquery username="#db_username#" password="#db_password#" name="getDefInc" datasource="#hAppGlobals.DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = '#Variables.sDefIncFlagName#'
</cfquery>

<!--- upd val in struct --->
<cfif getDefInc.RecordCount>
  
  <cfset temp = StructUpdate(hTempStruct, "fDefIncrement", Trim(getDefInc.pair))>
</cfif>

<!--- RTN VALS TO CALLER --->

<cfset Caller.hBidIncrements = hTempStruct>

<cfsetting enablecfoutputonly="No">
