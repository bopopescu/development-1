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

<cfinclude template = "../includes/app_globals.cfm">
<cfparam name="ban_hptop" default="0">
<cfparam name="ban_hpbot" default="0">
<cfparam name="ban_am" default="0">



<cfquery name="banner2" datasource="#datasource#">
select * from banners
where ID=#ID#
</cfquery>


<cfif #ParameterExists(edit)#>
<cfif isdefined("form.file_name") and form.file_name is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory2 = #GetDirectoryFromPath(curPath)#>
  <cfset #directory2# = Replace(GetDirectoryFromPath("#curPath#"),"admin","banners")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.file_name"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.file_name"
      DESTINATION="#directory2#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
  <cfset file_name = #File.ServerFile#>
<cfelse><cfset file_name = old_file_name>
</cfif>

<cfquery datasource="#datasource#">
update banners
set factor='#factor#',
    file_name='#file_name#',
	company='#company#',
	webaddress='#webaddress#',
	username='#username#',
	password='#password#',
	ban_hptop=#ban_hptop#,
	ban_hpbot=#ban_hpbot#,
	ban_am=#ban_am#,
banner_enable=#banner_enable#

where ID=#ID#
</cfquery>
</cfif>







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

