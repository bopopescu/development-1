<!--- Modified 10/30/11 - JM --->

<cfsetting enablecfoutputonly="yes">
<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfif #isDefined ("from_search")#>
   <cfset from_search = #from_search#>
<cfelse>
   <cfset from_search = 0>
</cfif>
<cfif #isDefined ("submit")# is 0>
   <cfset #submit# = 0>
</cfif>
<cfif #trim(submit)# is "Back">
  <cfif #curr_lvl# EQ 1>
     <cfif #from_search# EQ 1>
        <cflocation url="#VAROOT#/search/index.cfm?curr_cat=S&curr_lvl=0">
     </cfif>
     <cfset curr_cat = #session.prev_cat0#>
     <cfset curr_lvl = #session.prev_lvl0#>
  <cfelseif #curr_lvl# EQ 2>
     <cfset curr_cat = #session.prev_cat1#>
     <cfset curr_lvl = #session.prev_lvl1#>
  <cfelseif #curr_lvl# EQ 3>
     <cfset curr_cat = #session.prev_cat2#>
     <cfset curr_lvl = #session.prev_lvl2#>
  <cfelseif #curr_lvl# EQ 3>
     <cfset curr_cat = #session.prev_cat3#>
     <cfset curr_lvl = #session.prev_lvl3#>
  </cfif>
<cfelse>
  <cfif #curr_lvl# EQ 0>
     <cfset session.prev_cat0 = #curr_cat#>
     <cfset session.prev_lvl0 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 1>
     <cfset session.prev_cat1 = #curr_cat#>
     <cfset session.prev_lvl1 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 2>
     <cfset session.prev_cat2 = #curr_cat#>
     <cfset session.prev_lvl2 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 3>
     <cfset session.prev_cat3 = #curr_cat#>
     <cfset session.prev_lvl3 = #curr_lvl#>
  <cfelseif #curr_lvl# EQ 4>
     <cfset session.prev_cat4 = #curr_cat#>
     <cfset session.prev_lvl4 = #curr_lvl#>
  </cfif>
</cfif>
<cfif isDefined("gencat")>
  <cfset gencat = #gencat#>
<cfelse>
  <cfset gencat = "S">
</cfif>
<cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#DATASOURCE#">
    SELECT category, name, date_created, child_count, count_total, this_lvl
      FROM categories
     WHERE active = 1
     <cfif #curr_lvl# EQ 0>
       AND parent = 0
     <cfelseif #curr_lvl# EQ 1>
       AND lvl_1 = #curr_cat# AND category <> #curr_cat#
     <cfelseif #curr_lvl# EQ 2>
       AND lvl_2 = #curr_cat# AND category <> #curr_cat#
     <cfelseif #curr_lvl# EQ 3>
       AND lvl_3 = #curr_cat# AND category <> #curr_cat#
     <cfelseif #curr_lvl# EQ 4>
       AND lvl_4 = #curr_cat# AND category <> #curr_cat#
     </cfif>
     ORDER BY name ASC
</cfquery>


<!--- StartRow is the default starting row for the output.
      DisplayRows determines how many records to display at a time --->
<CFPARAM NAME="StartRow" DEFAULT="1">
<CFPARAM NAME="DisplayRows" DEFAULT="4">	



<!--- query the table. Cache the result set for 15 
      minutes. --->
<cfquery username="#db_username#" password="#db_password#" name="get_Items" datasource="#DATASOURCE#"
   CACHEDWITHIN="#CreateTimeSpan(0,0,15,0)#">
    SELECT itemnum, category1, name, list_type, sire, buynow_price, minimum_bid, date_end, picture1, pri_breed, year_foaled, color
      FROM items 
</cfquery>


		 <!--- Set a variable to hold the record number of the last
      record to output on the current page. --->
<CFSET ToRow = StartRow + (DisplayRows - 1)>
<CFIF ToRow GT get_Items.RecordCount>
    <CFSET ToRow = get_Items.RecordCount>
</CFIF>

<html>
<HEAD>
	<title>Equibidz Auction Listing</title>
</head>

<body>
 
<!--- Output the range of records displayed on the page as well as the total 
      number of records in the result set --->
<CFOUTPUT>
<H4>Displaying records #StartRow# - #ToRow# from the 
#get_Items.RecordCount# total records in the database.</H4>
</CFOUTPUT>

<!--- create the header for the table --->
<TABLE CELLPADDING="3" CELLSPACING="0">
<TR BGCOLOR="#888888">
  <TH>Name</TH>
  <TH>Title</TH>
  <TH>Department</TH>
  <TH>E-mail</TH>
  <TH>Phone Extension</TH>
</TR>    

<!--- dynamically create the rest of the table and output the number of
      records specified in the DisplayRows variable --->

<CFOUTPUT QUERY="get_Items" STARTROW="#StartRow#"
          MAXROWS="#DisplayRows#">
<TR BGCOLOR="##C0C0C0">
  <TD>#itemnum#</TD>
  <TD>#category1#</TD>
  <TD>#name#</TD>
  <TD>#list_type#</TD>
  <TD>#sire#</TD>
</TR>    
</CFOUTPUT>
</TABLE>
 
<!--- update the values for the next and previous rows to be returned --->
<CFSET Next = StartRow + DisplayRows>
<CFSET Previous = StartRow - DisplayRows>
 
<!--- Create a previous records link if the records being displayed aren't the
      first set --->
<CFOUTPUT>
<CFIF Previous GTE 1>
   <A HREF="index.cfm?StartRow=#Previous#"><B>Previous #DisplayRows# 
      Records</B></A>
<CFELSE>
Previous Records  
</CFIF>
 
<B>|</B>
 
<!--- Create a next records link if there are more records in the record set 
      that haven't yet been displayed. --->
<CFIF Next LTE get_Items.RecordCount>
    <A HREF="index.cfm?StartRow=#Next#"><B>Next 
    <CFIF (get_Items.RecordCount - Next) LT DisplayRows>
      #Evaluate((get_Items.RecordCount - Next)+1)#
    <CFELSE>
      #DisplayRows#
    </CFIF>  Records</B></A>
<CFELSE>
Next Records   
</CFIF>
</CFOUTPUT>
</TABLE>
 
</BODY>
</HTML>
		 
<CFOUTPUT>		 
		 
		 
		 
		  		
		<tr>
			<td align="left">
				<cfinclude template="../includes/copyrights.cfm">
			</td>
		</tr>
	</td>
</tr>
<table>
</div>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="no">
