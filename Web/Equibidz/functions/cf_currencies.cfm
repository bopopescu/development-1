<!---
  cf_currencies.cfm
  
  function to output currency select box..
  or convert currency code to its name..
  
  <cfmodule template="cf_currencies.cfm"
    mode="[CODECONVERT|SELECTBOX]"
    [code="[currency code]"]
    [boxname="[name of box on form]"]
    [selected="[code|name of selected currency]"]
    [return="[variable to be returned]"]>
  
--->
<cfsetting enablecfoutputonly="Yes">

<!--- inc app_globals --->
<cfinclude template="../includes/app_globals.cfm">

<!--- def required params list --->
<cfif IsDefined("Attributes.mode")>
  <cfif Attributes.mode IS "CODECONVERT">
    <cfset reqParams = "mode,code,return">
  <cfelseif Attributes.mode IS "SELECTBOX">
    <cfset reqParams = "mode,boxname,selected">
  </cfif>
<cfelse>
  <cfset reqParams = "mode">
</cfif>

<!--- chk required params --->
<cfloop index="l" list="#Variables.reqParams#">
  <cfif not IsDefined("Attributes." & l)>
    <cflocation url="http://#CGI.SERVER_NAME##VAROOT#/includes/404notfound.cfm">
  </cfif>
</cfloop>

<!--- setup currency info --->
<cfscript>
  
  currencies = ArrayNew(2);
  
  currencies[1][1] = "Australian Dollar";            currencies[1][2] = "AUD";
  currencies[2][1] = "Austrian Schilling";           currencies[2][2] = "ATS";
  currencies[3][1] = "Bahraini Dinar";               currencies[3][2] = "BHD";
  currencies[4][1] = "Bangladesh Taka";              currencies[4][2] = "BDT";
  currencies[5][1] = "Belgian Franc";                currencies[5][2] = "BEF";
  currencies[6][1] = "Brazil Real";                  currencies[6][2] = "BRL";
  currencies[7][1] = "British Pound";                currencies[7][2] = "GBP";
  currencies[8][1] = "Canadian Dollar";              currencies[8][2] = "CAD";
  currencies[9][1] = "China Renminbi";               currencies[9][2] = "CNY";
  currencies[10][1] = "Colombian Peso";              currencies[10][2] = "COP";
  currencies[11][1] = "Cyprus Pound";                currencies[11][2] = "CYP";
  currencies[12][1] = "Danish Krone";                currencies[12][2] = "DKK";
  currencies[13][1] = "Dutch Guilder";               currencies[13][2] = "NLG";
  currencies[14][1] = "European Euro";               currencies[14][2] = "EUR";
  currencies[15][1] = "Finnish Markka";              currencies[15][2] = "FIM";
  currencies[16][1] = "French Franc";                currencies[16][2] = "FRF";
  currencies[17][1] = "German Mark";                 currencies[17][2] = "DEM";
  currencies[18][1] = "Greek Drachma";               currencies[18][2] = "GRD";
  currencies[19][1] = "Hong Kong Dollar";            currencies[19][2] = "HKD";
  currencies[20][1] = "Iceland Krona";               currencies[20][2] = "ISK";
  currencies[21][1] = "Indian Rupee";                currencies[21][2] = "INR";
  currencies[22][1] = "Iranian Rial";                currencies[22][2] = "IRR";
  currencies[23][1] = "Iraqi Dinar";                 currencies[23][2] = "IQD";
  currencies[24][1] = "Irish Punt";                  currencies[24][2] = "IEP";
  currencies[25][1] = "Italian Lira";                currencies[25][2] = "ITL";
  currencies[26][1] = "Japanese Yen";                currencies[26][2] = "JPY";
  currencies[27][1] = "Korean Won";                  currencies[27][2] = "KRW";
  currencies[28][1] = "Kuwaiti Dinar";               currencies[28][2] = "KWD";
  currencies[29][1] = "Malaysian Ringgit";           currencies[29][2] = "MYR";
  currencies[30][1] = "Maltese Lira";                currencies[30][2] = "MTL";
  currencies[31][1] = "Mexican Peso";                currencies[31][2] = "MXP";
  currencies[32][1] = "Nepal Rupee";                 currencies[32][2] = "NPR";
  currencies[33][1] = "New Zealand Dollar";          currencies[33][2] = "NZD";
  currencies[34][1] = "Norwegian Krone";             currencies[34][2] = "NOK";
  currencies[35][1] = "Omani Rial";                  currencies[35][2] = "OMR";
  currencies[36][1] = "Pakistani Rupee";             currencies[36][2] = "PKR";
  currencies[37][1] = "Portuguese Escudo";           currencies[37][2] = "PTE";
  currencies[38][1] = "Qatari Riyal";                currencies[38][2] = "QAR";
  currencies[39][1] = "Saudi Riyal";                 currencies[39][2] = "SAR";
  currencies[40][1] = "Singapore Dollar";            currencies[40][2] = "SGD";
  currencies[41][1] = "South African Rand";          currencies[41][2] = "ZAL";
  currencies[42][1] = "Spanish Peseta";              currencies[42][2] = "ESP";
  currencies[43][1] = "Sri Lankan Rupee";            currencies[43][2] = "LKR";
  currencies[44][1] = "Swedish Krona";               currencies[44][2] = "SEK";
  currencies[45][1] = "Swiss Franc";                 currencies[45][2] = "CHF";
  currencies[46][1] = "Taiwan dollar";               currencies[46][2] = "TWD";
  currencies[47][1] = "Thai Baht";                   currencies[47][2] = "THB";
  currencies[48][1] = "Trinidad & Tobago Dollar";    currencies[48][2] = "TTD";
  currencies[49][1] = "U.A.E. Dirham";               currencies[49][2] = "AED";
  currencies[50][1] = "U.S. Dollar";                 currencies[50][2] = "USD";
  currencies[51][1] = "Venezuelan Bolivar";          currencies[51][2] = "VEB";
  currencies[52][1] = "Algerian Dinar";              currencies[52][2] = "DZD";
  currencies[53][1] = "Argentinian Peso";            currencies[53][2] = "ARP";
  currencies[54][1] = "Bahamian Dollar";             currencies[54][2] = "BSD";
  currencies[55][1] = "Barbados Dollar";             currencies[55][2] = "BBD";
  currencies[56][1] = "Bermudian Dollar";            currencies[56][2] = "BMD";
  currencies[57][1] = "Bulgarian Lev";               currencies[57][2] = "BGL";
  currencies[58][1] = "Chilean Peso";                currencies[58][2] = "CLP";
  currencies[59][1] = "Czech Koruna";                currencies[59][2] = "CZK";
  currencies[60][1] = "Ecuadorian Sucre";            currencies[60][2] = "ECS";
  currencies[61][1] = "Egyptian Pound";              currencies[61][2] = "EGP";
  currencies[62][1] = "Hungarian Forint";            currencies[62][2] = "HUF";
  currencies[63][1] = "Indonesian Rupiah";           currencies[63][2] = "IDR";
  currencies[64][1] = "Israeli New Shekel";          currencies[64][2] = "ILS";
  currencies[65][1] = "Jamaican Dollar";             currencies[65][2] = "JMD";
  currencies[66][1] = "Jordanian Dinar";             currencies[66][2] = "JDD";
  currencies[67][1] = "Karach Tenge";                currencies[67][2] = "KZT";
  currencies[68][1] = "Lebanese Pound";              currencies[68][2] = "LBP";
  currencies[69][1] = "Peruvian New Soles";          currencies[69][2] = "PEN";
  currencies[70][1] = "Philippines Peso";            currencies[70][2] = "PHP";
  currencies[71][1] = "Polish Zloty";                currencies[71][2] = "PLZ";
  currencies[72][1] = "Romanian Lev";                currencies[72][2] = "ROL";
  currencies[73][1] = "Russian Ruble";               currencies[73][2] = "RUR";
  currencies[74][1] = "Slovakian Koruna";            currencies[74][2] = "SKK";
  currencies[75][1] = "South Korean Won";            currencies[75][2] = "KRW";
  currencies[76][1] = "Sudanese Dinar";              currencies[76][2] = "SDD";
  currencies[77][1] = "Turkish Lira";                currencies[77][2] = "TRL";
  currencies[78][1] = "Hukrainean Hryvna";           currencies[78][2] = "UAH";
  currencies[79][1] = "Uruguayan Peso";              currencies[79][2] = "UYU";
  currencies[80][1] = "Zambian Kwacha";              currencies[80][2] = "ZMK";
      

</cfscript>

<!--- if code convert --->
<cfif Attributes.mode IS "CODECONVERT">
  
  <cfset currencyName = "">
  
  <cfloop index="i" from="1" to="#ArrayLen(currencies)#">
    <cfif currencies[i][2] IS Trim(Attributes.code)>
      <cfset currencyName = currencies[i][1]>
      <cfbreak>
    </cfif>
  </cfloop>
  
  <cfset temp = "Caller." & Trim(Attributes.return)>
  <cfset "#temp#" = currencyName>
  
<!--- if select box --->
<cfelseif Attributes.mode IS "SELECTBOX">
  
  <cfoutput><select name="#Trim(Attributes.boxname)#"></cfoutput>
  
  <cfloop index="i" from="1" to="#ArrayLen(currencies)#">
    <cfoutput><option value="#currencies[i][2]#"<cfif Trim(Attributes.selected) IS currencies[i][2]> selected</cfif>>#currencies[i][1]# (#currencies[i][2]#)</option></cfoutput>
  </cfloop>
  
  <cfoutput></select></cfoutput>
  
</cfif>

<cfsetting enablecfoutputonly="No">
