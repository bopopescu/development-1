<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/get_vars.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<cfsetting enablecfoutputonly=yes>
<cfset prompt = "0">
<cftry>
	<cfinclude template="../includes/app_globals.cfm">
	<cfoutput>

	<h2>Current settings specific for this software:</h2>
	<ul>
	Datasource: <b>#datasource#</b><br><br>
	Web site Domain: <b>#domain#</b>
	<ul><li> (used to generate return addresses for email.
	 See global_vars.cfm for email addresses used by
	 this software.</li></ul><br><br>
	Web site Root Address: <b><a href="http://#site_address##VAROOT#/"
	 >#site_address#</a></b>
	<ul><li> (click on the link to verify
	 that it goes to the correct site.  This is the link
	 use throughout the site and in emails which will
	 allow the users to easily return to your site. </li></ul>
	</ul>

	</cfoutput>
	<cfcatch>
		<cfoutput>
		Error: Cannot find license file.
		<br>ABORTING.
		</cfoutput>
	</cfcatch>
</cftry>
<cfsetting enablecfoutputonly="no">
