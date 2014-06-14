<!--- include globals ---> <cfset current_page="help">
<cfinclude template="includes/app_globals.cfm">
<cfmodule template="functions/timenow.cfm">



<html>
  <head>
    <title>Site's News and Announcements</title>
    
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <!--- Include the body tag --->
   <cfinclude template="includes/bodytag.html"> 
<cfinclude template="includes/menu_bar.cfm">

<cfquery  name="get_news1" datasource="#DATASOURCE#" maxrows=1>

select  * from news
where news is not null
order by date_posted DESC
</cfquery>


<cfquery  name="get_news" datasource="#DATASOURCE#">

select  * from news
where news is not null
order by date_posted DESC
</cfquery>
    <center>
      
      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width=562>
        <tr>
          <td><font size=4><b>Site's News and Announcements</b></font></td>
        </tr>
        <tr>
          <td>            <hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
        </tr>
        <tr>
          <td>


<cfif  #get_news1.recordcount#>
<cfoutput>#get_news1.news#</cfoutput>
</cfif>
       

<br>

<br>
<br>

     <font size=3>

<cfif  #get_news.recordcount#>
<cfoutput query="get_news">    


<a href="news2.cfm?id=#id#"><b> #Title# </b><!---#DateFormat(date_posted, "mm/dd/yy")# #TimeFormat(date_posted, "hh:mm:sstt")#           ---></a><br><br></cfoutput>
</cfif>
            </font>
          </td>
        </tr>
        <tr>
          <td>
            <br>
            <br>
                        <hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            <font size=3>
              <cfinclude template="includes/copyrights.cfm">
            </font>
          </td>
        </tr>
      </table>
    </center>
    
  </body>
</html>
