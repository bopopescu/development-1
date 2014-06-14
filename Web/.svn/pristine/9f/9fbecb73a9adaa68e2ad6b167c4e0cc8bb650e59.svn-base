<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>

 <cfinclude template="../includes/app_globals.cfm">
 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">

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
	     <cfset #page# = "admin">
	     <cfinclude template="menu_include.cfm">  

 <cfif #ParameterExists(delete)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="bannerid" list="#Form.id#">

<cfquery datasource="#datasource#">
delete  from banners
where id = #bannerID#
</cfquery>
</cfloop>
</cfif>
</cfif>


<tr>
      <td colspan=5 bgcolor=bac1cf>
       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=100%>	    
        <tr>
         <td>
          <table border=0 cellspacing=0 cellpadding=5 width=100%>
           <tr>


<div align="center"><font face="Arial,Verdana" size="3" color="Navy"><b>Selected Banner Has Been Removed</b></font></div>
<center>
<input type="button" value="Go Back" Onclick="history.back();">
</center>



</body>

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
 </body>
</html>

