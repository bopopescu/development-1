<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->

<html>
 <head>
  <title>Visual Auction Server Administrator [Categories Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfparam name="user_id" default="0">

 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">

 <cfparam name="submit" default="none">

 <cfparam name="lang_mode" default="0">

 <cfparam name="b2b_mode" default="0">

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">
 
 
  <!--- ********** 
<cfif #isDefined("directory")#>
  <cffile action="delete"	file="#directory##incoming#">  
</cfif>
--->
<!--- upload full size image --->
<cfif isdefined("form.cat_image") and form.cat_image is not "" >

  <cfset #curPath# = GetTemplatePath()>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","cat_images")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.cat_image"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/jpg, image/jpeg, image/png, image/gif">
  <cfelse>
    <cffile action="upload"
      filefield="form.cat_image"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept="image/*">
  </cfif>
<cfset cat_image = #File.serverFile#>
	<!--- Rename full size image with category number --->
      <cfif fileExists("#directory##cat_image#")>
        <cffile action="rename"
          SOURCE = "#directory##cat_image#"  
          DESTINATION = "#directory##newCat_category##right(cat_image,4)#">
      </cfif>

</cfif> 



<cfif #isDefined("incoming")# is 0>
  <cfset #incoming# = "">
</cfif>  
<!--- ********** --->

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
 <cfset #error_message# = "<font color='0000ff'>Operation successful</font>">


  
  
    <cfif #trim (submit)# is "Apply">
	<!--- get parent category settings --->
	<cfquery username="#db_username#" password="#db_password#" name="get_category" datasource="#DATASOURCE#">
    SELECT category, parent, name, user_id, date_created, require_login, heading_color, bg_color, cat_image, font_color, font_style
      FROM categories
     WHERE parent = #selected_category#
       
     ORDER BY name
   </cfquery>
   
   <cfif #heading_color# is "custom">
      <cfset #heading_color# = "#custom_heading_color#">
	  		<cfelse>
	  <cfset heading_color = "#form.heading_color#">
    		</cfif>
		<cfif #bg_color# is "custom">
      <cfset #bg_color# = "#custom_bg_color#">
	  	<cfelse>
	  <cfset bg_color = "#form.bg_color#">
    	</cfif>
		<cfif #font_color# is "custom">
      <cfset #font_color# = "#custom_font_color#">
	  	<cfelse>
	  <cfset font_color = "#form.font_color#">
    	</cfif>
			
   
    
     
      <cfquery username="#db_username#" password="#db_password#" name="update_category" datasource="#DATASOURCE#">
          UPDATE categories
          SET <cfif #cat_image# NEQ "">cat_image ='#newCat_category##right(cat_image,4)#'<cfelse>cat_image ='#cat_image#'</cfif>,
			  heading_color='#heading_color#',
			  bg_color='#bg_color#',
			  font_color='#font_color#',
			  font_style='#font_style#'
		  WHERE category = #newCat_category#
          
      </cfquery>
	  
	  
	 <!---Hide Refresh cashed pages slows down this page too much
<cfinclude template="../event5/count_auctions/index.cfm">
--->
	
      <cfset #error_message# = "<font color='0000ff'>Update successful.</font>">

 <!---  <font size="+1"></font> --->

  </cfif>

 <!--- Check to see if we need to edit an existing category --->
 <cfif #trim (submit)# is "Edit">
  <cfif #selected_category# is not "-1">
   <cfquery username="#db_username#" password="#db_password#" name="get_category" datasource="#DATASOURCE#">
    SELECT category, parent, name, user_id, date_created, require_login, parent_setting, heading_color, bg_color, cat_image, font_color, font_style
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
    <cfset #temp_name# = "[<a href='cat_info.cfm?selected_category=0&submit=top'>Top</a>]">
    <cfelse>
     <cfset #temp_name# = "[<a href='cat_info.cfm?selected_category=0&submit=top'>Top</a>]">
    </cfif>
   <cfelse>
    <cfset #temp_name# = #get_item_name.name#>
   </cfif>
   <cfif #idx# GT 1>
    <cfif #idx# is #lsize#>
     <cfset #tree_path_str# = "#tree_path_str# > <b>#temp_name#</b>">
    <cfelse>
     <cfset #tree_path_str# = "#tree_path_str# > <a href='cat_info.cfm?selected_category=#trim(cur_cat_id)#&submit=expand'>#temp_name#</a>">
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
  <form name="CatForm" enctype="multipart/form-data" action="./cat_info.cfm" method="post">
  
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
      <cfset #page# = "cat_info">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>

        <!--- A table encapsulating the main page content;
              with a thin black border --->
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=3 width=100%>
         <tr>
          <td>
           <font face="helvetica" size=2 color=000000>
            Use this page to set the colors, font and image used with this particular auction category.
                        <hr size=1 color=#heading_color# width=100%> 
           </font>
           <br>
 <cfoutput>
           &nbsp;<font face="Helvetica" size=2 color=000080><b>CATEGORY LAYOUT SECTION</b></font><cfif isDefined('get_category.cat_image') and get_category.cat_image is not ""> <img src="/cat_images/#get_category.cat_image#"></cfif>
           <!--- The main table with the dark blue border;
                 encapsulates the category stuff --->
           <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
            <tr>
             <td>
                <table border=1 cellspacing=0 cellpadding=2> 
                 
                 <tr>
                 
                   <input type="hidden" name="tree_path" value="#tree_path#">
                   <input type="hidden" name="main_parent" value="#main_parent#">
                  </cfoutput>
                  <cfif #trim (submit)# is "Edit" and selected_category gt 0>
				  
                   <cfoutput query="get_category">
                    <input type="hidden" name="newCat_date" value="#date_created#">
                    <input type="hidden" name="newCat_category" value="#category#">
					
					<td>
					  <table border=1>
					  <tr>
					    <td valign=top><b>Category Name:</b><br></td>
					    <td colspan=2><font size=5 color=blue><i>#name#</i></font></td>
					  </tr>
					
					  <tr>
					    <td><b>Category Image:</B><FONT SIZE=1 FACE="arial"> (Leave blank for none.)</FONT></td>
					    <td colspan=2><input name="cat_image" type="file" size=43 maxlength=250></td>
					  </tr>
					  <tr>
					  
					  <tr>
					    <td><b>Category Title Bar Color:</b></td><td><cfmodule template="../functions/cf_colorsel2.cfm" selectname="heading_color" selected="#heading_color#"></td>
					  </tr>
					  <tr>
					    <td><b>Category Background Color:</b></td><td><cfmodule template="../functions/cf_colorsel2.cfm" selectname="bg_color" selected="#bg_color#"></td>
					  </tr>
					  <tr>
					    <td><b>Title Bar Font Color:</b></td><td><cfmodule template="../functions/cf_colorsel2.cfm" selectname="font_color" selected="#font_color#"></td>
					  </tr>
					  <tr>
					    <td><b>Title Bar Font Style:</b></td>
						<td colspan=2><input name="font_style" type="text" size=25 maxlength=100 value="#font_style#"></td>
					  </tr>
					  <tr>
                        <td valign="top"><font face="helvetica"><b>Predefined color table:</b></font></td>
                        <td colspan=2>                      
                        <img border=0 src="./images/color_table.gif">&nbsp;
                        </td>
                      </tr>
					  <tr>
					    <td><input name="submit" type="submit" value="Apply"></td>
                        <td colspan=2><input type="reset" value="Undo"></td>
						
					  </tr>
					  </table>
					</td>
                 
                   
                   </cfoutput>
                  <cfelse>
				  <td>
				  <table border=1 width=100%>
				   <tr><td colspan=3 align=center><font color=blue size=2 face=arial>Select your category below then press Edit.  Use Expand & Collapse to locate your target category.<BR>You may download and select a stock category image as shown below or create your own category images.</font></td></tr>
				 
				   <tr>
                   
                    <td colspan=3 align=center>                      
                     <a href="http://www.beyondsolutions.com/stock_images/"><img border=0 src="./images/Stock_Categories.gif"></a>&nbsp;
                    </td>
                   </tr>
				 
				   </table>
				   </td>
                  </cfif>
                 </tr> 
                 <tr>
                  <cfif #b2b_mode# is 1><td colspan=15><cfelse><td colspan=13></cfif>            <hr size=1 color=#heading_color# width=100%> </td>
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

                 <cfparam name="complete" default="0">
                 <cfif complete is 'yes'>
                   <cfset error_message = "<font color='ff0000'></font>">
                 </cfif>

                 <!--- Show the current categories --->
                 <tr>
                  <cfif #b2b_mode# is 1><td colspan=15><cfelse><td colspan=13></cfif>
                    <table border=0 cellspacing=0 cellpadding=3>
                     <tr>
                      <td valign="top"><font face="helvetica" size=2><b>Status Messages: </b></font></td>
                      <td valign="top"><font face="helvetica" size=2><cfoutput>#error_message#</cfoutput></font></td>
                     </tr>
                    </table>
                    <cfif #lang_mode# is not 0>
                    <!--- get Name of Current Language --->
                    <cfquery username="#db_username#" password="#db_password#" name="lang_name" datasource="#DATASOURCE#">
                        SELECT lang_name
                          FROM languages
                         WHERE lang_id = #this_lang#
                    </cfquery></cfif>
                   <table border=0 cellspacing=0 cellpadding=2>
                    <tr>
                     <cfoutput><td><font face="helvetica" size=2><b><cfif #lang_mode# is not 0>#lang_name.lang_name#&nbsp;</cfif>Category Browser (#get_parents.recordCount# items on this level)</b></font><br><br></td></cfoutput>
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
                           <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Top" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Returns you to the top level category.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Edit" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Allows you to edit the selected category.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <!--- <tr>
                           <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Delete" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Deletes the selected category<cfif #lang_mode# is not 0>&nbsp;and all its translations&nbsp;</cfif>.</font></td>
                          </tr> --->
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Expand" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Expands the category tree 1 level.</font></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Collapse" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Collapses the category tree 1 level.</font></td>
                          </tr>
                          <cfif #lang_mode# neq 0>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Translate" width=75></td>
                           <td>&nbsp;<font face="helvetica" size=2>&nbsp;&nbsp;Translate selected category.</font></td>
                          </tr>
                          </cfif>
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
                    <li>The number next to the category indicates how many subcategories it contains.
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

