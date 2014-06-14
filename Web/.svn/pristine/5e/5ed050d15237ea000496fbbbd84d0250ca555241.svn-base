<!---
  setupEventClocks.cfm
  
  sets up time stamp values in "defaults" for events..
  sets start times to current day..
  start times offset from others on machine..
  values stored in registry..
  
  HKEY_LOCAL_MACHINE\Software\Visual Auction Server\ver 3.0
    ServersRunning  (number of servers running on machine)
    
    HKEY_LOCAL_MACHINE\Software\Visual Auction Server\ver 3.0\{domainname}
      CategoriesStart  (def time categories start)
      CompletedStart   (def time completed start)
      CurrentStart     (def time current start)
      EndingStart      (def time ending start)
      FeaturedStart    (def time featured start)
      GoingStart       (def time going start)
      NewStart         (def time new start)
      RootIndexStart   (def time root index start)
      
    
  runs first time.. then modifies self to require attribute "setupNow" = TRUE to run again..
  
  <cfmodule template="setupEventClocks.cfm"
    setupNow="[TRUE|FALSE]">
  
--->
<cfsetting enablecfoutputonly="Yes">

<cfparam name="Attributes.setupNow" default="FALSE">

<cfif not Attributes.setupNow>
</cfif>

<cfsetting enablecfoutputonly="No">