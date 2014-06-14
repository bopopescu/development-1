<CFSET BROWSER = CGI.HTTP_USER_AGENT>
<cfset browser = find("MSIE",browser)>

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfoutput>

<cfset theDay     = DatePart('d',#TIMENOW#)>
<cfset theMonth   = DatePart('m',#TIMENOW#)-1>
<cfset theYear    = Right(DatePart('YYYY',#TIMENOW#),2)>
<cfset theHours   = DatePart('h',#TIMENOW#)>
<cfset theMins    = DatePart('n',#TIMENOW#)>
<cfset theSecs    = DatePart('s',#TIMENOW#)>
<cfset ServerTime_string = "#theYear#,#theMonth#,#theDay#,#theHours#,#theMins#,#theSecs#">

<cfset theDay     = DatePart('d',hAuctionComplete.tsDateEnd)>
<cfset theMonth   = DatePart('m',hAuctionComplete.tsDateEnd)-1>
<cfset theYear    = Right(DatePart('YYYY',hAuctionComplete.tsDateEnd),2)>
<cfset theHours   = DatePart('h',hAuctionComplete.tsDateEnd)>
<cfset theMins    = DatePart('n',hAuctionComplete.tsDateEnd)>
<cfset theSecs    = DatePart('s',hAuctionComplete.tsDateEnd)>
<cfset DateEnd_string = "#theYear#,#theMonth#,#theDay#,#theHours#,#theMins#,#theSecs#">

<script language="JavaScript1.2">

var occasion=""
var message_on_occasion='<center><font face="Arial" size="3" color="red"><b>Completed!</b><font></center>'

var countdownwidth='218px'
var countdownheight='20px'
var countdownbgcolor='lightblue'
var opentags='<center><font face="Verdana"><small>'
var closetags='</small></font></center>'
var countdownleft=430

if (#get_ItemInfo.featured_studio# ==1){
  var countdowntop=200
}else{
  var countdowntop=90
}  

var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

function start_countdown(){
  if (document.layers){
    document.countdownnsmain.visibility="show"
  }  
  countdown()
}


if (document.all){
  document.write('<span id="countdownie" style="position: absolute; width:'+countdownwidth+'; height:'+countdownheight+'; top:'+countdowntop+'; left:'+countdownleft+'; background-color:'+countdownbgcolor+'"></span>')
}

window.onload=start_countdown




serverTime=Date.parse(new Date(#ServerTime_string#))
systemTime=Date.parse(Date())
theDifference=(Date.parse(new Date(#ServerTime_string#))-Date.parse(Date()))
futurestring=Date.parse(new Date(#DateEnd_string#))-theDifference

label1="Time left : <b>"





function countdown(){
  var today=new Date()
  var todayy=today.getYear()
  if (todayy < 1000){todayy+=1900}
  var todaym=today.getMonth()
  var todayd=today.getDate()
  var todayh=today.getHours()
  var todaymin=today.getMinutes()
  var todaysec=today.getSeconds()
  var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec

  dd=futurestring-(Date.parse(todaystring))
  dday=Math.floor(dd/(60*60*1000*24)*1)
  dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1)
  dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1)
  dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1)
  if(dday<=0&&dhour<=0&&dmin<=0&&dsec<=1){
    if (document.layers){
      document.countdownnsmain.document.countdownnssub.document.write(opentags+message_on_occasion+closetags)
      document.countdownnsmain.document.countdownnssub.document.close()
    }else if (document.all){
      countdownie.innerHTML=opentags+message_on_occasion+closetags
      return
    }      
  }else{
    if (dday == 0){dday = ""}
    if (dday == 1){dday=dday+" day + "}
    if (dday > 1){dday=dday+" days + "}
    if (document.layers){
      document.countdownnsmain.document.countdownnssub.document.write(opentags+label1+dday+dhour+":"+dmin+":"+dsec+closetags)
      document.countdownnsmain.document.countdownnssub.document.close()
    }else if (document.all)
      countdownie.innerHTML=opentags+label1+dday+dhour+":"+dmin+":"+dsec+closetags
    }
    setTimeout("countdown()",1000)
  }




</script>


<ilayer id="countdownnsmain" width=&{countdownwidth}; height=&{countdownheight}; bgColor=&{countdownbgcolor}; left=&{countdownleft}; top=&{countdowntop}; visibility=hide>
<layer id="countdownnssub" width=&{countdownwidth}; height=&{countdownheight}; left=0 top=0></layer></ilayer>



</cfoutput>