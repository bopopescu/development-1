<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/preview_image.cfm $ $Revision: 1 $ $Date: 12/29/99 2:22p $ $Author: Joe $ --->

<html>
 <cfoutput>
  <head>
   <title>Previewing Image of Auction Item</title>
  </head>
 
  <body bgcolor="cccccc">
   <center>
    <table border=0 cellspacing=0 cellpadding=0>
     <tr><td align="center"><font face="helvetica" size=2><b>#title#</b></font><br><br></td></tr>
     <tr><td align="center"><img border=1 bordercolor="000000" src="#image#"></td></tr>
     <tr><td align="center"><a href="#image#"><font face="helvetica" size=1>#image#</font></a></td></tr>
     <tr>
      <td align="center">
       <form name="blah">
        <br><input type="button" value=" Close Window " onclick="window.close ()" width=75>
       </form>
      </td>
     </tr>
    </table>     
   </center>
  </body>

 </cfoutput> 
</html>
