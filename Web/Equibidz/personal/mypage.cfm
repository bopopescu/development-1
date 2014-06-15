<cfsetting enablecfoutputonly="yes">

 <!--- include globals --->

 <cfset current_page = "personal">
 <cfinclude template="../includes/app_globals.cfm">
  
 

 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">

<cfinclude template="../includes/bodytag.html">


<CFQUERY username="#db_username#" password="#db_password#" name="getmypage" datasource="#DATASOURCE#">
      SELECT mypage, user_id, nickname,showfeedback,showauctions,membership_status
      FROM users
<CFIF IsDefined("url.nickname")>
      WHERE nickname='#URL.nickname#'
</CFIF>
</CFQUERY>

<CFIF IsDefined("form.mypagetext")>
<CFQUERY name="putmypage" username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
Update users
set mypage = '#form.mypagetext#'
WHERE user_id = #session.user_id#
</CFQUERY>
</CFIF>

<!--- define seller's feedback rating --->
  <cftry>
    <cfquery username="#db_username#" password="#db_password#" name="get_SellerFeedback" datasource="#DATASOURCE#">
        SELECT SUM(rating) AS ratinglevel, COUNT(rating) AS totalfeed
          FROM feedback
         WHERE user_id = #getmypage.user_id#
    </cfquery>
    
    <cfif get_SellerFeedback.totalfeed>
      <cfset ratingSeller = Round(get_SellerFeedback.ratinglevel)>
    <cfelse>
      <cfset ratingSeller = 0>
    </cfif>
    
    <cfcatch>
      <cfset ratingSeller = "not available">
    </cfcatch>
  </cftry>

<cfoutput>
<html>
<head><title> About Me</title>
<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
</head>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
   
  <center>
   <table border=0 cellspacing=0 cellpadding=2 width=640>
    <tr><td><font size=4 color="000000"><b>My Page</b></font></td></tr>
    <tr><td><hr size=1 color=#heading_color# width=100%></td></tr>
    <tr>
     <td>
      <font size=3>
</font>
</td>
</tr>




							<cfif ratingSeller LTE 9><cfset ratinglegend=#get_layout.legend1#>
							<cfelseif ratingSeller LTE 49><cfset ratinglegend=#get_layout.legend2#>
							<cfelseif ratingSeller LTE 99><cfset ratinglegend=#get_layout.legend3#>
							<cfelseif ratingSeller LTE 499><cfset ratinglegend=#get_layout.legend4#>
							<cfelseif ratingSeller LTE 999><cfset ratinglegend=#get_layout.legend5#>
							<cfelseif ratingSeller LTE 4999><cfset ratinglegend=#get_layout.legend6#>
							<cfelseif ratingSeller LTE 9999><cfset ratinglegend=#get_layout.legend7#>
							<cfelseif ratingSeller LTE 24999><cfset ratinglegend=#get_layout.legend8#>
							<cfelseif ratingSeller LTE 49999><cfset ratinglegend=#get_layout.legend9#>
							<cfelseif ratingSeller LTE 99999><cfset ratinglegend=#get_layout.legend10#>
							<cfelse><cfset ratinglegend=#get_layout.legend11#>
							</cfif>
	


     <tr>
      <td height="24"><div style="padding-left:15px;" class="h">


<b>User ID: <a href="#VAROOT#/feedback/index.cfm?user_id=#getmypage.user_id#">#getmypage.nickname#</a>(<a href="#VAROOT#/feedback/index.cfm?user_id=#getmypage.user_id#">#ratingSeller#</a>&nbsp;

<b><a href="#VAROOT#/feedback/legend.cfm"><img align="ABSMIDDLE" border="0" src="/legends/#ratinglegend#"></a></b>
									
									)</b><cfif getmypage.mypage neq "">
										<a href="../../personal/mypage.cfm?nickname=#getmypage.nickname#" target=_blank><img src="#varoot#/legends/#get_layout.aboutmeicon#"  border="0" align="absbotton"></a>
									</cfif>


<cfif #getmypage.membership_status# eq 1>
										<a href="../../help/about_membership.cfm" target=_blank><img src="#varoot#/legends/#get_layout.membershipicon#"  border="0" align="absbotton"></a>
									</cfif>
</div>










     <tr>
      <td bgcolor="##FFFFFF">
       <div style="padding-left:15px;padding-right:15px;padding-top:15px;padding-bottom:15px;">       
         #getmypage.mypage#        
	   </div>
       </td>
       </tr>

<br>
<br>


<cfif #getmypage.showfeedback# eq 1>


 <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="sumFeedback" datasource="#DATASOURCE#">
          SELECT SUM(rating) AS userrating, COUNT(rating) AS totalfeedback
            FROM feedback
           WHERE user_id = #getmypage.user_id#
      </cfquery>
      
      <cfif sumFeedback.totalfeedback>
        <cfset userrating = Round(sumFeedBack.userrating)>
      <cfelse>
        <cfset userrating = 0>
      </cfif>
      
      <cfcatch>
        <cfset userrating = "">
      </cfcatch>
    </cftry>
    
    <!--- get postive feedback count --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getPositive" datasource="#DATASOURCE#">
          SELECT COUNT(user_id) AS totalpos
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 1
      </cfquery>
      
      <cfset totalPositive = getPositive.totalpos>
      
      <cfcatch>
        <cfset totalPositive = "Not Available">
      </cfcatch>
    </cftry>
    
    <!--- get neutral feedback count --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeutral" datasource="#DATASOURCE#">
          SELECT COUNT(user_id) AS totalpos
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 0
      </cfquery>
      
      <cfset totalNeutral = getNeutral.totalpos>
      
      <cfcatch>
        <cfset totalNeutral = "Not Available">
      </cfcatch>
    </cftry>
    
    <!--- get negative feedback count --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNegative" datasource="#DATASOURCE#">
          SELECT COUNT(user_id) AS totalpos
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = -1
      </cfquery>
      
      <cfset totalNegative = getNegative.totalpos>
      
      <cfcatch>
        <cfset totalNegative = "Not Available">
      </cfcatch>
    </cftry>
    
    <!--- get pos feed count, past 7 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getPos7" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 1
             AND date_placed >= #DateAdd("d", -7, TIMENOW)#
      </cfquery>
      
      <cfset posPast7 = getPos7.found>
      
      <cfcatch>
        <cfset posPast7 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get pos feed count, past 30 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getPos30" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 1
             AND date_placed >= #DateAdd("d", -30, TIMENOW)#
      </cfquery>
      
      <cfset posPast30 = getPos30.found>
      
      <cfcatch>
        <cfset posPast30 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get pos feed count, past 180 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getPos180" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 1
             AND date_placed >= #DateAdd("d", -180, TIMENOW)#
      </cfquery>
      
      <cfset posPast180 = getPos180.found>
      
      <cfcatch>
        <cfset posPast180 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get neu feed count, past 7 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeu7" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 0
             AND date_placed >= #DateAdd("d", -7, TIMENOW)#
      </cfquery>
      
      <cfset neuPast7 = getNeu7.found>
      
      <cfcatch>
        <cfset neuPast7 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get neu feed count, past 30 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeu30" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 0
             AND date_placed >= #DateAdd("d", -30, TIMENOW)#
      </cfquery>
      
      <cfset neuPast30 = getNeu30.found>
      
      <cfcatch>
        <cfset neuPast30 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get neu feed count, past 180 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeu180" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = 0
             AND date_placed >= #DateAdd("d", -180, TIMENOW)#
      </cfquery>
      
      <cfset neuPast180 = getNeu180.found>
      
      <cfcatch>
        <cfset neuPast180 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get neg feed count, past 7 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeg7" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = -1
             AND date_placed >= #DateAdd("d", -7, TIMENOW)#
      </cfquery>
      
      <cfset negPast7 = getNeg7.found>
      
      <cfcatch>
        <cfset negPast7 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get neg feed count, past 30 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeg30" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = -1
             AND date_placed >= #DateAdd("d", -30, TIMENOW)#
      </cfquery>
      
      <cfset negPast30 = getNeg30.found>
      
      <cfcatch>
        <cfset negPast30 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- get neg feed count, past 180 days --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getNeg180" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS found
            FROM feedback
           where user_id=#getmypage.user_id#
             AND rating = -1
             AND date_placed >= #DateAdd("d", -180, TIMENOW)#
      </cfquery>
      
      <cfset negPast180 = getNeg180.found>
      
      <cfcatch>
        <cfset negPast180 = "n/a">
      </cfcatch>
    </cftry>
    
    <!--- define summary totals --->
    <cfloop index="l" list="7,30,180"> 
      <cfset tempPos = IIf(IsNumeric(Evaluate("posPast" & l)), "Evaluate('posPast' & l)", "0")>
      <cfset tempNeu = IIf(IsNumeric(Evaluate("neuPast" & l)), "Evaluate('neuPast' & l)", "0")>
      <cfset tempNeg = IIf(IsNumeric(Evaluate("negPast" & l)), "Evaluate('negPast' & l)", "0")>
      
      <cfset varName = "past" & l & "total">
      <cfif not IsNumeric(Evaluate("posPast" & l))
        AND not IsNumeric(Evaluate("neuPast" & l))
        AND not IsNumeric(Evaluate("negPast" & l))>
        <cfset "#varName#" = "n/a">
      <cfelse>
        <cfset "#varName#" = Evaluate(Abs(tempPos) + Abs(tempNeu) + Abs(tempNeg))>
      </cfif>
    </cfloop>
    
    <!--- get number of comments per page --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="NumComments" datasource="#DATASOURCE#">
          SELECT pair AS fb_per_page
            FROM defaults
           WHERE name = 'fb_per_page'
      </cfquery>
      
      <cfset numComments = NumComments.fb_per_page>

      <cfcatch>
        <cfset numComments = 20>
      </cfcatch>
    </cftry>
    
    <!--- define start of group --->
    <cfset startRec = 1>
    <cfif IsDefined("URL.startAt")>
      <cfset startRec = URL.startAt>
    <cfelseif IsDefined("Form.startAt")>
      <cfset startRec = Form.startAt>
    </cfif>
    <cfset startRec = IIf(IsNumeric(startRec), "startRec", "1")>
    
    <!--- get total number of comments --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="cntComments" datasource="#DATASOURCE#">
          SELECT COUNT(rating) AS totalfound
            FROM feedback
           where user_id=#getmypage.user_id#
      </cfquery>
      
      <cfset totalComments = cntComments.totalfound>
      
      <cfcatch>
        <cfset totalComments = 0>
      </cfcatch>
    </cftry>
    
    <!--- define end of group --->
    <cfset endRec = startRec + numComments - 1>
    <cfif endRec GT totalComments>
      <cfset endRec = totalComments>
    </cfif>
    
    <!--- get record set of comments --->
<!---    <cfquery username="#db_username#" password="#db_password#" name="getStarter" datasource="#DATASOURCE#" maxrows="#startRec#"> --->
	<cfquery username="#db_username#" password="#db_password#" name="getStarter" datasource="#DATASOURCE#">
        SELECT date_placed
          FROM feedback
         where user_id=#getmypage.user_id#
         ORDER BY date_placed DESC
    </cfquery>
    
    <cfif getStarter.RecordCount>
      <cfset dateMarker = CreateODBCDateTime(getStarter.date_placed)>
    <cfelse>
      <cfset dateMarker = TIMENOW>
    </cfif>
   
   
<!--- <cfquery username="#db_username#" password="#db_password#" name="getComments" datasource="#DATASOURCE#" maxrows="#numComments#"> --->
    
    <cfquery username="#db_username#" password="#db_password#" name="getComments" datasource="#DATASOURCE#">
        SELECT user_id_from, date_placed, rating, comment, itemnum
          FROM feedback
         where user_id=#getmypage.user_id#
           AND date_placed <= #dateMarker#
         ORDER BY date_placed DESC
    </cfquery>
    
    <!--- get listing bgcolor --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="getBgcolor" datasource="#DATASOURCE#">
          SELECT pair AS listing_bgcolor
            FROM defaults
           WHERE name = 'listing_bgcolor'
      </cfquery>
      
      <cfset commentBgcolor = getBgcolor.listing_bgcolor>
      
      <cfcatch>
        <cfset commentBgcolor = "d3d3d3">
      </cfcatch>
    </cftry>




<table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td>
              <font size=2>
Feedback Profile for "#URL.nickname#" (#userrating#&nbsp;

<b><a href="#VAROOT#/feedback/legend.cfm"><img align="ABSMIDDLE" border="0" src="/legends/#ratinglegend#"></a></b>
									
									)</b><cfif getmypage.mypage neq "">
										<a href="../../personal/mypage.cfm?nickname=#getmypage.nickname#" target=_blank><img src="#varoot#/legends/#get_layout.aboutmeicon#"  border="0" align="absbotton"></a>
									</cfif>


<cfif #getmypage.membership_status# eq 1>
										<a href="../../help/about_membership.cfm" target=_blank><img src="#varoot#/legends/#get_layout.membershipicon#"  border="0" align="absbotton"></a>
									</cfif>       </font>
              <hr size=1 color=#heading_color# width=100%>
            </td>
          </tr>
        </table>
        <font size=1><br></font>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td colspan=2 valign=top>
              <b>Profile Statistics:</b>
            </td>
            <td width=360 valign=top rowspan=4>
              <table border=0 cellspacing=0 cellpadding=1 noshade width=320>
                <tr bgcolor=000080>
                  <td colspan=4 align=center>
                    <font size=2 color=ffffff face="Arial">
                      <b>Summary of Recent Feedback</b>
                    </font>
                  </td>
                </tr>
                <tr bgcolor=d3d3d3>
                  <td>&nbsp;</td>
                  <td><font size=2>Past 7 days</font></td>
                  <td><font size=2>Past 30 days</font></td>
                  <td><font size=2>Past 180 days</font></td>
                </tr>
                <tr bgcolor=d3d3d3>
                  <td><font size=2>&nbsp;Positive</font></td>
                  <td align=center>#posPast7#</td>
                  <td align=center>#posPast30#</td>
                  <td align=center>#posPast180#</td>
                </tr>
                <tr bgcolor=d3d3d3>
                  <td><font size=2>&nbsp;Neutral</font></td>
                  <td align=center>#neuPast7#</td>
                  <td align=center>#neuPast30#</td>
                  <td align=center>#neuPast180#</td>
                </tr>
                <tr bgcolor=d3d3d3>
                  <td><font size=2>&nbsp;Negative</font></td>
                  <td align=center>#negPast7#</td>
                  <td align=center>#negPast30#</td>
                  <td align=center>#negPast180#</td>
                </tr>
                <tr bgcolor=d3d3d3>
                  <td><font size=2>&nbsp;<b>Total</b></font></td>
                  <td align=center><b>#past7total#</b></td>
                  <td align=center><b>#past30total#</b></td>
                  <td align=center><b>#past180total#</b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td width=10></td>
            <td width=280>
              <b>#totalPositive#</b> Positive comment<cfif totalPositive IS NOT 1>s</cfif>.
            </td>
          </tr>
          <tr>
            <td width=10></td>
            <td>
              <b>#totalNeutral#</b> Neutral comment<cfif totalNeutral IS NOT 1>s</cfif>.
            </td>
          </tr>
          <tr>
            <td width=10></td>
            <td>
              <b>#totalNegative#</b>Negative comment<cfif totalNegative IS NOT 1>s</cfif>.
            </td>
          </tr>
        </table>
        <br>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td><a href="#VAROOT#/feedback/leavefeedback.cfm?user_id=#getmypage.user_id#&">Click here</a> to leave feeback for this user.</td>
          </tr>
        </table>
        <br>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td>
              <font size=2>
Comments
              </font>
              <hr size=1 color=#heading_color# width=100%>
            </td>
          </tr>
        </table>
        <!--- output comments --->
        <cfif totalComments>
          <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
            <tr>
              <td>
                <cfif startRec GT 1>
                  <a href="#VAROOT#/feedback/index.cfm?user_id=#getmypage.user_id#&startAt=#evaluate(startRec-numComments)#">prev page</a>
                </cfif>
              </td>
              <td align=center>
                Comments #startRec#-#endRec# of #totalComments# total
              </td>
              <td align=right>
                <cfif endRec LT totalComments>
                  <a href="#VAROOT#/feedback/index.cfm?user_id=#getmypage.user_id#&startAt=#IncrementValue(endRec)#">next page</a>
                </cfif>
              </td>
            </tr>
          </table>
          <br>



          <table border=0 cellspacing=0 cellpadding=2 noshade width=640>
            <cfsetting enablecfoutputonly="Yes">
            <cfloop query="getComments" startrow="#startRec#" endrow="#endRec#">
              <!--- get user name --->
              <cfquery username="#db_username#" password="#db_password#" name="getUserName" datasource="#DATASOURCE#">
                  SELECT nickname
                    FROM users
                               WHERE user_id = #getmypage.user_id#
              </cfquery>
	      <cfset nickname_not_available = "Not Available">
              <cfset userNickname = IIf(getUserName.RecordCount, "getUserName.nickname", "nickname_not_available")>
              
              <!--- sum user's rating --->
              <cfif getUserName.RecordCount>
                <cfquery username="#db_username#" password="#db_password#" name="sumUserRating" datasource="#DATASOURCE#">
                    SELECT SUM(rating) AS userrating, COUNT(rating) AS totalcount
                      FROM feedback
                     WHERE user_id = #getmypage.user_id#
                </cfquery>
                
                <cfif sumUserRating.totalcount>
                  <cfset userrating = Round(sumUserRating.userrating)>
                <cfelse>
                  <cfset userrating = 0>
                </cfif>
              <cfelse>
                <cfset userrating = "not available">
              </cfif>
              
              <!--- define item display --->
              <cfif IsNumeric(itemnum) AND itemnum IS NOT 0>
                <cfset itemOn = '<b>Item:</b> <a href="#VAROOT#/listings/details/index.cfm?itemnum=' & itemnum & '">' & itemnum & '</a>'>
              <cfelse>
                <cfset itemOn = "&nbsp;">
              </cfif>
              
              <!--- define type of comment --->
              <cfset comType = "">
              <cfif rating IS 1>
                <cfset comType = "Positive:">
              <cfelseif rating IS 0>
                <cfset comType = "Neutral:">
              <cfelseif rating IS -1>
                <cfset comType = "Negative:">
              </cfif>
              

                <tr bgcolor="#commentBgcolor#">
                  <td width=240><b>User:</b> <a href="#VAROOT#/messaging/index.cfm?user_id=#user_id_from#">#userNickname#</a> (<a href="#VAROOT#/feedback/index.cfm?user_id=#user_id_from#">#userrating#</a>)</td>
                  <td width=240><b>Date:</b> #DateFormat(date_placed, "mm/dd/yyyy")# #TimeFormat(date_placed, "HH:mm:ss")#</td>
                  <td width=160>#itemOn#</td>
                </tr>
                <tr>
                  <td colspan=3><b>#comType#</b> #Trim(comment)#</td>
                </tr>

            </cfloop>
            <cfsetting enablecfoutputonly="No">
          </table>
        <cfelse>
          <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
            <tr>
              <td align=center>
                No comments at this time...
              </td>
            </tr>
          </table>
        </cfif>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
          <tr>
            <td>
              <br>
              <br>
              The preceeding comments have been ordered by date with the most recent 
              first.  The author of each comment takes full responsibility for his or her 
              remarks.  If you would like to speak to the author of a comment you may do 
              so by clicking on their User Id or Nickname and leaving them a message.
            </td>
          </tr>
        </table>

</cfif>
<cfif #getmypage.showauctions# eq 1>

  <cfquery username="#db_username#" password="#db_password#" name="get_results" datasource="#DATASOURCE#">

SELECT * FROM items WHERE user_id = (select user_id from users where nickname='#nickname#') AND status = 1 and date_start < #timenow# 
</cfquery>

<cfparam name="PgNum" default="1">

<cfset error_string= "">


<cfset bUseDefPerPg = 0>
<cfset iListPerPg = 25>

<cfquery username="#db_username#" password="#db_password#" name="getListPerPg" datasource="#DATASOURCE#">
    SELECT pair
      FROM defaults
     WHERE name = 'itemsperpage'
</cfquery>

<cfif getListPerPg.RecordCount>
  <cfif IsNumeric(getListPerPg.pair)>
    <cfset bUseDefPerPg = 1>
  </cfif>
</cfif>

<cfif Variables.bUseDefPerPg>
  <cfset iListPerPg = getListPerPg.pair>
</cfif>

<!--- def startrow/endrow --->
<cfset iStartRow = 0>
<cfset iEndRow = iListPerPg>

<cfif IsNumeric(PgNum)>
  <cfif PgNum GT 1>
    
    <cfset iStartRow = (PgNum * iListPerPg) - iListPerPg>
    <cfset iEndRow = PgNum * iListPerPg>
  </cfif>
</cfif>

<cfset iStartRow = iStartRow + 1>

<!--- get listing ending hours color --->
<cfquery username="#db_username#" password="#db_password#" name="HrsEndingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'hrsending_color'
</cfquery>

<!--- get # of days item is new --->
<cfquery username="#db_username#" password="#db_password#" name="ListingNew" datasource="#DATASOURCE#">
    SELECT pair AS days
      FROM defaults
     WHERE name = 'listing_new'
</cfquery>

<!--- get number of bids required for hot auction --->
<cfquery username="#db_username#" password="#db_password#" name="HotAuction" datasource="#DATASOURCE#">
    SELECT pair AS bids
      FROM defaults
     WHERE name = 'bids4hot'
</cfquery>

<!--- get listing ending hours value --->
<cfquery username="#db_username#" password="#db_password#" name="HrsEnding" datasource="#DATASOURCE#">
    SELECT pair AS hours
      FROM defaults
     WHERE name = 'hrsending'
</cfquery>

<!--- get listing ending hours color --->
<cfquery username="#db_username#" password="#db_password#" name="HrsEndingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'hrsending_color'
</cfquery>

<!--- define listing row color --->
<cfquery username="#db_username#" password="#db_password#" name="get_ListingColor" datasource="#DATASOURCE#">
    SELECT pair AS color
      FROM defaults
     WHERE name = 'listing_bgcolor'
</cfquery>

<!--- get thumbs mode settings (Thumbnail display outside studio) --->
<cfquery username="#db_username#" password="#db_password#" name="get_thumbsMode" datasource="#DATASOURCE#">
    SELECT pair AS show_thumbs
      FROM defaults
     WHERE name = 'enable_thumbs'
</cfquery>



    <!--- The main table --->
    <center>
	
      <table border=0  align=center cellspacing=0 cellpadding=2 width=640>
        <tr>
          <td>
            <font size=4 color="000000">
              <b>Auction Listings</b>
            </font>
          </td>
        </tr>
        <tr>
          <td>         <hr size=1 color=#heading_color# width=100%></td>
        </tr>
        <tr>
          <td>
            <font size=3>
              <cfif #error_string# is "">
                
                  <cfset resultsFound = IIf(get_results.RecordCount, DE("TRUE"), DE("FALSE"))>
                
                
                <cfif Variables.resultsFound>
                  
                    <b>#get_results.RecordCount# item(s) were found:</b>
                  
                  
                  <br>
                  <center>
                    <cfif IsNumeric(PgNum)>
                      <cfif PgNum GT 1>
                        [<a href="search_results.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum - 1)#">Previous</a>]
                      </cfif>
                    </cfif>
                    
                    <cfset sDspPgNum = IIf(IsNumeric(PgNum), "PgNum", "1")>
                    
                    Viewing Page #Variables.sDspPgNum#.
                    
                    <cfif IsDefined("Variables.sql_code")
                      AND Variables.iEndRow LT get_results.RecordCount
                      AND Variables.iEndRow LT get_results.RecordCount> 
                      
                      <cfif IsNumeric(PgNum)>
                        [<a href="search_results.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum + 1)#">Next</a>]
                      </cfif>
                     </cfif> 
                  </center>
                  <br>
                  <br>
                  
                  <cfmodule template="../functions/prnt_listing.cfm"
                    part="HEADER"
                    featured_studio="#get_results.featured_studio#"
             	      show_thumbs="#get_thumbsMode.show_thumbs#"
                    datasource="#DATASOURCE#"
					db_username="#db_username#"
					db_password="#db_password#"
					heading_color="#heading_color#"
					heading_fcolor="#heading_fcolor#"
					heading_font="#heading_font#">
                  
                  <cfset item_count = 0>
				  <cfset loopTo = 1>
                 <!---  <cfset loopTo = IIf(IsDefined("Variables.sql_code"), DE("2"), DE("1"))> --->
                  <cfset queryName = "get_results">
                  
                  <cfloop index="i" from=1 to=#loopTo#>
                    <cfloop query="#queryName#" startrow="#Variables.iStartRow#" endrow="#Variables.iEndRow#">
                      
                      <!--- increment item_count --->
                      <cfset item_count = IncrementValue(item_count)>
                      
                      <!--- get bids --->
                      <cfquery username="#db_username#" password="#db_password#" name="CountBids" datasource="#DATASOURCE#">
                          SELECT COUNT(itemnum) AS total
                            FROM bids
                           WHERE itemnum = #itemnum#
                      </cfquery>
                      
                      <!--- get highest bid --->
                      <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
                          SELECT MAX(bid) AS price
                            FROM bids
                           WHERE itemnum = #itemnum#
                      </cfquery>
                     <cfif auction_mode is 1> 
					  <!-- get lowest bid -->
					   <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
                          SELECT MIN(bid) AS price
                            FROM bids
                           WHERE itemnum = #itemnum#
                      </cfquery>
					  </cfif>
                      <!--- output listing --->
					  <cfif isDefined('url.auction_mode')>
					  <cfif auction_mode is 0>
                      <cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						highest="#HighestBid.price#"
                        minimum_bid="#minimum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#get_results.featured_studio#"
                 	      show_thumbs="#get_thumbsMode.show_thumbs#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#"
						numbermask="#numbermask#">
						<cfelse>
						<cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						lowest="#LowestBid.price#"
                        maximum_bid="#maximum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#featured_studio#"
                 	      show_thumbs="#get_thumbsMode.show_thumbs#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#"
						numbermask="#numbermask#">
						</cfif><cfelseif auction_mode is not 1>
						<cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						highest="#HighestBid.price#"
                        minimum_bid="#minimum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#featured_studio#"
                 	      show_thumbs="#get_thumbsMode.show_thumbs#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#"
						numbermask="#numbermask#">
						<cfelse>
							<cfmodule template="../functions/prnt_listing.cfm"
                        part="LISTING"
                        itemnum="#itemnum#"
                        itemtitle="#title#"
                        currentrow="#item_count#"
                        rowcolor="#get_ListingColor.color#"
                        boldtitle="#bold_title#"
                        picture="#picture#"
                        sound="#sound#"
                        banner="#banner#"
                        banner_line="#banner_line#"
            						lowest="#LowestBid.price#"
                        maximum_bid="#maximum_bid#"
				                totalbids="#CountBids.total#"
                        hotbids="#HotAuction.bids#"
                        TIMENOW="#TIMENOW#"
                        listingnew="#ListingNew.days#"
                        date_start="#date_start#"
                        date_end="#date_end#"
                        listingending="#HrsEnding.hours#"
                        endingcolor="#HrsEndingColor.color#"
                        featured_studio="#featured_studio#"
                 	      show_thumbs="#get_thumbsMode.show_thumbs#"
                        VAROOT="#VAROOT#"
						datasource="#DATASOURCE#"
						db_username="#db_username#"
						db_password="#db_password#"
						numbermask="#numbermask#">
                      </cfif>
                    </cfloop>
                    <cfset queryName = "get_results2">
                  </cfloop>
                  
                  <cfmodule template="../functions/prnt_listing.cfm" part="FOOTER">
                  <br>
                  <center>
                    <cfif IsNumeric(PgNum)>
                      <cfif PgNum GT 1>
                        [<a href="mypage.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum - 1)#&&nickname='#nickname#'">Previous</a>]
                      </cfif>
                    </cfif>
                    
                    <cfset sDspPgNum = IIf(IsNumeric(PgNum), "PgNum", "1")>
                    
                    Viewing Page #Variables.sDspPgNum#.
                    
                    <cfif IsDefined("Variables.sql_code")
                      AND Variables.iEndRow LT get_results.RecordCount
                      AND Variables.iEndRow LT get_results.RecordCount> 
                      
                      <cfif IsNumeric(PgNum)>
                        [<a href="mypage.cfm?#REReplace(CGI.QUERY_STRING, "&PgNum=[0-9]*", "", "ALL")#&PgNum=#Evaluate(PgNum + 1)#&nickname='#nickname#'">Next</a>]
                      </cfif>
                     </cfif> 
                  </center>
                <cfelse>
                  <b>Sorry, no items matching your search criteria were found.  You may want to go back and modify your search.</b><br>
                  <br>
                </cfif>
                
              <cfelse>
                <font size=3 color="ff0000">
                  <b>#error_string#</b>
                </font>
              </cfif>

<!---              <br>
                       <hr size=1 color=#heading_color# width=100%>
              <form name="blah" action="index.cfm" method="get">
                <input type="hidden" name="search_type" value="#search_type#">
                <input type="hidden" name="search_text" value="#search_text#">
                <input type="hidden" name="search_span" value="#search_span#">
                <input type="hidden" name="search_limit" value="#search_limit#">
                <input type="hidden" name="order_by" value="#order_by#">
                <input type="hidden" name="sort_order" value="#sort_order#">
                <input type="hidden" name="country" value="#country#">
                <input type="hidden" name="country_type" value="#country_type#">
                <input type="hidden" name="category" value="#category#">
                <input type="submit" value="<< Back" width=75>
              </form>
--->
            </font>
          </td>
        </tr>
       

      </table>
    </center>
  </body>
</html>





</cfif>





</td>
     </tr>

	   <tr>

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
    </td>
  </tr>

<table width=640 align=center>
<tr>
<td>
<hr size=1  color=#heading_color#>
</td>
</tr>
<tr>
<td>

 <cfinclude template="../includes/copyrights.cfm">
</td>
</tr>
</table>
 </cfoutput>

