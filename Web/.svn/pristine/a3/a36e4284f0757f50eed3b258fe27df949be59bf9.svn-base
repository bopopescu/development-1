
  <!--- define highlights start/end --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getHighLight" datasource="#DATASOURCE#">
        SELECT pair AS alink_color
          FROM defaults
         WHERE name = 'alink_color'
    </cfquery>
    
    <cfset theColor = Trim(getHighLight.alink_color)>
    
    <cfset hlightStart = '<font color="' & theColor & '">'>
    <cfset hlightEnd = '</font>'>
    
    <cfcatch>
      <cfset hlightStart = '<font color="ff0000">'>
      <cfset hlightEnd = '</font>'>
    </cfcatch>
  </cftry>
