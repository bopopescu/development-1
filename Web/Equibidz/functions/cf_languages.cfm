<cfsetting EnableCFOutputOnly="YES">
<!---
cf_languages.cfm

(modified by Jason on 2/11/99)

will...

output a SELECT box with given name and given language set...
or
output a list of languages w/ codes in a given set...
or
take a language code and return its full name...

<CFMODULE TEMPLATE="cf_languages.cfm"
	OPTION="[SELECT|LIST|CONVERT]"
	[LANGSET="[S|E|F]"]
	[SELECTNAME=""]
	[SELECTED=""]
	[DELIM=""]
	[CODE=""]
	[RETURN=""]
	[SIZE=""]
	[MULTIPLE=""]>
	
	LANGSET S=short E=expanded F=full
	
	Examples:
	
	print select box...
	
	<CFMODULE TEMPLATE="cf_languages.cfm"
		OPTION="SELECT"
		LANGSET="E"
		SELECTNAME="myselectbox"
		SELECTED="[English|en]"
        SIZE="5"
        MULTIPLE="YES">
	
	print list...
	
	<CFMODULE TEMPLATE="cf_languages.cfm"
		OPTION="LIST"
		LANGSET="F"
		DELIM=" - ">
	
	translate code to name...
	
	<CFMODULE TEMPLATE="cf_languages.cfm"
		OPTION="CONVERT"
		CODE="en"
		RETURN="myvariable">

---><CFSCRIPT>
	// load languages into array
	langs = ArrayNew(2);
	
	langs[1][1] = "EF";  langs[1][2] = "af";  langs[1][3] = "Afrikaans";
	langs[2][1] = "EF";  langs[2][2] = "sq";  langs[2][3] = "Albanian";
	langs[3][1] = "SEF";  langs[3][2] = "ar";  langs[3][3] = "Arabic";
	langs[4][1] = "F";  langs[4][2] = "ar-dz";  langs[4][3] = "Arabic (Algeria)";
	langs[5][1] = "F";  langs[5][2] = "ar-bh";  langs[5][3] = "Arabic (Bahrain)";
	langs[6][1] = "F";  langs[6][2] = "ar-eg";  langs[6][3] = "Arabic (Egypt)";
	langs[7][1] = "F";  langs[7][2] = "ar-iq";  langs[7][3] = "Arabic (Iraq)";
	langs[8][1] = "F";  langs[8][2] = "ar-jo";  langs[8][3] = "Arabic (Jordan)";
	langs[9][1] = "F";  langs[9][2] = "ar-kw";  langs[9][3] = "Arabic (Kuwait)";
	langs[10][1] = "F";  langs[10][2] = "ar-lb";  langs[10][3] = "Arabic (Lebanon)";
	langs[11][1] = "F";  langs[11][2] = "ar-ly";  langs[11][3] = "Arabic (Libya)";
	langs[12][1] = "F";  langs[12][2] = "ar-ma";  langs[12][3] = "Arabic (Morocco)";
	langs[13][1] = "F";  langs[13][2] = "ar-om";  langs[13][3] = "Arabic (Oman)";
	langs[14][1] = "F";  langs[14][2] = "ar-qa";  langs[14][3] = "Arabic (Qatar)";
	langs[15][1] = "F";  langs[15][2] = "ar-sa";  langs[15][3] = "Arabic (Saudi Arabia)";
	langs[16][1] = "F";  langs[16][2] = "ar-sy";  langs[16][3] = "Arabic (Syria)";
	langs[17][1] = "F";  langs[17][2] = "ar-tn";  langs[17][3] = "Arabic (Tunisia)";
	langs[18][1] = "F";  langs[18][2] = "ar-ae";  langs[18][3] = "Arabic (U.A.E.)";
	langs[19][1] = "F";  langs[19][2] = "ar-ye";  langs[19][3] = "Arabic (Yemen)";
	langs[20][1] = "EF";  langs[20][2] = "eu";  langs[20][3] = "Basque";
	langs[21][1] = "EF";  langs[21][2] = "be";  langs[21][3] = "Belarusian";
	langs[22][1] = "SEF";  langs[22][2] = "bg";  langs[22][3] = "Bulgarian";
	langs[23][1] = "EF";  langs[23][2] = "ca";  langs[23][3] = "Catalan";
	langs[24][1] = "SEF";  langs[24][2] = "zh";  langs[24][3] = "Chinese";
	langs[25][1] = "F";  langs[25][2] = "zh-hk";  langs[25][3] = "Chinese (Hong Kong)";
	langs[26][1] = "F";  langs[26][2] = "zh-cn";  langs[26][3] = "Chinese (PRC)";
	langs[27][1] = "F";  langs[27][2] = "zh-sg";  langs[27][3] = "Chinese (Singapore)";
	langs[28][1] = "F";  langs[28][2] = "zh-tw";  langs[28][3] = "Chinese (Taiwan)";
	langs[29][1] = "EF";  langs[29][2] = "hr";  langs[29][3] = "Croatian";
	langs[30][1] = "SEF";  langs[30][2] = "cs";  langs[30][3] = "Czech";
	langs[31][1] = "SEF";  langs[31][2] = "da";  langs[31][3] = "Danish";
	langs[32][1] = "SEF";  langs[32][2] = "nl";  langs[32][3] = "Dutch";
	langs[33][1] = "F";  langs[33][2] = "nl-be";  langs[33][3] = "Dutch (Belgian)";
	langs[34][1] = "SEF";  langs[34][2] = "en";  langs[34][3] = "English";
	langs[35][1] = "F";  langs[35][2] = "en-au";  langs[35][3] = "English (Australian)";
	langs[36][1] = "F";  langs[36][2] = "en-bz";  langs[36][3] = "English (Belize)";
	langs[37][1] = "F";  langs[37][2] = "en-gb";  langs[37][3] = "English (British)";
	langs[38][1] = "F";  langs[38][2] = "en-ca";  langs[38][3] = "English (Canadian)";
	langs[39][1] = "F";  langs[39][2] = "en-ie";  langs[39][3] = "English (Ireland)";
	langs[40][1] = "F";  langs[40][2] = "en-jm";  langs[40][3] = "English (Jamaica)";
	langs[41][1] = "F";  langs[41][2] = "en-nz";  langs[41][3] = "English (New Zealand)";
	langs[42][1] = "F";  langs[42][2] = "en-za";  langs[42][3] = "English (South Africa)";
	langs[43][1] = "F";  langs[43][2] = "en-tt";  langs[43][3] = "English (Trinidad)";
	langs[44][1] = "EF";  langs[44][2] = "et";  langs[44][3] = "Estonian";
	langs[45][1] = "EF";  langs[45][2] = "fo";  langs[45][3] = "Faeroese";
	langs[46][1] = "EF";  langs[46][2] = "fa";  langs[46][3] = "Farsi";
	langs[47][1] = "EF";  langs[47][2] = "fi";  langs[47][3] = "Finnish";
	langs[48][1] = "SEF";  langs[48][2] = "fr";  langs[48][3] = "French";
	langs[49][1] = "F";  langs[49][2] = "fr-be";  langs[49][3] = "French (Belgian)";
	langs[50][1] = "F";  langs[50][2] = "fr-ca";  langs[50][3] = "French (Canadian)";
	langs[51][1] = "F";  langs[51][2] = "fr-lu";  langs[51][3] = "French (Luxembourg)";
	langs[52][1] = "F";  langs[52][2] = "fr-ch";  langs[52][3] = "French (Swiss)";
	langs[53][1] = "EF";  langs[53][2] = "mk";  langs[53][3] = "FYROM";
	langs[54][1] = "EF";  langs[54][2] = "gd";  langs[54][3] = "Gaelic";
	langs[55][1] = "SEF";  langs[55][2] = "de";  langs[55][3] = "German";
	langs[56][1] = "F";  langs[56][2] = "de-at";  langs[56][3] = "German (Austrian)";
	langs[57][1] = "F";  langs[57][2] = "de-li";  langs[57][3] = "German (Liechtenstein)";
	langs[58][1] = "F";  langs[58][2] = "de-lu";  langs[58][3] = "German (Luxembourg)";
	langs[59][1] = "F";  langs[59][2] = "de-ch";  langs[59][3] = "German (Swiss)";
	langs[60][1] = "SEF";  langs[60][2] = "el";  langs[60][3] = "Greek";
	langs[61][1] = "SEF";  langs[61][2] = "he";  langs[61][3] = "Hebrew";
	langs[62][1] = "EF";  langs[62][2] = "hi";  langs[62][3] = "Hindi";
	langs[63][1] = "SEF";  langs[63][2] = "hu";  langs[63][3] = "Hungarian";
	langs[64][1] = "EF";  langs[64][2] = "is";  langs[64][3] = "Icelandic";
	langs[65][1] = "EF";  langs[65][2] = "in";  langs[65][3] = "Indonesian";
	langs[66][1] = "SEF";  langs[66][2] = "it";  langs[66][3] = "Italian";
	langs[67][1] = "F";  langs[67][2] = "it-ch";  langs[67][3] = "Italian (Swiss)";
	langs[68][1] = "SEF";  langs[68][2] = "ja";  langs[68][3] = "Japanese";
	langs[69][1] = "SEF";  langs[69][2] = "ko";  langs[69][3] = "Korean";
	langs[70][1] = "EF";  langs[70][2] = "lv";  langs[70][3] = "Latvian";
	langs[71][1] = "EF";  langs[71][2] = "lt";  langs[71][3] = "Lithuanian";
	langs[72][1] = "SEF";  langs[72][2] = "ms";  langs[72][3] = "Malaysian";
	langs[73][1] = "EF";  langs[73][2] = "mt";  langs[73][3] = "Maltese";
	langs[74][1] = "SEF";  langs[74][2] = "no";  langs[74][3] = "Norwegian";
	langs[75][1] = "SEF";  langs[75][2] = "pl";  langs[75][3] = "Polish";
	langs[76][1] = "SEF";  langs[76][2] = "pt";  langs[76][3] = "Portuguese";
	langs[77][1] = "F";  langs[77][2] = "pt-br";  langs[77][3] = "Portuguese (Brazilian)";
	langs[78][1] = "EF";  langs[78][2] = "rm";  langs[78][3] = "Rhaeto-Romanic";
	langs[79][1] = "SEF";  langs[79][2] = "ro";  langs[79][3] = "Romanian";
	langs[80][1] = "F";  langs[80][2] = "ro-mo";  langs[80][3] = "Romanian (Moldavia)";
	langs[81][1] = "SEF";  langs[81][2] = "ru";  langs[81][3] = "Russian";
	langs[82][1] = "F";  langs[82][2] = "ru-mo";  langs[82][3] = "Russian (Moldavia)";
	langs[83][1] = "EF";  langs[83][2] = "sr";  langs[83][3] = "Serbian";
	langs[84][1] = "EF";  langs[84][2] = "sk";  langs[84][3] = "Slovak";
	langs[85][1] = "EF";  langs[85][2] = "sl";  langs[85][3] = "Slovenian";
	langs[86][1] = "EF";  langs[86][2] = "sb";  langs[86][3] = "Sorbian";
	langs[87][1] = "SEF";  langs[87][2] = "es";  langs[87][3] = "Spanish";
	langs[88][1] = "F";  langs[88][2] = "es-ar";  langs[88][3] = "Spanish (Argentina)";
	langs[89][1] = "F";  langs[89][2] = "es-bo";  langs[89][3] = "Spanish (Bolivia)";
	langs[90][1] = "F";  langs[90][2] = "es-cl";  langs[90][3] = "Spanish (Chile)";
	langs[91][1] = "F";  langs[91][2] = "es-co";  langs[91][3] = "Spanish (Colombia)";
	langs[92][1] = "F";  langs[92][2] = "es-cr";  langs[92][3] = "Spanish (Costa Rica)";
	langs[93][1] = "F";  langs[93][2] = "es-ec";  langs[93][3] = "Spanish (Ecuador)";
	langs[94][1] = "F";  langs[94][2] = "es-sv";  langs[94][3] = "Spanish (El Salvador)";
	langs[95][1] = "F";  langs[95][2] = "es-gt";  langs[95][3] = "Spanish (Guatemala)";
	langs[96][1] = "F";  langs[96][2] = "es-hn";  langs[96][3] = "Spanish (Honduras)";
	langs[97][1] = "F";  langs[97][2] = "es-mx";  langs[97][3] = "Spanish (Mexican)";
	langs[98][1] = "F";  langs[98][2] = "es-ni";  langs[98][3] = "Spanish (Nicaragua)";
	langs[99][1] = "F";  langs[99][2] = "es-pa";  langs[99][3] = "Spanish (Panama)";
	langs[100][1] = "F";  langs[100][2] = "es-py";  langs[100][3] = "Spanish (Paraguay)";
	langs[101][1] = "F";  langs[101][2] = "es-pe";  langs[101][3] = "Spanish (Peru)";
	langs[102][1] = "F";  langs[102][2] = "es-pr";  langs[102][3] = "Spanish (Puerto Rico)";
	langs[103][1] = "F";  langs[103][2] = "es-uy";  langs[103][3] = "Spanish (Uruguay)";
	langs[104][1] = "F";  langs[104][2] = "es-ve";  langs[104][3] = "Spanish (Venezuela)";
	langs[105][1] = "EF";  langs[105][2] = "sx";  langs[105][3] = "Sutu";
	langs[106][1] = "SEF";  langs[106][2] = "sv";  langs[106][3] = "Swedish";
	langs[107][1] = "F";  langs[107][2] = "sv-fi";  langs[107][3] = "Swedish (Finland)";
	langs[108][1] = "EF";  langs[108][2] = "th";  langs[108][3] = "Thai";
	langs[109][1] = "EF";  langs[109][2] = "ts";  langs[109][3] = "Tsonga";
	langs[110][1] = "EF";  langs[110][2] = "tn";  langs[110][3] = "Tswana";
	langs[111][1] = "SEF";  langs[111][2] = "tr";  langs[111][3] = "Turkish";
	langs[112][1] = "EF";  langs[112][2] = "uk";  langs[112][3] = "Ukrainian";
	langs[113][1] = "EF";  langs[113][2] = "ur";  langs[113][3] = "Urdu";
	langs[114][1] = "SEF";  langs[114][2] = "vi";  langs[114][3] = "Vietnamese";
	langs[115][1] = "EF";  langs[115][2] = "xh";  langs[115][3] = "Xhosa";
	langs[116][1] = "EF";  langs[116][2] = "ji";  langs[116][3] = "Yiddish";
	langs[117][1] = "EF";  langs[117][2] = "zu";  langs[117][3] = "Zulu";

</CFSCRIPT

><CFIF not IsDefined("Attributes.OPTION")

>Attribute not specified for cf_languages... Aborting...<BR><CFABORT></CFIF

><CFSWITCH EXPRESSION="#Attributes.OPTION#"
	
	><!--- output select box 
	---><CFCASE VALUE="SELECT"
	
		><!--- verify attributes present 
		---><CFLOOP INDEX="l" LIST="LANGSET,SELECTNAME,SELECTED,SIZE,MULTIPLE"
			
			><CFIF not IsDefined("Attributes." & l)
				>Attribute not specified for cf_languages... Aborting...<BR>
				<CFABORT
			></CFIF
			
		></CFLOOP
		
		><!--- output select box 
		
		---><CFOUTPUT><SELECT NAME="#Trim(Attributes.SELECTNAME)#"<cfif #trim(attributes.MULTIPLE)# is "YES"> multiple</cfif><cfif #trim(attributes.SIZE)# GT "1"> size=#trim(attributes.SIZE)#</cfif>>
</CFOUTPUT><CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(langs)#"
		><CFIF langs[i][1] CONTAINS Trim(Attributes.LANGSET)><CFOUTPUT><OPTION VALUE="#langs[i][2]#"<CFIF langs[i][3] IS #Trim(Attributes.SELECTED)# OR #listContainsNoCase (Attributes.SELECTED, langs[i][2], ",")#> SELECTED</CFIF>>#langs[i][3]#</CFOUTPUT>
</CFIF></CFLOOP
		><CFOUTPUT></SELECT></CFOUTPUT
		
	></CFCASE
	
	><!--- output list 
	---><CFCASE VALUE="LIST"
		
		><!--- verify attributes present 
		---><CFLOOP INDEX="l" LIST="LANGSET,DELIM"
			
			><CFIF not IsDefined("Attributes." & l)
				>Attribute not specified for cf_languages... Aborting...<BR>
				<CFABORT
			></CFIF
			
		></CFLOOP
	
	><CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(langs)#"
		><CFIF langs[i][1] CONTAINS Trim(Attributes.LANGSET)><CFOUTPUT>#langs[i][2]##Attributes.DELIM##langs[i][3]#</CFOUTPUT>
</CFIF
	></CFLOOP
	
	></CFCASE
	
	><!--- convert code 
	---><CFCASE VALUE="CONVERT"
		
		><!--- verify attributes present 
		---><CFLOOP INDEX="l" LIST="CODE,RETURN"
			
			><CFIF not IsDefined("Attributes." & l)
				>Attribute not specified for cf_languages... Aborting...<BR>
				<CFABORT
			></CFIF
			
		></CFLOOP
		
		><CFSET temp = ""
		
		><CFLOOP INDEX="i" FROM="1" TO="#ArrayLen(langs)#"
			><CFIF langs[i][2] IS Trim(Attributes.CODE)
				><CFSET temp = langs[i][3]
				><CFBREAK
			></CFIF
		></CFLOOP
		
		><CFSET var_return = "Caller." & Attributes.RETURN
		
		><CFSET "#var_return#" = temp
	
	></CFCASE
	
	><CFDEFAULTCASE></CFDEFAULTCASE
></CFSWITCH>
<cfsetting EnableCFOutputOnly="NO">
