<cfsetting enablecfoutputonly="yes">
<!---

Studio.cfm
Builds thumbnails table
!!!!! WARNING !!!!!
Do not change the number of navigation links on this page!
Do not put in a include for the menu_bar.cfm template!

Link destination, the order they appear, and image map are OK. 

Any deviation from 8 navigation links at the top of the page and
8 navigation links at the bottom will cause studio to stop functioning.
 
Walter 11/24/99

added body tag include & stylesheet.css - 11/06/00TL
--->

<!--- define cache control page --->

<cfinclude template = "../includes/app_globals.cfm">
<cfmodule template="../functions/timenow.cfm">



<cfparam name="category" default="0">
<cfparam name="hot_auctions" default="FALSE">                              
<cfparam name="VAROOT" default="">


<cfif isDefined("session.featured") is "TRUE">
  <cfif #category# IS 0>
    <cfparam name="featured" default="TRUE">
  <cfelse>
    <cfparam name="featured" default="FALSE">  
  </cfif>    
<cfelse>
  <cfparam name="featured" default="FALSE">
</cfif>


<cfset levelsDisplayed = 4>

<CFMODULE TEMPLATE="../functions/cf_category_tree.cfm"
  TYPE="RETRIEVE"
  DATASOURCE="#DATASOURCE#"
  PARENT = "0"
  REQUIRE_LOGIN="0">

<CFSET BROWSER = CGI.HTTP_USER_AGENT>
<cfset browser = find("MSIE",browser)>

<cfif #category# IS NOT "0">
  <cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#DATASOURCE#">
    SELECT itemnum,
   	minimum_bid,
   	maximum_bid,
   	date_start,
	  date_end,
  	title,
	  banner_line,
  	quantity,
  	category1,
    category2,
    auction_mode
	  FROM items
    WHERE ((category1 = #category#) OR (category2 = #category#)) AND studio = 1 and status = 1
    ORDER BY date_start DESC
  </cfquery>
</cfif>
<cfif #featured# is "TRUE">
  <cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#DATASOURCE#">
    SELECT itemnum,
  	minimum_bid,
  	maximum_bid,
  	date_start,
	  date_end,
  	title,
	  banner_line,
  	quantity,
    category1,
    category2,
    auction_mode 
	  FROM items
    WHERE studio = 1 and featured_studio = 1 and status = 1
    ORDER BY date_start DESC
  </cfquery>
</cfif>


<!---
<cfif #hot_auctions# is "TRUE">
<cfquery username="#db_username#" password="#db_password#" name="top_items" datasource="#DATASOURCE#">
  SELECT itemnum,
  	minimum_bid,
  	date_start,
	  date_end,
  	title,
	  banner_line,
  	quantity,
    category1,
    category2,
    0 as total_bids
	  FROM items
    WHERE studio = 1 and status = 1
    ORDER BY date_start DESC
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="create_table" datasource="#DATASOURCE#">
 	CREATE TABLE hot_sort (
 	itemnum char(9),
 	minimum_bid number,
 	date_start date,
 	date_end date,
 	banner_line char(60),
 	quantity number,
 	category1 char(9),
 	category2 char(9),
  title char(60), 
 	total number)
</cfquery>
<cfloop query="top_items">
 	<cfquery username="#db_username#" password="#db_password#" name="count" datasource="#DATASOURCE#">
 		SELECT COUNT(itemnum) AS total
 		FROM bids
 		WHERE itemnum=#itemnum#
	</cfquery>
 	<cfquery username="#db_username#" password="#db_password#" name="temp_store" datasource="#DATASOURCE#">
 		INSERT INTO hot_sort
    (itemnum,
 		title,
   	total,
   	minimum_bid,
   	date_start,
   	date_end,
   	banner_line,
   	quantity,
 	  category1,
   	category2)
 		VALUES (#top_items.itemnum#,
		'#top_items.title#',
		#count.total#,
		#top_items.minimum_bid#,
		'#top_items.date_start#',
		'#top_items.date_end#',
		'#top_items.banner_line#',
   	#top_items.quantity#,
 	  #top_items.category1#,
   	#top_items.category2#)
 	</cfquery>
</cfloop>
<cfquery username="#db_username#" password="#db_password#" name="get_ItemInfo" datasource="#DATASOURCE#">
 	SELECT *
 	FROM hot_sort
 	WHERE total <> 0
 	ORDER BY total DESC;
</cfquery>
<cfquery username="#db_username#" password="#db_password#" name="dropTheTable" datasource="#DATASOURCE#">
  DROP TABLE hot_sort
</cfquery>
</cfif>                
--->




<!--- Set delimiter variables --->
<cfset #int_delim# = "÷">
<cfset #ext_delim# = "²">

<cfoutput>
<html>
<head>
<title>#company_name# Studio</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
<cfif #category# NEQ 0 or #featured# is "true" or #hot_auctions# is "true">
  <cf_jsarray thequery="#get_ItemInfo#">
</cfif>

<script language = "javascript">

</cfoutput>

<cfif #category# NEQ 0 or #featured# is "TRUE" or #hot_auctions# is "TRUE">
  <cfoutput>category_name=new Array();
  
  </cfoutput>
  <cfset counter=0>
  <cfloop query="get_ItemInfo">
    <cfquery username="#db_username#" password="#db_password#" name="get_catName" datasource="#DATASOURCE#">
      SELECT name
      FROM categories
      WHERE category=#get_ItemInfo.category1# or category=#get_ItemInfo.category2#
    </cfquery>
    <cfoutput>category_name[#counter#]="#get_catName.name#";
	
    </cfoutput>
   <cfset counter = counter+1>    
  </cfloop>
</cfif>

<cfif #category# NEQ 0 or #featured# is "TRUE" or #hot_auctions# is "TRUE">
  <cfset counter = 0>
  <cfoutput>
    date_diff = new Array(#get_itemInfo.RecordCount#)  
  </cfoutput>    
  <cfloop query="get_ItemInfo">
    <cfset theTotMinutes = #DateDiff("n","#timenow#","#CreateODBCDateTime("#get_itemInfo.date_end#")#")#>
    <cfif theTotMinutes GT 0>
      <cfset theDays = "#Int(Evaluate(theTotMinutes/1440))#">
      <cfset theHours = "#Int(Evaluate((theTotMinutes MOD 1440)/60))#">
      <cfset theMinutes = "#Evaluate((theTotMinutes MOD 1440) MOD 60)#">
      <cfif #theDays# NEQ 0>
        <cfset theDaysLabel = #IIf(#Int(Evaluate(theTotMinutes/1440))# GT 1,DE("days"),DE("day"))#>   
        <cfset theTimeString = "#theDays# #theDaysLabel#">
        <cfif #theHours# NEQ 0>
          <cfset theHoursLabel = #IIf(#Int(Evaluate(theTotMinutes MOD 1440))# GT 1,DE("hours"),DE("hour"))#>          
         <cfset theTimeString = "#theTimeString#, #theHours# #theHoursLabel#">
          <cfif #theMinutes# NEQ 0> 
            <cfset theMinutesLabel = #IIf(#Int(Evaluate((theTotMinutes MOD 1440) MOD 60))# GT 1,DE("minutes"),DE("minute"))#>          
           <cfset theTimeString = "#theTimeString#, #theMinutes# #theMinutesLabel#">
          </cfif>
        </cfif>    
      <cfelse>
        <cfif #theHours# NEQ 0>
          <cfset theHoursLabel = #IIf(#Int(Evaluate(theTotMinutes MOD 1440))# GT 1,DE("hours"),DE("hour"))#>          
          <cfset theTimeString = "#theHours# #theHoursLabel#">
          <cfif #theMinutes# NEQ 0> 
            <cfset theMinutesLabel = #IIf(#Evaluate((theTotMinutes MOD 1440) MOD 60)# GT 1,DE("Minutes"),DE("Minute"))#>          
            <cfset theTimeString = "#theTimeString#, #theMinutes# # theMinutesLabel#">
          </cfif>
        <cfelse>  
          <cfif #theMinutes# NEQ 0> 
            <cfset theMinutesLabel = #IIf(#Evaluate((theTotMinutes MOD 1440) MOD 60)# GT 1,DE("minutes"),DE("minute"))#>          
            <cfset theTimeString = "#theMinutes# # theMinutesLabel#">
          </cfif>
        </cfif>
      </cfif>  
      <cfoutput>
        date_diff[#counter#] = "#theTimeString#"
      </cfoutput>
    <cfelse>
      <cfoutput>
        date_diff[#counter#] = "Just Expired"
      </cfoutput>
    </cfif>    
    <cfset counter = counter+1>    
  </cfloop>    


  <cfset counter = 0>
  <cfoutput>  
    maxBidArray = new Array(2)
    theMaxBid  = new Array()
    theMinBid = new Array()
  </cfoutput>
  <cfloop query="get_ItemInfo">  
    <cfquery username="#db_username#" password="#db_password#" name="getMaxBid" maxrows="1" datasource="#DATASOURCE#">
      SELECT bid <!--- itemnum --->
      FROM bids
      WHERE itemnum = #get_ItemInfo.itemnum#
      ORDER BY bid DESC
    </cfquery>

    <cfquery username="#db_username#" password="#db_password#" name="getMinBid" maxrows="1" datasource="#DATASOURCE#">
      SELECT <!--- itemnum, ---> bid
      FROM bids
      WHERE itemnum = #get_ItemInfo.itemnum#
      ORDER BY bid ASC
    </cfquery>

    <cfoutput>
<!---      theItem[#counter#] = "#getMaxBid.itemnum#" --->
      theMaxBid[#counter#]  = "#LSCurrencyFormat(getMaxBid.bid,"local")#"
      theMinBid[#counter#]  = "#LSCurrencyFormat(getMinBid.bid,"local")#"
    </cfoutput>
    <cfset counter = counter+1> 
  </cfloop>
</cfif>





<cfif #category# NEQ 0 or #featured# is "TRUE" or #hot_auctions# is "TRUE">
  <cfset #counter# = 0>
  <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\","thumbs\")#>
  <cfoutput>
    theFileName=new Array()
  </cfoutput>
  <cfloop query="get_ItemInfo">  
    <cfif fileExists("#thePath##itemnum#.jpg")>
      <cfoutput>theFileName[#counter#] = "#itemnum#.jpg"
      </cfoutput>
    <cfelseif fileExists("#thePath##itemnum#.gif")>
      <cfoutput>theFileName[#counter#] = "#itemnum#.gif"
      </cfoutput>
    <cfelse>
      <cfoutput>theFileName[#counter#] = "../images/dummy.gif"
      </cfoutput>
    </cfif>                        
    <cfset counter = counter+1> 
  </cfloop>
</cfif>



<cfoutput>

function filenameOnly (InString){
  LastSlash=InString.lastIndexOf ('/', InString.length-1)
  OutString=InString.substring(LastSlash+1, InString.length)
  return (OutString);
}


function table_getValue(row,col) {
  return this.data[row*this.columns+col]
}

function table_setValue(row,col,value) {
  this.data[row*this.columns+col]=value
}

function table_set(contents) {
  var n = contents.length
  for(var j=0;j<n;++j){
 	  this.data[j]=contents[j]
  }
}

if ((#category# != 0)||("#featured#" == "TRUE")||("#hot_auctions#" == "TRUE")){
  var maxpics=QUERYARRAY[0].length
}else{
  var maxpics = 0
}

function table_write(doc){
document.write('<table width=100% height="8" border="0"><tr><td></td></tr></table>')
document.write('<center><table width="620" cellpadding=1 cellspacing=0 border="1" bgcolor="##ffffff">')
document.write('<tr><td>')
document.write('<table width=100% cellpadding=1 cellspacing=0 border="1">')
document.write('<tr><td height=110 align=center valign=center>')
document.write(this.data[0]+'</td><td align=center valign=center>')
document.write(this.data[1]+'</td><td align=center valign=center>')
document.write(this.data[2]+'</td><td align=center valign=center>')
document.write(this.data[3]+'</td><td align=center valign=center>')
document.write(this.data[4]+'</td></tr>')
document.write('<tr><td height=110 align=center valign=center>')
document.write(this.data[5]+'</td><td align=center valign=center>')
document.write(this.data[6]+'</td><td align=center valign=center>')
document.write(this.data[7]+'</td><td align=center valign=center>')
document.write(this.data[8]+'</td><td align=center valign=center>')
document.write(this.data[9]+'</td></tr>')
document.write('<tr><td height=110 align=center valign=center>')
document.write(this.data[10]+'</td><td align=center valign=center>')
document.write(this.data[11]+'</td><td align=center valign=center>')
document.write(this.data[12]+'</td>')
document.write('<td bgcolor="##c0c0c0" colspan="2" rowspan=2 valign=top align="center">')
document.write('<table bgcolor="##c0c0c0" cellpadding=0 cellspacing=0 border=0>') //border is 1
document.write('<form name="theForm" method="post" action="">')
document.write('<tr><td align=center valign=center>')
document.write(this.data[16])    
document.write('<select name="c" OnChange=location.href=this.options[this.selectedIndex].value>')
<cfif browser is 0>
  document.write('<option value="" <cfif #category# NEQ 0>selected</cfif>>Please select a category.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>')
<cfelse>
  document.write('<option value="" <cfif #CATEGORY# NEQ 0>selected</cfif>>Please select a category.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>')
</cfif>  

document.write('<option value="#VAROOT#/listings/Studio.cfm?featured=TRUE&/##theLink"<cfif #featured# IS 'TRUE'> selected</cfif>>FEATURED ITEMS</option>')
<!--- document.write('<option value="#VAROOT#/listings/Studio.cfm?hot_auctions=TRUE&/##theLink"<cfif #hot_auctions# IS 'TRUE'> selected</cfif>>HOT AUCTIONS</option>') --->

<cfloop index="l" list="#result#" delimiters="#ext_delim#">
  <cfquery username="#db_username#" password="#db_password#" name="chk4studio" datasource="#DATASOURCE#">
    SELECT COUNT(*) AS counter
	  FROM items
    WHERE ((category1 = #ListGetAt(l, 1, int_delim)#) OR (category2 = #ListGetAt(l, 1, int_delim)#)) and status = 1 AND studio = 1
  </cfquery>
  <cfif #chk4studio.counter# GT 0 AND Evaluate(ListGetAt(l, 3, int_delim) + 1) LTE Variables.levelsDisplayed>
    <cfset theCategory = Replace(Mid(ListGetAt(l, 2, int_delim), 2, Len(ListGetAt(l, 2, int_delim)) - 2),"'","","ALL")>
    <cfif ListGetAt(l, 3, int_delim) IS 0>
      <cfset theCategory = #RepeatString("&nbsp;", (ListGetAt(l, 3, int_delim)) * 3)#&#theCategory#>
    <cfelse>
      <cfset theCategory = #RepeatString("&nbsp;", (ListGetAt(l, 3, int_delim)) * 3)#&" "&#theCategory#>      
    </cfif>
<!---    document.write("<option value='#VAROOT#/listings/Studio.cfm?category=#ListGetAt(l, 1, int_delim)#&/##theLink'>#Left(theCategory,34)#</option>") --->
    document.write("<option value='#VAROOT#/listings/Studio.cfm?category=#ListGetAt(l, 1, int_delim)#&/##theLink'>#theCategory#</option>")

  </cfif>    
</cfloop>

document.write('</select></td></tr></form></table>')
document.write('<table border="0" width=100% bgcolor="##c0c0c0" cellpadding="0" cellspacing="0"><tr>')

if (((#category# != "0")||("#featured#" == "TRUE")||("#hot_auctions#" == "TRUE"))){   //&&(maxpics > 16)){
if (maxpics > 16){
  document.write('<tr><td colspan=3 height=6></td></tr>')
}  

<!--- Sell button commented out below --->
if ("#featured#" == "FALSE"){
//document.write('<td align="center" valign="middle">&nbsp;<a href="../sell/index.cfm?cat=#category#"
// onMouseOver="document.sell_butt.src=\'../images/Sellhere_1.gif\'" //onMouseOut="document.sell_butt.src=\'../images/Sellhere_0.gif\'"><img src="../images/Sellhere_0.gif" border="0" width="45"
// height="39" vspace="4" name="sell_butt" alt="Sell your items in this category"><a/></td>')
}else{
  document.write('<td>&nbsp;</td>')
}  

if (maxpics > 16){
  document.write('<td align="center" valign="middle">&nbsp;&nbsp;&nbsp;<A HREF=javascript:changePage("first") onMouseOver="document.S_arrow.src=\'../images/S_arrow_r.gif\'" onMouseOut="document.S_arrow.src=\'../images/S_arrow.gif\'"><img src="../images/S_arrow.gif" height=25 width=23 border=0 name="S_arrow" alt="First Page"></a>&nbsp;')
  document.write('<A HREF=javascript:changePage("prev") onMouseOver="document.L_arrow.src=\'../images/L_arrow_r.gif\'" onMouseOut="document.L_arrow.src=\'../images/L_arrow.gif\'"><img src="../images/L_arrow.gif" height=25 width=17 border=0 name="L_arrow" alt="Previous Page"></a>')
  document.write('<img src="../images/a1.gif" height=25 width=30 border=0 name="digi_1">')
  valdigi_2=Math.floor(maxpics/16)+((maxpics%16)!=0?1:0)
  document.write('<img src="../images/b'+valdigi_2+'.gif" height=25 width=30 border=0 name="digi_2">')
  document.write('<A HREF=javascript:changePage("next") onMouseOver="document.R_arrow.src=\'../images/R_arrow_r.gif\'" onMouseOut="document.R_arrow.src=\'../images/R_arrow.gif\'"><img src="../images/R_arrow.gif" height=25 width=17 border=0 name="R_arrow" alt="Next Page"></a></td>')
}else{
  document.write('<td align="center"><img src="../images/Studio_label1.gif" width=146 height=48 border=0></td>')
}
document.write('<td align=right><img src="../images/i.gif" height=40 width=10 border=0 alt="WConti fecit 10/99"></td>')
}else{
  document.write('<td><img src="../images/Studio_label.gif" width=248 height=52 border=0></td>')
}
document.write('</tr>')
document.write('</table>')
document.write('</td></tr>')
document.write('<tr><td height=110 align=center valign=center>')
document.write(this.data[13]+'</td><td align=center valign=center>')
document.write(this.data[14]+'</td><td align=center valign=center>')
document.write(this.data[15]+'</td></tr></table>')
document.write('</td></tr></table></center>')
}

function table(cells) {
 this.data = new Array(16)
 this.getValue = table_getValue
 this.setValue = table_setValue
 this.set = table_set
 this.write = table_write
}

function doThis(item_no){
  for (x=0; x <= ITEMNUM[1].length; x++){
    if (ITEMNUM[x] == filenameOnly(item_no).substr(0,9)){
      theTitle=TITLE[x]
      break
    }
  }
  return theTitle
}

function notes(){
  document.forms[0].textfield.value="This is your Thumbnails Catalog. You will be able to select an auctioned item by clicking on its picture. This catalog contains only those items that the sellers deem to deserve special attention.  As such it does not encompass all items, but it sure makes the navigation of our auction site much easier and fun.\n\rEnjoy!"
}


var page_no=1
var counter=j=16
function changePage(page){
  if(page=="first"){counter=j=0}
  if (page == "prev"){
    if (counter == 16){
      if (maxpics%16 == 0){
        counter=j= maxpics-16;
      }else{
        counter=j=(maxpics-(maxpics%16));
      }        
	  }else{
	    if (counter >= maxpics){
    	  counter=j=maxpics-(16+(maxpics%16));
 		  }else{
			  counter=j=counter-32;
     	}
	  }
  }
 	if (counter >= maxpics){counter=j=0}
	for(var i=0;i<=15;++i){
		if (counter < maxpics){
		
	
  	  eval("document.img"+i+".src='../thumbs/"+theFileName[j]+"'")
			if (i < 13){
        document.links[i+8].href="../listings/details/index.cfm?itemnum="+ITEMNUM[j]+""
	    }else{
        document.links[i+11].href="../listings/details/index.cfm?itemnum="+ITEMNUM[j]+""
    	}
			++counter
	  	++j
		}else{
			eval("document.img"+i+".src='../images/dummy.gif'")
  		if (i < 13){
        document.links[(i+8)].href="javascript:notes()"
			}else{
			  document.links[(i+12)].href="javascript:notes()"
			}
		}
  }
	if (page=="next"){++page_no}
	if (page=="prev"){--page_no}
	if (page=="first"){page_no=1}
	if (page_no < 1){page_no=valdigi_2}
	if (page_no>valdigi_2){page_no=1}
	document.digi_1.src="../images/a"+page_no+".gif"
	if (page == "next"){
  	a=counter-16
    for(var x=0;x<=15;++x){
      pre_load="image"+a
  	  pre_load = new Image();
      pre_load.src = "../thumbs/"+theFileName[a];
      if (a >= maxpics){
        break    
      }else{
        ++a  
      }      
    }
  }
}


function filenameOnly (InString){
  LastSlash=InString.lastIndexOf ('/', InString.length-1)
  OutString=InString.substring(LastSlash+1, InString.length)
  return (OutString);
}


function spaceTrim(InString) {
        var LoopCtrl=true;
        while (LoopCtrl) {
                if (InString.indexOf("  ") != -1) {
                        Temp = InString.substring(0, InString.indexOf("  "))
                        InString = Temp + InString.substring(InString.indexOf("  ")+1, 
                                InString.length)
                } else
                        LoopCtrl = false;
        }
        if (InString.substring(0, 1) == " ")
                InString = InString.substring(1, InString.length)
        if (InString.substring (InString.length-1) == " ")
                InString = InString.substring(0, InString.length-1)
        return (InString)
}


function buildText(item_no){
  if ((#category# != "0")||("#featured#" == "TRUE")||("#hot_auctions#" == "TRUE")){
    item_no=filenameOnly(item_no).substr(0,9)
    if (item_no != "dummy.gif"){
      for (var i = 0; i <= QUERYARRAY[1].length; i++){
        if (ITEMNUM[i] == item_no){        
          if ("#hot_auctions#" == "TRUE"){
            theString = " "+parseInt(TOTAL[i])+" Bid"
            if(TOTAL[i] > 1){
              theString += "s.\n"
            }else{
              theString += ".\n"
            }                            
          }else{ 
            theString=" Category: "+category_name[i]+"\n"
          }  
          theString+=" "+spaceTrim(TITLE[i])+"\n"
          
          if (spaceTrim(BANNER_LINE[i])!=""){
            theString+=" "+spaceTrim(BANNER_LINE[i])+"\n"
          }


          if (AUCTION_MODE[i] == "1"){
            if (theMinBid[i] == "$0.00"){
              theBidString = " Max Bid: "+moneyFormat(MAXIMUM_BID[i])+"\n"
            }else{
              theBidString = " Current Bid: "+theMinBid[i]+"\n"
            }
            theBidString += " (This is a Reverse Auction)\n"
          }else{
            if (theMaxBid[i] != "$0.00"){
              theBidString=" Current Max Bid: "+theMaxBid[i]+"\n"
            }else{
              theBidString=" Minimum Bid: $"+moneyFormat(MINIMUM_BID[i])+"\n"
            }
          }            


<!---
          for (x=1; x <= theItem[0].length; x++){
            if (theItem[x] == item_no){
              theBidString=" Current Bid: "+theBid[x]+"\n"
              break
            }else{
              theBidString=" Minimum Bid: $"+moneyFormat(MINIMUM_BID[i])+"\n"
            }
          }   
--->          
          
          
                     
          theString+=theBidString
          theString+=" Quantity: "+parseInt(QUANTITY[i])+"\n"
          if (date_diff[i] == "Juast Expired"){
            theString+=" Auction has just expired.\n"
          }else{            
            theString+=" "+date_diff[i]
          }            
          document.forms[0].textfield.value = theString
	        break
        }
      }      
    }
  }
}



function statistics(){
//  document.forms[0].textfield.value='Some statistics here.'
//document.forms[0].textfield.value=''
}



function moneyFormat(input) {
  var dollars = Math.floor(input)
  var cents  = "" + Math.round(input * 100)
  cents = cents.substring(cents.length-2, cents.length)
  input = dollars + "." + cents
  return input
}


function imageError(bla){

alert(bla)

<!---
 contents[i] = '<a href="../listings/details/index.cfm?itemnum='+ITEMNUM[i]+'" onmouseOver=javascript:buildText(document.img'+i+'.src);return true onmouseOut="javascript:statistics()"><IMG SRC="../thumbs/'+ITEMNUM[i]+'.gif" border="0" width="124" height="110" name="img'+i+'"></a>'
 
 alert(contents[i])   --->
}



//-->
</script>

</head>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar_studio.cfm">
<!--- <center>
<table border=0 cellspacing=0 cellpadding=0 noshade width=640>
  <tr><td colspan=2>
<IMG SRC="#VAROOT#/logos/#get_layout.logo#" width=1003 border=0 alt="Auction Home"><br> 
    <font size=2><font size=3
	><a href="#VAROOT#/index.cfm">Home</a
	>&nbsp;<a href="#VAROOT#/listings/Studio.cfm?/##theLink">Studio</a
	>&nbsp;<a href="#VAROOT#/listings/categories/index.cfm">Listings</a
	>&nbsp;<a href="#VAROOT#/help/index.cfm">Help</a
	>&nbsp;<a href="#VAROOT#/buyers/index.cfm">Buyers</a
	>&nbsp;<a href="#VAROOT#/sellers/index.cfm">Sellers</a
	>&nbsp;<a href="#VAROOT#/search/index.cfm">Search</a
	>&nbsp;<a href="#VAROOT#/help/sitemap.cfm">Site&nbsp;Map</a
	></font></font>
  </td></tr>
</table>
<center>--->
<br>

<A name="theLink"></A>

<SCRIPT LANGUAGE="JavaScript"><!--

<cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"listings\details\","thumbs\")#>   

cells=17
t = new table(cells)
t.border=1

contents = new Array()


for (var i = 0; i <= 16; i++){
  if (i == 16){
    contents[i] = '<Font face="Arial"><textarea name="textfield" <cfif browser is 0>cols="20" rows="8"<cfelse>cols="28" rows="9"</cfif> wrap="VIRTUAL" onFocus="textfield.blur()">WELCOME!\nThis is your Thumbnails Catalog. You will be able to select an auctioned item by clicking on its picture. This catalog contains only those items that the sellers deem to deserve special attention.  As such it does not encompass all items, but it sure makes the navigation of our auction site much easier and fun.\n\rEnjoy!</textarea></font><br>'
  	}else{
    if ((#category# == 0)&&("#featured#" == "FALSE")&&("#hot_auctions#" == "FALSE")){
      <cfset #session.featured# = "TRUE">
	  	  
      if ((i > 12)&&(i < 16)){
        contents[i] = "<IMG SRC='../images/Welcome"+[i+3]+".jpg' border='0'>"
      }else{	
        contents[i] = "<IMG SRC='../images/Welcome"+[i+1]+".jpg' border='0'>"
      }
	
    }else{ 
      if ((i > 12)&&(i < 16)){
        if (i <= ITEMNUM.length-1){
          contents[i] = '<a href="../listings/details/index.cfm?itemnum='+ITEMNUM[i]+'" onmouseOver=javascript:buildText(document.img'+i+'.src);return true onmouseOut="javascript:statistics()"><IMG SRC="../thumbs/'+theFileName[i]+'" border="0" name="img'+i+'" width=124 height=110></a>'
        }else{
          contents[i] = "<a href='' onmouseOver='javascript:notes()'><IMG SRC='../images/dummy.gif' width='124 height='110' border='0'></a>"  	  
        }
      }else{
        if (i <= ITEMNUM.length-1){      
           contents[i] = '<a href="../listings/details/index.cfm?itemnum='+ITEMNUM[i]+'" onmouseOver=javascript:buildText(document.img'+i+'.src);return true onmouseOut="javascript:statistics()"><IMG SRC="../thumbs/'+theFileName[i]+'" border="0" name="img'+i+'" width=124 height=110></a>'           
     	  }else{
          contents[i] = "<a href='' onmouseOver='javascript:notes()'><IMG SRC='../images/dummy.gif' border='0'></a>"  	  
        }
      }    	  
    }
  }
}  


 
t.set(contents)
t.write(document)


if (maxpics > 16){
  y=17
  for(var x=0;x<=15;++x){
    pre_load="image"+x
    pre_load = new Image();
    pre_load.src = "../thumbs/"+ITEMNUM[y]+".jpg'";
    ++y
  }
}

// --></SCRIPT>
<center>
<!---<font size=2><font size=3
	><a href="#VAROOT#/index.cfm">Home</a
	>&nbsp;<a href="#VAROOT#/listings/Studio.cfm?/##theLink">Studio</a
	>&nbsp;<a href="#VAROOT#/listings/categories/index.cfm">Listings</a
	>&nbsp;<a href="#VAROOT#/help/index.cfm">Help</a
	>&nbsp;<a href="#VAROOT#/buyers/index.cfm">Buyers</a
	>&nbsp;<a href="#VAROOT#/sellers/index.cfm">Sellers</a
	>&nbsp;<a href="#VAROOT#/search/index.cfm">Search</a
	>&nbsp;<a href="#VAROOT#/help/sitemap.cfm">Site&nbsp;Map</a
	></font></font>
 include copyright information --->
      <table border=0 cellspacing=0 cellpadding=0 noshade width=#get_layout.page_width#>
        <tr>
          <td align=left valign=top><br>
                        <hr size=2 color=#heading_color# width=#get_layout.page_width#>
            <font size=2>
     <cfinclude template="../includes/copyrights_studio.cfm">
               <br>
            </font>
          </td>
        </tr>
      </table>
      <!--- end include copyright information --->
</center>

</body>

</html>
</cfoutput>
