<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->

<cfmodule template="../functions/timenow.cfm">

<!--- If defined, merge the separate date and time objects into 1 object --->
 <cfif #isDefined ("start_time")#>
  <cfset #start_time# = "#start_time##start_time_s#">
  <cfset #start_hour# = #timeFormat (start_time, 'H')#>
  <cfset #start_min# = #timeFormat (start_time, 'm')#>
  <cfset #date_start# = #createDateTime (start_year, start_month, start_day, start_hour, start_min, 0)#>
 </cfif>
 
 <!--- Main page body --->
 <body bgcolor=465775>
  <form name="item_input" action="./advertise.cfm" method="post" enctype="multipart/form-data">
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
      <cfset #page# = "advertise">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf>

        <!--- A table encapsulating the main page content;
              with a thin black border --->
        <table border=0 bordercolor=000000 cellspacing=0 cellpadding=3 width=100%>
         <tr>
          <td>
           <font face="helvetica" size=2 color=000000>
            Use this page to administer the advertisement applications in your
            <i>Auction Server</i> software.<br>If you do not know how to use
            this administration tool, please <!---consult your user manual or<br>--->
			click the help button<br>in the upper right corner of this window.<br><br>
            &nbsp;Related Table:
            <input type="submit" name="submit" value="Duration & Fees">&nbsp;<input type="submit" value="Advertisement Information" onclick="showAdinfoWindow()">
			<input type="submit" name="newad" onClick="showAdForm()" value="New Ad">
          </td>
          <tr><td><hr></td></tr>
         </tr>
        </table>
		<form method="post" action="index.cfm" name="item_input" enctype="multipart/form-data">
        <input type="hidden" name="adnum" value="#adnum#">
        <table  border="0" align="center">
          <tr><td colspan="3"><font size=3>
       Please fill out the following form to place your ad, remembering
       to be as accurate and honest as possible when describing your offering, as set
       forth in the <A HREF="../terms.cfm">Terms & Conditions</A>.  You must be a <A HREF="..#VAROOT#/registration/index.cfm">registered user</A> to advertise.<br>
            </font><br>
     <font size=2>NOTE: This Advertisement will not be posted automatically pending Site Approval.</font>
<hr width=100% size=1 color="#heading_color#" noshade>
            </td>
          </tr>
<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
         

 		<input name="user_id" type="hidden" value="#session.user_id#">
		<input name="password" type="hidden" value="#session.password#">

 	  <cfelse>


          <tr>
            <td>
				
            <font size=3 color="0000ff"><b>* User Name:</b></font>
            </td>
            <td ><input name="user_id" size="15" value="#user_id#" maxlength="20" >
            </td>
          </tr>
          <tr>
            <td><font size=3 color="0000ff"><b>* Password:</b></font>
            </td>
            <td>
           <input type="password" name="password" size="15" value="#password#" maxlength="12">
            </td>

          </tr> 



</cfif>
        
          <tr>
            <td><font><b>Ad Number:</b></font></td>
            <td colspan=2>#adnum#</td>
          </tr>
          <tr>
          <td><font size=3><b>Web Link:</b></font></td>
          <td colspan="2"><input name="title" value="#title#" size="45" >&nbsp;
                          <input type="button" name="prevlink" value="Preview Link" onClick="return preview_link()"><br>&nbsp;(ex. http://www.yahoo.com)
          </td>
          </tr>
       <tr>
       <td><font size=3><b>Start Date/Time:</b></font></td>
       <td>
        <table border=0 cellspacing=0 cellpadding=1>
         <tr>
          <cfset the_month = #datePart ("m", "#date_start#")#>
          <cfset the_day = #datePart ("d", "#date_start#")#>
          <cfset the_year = #datePart ("yyyy", "#date_start#")#>
          <cfset the_time = #timeFormat ("#date_start#", 'hh:mm')#>
          <cfset the_time_s = #timeFormat ("#date_start#", 'tt')#>
           <td>
           <select name="start_month">
            <option value="1"<cfif #the_month# is "1"> selected</cfif>>Jan</option>
            <option value="2"<cfif #the_month# is "2"> selected</cfif>>Feb</option>
            <option value="3"<cfif #the_month# is "3"> selected</cfif>>Mar</option>
            <option value="4"<cfif #the_month# is "4"> selected</cfif>>Apr</option>
            <option value="5"<cfif #the_month# is "5"> selected</cfif>>May</option>
            <option value="6"<cfif #the_month# is "6"> selected</cfif>>Jun</option>
            <option value="7"<cfif #the_month# is "7"> selected</cfif>>Jul</option>
            <option value="8"<cfif #the_month# is "8"> selected</cfif>>Aug</option>
            <option value="9"<cfif #the_month# is "9"> selected</cfif>>Sep</option>
            <option value="10"<cfif #the_month# is "10"> selected</cfif>>Oct</option>
            <option value="11"<cfif #the_month# is "11"> selected</cfif>>Nov</option>
            <option value="12"<cfif #the_month# is "12"> selected</cfif>>Dec</option>
           </select>
          </td>
          <td><input name="start_day" type="text" size=2 maxlength=2 value="#the_day#">,</td>
          <td><input name="start_year" type="text" size=4 maxlength=4 value="#the_year#"></td>
          <td><font size=3>&nbsp;at&nbsp;</font></td>
          <td><input name="start_time" type="text" size=5 maxlength=5 value="#the_time#"></td>
          <td>
           <select name="start_time_s">
            <option value="AM"<cfif #the_time_s# is "AM"> selected</cfif>>AM</option>
            <option value="PM"<cfif #the_time_s# is "PM"> selected</cfif>>PM</option>
           </select>
          </td>
         </tr>
        </table>
       </td>
      </tr>
       <tr><td colspan="3"><font size=2>(This Date is subject to change pending approval of this Ad)</font><br><br></td></tr>
          <tr>
            <td><font size=3><b>Ad Duration/Fees:</b></font></td>
            <td colspan="2">
              <select name="Duration">
                <cfloop query="get_duration">
                 
                  <option value='#ad_dur#' <cfif #ad_dur# EQ 1>selected</cfif>>#ad_dur# Month(s) - $#numberformat(ad_fee,numbermask)#
                </cfloop>
              </select>
            </td>
          </tr>
          <tr><td colspan=3>&nbsp;</td></tr>
		  <tr><td><font face="helvetica" size=2><font size=3><b>Upload Ad Banner:</b><br>(150H X 130W)</font></td><td colspan="2"><input name="picture" type="file" size=45 maxlength=250></td></tr>
         <tr>
           <td colspan=3><br><br>

              <input type="submit" name="submit" value="Submit" onClick="return val_imagename()"> &nbsp;
              <input type="submit" name="return" value="Return">

            </td>
          </tr>

        </table>
      </form>
       
 </body>
</html>
