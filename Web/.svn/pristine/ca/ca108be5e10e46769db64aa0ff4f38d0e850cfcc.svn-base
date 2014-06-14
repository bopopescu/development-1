<!---
  /functions/setupDefProxyMax.cfm
  
  - function to setup value in defaults table for maxing out proxy bids when under reserve
  - will setup the value if doesn't exist
  - will return the value if defined
  - will return the value of the maxout flag if "rtnMaxoutFlag" defined
  
  <cfmodule template="functions/setupDefProxyMax.cfm"
    datasource="[system DSN]"
    rtnMaxout="[variable to return]"
    rtnMaxoutFlag="[variable to return, if not def, not returned]">
    
  Author: John Adams
  Date: 07/16/1999
  
--->
<cfsetting enablecfoutputonly="Yes">
<CFINCLUDE TEMPLATE="../includes/app_globals.cfm">
<cfinclude template="../includes/session_include.cfm">
<cfif session.auction_mode is 0>
<!-- Regular Auctions -- Reverse auction begins on line 118>
<!--- def vals --->
<cfset sMaxoutFlag = "bMaxoutProxies">
<cfset bDefMaxout = 0>
<cfset lReqAttribs = "datasource">
<cfset bCreateDef = 0>
<cfset bUpdateDef = 0>
<cfset bRtnMaxoutFlag = 0>
<cfset bRtnMaxout = 0>

<!--- chk attribs exist --->
<cfloop index="e" list="#Variables.lReqAttribs#">
  
  <cfif not IsDefined("Attributes." & e)>
    <cfoutput>
      <br>
      <b>ERROR:</b> #e# attribute of setupDefProxyMax not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def if should rtn maxout --->
<cfif IsDefined("Attributes.rtnMaxout")>
  
  <cfif Len(Attributes.rtnMaxout)>
    <cfset bRtnMaxout = 1>
  </cfif>
</cfif>

<!--- def if should rtn maxout flag --->
<cfif IsDefined("Attributes.rtnMaxoutFlag")>
  
  <cfif Len(Attributes.rtnMaxoutFlag)>
    <cfset bRtnMaxoutFlag = 1>
  </cfif>
</cfif>

<!--- chk def val exist --->
<cfquery username="#db_username#" password="#db_password#" name="getDefMaxout" datasource="#Attributes.datasource#">
    SELECT pair AS maxout
      FROM defaults
     WHERE name = '#Variables.sMaxoutFlag#'
</cfquery>

<!--- if val found --->
<cfif getDefMaxout.RecordCount>
  
  <!--- if val bool --->
  <cfif IsBoolean(getDefMaxout.maxout)>
    <cfset bDefMaxout = Trim(getDefMaxout.maxout)>
  
  <!--- else set to update def --->
  <cfelse>
    <cfset Variables.bUpdateDef = 1>
  </cfif>
  
<!--- else set to create def --->
<cfelse>
  <cfset Variables.bCreateDef = 1>
</cfif>

<!--- if should create def --->
<cfif Variables.bCreateDef>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
      INSERT INTO defaults
        (name, pair)
      VALUES
        ('#sMaxoutFlag#', '#bDefMaxout#')
  </cfquery>
</cfif>

<!--- if should update def --->
<cfif Variables.bUpdateDef>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
      UPDATE defaults
         SET pair = '#bDefMaxout#'
       WHERE name = '#sMaxoutFlag#'
  </cfquery>
</cfif>

<!--- if desired, rtn bool val to Caller --->
<cfif Variables.bRtnMaxout>
  
  <cfset sTmpVar = "Caller." & Trim(Attributes.rtnMaxout)>
  <cfset "#Variables.sTmpVar#" = Variables.bDefMaxout>
</cfif>

<!--- if desired, rtn flag name to Caller --->
<cfif Variables.bRtnMaxoutFlag>
  
  <cfset sTmpVar = "Caller." & Trim(Attributes.rtnMaxoutFlag)>
  <cfset "#Variables.sTmpVar#" = Variables.sMaxoutFlag>
</cfif>
<cfelse>
<!-- Reverse Auction -->

<!--- def vals --->
<cfset sMinoutFlag = "bMinoutProxies">
<cfset bDefMinout = 0>
<cfset lReqAttribs = "datasource">
<cfset bCreateDef = 0>
<cfset bUpdateDef = 0>
<cfset bRtnMinoutFlag = 0>
<cfset bRtnMinout = 0>

<!--- chk attribs exist --->
<cfloop index="e" list="#Variables.lReqAttribs#">
  
  <cfif not IsDefined("Attributes." & e)>
    <cfoutput>
      <br>
      <b>ERROR:</b> #e# attribute of setupDefProxyMin not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- def if should rtn Minout --->
<cfif IsDefined("Attributes.rtnMinout")>
  
  <cfif Len(Attributes.rtnMinout)>
    <cfset bRtnMinout = 1>
  </cfif>
</cfif>

<!--- def if should rtn Minout flag --->
<cfif IsDefined("Attributes.rtnMinoutFlag")>
  
  <cfif Len(Attributes.rtnMinoutFlag)>
    <cfset bRtnMinoutFlag = 1>
  </cfif>
</cfif>

<!--- chk def val exist --->
<cfquery username="#db_username#" password="#db_password#" name="getDefMinout" datasource="#Attributes.datasource#">
    SELECT pair AS minout
      FROM defaults
     WHERE name = '#Variables.sMinoutFlag#'
</cfquery>

<!--- if val found --->
<cfif getDefMinout.RecordCount>
  
  <!--- if val bool --->
  <cfif IsBoolean(getDefMinout.minout)>
    <cfset bDefMinout = Trim(getDefMinout.minout)>
  
  <!--- else set to update def --->
  <cfelse>
    <cfset Variables.bUpdateDef = 1>
  </cfif>
  
<!--- else set to create def --->
<cfelse>
  <cfset Variables.bCreateDef = 1>
</cfif>

<!--- if should create def --->
<cfif Variables.bCreateDef>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
      INSERT INTO defaults
        (name, pair)
      VALUES
        ('#sMinoutFlag#', '#bDefMinout#')
  </cfquery>
</cfif>

<!--- if should update def --->
<cfif Variables.bUpdateDef>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#Attributes.datasource#">
      UPDATE defaults
         SET pair = '#bDefMinout#'
       WHERE name = '#sMinoutFlag#'
  </cfquery>
</cfif>

<!--- if desired, rtn bool val to Caller --->
<cfif Variables.bRtnMinout>
  
  <cfset sTmpVar = "Caller." & Trim(Attributes.rtnMinout)>
  <cfset "#Variables.sTmpVar#" = Variables.bDefMinout>
</cfif>

<!--- if desired, rtn flag name to Caller --->
<cfif Variables.bRtnMinoutFlag>
  
  <cfset sTmpVar = "Caller." & Trim(Attributes.rtnMinoutFlag)>
  <cfset "#Variables.sTmpVar#" = Variables.sMinoutFlag>
</cfif>
</cfif>
<cfsetting enablecfoutputonly="No">
