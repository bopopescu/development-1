<!--- include globals ---> 
<cfset current_page="help">
<cfinclude template="includes/app_globals.cfm">
<cfmodule template="functions/timenow.cfm">


<cfoutput>
<html>
  <head>
    <title>Privacy</title>
    
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <!--- Include the body tag --->
   <cfinclude template="includes/bodytag.html"> 
<cfinclude template="includes/menu_bar.cfm">

    <center>
      
      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width="#get_layout.page_width#">
        <tr>
          <td><font size=4><b>Privacy</b></font></td>
        </tr>
        <tr>
          <td>            <hr width="#get_layout.page_width#" size=1 color="#heading_color#" noshade></td>
        </tr>
        <tr>
          <td>
            <font size=3>

 
 #get_layout.Privacy#    <br><br>

        </font>
          </td>
        </tr></table>
		<table border=0 cellpadding=2 cellspacing=0 width="#get_layout.page_width#">
        <tr>
          <td>
            <br>
            <br>
                        <hr width=#get_layout.page_width# size=1 color="#heading_color#" noshade>
          </td>
        </tr>
        <tr>
          <td align="left">
            
              <cfinclude template="includes/copyrights.cfm">
          
          </td>
        </tr>
      </table>
    </center>
    
  </body>
</html></cfoutput>
