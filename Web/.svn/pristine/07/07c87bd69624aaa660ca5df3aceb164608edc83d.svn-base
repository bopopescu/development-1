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

  <SCRIPT LANGUAGE="JavaScript">
  <!-- Hide from other browsers

    function checkAll1()
    {
      for (var i=0;i<document.numbskull1.id.length;i++)
      {
        var e = document.numbskull1.id[i];
        if (e.name != 'selectAll')
          e.checked = !e.checked;
      }
    }
	

  // Stop Hididng from other Browsers  -->
  </SCRIPT>


<!---
  bidhistory.cfm
  displays bidding history of a given item...
--->

  <cfinclude template="../../includes/app_globals.cfm">
  



<cfif #ParameterExists(delete)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="item" list="#Form.id#">

<cfquery datasource="#datasource#">
delete  from bids
where id = #item#
</cfquery>
</cfloop>
</cfif>


</cfif>



<cfif #ParameterExists(delete1)#>
<cfif ParameterExists(Form.id)>
		  <cfloop index="item" list="#Form.id#">

<cfquery datasource="#datasource#">
delete  from proxy_bids
where id = #item#
</cfquery>
</cfloop>
</cfif>


</cfif>



<cfsetting enablecfoutputonly="Yes">

<cftry>
  <!--- include globals --->
  <!--- define TIMENOW --->
  <cfmodule template="../../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>
<cfinclude template="../../includes/session_include.cfm">


<cftry>
  <!--- get item's info --->
  <cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#DATASOURCE#">
      SELECT itemnum, user_id, title, date_start, date_end, minimum_bid, reserve_bid, private
        FROM items
       WHERE itemnum = #URL.itemnum#
  </cfquery>
  
  <!--- define found/not found --->
  <cfset isvalid = IIf(get_ItemInfo.RecordCount, DE("TRUE"), DE("FALSE"))>
  
  <cfcatch>
    <cfset isvalid = "FALSE">
  </cfcatch>
</cftry>

<!--- if valid get rest of info --->
<cfif Variables.isvalid>
  <!--- get currency type --->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#DATASOURCE#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>
  
  <!--- get highest bidder, number of bids --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getHighBid" datasource="#DATASOURCE#">
        SELECT MAX(bid) AS highest, COUNT(bid) AS found
          FROM bids
         WHERE itemnum = #get_ItemInfo.itemnum#
		 AND buynow = 0
    </cfquery>
    
    <cfif getHighBid.found>
      <cfset lastBid = getHighBid.highest>
      <cfset numberBids = Round(getHighBid.found)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset lastBid = get_ItemInfo.minimum_bid>
      <cfset numberBids = 0>
    </cfcatch>
  </cftry>
  
  
  
  <!--- get highest bidder, number of bids --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getproxyHighBid" datasource="#DATASOURCE#">
        SELECT MAX(bid) AS highest, COUNT(bid) AS found
          FROM proxy_bids
         WHERE itemnum = #get_ItemInfo.itemnum#
		 
    </cfquery>
    
    <cfif getproxyHighBid.found>
      <cfset lastBid = getproxyHighBid.highest>
      <cfset numberproxyBids = Round(getproxyHighBid.found)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset lastBid = get_ItemInfo.minimum_bid>
      <cfset numberproxyBids = 0>
    </cfcatch>
  </cftry>
  
  <!--- define if reserve met --->
  <cftry>
    <cfif lastBid GTE get_ItemInfo.reserve_bid OR get_ItemInfo.reserve_bid IS 0>
      <cfset reserveMet = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset reserveMet = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- get seller info for item --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getSeller" datasource="#DATASOURCE#">
        SELECT nickname, email
          FROM users
         WHERE user_id = #get_ItemInfo.user_id#
    </cfquery>
    
    <cfif getSeller.RecordCount>
      <cfset sellerNick = Trim(getSeller.nickname)>
      <cfset sellerEmail = Trim(getSeller.email)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset sellerNick = "Not Available">
      <cfset sellerEmail = "Not Available">
    </cfcatch>
  </cftry>
  
  <!--- sum seller rating --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="getSellerRate" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS rate, COUNT(rating) AS found
          FROM feedback
         WHERE user_id = #get_ItemInfo.user_id#
    </cfquery>
    
    <cfif getSellerRate.found>
      <cfset sellerRating = Round(getSellerRate.rate)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset sellerRating = 0>
    </cfcatch>
  </cftry>
  
  <!--- define "mailto" link value --->
  <cfif get_ItemInfo.private>
    <cfset mailToLink = "#VAROOT#/messaging/index.cfm?user_id=" & get_ItemInfo.user_id>
  <cfelse>
    <cfset mailToLink = "mailto:" & sellerEmail>
  </cfif>
  
  <!--- get bids --->
 <cfquery username="#db_username#" password="#db_password#" name="getHistory" datasource="#DATASOURCE#">
      SELECT B.user_id, B.time_placed, B.bid, B.quantity, U.nickname, U.email,b.id
        FROM bids B, users U
       WHERE B.itemnum = #get_ItemInfo.itemnum#
         AND B.user_id = U.user_id
		 AND B.buynow = 0
       ORDER BY B.bid DESC, B.time_placed ASC
  </cfquery> 
  

  
   <!--- get proxy_bids --->
  <cfquery username="#db_username#" password="#db_password#" name="getproxyHistory" datasource="#DATASOURCE#">
      SELECT P.user_id, P.time_placed, P.bid, P.quantity, U.nickname, U.email,p.id
        FROM proxy_bids P, users U
       WHERE P.itemnum = #get_ItemInfo.itemnum#
         AND P.user_id = U.user_id
	ORDER BY P.bid DESC, P.time_placed ASC
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
</cfif>

<!--- output page --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>Item Bid History</title>

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../../includes/bodytag.html">
 <cfinclude template="../../includes/menu_bar.cfm">
    <center>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=600>
        <tr>
          <td>
            <!--- include menu bar --->
            <center>
              <br>
<!--- 
              <br>
              Browse the <a href="<cfoutput>#VAROOT#</cfoutput>/studio/index.html">studio</a> for items.
 --->
            </center>
          </td>
        </tr>
      </table>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=600>
        <tr>
          <td>
            <font size=4>
              <b>Bid History for</b>
            </font>
            <hr size=1 color=#heading_color# width=100%> 
          </td>
        </tr>
      </table>
      <cfif isvalid>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=600>
          <tr>
            <td>
              <center>
                <cfoutput>#Trim(get_ItemInfo.title)# (item <a href="./index.cfm?itemnum=#get_ItemInfo.itemnum#">###get_ItemInfo.itemnum#</a>)</cfoutput>
              </center>
              
            </td>
          </tr>
        </table>
        <cfoutput>
        <table border=0 cellspacing=0 cellpadding=1 noshade width=600>
         
          <tr>
            <td><b>Number of bids made:</b></td>
            <td><b>#numberBids#</b> <cfif numberBids GT 1><font size=2>(may include multiple bids by the same bidder)</font></cfif></td>
          </tr>
         
        </table>
        </cfoutput>
        <br>
        <table border=0 cellspacing=0 cellpadding=1 noshade width=600>
          <tr>
            <td>
                          <hr size=1 color=#heading_color# width=100%> 
              <center>
                (ordered highest bid to lowest bid and oldest to newest)
              </center>
            </td>
          </tr>
        </table>
        <cfsetting enablecfoutputonly="Yes">
          <!--- output history --->
          <cfif getHistory.RecordCount>
            
            <cfoutput>
              <table border=0 cellspacing=0 cellpadding=2 width=600 noshade>
              <tr bgcolor=#rowBgcolor#>
                <td><b>User:</b> (Rating)</td>
                <td><b>Bid:</b></td>
                <td><b>Quantity:</b></td>
                <td><b>Date:</b></td>
              </tr>
            </cfoutput>



<cfif #gethistory.recordcount# neq 0>

<cfoutput>
<input type="checkbox" name="selectAll " onClick="return checkAll();">
	Check All<br>
</cfoutput>
</cfif>

<cfoutput>
<form  name="numbskull" action="bidhistory.cfm?itemnum=#itemnum#" method="post">



            <cfset loop_count = 0>

            <cfloop query="getHistory">

            <!--- define mailtoLink --->
            <cfif get_ItemInfo.private>
              <cfset mailToLink = "#VAROOT#/messaging/index.cfm?user_id=" & getHistory.user_id>
            <cfelse>
              <cfset mailToLink = "mailto:" & Trim(getHistory.email)>
            </cfif>
            
            <!--- get users rating --->
            <cftry>
              <cfquery username="#db_username#" password="#db_password#" name="getRating" datasource="#DATASOURCE#">
                  SELECT SUM(rating) AS userrating, COUNT(rating) AS found
                    FROM feedback
                   WHERE user_id = #getHistory.user_id#
              </cfquery>
              
              <cfif getRating.found>
                <cfset userRating = Round(getRating.userrating)>
              <cfelse>
                <cfthrow>
              </cfif>
              
              <cfcatch>
                <cfset userRating = 0>
              </cfcatch>
            </cftry>

            <cfset bgcolor = iif(int(loop_count/2) neq (loop_count/2), "rowBgcolor", DE(""))>

<tr bgcolor=#bgcolor#>
                <td>

<input type="checkbox" name="id" value="#id	#">
<a href="#mailToLink#">#Trim(getHistory.nickname)#</a>&nbsp;(<a href="#VAROOT#/feedback/index.cfm?user_id=#getHistory.user_id#">#userRating#</a>)</td>
                <td>#numberFormat(getHistory.bid,numbermask)# #Trim(getCurrency.type)#</td>
                <td>#getHistory.quantity#</td>
                <td>#DateFormat(getHistory.time_placed, "mm/dd/yy")#&nbsp;#TimeFormat(getHistory.time_placed, "HH:mm:ss")#</td>
              </tr>


            <cfset loop_count = loop_count + 1>
            
            </cfloop>
			



<center>
<cfif #gethistory.recordcount# neq 0>

<input type="submit" name="delete" value="Delete bid(s)" onclick="return confirm('Are you sure you want to delete these bid?');">




			<input type="button" value="Go Back" Onclick="history.back();">
<cfelse>
		<input type="button" value="Go Back" Onclick="history.back();">


</cfif>

</center>
</form>
</cfoutput>	


			<!--- Display proxy_bids --->
			<cfoutput><tr bgcolor=#bgcolor#><td colspan=4></cfoutput>
			<cfoutput><br><br><b>Proxy bids</b><br>            <hr size=1 color=#heading_color# width=100%> <br><b>Number of bids made:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #numberproxyBids#</b></cfoutput>
			<cfoutput></td></tr></cfoutput>



<cfoutput>
<cfif #getproxyhistory.recordcount# neq 0>



<tr>
<td>

<input type="checkbox" name="selectAll " onClick="return checkAll1();">
	Check All<br>
</td>
</tr>
</cfif>

<form  name="numbskull1" action="bidhistory.cfm?itemnum=#itemnum#" method="post">




            <cfloop query="getproxyHistory">
			 <tr bgcolor=#bgcolor#>
			<td>

<input type="checkbox" name="id" value="#id#">
<a href="#mailToLink#">#Trim(getproxyHistory.nickname)#</a>&nbsp;(<a href="#VAROOT#/feedback/index.cfm?user_id=#getproxyHistory.user_id#">#userRating#</a>)</td><td>#numberFormat(getproxyHistory.bid,numbermask)# #Trim(getCurrency.type)#</td>
                <td>#getproxyHistory.quantity#</td>
                <td>#DateFormat(getproxyHistory.time_placed, "mm/dd/yy")#&nbsp;#TimeFormat(getproxyHistory.time_placed, "HH:mm:ss")#</td>
			</tr>
			</cfloop> 




<center>
<cfif #getproxyhistory.recordcount# neq 0>
<tr>
<td>
<input type="submit" name="delete1" value="Delete proxy bid(s)" onclick="return confirm('Are you sure you want to delete these bid?');">




			<input type="button" value="Go Back" Onclick="history.back();">
<cfelse>
		<input type="button" value="Go Back" Onclick="history.back();">
</td>
</tr>
</cfif>

</center>


</form>

</cfoutput>
			<!--- end display proxy_bids --->
			
			
            <cfoutput>
              </table>
            </cfoutput>
            
          <cfelse>
            <cfoutput>
              <table border=0 cellspacing=0 cellpadding=0 width=600 noshade>
                <tr>
                  <td>
                    <br>
                    No bids have been placed yet.
                  </td>
                </tr>
              </table>
            </cfoutput>
          </cfif>
        <cfsetting enablecfoutputonly="No">
        <br>
        <br>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=600>
          <tr>
            <td>
              <!--- include menu bar --->
              <center>
              </center>
            </td>
          </tr>
        </table>
      <cfelse>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=600>
          <tr>
            <td>
              Sorry... item not found.  Please try a different item number.<br>
              <br>
            </td>
          </tr>
        </table>
      </cfif>
      <br>
      <br>
      <table border=0 cellspacing=0 cellpadding=0 noshade width=600>
        <tr>
          <td align=left valign=top>
             <font size=2>
               <cfinclude template="../../includes/copyrights.cfm">
               <br>
               <br>
               <br>
            </font>
          </td>
        </tr>
      </table>
    </center>




  </body>
</html>
