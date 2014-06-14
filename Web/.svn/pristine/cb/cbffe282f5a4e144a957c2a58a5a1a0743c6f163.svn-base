<!---
  dbMod[Table Name].cfm
  
  utility for adding new table to the database..
  
--->

<!--- customize vals --->
<cfset sNewTableName = "email_blocks">      <!--- req., name of new table --->

<cfset sNewTableSQL = StructNew()>      <!--- req., structure to hold SQL statements for diff type of db's --->
  <cfset temp = StructInsert(sNewTableSQL, "MSAccess", "
      CREATE TABLE #Variables.sNewTableName#
        (
          address TEXT(65) NOT NULL,
          block_type TEXT(1) NOT NULL
        )
  ")>

<cfset iNumNewIndexes = 2>      <!--- req., num of new indexes for table --->

<cfset sNewTableIndexes = StructNew()>      <!--- all opt., if iNumNewIndexes IS 0, else req. --->
  <cfset temp = StructInsert(sNewTableIndexes, "MSAccess1", "
      CREATE INDEX address_index ON #Variables.sNewTableName# (address);
  ")>
  <cfset temp = StructInsert(sNewTableIndexes, "MSAccess2", "
      CREATE INDEX block_type_index ON #Variables.sNewTableName# (block_type);
  ")>


<!--- def vals --->
<cfparam name="dbType" default="MSAccess">
<cfparam name="bRunScript" default="FALSE">
<cfparam name="bRenameScript" default="FALSE">

<!--- inc app_globals.cfm --->
<cfinclude template="../includes/app_globals.cfm">

<!--- display form --->
<cfif not bRunScript
  AND not bRenameScript
  AND not IsDefined("Form.sSubmitRename")
  AND not IsDefined("Form.sSubmitForm")
  AND not IsDefined("Form.sSubmitRename")>
  
  <cfoutput>
    
    <form action="#GetFileFromPath(CGI.SCRIPT_NAME)#" method="POST">
      #GetFileFromPath(CGI.SCRIPT_NAME)#<br>
      <br>
      
      Utility for adding the new "#Variables.sNewTableName#" table to your VA server database.<br>
      <br>
      
      Please select the type of database you are running.<br>
      <br>
      
      (NOTE: This script must have permission to modify the structure of your database.<br>
      For more information please consult your database documentation.)<br>
      <br>
      
      <select name="dbType">
        <option value="MSAccess" selected>MS Access</option>
      </select><br>
      <br>
      
      <input name="sSubmitForm" type=submit value="Create Table"><br>
      <br>
      
      <input name="bRunScript" type=hidden value="TRUE">
      
    </form>
    
  </cfoutput>
  
<!--- run script --->
<cfelseif bRunScript
  AND IsDefined("Form.sSubmitForm")
  AND CGI.HTTP_REFERER CONTAINS "/functions/#GetFileFromPath(CGI.SCRIPT_NAME)#">
  
  <!--- def vals --->
  <cfset bCreatedSuccess = 0>
  
  <!--- fun MS Access --->
  <cfif dbType IS "MSAccess">
    
    <cftry>
      <!--- create table --->
      <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
          #sNewTableSQL.MSAccess#
      </cfquery>
      
      <!--- create any indexes --->
      <cfloop index="i" from="1" to="#Variables.iNumNewIndexes#">
        
        <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
            #Evaluate("sNewTableIndexes.MSAccess" & i)#
        </cfquery>
      </cfloop>
      
      <cfset bCreatedSuccess = 1>
      
      <cfcatch>
      </cfcatch>
    </cftry>
    
  <!--- db type not found --->
  <cfelse>
    
    <cfoutput>
      Script not found for the requested database: #dbType#<br>
      <br>
      Please try again.<br>
      <br>
    </cfoutput>
  </cfif>
  
  <!--- if successful create --->
  <cfif Variables.bCreatedSuccess>
    
    <cfoutput>
      <form action="#GetFileFromPath(CGI.SCRIPT_NAME)#" method="POST">
        #GetFileFromPath(CGI.SCRIPT_NAME)#<br>
        <br>
        
        "#Variables.sNewTableName#" table created successfully..<br>
        <br>
        <br>
        
        Please move this file to a non executable directory to prevent if from being run 
        in the future.<br>
        Or click the button below to rename this file with the ".bak" extension.<br>
        <br>
        
        (NOTE: This requires the use of CFFILE and permission to modify this script.)<br>
        <br>
        
        <input name="sSubmitRename" type=submit value="Rename Script">
        
        <input name="bRenameScript" type=hidden value="TRUE">
      </form>
    </cfoutput>
    
  <cfelse>
    
    <cfoutput>
      #GetFileFromPath(CGI.SCRIPT_NAME)#<br>
      <br>
      
      Unexpected Error!<br>
      <br>
      
      Unable to create table.<br>
      Please contact <a href="mailto:Technical Support <support@beyondsolutions.com>">technical support</a> to resolve this matter.<br>
      <br>
    </cfoutput>
  </cfif>
  
<!--- rename script --->
<cfelseif bRenameScript
  AND IsDefined("Form.sSubmitRename")
  AND CGI.HTTP_REFERER CONTAINS "/functions/#GetFileFromPath(CGI.SCRIPT_NAME)#">
  
  <cftry>
    <cffile action="Rename"
      source="#ExpandPath("./" & GetFileFromPath(CGI.SCRIPT_NAME))#"
      destination="#ExpandPath("./" & SpanExcluding(GetFileFromPath(CGI.SCRIPT_NAME), ".") & ".bak")#">
    
    <cfoutput>
      #GetFileFromPath(CGI.SCRIPT_NAME)#<br>
      <br>
      
      Script successfully renamed to #SpanExcluding(GetFileFromPath(CGI.SCRIPT_NAME), ".")#.bak .<br>
      <br>
    </cfoutput>
    
    <cfcatch>
      <cfoutput>
        #GetFileFromPath(CGI.SCRIPT_NAME)#<br>
        <br>
        
        ERROR: Unable to rename script.<br>
        Please move this file to a non executable directory to prevent if from being run 
        in the future.<br>
        <br>
        <br>
      </cfoutput>
    </cfcatch>
  </cftry>
  
</cfif>
