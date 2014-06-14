<!---
/admin/archive_menu.cfm

  This Menu to accepts data to archive/stop displaying invoices and payments on the site.
  
 

--->




<html>
 <head>
  <title>Visual Auction Server Administrator [Accounts Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
<!--- Include session tracking template --->

<cfinclude template="../includes/session_include.cfm">


 <!--- Set defaults of they're here for the first time --->
 <cfif isDefined ("submit")>
  <cfset #submit# = #trim (submit)#>
 <cfelse>
  <cfset #submit# = "">
 </cfif>

 <cfif isDefined ("archive_flag")>
  <cfset #archive_flag# = #trim (archive_flag)#>
 <cfelse>
  <cfset #archive_flag# = 0>
 </cfif>
 
   
<!--- Check to see if they want to go back --->
 <cfif IsDefined("form.submit")>
  <cfif #submit# is "Return to Menu">
     <cflocation url="accountsNU.cfm">
  </cfif>
  </cfif>
  
  
 <cfsetting EnableCFOutputOnly="YES">

<!---  1/01 Store info in session variables and branch to another form to process archive --->

  <cfif IsDefined("submit3")> 
    <cfif IsDefined("form.selected_item")> 
      <cfset session.archive_flag = #archive_flag#>
      <cfset session.selected_item = #form.selected_item#>
	  <cflocation url="archive_process.cfm">
	</cfif>
 </cfif>
      
 
  
<!--- 11/00 RS retrieve all active users for select box --->

<cfquery username="#db_username#" password="#db_password#"    name="getUser" datasource="#DATASOURCE#" >
          SELECT user_id, nickname
            FROM users
			WHERE is_active = 1
           ORDER BY nickname
</cfquery>

<!--- Get a list of active users that have account info --->
 <cfquery username="#db_username#" password="#db_password#" name="get_user_list" datasource="#DATASOURCE#">
  SELECT invoices.itemnum,
         invoices.user_id,
         invoices.status,
         invoices.date_created,
         invoices.date_due,
         invoices.listing,
         invoices.second_cat,
         invoices.fee,
         invoices.bold,
         invoices.featured,
         invoices.featured_cat,
         invoices.banner,
<!---  ---><!---  --->
         invoices.studio,
         invoices.late_charge,
         invoices.paid,
         invoices.reference,
		 invoices.invoice_total,
		 invoices.docnum,
         users.name,
         users.balance,
         users.user_id,
         users.nickname,
		 items.quantity
    FROM items, invoices, users
   WHERE items.itemnum = invoices.itemnum
   
   <cfif IsDefined("submit2")>
	  AND invoices.user_id = #form.selectbox_user_id#
	  AND users.user_id = #form.selectbox_user_id#
   <cfelse>
      AND users.user_id = invoices.user_id
   </cfif>
      AND invoices.paid = invoices.invoice_total
      AND invoices.archive = 0
      ORDER BY invoices.date_created
 </cfquery>

 
 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 		
	<body bgcolor=465775 link=ffffff alink=ffaa00 vlink=999999>
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
            <cfset #page# = "accounts">
            <cfinclude template="menu_include.cfm">
		
     
	 <tr>
       <td colspan=5 bgcolor=bac1cf>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>
            <td colspan=2>
             <font face="helvetica" size=3 color=000000>
              <b>Use this page to remove Invoices and payments from being displayed <br>
and processed on the site. This process will not			 DELETE any records. <br>To start, select user and click on Invoices By User. After doing so, click on <br>'Archive' and 'Process' to have Archive processing initiated. 
			 <br><br>
			  Note: Users' balances and credits are not affected.</b> 
			   <br>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>
              
             </font>
            </td>
           </tr>
		  
           <tr>
            <form name="archiveForm" action="archive_menu2.cfm" method="post">
			<td valign="top" align="left">&nbsp;<!---<font face="helvetica"  size=2 color=000080><b>Active Invoices</b></font>--->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Return to Menu">
			  <br>         
              <table border=0 bordercolor=ffffff cellspacing=0 cellpadding=3 bgcolor=bac1cf>
                <cfif #isDefined ("submit2")#>
                 <cfif #submit2# is "Invoices by User">
                  <tr>
                   <cfoutput><td><font face="helvetica" size=2>&nbsp;<b>Please select invoices to remove from the list:</b><br>&nbsp;(#get_user_list.recordcount# records found)</font></td></cfoutput>
                   <!---<td>&nbsp;</td>--->
                  </tr>
                  <tr>
                   <td>
                    <cfif #isDefined ("form.selected_item")#>
                     <cfset #the_itemnum# = #form.selected_item#>
                    <cfelse>
                     <cfset #the_itemnum# = #get_user_list.itemnum#>
                    </cfif>
                    <select name="selected_item" size=10 width=314 MULTIPLE <cfif IsDefined("submit2") > </cfif>>
                     <cfif #get_user_list.recordcount# is 0><option value="-1">< none ></option></cfif>
                     <cfloop query="get_user_list"><cfoutput><option value="#itemnum#"<cfif listcontains(the_itemnum, itemnum)> selected</cfif>>nickn:#nickname#&nbsp;#name#&nbsp;[Item ###itemnum#]&nbsp;(#dateFormat (date_created, "mm-dd-yyyy")#)&nbsp;amount:#invoice_total# </option></cfoutput></cfloop>
					</select>
                   </td>
				   </tr>
				</cfif>
			</cfif>
				
<!---show select check boxes & new user select box--->
			    <!---<cfif #submit# is not "Retrieve">--->
                  <tr>
                   <td>
                    <table border=0 cellspacing=0 cellpadding=2>
                     <tr>
                      <td><font face="helvetica" size=2><b>Archive?:</b></font></td>
                      <td>&nbsp;</td>
                      <td><input name="archive_flag" type="checkbox" value="1"<cfif #archive_flag# is "1"> checked</cfif>>
	                  </td>
                      <td>&nbsp;</td>
                      <td colspan=1>
                      <cfif #isDefined ("form.selectbox_user_id")#>
                        <cfset #the_user_id# = #form.selectbox_user_id#>
                      <cfelse>
                        <cfset #the_user_id# = #getUser.user_id#>
                     </cfif>
                     <select name="selectbox_user_id" size=1 width= 10 >
                     <cfif #getUser.recordcount# is 0><option value="-1">< none ></option></cfif>
                     <cfoutput>
		               <cfloop query="getUser">
		               <option value="#user_id#" <cfif #user_id# is #the_user_id#> selected </cfif>>#getUser.nickname#</option>
		               </cfloop>
		            </cfoutput>
                    </select>
					</td> 
		            <td>&nbsp;</td>
                    <td><input type="submit" name="submit2" value="Invoices by User" width=30></td>
	                <td>&nbsp;</td>
					<td><input type="submit" name="submit3" value="Process " width=30></td>
				  	<td>&nbsp;</td>
					<td>&nbsp;</td>
				  </tr>
			     </table>
	           </td>
		     </tr>
         <!---</cfif>--->		
	   </table>
	  </td>
	 </form>
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
