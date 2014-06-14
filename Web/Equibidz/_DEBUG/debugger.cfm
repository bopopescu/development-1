<cfoutput>
	#dollarFormat("13,000")#
</cfoutput>
<cfset s = "14,001">
<cfset n1 = 14000>
<cfset n2 = 15000>
<cfif s gt n1>
It's greater than n1<br />
<cfelseif s gt n2>
It's greater than n2<br />
<cfelse>
It's not greater than<br />
</cfif>