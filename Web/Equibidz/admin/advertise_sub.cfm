<!--- SourceSafe $Logfile: /Visual-Auction-4/admin/ad_categories.cfm $ $Revision: 2 $ $Date: 1/27/00 8:39p $ $Author: Davidh1 $ --->


<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif #trim(submit)# is "Back">
  <cflocation url="advertise.cfm">
</cfif>
<cfif isDefined("selected_adv_defaults")>
    <cfset selected_ad=#selected_adv_defaults#>
<cfelse>
   <cfset selected_ad=0>
</cfif>
<cfif isDefined("ad_dur") AND #trim(submit)# neq "Reset">
   <cfset ad_dur=#ad_dur#>
<cfelse>
   <cfset ad_dur="">
</cfif>   
<cfif isDefined("ad_fee") AND #trim(submit)# neq "Reset">
   <cfset ad_fee=#ad_fee#>
<cfelse>
   <cfset ad_fee="">
</cfif>   
<cfset #error_message#="">
<cfif #trim(submit)# is "Retrieve">
    <cfquery username="#db_username#" password="#db_password#" name="get_adv_defaults" datasource="#DATASOURCE#">
        SELECT * FROM adv_defaults WHERE ad_dur = #selected_ad#
    </cfquery> 
    <cfset ad_dur = #get_adv_defaults.ad_dur#>
    <cfset ad_fee = #get_adv_defaults.ad_fee#>
</cfif>   
<cfif #trim(submit)# is "Save">
   <cfif #ad_dur# is "" OR #ad_fee# is "" OR #ad_fee# is 0>
      <cfset #error_message# = "Incomplete Information">
   </cfif>
   <cfif #error_message# is "">
      <cfquery username="#db_username#" password="#db_password#" name="get_adv_defaults" datasource="#DATASOURCE#">
         SELECT * FROM adv_defaults WHERE ad_dur = #ad_dur#
      </cfquery> 
      <cfif get_adv_defaults.Recordcount is 0>
         <cfquery username="#db_username#" password="#db_password#" name="add_adv_defaults" datasource="#DATASOURCE#">
            INSERT INTO adv_defaults (ad_dur,ad_fee) VALUES ('#ad_dur#',#ad_fee#) 
         </cfquery> 
      <cfelse>
         <cfquery username="#db_username#" password="#db_password#" name="upd_adv_defaults" datasource="#DATASOURCE#">
            UPDATE adv_defaults
            SET ad_dur = '#ad_dur#',
                ad_fee = #ad_fee#
            WHERE ad_dur = #selected_ad#
         </cfquery>       
      </cfif>    
      <cfset ad_dur = "">
      <cfset ad_fee = "">
   </cfif>
</cfif>
<cfif #trim(submit)# is "Delete">
   <cfif #ad_dur# is "" OR #ad_fee# is "" OR #ad_fee# is 0>
      <cfset #error_message# = "Retrieve the Data to be Deleted first. Then Press Delete">
   </cfif>
   <cfif #error_message# is "">
      <cfquery username="#db_username#" password="#db_password#" name="upd_adv_defaults" datasource="#DATASOURCE#">
         DELETE FROM adv_defaults WHERE ad_dur = #selected_ad#
      </cfquery>       
      <cfquery username="#db_username#" password="#db_password#" name="get_adv_defaults" datasource="#DATASOURCE#">
         SELECT * FROM adv_defaults 
      </cfquery>    
      <cfset selected_ad = #get_adv_defaults.ad_dur#>   
      <cfset ad_dur = "">
      <cfset ad_fee = "">
   </cfif>   
</cfif>

<html>
 <head>
  <title>Visual Auction Server Administrator [Classfied Ads Module]</title>
 <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
 </head>


 <!--- Main page body --->
 <body bgcolor=465775>
  <form name="CatForm" action="./advertise_sub.cfm" method="post">
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
            Use this page to administer the advertisement ad duration & fees in your
            <i>Auction Server</i> software.<br>If you do not know how to use
            this administration tool, please <!---consult your user manual or<br>--->
			click the help button<br>in the upper right corner of this window.
          </td>
          <tr><td><hr></td></tr>
         </tr>
        </table>
        <cfquery username="#db_username#" password="#db_password#" name="get_adv_defaults" datasource="#DATASOURCE#">
           SELECT * FROM adv_defaults      
           ORDER BY ad_dur ASC                            
        </cfquery> 
        <cfif #selected_ad# is 0>
           <cfset selected_ad = #get_adv_defaults.ad_dur#>
        </cfif>        
        <table border=0 cellspacing=10 cellpadding=0>
        <tr><td align="left"><b>Ads Settings</b></td></tr>        
        <tr><td>        
        <table border=0 cellspacing=0 cellpadding=0>
        <tr><td>        
           <tr>
           <td align="left">
           <select name="selected_adv_defaults" size=10 width=250>
              <cfif #get_adv_defaults.recordcount# gt 0>
                   <cfloop query="get_adv_defaults">
                       <cfoutput><option value="#ad_dur#"<cfif #ad_dur# is #selected_ad#> selected</cfif>>#ad_dur# Month(s)&nbsp;&nbsp;&nbsp;#DollarFormat(ad_fee)#</option></cfoutput>
                   </cfloop>
              <cfelse>
                   <cfoutput><option value="0" selected>< empty ></option></cfoutput>
              </cfif>
              </select>
            </td>
           </tr>
        </table>    
        <td>
        <cfoutput>
        <table border=0 cellspacing=0 cellpadding=0>
        <tr><td><font size=2>Duration (Months):</font></td></tr>
        <tr><td><input type="text" name="ad_dur" value="#ad_dur#" size=10></td></tr>
        <tr><td><font size=1>Input Numbers only. Do not put Months</font></td></tr>
        <tr><td><font size=2>Fee (USD):</font></td></tr>
        <tr><td><input type="text" name="ad_fee" value="#ad_fee#" size=10></td></tr>
        <tr><td><font size=1>Input Numbers only. Do not put Currency</font></td></tr>
        <cfif #error_message# neq "">
           <tr><td><font color="red" size=1>#error_message#</font></td></tr>
        </cfif>
        <tr><td>&nbsp;</td></tr>
        <tr><td><input type="submit" name="submit" value="Retrieve">
                <input type="submit" name="submit" value="Save">
                <input type="submit" name="submit" value="Delete" onClick="return confirm('Please Confirm Action?')">
                <input type="submit" name="submit" value="Reset">
                <input type="submit" name="submit" value="Back">
        </td></tr>
        </table>  
        </cfoutput>  
        </td></tr>
       </td>
      </tr>
     </table>
    </center>
   </font>
  </form>
 </body>
</html>
