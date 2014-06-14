<!--- get session variable --->
<cfinclude template="../includes/session_include.cfm">
<cfmodule template="../functions/timenow.cfm">


<cfparam name="session.admin_access" default="0">
<cfparam name="session.defaults_access" default="0">
<cfparam name="session.users_access" default="0">
<cfparam name="session.accounts_access" default="0">
<cfparam name="session.categories_access" default="0">
<cfparam name="session.auctions_access" default="0">
<cfparam name="session.siteinfo_access" default="0">
<cfparam name="session.reports_access" default="0">
<cfparam name="session.classified_access" default="0">
<cfparam name="session.access_access" default="0">
<cfparam name="session.support_access" default="0">
<cfparam name="session.banner_access" default="0">

<cfif classified_valid is "Yes">
<cfset topline = 734>
<cfelse>
<cfset topline = 662>
</cfif>

<cfoutput>
 <tr bgcolor=0a5168>
<td colspan=5 valign=bottom><img border=0 src="adminbar.jpg" valign=bottom></td>
 </tr>

 <tr bgcolor=0a5168>
  <td><img border=0 src="#VAROOT#/admin/images/menu_left.gif"></td>
  <td>
   <table border=0 cellspacing=0 cellpadding=0>
    <tr>
     <cfif #session.admin_access# eq 1><td><a href="#VAROOT#/admin/admin.cfm"><img border=0 src='#VAROOT#/admin/images/btn_admin_<cfif #page# is "admin">on<cfelse>off</cfif>.gif' alt="Login"></a></td></cfif>
     <cfif #session.defaults_access# eq 1><td><a href="#VAROOT#/admin/defaults.cfm"><img border=0 src='#VAROOT#/admin/images/btn_defaults_<cfif #page# is "defaults">on<cfelse>off</cfif>.gif' alt="Defaults"></a></td></cfif>
     <cfif #session.users_access# eq 1><td><a href="#VAROOT#/admin/users.cfm"><img border=0 src='#VAROOT#/admin/images/btn_users_<cfif #page# is "users">on<cfelse>off</cfif>.gif' alt="Users"></a></td></cfif>
     <cfif #session.accounts_access# eq 1><td><a href="#VAROOT#/admin/accountsNU.cfm"><img border=0 src='#VAROOT#/admin/images/btn_accounts_<cfif #page# is "accounts">on<cfelse>off</cfif>.gif' alt="Accounts"></a></td></cfif>
     <cfif #session.categories_access# eq 1><td><a href="#VAROOT#/admin/categories.cfm"><img border=0 src='#VAROOT#/admin/images/btn_categories_<cfif #page# is "categories">on<cfelse>off</cfif>.gif' alt="Categories"></a></td></cfif>
     <cfif #session.auctions_access# eq 1><td><a href="#VAROOT#/admin/auctions.cfm"><img border=0 src='#VAROOT#/admin/images/btn_auctions_<cfif #page# is "auctions">on<cfelse>off</cfif>.gif' alt="Auctions"></a></td></cfif>
     <cfif #session.auctions_access# eq 1><td><a href="#VAROOT#/admin/advertise.cfm"><img border=0 src='#VAROOT#/admin/images/btn_adv_<cfif #page# is "advertise">on<cfelse>off</cfif>.gif' alt="Avertise"></a></td></cfif>
     <cfif #session.siteinfo_access# eq 1><td><a href="#VAROOT#/admin/options.cfm"><img border=0 src='#VAROOT#/admin/images/btn_colors_<cfif #page# is "siteinfo">on<cfelse>off</cfif>.gif' alt="Site Info"></a></td></cfif>
     <cfif #session.reports_access# eq 1><td><a href="#VAROOT#/admin/reports.cfm"><img border=0 src='#VAROOT#/admin/images/btn_reports_<cfif #page# is "reports">on<cfelse>off</cfif>.gif' alt="Reports"></a></td></cfif>

<cfquery name="blah" datasource="#datasource#">

Select * from access where login='#session.username#'
</cfquery>

     <cfif #blah.support_access# eq 1><td><a href="#VAROOT#/support/admin/support.cfm"><img border=0 src='#VAROOT#/support/admin/images/btn_support_<cfif #page# is "support">on<cfelse>off</cfif>.gif' alt="Support"></a></td></cfif>
     <cfif #blah.banner_access# eq 1><td><a href="#VAROOT#/admin/add_new_banner.cfm"><img border=0 src='#VAROOT#/admin/images/btn_banner_<cfif #page# is "banners">on<cfelse>off</cfif>.gif' alt="banners"></a></td></cfif>

	     <cfif classified_valid is "Yes"> <cfif trim(blah.classified_access) eq 1><td><a href="#VAROOT#/classified/admin/ad_mngr.cfm"><img border=0 src='#VAROOT#/admin/images/btn_classified_<cfif #page# is "ad_mngr">on<cfelse>off</cfif>.gif' alt="Classified Ads"></a></td></cfif>
</cfif>
<cfif #session.access_access# eq 1><td><a href="#VAROOT#/admin/access.cfm"><img border=0 src='#VAROOT#/admin/images/btn_access_<cfif #page# is "access">on<cfelse>off</cfif>.gif' alt="Access"></a></td></cfif>

	 
    </tr>
   </table>
  </td>

 <td colspan=2 align="right"><font face="helvetica" size=2 color="ffffff"> <!---Administrator Account ---></font></td> 
  <td>&nbsp;</td>
 </tr>
</cfoutput>


<cfquery name="get_ip" datasource="#datasource#">
SELECT tracker
FROM tracking
WHERE tracker = '#cgi.remote_addr#'
</cfquery>

<cfif #get_ip.recordcount# eq 0>

<cfquery name=get_ip1 datasource="#datasource#">
insert into tracking(tracker,webbrowser,referer,date_time)
values('#CGI.REMOTE_ADDR#','#CGI.HTTP_USER_AGENT#','#CGI.HTTP_REFERER#',  #CreateODBCDateTime(timenow)#)
</cfquery>



<cfquery name=updatetempip datasource="#datasource#">
select count(tracker) as blah from tracking
</cfquery>


<cfquery name="updateip" datasource="#datasource#">

update stats set tracking= #updatetempip.blah# where id = 1

</cfquery>

</cfif> 
