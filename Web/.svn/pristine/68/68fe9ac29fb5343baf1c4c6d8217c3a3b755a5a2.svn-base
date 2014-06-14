<!---
  submitcomplete.cfm
  
  displays completed feedback submit information...
  successful/unsuccessful...  etc...
  
  <cfmodule template="submitcomplete.cfm"
    success="[BOOLEAN]"
    bgcolor="[listing_bgcolor]"
    userFrom="[user nickname]"
    userTo="[user nickname]"
    datePlaced="[date placed]"
    itemNumber="[item number]"
    tone="[-1|0|1]"
    comment="[user comment]"
    VAROOT="[global var VAROOT]">
    
--->
<cfsetting enablecfoutputonly="Yes">

<!--- def vals --->
<cfparam name="Attributes.VAROOT" default="">

<!--- chk required params --->
<cfloop index="l" list="success,bgcolor,userFrom,userTo,datePlaced,itemNumber,tone,comment">
  <cfif not IsDefined("Attributes." & l)>
    
    <cfoutput>
      <b>ERROR:</b> Missing #l# attribute of "submitcomplete".<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- set success = false if not boolean --->
<cfif not IsBoolean(Attributes.success)>
  <cfset success = "FALSE">
<cfelse>
  <cfset success = Attributes.success>
</cfif>

<!--- output submit message --->
<cfsetting enablecfoutputonly="No">

<cfif Variables.success>
  <cfsetting enablecfoutputonly="Yes">
  
  <!--- define item display --->
  <cfif IsNumeric(Attributes.itemNumber) AND Attributes.itemNumber IS NOT 0>
    <cfset itemDisplay = "<b>Item:</b> " & Attributes.itemNumber>
  <cfelse>
    <cfset itemDisplay = "&nbsp;">
  </cfif>
  
  <!--- defined comment type --->
  <cfif Attributes.tone IS -1>
    <cfset comType = "<b>Negative:</b>">
  <cfelseif Attributes.tone IS 1>
    <cfset comType = "<b>Positive:</b>">
  <cfelse>
    <cfset comType = "<b>Neutral:</b>">
  </cfif>
  
  <cfsetting enablecfoutputonly="No">
  <cfoutput>
  <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
    <tr>
      <td>
        Feedback submited successfully...<br>
        <br>
        Thank you for leaving your comments about our users.  We hope your stay here is 
        an enjoyable one.  The following message will now be displayed in "#Attributes.userTo#'s" 
        feedback record.<br>
        <br>
      </td>
    </tr>
  </table>
  <table border=0 cellspacing=0 cellpadding=2 noshade width=640>
    <tr bgcolor="#Attributes.bgcolor#">
      <td width=240><b>User:</b> #Attributes.userFrom#</td>
      <td width=240><b>Date:</b> #DateFormat(Attributes.datePlaced, "mm/dd/yyyy")# #TimeFormat(Attributes.datePlaced, "HH:mm:ss")#</td>
      <td width=160>#itemDisplay#</td>
    </tr>
    <tr>
      <td colspan=3><b>#comType#</b> #Trim(Attributes.comment)#</td>
    </tr>
  </table>
  </cfoutput>
  <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
    <tr>
      <td>
        <br>
        <a href="<cfoutput>#Attributes.VAROOT#</cfoutput>/feedback/leavefeedback.cfm"><b>Leave Another Message</b></a><br>
        <br>
      </td>
    </tr>
  </table>
  <br>
<cfelse>

<!---
  <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
    <tr>
      <td>
        Submit unsuccessful...<br>
        <br>
        For some undetermined reason we were unable to except this feedback at this 
        time.  You may try changing the attributes of your comment and then resubmitting 
        it.  This may resolve any unforeseen problems.<br>
        <br>
        <a href="<cfoutput>#Attributes.VAROOT#</cfoutput>/feedback/leavefeedback.cfm"><b>Leave Another Message</b></a><br>
      </td>
    </tr>
  </table>

--->
<cfsetting enablecfoutputonly="Yes">
  
  <!--- define item display --->
  <cfif IsNumeric(Attributes.itemNumber) AND Attributes.itemNumber IS NOT 0>
    <cfset itemDisplay = "<b>Item:</b> " & Attributes.itemNumber>
  <cfelse>
    <cfset itemDisplay = "&nbsp;">
  </cfif>
  
  <!--- defined comment type --->
  <cfif Attributes.tone IS -1>
    <cfset comType = "<b>Negative:</b>">
  <cfelseif Attributes.tone IS 1>
    <cfset comType = "<b>Positive:</b>">
  <cfelse>
    <cfset comType = "<b>Neutral:</b>">
  </cfif>
  
  <cfsetting enablecfoutputonly="No">
  <cfoutput>
  <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
    <tr>
      <td>
        Feedback submited successfully...<br>
        <br>
        Thank you for leaving your comments about our users.  We hope your stay here is 
        an enjoyable one.  The following message will now be displayed in "#Attributes.userTo#'s" 
        feedback record.<br>
        <br>
      </td>
    </tr>
  </table>
  <table border=0 cellspacing=0 cellpadding=2 noshade width=640>
    <tr bgcolor="#Attributes.bgcolor#">
      <td width=240><b>User:</b> #Attributes.userFrom#</td>
      <td width=240><b>Date:</b> #DateFormat(Attributes.datePlaced, "mm/dd/yyyy")# #TimeFormat(Attributes.datePlaced, "HH:mm:ss")#</td>
      <td width=160>#itemDisplay#</td>
    </tr>
    <tr>
      <td colspan=3><b>#comType#</b> #Trim(Attributes.comment)#</td>
    </tr>
  </table>
  </cfoutput>
  <table border=0 cellspacing=0 cellpadding=0 noshade width=640>
    <tr>
      <td>
        <br>
        <a href="<cfoutput>#Attributes.VAROOT#</cfoutput>/feedback/leavefeedback.cfm"><b>Leave Another Message</b></a><br>
        <br>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <br>
  <br>
</cfif>
