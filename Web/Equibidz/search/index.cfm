<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">


<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>

<cfif isDefined("name")>
    <cfset name = #name#>
<cfelse>
    <cfif isDefined("session.name")>
       <cfset name = #session.name#>
    <cfelse>
       <cfset name = "">
    </cfif>   
</cfif>
<cfif isDefined("list_type")>
    <cfset list_type = #list_type#>
<cfelse>
    <cfif isDefined("session.list_type")>
       <cfset list_type = #session.list_type#>
    <cfelse>
       <cfset list_type = "">
    </cfif>   
</cfif>
<cfif isDefined("category1")>
    <cfset category1 = #category1#>
<cfelse>
    <cfif isDefined("session.category1")>
       <cfset category1 = #session.category1#>
    <cfelse>
       <cfset category1 = 0>
    </cfif>   
</cfif>
<cfif isDefined("location")>
    <cfset location = #selected_location#>
<cfelse>
    <cfif isDefined("session.location")>
       <cfset location = #session.location#>
    <cfelse>
       <cfset location = "">
    </cfif>   
</cfif>
<cfif isDefined("state")>
    <cfset state = #state#>
<cfelse>
    <cfif isDefined("session.state")>
       <cfset state = #session.state#>
    <cfelse>
       <cfset state = "">
    </cfif>   
</cfif>
<cfif isDefined("country")>
    <cfset country = #country#>
<cfelse>
    <cfif isDefined("session.country")>
       <cfset country = #session.country#>
    <cfelse>
       <cfset country = "">
    </cfif>   
</cfif>
<cfif isDefined("province")>
    <cfset province = #province#>
<cfelse>
    <cfif isDefined("session.province")>
       <cfset province = #session.province#>
    <cfelse>
       <cfset province = "">
    </cfif>   
</cfif>
<cfif isDefined("city")>
    <cfset city = #city#>
<cfelse>
    <cfif isDefined("session.city")>
       <cfset city = #session.city#>
    <cfelse>
       <cfset city = "">
    </cfif>   
</cfif>
<cfif isDefined("zipcode")>
    <cfset zipcode = #zipcode#>
<cfelse>
    <cfif isDefined("session.zipcode")>
       <cfset zipcode = #session.zipcode#>
    <cfelse>
       <cfset zipcode= "">
    </cfif>
</cfif>
<cfif isDefined("pri_breed")>
    <cfset pri_breed = #selected_pri_breed#>
<cfelse>
    <cfif isDefined("session.pri_breed")>
       <cfset pri_breed = #session.pri_breed#>
    <cfelse>
       <cfset pri_breed= "">
    </cfif>   
</cfif>
<cfif isDefined("pure_breed")>
    <cfset pure_breed = 1>
<cfelse>
    <cfset pure_breed= 0>
</cfif>
<cfif isDefined("sec_breed")>
    <cfset sec_breed = #selected_sec_breed#>
<cfelse>
    <cfif isDefined("session.sec_breed")>
       <cfset sec_breed = #session.sec_breed#>
    <cfelse>
       <cfset sec_breed= "">
    </cfif>   
</cfif>
<cfif isDefined("sex")>
    <cfset sex = #selected_sex#>
<cfelse>
    <cfif isDefined("session.sex")>
       <cfset sex = #session.sex#>
    <cfelse>
       <cfset sex= "">
    </cfif>   
</cfif>
<cfif isDefined("age_min")>
    <cfset age_min = #selected_age_min#>
<cfelse>
    <cfif isDefined("session.age_min")>
       <cfset age_min = #session.age_min#>
    <cfelse>
       <cfset age_min = 0>
    </cfif>   
</cfif>
<cfif isDefined("age_max")>
    <cfset age_max = #selected_age_max#>
<cfelse>
    <cfif isDefined("session.age_max")>
       <cfset age_max = #session.age_max#>
    <cfelse>
       <cfset age_max = 50>
    </cfif>   
</cfif>
<cfif isDefined("height_min")>
    <cfset height_min = #selected_height_min#>
<cfelse>
    <cfif isDefined("session.height_min")>
       <cfset height_min = #session.height_min#>
    <cfelse>
       <cfset height_min = "">
    </cfif>   
</cfif>
<cfif isDefined("height_max")>
    <cfset height_max = #selected_height_max#>
<cfelse>
    <cfif isDefined("session.height_max")>
       <cfset height_max = #session.height_max#>
    <cfelse>
       <cfset height_max = "">
    </cfif>   
</cfif>
<cfif isDefined("color")>
    <cfset color = #selected_color#>
<cfelse>
    <cfif isDefined("session.color")>
       <cfset color = #session.color#>
    <cfelse>
       <cfset color = "">
    </cfif>   
</cfif>
<cfif isDefined("price_min")>
    <cfset price_min = #price_min#>
<cfelse>
    <cfif isDefined("session.price_min")>
       <cfset price_min = #session.price_min#>
    <cfelse>
       <cfset price_min = 0.00>
    </cfif>   
</cfif>
<cfif isDefined("price_max")>
    <cfset price_max = #price_max#>
<cfelse>
    <cfif isDefined("session.price_max")>
       <cfset price_max = #session.price_max#>
    <cfelse>
       <cfset price_max = 999999999.99>
    </cfif>   
</cfif>
<cfif isDefined("discipline")>
    <cfset discipline = #selected_discipline#>
<cfelse>
    <cfif isDefined("session.discipline")>
       <cfset discipline = #session.discipline#>
    <cfelse>
       <cfset discipline = "">
    </cfif>   
</cfif>
<cfif isDefined("experience")>
    <cfset experience = #selected_experience#>
<cfelse>
    <cfif isDefined("session.experience")>
       <cfset experience = #session.experience#>
    <cfelse>
       <cfset experience = "">
    </cfif>   
</cfif>
<cfif isDefined("attributes")>
    <cfset attributes = #selected_attributes#>
<cfelse>
    <cfif isDefined("session.attributes")>
       <cfset attributes = #session.attributes#>
    <cfelse>
       <cfset attributes = "">
    </cfif>   
</cfif>
<cfif isDefined("temperament_min")>
    <cfset temperament_min = #temperament_min#>
<cfelse>
    <cfif isDefined("session.temperament_min")>
       <cfset temperament_min = #session.temperament_min#>
    <cfelse>
      <cfset temperament_min = "">
    </cfif>  
</cfif>
<cfif isDefined("temperament_max")>
    <cfset temperament_max = #temperament_max#>
<cfelse>
    <cfif isDefined("session.temperament_max")>
       <cfset temperament_max = #session.temperament_max#>
    <cfelse>
      <cfset temperament_max = "">
    </cfif>  
</cfif>
<cfif isDefined("chk_sold")>
    <cfset chk_sold = 1>
<cfelse>
    <cfset chk_sold = 0>
</cfif>
<cfif isDefined("chk_registered")>
    <cfset chk_registered = 1>
<cfelse>
    <cfset chk_registered = 0>
</cfif>
<cfif isDefined("chk_withphoto")>
    <cfset chk_withphoto = 1>
<cfelse>
    <cfset chk_withphoto = 0>
</cfif>
<cfif isDefined("chk_withvideo")>
    <cfset chk_withvideo = 1>
<cfelse>
    <cfset chk_withvideo = 0>
</cfif>

<cfif #trim(submit)# is "Search">
    <cfset session.name = #name#>
    <cfset session.list_type = #selected_list_type#>
    <cfset session.category1 = #category1#>
    <cfset session.location = #selected_location#>
    <cfset session.city = #city#>
    <cfset session.state = #state#>
    <cfset session.country = #country#>
    <cfset session.province = #province#>
    <cfset session.zipcode = #zipcode#>
    <cfset session.pri_breed = #selected_pri_breed#>
    <cfset session.pure_breed = #pure_breed#>
    <cfset session.sec_breed = #selected_sec_breed#>
    <cfset session.sex = #selected_sex#>
    <cfset session.age_min = #selected_age_min#>
    <cfset session.age_max = #selected_age_max#>
    <cfset session.height_min = #selected_height_min#>
    <cfset session.height_max = #selected_height_max#>
    <cfset session.color = #selected_color#>
    <cfset session.price_min = #price_min#>
    <cfset session.price_max = #price_max#>
    <cfset session.discipline = #selected_discipline#>
    <cfset session.experience = #selected_experience#>
    <cfset session.attributes = #selected_attributes#>
    <cfset session.temperament_min = #selected_temperament_min#>
    <cfset session.temperament_max = #selected_temperament_max#>
    <cfset session.chk_sold = #chk_sold#>
    <cfset session.chk_registered = #chk_registered#>
    <cfset session.chk_withphoto = #chk_withphoto#>
    <cfset session.chk_withvideo = #chk_withvideo#>
    <cflocation url="search_results.cfm">
</cfif>
<cfif isDefined("session.pure_breed")>
    <cfset pure_breed = #session.pure_breed#>
<cfelse>
    <cfset pure_breed = #pure_breed#>
</cfif>
<cfif isDefined("session.chk_sold")>
    <cfset chk_sold = #session.chk_sold#>
<cfelse>
    <cfset chk_sold = #chk_sold#>
</cfif>
<cfif isDefined("session.chk_registered")>
    <cfset chk_registered = #session.chk_registered#>
<cfelse>
    <cfset chk_registered = #chk_registered#>
</cfif>
<cfif isDefined("session.chk_withphoto")>
    <cfset chk_withphoto = #session.chk_withphoto#>
<cfelse>
    <cfset chk_withphoto = #chk_withphoto#>
</cfif>
<cfif isDefined("session.chk_withvideo")>
    <cfset chk_withvideo = #session.chk_withvideo#>
<cfelse>
    <cfset chk_withvideo = #chk_withvideo#>
</cfif>

<cfif #submit# EQ 0 OR #trim(submit)# is "Reset">
   <cfset name = "">
   <cfset list_type = "">
   <cfset category1 = 0>
   <cfset location = "">
   <cfset city = "">
   <cfset state = "">
   <cfset country = "">
   <cfset province = "">   
   <cfset zipcode = "">
   <cfset pri_breed = "">
   <cfset pure_breed = "">
   <cfset sec_breed = "">
   <cfset sex= "">
   <cfset age_min = 0>
   <cfset age_max = 50>
   <cfset height_min = "">
   <cfset height_max = "">
   <cfset color = "">
   <cfset price_min = 0.00>
   <cfset price_max = 999999999.99>
   <cfset discipline = "">
   <cfset experience = "">
   <cfset attributes = "">
   <cfset temperament_min = "">
   <cfset temperament_max = "">
   <cfset chk_sold = 1>
   <cfset chk_maytrade = 0>
   <cfset chk_registered = 0>
   <cfset chk_free = 0>
   <cfset chk_withphoto = 0>
   <cfset chk_withvideo = 0>
   <cfset chk_guaranteed = 0>
</cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total, this_lvl
      FROM categories
     WHERE active = 1
       AND parent = 0
     ORDER BY name ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_breed" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'breed'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'color'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_height" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'height'
   ORDER BY pair+0
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_discipline" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'discipline'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_experience" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'experience'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_attributes" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'attributes'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_temperament" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'temperament'
   ORDER BY pair+0
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_location" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'location'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_dollar_type" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'dollar_type'
   ORDER BY pair ASC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="get_list_type" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'list_type'
   ORDER BY pair ASC
</cfquery>


<cfoutput>
<html>
<head>
	<title>Equibidz-Search</title>
	<meta name="keywords" content="#get_layout.keywords#">
	<meta name="description" content="#get_layout.descriptions#">
	<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
	<link rel=stylesheet href="#VAROOT#/includes/stylenew.css" type="text/css">
   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
   
   
<script> 
   
	$(document).ready(function(){
	
			$('.addDiscipline').click(function(){
			
				$('.cb').slideToggle("fast");
			
			});
	
			$('.addAttributes').click(function(){
				$('.cb2').slideToggle("fast");
			
			});
			
			
			
			
			
	});
   
   </script>
   <script>
  
   
		function updateDiscipline() {
         
         var allVals = [];
         $('.cb :checked').each(function() {
           allVals.push($(this).val());
         });
         $('.txtdiscipline').val(allVals)
      }
     $(function() {
       $('.cb input').click(updateDiscipline);
       updateDiscipline();
     });
	 
	 
	 function updateAttributes() {
         
         var allVals = [];
         $('.cb2 :checked').each(function() {
           allVals.push($(this).val());
         });
         $('.txtattributes').val(allVals)
      }
     $(function() {
       $('.cb2 input').click(updateAttributes);
       updateAttributes();
     });
	 
	 
	 
	 

	 
	</script>
	
	<style type="text/css">
	
		.cb{
		
		height:200px;
		width:200px;
		overflow:scroll;
		display:none;
		margin-bottom:20px;
		
		}
		
		.cb2{
		
		height:200px;
		width:300px;
		overflow:scroll;
		display:none;
		margin-bottom:20px;
		
		}
		
		.addDiscipline{
		
		cursor:pointer
		
		
		}
		
		.addAttributes{
		
		cursor:pointer
		
		
		}
	</style>
	
</head>
<cfinclude template="../includes/menu_bar.cfm"> 

<body>
<div align="center">
<table border='0' width='1' class="tbl-sidecolor"  cellpadding="0" cellspacing="0">
<tr><td><br></td></tr>
<tr valign="top">
	<td align="center">
		<!--- Start: Main Body --->
		<div align="center">
		<table width='900' cellpadding="0" cellspacing="0" style="border-color: 000; border-width: 1px:">
		  <tr><td colspan=13 align="left">
		      <font size=4><b>Search</b></font><br>
		      <font size=2>To see items only in that <b>Category</b>.</font>
	      </td></tr>
		  <td width=250 valign="top">
   		      <table width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td align="center"><font color=""><b>Category</b></font></td></tr>
                 <tr><td colspan=13><hr size=1 color="#heading_color#" noshade></td></tr>
	             <tr><td>
   		         <table width='99%' cellpadding="0" cellspacing="0">
   		         <cfif get_Categories.RecordCount>
    		        <cfloop query="get_Categories">
				       <cfquery username="#db_username#" password="#db_password#" name="get_totals" datasource="#DATASOURCE#">
					      SELECT count(itemnum) as total_items
					      FROM items
					      WHERE category1 = #category# AND status = 1
                       </cfquery>
                       <tr>
                          <td width="6%" align="left" valign="middle">
 		                     <a href="#VAROOT#/listings/index.cfm?curr_cat=#category#&curr_lvl=#this_lvl#&from_search=1"><img src="#VAROOT#/images/icon_post.gif" border="0" width="10" height="10"></a>
 		                  </td>
 		                  <td width="94%" align="left">   
 		                     <a href="#VAROOT#/listings/index.cfm?curr_cat=#category#&curr_lvl=#this_lvl#&from_search=1"><font size=3><b>#name#</b>
		                     <cfif #child_count# GT 0>
		                         <img src="#VAROOT#/images/folder.gif" width=18 height=18 border=0 align=top title="Click to view sub-categories">
		                     </cfif>
                             <font size=1>(#get_totals.total_items#)</font>		      
                             </a>          
                          </td>
                       </tr>   
                       <tr><td colspan=2>&nbsp;</td></tr>
    		        </cfloop>
	                <tr><td colspan=2>&nbsp;</td></tr>
	                <tr><td colspan=2 align="center"><font color="000" size=2>Note: Items may exist<br>in sub-categories.</font></td></tr>
    		     <cfelse>
 	                <tr><td colspan=2>&nbsp;</td></tr>
	                <tr><td colspan=2align="center"><font color="000" size=2>No sub-categories found.</font></td></tr>
	             </cfif>   
                 <tr><td>&nbsp;</td></tr>
    		     </table>
    		     </td></tr>
              </table>
		  </td>
		  <td width=20></td>
		  <td width=630 valign="top">
			  <form name="search" action="index.cfm" method="post">		  
   		      <table border='0' width='100%' cellpadding="0" cellspacing="0">
		         <tr bgcolor="616362"><td colspan=2>&nbsp;&nbsp;<font color="000"><b>Select only the criteria you want to search on:</b></td></tr>
                 <tr><td colspan=2><hr size=1 color="#heading_color#" noshade></td></tr>
                 <tr>
                 <td width="1%">&nbsp;</td>
                 <td width="99%">
   		         <table border='0' width='100%' cellpadding="0" cellspacing="0">
                    <tr>
                       <td><font size=2 color="000"><b>Horse Name:</b></font></td>
                       <td><input type="text" name="name" value="#name#" size=30>&nbsp;<font size=1 color="000">(Blank to select ALL)</font></td> 
                    </tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Listing Title:</b></font></td>
						<td>
                           <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category1"
                              selected="#category1#"
                              any="1">
                        </td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Listing Type:</b></font></td>
		 				<td>
                           <select name="selected_list_type">
                              <option value=""<cfif #list_type# is ""> selected</cfif>>---Any---</option>
                              <cfloop query="get_list_type">
                                 <option value="#pair#"<cfif #list_type# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>City:</b></font></td>
						<td><input type='text' name='city' size='15' value='#city#'>&nbsp;<font size=1 color="000">(Blank to select ALL)</font></td>
					</tr>
                    <tr>
                       <td><font size=2 color="000"><b>State:</font></td>
                       <td>
                  	      <CFMODULE TEMPLATE="..\functions\cf_states.cfm"
                              SELECTNAME="state"
                              SELECTED="#state#"
                              MULTIPLE="0"
                              SIZE="1"
                              ANY="2">
                       </td>
                    </tr>
                    <tr>
                       <td><font size=2 color="000"><b>Country:</font></td>
                       <td>
                          <CFMODULE TEMPLATE="..\functions\cf_countries.cfm"
                              SELECTNAME="country"
                              SELECTED="#country#"
                              MULTIPLE="0"
                              SIZE="1"
                              ANY="1">
                       </td>
                    </tr>
                    <tr>
                       <td><font size=2 color="000"><b>Province (Non US):</b></font></td>
                       <td><input type="text" name="province" value="#province#" size=15>&nbsp;<font size=1 color="000">(Blank to select ALL)</font></td> 
                    </tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Location:</b></font></td>
						<td>
                           <select name="selected_location">
                              <option value=""<cfif #location# is ""> selected</cfif>>---Any---</option>
                              <cfloop query="get_location">
                                 <option value="#pair#"<cfif #location# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
                        </td>   
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Zip Search (US Only):</b></font></td>
						<td><input type='text' name='zipcode' value="#zipcode#" size='15'>&nbsp;<font size=1 color="000">(blank to select ALL)</font></td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Primary Breed:</b></font></td>
		 				<td>
                           <select name="selected_pri_breed">
                              <option value=""<cfif #pri_breed# is ""> selected</cfif>>---Any---</option>
                              <cfloop query="get_breed">
                                 <option value="#pair#"<cfif #pri_breed# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td align='left'><font size=2 color="000"><b>Purebred Only:</b></font></td>
						<td>
							<input type='checkbox' name='pure_breed' value='#pure_breed#' <cfif #pure_breed# EQ 1>checked</cfif>>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Secondary Breed:</b></font></td>
		 				<td>
                           <select name="selected_sec_breed">
                              <option value=""<cfif #sec_breed# is ""> selected</cfif>>---Not Applicable---</option>
                              <cfloop query="get_breed">
                                 <option value="#pair#"<cfif #sec_breed# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Sex:</b></font></td>
						<td>
                           <select name="selected_sex">
                              <option value=""<cfif #sex# is ""> selected</cfif>>---Any---</option>
                              <option value="S"<cfif #sex# is "S"> selected</cfif>>Stallion</option>
                              <option value="M"<cfif #sex# is "M"> selected</cfif>>Mare</option>
                              <option value="G"<cfif #sex# is "G"> selected</cfif>>Gelding</option>
                           </select>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Age Range:</b></font></td>
						<td>
                           <select name="selected_age_min">
                              <option value="0"<cfif #age_min# is 0> selected</cfif>>---Min---</option>
                              <option value="1"<cfif #age_min# is 1> selected</cfif>>1 year old</option>
                              <option value="2"<cfif #age_min# is 2> selected</cfif>>2 years old</option>
                              <option value="3"<cfif #age_min# is 3> selected</cfif>>3 years old</option>
                              <option value="4"<cfif #age_min# is 4> selected</cfif>>4 years old</option>
                              <option value="5"<cfif #age_min# is 5> selected</cfif>>5 years old</option>
                              <option value="6"<cfif #age_min# is 6> selected</cfif>>6 years old</option>
                              <option value="7"<cfif #age_min# is 7> selected</cfif>>7 years old</option>
                              <option value="8"<cfif #age_min# is 8> selected</cfif>>8 years old</option>
                              <option value="9"<cfif #age_min# is 9> selected</cfif>>9 years old</option>
                              <option value="10"<cfif #age_min# is 10> selected</cfif>>10 years old</option>
                              <option value="11"<cfif #age_min# is 11> selected</cfif>>11 years old</option>
                              <option value="12"<cfif #age_min# is 12> selected</cfif>>12 years old</option>
                              <option value="13"<cfif #age_min# is 13> selected</cfif>>13 years old</option>
                              <option value="14"<cfif #age_min# is 14> selected</cfif>>14 years old</option>
                              <option value="15"<cfif #age_min# is 15> selected</cfif>>15 years old</option>
                              <option value="16"<cfif #age_min# is 16> selected</cfif>>16 years old</option>
                              <option value="17"<cfif #age_min# is 17> selected</cfif>>17 years old</option>
                              <option value="18"<cfif #age_min# is 18> selected</cfif>>18 years old</option>
                              <option value="19"<cfif #age_min# is 19> selected</cfif>>19 years old</option>
                              <option value="20"<cfif #age_min# is 20> selected</cfif>>20 years old</option>
                              <option value="21"<cfif #age_min# is 21> selected</cfif>>21 years old</option>
                              <option value="22"<cfif #age_min# is 22> selected</cfif>>22 years old</option>
                              <option value="23"<cfif #age_min# is 23> selected</cfif>>23 years old</option>
                              <option value="24"<cfif #age_min# is 24> selected</cfif>>24 years old</option>
                              <option value="25"<cfif #age_min# is 25> selected</cfif>>25 years old</option>
                              <option value="26"<cfif #age_min# is 26> selected</cfif>>26 years old</option>
                              <option value="27"<cfif #age_min# is 27> selected</cfif>>27 years old</option>
                              <option value="28"<cfif #age_min# is 28> selected</cfif>>28 years old</option>
                              <option value="29"<cfif #age_min# is 29> selected</cfif>>29 years old</option>
                              <option value="30"<cfif #age_min# is 30> selected</cfif>>30 years old</option>
                              <option value="31"<cfif #age_min# is 31> selected</cfif>>31 years old</option>
                              <option value="32"<cfif #age_min# is 32> selected</cfif>>32 years old</option>
                              <option value="33"<cfif #age_min# is 33> selected</cfif>>33 years old</option>
                              <option value="34"<cfif #age_min# is 34> selected</cfif>>34 years old</option>
                              <option value="35"<cfif #age_min# is 35> selected</cfif>>35 years old</option>
                              <option value="36"<cfif #age_min# is 36> selected</cfif>>36 years old</option>
                              <option value="37"<cfif #age_min# is 37> selected</cfif>>37 years old</option>
                              <option value="38"<cfif #age_min# is 38> selected</cfif>>38 years old</option>
                              <option value="39"<cfif #age_min# is 39> selected</cfif>>39 years old</option>
                              <option value="30"<cfif #age_min# is 40> selected</cfif>>40 years old</option>
                              <option value="41"<cfif #age_min# is 41> selected</cfif>>41 years old</option>
                              <option value="42"<cfif #age_min# is 42> selected</cfif>>42 years old</option>
                              <option value="43"<cfif #age_min# is 43> selected</cfif>>43 years old</option>
                              <option value="44"<cfif #age_min# is 44> selected</cfif>>44 years old</option>
                              <option value="45"<cfif #age_min# is 45> selected</cfif>>45 years old</option>
                              <option value="46"<cfif #age_min# is 46> selected</cfif>>46 years old</option>
                              <option value="47"<cfif #age_min# is 47> selected</cfif>>47 years old</option>
                              <option value="48"<cfif #age_min# is 48> selected</cfif>>48 years old</option>
                              <option value="49"<cfif #age_min# is 49> selected</cfif>>49 years old</option>
                              <option value="60"<cfif #age_min# is 50> selected</cfif>>50 years old</option>
                            </select>  
							<font size=2 color="000">to</font>
                           <select name="selected_age_max">
                              <option value="1"<cfif #age_max# is 1> selected</cfif>>1 year old</option>
                              <option value="2"<cfif #age_max# is 2> selected</cfif>>2 years old</option>
                              <option value="3"<cfif #age_max# is 3> selected</cfif>>3 years old</option>
                              <option value="4"<cfif #age_max# is 4> selected</cfif>>4 years old</option>
                              <option value="5"<cfif #age_max# is 5> selected</cfif>>5 years old</option>
                              <option value="6"<cfif #age_max# is 6> selected</cfif>>6 years old</option>
                              <option value="7"<cfif #age_max# is 7> selected</cfif>>7 years old</option>
                              <option value="8"<cfif #age_max# is 8> selected</cfif>>8 years old</option>
                              <option value="9"<cfif #age_max# is 9> selected</cfif>>9 years old</option>
                              <option value="10"<cfif #age_max# is 10> selected</cfif>>10 years old</option>
                              <option value="11"<cfif #age_max# is 11> selected</cfif>>11 years old</option>
                              <option value="12"<cfif #age_max# is 12> selected</cfif>>12 years old</option>
                              <option value="13"<cfif #age_max# is 13> selected</cfif>>13 years old</option>
                              <option value="14"<cfif #age_max# is 14> selected</cfif>>14 years old</option>
                              <option value="15"<cfif #age_max# is 15> selected</cfif>>15 years old</option>
                              <option value="16"<cfif #age_max# is 16> selected</cfif>>16 years old</option>
                              <option value="17"<cfif #age_max# is 17> selected</cfif>>17 years old</option>
                              <option value="18"<cfif #age_max# is 18> selected</cfif>>18 years old</option>
                              <option value="19"<cfif #age_max# is 19> selected</cfif>>19 years old</option>
                              <option value="20"<cfif #age_max# is 20> selected</cfif>>20 years old</option>
                              <option value="21"<cfif #age_max# is 21> selected</cfif>>21 years old</option>
                              <option value="22"<cfif #age_max# is 22> selected</cfif>>22 years old</option>
                              <option value="23"<cfif #age_max# is 23> selected</cfif>>23 years old</option>
                              <option value="24"<cfif #age_max# is 24> selected</cfif>>24 years old</option>
                              <option value="25"<cfif #age_max# is 25> selected</cfif>>25 years old</option>
                              <option value="26"<cfif #age_max# is 26> selected</cfif>>26 years old</option>
                              <option value="27"<cfif #age_max# is 27> selected</cfif>>27 years old</option>
                              <option value="28"<cfif #age_max# is 28> selected</cfif>>28 years old</option>
                              <option value="29"<cfif #age_max# is 29> selected</cfif>>29 years old</option>
                              <option value="30"<cfif #age_max# is 30> selected</cfif>>30 years old</option>
                              <option value="31"<cfif #age_max# is 31> selected</cfif>>31 years old</option>
                              <option value="32"<cfif #age_max# is 32> selected</cfif>>32 years old</option>
                              <option value="33"<cfif #age_max# is 33> selected</cfif>>33 years old</option>
                              <option value="34"<cfif #age_max# is 34> selected</cfif>>34 years old</option>
                              <option value="35"<cfif #age_max# is 35> selected</cfif>>35 years old</option>
                              <option value="36"<cfif #age_max# is 36> selected</cfif>>36 years old</option>
                              <option value="37"<cfif #age_max# is 37> selected</cfif>>37 years old</option>
                              <option value="38"<cfif #age_max# is 38> selected</cfif>>38 years old</option>
                              <option value="39"<cfif #age_max# is 39> selected</cfif>>39 years old</option>
                              <option value="30"<cfif #age_max# is 40> selected</cfif>>40 years old</option>
                              <option value="41"<cfif #age_max# is 41> selected</cfif>>41 years old</option>
                              <option value="42"<cfif #age_max# is 42> selected</cfif>>42 years old</option>
                              <option value="43"<cfif #age_max# is 43> selected</cfif>>43 years old</option>
                              <option value="44"<cfif #age_max# is 44> selected</cfif>>44 years old</option>
                              <option value="45"<cfif #age_max# is 45> selected</cfif>>45 years old</option>
                              <option value="46"<cfif #age_max# is 46> selected</cfif>>46 years old</option>
                              <option value="47"<cfif #age_max# is 47> selected</cfif>>47 years old</option>
                              <option value="48"<cfif #age_max# is 48> selected</cfif>>48 years old</option>
                              <option value="49"<cfif #age_max# is 49> selected</cfif>>49 years old</option>
                              <option value="50"<cfif #age_max# is 50> selected</cfif>>---Max---</option>
                            </select>  
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Height Range:</b></font></td>
						<td>
                           <select name="selected_height_min">
                              <option value=""<cfif #height_min# is ""> selected</cfif>>---Min---</option>
                              <cfloop query="get_height">
                                 <option value="#pair#"<cfif #height_min# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						   <font size=2 color="000">to</font>
                           <select name="selected_height_max">
                              <option value=""<cfif #height_max# is ""> selected</cfif>>---Max---</option>
                              <cfloop query="get_height">
                                 <option value="#pair#"<cfif #height_max# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Base Color:</b></font></td>
						<td>
                           <select name="selected_color">
                              <option value=""<cfif #color# is ""> selected</cfif>>---Any---</option>
                              <cfloop query="get_color">
                                 <option value="#pair#"<cfif #color# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Price Range:</b></font></td>
						<td>
				           <table width=100% border=0 cellspaceing=0 cellpadding=0>
						      <tr>						      
							  <td><font size=2 color="000">
							      <input type='text' name='price_min' size='12' value='#price_min#'>
 							      <font size=2 color="000">to</font>
							      <input type='text' name='price_max' size='12' value='#price_max#'> in US Dollars<br>
							      (Do not enter (,)commas or currency sign)
							 </font></td>
							 </tr>
						   </table>	 
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Discipline:</b></font></td>
						<td>
    

						   <div class="addDiscipline" > <input type="textbox" id="txtdiscipline"  class="txtdiscipline" size="50" 		name="selected_discipline"> <font size="2px"> Show/Hide</font></div>
							<div class="cb" id="cb">
							<cfloop query="get_discipline">
							<input type="checkbox" value="#pair#"<cfif #discipline# is #pair#> selected</cfif>>#pair# <br>
							</cfloop>
							</div>
				   

				   
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Experience in Discipline:</b></font></td>
						<td>
                           <select name="selected_experience">
                              <option value=""<cfif #experience# is ""> selected</cfif>>---Any---</option>
                              <cfloop query="get_experience">
                                 <option value="#pair#"<cfif #experience# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Attributes:</b></font></td>
						<td>
              
		
						   
						   <div class="addAttributes"> <input type="textbox" id="txtattributes"  class="txtattributes" size="50" name="selected_attributes"><font size="2px"> Show/Hide</font></div>
				   <div class="cb2" id="cb2">
                   <cfloop query="get_attributes">
                    <input type="checkbox" value="#pair#"<cfif #attributes# is #pair#> selected</cfif>>#pair# <br>
                   </cfloop>
				   </div>
						   
						   
						   
						   
						   
						   
						   
						   
						   
						   
						   
						   
						</td>
					</tr>
					<tr>
						<td valign='top'><font size=2 color="000"><b>Temperament:</b></font></td>
						<td>
                           <select name="selected_temperament_min">
                              <option value=""<cfif #temperament_min# is ""> selected</cfif>>---Min---</option>
                              <cfloop query="get_temperament">
                                 <option value="#pair#"<cfif #temperament_min# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						   <font size=2 color="000">to</font>
                           <select name="selected_temperament_max">
                              <option value=""<cfif #temperament_max# is ""> selected</cfif>>---Max---</option>
                              <cfloop query="get_temperament">
                                 <option value="#pair#"<cfif #temperament_max# is #pair#> selected</cfif>>#pair#</option>
                              </cfloop>
                           </select>
						</td>
					</tr>
					<tr>
						<td><font size=2 color="000"><b>Others:</b></font></td>
						<td>
							<table border='0' cellspacing='0' cellpadding='3' width='400' style="color:white;">
							<tr>
								<td valign='top'>
									<input type='checkbox' name='chk_sold' value='#chk_sold#' <cfif #chk_sold# EQ 1>checked</cfif>><font size=2 color="000"><b>Exclude Sold Ads</b></font><br>
									<input type='checkbox' name='chk_registered' value='#chk_registered#' <cfif #chk_registered# EQ 1>checked</cfif>><font size=2 color="000"><b>Must be registered</b></font><br>
								</td>
								<td valign='top'>
									<input type='checkbox' name='chk_withphoto' value='#chk_withphoto#' <cfif #chk_withphoto# EQ 1>checked</cfif>><font size=2 color="000"><b>List ads with photos</b></font><br>
									<input type='checkbox' name='chk_withvideo' value='#chk_withvideo#' <cfif #chk_withvideo# EQ 1>checked</cfif>><font size=2 color="000"><b>List ads with videos</b></font><br>
								</td>
							</tr>
							</table>
						</td>
					</tr>
					</table>					
				 </td></tr> 	
		         </table>
			  </td></tr> 	
		      </table> 		
			  <tr><td>&nbsp;</td></tr>
		  	  <tr><td align="center">
				  <input type="submit" name="submit" value="Search">
				  <input type="submit" name="submit" value="Reset">
			  </td></tr>
			  <tr><td>&nbsp;</td></tr>
			  <tr><td>&nbsp;</td></tr>
		      </form>
		  </td></tr>
		</table>
		</div>
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
