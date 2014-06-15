  <SCRIPT LANGUAGE="JavaScript">
  <!-- Hide from other browsers

    function checkAll()
    {
      for (var i=0;i<document.numbskull.id.length;i++)
      {
        var e = document.numbskull.id[i];
        if (e.name != 'selectAll')
          e.checked = !e.checked;
      }
    }
	

  // Stop Hididng from other Browsers  -->
  </SCRIPT>



  <cfinclude template="../includes/app_globals.cfm">
  



<cfif #ParameterExists(delete)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="item" list="#Form.id#">

<cfquery datasource="#datasource#">
delete from blocked_bidders
where id = #item#
</cfquery>
</cfloop>
</cfif>


</cfif>






<cfsetting enablecfoutputonly="Yes">

<cftry>
  <!--- include globals --->
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>
<cfinclude template="../includes/session_include.cfm">




  

 <cfquery username="#db_username#" password="#db_password#" name="getHistory" datasource="#DATASOURCE#">
      SELECT *
        FROM blocked_bidders
       WHERE seller =#session.user_id#

       ORDER BY date_placed ASC
  </cfquery> 
  

  

  
  
  <!--- get bgcolor for listings --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="bgColor" datasource="#DATASOURCE#">
        SELECT pair AS listing_bgcolor
          FROM defaults
         WHERE name = 'listing_bgcolor'
    </cfquery>
    
    <cfif bgColor.RecordCount>
      <cfset rowBgcolor = Trim(bgColor.listing_bgcolor)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset rowBgcolor = "d3d3d3">
    </cfcatch>
  </cftry>


<!--- output page --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>Blocked Bidders List</title>

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
  <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
   


    <tr><td><font size=2 color="000000"><b>Blocked Bidders List</b></font></td></tr>
        <tr>
          <td>


            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%>


          </td>
        </tr>


      </table>

        
        
        
        <cfsetting enablecfoutputonly="Yes">
          <!--- output history --->
          <cfif getHistory.RecordCount>
            
            <cfoutput>
              <table border=0 cellspacing=0 cellpadding=2 width=600 noshade>
              <tr bgcolor=#rowBgcolor#>
                <td><b>Itemnum:</b></td>
                <td><b>Title:</b></td>
                <td><b>Blocked Bidders:</b></td>
                <td><b>Date:</b></td>
              </tr>
            </cfoutput>



<cfif #gethistory.recordcount# neq 0>

<cfoutput>
<input type="checkbox" name="selectAll " onClick="return checkAll();">
	Check All<br>

(<font size=1>Select the bidder(s) you want to reinstate, then click on the "Reinstate Bidder(s)" button</font>)
</cfoutput>
</cfif>

<cfoutput>
<form  name="numbskull" action="blockedlist.cfm" method="post">



            <cfset loop_count = 0>

            <cfloop query="getHistory">

      
     
              <cfquery username="#db_username#" password="#db_password#" name="getuser" datasource="#DATASOURCE#">
                  SELECT nickname,email
                    FROM users
                   WHERE user_id = #getHistory.bidder#
              </cfquery>
              

         <cfquery username="#db_username#" password="#db_password#" name="getitem" datasource="#DATASOURCE#">
                  SELECT title
                    FROM items
                   WHERE itemnum = #itemnum#
              </cfquery>
           

            <cfset bgcolor = iif(int(loop_count/2) neq (loop_count/2), "rowBgcolor", DE(""))>

<tr bgcolor=#bgcolor#>
                <td>

<input type="checkbox" name="id" value="#id#">
<a href="#varoot#/listings/details/index.cfm?itemnum=#itemnum#" target=_blank>#itemnum#</a></td>
                <td><a href="#varoot#/listings/details/index.cfm?itemnum=#itemnum#" target=_blank>#getitem.title#</a></td>
                <td><a href="mailto:#getuser.email#">#getuser.Nickname# &nbsp;(#bidder#)</a></td>
                <td>#DateFormat(getHistory.date_placed, "mm/dd/yy")#&nbsp;#TimeFormat(getHistory.date_placed, "HH:mm:ss")#</td>
              </tr>


            <cfset loop_count = loop_count + 1>
            
            </cfloop>
			



<center>
<cfif #gethistory.recordcount# neq 0>

<input type="submit" name="delete" value="Reinstate Bidder(s)" onclick="return confirm('Are you sure you want to reinstate these bidders?');">





<cfelse>
		<input type="button" value="Go Back" Onclick="history.back();">


</cfif>

</center>
</form>
</cfoutput>	


		
			
            <cfoutput>
              </table>
            </cfoutput>
            
          <cfelse>
            <cfoutput>
              <table border=0 cellspacing=0 cellpadding=0 width=600 noshade>
                <tr>
                  <td>
                    <br>
                    There is no blocked bidders in the list.



                  </td>
                </tr>

              </table>
            </cfoutput>

          </cfif>

<cfquery name="checkitem" datasource="#DATASOURCE#">

select count(itemnum) as moose from items where status=1 and user_id=#session.user_id#
</cfquery>


<!---<cfif #checkitem.moose# gt 0> --->
<cfset #error_message# = "">
<cfset #error_list# = "">
<cfparam name="bidder" default="">
<cfparam name="itemnum" default="">





<cfif isdefined ("submit") and #submit# is "block this bidder">



  
   

<cfif #bidder# is "">

      <cfset #error_list# =#listAppend (error_list, "bidder")#>

</cfif>

    <cfif #itemnum# is "">
      <cfset #error_list# = #listAppend (error_list, "itemnum")#>
 </cfif>





<cfif #error_list# is ""  AND #error_message# IS "">




   <cfquery username="#db_username#" password="#db_password#" name="verify" datasource="#DATASOURCE#">
    SELECT bidder from blocked_bidders where bidder=(select user_id from users where nickname='#bidder#') and itemnum = #itemnum#
   </cfquery>

<cfif #verify.recordcount# eq 0>



   <cfquery username="#db_username#" password="#db_password#" name="getuser" datasource="#DATASOURCE#">
 select user_id from users where nickname='#bidder#'
   </cfquery>

   <cfquery username="#db_username#" password="#db_password#" name="blocked" datasource="#DATASOURCE#">
    insert into blocked_bidders(seller,bidder,date_placed,itemnum,remote_ip)

values (#session.user_id#, #getuser.user_id#,#CreateODBCDateTime(timenow)#,#itemnum#,'#cgi.remote_addr#')
   </cfquery>



<cfset #error_message# = "<font color=Red size=2>The bidder is now blocked from bidding on your specified auction item</font>">

<cfelse>
<cfset #error_message# = "<font color=Red size=2>You already added bidder into your blocked list</font>">

</cfif>
</cfif> 
</cfif>






<!---</cfif> --->



<cfoutput>

  <!--- The main table --->
  <center>

       
   <table border=0 cellspacing=0 cellpadding=2 width=800>

<cfif #error_message# is not "">
	
<tr>
<td>
  
              <font size=3 color=ff0000>	            <center>#error_message#</center></font>
</td>
</tr>

</cfif>


    <tr><td><font size=2 color="000000"><b>Block bidder</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# noshade></td></tr>
    <tr>
     <td>
     <font size=1><b>
Please try to resolve any disputes with the bidders first before you blocking them. Please enter the bidder's nickname who you want to block, your auction item, and click on "Block This Bidder" button.      
</b></font>
</td>
</tr>
<tr>
<td>
&nbsp;
</td>
</tr>

 <br><br>
      
      	 <form name="addbidder" action="blockedlist.cfm" method="post">
        <table border=0 cellspacing=0 cellpadding=4>









<tr>
<td>&nbsp;</td>
</tr>      
         <tr><td><font <cfif #listFind (error_list, "bidder")#>color="ff0000"<cfelse>color="0000ff"</cfif>><b>Bidder's Nickname:</b></font></td>
		  <td>&nbsp;</td>
<td><input type="text" name="bidder" value="" size=15 maxlength=20></td></tr>
         <tr><td ><font <cfif #listFind (error_list, "itemnum")#>color="ff0000"<cfelse>color="0000ff"</cfif>><b>Your Auction Itemnum:</b></font></td>

		  <td>&nbsp;</td>
<td><input type="itemnum" name="Itemnum" value="" size=15 maxlength=20></td></tr>
                

        
        </table>
        <br>

        <input type="submit" name="submit" value="Block This Bidder" width=75>
       </form>
     </td>
    </tr>
  
   </table>     

</cfoutput>



<cfoutput>      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=800>




<tr>
<td>
  <div align="center">

 <cfinclude template="nav.cfm">
</div>
      </td></tr></table>
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
            
              <cfinclude template="../includes/copyrights.cfm">
          
          </td>
        </tr>
      </table></div>
</cfoutput>
  </body>
</html>
