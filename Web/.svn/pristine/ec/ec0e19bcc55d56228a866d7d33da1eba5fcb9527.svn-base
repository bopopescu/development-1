<!---
  --- PageRequestManager
  --- ------------------
  ---
  --- Manages the security and monitoring around page requests.
  ---
  --- author: bsterner
  --- date:   6/14/14
  --->
<cfcomponent displayname="Page Request Manager" hint="Manages the security and monitoring around page requests." extends="SecurityManager" accessors="true" output="false" persistent="false">

    <cffunction name="trackRequest" description="Manages the activities and actions of a page request based on the remote address.  Evidently there are certain remote addresses we need to track.">
		<cfargument name="remoteAddress" type="string" required="yes" hint="The remote address of the user request the page.">
		<cfset var getIpAddress = "">
		<cfset var getTrackingCount = -1>
		<cfquery name="getIpAddress" datasource="#application.datasource#">
			SELECT tracker
			FROM tracking
			WHERE tracker = '#arguments.remoteAddress#'
		</cfquery>
		<cfif not getIpAddress.recordCount>
			<cfquery datasource="#application.datasource#">
			    INSERT INTO tracking(tracker, webbrowser, referer, date_time)
			    VALUES('#CGI.REMOTE_ADDR#','#CGI.HTTP_USER_AGENT#','#CGI.HTTP_REFERER#',  #createODBCDateTime(timenow)#)
			</cfquery>
			<cfquery name="getTrackingCount" datasource="#application.datasource#">
				SELECT COUNT(tracker) AS tracking_count
				FROM tracking
			</cfquery>
			<cfquery datasource="#application.datasource#">
				UPDATE stats
				SET tracking = #getTrackingCount.tracking_count#
				WHERE id = 1
			</cfquery>
		</cfif>
    </cffunction>

</cfcomponent>