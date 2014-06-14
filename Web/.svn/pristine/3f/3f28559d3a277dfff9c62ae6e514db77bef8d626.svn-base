
<cfinclude template="../includes/session_include.cfm">
  <!--- define userNickname if Session available --->
  <cftry>
    <cfif IsDefined("nickname")>
      <cfset userNickname = Trim(nickname)>
    <cfelseif IsDefined("Session.nickname")>
      <cfset userNickname = Session.nickname>
    <cfelse>
      <cfset userNickname = "">
    </cfif>
    
    <cfcatch>
      <cfset userNickname = "">
    </cfcatch>
  </cftry>

