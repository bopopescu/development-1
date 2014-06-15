<cfsetting enablecfoutputonly="Yes">
<!---
  index.cfm
  
  view user feedback
  
--->
<cfset current_page="feedback">
<cftry>
  <!--- include globals --->
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<!--- define itemnum --->
<cfparam name="itemnum" default="">

<!--- determine if user_id given --->
<cfset idPresentURL = "FALSE">
<cfset idPresentForm = "FALSE">
<cfset userIsValid = "TRUE">

<cfif IsDefined("URL.user_id")>
  <cfset idPresentURL = "TRUE">
<cfelseif IsDefined("Form.user_id")>
  <cfset idPresentForm = "TRUE">
</cfif>

<!--- if idPresent* , setup page info --->
<cfif idPresentURL OR idPresentForm>
  <!--- define which id number to use --->
  <cfif idPresentURL>
    <cfset userId = URL.user_id>
  <cfelseif idPresentForm>
    <cfset userId = Form.user_id>
  </cfif>
  
  <!--- define if id|nickname exist --->
  <cftry>
    <cfset tempId = REReplace(userId, "[^0123456789]", "", "ALL")>
    <cfset tempId = IIf(not Len(tempId), DE("0000"), "tempId")>
    
    <cfquery username="#db_username#" password="#db_password#" name="getId" datasource="#DATASOURCE#">
        SELECT user_id, nickname
          FROM users
         WHERE user_id = #tempId#
    </cfquery>
    
    <cfif not getId.RecordCount>
      <cfquery username="#db_username#" password="#db_password#" name="getId" datasource="#DATASOURCE#">
          SELECT user_id, nickname
            FROM users
           WHERE nickname = '#Trim(userId)#'
      </cfquery>
    </cfif>
    
    <cfset userId = IIf(getId.RecordCount, "getId.user_id", "userId")>
    <cfset userNickname = IIf(getId.RecordCount, "Trim(getId.nickname)", "not available")>
    <cfset userIsValid = IIf(getId.RecordCount, DE("TRUE"), DE("FALSE"))>
    
    <cfcatch>
      <cfset userNickname = "not available">
      <cfset userIsValid = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- if valid user get rest info --->
  <cfif Variables.userIsValid>
    
    <!--- get sum feedback rating on user --->
    <cftry>
      <cfquery username="#db_username#" password="#db_password#" name="sumFeedback" datasource="#DATASOURCE#">
          SELECT SUM(rating) AS userrating, COUNT(rating) AS totalfeedback
            FROM feedback
           WHERE user_id = #Variables.userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
           WHERE user_id = #userId#
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
         WHERE user_id = #userId#
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
         WHERE user_id = #userId#
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
  </cfif>
</cfif>

<!--- output page --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>User Feedback</title>
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
      <br>
      <!--- if user_id not defined, output form --->
      <cfif not idPresentURL AND not idPresentForm OR not userIsValid>
       <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
          <tr>
            <td>
              <b>Please enter a Nickname or User ID to view a member's profile.</b><br>
              <br>
              <form name="lookupFeedback" action="index.cfm" method="POST">
                <input type=text name="user_id" value="" size=20> 
                <input type=submit name="sumit" value="Lookup User">
              </form>

		<SCRIPT LANGUAGE="JavaScript">
		<!--
		document.lookupFeedback.user_id.focus()

		// -->
		</SCRIPT>

              <br>
              <cfif not userIsValid>
                <font color=#ff0000>
                  User not found.  Please check spelling or try a different name.
                </font>
              </cfif>
            </td>
          </tr>
        </table></div>

      <!--- else, output feedback info --->
      <cfelse>
<div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
                 <tr>
            <td>
              <font size=4>
                <b>Feedback Profile for <cfoutput>"#userNickname#" (#userrating#)</cfoutput></b>
              </font>
              <hr width=100% size=1 noshade>
            </td>
          </tr>
        </table>
              <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
          <tr>
            <td colspan=2 valign=top>
              <b>Profile Statistics:</b>
            </td>
            <td width=360 valign=top rowspan=4>
              <table border=0 cellspacing=0 cellpadding=1 noshade width=320>
                <cfoutput><tr bgcolor="616362">
                  <td colspan=4 align=center style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>
                   
                      <b>Summary of Recent Feedback</b>
                  
                  </td>
                </tr></cfoutput>
                <tr bgcolor="gray">
                  <td>&nbsp;</td>
                  <td><font size=2>Past 7 days</font></td>
                  <td><font size=2>Past 30 days</font></td>
                  <td><font size=2>Past 180 days</font></td>
                </tr>
                <tr bgcolor="gray">
                  <td><font size=2>&nbsp;Positive</font></td>
                  <td align=center><cfoutput>#posPast7#</cfoutput></td>
                  <td align=center><cfoutput>#posPast30#</cfoutput></td>
                  <td align=center><cfoutput>#posPast180#</cfoutput></td>
                </tr>
                <tr bgcolor="gray">
                  <td><font size=2>&nbsp;Neutral</font></td>
                  <td align=center><cfoutput>#neuPast7#</cfoutput></td>
                  <td align=center><cfoutput>#neuPast30#</cfoutput></td>
                  <td align=center><cfoutput>#neuPast180#</cfoutput></td>
                </tr>
                <tr bgcolor="gray">
                  <td><font size=2>&nbsp;Negative</font></td>
                  <td align=center><cfoutput>#negPast7#</cfoutput></td>
                  <td align=center><cfoutput>#negPast30#</cfoutput></td>
                  <td align=center><cfoutput>#negPast180#</cfoutput></td>
                </tr>
                <tr bgcolor="gray">
                  <td><font size=2>&nbsp;<b>Total</b></font></td>
                  <td align=center><b><cfoutput>#past7total#</cfoutput></b></td>
                  <td align=center><b><cfoutput>#past30total#</cfoutput></b></td>
                  <td align=center><b><cfoutput>#past180total#</cfoutput></b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td width=10></td>
            <td width=280>
              <cfoutput><b>#totalPositive#</b></cfoutput> Positive comment<cfif totalPositive IS NOT 1>s</cfif>.
            </td>
          </tr>
          <tr>
            <td width=10></td>
            <td>
              <cfoutput><b>#totalNeutral#</b></cfoutput> Neutral comment<cfif totalNeutral IS NOT 1>s</cfif>.
            </td>
          </tr>
          <tr>
            <td width=10></td>
            <td>
              <cfoutput><b>#totalNegative#</b></cfoutput> Negative comment<cfif totalNegative IS NOT 1>s</cfif>.
            </td>
          </tr>
        </table></div>
        <br>
       <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
          <tr>
            <cfoutput><td><a href="#VAROOT#/feedback/leavefeedback.cfm?user_id=#userId#&itemnum=#itemnum#">Click here</a> to leave feeback for this or any other user.</td></cfoutput>
          </tr>
        </table></div>
        <br>
        <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
          <tr>
            <td>
              <font size=4>
                <b>Comments:</b>&nbsp;<cfoutput>#startRec#-#endRec# of #totalComments# total</cfoutput>
              </font>
              <hr width=100% size=1 noshade>
            </td>
          </tr>
        </table></div>
        <!--- output comments --->
        <cfif totalComments>
          <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
            <tr>
              <td>
                <cfif startRec GT 1>
                  <cfoutput><a href="#VAROOT#/feedback/index.cfm?user_id=#userId#&startAt=#evaluate(startRec-numComments)#">prev page</a></cfoutput>
                </cfif>
              </td>
              <td align=right>
                <cfif endRec LT totalComments>
                  <cfoutput><a href="#VAROOT#/feedback/index.cfm?user_id=#userId#&startAt=#IncrementValue(endRec)#">next page</a></cfoutput>
                </cfif>
              </td>
            </tr>
          </table></div>
          <br>



         <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
            <cfsetting enablecfoutputonly="Yes">
            <cfloop query="getComments" startrow="#startRec#" endrow="#endRec#">
              <!--- get user name --->
              <cfquery username="#db_username#" password="#db_password#" name="getUserName" datasource="#DATASOURCE#">
                  SELECT nickname
                    FROM users
                   WHERE user_id = #user_id_from#
              </cfquery>
	      <cfset nickname_not_available = "Not Available">
              <cfset userNickname = IIf(getUserName.RecordCount, "getUserName.nickname", "nickname_not_available")>
              
              <!--- sum user's rating --->
              <cfif getUserName.RecordCount>
                <cfquery username="#db_username#" password="#db_password#" name="sumUserRating" datasource="#DATASOURCE#">
                    SELECT SUM(rating) AS userrating, COUNT(rating) AS totalcount
                      FROM feedback
                     WHERE user_id = #user_id_from#
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
                <cfquery username="#db_username#" password="#db_password#" name="get_feedItem" datasource="#DATASOURCE#">
                    SELECT name
                    FROM items
                    WHERE itemnum = #itemnum#
                </cfquery>
                <cfset itemOn = '<a href="#VAROOT#/listings/details/index.cfm?itemnum=#itemnum#&curr_cat=#curr_cat#&curr_lvl=#curr_lvl#">' & '(' & #itemnum# & ') ' & #get_feedItem.name# & '</a>'>
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
              
              <cfoutput>
                <tr>
                  <td>#userNickname# (#userrating#)</td>
                  <td>#DateFormat(date_placed, "mm/dd/yyyy")# #TimeFormat(date_placed, "HH:mm:ss")#</td>
                  <td>#itemOn#</td>
                  <td>#getComments.comment#</td>
                </tr>
              </cfoutput>
            </cfloop>
            <cfsetting enablecfoutputonly="No">
          </table></div>
        <cfelse>
         <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
            <tr>
              <td align=center>
                No comments at this time...
              </td>
            </tr>
          </table></div>
        </cfif>
        <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
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
          <tr><td align="center"><br><br><input type="button" name="back" value=" << Back " onClick="JavaScript:history.back(1)"></td></tr>
        </table></div>
        <br>
             </cfif>

       <cfoutput>
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
      </table></cfoutput></div>
  </body>
</html>
  
