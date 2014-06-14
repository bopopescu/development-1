<!--- classifieds/admin/ad_mngr.cfm
      Visual Auction 4 Administrator [Classifieds Module]
--->
<cfinclude template = "../../includes/app_globals.cfm">

<!--- Always check for valid username/password --->
 <cfinclude template="../../admin/validate_include.cfm">

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

 <!--- Set a default value for "cur_category" if nonexistent --->
 <cfif #isDefined ("cur_category")# is 0>
  <cfset #cur_category# = "">
 </cfif>

 <!--- Set a default value for "selected_category" if nonexistent --->
 <cfif #isDefined ("selected_category")# is 0>
  <cfset #selected_category# = "0">
 </cfif>

 <!--- Set a default for "error_message" --->
 <cfset #error_message# = "<font color='0000ff'>Operation successful - Categories retrieved.</font>">

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
   <cfquery name="get_item_name" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
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

 <!--- Check to see if they selected an item --->
 <cfif (#submit# is "Expand") or (#submit# is "Collapse")>
  <cfquery name="get_ad_items" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
   SELECT adnum,
          title
     FROM ad_info
    WHERE category1=#selected_category#
       OR category2=#selected_category#
    ORDER BY title, adnum
  </cfquery>
  <cfset #cur_category# = #get_item_name.name#>
  </cfif>

 <cfsetting EnableCFOutputOnly="NO">
 
<!--- Main page --->
<html>
 <head>
  <title>Visual Auction 4 Administrator [Classifieds Module]</title>
  <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <body bgcolor=ffffff>
  <font face="helvetica" size=2>
   <center>

     <!--- The main table encapsulating everything on the page --->
     <table width=700 border=0 cellspacing=0 cellpadding=0>
      <tr>
       <td><img border=0 src="../../Admin/images/left.gif"></td>
       <td bgcolor=0c546c><img border=0 src="../../Admin/images/top_banner.gif"></td>
       <td><img border=0 src="../../Admin/images/header_fill.gif" width=124 height=25></td>
       <td><a href="../../Admin/help.cfm"><img border=0 src="../../Admin/images/help.gif" alt="View Help"></a><a href="../../Admin/login.cfm"><img border=0 src="../../Admin/images/logout.gif" alt="Logout"></a></font></td>
       <td><img border=0 src="../../Admin/images/right.gif"></td>
      </tr>

      <!--- Include the menubar --->
      <cfset #page# = "ad_mngr">
      <cfinclude template="../../admin/menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=a9ccd7>
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
         <tr>
          <td>
           <table border=0 cellspacing=0 cellpadding=5 width=100%>
            <tr>
             <td colspan=2>
              <font face="helvetica" size=2 color=000000>
               Use this page to administer the Classified Ads in your <i>Auction Server</i> software.  If you do not
               know<br> how to use this administration tool, please click the
               help button in the <br>upper right corner of this window.
   <hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade>
              </font>
             </td>
            </tr>
            <tr>
             <td valign="top">
               &nbsp;<font face="Helvetica" size=2 color=000080><b>CLASSIFIEDS INFORMATION:</b><br></font>
               <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                <tr>               
                 <td colspan=2>
                  <!--- <table border=0 cellspacing=0 cellpadding=2>
                   <tr>
                    <form name="itemsearch" action="item_search_results.cfm" method="post">                    
                     <td><font face="helvetica" size=2><b>Item Search</b></font></td>
                     <td><input type="text" name="search" size=20 maxlength=255></td>
                     <td><input type="submit" name="submit" value="Search"></td>
                     <td><font face="helvetica" size=2>&nbsp;&nbsp;&nbsp;Enter a word, phrase, or Ad ID code to search for.</font></td>
                    </form>
                   </tr>
                  </table> --->
                 &nbsp;</td>
                </tr>
                <tr>
                 <td>
                  <table border=0 cellspacing=0 cellpadding=2>
              <form name="admanform" action="ad_mngr.cfm" method="post">
               <cfoutput>
                <input type="hidden" name="tree_path" value="#tree_path#">
                <input type="hidden" name="main_parent" value="#main_parent#">
               </cfoutput>

                 <!--- Run a query to find all the base categories in the database --->
                 <cfquery name="get_parents" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
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
                      <td><table border=1 cellspacing=0 cellpadding=3 width=250><tr bgcolor="eeeeeef"><td><font face="helvetica" size=2 color=000080>#tree_path_str#</font></td></tr></table></td>
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
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td><input type="submit" name="submit" value="Expand" width=75></td>
                          </tr>
                          <tr><td><img src="./images/btn_spacer.gif" width=1 height=6></td></tr>
                          <tr>
                           <td><input type="submit" name="submit" value="Collapse" width=75></td>
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
                    <li>Categories with a plus (+) sign contain subcategories.<br>
                    <li>A number next to the category is how many<br>&nbsp;&nbsp;subcategories it contains.
                    <br><br>
                    <table border=0 cellspacing=0 cellpadding=3>
                     <tr>
                      <td valign="top"><font face="helvetica" size=2><b>Status Messages: </b><br><cfoutput>#error_message#</cfoutput></font></td>
                     </tr>
                    </table>
                   </font>
                  </td>
                 </tr>
                </table>
               </form>
               </td>
               <td valign="top">
                <form name="itemsform" action="classified_item.cfm" method="post">
                 <cfoutput><input type="hidden" name="selected_category" value="#selected_category#"></cfoutput>
                <table border=0 cellspacing=0 cellpadding=2>
                 <tr>
                  <td>
                   <font face="helvetica" size=2>&nbsp;<b>Items in the selected category:</b></font>
                   <br>
                  </td>
                 </tr>
                 <tr>
                  <cfoutput>
                   <cfif #cur_category# is "">
                    <td><table border=1 cellspacing=0 cellpadding=3 width=250><tr bgcolor="eeeeeef"><td><font face="helvetica" size=2 color=000080><b>Top</b></font></td></tr></table></td>
                   <cfelse>
                    <td><table border=1 cellspacing=0 cellpadding=3 width=250><tr bgcolor="eeeeeef"><td><font face="helvetica" size=2 color=000080><b>#cur_category#</b> (#get_ad_items.recordCount# items)</font></td></tr></table></td>
                   </cfif>
                  </cfoutput>
                 </tr>
                 <tr>
                  <td>
                   <select name="selected_item" size=10 width=250>
                    <cfif (#submit# is "Expand") or (#submit# is "Collapse")>
                     <cfif #get_ad_items.recordCount# GT 0>
                      <cfif #isDefined ("selected_item")#>
                       <cfloop query="get_ad_items">
                        <cfoutput><option value="#adnum#"<cfif (#adnum# is #selected_item#)> selected</cfif>>  #title#</option></cfoutput>
                       </cfloop>
                      <cfelse>
                       <cfloop query="get_ad_items">
                        <cfoutput><option value="#adnum#"<cfif #currentRow# is 1> selected</cfif>>(#adnum#) #title#</option></cfoutput>
                       </cfloop>
                      </cfif>
                     </cfif>
                    </cfif>
                   </select>
                  </td>
                 </tr>
                 <tr>
                  <td>
                   <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                     <td><cfif #main_parent# GT 0><input type="submit" name="submit" value="Add" width=70><cfelse>&nbsp;</cfif></td>
                     <cfif (#submit# is "Expand") or (#submit# is "Collapse")>
                      <cfif #get_ad_items.recordCount# GT 0>
                       <td>&nbsp;<input type="submit" name="submit" value="Edit" width=70></td>
                       <td width=32>&nbsp;</td>
                       <td>&nbsp;<input type="submit" name="submit2" value="Delete" width=70></td>
                      </cfif>
                     </cfif>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
               </td>
              </tr>
             </table>
             </form>
            </td>
           </tr>
          </table>
		  
		  <TABLE><TR><TD>

<!--- Begin old defaults page --->

<cfquery name="get_ad_defaults" datasource="#DATASOURCE#" username="#db_username#" password="#db_password#">
	SELECT ad_dur, ad_fee
	FROM ad_defaults
	ORDER BY ad_dur ASC
</cfquery>


<cfparam name="mode" default="defaults">

<cfif mode IS "edit">
<TABLE width=100% Border=0>
    <TR>
        <TD><font face="arial black" size="4">Classified Ad Editing</font></TD>
	</TR>
    
</TABLE>

<cfelseif mode IS "defaults">
<TABLE width=100% Border=0>
    <TR>
        <TD><font face="arial black" size="4" color="000080">Classified Ad Controls</font><br></TD>
	</TR>
    <TR>
        <TD>
			<TABLE width=100% Border=0>
		    <TR>
        		<TD><font face="arial">Use these settings to set the defaults for the Classified Ads Section:</font></TD>
			</TR>
			<tr>
				<td  VALIGN=TOP align=center><table width="50%" border="1" cellspacing=0>
					<tr><td colspan="2" align="center"><font face="Arial" size="+1" color="000080"><b>Classified Ad Durations and Fees</b></font></td></tr>
					<tr><td align="center" width="50%"><font face="Arial" color="000080"><b>Duration</b></font></td><td align="center" width="50%"><font face="Arial" color="000080"><b>Fee</b></font></td></tr>
						<cfloop query="get_ad_defaults">
							<cfoutput><tr><td align="center">#ad_dur# days</td><td align="center">#numberFormat(ad_fee,numbermask)#</td></tr></cfoutput>
						</cfloop>
					</table>
					<br>
					
				</td><TD VALIGN=TOP align=left>
				<cfif IsDefined("ad_dur") IS 0>
					<cfset ad_dur="">
					<cfelse>
					<cfset ad_dur=#ad_dur#>
					</cfif>
					<cfif IsDefined("ad_fee") IS 0>
					<cfset ad_fee="">
					<cfelse>
					<cfset ad_fee=#ad_fee#>
					</cfif>					
					<cfoutput>
						<FORM ACTION="admin_up.cfm" METHOD="POST" ENCTYPE="multipart/form-data">
<INPUT TYPE="Hidden" NAME="required_duration" VALUE="You must enter a valid numeric value for the ad duration">
	<TABLE>
	<TR><TD COLSPAN=2><CFIF isDefined('url.refuse')>
	
<FONT FACE="Arial" COLOR="Red"><B><CFIF url.refuse IS 1>
You can not have multiple durations of the same value.
<CFELSE>
Please make entries according to the example above.
</CFIF></B></FONT></CFIF></TD></TR>
<TR><TD>Duration:</TD><TD>Fee:</TD></TR>
<TR><TD><input type="text" name="duration" value="#ad_dur#"></TD><TD><input type="text" name="fee" value="#ad_fee#"></TD></TR>
<TR><TD><input type="submit" name="add" value="Add New Pair"></TD><TD><input type="submit" name="delete" value="Delete Old Pair"></TD></TR>
</TABLE>			
			
						</form>
					</cfoutput>
				<br><br>
				<FONT FACE="Arial" COLOR="000080">
				Example: 
				</FONT>
				<FORM ACTION="" METHOD="POST">
				<TABLE>
				<TR><TD>Duration:</TD><TD>Fee:</TD></TR>
				<TR><TD><INPUT TYPE="Text" NAME="" VALUE="30"></TD><TD><INPUT TYPE="Text" NAME="" VALUE="15.00"></TD></TR>
				</TABLE>
				
				
				</FORM>
				
				</TD>
			</tr>
			</table>		
		</TD>
	</TR>
</TABLE>
</cfif>

<!--- End old defaults page --->

		  </TD></TR></TABLE>
		  
		  
		  
        </td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>