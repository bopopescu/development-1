
 
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 
 <cfif isDefined('session.user_id') is 0>
<cflocation url="/login.cfm?login=1&path=#script_name#">
</cfif>
  
 
 <!--- define TIMENOW --->
 <cfmodule template="../functions/timenow.cfm">
 
 <cfparam name="limit_results" default="">
 <cfparam name="search_text" default="">
<cfparam name="status" default = "1">
<!--- AND user_id = #session.user_id#
  --->
<cfif search_text neq "" and limit_results eq "title">
 <cfset search_text = #trim(search_text)#>
 <cfset search_text = "#rereplace(search_text,"#chr(44)#"," ","ALL")#">
<cfset search_text = "#rereplace(search_text,"#chr(45)#"," ","ALL")#">
<cfset search_text = "#rereplace(search_text,"#chr(95)#"," ","ALL")#">
<cfset search_text = "#rereplace(search_text,"#chr(38)#"," ","ALL")#">
<cfset search_text = "#rereplace(search_text,"#chr(47)#"," ","ALL")#">
<cfset search_text = "#rereplace(search_text,"#chr(35)#"," ","ALL")#">
<cfset search_text = "#rereplace(search_text,"#chr(33)#"," ","ALL")#"> 
<cfset search_text = rereplace(search_text, "'","'' ","ALL")>
<cfset search_text = " #search_text#"> 
<!--- <cfset search_text = #trim(search_text)#>
 
 <cfset search_text = ReplaceNoCase(search_text, "!", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "@", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "##", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "$", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "%", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "^", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "&", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "*", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "(", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, ")", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "_", "#chr(222)#", "ALL")>
 <cfset search_text = ReplaceNoCase(search_text, "-", "#chr(222)#", "ALL")> 
<cfset search_text = ReplaceNoCase(search_text, "+", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "=", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "{", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "}", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "|", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "[", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "]", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "\", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, ",", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "<", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, ">", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "?", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, ":", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, ";", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, """", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "'", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text, "/", "#chr(222)#", "ALL")>
<cfset search_text = ReplaceNoCase(search_text,"#chr(8482)#", "#chr(222)#","ALL")> 
<cfset search_text = ReplaceNoCase(search_text,"#chr(174)#", "#chr(222)#","ALL")> 
<cfset search_text = ReplaceNoCase(search_text,"#chr(176)#", "#chr(222)#","ALL")> --->
<cfset logOperator = "AND">

       <cfset field = "title">
	   
        <cfset sql_code = "">
        <cfset counter = 1>
        <cfloop index="l" list="#search_text#" delimiters=" ">
          <cfset logOp = IIf(counter LT ListLen(search_text, " "), "logOperator", DE(""))>
			<cfset sql_code = "#sql_code#  #field# LIKE '%#l#%' #logOp#"> 
        
          <cfset counter = counter + 1>
        </cfloop> 

         <cfset sql_code = "WHERE #sql_code# AND user_id = #session.user_id# and quantity = org_quantity AND status = 0">
		 
	<cfelseif search_text neq "" and limit_results eq "itemnum">
	<cfset search_text = rereplace(search_text, "[^0-9]","","ALL")>	 
		 
		 </cfif>


<cfquery name="getItems" datasource="#DATASOURCE#" dbtype="ODBC">
SELECT user_id,quantity,itemnum,status, title,date_start, date_end,  minimum_bid, buynow_price FROM   items 

<cfif search_text eq "">
WHERE  user_id = #session.user_id#
 and quantity = org_quantity 
AND status = 0
  <cfelse>

<cfif limit_results eq "title">
#PreserveSingleQuotes(sql_code)#

<cfelseif limit_results eq "itemnum">
WHERE  itemnum = #search_text#
AND user_id = #session.user_id#
and quantity = org_quantity
AND status = 0
</cfif>
</cfif>
 

 
</cfquery>

<cfparam name="group" default = "1">
<cfset itemsperpage = 25>
<cfset countgroup = 25>

 <cfset total_messages = getItems.recordcount>
 <cfif total_messages eq 0>
  <cfset total_pages = 1>
<cfelse>
  <cfset total_pages = Ceiling(total_messages / countgroup)>
</cfif>

 <!--- Get the listing background color --->
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #header_bg# = #get_listing_bgcolor.pair#> 
 
 
    
   
    <cfset directory = replace(expandpath(".\"),"personal","thumbs","ALL")>
	<!--- <cfset directory = replace(directory, "dev","www","all")> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Active Items</title>
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<link rel=stylesheet href="/includes/stylesheet.css" type="text/css">
</head>

<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">

<!--- The main table --->
<div align="center">
<TABLE width="<cfoutput>#get_layout.page_width#</cfoutput>" cellpadding=0 cellspacing=0 border=0>
  
  <TR>
    <TD width="<cfoutput>#get_layout.page_width#</cfoutput>">
<TABLE width="100%" border=0>
  
  <TR>
    <TD width="100%">
	  
	
	  
	  
	  </TD></TR></TABLE>
<TABLE width="100%" border=0>
  
  <TR>
    <TD width="100%"><font size=4>Unsold Items</font></TD></TR></TABLE>



<TABLE height=48 width="100%" border=0>
  <form action="unsold_items.cfm" method="get">
  <TR>
    
    <TD width="100%" height=44 rowSpan=2>
      <P align=center><FONT size=3>Search:</FONT>   <INPUT 
      maxLength=129 name="search_text" value="<cfif isDefined('search_text')><cfoutput>#search_text#</cfoutput></cfif>">  <SELECT  size=1 
      name="limit_results"> 
	  
	  <OPTION value="Title" <cfif limit_results eq "Title">selected</cfif>>Item title</OPTION> 
        <OPTION value="itemnum" <cfif limit_results eq "itemnum">selected</cfif>>Item number</OPTION>
		
		</SELECT> <!--- <input type="radio" name="status" value="1" <cfif status eq 1>checked</cfif>> Active <input type="radio" name="status" value="0" <cfif status eq 0>checked</cfif>> Expired  ---> <INPUT type=submit value=Search name=Search></P></TD></TR></form>
  </TABLE>
<TABLE cellPadding=6 width="100%" bgcolor=F2FFCA border=0>
  
  <TR>
    <TD width="100%">
      <TABLE width="100%" border=0>
         <cfset startrow = 1+(int(group-1)*int(countgroup))>
		 <cfset endrow = startrow+(int(countgroup)-1)>
        <TR>
          <TD width="50%">Items Found<cfoutput>(#startrow#-<cfif getItems.recordcount LT endrow>#getItems.recordcount#<cfelse>#endrow#</cfif> of #getItems.recordcount# items)</cfoutput></TD>
          <TD width="50%">&nbsp;</TD></TR></TABLE></TD></TR>
  
  <TR>
    <TD width="100%">
	<table width=100% cellpadding=2 cellspacing=0>
	<tr><td colspan=8> <cfif getItems.recordcount gt countgroup>
	    <br>  Click here for more items: 
                <cfmodule template="../functions/pagelinks.cfm"
                  thispage="#group#"
                  totalpages="#total_pages#"
                  link="#VAROOT#/personal/unsold_items.cfm?user_id=#session.user_id#&status=0&limit_results=#limit_results#&search_text=#urlencodedformat(search_text)#">
	   </cfif></td></tr>
	
	<tr>
	<td><FONT size=2><b>Image</b></FONT></td>	
	<td>
	<cfif getItems.status eq 1><FONT size=2><b>Edit</b></FONT><cfelse><FONT size=2><b>Relist</b></FONT></cfif>
	</td>
	<td><FONT size=2><b>Title</b></FONT>  </td>
	<td><FONT size=2><b>Start Date</b></FONT></td>
	<td><FONT size=2><b>End Date</b></td>
	<td><FONT size=2><b><u>Min Bid</u><br>Price</b></td>
	<td><FONT size=2><b>Qty</b></FONT></td>
	</tr>
	 
<cfset counter = 0>
	<cfset total_quantity = 0>
	<cfset total_bid = 0>
	<cfset total_sales = 0>
	  
         <cfoutput query="getItems" startrow="#startrow#" maxrows="#itemsperpage#">
		 
			   <tr <cfif counter mod 2 eq 1> bgcolor=ffffff<cfelse>bgcolor=dfdfdf</cfif>>
	   <td>
	   <cfif fileexists("#directory##getItems.itemnum#.jpg")>
	   <img src="http://#site_address##varoot#/thumbs/#getItems.itemnum#.jpg" width=76><cfelse>&nbsp;</cfif></td>
       <TD width="54">
	   <cfif getItems.status eq 0>
	   <a href="/personal/relist_info.cfm?itemnum=#getItems.itemnum#"><FONT size="1">(#getItems.itemnum#)</font></a>
<cfelse>
<a href="/personal/edit_info.cfm?itemnum=#getItems.itemnum#"><FONT size="1">(#getItems.itemnum#)</font></a>
</cfif>
</td>
	   
        <td>  <FONT size="1"><A 
            href="/listings/details/index.cfm?itemnum=#itemnum#">#getItems.title#</A></font></td>
<td><FONT size="1"> #dateformat(getItems.date_start,"mm/dd/yyyy")# #timeformat(getItems.date_start,"hh:mm tt")#</FONT></td>  
<td><FONT size="1"> #dateformat(getItems.date_end,"mm/dd/yyyy")# #timeformat(getItems.date_end,"hh:mm tt")#</FONT></td>                                                                                                                                       
        <td><FONT size="1"> <u>#dollarformat(getItems.minimum_bid)#</u><br>#dollarformat(getItems.buynow_price)#</FONT></td>   
		<td><FONT size="1"> #getItems.quantity#</FONT></td>
		
        </TR>
	
	  <cfset counter = incrementValue(counter)>
	  </cfoutput><cfoutput>
	 
	  </table></TD></TR>
  <TR>
    <TD borderColor=d6dcfe width="100%" bgColor=ffffff>
     
			</TD></TR></TABLE></td></tr></table>
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
