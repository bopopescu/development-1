<!---
epoch.cfm

defines Unix time
seconds since 12/31/1969 24:00:00 GMT

set "zone_adjust" +/- to calc GMT from your server time

<CFMODULE TEMPLATE="epoch.cfm">

--->

<!--- define # of hours to adjust server time to get GMT time --->
<CFSET zone_adjust = 8>

<!--- define GMT time --->
<CFSET GMTtime = DateAdd("h", zone_adjust, Now())>

<!--- set EPOCH in Caller --->
<CFSET Caller.EPOCH = DateDiff("s", "12-31-1979 00:00:00", GMTtime)>
