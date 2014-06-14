<!--
  event.cfm
  
  email & auction maintenance events...
  
  main controller for scheduled event...
  default schedule is every 10 minutes...
-->

<!-- SET INTERVALS ACCORDINGLY -->

<!-- include auction expirer -->
<cflocation url="expire/index.cfm?requesttimeout=600" addtoken="No">
<!--- <cfinclude template="expire/index.cfm"> --->
