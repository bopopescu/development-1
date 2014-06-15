<!---
  leavefeedback.cfm
  
  form used for leaving feedback on a user...
  will run stand alone...
  or excepting either or both... (Session.nickname, URL.user_id, Form.user_id)
  
--->
<cfset current_page="feedback">
<cfsetting enablecfoutputonly="Yes">

<cftry>
  <!--- include globals --->
  <cfinclude template="../includes/app_globals.cfm">
  
  <!--- define TIMENOW --->
  <cfmodule template="../functions/timenow.cfm">
  
  <cfcatch>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfcatch>
</cftry>

<!--- enable Session state management --->
<cfset mins_until_timeout = 60>
<cfapplication name="UserManagement" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, mins_until_timeout, 0)#">

<!--- define nickname --->
<cfif IsDefined("Session.nickname")>
  <cfset nickname = Trim(Session.nickname)>
<cfelseif IsDefined("Form.nickname")>
  <cfset nickname = Trim(Form.nickname)>
<cfelseif IsDefined("URL.nickname")>
  <cfset nickname = Trim("URL.nickname")>
<cfelse>
  <cfset nickname = "">
</cfif>

<!--- define user_id of receiver --->
<cfif IsDefined("Form.user_id")>
  <cfset user_id = Trim(Form.user_id)>
<cfelseif IsDefined("URL.user_id")>
  <cfset user_id = Trim(URL.user_id)>
<cfelse>
  <cfset user_id = "">
</cfif>

<cfif Len(user_id)>
  <cfset tempId = REReplace(user_id, "[^0123456789]", "", "ALL")>
  <cfset tempId = IIf(not Len(tempId), DE("0"), "tempId")>
  
  <cfquery username="#db_username#" password="#db_password#" name="getUser" datasource="#DATASOURCE#">
      SELECT nickname
        FROM users
       WHERE user_id = #tempId#
  </cfquery>
  
  <cfif not getUser.RecordCount>
    <cfquery username="#db_username#" password="#db_password#" name="getUser" datasource="#DATASOURCE#">
        SELECT nickname
          FROM users
         WHERE nickname = '#user_id#'
    </cfquery>
  </cfif>
  
  <cfif getUser.RecordCount>
    <cfset user_id = Trim(getUser.nickname)>
  </cfif>
</cfif>

<!--- define itemnum comment refers to --->
<cfif IsDefined("Form.itemnum")>
  <cfset itemnum = Trim(Form.itemnum)>
<cfelseif IsDefined("URL.itemnum")>
  <cfset itemnum = Trim(URL.itemnum)>
<cfelse>
  <cfset itemnum = "">
</cfif>

<!--- define tone of comment --->
<cfif IsDefined("Form.tone")>
  <cfset tone = Trim(Form.tone)>
<cfelseif IsDefined("URL.tone")>
  <cfset tone = Trim(URL.tone)>
<cfelse>
  <cfset tone = "positive">
</cfif>

<!--- define comment --->
<cfif IsDefined("Form.comment")>
  <cfset comment = Trim(Form.comment)>
<cfelse>
  <cfset comment = "">
</cfif>

<!--- define highlights start/end --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="getHighLight" datasource="#DATASOURCE#">
      SELECT pair AS alink_color
        FROM defaults
       WHERE name = 'alink_color'
  </cfquery>
 <cfset error_message=""> 
  <cfset theColor = Trim(getHighLight.alink_color)>
  
  <cfset hlightStart = '<font color="' & theColor & '">'>
  <cfset hlightEnd = '</font>'>
  
  <cfcatch>
    <cfset hlightStart = '<font color="ff0000">'>
    <cfset hlightEnd = '</font>'>
  </cfcatch>
</cftry>

<!--- define default check values --->
<cfset chkNickname = "TRUE">
<cfset chkPassword = "TRUE">
<cfset chkUserID = "TRUE">
<cfset chkItemnum = "TRUE">
<cfset chkTone = "TRUE">
<cfset chkComment = "TRUE">
<cfset chkSubmit = "TRUE">
<cfset chkSelf = "FALSE">
<cfset chkSecond = "FALSE">

<!--- if submit verify information --->
<cfif IsDefined("Form.leave_comment")>
  
  <!--- chk From id/nickname & password  --->
  <cftry>
    <cfif IsNumeric(Trim(Form.nickname))>
      <cfquery username="#db_username#" password="#db_password#" name="chkLogin" datasource="#DATASOURCE#">
          SELECT user_id, password, nickname
            FROM users
           WHERE user_id = #Trim(Form.nickname)#
             AND password = '#Trim(Replace(Form.password, "'", "''", "ALL"))#'
             AND last_login_date <> #CreateODBCDateTime("12/31/1969")#

OR nickname = '#Trim(Form.nickname)#'
             AND password = '#Trim(Replace(Form.password, "'", "''", "ALL"))#'
             AND last_login_date <> #CreateODBCDateTime("12/31/1969")#

      </cfquery>

  

<cfelse>


      <cfquery username="#db_username#" password="#db_password#" name="chkLogin" datasource="#DATASOURCE#">
          SELECT user_id, password, nickname
            FROM users
           WHERE nickname = '#Trim(Form.nickname)#'
             AND password = '#Trim(Replace(Form.password, "'", "''", "ALL"))#'
             AND last_login_date <> #CreateODBCDateTime("12/31/1969")#
      </cfquery>
    </cfif>
    



    <cfif chkLogin.RecordCount>

      <cfset savUserId = chkLogin.user_id>
      <cfset savPassword = Trim(chkLogin.password)>
      <cfset chkNickname = "TRUE">
      <cfset chkPassword = "TRUE">
      <cfset Session.nickname = Trim(chkLogin.nickname)>
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset savUserId = "">
      <cfset savPassword = "">
      <cfset chkNickname = "FALSE">
      <cfset chkPassword = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- chk To id/nickname & password  --->
  <cftry>
    <cfif IsNumeric(Trim(Form.user_id))>
      <cfquery username="#db_username#" password="#db_password#" name="chkUser" datasource="#DATASOURCE#">
          SELECT user_id
            FROM users
           WHERE user_id = #Trim(Form.user_id)#
           OR    nickname = '#Trim(Form.user_id)#'

      </cfquery>
    <cfelse>
      <cfquery username="#db_username#" password="#db_password#" name="chkUser" datasource="#DATASOURCE#">
          SELECT user_id
            FROM users
           WHERE nickname = '#Trim(Form.user_id)#'
      </cfquery>
    </cfif>
    
    <cfif chkUser.RecordCount>
      <cfset savToUserId = chkUser.user_id>
      <cfset chkUserID = "TRUE">
    <cfelse>
      <cfthrow>
    </cfif>
    
    <cfcatch>
      <cfset savToUserId = "">
      <cfset chkUserID = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- chk Self --->
  <cfif savUserId IS savToUserId AND savUserId IS NOT "" AND savToUserId IS NOT "">
    <cfset chkSelf = "TRUE">
  </cfif>
  
  <!--- chk Itemnum if present --->
  <cftry>
    <cfif Len(Trim(Form.itemnum))>
<!---
<cfinclude template="../event2/event.cfm">
--->
      <cfquery username="#db_username#" password="#db_password#" name="getItemnum" datasource="#DATASOURCE#">
          SELECT COUNT(itemnum) AS found
            FROM items
           WHERE itemnum = (
		   SELECT itemnum
		   FROM items
		   WHERE status = 0
		   AND itemnum = #Trim(REReplace(Form.itemnum, "[^0123456789]", "", "ALL"))#)


      </cfquery>
      




  <cfquery username="#db_username#" password="#db_password#" name="HighestBid" datasource="#DATASOURCE#">
              SELECT MAX(bid) AS price
                FROM bids
               WHERE itemnum = #Trim(REReplace(Form.itemnum, "[^0123456789]", "", "ALL"))#
			   AND buynow = 0 
          </cfquery>
		  
		  <!--- get lowest bid --->
          <cfquery username="#db_username#" password="#db_password#" name="LowestBid" datasource="#DATASOURCE#">
              SELECT MIN(bid) AS price
                FROM bids
               WHERE itemnum = #Trim(REReplace(Form.itemnum, "[^0123456789]", "", "ALL"))#
          </cfquery>
          


<cftry>
          <cfquery username="#db_username#" password="#db_password#" name="getseller" datasource="#DATASOURCE#">
              SELECT user_id
                FROM items
               WHERE itemnum = #Trim(REReplace(Form.itemnum, "[^0123456789]", "", "ALL"))#
               AND user_id=#chklogin.user_id#
          </cfquery>


  <cfquery name="getBidder" datasource="#DATASOURCE#">
    select B.user_id,U.user_id,U.nickname
	from bids B,users U
	where B.bid =  <cfif #highestbid.recordcount# neq 0 and #highestbid.price#  neq ""  >#HighestBid.price#<cfelseif #lowestbid.recordcount# neq 0 and #lowestbid.price#  neq "">#lowestbid.price#</cfif>
	and   B.itemnum = #Trim(REReplace(Form.itemnum, "[^0123456789]", "", "ALL"))#
and B.user_id=#chkLogin.user_id#

  </cfquery>
<cfcatch>
</cfcatch>
</cftry> 




      <cfif getItemnum.found and #getbidder.recordcount# or #getseller.recordcount#>
        <cfset savItemnum = Trim(REReplace(Form.itemnum, "[^0123456789]", "", "ALL"))>
        <cfset chkItemnum = "TRUE">
      <cfelse>
        <cfset savItemnum = 0>
        <cfset chkItemnum = "FALSE">
      </cfif>
    <cfelse>
      <cfset savItemnum = 0>
	  <!--- set chkItemnum to False to require Item number entry on form ---->
      <cfset chkItemnum = "FALSE">
    </cfif>
    
    <cfcatch>
      <cfset savItemnum = 0>
      <cfset chkItemnum = "FALSE">
    </cfcatch>
  </cftry>
  
  <!--- chk Tone --->
  <cfif Form.tone IS "positive" OR Form.tone IS "neutral" OR Form.tone IS "negative">
    <cfif Form.tone IS "positive">
      <cfset savTone = 1>
    <cfelseif Form.tone IS "neutral">
      <cfset savTone = 0>
    <cfelseif Form.tone IS "negative">
      <cfset savTone = -1>
    <cfelse>
      <cfset savTone = 0>
      <cfset chkTone = "FALSE">
    </cfif>
    <cfset chkTone = "TRUE">
  <cfelse>
    <cfset savTone = 0>
    <cfset chkTone = "FALSE">
  </cfif>
  
  <!--- chk Comment --->
  <cfif not Len(Trim(Form.comment))>
    <cfset savComment = "">
    <cfset chkComment = "FALSE">
  <cfelse>
    <cfset savComment = Trim(Form.comment)>
    <cfset chkComment = "TRUE">
  </cfif>
  
  <!--- define sucessful submit --->
  <cfif not chkNickname OR not chkPassword OR not chkUserId OR not chkItemnum OR not chkTone OR not chkComment OR chkSelf or chkSecond>
    <cfset chkSubmit = "FALSE">
  </cfif>
  
  <!--- if item checks out, submit to db --->
  <cfif chkSubmit>
    
    <!--- define values --->
    <cfset savDate_placed = TIMENOW>
    <cfset savRemote_ip = CGI.REMOTE_ADDR>
      <cfif not Len(Trim(savRemote_ip))>
        <cfset savRemote_ip = "n/a">
      </cfif>
    
    <cftry>
      <!--- determine if feedback already exists --->
      <cfquery username="#db_username#" password="#db_password#" name="getPrevious" datasource="#DATASOURCE#">
          SELECT COUNT(user_id) AS found
            FROM feedback
           WHERE user_id = #savToUserId#
             AND user_id_from = #savUserId#
			 AND itemnum = #savItemnum#
      </cfquery>
      
      <!--- if previous, update.. else insert --->
      <cfif #getPrevious.found# eq 0>
        <cfquery username="#db_username#" password="#db_password#" name="insFeedback" datasource="#DATASOURCE#">
            INSERT INTO feedback
              (user_id, user_id_from, date_placed, rating, comment, itemnum, remote_ip)
            VALUES
              (#savToUserId#, #savUserId#, #savDate_placed#, #savTone#, '#savComment#', #savItemnum#, '#savRemote_ip#')
        </cfquery>
      

        <cfquery username="#db_username#" password="#db_password#" name="updFeedback" datasource="#DATASOURCE#">


update items set feedback_left=1 where itemnum=#saveItemnum#
</cfquery>
<!---
        <cfquery username="#db_username#" password="#db_password#" name="updFeedback" datasource="#DATASOURCE#">
            UPDATE feedback
               SET date_placed = #savDate_placed#,
                   rating = #savTone#,
                   comment = '#savComment#',
                   itemnum = #savItemnum#,
                   remote_ip = '#savRemote_ip#'
             WHERE user_id = #savToUserId#
               AND user_id_from = #savUserId#
			   AND itemnum = #savItemnum#
        </cfquery>
--->
      <cfelse>
        <cfset chksubmit = "FALSE">
        <cfset IsGoodSubmit = "FALSE">
        <cfset chkSecond = "TRUE">
</cfif>
      
      <!--- log feedback --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"
        description="Feedback Left (On User: #savToUserId#)"
        itemnum="#savItemnum#"
        details="TONE: #savTone#     COMMENT: #savComment#"
        user_id="#savUserId#">
      
      <cfset IsGoodSubmit = "TRUE">
      
      <cfcatch>
        <cfset IsGoodSubmit = "FALSE">
      </cfcatch>
    </cftry>
  </cfif>
</cfif>

<!--- get SSL on/off --->
<cftry>
  <cfquery username="#db_username#" password="#db_password#" name="SSL" datasource="#DATASOURCE#">
      SELECT pair AS enable_ssl
        FROM defaults
       WHERE name = 'enable_ssl'
  </cfquery>
  
  <cfset sslOn = SSL.enable_ssl>
  
  <cfcatch>
    <cfset sslOn = "FALSE">
  </cfcatch>
</cftry>

<!--- output page --->
<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>User Feedback</title>
    
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
  <cfinclude template="../includes/menu_bar.cfm">
  <form name="addFeedback" action="leavefeedback.cfm" method="POST">

  <div align="center">

  <table border=0 cellspacing=0 cellpadding=2 width=800>
   
        <tr>
          <td><br>
            <font size=4>
              <b>Leave Feedback for a User</b>
            </font>
            <hr size=1 color="616362"><br>


            <cfif not chkSubmit>
              <cfif chkSelf>
                <cfoutput>#hlightStart#<b>INVALID:</b> You may not place feedback about yourself.#hlightEnd#</cfoutput><br>
              <cfelseif chkSecond>

                <cfoutput><font color=red size=2><b>INVALID:</b> You already left a feedback to this user.</font></cfoutput><br>
              <cfelse>

                <cfoutput>#hlightStart#<b>INCOMPLETE:</b> Please verify that the highlighted items are correct.#hlightEnd#</cfoutput><br>
              </cfif>
              <br>
            </cfif>
          </td>
        </tr>
      </table>
      <!--- display completed submit message, else form --->
      <cfif IsDefined("Variables.IsGoodSubmit")>
        <cfsetting enablecfoutputonly="Yes">
        
        <cftry>
          <cfquery username="#db_username#" password="#db_password#" name="getBgcolor" datasource="#DATASOURCE#">
              SELECT pair AS listing_bgcolor
                FROM defaults
               WHERE name = 'listing_bgcolor'
          </cfquery>
          
          <cfset tempBgcolor = getBgcolor.listing_bgcolor>
          
          <cfcatch>
            <cfset tempBgcolor = "d3d3d3">
          </cfcatch>
        </cftry>
        
        <cfsetting enablecfoutputonly="No">

<cfif chksubmit>
        <cfmodule template="submitcomplete.cfm"
          success="#Variables.IsGoodSubmit#"
          bgcolor="#tempBgcolor#"
          userFrom="#Trim(Form.nickname)#"
          userTo="#Trim(Form.user_id)#"
          datePlaced="#savDate_placed#"
          itemNumber="#savItemnum#"
          tone="#savTone#"
          comment="#savComment#"
          VAROOT="#VAROOT#">

<cfelse>

</cfif>
      <cfelse>
        <cfoutput>
        <table border=0 cellspacing=2 cellpadding=0 noshade width=800>
          <tr>
            <td>
              <font size=2>
                <cfif not Variables.chkNickname>#hlightStart#</cfif><b>Your User ID</b><cfif not Variables.chkNickname>#hlightEnd#</cfif> or <cfif not Variables.chkNickname>#hlightStart#</cfif><b>Username</b><cfif not Variables.chkNickname>#hlightEnd#</cfif><br>
              </font>
              <input type=text name="nickname" value="#Variables.nickname#" size=20>
            </td>
            <td>
              <font size=2>
                <cfif not Variables.chkPassword OR not Variables.chkSubmit>#hlightStart#</cfif><b>Your password</b><cfif not Variables.chkPassword OR not Variables.chkSubmit>#hlightEnd#</cfif><br>
              </font>
              <input type=password name="password" value="<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">#session.password#</cfif>" size=20>
            </td>
          </tr>
          <tr>
            <td>
              <font size=2>
                <cfif not Variables.chkUserID>#hlightStart#</cfif><b>User ID<cfif not Variables.chkUserID>#hlightEnd#</cfif></b> or <cfif not Variables.chkUserID>#hlightStart#</cfif><b>Username</b><cfif not Variables.chkUserID>#hlightEnd#</cfif> of person you're writing about<br>
              </font>
              <input type=text name="user_id" value="#Variables.user_id#" size=20>
            </td>
            <td>
              <font size=2>
                <cfif not Variables.chkItemnum>#hlightStart#</cfif><b>Item number</b><cfif not Variables.chkItemnum>#hlightEnd#</cfif> (<B>required</B>, to relate comment to a transaction)<br>
              </font>
              <input type=text name="itemnum" value="#Variables.itemnum#" size=20>
            </td>
          </tr>
        </table>
        </cfoutput>
        <br>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
          <tr>
            <td width=330 valign=top>
              <cfoutput><cfif not Variables.chkTone>#hlightStart#</cfif><b>Tone of your comment:</b><cfif not Variables.chkTone>#hlightEnd#</cfif><br></cfoutput>
              <br>
              <input type=radio name="tone" value="positive"<cfif Variables.tone IS "positive"> checked</cfif>> Positive<br>
              <input type=radio name="tone" value="neutral"<cfif Variables.tone IS "neutral"> checked</cfif>> Neutral<br>
              <input type=radio name="tone" value="negative"<cfif Variables.tone IS "negative"> checked</cfif>> Negative<br>
            </td>
            
        <td width=385> 
          <div align="left">
            <table border=0 cellspacing=0 cellpadding=2 noshade width=377 height="146">
              <tr bgcolor="616362"> 
                <td align=center bgcolor="616362"> 
                  <div align="center"><font color="000000" face="Arial" size=2> 
                    <b><font size="3">You are responsible for your own words. 
                    </font></b></font> </div>
                </td>
              </tr>
              <tr bgcolor="gray"> 
                <td bgcolor="gray"> 
                  <div align="left" style="margin: 5px 5px 5px 5px;"><font size=2 color="ffffff"> Your comment will include your 
                    user name and the date which you left your remark. We cannot 
                    take responsibility for the comments you post here, and you 
                    should be careful about making comments that could be libelous 
                    or slanderous. To be safe, make only factual, emotionless 
                    comments. Contact your attorney if you have any doubts. Please 
                    try to resolve any disputes with the other party before publically 
                    declaring a complaint. </font> </div>
                </td>
              </tr>
            </table>
          </div>
        </td>
          </tr>
        </table>
        <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
          <tr>
            <td><br>
              <cfoutput><cfif not Variables.chkComment>#hlightStart#</cfif><b>Your comment</b><cfif not Variables.chkComment>#hlightEnd#</cfif> (80 characters max.)<br>
              <input type=text name="comment" value="#Variables.comment#" size=75 maxlength=80><br></cfoutput>
              <br>
              <font size=2>
                <b>NOTE: </b>Only successful buyers and sellers of this item may leave feedback. Each new feedback must be referenced to a seperate item number.  If you have already 
                left feedback in reference to this <i>item number</i> you can <a href="<cfoutput>#VAROOT#</cfoutput>/">exit</a> 
                the feedback section here.<br>
              </font>
              <br>
              <!--- SSL Link --->
              <cfif Variables.sslOn>
                <cfoutput><a href="https://#CGI.SERVER_NAME##VAROOT#/feedback/leavefeedback.cfm"><b>Use Secure Sockets Layer</b></a><br></cfoutput>
                <br>
              </cfif>
              <input type=submit name="leave_comment" value="Leave Comment"> 
              <input type="button" name="back" value=" << Back " onClick="JavaScript:history.back(1)"><br><br>
              
              <b>Resolving disputes before leaving negative feedback.</b><br>
              As the old saying goes... once you've said something you can't take it back. Once a negative comment 
              has been posted, the damage has already been 
              done. For this reason we encourage all members to contact the person in question 
              directly before leaving negative feedback about them.
            </td>
          </tr>
        </table>
      </cfif></form>
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
