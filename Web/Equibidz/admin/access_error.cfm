<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/access.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->
 
<html>
 <head>
  <title>Visual Auction Server Administrator [Access Module]</title>
 </head>

 

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

 <cfsetting EnableCFOutputOnly="YES">
  
  
 <cfsetting EnableCFOutputOnly="NO">

 <!--- Main page body --->
 <body bgcolor=465775>
  <form name="CatForm" action="./access.cfm" method="post">
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
                        <hr size=1 color=#heading_color# width=100%> 
           </font>
           <br>
		   
           &nbsp;<font face="Helvetica" size=2 color=000080><b>You do not have access to <cfoutput>#url.access_cat#</cfoutput></b></font>
           
           
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
