<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


<cfif #isDefined ("from_search")#>
   <cfset from_search = #from_search#>
<cfelse>
   <cfset from_search = 0>
</cfif>
<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif #isDefined ("my_No")#>
   <cfset my_No = #my_No#>
<cfelse>
   <cfset my_No = 11>
</cfif>
<cfif #isDefined ("my_Action")#>
   <cfset my_Action = #my_Action#>
<cfelse>
   <cfset my_Action = 0>
</cfif>

<cfif #my_No# EQ 11>
  <cfset my_Title = "Personal Information">
<cfelseif #my_No# is 12>
  <cfset my_Title = "Post Feedback">
<cfelseif #my_No# is 13>
  <cfset my_Title = "Feedbacks for Me">
<cfelseif #my_No# is 14>
  <cfset my_Title = "Feedbacks to Others">
</cfif>

<cfoutput>
<html>
<head>
	<title>Equibidz-My Accounts</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">		
</head>
<cfinclude template="../includes/menu_bar.cfm"> 

<body>
<div align="center">
<table border='0' width='1000' style="background-image: url('images/bg_table.jpg')" cellpadding="0" cellspacing="0">
<tr valign="top">
	<td align="center">
		<!--- Start: Main Body --->
		<div align="center">
		<table width='900' cellpadding="0" cellspacing="0" style="border-color: CDC8AB; border-width: 1px:">
          <tr><td colspan=3><font size=4><br><br><b>My Account</b></font></td></tr>
          <tr><td colspan=3><hr size=1 color="616362" width=100%></td></tr>
          <tr><td colspan=3><font size=3>
              This section of our site allows you to change and update your personal information, as well as feedbacks. This Page is exclusive 
              to your account and accessible only by your username & password.
          </td></tr>
          <tr><td colspan=3>&nbsp;</td></tr>
          <tr><td colspan=3>&nbsp;</td></tr>
		  <tr><td colspan=3 align="left">
		      <font size=4><b>#my_Title#</b></font><br>
		      <font size=2  color="aaaaaa">Select an Item from the Menu update your Personal Account.</font>
	      </td></tr>
		  <td width=210 valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td align="center"><font color="CDC8AB"><b>M e n u</b></font></td></tr>
		         <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='99%' cellpadding="1" cellspacing="1">
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_accounts.cfm?my_No=11"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 11>style="color:ffffff;"</cfif> href="my_accounts.cfm?my_No=11">Personal Information</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_accounts.cfm?my_No=12"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 12>style="color:ffffff;"</cfif> href="my_accounts.cfm?my_No=12">Post Feedback</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_accounts.cfm?my_No=13"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 13>style="color:ffffff;"</cfif> href="my_accounts.cfm?my_No=13">Feedbacks for Me</a></b></font></td>
                    </tr>   
                    <tr>
                       <td width="6%" align="left" valign="middle"><a href="my_accounts.cfm?my_No=14"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a></td>     
                       <td width="94%" align="left"><font size=3><b><a <cfif #my_No# EQ 14>style="color:ffffff;"</cfif> href="my_accounts.cfm?my_No=14">Feedbacks to Others</a></b></font></td>
                    </tr>   
                    <tr><td colspan=2>&nbsp;</td></tr>
                    <tr><td colspan=2 align="left"><a href="my_auctions.cfm"><font size=1><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10">&nbsp;&nbsp;<b>GO TO MY AUCTION</b></font></a></td></tr>
    		     </table>
    		     </td></tr>
              </table>
		  </td>
		  <td width=5></td>
		  <td width=685 valign="top">
		    <!---------Personal-Info------------------------>
		    <cfif #my_No# EQ 11>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td>&nbsp;<font color="CDC8AB"><b>Update your Personal Information here</b></font></td></tr>
                 <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
                 <tr><td>
				    <cfinclude template="personal.cfm">
              	 </td></tr> 	                  	 	    
		      </table> 
		    <!---------Post Feedback------------------------>
		    <cfelseif #my_No# EQ 12>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td>&nbsp;<font color="CDC8AB"><b>Leave Feedback for a User</b></font></td></tr>
                 <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
                 <tr><td>
				    <cfinclude template="leavefeedback.cfm">
              	 </td></tr> 	    
		      </table> 
		    <!---------Feedback-for-me---------------------->
		    <cfelseif #my_No# EQ 13>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td>&nbsp;<font color="CDC8AB"><b>Feedbacks to you from other Users</b></font></td></tr>
                 <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
                 <tr><td>
				    <cfinclude template="feeds_recvd.cfm">
              	 </td></tr> 	    
		      </table> 
		    <!---------Feedback-to-others------------------>
		    <cfelseif #my_No# EQ 14>
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td>&nbsp;<font color="CDC8AB"><b>Feedbacks you posted for other Users</b></font></td></tr>
                 <tr><td><hr size=1 color="#heading_color#" noshade></td></tr>
                 <tr><td>
				    <cfinclude template="feeds_left.cfm">
              	 </td></tr> 	    
		      </table> 
		    </cfif>
		  </td>
		  </tr>
		</table>
		</div>
		<br><br><br><br>
		<tr>
			<td>
				<hr width='#get_layout.page_width#' size=1 color="#heading_color#" noshade>
			</td>
		</tr>			
		<tr>
			<td align="left">
				<cfinclude template="../includes/copyrights.cfm">
			</td>
		</tr>
	</td>
</tr>
<table>
</div>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
