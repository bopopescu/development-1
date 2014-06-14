<cfinclude template = "../includes/app_globals.cfm">
<cfinclude template="../includes/session_include.cfm">
<cfquery username="#db_username#" password="#db_password#" name="GetCurrency" datasource="#DATASOURCE#">
  SELECT pair AS theCurrency
  FROM defaults
  WHERE name = 'site_currency'
</cfquery>
<cfset theCurrency=#GetCurrency.theCurrency#>

<html>
  <Head>
    <title>Currency Converter</title>
    
  </head>
  <body>
<!---  <body onBlur='window.focus()'>--->


	<cfif #isDefined('b')#>
		<cfif #b# NEQ #c#>
      <cfhttp URL="http://blacktusk.commerce.ubc.ca/cgi-bin/fxdata?b=#form.b#&c=#form.c#&rd=1&f=csv">
      <!---  <cfoutput>#ListLen(CFHTTP.FileContent)#</cfoutput> 
 --->

      <!--- def vals --->
      <cfset iCurPos = 1>
      <cfset iEndPos = 1>
      <cfset iLinesFound = 0>
      <cfset sLine1 = "">
      <cfset sLine2 = "">
      <cfset sLine3 = "">
      <cfset sLine4 = "">
      <cfset sService = "">
      <cfset sDate = "">
      <cfset sStartCurrency = "">
      <cfset sEndCurrency = "">
      <cfset fRate = 0.00>
	<cfset ListLen	= #ListLen(CFHTTP.FileContent)#>
      <cfset jump = 0>
      
      <cfloop index="i" from="1" to="#Len(CFHTTP.FileContent)#">
<!--- <cfif jump is 1>
<cfbreak>
</CFIF> --->
        <!--- strip line 1 --->
      <cfif Variables.iLinesFound lt 1> 
	    <!---  <cfif Len(CFHTTP.FileContent) lt 3>--->
          <cfset iCurPos = REFind("^PACIFIC", CFHTTP.FileContent, Variables.iCurPos)>
         <!---  <cfif iCurPos IS 0> --->
		 <cfif iCurPos IS 0>
            <cfset theFigure = "#theCurrency# #session.Item_price#">
            <cfset theMsg="<img src='flags_strip.gif' width=334 height=22 border=0><br><br>
            <br><br><br><br><center><FONT face=Arial,Helvetica COLOR=##004C00>Sorry! This 
	  			  currency is not available<br>at this time. Please try later.</center></font>">	
            <cfset jump=1>
            <cfbreak>
          </cfif>
          <cfset iEndPos = REFind("#Chr(34)#YYYY", CFHTTP.FileContent, Variables.iCurPos) - Variables.iCurPos>
          <cfset sLine1 = Trim(Mid(CFHTTP.FileContent, Variables.iCurPos, Variables.iEndPos))>
          <cfset iCurPos = Variables.iEndPos - 1>
          <cfset iLinesFound = iLinesFound + 1>

        <!--- strip line 2 --->
        <cfelseif Variables.iLinesFound IS 1>
          <cfset iCurPos = REFind("#Chr(34)#YYYY", CFHTTP.FileContent, Variables.iCurPos)>
          <cfset iEndPos = REFind("#Chr(34)#[a-zA-z]{3,3}/", CFHTTP.FileContent, Variables.iCurPos) - Variables.iCurPos>
          <cfset sLine2 = Trim(Mid(CFHTTP.FileContent, Variables.iCurPos, Variables.iEndPos))>
          <cfset iCurPos = Variables.iEndPos>
          <cfset iLinesFound = iLinesFound + 1>

        <!--- strip line 3 --->
        <cfelseif Variables.iLinesFound IS 2>
          <cfset iCurPos = REFind(".#Chr(34)#[a-zA-z]{3,3}/", CFHTTP.FileContent, Variables.iCurPos)>
          <cfset iEndPos = REFind("#Chr(34)#\(C", CFHTTP.FileContent, Variables.iCurPos) - Variables.iCurPos>
          <cfset sLine3 = Trim(Mid(CFHTTP.FileContent, Variables.iCurPos, Variables.iEndPos))>
          <cfset iCurPos = Variables.iEndPos>
          <cfset iLinesFound = iLinesFound + 1>

        <!--- strip line 4 --->
        <cfelseif Variables.iLinesFound IS 3>
          <cfset iCurPos = REFind("#Chr(34)#\(C", CFHTTP.FileContent, Variables.iCurPos)>
          <cfset iEndPos = REFind("#Chr(34)#", CFHTTP.FileContent, Evaluate(Variables.iCurPos + 1)) - Variables.iCurPos + 1>
          <cfset sLine4 = Trim(Mid(CFHTTP.FileContent, Variables.iCurPos, Variables.iEndPos))>
          <cfset iCurPos = Variables.iEndPos>
          <cfset iLinesFound = iLinesFound + 1>
          <cfbreak>
        </cfif>
      </cfloop>

      <cfif jump NEQ 1>
	  
        <!--- redef vals --->
        <cfset sService = Variables.sLine1>
		 <cfif ListLen LT 3>
        	<cfset temp = "">
			 <cfset fRate = 0>
		<cfelse>
		<cfset temp = ListGetAt(Variables.sLine2, "2", ",")>
		<cfset fRate = ListGetAt(Variables.sLine3, "2", ",")>
		</cfif>
        <cfset sDate = DateFormat(Replace(temp,"""", "", "ALL"),"mm/dd/yyyy")>
        <cfset temp = ListGetAt(Variables.sLine3, "1", ",")>
        <cfset temp = Replace(temp, """", "", "ALL")>
        <cfset sStartCurrency = ListGetAt(temp, "1", "/")>
        <cfset sEndCurrency = ListGetAt(temp, "2", "/")>
		<cfset base_price = session.Item_price>
        <cfset session.Item_price = replace(session.Item_price,",","")>
	  		<cfset target_price = #numberformat (evaluate(session.Item_price * fRate),numbermask)#>
		  	<cfset theFigure = "#sStartCurrency# #numberformat(evaluate(session.Item_price * fRate),numbermask)#">
        <cfmodule template="cf_currencies.cfm" mode="CODECONVERT" code=#sStartCurrency# return="SourceCur">
        <cfmodule template="cf_currencies.cfm" mode="CODECONVERT" code=#sEndCurrency#   return="TargetCur">    
<cfif ListLen LT 3>
<!--- If no exchange rate info  --->
            <cfset theFigure = "#theCurrency# #session.Item_price#">
            <cfset theMsg="<img src='flags_strip.gif' width=334 height=22 border=0><br><br>
            <br><br><br><br><center><FONT face=Arial,Helvetica COLOR=##004C00>Sorry! This 
	  			  currency is not available<br>at this time. Please try later.</center></font>">	
            
			<cfelse>
			 <cfset theMsg="<img src='flags_strip.gif' width=334 height=22 border=0><center><FONT 
        face=Arial,Helvetica COLOR=##004C00 size=-1>#base_price# #TargetCur#s = #target_price# #SourceCur#s<br>
        Rate #fRate# on #sDate#</font></center></font><FONT 
        face=Arial,Helvetica COLOR=##004C00 size=-2>IMPORTANT : Exchange rates change from day 
        to day and banks use different rates when converting to or from your local currency. 
        Credit card companies also may add a percentage to the market rate. The calculator uses 
        rates which are updated daily and uses the same rate for conversions both to and from 
        each currency. The results given by the converter are only intended to be indicative 
        and can easily be several percentage points different from the rate actually used to 
        charge your card account. If you are purchasing a high priced item where the exchange 
        rate difference could be significant please check the current rates using a site which 
        is updated frequently such as The New York Federal Reserve Bank (http://www.ny.frb.orghttp://www.ny.frb.org). 
        You may also want to check the exact conversion rules with your bank."></font>	
</cfif>
      </cfif><!--- jump NEQ 1 --->

    <cfelse>
      <cfset session.Item_price = replace(session.Item_price,",","")>
			<cfset theFigure = "#theCurrency# #session.Item_price#">
			<cfset theMsg="<img src='flags_strip.gif' width=334 height=22 border=0><br><br>
			<br><br><br><br><center><FONT face=Arial,Helvetica COLOR=##004C00>Sorry! The Home 
			Currency must be<br>different from the Auction Currency.<br>Please try again.</center></font>">	
		</cfif>


  <cfelse>
    <cfset session.Item_price=#bid_currently#>
    <cfset session.Item_price = replace(session.Item_price,",","")> 
		<cfset theMsg="<img src='flags_strip.gif' width=334 height=22 border=0><br><br>
		<br><br><br><br><center><FONT face=Arial,Helvetica COLOR=##004C00>How much is it 
		in your<br>home currency?</center></font>">
		<cfset theFigure = "#theCurrency# #session.Item_price#">
	</cfif>

  <form name="theForm" action="w_currency1.cfm" method="post">

  <input type="hidden" name="b" value=<cfoutput>#theCurrency#</cfoutput>>

  <table cellpadding=0 cellspacing=0 border=1 width=334>
  <tr>
	  <td valign=top><cfoutput>
		  <table cellpadding=3 cellspacing=0 border=0 bgcolor=##FFFFD0 height=246 width=100%>
		  </cfoutput>
		  	<tr>
			    <TD valign=top>
  					<cfoutput>#theMsg#</cfoutput>
  				</td>
	  		</tr>
		  </table>

      <table cellpadding=0 cellspacing=0 border=0 BGCOLOR=#FFFFD0>
      <!--- this table contains the bottom table of three cells --->
      <tr><td>
      <TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 BGCOLOR=#FFFFD0>      
         <TR>
           <TD width=350 valign=center align=center>
             <font face="Arial,Helvetica" size=3><b><cfoutput>#theFigure#</cfoutput></b></font>
           </td>
           <TD align=right><FONT FACE="Arial,Helvetica" size=-1>

<select name="c" onChange="submit()">
<option value="">Convert to your Currency
<option value="USD">U.S. Dollars
<option value="CAD">Canadian Dollars
<option value="EUR">European Euros
<option value="FRF">French Francs
<option value="DEM">German Marks
<option value="ITL">Italian Lira
<option value="JPY">Japanese Yen
<option value="ESP">Spanish Pesetas
<option value="AUD">Australian Dollars
<option value="CHF">Swiss Francs
<option value="ATS">Austrian Schillings
<option value="BEF">Belgian Francs
<option value="GBP">British Pounds
<option value="DZD">Algerian Dinars
<option value="ARP">Argentinian Pesos
<option value="DKK">Danish Kroner
<option value="NLG">Dutch Guilders
<option value="RUR">Russian Rubles
<option value="BSD">Bahamian Dollars
<option value="BHD">Bahraini Dinars
<option value="BBD">Barbados Dollars
<option value="BRR">Brazilian Reals
<option value="BGL">Bulgarian Lev
<option value="CLP">Chilean Pesos
<option value="CNY">Chinese Renminbi
<option value="COP">Colombian Peso
<option value="CYP">Cyprus Pound
<option value="CZK">Czech Koruna
<option value="XCD">East Caribbean Dollars
<option value="ECS">Ecuadoran Sucre
<option value="EGP">Egyptian Pounds
<option value="FIM">Finnish Markka
<option value="GRD">Greek Drachmas
<option value="HKD">Hong Kong Dollars
<option value="HUF">Hungarian Forint
<option value="ISK">Icelandic Krona
<option value="INR">Indian Rupees
<option value="IDR">Indonesian Rupiah
<option value="IRR">Iranian Rial
<option value="IQD">Iraqui Dinar
<option value="IEP">Irish Punt
<option value="ILS">Israeli New Shekels
<option value="JMD">Jamaican Dollars
<option value="JOD">Jordanian Dinars
<option value="KZT">Kazach Tenge
<option value="KWD">Kuwaiti Dinars
<option value="LBP">Lebanese Pound
<option value="MYR">Malaysian Ringgit
<option value="MTL">Maltese Lira
<option value="MXP">Mexican Pesos
<option value="NPR">Nepal Rupee
<option value="NZD">New Zealand Dollars
<option value="OMR">Omani Riyal
<option value="NOK">Norwegian Kroner
<option value="PKR">Pakistani Rupees
<option value="PEN">Peruvian New Soles
<option value="PHP">Philippines Pesos
<option value="PLZ">Polish Zloty
<option value="PTE">Portuguese Escudo
<option value="QAR">Qatari Riyal
<option value="ROL">Romanian Lev
<option value="SAR">Saudi Arabian Riyal
<option value="XDR">Special Drawing Rights
<option value="SGD">Singapore Dollars
<option value="SKK">Slovakian Koruna
<option value="ZAR">South African Rand
<option value="KRW">South Korean Won
<option value="LKR">Srilankan Rupee
<option value="SDD">Sudanese Dinars
<option value="SEK">Swedish Krona
<option value="TWD">Taiwan Dollars
<option value="THB">Thai Baht
<option value="TTD">Trinidad+Tobago Dollar
<option value="TRL">Turkish Lira
<option value="UAH">Ukrainean Hryvna
<option value="AED">United Arab Emirates Dirham
<option value="UYU">Uruguayan Peso
<option value="VEB">Venezuelan Bolivar
<option value="ZMK">Zambian Kwacha
</SELECT></FONT></TD>

</TR>
</TABLE>

</td></tr>
</table>

</td></tr>
</table>
</form>
</body>
</html>

