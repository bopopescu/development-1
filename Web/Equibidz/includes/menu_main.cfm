<cfoutput>
<cfparam name="current_page" default="indexhome">
<cfset classified_valid="No">
<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">			
<body bgcolor="#get_layout.bg_color#" text="#get_layout.text_color#" marginheight="0" topmargin="0" vspace="0" marginwidth="0" leftmargin="0" hspace="0" style="margin:0; padding:0;font-family:#get_layout.text_font#" onLoad="ShowText();">
<!--- Start: Main Body --->
<!--<table style="background-image: url('#VAROOT#/images/bg_table.jpg')" width="706" border="0" align="center" cellpadding="0" cellspacing="0">-->
<table class="tbl-sidecolor" width="706" border="0" align="center" cellpadding="0" cellspacing="0">
<tr valign="top">
	<td align="center">
		<table width="750" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="20">&nbsp;</td>
		</tr>
		<tr>
			<td style="background-image: url('/images/bg_filler.jpg'); height:35px;" align="center">
              <!---<div class="main-menu">
				 New button styles ---->
				 <span class="main-menu">
				<a href="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0" class="btn">Search</a>
				<a href="#VAROOT#/listings/index.cfm?curr_cat=S&curr_lvl=0" class="btn">Auctions</a>
				<a href="#VAROOT#/advertise" class="btn">Advertise</a>
				<a href="#VAROOT#/terms.cfm" class="btn">Terms</a>
				<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
				<cfelse>
					<a href="#VAROOT#/registration" class="btn">Registrations</a>
				</cfif>
					<a href="#VAROOT#/contactus.cfm" class="btn">Contact Us</a>
					<a href="#VAROOT#/help.cfm" class="btn">Help</a>
				<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
					<a href="#VAROOT#/personal/my_auctions.cfm?my_No=11" class="btn">MY AUCTION</a>
					<a href="#VAROOT#/personal/my_accounts.cfm?my_No=11" class="btn">MY ACCOUNT</a>
					<cfinclude template="post_new_horse.cfm">
				<cfelse>
					<a href="#VAROOT#/login.cfm?login=1" class="btn">LOGIN</a>
				</cfif>
				</div>
			    <cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
                   <div class="login">
                      <cfquery username="#db_username#" password="#db_password#" name="get_user" datasource="#DATASOURCE#">
					  	 SELECT nickname
	                     FROM users
	                     WHERE user_id = #session.user_id#
                      </cfquery>                      
			          <font size=2 face="century gothic">&nbsp;<a style="text-decoration:underline;" href="#VAROOT#/personal/my_accounts.cfm?my_No=11">#ucase(get_user.nickname)#</a> | <a style="text-decoration:underline;" href="#VAROOT#/login.cfm?logout=1">LOGOUT</a></font> 			       </div>   
 			    </cfif>   
                <div class="bookmark">
                   <font size=1>Share this&nbsp;</font>
			       <script type="text/javascript">
					  addthis_url    = location.href;   
					  addthis_title  = document.title;  
					  addthis_pub    = 'equibidz';     						
				   </script>
				   <script type="text/javascript" src="http://s7.addthis.com/js/addthis_widget.php?v=12"></script>                    
		        </div>			
              	<!---<div class="logo">
					<img src="#VAROOT#/images/logo.jpg" alt="Equibidz Logo" />
					<div class="logo-text">
						Equibidz.com
					</div>
                </div>--->			</td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  </tr>
		<!---<tr>
			<td align='center' valign='top'>
</td>
</tr>--->
</table>
</cfoutput>