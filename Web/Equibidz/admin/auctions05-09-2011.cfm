<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/auctions.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->

<html>
 <head>
  <title>Visual Auction Server Administrator [Auctions Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<cfmodule template="../functions/timenow.cfm">
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

 <!--- Check to see if they selected an item --->
 <cfif (#submit# is "Expand") or (#submit# is "Collapse")>
  <cfquery username="#db_username#" password="#db_password#" name="get_auction_items" dataSource="#DATASOURCE#">
   SELECT itemnum,
          title, status
     FROM items
    WHERE category1=#selected_category#
       OR category2=#selected_category#
    ORDER BY title
  </cfquery>
  <cfset #cur_category# = #get_item_name.name#>
  </cfif>




<cfif isdefined("duh")>

<cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","dbase\ms_access97")>

    <cffile action="copy"
source="#directory#\auctionserver.mdb"
      DESTINATION="#directory#\auctionserver.mdb.bak"
      >
<cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="backup database"
      details="Backup database on #timenow#">


</cfif>




<cfif isdefined("duh1")>

<cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory1# = Replace(GetDirectoryFromPath("#curPath#"),"admin","dbase\ms_access97")>

  <cfif fileexists("#directory1#auctionserver.mdb.bak")>
    <cffile action="copy"
source="#directory1#\auctionserver.mdb.bak"
      DESTINATION="#directory1#\auctionserver.mdb"
      >


</cfif>



<cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="restore database"
      details="restore database on #timenow#">


</cfif>



 <cfsetting EnableCFOutputOnly="NO">
 
 <!--- Main page body --->
 <body bgcolor=465775>
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
      <cfset #page# = "auctions">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>
        <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
         <tr>
          <td>
           <table border=0 cellspacing=0 cellpadding=5 width=100%>
            <tr>
             <td colspan=2>
              <font face="helvetica" size=2 color=000000>
               Use this page to administer the auctions in your <i>Auction Server</i> software.  If you do not
               know<br> how to use this administration tool, please
			   <!---consult your user manual or --->click the
               help button in the upper right corner of this window.
            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
              </font>
             </td>
            </tr>
            <tr>
             <td valign="top">
               &nbsp;<font face="Helvetica" size=2 color=000080><b>AUCTION INFORMATION:</b><br></font>
               <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                <tr>               
                 <td colspan=2>
                  <table border=0 cellspacing=0 cellpadding=2>
                   <tr>
                    <form name="itemsearch" action="item_search_results.cfm" method="post">                    
                     <td><font face="helvetica" size=2><b>Item Search</b></font></td>
                     <td><input type="text" name="search" size=20 maxlength=255></td>
                     <td><input type="submit" name="submit" value="Search"></td>
                     <td><font face="helvetica" size=2>&nbsp;&nbsp;&nbsp;Enter a word, phrase, or item ID code to search for.</font></td>
                    </form>
                   </tr>
                  </table>
                 </td>
                </tr>
                <tr>
                 <td>
                  <table border=0 cellspacing=0 cellpadding=2>
              <form name="auctionform" action="auctions.cfm" method="post">
               <cfoutput>
                <input type="hidden" name="tree_path" value="#tree_path#">
                <input type="hidden" name="main_parent" value="#main_parent#">
               </cfoutput>

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
                <form name="itemsform" action="auction_item.cfm" method="post">
                 <cfoutput><input type="hidden" name="selected_category" value="#selected_category#"></cfoutput>
                <table border=0 cellspacing=0 cellpadding=2>
                 <tr>
                  <td>
                   <font face="helvetica" size=2>&nbsp;<b>Items auctioned in the selected category:</b></font>
                   <br>
                  </td>
                 </tr>
                 <tr>
                  <cfoutput>
                   <cfif #cur_category# is "">
                    <td><table border=1 cellspacing=0 cellpadding=3 width=250><tr bgcolor="eeeeeef"><td><font face="helvetica" size=2 color=000080><b>Top</b></font></td></tr></table></td>
                   <cfelse>
                    <td><table border=1 cellspacing=0 cellpadding=3 width=250><tr bgcolor="eeeeeef"><td><font face="helvetica" size=2 color=000080><b>#cur_category#</b> (#get_auction_items.recordCount# items)</font></td></tr></table></td>
                   </cfif>
                  </cfoutput>
                 </tr>
                 <tr>
                  <td>
                   <select name="selected_item" size=10 width=250>
                    <cfif (#submit# is "Expand") or (#submit# is "Collapse")>
                     <cfif #get_auction_items.recordCount# GT 0>
                      <cfif #isDefined ("selected_item")#>
                       <cfloop query="get_auction_items">
                        <cfoutput><option value="#itemnum#"<cfif (#itemnum# is #selected_item#)> selected</cfif>>  #title#<cfif status eq 1> [Active]</cfif></option></cfoutput>
                       </cfloop>
                      <cfelse>
                       <cfloop query="get_auction_items">
                        <cfoutput><option value="#itemnum#"<cfif #currentRow# is 1> selected</cfif>>(#itemnum#) #title#<cfif status eq 1> [Active]</cfif></option></cfoutput>
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
                     <td><cfif #main_parent# GT 0> <input type="submit" name="submit" value="Add" width=70> <cfelse>&nbsp;</cfif></td>
                     <cfif (#submit# is "Expand") or (#submit# is "Collapse")>
                      <cfif #get_auction_items.recordCount# GT 0>
                       <td>&nbsp;<input type="submit" name="submit" value="Edit" width=70></td>

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


<cfif ParameterExists(URL.action) AND URL.action is "delete">
	  <cfif ParameterExists(Form.itemnum)>
		  <cfloop index="item" list="#Form.itemnum#">
			<cfquery name="DeleteItem" datasource="#datasource#" dbtype="ODBC">
				Delete 
				From items
				where itemnum = #item#	
			</cfquery>
		  </cfloop>
	   </cfif>
	</cfif>




	<cfquery name="GetUsers" datasource="#datasource#" dbtype="ODBC">
		
		Select distinct u.user_id, u.nickname,i.user_id
		From users u,items i
where is_active=1

and u.user_id=i.user_id
		Order By u.nickname ASC
	</cfquery>
	<tr><td colspan="5">
	<form action="list.cfm" method="post">
	  <table align="center">
	  	<tr><td>&nbsp;</td></tr>
		<cfif ParameterExists(URL.action) AND URL.action is "delete">
		  <cfif ParameterExists(Form.itemnum)>
			<tr><td align="center"><font color="Red"><b>auction(s) deleted!</b></font></td></tr>
		  <cfelse>
		   	 <tr><td align="center"><font color="Red"><b>You did not check any item to delete. </b></font></td></tr>
		  </cfif>
		</cfif>


<table border=1 align=center width =400 bordercolor=000080>

<font color=000080 size=3><center><b> Delete auction(s) posted by selected user :</b></center><br></font>

<cfif #getusers.recordcount#>
	  	<tr><td align=center>Select a user to list his or her auction(s):</td></tr>
		<tr><td align=center>
			<select name="user_id">
	<!---			<option value="">--Select a user--</option>		--->
				<cfoutput query="GetUsers">
					<option value="#user_id#">#nickname#</option>		
				</cfoutput>
			</select>
			<input type="submit" value="List Posted Items">
		</td></tr>
</table>
<cfelse>

<center> <font color=red size=3>There is no user at this time</font></center>
</cfif>

	</form>











	<form name="duh" action="auctions.cfm" method="post">
	  <table align="center">
	  	<tr><td>&nbsp;</td></tr>


<table border=1 align=center width =400 bordercolor=000080>

<font color=000080 size=3><center><b> Backup the current database :</b></center><br></font>
<cfif isdefined("duh")>
<font color=red ><center> Your database was saved as /dbase/ms_access97/auctionserver.mdb.bak</center></font>
</cfif>
<cfif isdefined("duh1")>
<font color=red ><center> Your database is now restored</center></font>
</cfif>
	  	<tr><td align=center>Save a copy of your current database as /dbase/ms_access97/auctionserver.mdb.bak. If your site is running on SQL, then you don't need to do this. <font color=red> BE CAREFUL WHEN YOU CLICK ON THE RESTORE BUTTON, BECAUSE IT'LL REVERSE YOUR DATA TO THE PREVIOUS STATE. THAT MEANS ALL THE CHANGES YOU MADE AFTER YOU BACKUP THE DATABASE WILL BE LOST</FONT>:</td></tr>
		<tr><td align=center>

			<input type="submit" name="duh" value="Backup">
			<input type="submit" name="duh1" value="Restore">
		</td></tr>
</table>


	</form>






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
 </body>
</html>
