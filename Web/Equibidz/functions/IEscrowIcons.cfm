<!---
  
  IEscrowIcons.cfm
  
  module for setting and returning values associated with the i-escrow icons..
  
  Usage:
    
    <cfmodule template="IEscrowIcons.cfm"
      sOpt="">
      
  Structure returned: hIEscrowIcons
  
  Keys:
    ##.aErrors      ;array (errors encountered while processing)
    
  See below for more options..
  
  Author: John Adams
  Date: 1999/09/09
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- chk params exist --->
<cfloop index="e" list="">
  
  <cfif not IsDefined("Attributes.#e#")>
    
    <cfoutput>
      <br>
      <br>
      <b>ERROR:</b> "#e#" attribute of IEscrowIcons not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def vals --->
<cfset hTempStruct = StructNew()>
<cfset temp = StructInsert(hTempStruct, "aErrors", ArrayNew(1))>

<cfset sIcon1 = "std_button.gif">      <!--- icon image file --->
<cfset sIcon2 = "std_120x34.gif">      <!--- icon image file --->
<cfset sIcon3 = "std_234x34.gif">      <!--- icon image file --->

<cfset sIconName1 = "Small">      <!--- icon proper name --->
<cfset sIconName2 = "Medium">      <!--- icon proper name --->
<cfset sIconName3 = "Large">      <!--- icon proper name --->

<cfset sURL1 = "#varoot#/images/">      <!--- url to images --->

<cfset sIEHomeURL = "http://www.enetsettle.com">

<cfset hFlags = StructNew()>
<cfset temp = StructInsert(hFlags, "hFrontPage", StructNew())>
  <cfset temp = StructInsert(hFlags.hFrontPage, "sName", "IEIconFrontPage")>      <!--- flag name for front page icon --->
  <cfset temp = StructInsert(hFlags.hFrontPage, "sDefVal", Variables.sIcon1)>      <!--- def val for front page icon --->

<!--- init globals --->
<cfmodule template="../includes/app_globals.cfm"
  sStructName="hAppGlobals">

<!--- if defined Attributes.sOpt, continue --->
<cfif IsDefined("Attributes.sOpt")>

  <!--- if sOpt = DISP/FRONTPAGE --->
  <cfif Attributes.sOpt IS "DISP/FRONTPAGE">
    
    <!---
      
      returns struct w/ vals for output on front page..
      
      Usage:
      
      <cfmodule template="IEscrowIcons.cfm"
        sOpt="DISP/FRONTPAGE">
      
      Keys:
        ##.sURL      ;string (image src url)
        ##.sIEHomeURL      ;string (url to iescrow's home page)
        ##.sCurrentOption      ;string (current image file)
        ##.aIconOptions[]      ;array (icon file options)
          [].sFile      ;string (file name)
          [].sName      ;string (proper name)
        
    --->
    
    <!--- chk flag exist --->
    <cfmodule template="IEscrowIcons.cfm"
      sOpt="SUB/CHKFLAGEXIST"
      sFlag="hFrontPage">
      
    <!--- get current val --->
    <cfquery username="#db_username#" password="#db_password#" name="getVal" datasource="#hAppGlobals.DATASOURCE#">
        SELECT pair
          FROM defaults
         WHERE name = '#hFlags.hFrontPage.sName#'
    </cfquery>
    
    <!--- def vals --->
    <cfset temp = StructInsert(hTempStruct, "sURL", "#Variables.sURL1#")>
    <cfset temp = StructInsert(hTempStruct, "sIEHomeURL", "#Variables.sIEHomeURL#")>
    <cfset temp = StructInsert(hTempStruct, "sCurrentOption", Trim(getVal.pair))>
    <cfset temp = StructInsert(hTempStruct, "aIconOptions", ArrayNew(1))>
    
    <cfset iCounter = 1>
    
    <cfloop condition="IsDefined('Variables.sIcon#Variables.iCounter#') AND IsDefined('Variables.sIconName#Variables.iCounter#')">
      
      <cfset temp = ArrayAppend(hTempStruct.aIconOptions, StructNew())>
      <cfset temp = StructInsert(hTempStruct.aIconOptions[ArrayLen(hTempStruct.aIconOptions)], "sFile", Evaluate("Variables.sIcon#Variables.iCounter#"))>
      <cfset temp = StructInsert(hTempStruct.aIconOptions[ArrayLen(hTempStruct.aIconOptions)], "sName", Evaluate("Variables.sIconName#Variables.iCounter#"))>
      <cfset iCounter = iCounter + 1>
    </cfloop>
    
  <!--- if sOpt = SET/FRONTPAGE --->
  <cfelseif Attributes.sOpt IS "SET/FRONTPAGE">
    
    <!---
      
      sets icon file value..
      
      <cfmodule template="IEscrowIcons.cfm"
        sOpt="SET/FRONTPAGE"
        sNewFile="[new file name, 30 chars max]">
        
    --->
    
    <!--- if attribs defined, continue --->
    <cfif IsDefined("Attributes.sNewFile")>
      
      <!--- if new file LTE 30 chars --->
      <cfif Len(Attributes.sNewFile) LTE 30>
        
        <!--- chk flag exist --->
        <cfmodule template="IEscrowIcons.cfm"
          sOpt="SUB/CHKFLAGEXIST"
          sFlag="hFrontPage">
          
        <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
            UPDATE defaults
               SET pair = '#Trim(Attributes.sNewFile)#'
             WHERE name = '#hFlags.hFrontPage.sName#'
        </cfquery>
        
      <!--- else too long --->
      <cfelse>
        
        <cfset temp = ArrayAppend(hTempStruct.aErrors, "New file name too long.")>
      </cfif>
      
    <cfelse>
      
      <cfset temp = ArrayAppend(hTempStruct.aErrors, """sNewFile"" attribute not defined.")>
    </cfif>
    
  <!--- if sOpt = SUB/CHKFLAGEXIST --->
  <cfelseif Attributes.sOpt IS "SUB/CHKFLAGEXIST">
    
    <!---
      
      checks flag exist..
      else sets at default..
      
      Usage:
      
      <cfmodule template="IEscrowIcons.cfm"
        sOpt="SUB/CHKFLAGEXIST"
        sFlag="[key name from hFlags.]">
        
    --->
    
    <!--- if attribs defined, continue --->
    <cfif IsDefined("Attributes.sFlag")>
      
      <cfquery username="#db_username#" password="#db_password#" name="chkFlag" datasource="#hAppGlobals.DATASOURCE#">
          SELECT pair
            FROM defaults
           WHERE name = '#Evaluate("hFlags.#Attributes.sFlag#.sName")#'
      </cfquery>
      
      <!--- if not defined create at default --->
      <cfif not chkFlag.RecordCount>
        
        <cfquery username="#db_username#" password="#db_password#" datasource="#hAppGlobals.DATASOURCE#">
            INSERT INTO defaults
              (name, pair)
            VALUES
              ('#Evaluate("hFlags.#Attributes.sFlag#.sName")#', '#Evaluate("hFlags.#Attributes.sFlag#.sDefVal")#')
        </cfquery>
      </cfif>
      
    <!--- else attribs not defined --->
    <cfelse>
      
      <cfset temp = ArrayAppend(hTempStruct.aErrors, """sFlag"" attribute not defined.")>
    </cfif>
    
  <!--- else invalid sOpt --->
  <cfelse>
    
    <cfset temp = ArrayAppend(hTempStruct.aErrors, "Invalid ""sOpt"" option.")>
  </cfif>
  
<!--- else not given --->
<cfelse>
  
  <cfset temp = ArrayAppend(hTempStruct.aErrors, """sOpt"" not defined.")>
</cfif>

<!--- rtn vals to Caller --->
<cfset Caller.hIEscrowIcons = hTempStruct>

<cfsetting enablecfoutputonly="No">
