<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->

<html>
 <head>
  <title>Visual Auction Server Administrator [Categories Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfparam name="user_id" default="0">

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">

 <!--- Set a default value for "submit" if nonexistent --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "enter">
 </cfif>

 <!--- Set a default value for "tree_path" if nonexistent --->
 <cfif #isDefined ("tree_path")# is 0>
  <cfset #tree_path# = "0">
 </cfif>

 <!--- Set a default value for "main_parent" if nonexistent --->
 <cfif #isDefined ("main_parent")# is 0>
  <cfset #main_parent# = "0">
 </cfif>

 <!--- Set a default for "error_message" --->
 <cfset #error_message# = "<font color='0000ff'>Operation successful - Categories retrieved.</font>">

 <!--- Set defaults for the bit fields --->
 <cfif #isDefined ("newCat_active")# is 0>
  <cfset #newCat_active# = "0">
 <cfelse>
  <cfset #newCat_active# = "1">
 </cfif>
 <cfif #isDefined ("newCat_sales")# is 0>
  <cfset #newCat_sales# = "0">
 <cfelse>
  <cfset #newCat_sales# = "1">
 </cfif>
 <cfif #isDefined ("newCat_login")# is 0>
  <cfset #newCat_login# = "0">
 <cfelse>
  <cfset #newCat_login# = "1">
 </cfif>

 <!--- Reformat date if not in the correct format. --->
 <cfif #isDefined ("newCat_date")#>
  <cfif #left (newCat_date, 3)# is not "{ts '">
   <cfset #newCat_date# = #createODBCDateTime (newCat_date)#>
  </cfif>
 </cfif>
 
 <!--- Run queries to find fee settings --->
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_listing" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_listing'
  </cfquery>
  <!--- Run queries to find cat_fee enable --->
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_cat_fee" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_cat_fee'
  </cfquery>
  <cfset #enable_cat_fee# = #get_enable_cat_fee.pair#>

  <!--- Check to see if we need to insert a new category --->
  <CFMODULE TEMPLATE="../functions/epoch.cfm">
  
  <cfif #trim (submit)# is "Add New">
  	<cfset error_message = "">
  <CFIF #user_id# is "">
  <CFSET user_id = 0>
</CFIF>
    <cfif newCat_name eq "">
		<cfset #error_message# = "<font color='red'>Operation error - Please enter name for new category.</font>">
	</cfif>
	<cfif error_message eq "">
	<cfif isDefined('parent_settings')>
	<cfquery username="#db_username#" password="#db_password#" name="get_parent_settings" datasource="#DATASOURCE#" maxrows="1" dbtype="ODBC">
SELECT parent_setting,cat_image,heading_color,bg_color,font_color,font_style
FROM categories
WHERE category = #main_parent#
</cfquery>
	
	</cfif>
	<cfquery username="#db_username#" password="#db_password#" name="get_all_lvls" datasource="#DATASOURCE#" maxrows="1" dbtype="ODBC">
SELECT lvl_1,lvl_2,lvl_3,lvl_4,lvl_5,lvl_6,lvl_7,lvl_8,this_lvl
FROM categories
WHERE category = #main_parent#
AND category > 0
</cfquery>

<cfif get_all_lvls.recordcount>
<cfif get_all_lvls.this_lvl lt 8>
<cfset this_lvl = incrementValue(get_all_lvls.this_lvl)>
<cfelse>
<cfset error_message = "<font color=ff0000>#error_message# <li>You may not create more than 8 levels of categories.</li></font>">
<cfset this_lvl = 0>
</cfif>

<cfset lvl_1 = #get_all_lvls.lvl_1#>

<cfif this_lvl eq 2>
<cfset lvl_2 = #epoch#>
<cfelse>
<cfset lvl_2 = #get_all_lvls.lvl_2#>
</cfif>
<cfif this_lvl eq 3>
<cfset lvl_3 = #epoch#>
<cfelse>
<cfset lvl_3 = #get_all_lvls.lvl_3#>
</cfif>
<cfif this_lvl eq 4>
<cfset lvl_4 = #epoch#>
<cfelse>
<cfset lvl_4 = #get_all_lvls.lvl_4#>
</cfif>
<cfif this_lvl eq 5>
<cfset lvl_5 = #epoch#>
<cfelse>
<cfset lvl_5 = #get_all_lvls.lvl_5#>
</cfif>
<cfif this_lvl eq 6>
<cfset lvl_6 = #epoch#>
<cfelse>
<cfset lvl_6 = #get_all_lvls.lvl_6#>
</cfif>
<cfif this_lvl eq 7>
<cfset lvl_7 = #epoch#>
<cfelse>
<cfset lvl_7 = #get_all_lvls.lvl_7#>
</cfif>
<cfif this_lvl eq 8>
<cfset lvl_8 = #epoch#>
<cfelse>
<cfset lvl_8 = #get_all_lvls.lvl_8#>
</cfif>

<cfelse>
<cfset lvl_1 = #epoch#>
<cfset lvl_2 = 0>
<cfset lvl_3 = 0>
<cfset lvl_4 = 0>
<cfset lvl_5 = 0>
<cfset lvl_6 = 0>
<cfset lvl_7 = 0>
<cfset lvl_8 = 0>
<cfset this_lvl = 1>
</cfif>
	<cfif error_message eq "">
    <!--- Insert the new item into the database --->
    <cfquery username="#db_username#" password="#db_password#" name="insert_new_cat" datasource="#DATASOURCE#">
        INSERT INTO categories (category,
                                parent,
                                name,
                                date_created,
                                active,
                                allow_sales,
                                require_login,
								user_id,
								fee_listing,
                                child_count
								<cfif isDefined('parent_settings') and get_parent_settings.recordcount>, 			
								parent_setting,
								cat_image,
								heading_color,
								bg_color,
								font_color,
								font_style,</cfif>
								,lvl_1,
								lvl_2,
								lvl_3,
								lvl_4,
								lvl_5,
								lvl_6,
								lvl_7,
								lvl_8,
								this_lvl)
        VALUES (#EPOCH#,
                #main_parent#,
                '#newCat_name#',
                #newCat_date#,
                #newCat_active#,
                #newCat_sales#,
                #newCat_login#,
				#user_id#,
				<cfif isnumeric(fee_listing)>#fee_listing#<cfelse>#get_fee_listing.pair#</cfif>,
                0<cfif isDefined('parent_settings') and get_parent_settings.recordcount>, 			
				1,
								'#get_parent_settings.cat_image#',
								'#get_parent_settings.heading_color#',
								'#get_parent_settings.bg_color#',
								'#get_parent_settings.font_color#',
				'#get_parent_settings.font_style#',</cfif>
				,#lvl_1#,
				#lvl_2#,
				#lvl_3#,
				#lvl_4#,
				#lvl_5#,
				#lvl_6#,
				#lvl_7#,
				#lvl_8#,
				#this_lvl#)
    </cfquery>
    
    <!--- Update its parent's "child_count" flag --->
    <cfquery username="#db_username#" password="#db_password#" name="update_parent" datasource="#DATASOURCE#">
        UPDATE categories
           SET child_count = child_count + 1         
         WHERE category = #listLast (tree_path)#
    </cfquery>
    
	
    <!--- log new category --->
    <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Category Created"
      details="CATEGORY NAME: #newCat_name#     CATEGORY ID: #EPOCH#     PARENT: #main_parent#     ACTIVE: #newCat_active#     ALLOW PUBLIC SALES: #newCat_sales#">
	  
	<!--- generate category tree 
	<cfinclude template="gen_all_cats.cfm">
--->
<!--- Hide Refresh cashed pages slows down this page too much
<cfinclude template="../event5/count_auctions/index.cfm">
   --->    
    <cfset #error_message# = "<font color='0000ff'>Operation successful - 1 category added.</font>">
</cfif>
	</cfif>
  </cfif>
  
  <!--- Check if we're updating an existing category --->
  <cfif #trim (submit)# is "Update">
    
    <cfif #isDefined ("newCat_category")#>
      
      <!--- Check to see if they tried to turn active flag off --->
      <cfquery username="#db_username#" password="#db_password#" name="check_active" datasource="#DATASOURCE#">
          SELECT active
            FROM categories
           WHERE category=#selected_category#
      </cfquery>
      
      <!--- If they are turning activity off, check for pending auctions --->
      <cfset #ok_active# = "1">
      
      <cfif (#check_active.active# is "1") and (#newCat_active# is "0")>
        
        <!--- Check for activity in this category --->
        <cfquery username="#db_username#" password="#db_password#" name="check_auctions" datasource="#DATASOURCE#">
            SELECT status
              FROM items
             WHERE (category1 = #newCat_category#
                OR category2 = #newCat_category#)
               AND status = 1
        </cfquery>
        
        <cfif #check_auctions.recordCount# GT 0>
          <cfset #ok_active# = "0">
        </cfif>
      </cfif>
	  <cfif isDefined('parent_settings')>
	  <cfquery username="#db_username#" password="#db_password#" name="get_parent" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT parent 
FROM categories
WHERE category = #newCat_category#
</cfquery>
	  
	<cfquery username="#db_username#" password="#db_password#" name="get_parent_settings" datasource="#DATASOURCE#" maxrows="1" dbtype="ODBC">
SELECT parent_setting,cat_image,heading_color,bg_color,font_color,font_style
FROM categories
WHERE category = #get_parent.parent#
</cfquery>
	
	</cfif>
      
      <cfquery username="#db_username#" password="#db_password#" name="update_category" datasource="#DATASOURCE#">
          UPDATE categories
             SET name = '#newCat_name#',
          <cfif #ok_active# is "1">
                 active = #newCat_active#,     
                 allow_sales = #newCat_sales#,
          <cfelse>
                 allow_sales = 0,
          </cfif>
		<cfif isDefined('parent_settings') and get_parent_settings.recordcount eq 1> 	
parent_setting = 1,								cat_image = '#get_parent_settings.cat_image#',
								heading_color = '#get_parent_settings.heading_color#',
								bg_color = '#get_parent_settings.bg_color#',
								font_color = '#get_parent_settings.font_color#',
								font_style = '#get_parent_settings.font_style#',
		 </cfif> 
		<cfif #user_id# is not "">  		user_id = #user_id#,<cfelse> user_id=0,</cfif>
				require_login = #newCat_login#,
				<cfif isnumeric(fee_listing)>fee_listing = #fee_listing#<cfelse>fee_listing = #get_fee_listing.pair#</cfif>
           WHERE category = #newCat_category#
      </cfquery>
      
      <!--- log update of category --->
      <cfset bLogAllowSales = IIf(ok_active, "newCat_sales", DE("0"))>

      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Category Information Updated"
        details="CATEGORY NAME: #newCat_name#     CATEGORY ID: #newCat_category#     ACTIVE: #newCat_active#     ALLOW PUBLIC SALES: #Variables.bLogAllowSales#    FEE LISTING: #fee_listing#">
      
      <cfif #ok_active# is "1">
	  	<!--- generate category tree --->
	  	<cfinclude template="gen_all_cats.cfm">
        <cfset #error_message# = "<font color='0000ff'>Operation successful - 1 category updated.</font>">

<!---Hide Refresh cashed pages 
<cfinclude template="../event5/count_auctions/index.cfm">
--->
      <cfelse>
        <cfset #error_message# = "<font color='ff0000'>Unable to inactivate '#newCat_name#' because there are auctions active within it.<br>Further sales have been disabled in this category instead.<br>You may inactivate it when the pending auctions close.</font>">
      </cfif>
      
    <cfelse>
      <cfset #error_message# = "<font color='ff0000'>You must specify a category to edit in order to update.</font>">
    </cfif>
  </cfif>

  <!--- Check if we're deleting an existing category --->
  <cfif #trim (submit)# is "Delete">
    
    <cfif #selected_category# is not "-1">
      
      <!--- Check to see if there are any subcategories --->   
      <cfquery username="#db_username#" password="#db_password#" name="check_subs" datasource="#DATASOURCE#">
          SELECT name, child_count
            FROM categories
           WHERE category = #selected_category#
      </cfquery>
      
      <!--- If there are no subs, delete the item --->
      <cfif #check_subs.child_count# is 0> 
        
        <!--- Check for activity in this category first --->
        <cfquery username="#db_username#" password="#db_password#" name="check_auctions" datasource="#DATASOURCE#">
            SELECT status
              FROM items
             WHERE (category1 = #selected_category#
                OR category2 = #selected_category#)
               AND status = 1
        </cfquery>
        
        <!--- Proceed with delete if no activity in this category --->
        <cfif #check_auctions.recordCount# is 0>
          
          <cfquery username="#db_username#" password="#db_password#" name="delete_category" datasource="#DATASOURCE#">
              DELETE
                FROM categories
               WHERE category = #selected_category#
          </cfquery>
          
          <cfquery username="#db_username#" password="#db_password#" name="delete_cat_update_parent" datasource="#DATASOURCE#">
              UPDATE categories      
                 SET child_count = child_count - 1
               WHERE category = #main_parent#
                 AND child_count >= 1
          </cfquery>
          
          <!--- log deletion of category --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Category Deleted"
            details="CATEGORY ID: #selected_category#     PARENT: #main_parent#">
			
			<!--- generate category tree --->
			<cfinclude template="gen_all_cats.cfm">
          
          <cfset #error_message# = "<font color='0000ff'>Operation successful - 1 category deleted.</font>">

<!---Hide Refresh cashed pages 
<cfinclude template="../event5/count_auctions/index.cfm">
    --->      
        <cfelse>
          <cfquery username="#db_username#" password="#db_password#" name="disable_sales_in_category" datasource="#DATASOURCE#">
              UPDATE categories
                 SET allow_sales = 0
               WHERE category = #selected_category#
          </cfquery>
          
          <!--- log public sales disabled --->
          <cfmodule template="../functions/addTransaction.cfm"
            datasource="#DATASOURCE#"
            description="Category Public Sales Disabled"
            details="CATEGORY ID: #selected_category#     CATEGORY CONTAINS ACTIVE AUCTIONS;  UNABLE TO DELETE">
          
          <cfset #error_message# = "<font color='ff0000'>Unable to delete '#check_subs.name#' because there are auctions active within it.<br>Further sales have been disabled in this category.<br>You may delete it when the pending auctions close.</font>">
        </cfif>
        
      <!--- Else there were subs; set the error message --->
      <cfelse>
        <cfset #error_message# = "<font color='ff0000'>Unable to delete '#check_subs.name#' because it contains subcategories.</font>">
      </cfif>
    
    <!--- Catch delete of nonexistent item --->
    <cfelse>
      <cfset #submit# = "nop">
      <cfset #error_message# = "<font color='ff0000'>Please select an existing category to delete.</font>">
    </cfif>
  </cfif>

 <!--- Check to see if we need to edit an existing category --->
 <cfif #trim (submit)# is "Edit">
  <cfif #selected_category# is not "-1">
   <cfquery username="#db_username#" password="#db_password#" name="get_category" datasource="#DATASOURCE#">
    SELECT category, parent, name, date_created, active, allow_sales, user_id, require_login,parent_setting,cat_image,heading_color,bg_color,font_color,font_style,fee_listing
      FROM categories
     WHERE category = #selected_category#
     ORDER BY name
   </cfquery>
   <cfset #error_message# = "<font color='0000ff'>Operation successful - 1 category retrieved.</font>">
  <cfelse>
   <cfset #submit# = "nop">
   <cfset #error_message# = "<font color='ff0000'>Please select an existing category to edit.</font>">
  </cfif>
 </cfif>

 <!--- Check to see if we need to expand a subtree --->
 <cfif #trim (submit)# is "Expand">
  <cfset #main_parent# = #selected_category#>
  <cfset #tree_path# = "#tree_path#, #main_parent#">
  <cfset #error_message# = "<font color='0000ff'>Operation successful - Category tree expanded 1 level.</font>">
 </cfif>

 <!--- Check to see if we need to collapse a subtree --->
 <cfset #lsize# = #listLen (#tree_path#)#>
 <cfif #trim (submit)# is "Collapse">
  <cfif #lsize# GT 1>
   <cfset #tree_path# = #listDeleteAt (tree_path, lsize)#>
   <cfset #main_parent# = #listLast (tree_path)#>
   <cfset #lsize# = #lsize# - 1>
  </cfif>
  <cfset #error_message# = "<font color='0000ff'>Operation successful - Category tree collapsed 1 level.</font>">
 </cfif>

 <!--- Check to see if we need to jump to the top level --->
 <cfif #trim (submit)# is "Top">
  <cfset #main_parent# = "0">
  <cfset #tree_path# = "0">
  <cfset #lsize# = "1">
  <cfset #error_message# = "<font color='0000ff'>Operation successful - Category tree collapsed to top level.</font>">
 </cfif>

 <!--- Build a text representation of the current tree --->
 <cfset #tree_path_str# = "">
 <cfif #lsize# GT 0>
  <cfloop from="1" to="#lsize#" index="idx">
   <cfset #cur_cat_id# = #listGetAt (tree_path, idx)#>
   <cfquery username="#db_username#" password="#db_password#" name="get_item_name" datasource="#DATASOURCE#">
    SELECT name, category
      FROM categories
     WHERE category = #cur_cat_id#
   </cfquery>
   <cfif #get_item_name.category# is "0">
    <cfif #lsize# is "1">
     <cfset #temp_name# = "[Top]">
    <cfelse>
     <cfset #temp_name# = "[<a href='categories.cfm?selected_category=0&submit=top'>Top</a>]">
    </cfif>
   <cfelse>
    <cfset #temp_name# = #get_item_name.name#>
   </cfif>
   <cfif #idx# GT 1>
    <cfif #idx# is #lsize#>
     <cfset #tree_path_str# = "#tree_path_str# > <b>#temp_name#</b>">
    <cfelse>
     <cfset #tree_path_str# = "#tree_path_str# > <a href='categories.cfm?selected_category=#trim(cur_cat_id)#&submit=expand'>#temp_name#</a>">
    </cfif>
   <cfelse>
    <cfif #idx# is #lsize#>
     <cfset #tree_path_str# = "<b>#temp_name#</b>">
    <cfelse>
     <cfset #tree_path_str# = "#temp_name#">
    </cfif>
   </cfif>
  </cfloop>
 </cfif>

 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 <body bgcolor=465775>
  <form name="CatForm" action="./categories.cfm" method="post">
   <font face="helvetica" size=2>
    <center>

     <!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900>
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>
<!---
<td></td>
<td></td>
--->
<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->

      <!--- Include the menubar --->
      <cfset #page# = "categories">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>

        <!--- A table encapsulating the main page content;
              with a thin black border --->
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=3 width=100%>
         <tr>
          <td>
           <font face="helvetica" size=2 color=000000>
            Use this page to administer the auction categories in your
            <i>Auction Server</i> software.<br>If you do not know how to use
            this administration tool, please <!---consult your user manual or<br>--->
			click the help button<br>in the upper right corner of this window.
                        
				<table border=0 cellspacing=0 cellpadding=3>
                     <tr>
                      <td valign="top"><font face="helvetica" size=2><b>Status Messages: </b></font></td>
                      <td valign="top"><font face="helvetica" size=2><cfoutput>#error_message#</cfoutput></font></td>
                     </tr>
               	</table>
           </font>
           <br>

           &nbsp;<font face="Helvetica" size=2 color=000080><b>AUCTION CATEGORY FUNCTIONS:</b></font>
           <!--- The main table with the dark blue border;
                 encapsulates the category stuff --->
           <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
            <tr>
             <td>
                <table border=0 cellspacing=0 cellpadding=2> 
                 <tr bgcolor=bac1cf>
                  <td><font face="helvetica" size=2><b>Category Name </b></font></td>
                  <td width=5>&nbsp;</td>
                  <td><font face="helvetica" size=2><b>Created On </b></font></td>
                  <td width=5>&nbsp;</td>
                  <td><font face="helvetica" size=2><b>Active </b></font></td>
                  <td width=5>&nbsp;</td>
                  <td><font face="helvetica" size=2><b>Sales </b></font></td>
                  <td width=5>&nbsp;</td>
                 <!--- <td><font face="helvetica" size=2><b>Login </b></font></td>  --->
                 
				  <td><font face="helvetica" size=2><B>Exclusive Listing User&nbsp;ID&nbsp;#</B></font></td>
                  <td width=5>&nbsp;</td>
				  <cfif enable_cat_fee eq 1>
				  <td><font face="helvetica" size=2><B>Listing Fee</B></font></td>
                  <td width=5>&nbsp;</td>
				  </cfif>
                  <td colspan=2><font face="helvetica" size=2><b>Actions ---------</b></font></td>
                 </tr>
                 <tr>
                  <cfoutput>
                   <input type="hidden" name="tree_path" value="#tree_path#">
                   <input type="hidden" name="main_parent" value="#main_parent#">
                  </cfoutput>
                  <cfif #trim (submit)# is "Edit">
                   <cfoutput query="get_category">
                    <input type="hidden" name="newCat_date" value="#date_created#">
                    <input type="hidden" name="newCat_category" value="#category#">
					
					<a href="cat_info.cfm?selected_category=#trim(category)#&submit=edit"><font size=-1 color=blue><b>Click Here to update the category layout</b></font></a>&nbsp;&nbsp;&nbsp;<cfif isDefined('get_category.parent_setting') and get_category.parent gt 0>
<input type="checkbox" name="parent_settings" value="1"<cfif get_category.parent_setting eq 1> checked<cfelse> </cfif>> Use parent category settings<br></cfif>
<cfif isDefined('category')>
<cfset category = "category">
<cfelse></cfif>
<a href="cat_info.cfm?selected_category=-5&submit=edit"><font size=-1 color=blue><b>Click Here to create a new category layout</b></font></a>
                    <td><input name="newCat_name" size=25 maxlength=40 value="#name#"></td>
                    <td>&nbsp;</td>
                    <td><font face="helvetica" size=2>#dateFormat (date_created, 'dd-mmm-yyyy')#</font></td>
                    <td>&nbsp;</td>
                    <td><input name="newCat_active" type="checkbox" <cfif #active# gt 0 >checked</cfif>></td>
                    <td>&nbsp;</td>
                    <td><input name="newCat_sales" type="checkbox" <cfif #allow_sales# gt 0>checked</cfif>></td>
                    <td>&nbsp;</td>
                    
					<td><INPUT TYPE="Text" NAME="user_id" VALUE="#user_id#" SIZE=15>&nbsp;</td>
                    <td>&nbsp;</td>
					<cfif enable_cat_fee eq 1>
					<td><input name="fee_listing" type="text" value="#fee_listing#" size="5"></td>
                    <td>&nbsp;</td>
					<cfelse>
					<input name="fee_listing" type="hidden" value="#fee_listing#" size="5">
				    </cfif>
                    <td><input name="submit" type="submit" value="Update"></td>
                    <td><input name="submit" type="submit" value="Add New"></td>
                    <td><input type="reset" value="Undo"></td>
                   </cfoutput>
                  <cfelse>
                   <cfoutput><input type="hidden" name="newCat_date" value="#now ()#"></cfoutput>
		<cfif isDefined('get_category.parent') and get_category.parent gt 0>		   <a href="cat_info.cfm?selected_category=#trim(category)#&submit=edit"><font size=-1 color=blue><b>Click Here to update the category layout</b></font></a>&nbsp;&nbsp;&nbsp;
<input type="checkbox" name="parent_settings" value="1"<cfif isDefined('get_parent_settings.parent_setting') and get_parent_settings.parent_setting eq 1> checked<cfelse> </cfif>> Use parent category settings<br></cfif>

<a href="cat_info.cfm?selected_category=-5&submit=edit"><font size=-1 color=blue><b>Click Here to create a new category layout</b></font></a>
                   <td><input name="newCat_name" size=25 maxlength=40></td>
                   <td>&nbsp;</td>
                   <td><font face="helvetica" size=2><cfoutput>#dateFormat (now(), 'dd-mmm-yyyy')#</cfoutput></font></td>
                   <td>&nbsp;</td>
                   <td><input name="newCat_active" type="checkbox" checked></td>
                   <td>&nbsp;</td>
                   <td><input name="newCat_sales" type="checkbox" checked></td>
                   <td>&nbsp;</td>
                  <!--- <td> <input name="newCat_login" type="checkbox"> </td>  --->
                   <td><INPUT TYPE="Text" NAME="user_id" VALUE="<cfoutput>#user_id#</cfoutput>" SIZE=15></td>
                   <td>&nbsp;</td>
				   <cfoutput>
				   <cfif enable_cat_fee eq 1>
				   <td><input name="fee_listing" type="text" value="#get_fee_listing.pair#" size="5"></td>
                   <td>&nbsp;</td>
				   <cfelse>
					<input name="fee_listing" type="hidden" value="#get_fee_listing.pair#" size="5">
				    </cfif>
					</cfoutput>
                   <td><input name="submit" type="submit" value="Add New"></td>
                   <td><input type="reset" value="Clear"></td>
                   <!--- <td width=60>&nbsp;</td> --->
                  </cfif>
                 </tr> 
                 <tr>
                  <td colspan=13>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                 </tr>

                 <!--- Run a query to find all the base categories in the database --->
                 <cfquery username="#db_username#" password="#db_password#" name="get_parents" datasource="#DATASOURCE#">
                  SELECT category,                                  
                         name,
                         child_count                       
                    FROM categories
                   WHERE parent = #main_parent#
                   ORDER BY name
                 </cfquery> 

                 <!--- Show the current categories --->
                 <tr>
                  <td colspan=13>
                   <table border=0 cellspacing=0 cellpadding=2>
                    <tr>
                     <cfoutput><td><font face="helvetica" size=2><b>Category Browser (#get_parents.recordCount# items on this level)</b></font></td></cfoutput>
                    </tr>
                    <tr>                       
                     <cfoutput>      
                      <td><table border=1 cellspacing=0 cellpadding=3><tr bgcolor="eeeeeef"><td><font face="helvetica" size=2 color=000080>#tree_path_str#</font></td></tr></table></td>
                     </cfoutput>
                    </tr>
                    <tr>
                     <td>
                      <table border=0 cellspacing=0 cellpadding=0>
                       <tr>
                        <td align="left">
                         <select name="selected_category" size=10 width=250>
                          <!--- Show all current categories --->
                          <cfif #get_parents.recordcount# gt 0>
                           <cfloop query="get_parents">
                            <cfoutput><option value="#category#"<cfif #currentRow# is 1> selected</cfif>>&nbsp;#name#<cfif #child_count# GT "0"> (#child_count#)+</cfif></option></cfoutput>
                           </cfloop>
                          <cfelse>
                           <cfoutput><option value="-1" selected>< empty ></option></cfoutput>
                          </cfif>
                         </select>
                        </td>
                        <td valign="top">
                         <table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                           <td><input type="submit" name="submit" value="Top" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Returns to the top level category list.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td><input type="submit" name="submit" value="Edit" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Allows you to edit the selected category.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td><input type="submit" name="submit" value="Delete" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Deletes the selected category.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td><input type="submit" name="submit" value="Expand" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Expands the tree 1 level.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td><input type="submit" name="submit" value="Collapse" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Collapses the tree 1 level.</font></td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table> 
                     </td>
                    </tr>
                   </table>
                   <br>
                   <font face="helvetica" size=2><b>Notes: </b><br>
                    <li>Categories with a plus (+) sign contain subcategories.  Select the category and click "expand" to see them.<br>
                    <li>A number next to the category is how many subcategories it contains.
                    <br><br>
                   </font>
                  </td>
                 </tr>
                </table>
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
       </td>
      </tr>
     </table>
    </center>
   </font>
  </form>
 </body>
</html>
