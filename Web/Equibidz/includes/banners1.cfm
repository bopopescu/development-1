




<!--- usage: include <cf_banner> in your program--->
<cfquery datasource="#datasource#" name="qrylogos">
        select ID,factor from banners
</cfquery>

<cfif #qrylogos.recordcount# NEQ 0>
<cfset logoarray = arraynew(2)>
<cfset indexno=1>
<cfloop query="qrylogos">
<cfloop index="i" from="1" to="#factor#">
<cfset logoarray[#indexno#][1]=#indexno#>
<cfset logoarray[#indexno#][2]=#ID#>
<cfset indexno=indexno+1>
</cfloop>
</cfloop>
<cfset indexno=indexno-1>
<cfset inno=#randrange(1,indexno)#>
<cfset id=#logoarray[inno][2]#>
<cfquery datasource="#datasource#" name="qrylogocount">
select *
from banners 
where ID=#id# and banner_enable=1 
</cfquery>



<center>
<cfoutput query="qrylogocount">
<!---
<cfif (ban_hptop eq 1 AND placehp eq 1) OR (ban_am eq 1 AND placeam eq 1)>
--->
<cfif #file_name# is "">

<img src="/images/dot.gif" width="400" height="60" border="0" align="absmiddle">


<cfelse>
<a href="#webaddress#"><img src="#varoot#/banners/#file_name#" width="468" height="60" border="0" align="absmiddle"></a>
</cfif>
<!---
</cfif>
--->
</cfoutput>
</center>

</cfif>


