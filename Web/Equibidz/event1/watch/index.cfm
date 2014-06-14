<!---
  index.cfm
  
  future watch..
  main script..
  sends email to all those on future watch..
  
  Author: John Adams
  
--->

<!--- def values --->
<cfset iDefLastUser = 0>
<cfset iLastUser = iDefLastUser>
<cfset iRecsToReturn = 1>
<cfset iRecsDenominator = 6>
<cfset sFlagName = "e_futurewatch">
<cfset sSearchString = "">
<cfset aSearchResults = ArrayNew(2)>

<!--- get flag --->
<cfquery username="#db_username#" password="#db_password#" name="chkFlag" datasource="#DATASOURCE#">
    SELECT pair AS e_futurewatch
      FROM defaults
     WHERE name = '#sFlagName#'
</cfquery>

<!--- if exist chk --->
<cfif chkFlag.RecordCount>
  
  <!--- if flag no val, don't use --->
  <cfif not Len(Trim(chkFlag.e_futurewatch))>
    
    <cfset iLastUser = iDefLastUser>
    
  <!--- if flag not numeric, don't use --->
  <cfelseif not IsNumeric(Trim(chkFlag.e_futurewatch))>
    
    <cfset iLastUser = iDefLastUser>
    
  <!--- set last user val --->
  <cfelse>
    <cfset iLastUser = Trim(chkFlag.e_futurewatch)>
  </cfif>
  
  <cfoutput>
    &lt;!-- debug >> Last Future Watch Account: #iLastUser# --&gt;<br><br>
  </cfoutput>
  
<!--- else create flag --->
<cfelse>
  
  <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
      INSERT INTO defaults
        (name, pair)
      VALUES
        ('#sFlagName#', '#iDefLastUser#')
  </cfquery>
  
  <cfoutput>
    &lt;!-- debug >> Creating Future Watch flag --&gt;<br><br>
  </cfoutput>
  
  <!--- set last user val to def --->
  <cfset iLastUser = iDefLastUser>
</cfif>

<!--- cnt users enabled on future watch --->
<cfquery username="#db_username#" password="#db_password#" name="cntUsers" datasource="#DATASOURCE#">
    SELECT COUNT(user_id) AS found
      FROM futurewatch
     WHERE enabled = 1
</cfquery>

<!--- if no users stop --->
<cfif not cntUsers.found>
  
  <cfoutput>
    &lt;!-- debug >> No Enabled Future Watch Users: aborting future watch --&gt;<br><br>
  </cfoutput>
  
<!--- else continue --->
<cfelse>
  
  <!--- set num of recs to return --->
  <cfset iRecsToReturn = Ceiling(cntUsers.found / iRecsDenominator)>
  
  <cfoutput>
    &lt;!-- debug >> Enabled Future Watch Users: #iRecsToReturn# --&gt;<br><br>
  </cfoutput>
  
  <!--- get users on futurewatch GT id num --->
  <cfquery username="#db_username#" password="#db_password#" name="getUsers" datasource="#DATASOURCE#" maxrows="#iRecsToReturn#">
      SELECT F.user_id, F.keywords, F.last_sent, U.email, U.nickname
        FROM futurewatch F, users U
       WHERE F.enabled = 1
         AND F.user_id > #iLastUser#
         AND F.user_id = U.user_id
       ORDER BY F.user_id ASC
  </cfquery>
  
  <cfoutput>
    &lt;!-- debug >> Users Found: #getUsers.RecordCount# --&gt;<br><br>
  </cfoutput>
  
  <!--- loop over users --->
  <cfloop query="getUsers">

    <cfset sSearchString = ""><!--- one bug fixed. --->

    <cfif ListLen(getUsers.keywords, ",")>
      
      <cfoutput>
        &lt;!-- debug >> User's Keywords: "#getUsers.keywords#" --&gt;<br><br>
        &lt;!-- debug >> User's Last Sent: #getUsers.last_sent# --&gt;<br><br>
      </cfoutput>
      
      <!--- setup search string --->
      <cfloop index="i" from=1 to=#ListLen(getUsers.keywords, ",")#>
        
        <cfset temp1 = IIf(i IS 1, DE(" AND (title LIKE "), DE(" OR title LIKE "))>
        <cfset temp2 = IIf(i IS ListLen(getUsers.keywords, ","), DE(" ) "), DE(" "))>
        
        <cfset sTmpKeyword = Replace(Trim(ListGetAt(getUsers.keywords, i, ",")), "%", "%%", "ALL")>
        <cfset sTmpKeyword = Replace(sTmpKeyword, "'", "''", "ALL")>
        
        <cfset sSearchString = sSearchString &  "#temp1# '%#Variables.sTmpKeyword#%' OR description LIKE '%#Variables.sTmpKeyword#%' #temp2#">
      </cfloop>
      
      <cfoutput>
        &lt;!-- debug >> search string built --&gt;<br><br>
        &lt;!-- debug >> search string: #sSearchString# --&gt;<br><br>
      </cfoutput>
      
      <!--- search auctions --->
      <cfquery username="#db_username#" password="#db_password#" name="chkAuctions" datasource="#DATASOURCE#">
          SELECT title, itemnum
            FROM items
           WHERE user_id <> #getUsers.user_id#
             AND status = 1
             AND date_end > #TIMENOW#
             AND itemnum > #getUsers.last_sent#
                 #PreserveSingleQuotes(sSearchString)#
           ORDER BY itemnum DESC
      </cfquery>
      
      <cfoutput>
        &lt;!-- debug >> Records found: #chkAuctions.RecordCount# --&gt;<br><br>
      </cfoutput>
      
      <cfif chkAuctions.RecordCount>
        
        <!--- clear array --->
        <cfloop condition="not ArrayIsEmpty(aSearchResults)">
          
          <cfset temp = ArrayClear(aSearchResults)>
          
          <cfoutput>
            &lt;!-- debug >> Clearing search results array --&gt;<br><br>
          </cfoutput>
        </cfloop>
        
        <!--- load query info into array --->
        <cfloop query="chkAuctions">
          
          <cfset aSearchResults[chkAuctions.CurrentRow][1] = Trim(chkAuctions.title)>
          <cfset aSearchResults[chkAuctions.CurrentRow][2] = Trim(chkAuctions.itemnum)>
        </cfloop>
        
        <cfoutput>
          &lt;!-- debug >> Loaded query into array --&gt;<br><br>
        </cfoutput>
        
        <!--- send email --->
        <cfmodule template="eml_watch.cfm"
          to="#Trim(getUsers.email)#"
          from="#SERVICE_EMAIL##DOMAIN#"
          subject="New auctions of interest to you."
          aSearchResults="#aSearchResults#"
          userNickname="#Trim(getUsers.nickname)#"
          companyName="#COMPANY_NAME#">
          
        <cfoutput>
          &lt;!-- debug >> Sending future watch email to: <b>#Trim(getUsers.email)#</b> --&gt;<br><br>
        </cfoutput>
        
        <!--- update last item sent value --->
        <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
            UPDATE futurewatch
               SET last_sent = #chkAuctions.itemnum#
             WHERE user_id = #getUsers.user_id#
        </cfquery>
        
        <cfoutput>
          &lt;!-- debug >> Updating last sent value for user --&gt;<br><br>
        </cfoutput>
      </cfif>
    </cfif>
    
    <!--- set iLastUser to user --->
    <cfset iLastUser = getUsers.user_id>
  </cfloop>
  
  <!--- get highest user id num enabled on future watch --->
  <cfquery username="#db_username#" password="#db_password#" name="getHighestUser" datasource="#DATASOURCE#">
      SELECT MAX(user_id) AS id_num
        FROM futurewatch
       WHERE enabled = 1
  </cfquery>
  
  <!--- if iLastUser GTE highest user reset to iDefLastUser --->
  <cfif iLastUser GTE getHighestUser.id_num>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
        UPDATE defaults
           SET pair = '#iDefLastUser#'
         WHERE name = '#sFlagName#'
    </cfquery>
    
    <cfoutput>
      &lt;!-- debug >> Reset #sFlagName# to: #iDefLastUser# --&gt;<br><br>
    </cfoutput>
    
  <!--- else set to iLastUser --->
  <cfelse>
    
    <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
        UPDATE defaults
           SET pair = '#iLastUser#'
         WHERE name = '#sFlagName#'
    </cfquery>
    
    <cfoutput>
      &lt;!-- debug >> Set #sFlagName# to: #iLastUser# --&gt;<br><br>
    </cfoutput>
  </cfif>
</cfif>
