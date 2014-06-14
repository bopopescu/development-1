<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/item_search_results.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<html>
 <head>
  <title>Visual Auction Server Administrator [Auctions Module: Search Results]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">

 <!--- Set a default value for "submit" if nonexistent --->
 <cfif #isDefined ("submit")# is 0>
  <cfset #submit# = "enter">
 </cfif>

 <!--- Do a search --->
 <cfquery username="#db_username#" password="#db_password#" name="search_items" datasource="#DATASOURCE#">
  SELECT itemnum, title, description
    FROM items
  <cfif #trim (search)# is not "">
   WHERE title LIKE '%#search#%'
      OR description LIKE '%#search#%'
  <cfif #isNumeric (search)#>
      OR itemnum=#search#
  </cfif>
  <cfelse>
   WHERE 1=1
  </cfif>
   ORDER BY title
 </cfquery>
 
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
               The following is a list of items returned by the item search engine.
                           <hr size=1 color=#heading_color# width=100%> 
              </font>
             </td>
            </tr>
            <tr>
             <td valign="top">
               &nbsp;<font face="Helvetica" size=2 color=000080><b>ITEM SEARCH RESULTS:</b><br></font>
               <table border=1 bordercolor=000080 cellspacing=0 cellpadding=2>
                <tr>               
                 <td colspan=2>
                  <form action="auction_item.cfm">
                  <table border=0 cellspacing=0 cellpadding=2>
                   <tr>
                    <td>
                     <cfoutput><font face="helvetica" size=2>#search_items.recordcount# item(s) found.</font></cfoutput>
                     <br>
                     <select name="selected_item" size=10 width=260>
                      <cfloop query="search_items">
                       <cfoutput><option value="#itemnum#" <cfif search_items.currentrow eq 1>selected</cfif>>#title#</option></cfoutput>
                      </cfloop>
                     </select>
                    </td>
                   </tr>
                   <tr>
                    <td><input type="submit" name="submit" value="Edit" width=75>&nbsp;&nbsp;<input type="submit" name="submit" value="Delete" width=75>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Done" width=75></td>
                   </tr>
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
      </td>
     </tr>
    </table>
   </center>
  </font>
 </body>
</html>
