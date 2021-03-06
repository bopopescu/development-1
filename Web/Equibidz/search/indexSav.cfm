<cfsetting enablecfoutputonly="yes">
<!---
	Search Page:



--->


<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Check for passed-in params --->
<cfif #isDefined ("search_text")# is 0>
  <cfset #search_text# = "">
</cfif>
<cfif #isDefined ("search_span")# is 0>
  <cfset #search_span# = "title">
</cfif>
<cfif #isDefined ("search_limit")# is 0>
  <cfset #search_limit# = "active">
</cfif>
<cfif #isDefined ("order_by")# is 0>
  <cfset #order_by# = "title">
</cfif>
<cfif #isDefined ("sort_order")# is 0>
  <cfset #sort_order# = "ASC">
</cfif>
<cfif #isDefined ("country")# is 0>
  <cfset #country# = "">
</cfif>
<cfif #isDefined ("country_type")# is 0>
  <cfset #country_type# = "in">
</cfif>
<cfif #isDefined ("search_type")# is 0>
  <cfset #search_type# = "title_search">
</cfif>
<cfif #isDefined ("category")# is 0>
  <cfset #category# = "">
</cfif>
<cfif #isDefined ("radius")# is 0>
  <cfset #radius# = "5">
</cfif>
<cfif #isDefined ("measure_type")# is 0>
  <cfset #measure_type# = "MI">
</cfif>

<!--- Get their info if they're logged in --->
<cfif #isDefined ("session.nickname")#>
  <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
      SELECT user_id,
             nickname,
             name,
             password,
             email
        FROM users
       WHERE nickname = '#session.nickname#'
  </cfquery>
  
  <cfset temp_var = find (" ", get_user_info.name) - 1>
  <cfif temp_var lt 0>
    <cfset not_less_than_one = 1>
  <cfelse>
    <cfset not_less_than_one = temp_var>
  </cfif>
  
  <cfset user_fname = left (get_user_info.name, not_less_than_one)>
<cfelse>
  <cfset #user_fname# = "">
</cfif>

<cfoutput>
<html>
	<head>
		<title>Search Page</title>
		<meta name="keywords" content="#get_layout.keywords#">
		<meta name="description" content="#get_layout.descriptions#">
		<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	</head>

	<cfinclude template="../includes/bodytag.html">
	<cfinclude template="../includes/menu_bar.cfm"> 
	
					<!--- The main table --->
					<table border='0' cellspacing='0' cellpadding='3' width='700' style="color:white;">
					<tr>
						<td colspan='2'>Select only the criteria you want to search on:</td>
					</tr>
					<tr>
						<td colspan='2'><hr /></td>
					</tr>
					<tr>
						<td width='250' valign='top'>Type of Ad:</td>
						<td>
							<select name='type_of_ad' style='width:220px'>
								<option value=''>Horses for Sale & Lease</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Ad Title or Horse Name:</td>
						<td>
							<input type='text' name='ad_title' value='' style='width:220px'>
						</td>
					</tr>
					<tr>
						<td valign='top'>Location:</td>
						<td>
							<select name='location' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value=''>Region - Middle Atlantic</option>
								<option value=''>Region - Midwest</option>
								<option value=''>Region - New England</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>City:</td>
						<td>
							<input type='text' name='city' size='35' value='' style='width:220px'>
						</td>
					</tr>
					<tr>
						<td valign='top'>Zip Search (US Only):</td>
						<td>
							<select name='distance'>
								<option value=''></option>
							</select>
							from the
							<input type='text' name='zip' size='15'>
							zip code
						</td>
					</tr>
					<tr>
						<td valign='top'>Primary Breed:</td>
						<td>
							<select name='primary_breed' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value=''>---------</option>
								<option value=''>Breeds w/ Most Ads</option>
								<option value=''>Quarter Horse</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Purebred Only:</td>
						<td>
							<input type='checkbox' name='purebred' value='purebred'>
						</td>
					</tr>
					<tr>
						<td>Secondary Breed</td>
						<td>
							<select name='secondary_breed' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value=''>---------</option>
								<option value=''>Breeds w/ Most Ads</option>
								<option value=''>Quarter Horse</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Sex:</td>
						<td>
							<select name='sex' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value='gelding'>Gelding</option>
								<option value='mare'>Mare</option>
								<option value='stallion'>Stallion</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Age:</td>
						<td>
							<select name='age_min'>
								<option value=''>-- Min --</option>
							</select>
							to
							<select name='age_max'>
								<option value=''>-- Max --</option>
							</select>
							years
						</td>
					</tr>
					<tr>
						<td valign='top'>Height:</td>
						<td>
							<select name='height_min'>
								<option value=''>-- Min --</option>
							</select>
							to
							<select name='height_max'>
								<option value=''>-- Max --</option>
							</select>
							hands
						</td>
					</tr>
					<tr>
						<td valign='top'>Base Color:</td>
						<td>
							<select name='base_color' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value='bay'>Bay</option>
								<option value='black'>Black</option>
								<option value='brown'>Brown</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Price:</td>
						<td>
							$<input type='text' name='price_min' size='5' value=''>
							to
							$<input type='text' name='price_max' size='5' value=''>
						</td>
					</tr>
					<tr>
						<td valign='top'>Bloodline:</td>
						<td>
							<input type='text' name='bloodline' size='20' value=''>
							<select name='bloodline'>
								<option value=''>-- Any Generation --</option>
							</select>
						</td>
					</tr>		
					<tr>
						<td valign='top'>Discipline:</td>
						<td>
							<select name='discipline' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value='barrel_racing'>Barrel Racing</option>
								<option value='beginner_family'>Beginner / Family</option>
								<option value='breeding'>Breeding</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Experience in Discipline:</td>
						<td>
							<select name='experience' style='width:220px'>
								<option value=''>-- Any --</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Attributes:</td>
						<td>
							<select name='attributes' size='4' style='width:220px'>
								<option value=''>-- Any --</option>
								<option value=''>All-Around Champion</option>
								<option value=''>All-Around Reserce Champion</option>
								<option value=''>APHA Breeders Trust</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign='top'>Temperament:</td>
						<td>
							<select name='temperament_min'>
								<option value=''>-- Min --</option>
							</select>
							to
							<select name='temperament_max'>
								<option value=''>-- Max --</option>
							</select>				
						</td>
					</tr>
					<tr>
						<td valign='top'>Ads Posted:</td>
						<td>
							<select name='ads_posted'>
								<option value=''>-- Any --</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan='2' align='center' valign='top'>
							<table border='0' cellspacing='0' cellpadding='3' width='400' style="color:white;">
							<tr>
								<td valign='top'>
									<input type='checkbox' name='' value=''>Exclude Sold Ads<br />
									<input type='checkbox' name='' value=''>May Trade Only<br />
									<input type='checkbox' name='' value=''>Must be registered<br />
									<input type='checkbox' name='' value=''>Free Horses
								</td>
								<td valign='top'>
									<input type='checkbox' name='' value=''>List ads with photos<br />
									<input type='checkbox' name='' value=''>List ads with videos<br />
									<input type='checkbox' name='' value=''>GUARANTEED to sell
								</td>
							</tr>
							</table>
						</td>
					</tr>
					</table>
				</td>
			</tr>
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
			</table>
		</td>
	</tr>
	</table>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
