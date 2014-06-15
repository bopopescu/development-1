<cfsetting enablecfoutputonly="no">
<!---
  Import data from text file:
  import.cfm
  Phillip Nguyen 6-19-01
--->



<!--- define cache control page --->
<cfset current_page = "import">
<cfinclude template = "../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Include EPOCH module  --->
<CFMODULE TEMPLATE="../functions/epoch.cfm">

<cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0) or session.user_id eq 0 or session.password eq 0>
  <cflocation url="../personal/index.cfm">
 </cfif>
 
 <cfparam name="message" default="">

<!--- <cfset curPath = GetTemplatePath()>
    <cfset directory1 = replace(GetDirectoryFromPath("#curPath#"), "import", "")>
	<cfset directory2 = GetDirectoryFromPath("#curPath#")> --->
<!--- <CFFILE ACTION="copy"
    SOURCE="#directory1#items.txt"
    DESTINATION="#directory2#items.txt"> --->
	
<cfquery username="#db_username#" password="#db_password#" name="chck_upload_status" datasource="#DATASOURCE#">
SELECT *
FROM upload_status
WHERE id = 1
</cfquery>

<cfif isdefined("form.refresh")>
	<cfif chck_upload_status.status eq 1>
		<cfset error_time = #datediff("n", chck_upload_status.date_uploaded, timenow)#>
		<cfif error_time gte 5>
			<cfquery username="#db_username#" password="#db_password#" name="upd_upload_error" datasource="#DATASOURCE#">
			UPDATE upload_status
			SET status = 0,
				date_uploaded = #createODBCDateTime (timenow)#
			WHERE id = 1
			</cfquery>
			<cfset #curPath2# = GetTemplatePath()>
  			<cfset directory2 = #GetDirectoryFromPath(curPath2)#>
			<cfif fileexists("#directory2#items.txt")>
  				<cffile action="delete"	file="#directory2#items.txt">
			</cfif>
		</cfif>
	</cfif>
</cfif>

<!--- check error --->
<cfif isdefined("submit_file")>
	<cfif isdefined("form.textfile") and form.textfile is "">
		<cfset message = message & "<font color=""red"" size=""3"">Please select file to import.  </font>">
	</cfif>
</cfif>

<cfif message eq "">
<cfif isdefined("submit_file") and chck_upload_status.status eq 0>
<cfparam name="items_list" default="">

<cfquery username="#db_username#" password="#db_password#" name="upd_upload_status1" datasource="#DATASOURCE#">
UPDATE upload_status
SET status = 1,
	date_uploaded = #createODBCDateTime (timenow)#
WHERE id = 1
</cfquery>

<!--- delete all items from items2 before it start new upload--->
<cfquery username="#db_username#" password="#db_password#" name="del_items2" datasource="#DATASOURCE#">
    DELETE
    FROM items2
</cfquery>

<cfif isdefined("form.textfile") and form.textfile is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <!--- <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"import","thumbs")> --->
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.textfile"
      DESTINATION="#directory#"
      nameconflict="overwrite">
  <cfelse>
    <cffile action="upload"
      filefield="form.textfile"
      DESTINATION="#directory#"
      nameconflict="overwrite"><!---       accept='application/txt' --->
  </cfif>
  
  <cfset incoming_file = #URLEncodedFormat(File.ServerFile)#>
  <cfset serverfile_file = #File.ServerFile#>
  
</cfif>  

<cfif #isDefined ("incoming_file")#>
    <cfif IsDefined("serverfile_file") and #serverfile_file# NEQ "">      
      <cfif fileExists("#directory##serverfile_file#")>
        <cffile action="rename"
          SOURCE = "#directory##serverfile_file#"  
          DESTINATION = "#directory#items.txt">
      </cfif>
    <cfelse>
      <cfif fileExists("#directory##incoming_file#")>
        <cffile action="rename"
          SOURCE = "#directory##incoming_file#"  
          DESTINATION = "#directory#items.txt">
      </cfif>
    </cfif>  
  </cfif>

<!---
<CFSTOREDPROC PROCEDURE="import_text"
    DATASOURCE="#datasource#"    USERNAME="yourusername"
    PASSWORD="yourpassword"    DBSERVER="yourdbserver"    DBNAME="armsbid"
    RETURNCODE="YES"    DEBUG>
</CFSTOREDPROC>

--->


<cfhttp  url="http://#site_address##varoot#/import/items.txt"
method="GET"
timeout="300"
name="import"
columns="category1,category2,auction_type,title,auction_mode,minimum_bid,maximum_bid,location,country,pay_morder_ccheck,pay_cod,pay_see_desc,pay_pcheck,pay_ol_escrow,pay_other,pay_visa_mc,pay_am_express,pay_discover,ship_sell_pays,ship_buy_pays_act,ship_see_desc,ship_buy_pays_fxd,ship_international,description,picture,sound,quantity,increment_valu,dynamic,dynamic_valu,reserve_bid,bold_title,featured,featured_cat,private,banner,banner_line,date_end,buynow_price,auto_relist"
delimiter="#CHR(9)#"
textqualifier=" "
      >     


<cfoutput query="import">
     <cfquery  name="uploadData"  datasource="#datasource#">
          INSERT INTO items2 (category1,category2,auction_type,title,auction_mode,minimum_bid,maximum_bid,location,country,pay_morder_ccheck,pay_cod,pay_see_desc,pay_pcheck,pay_ol_escrow,pay_other,pay_visa_mc,pay_am_express,pay_discover,ship_sell_pays,ship_buy_pays_act,ship_see_desc,ship_buy_pays_fxd,ship_international,description,picture,sound,quantity,increment_valu,dynamic,dynamic_valu,reserve_bid,bold_title,featured,featured_cat,private,banner,banner_line,date_end,buynow_price,auto_relist)
          VALUES (<cfif category1 neq "" and isnumeric(category1)>#category1#<cfelse>0</cfif>,
		  		  <cfif category2 neq "" and isnumeric(category2)>#category2#<cfelse>-1</cfif>,
				  '#auction_type#',
				  '#title#',
				  <cfif auction_mode neq "" and isnumeric(auction_mode)>#auction_mode#<cfelse>0</cfif>,
				  <cfif minimum_bid neq "" and isnumeric(minimum_bid)>#minimum_bid#<cfelse>1</cfif>,
				  <cfif maximum_bid neq "" and isnumeric(maximum_bid)>#maximum_bid#<cfelse>0</cfif>,
				  '#location#',
				  '#country#',
				  <cfif pay_morder_ccheck neq "" and isnumeric(pay_morder_ccheck)>#pay_morder_ccheck#<cfelse>0</cfif>,
				  <cfif pay_cod neq "" and isnumeric(pay_cod)>#pay_cod#<cfelse>0</cfif>,
				  <cfif pay_see_desc neq "" and isnumeric(pay_see_desc)>#pay_see_desc#<cfelse>0</cfif>,
				  <cfif pay_pcheck neq "" and isnumeric(pay_pcheck)>#pay_pcheck#<cfelse>0</cfif>,
				  <cfif pay_ol_escrow neq "" and isnumeric(pay_ol_escrow)>#pay_ol_escrow#<cfelse>0</cfif>,
				  <cfif pay_other neq "" and isnumeric(pay_other)>#pay_other#<cfelse>0</cfif>,
				  <cfif pay_visa_mc neq "" and isnumeric(pay_visa_mc)>#pay_visa_mc#<cfelse>0</cfif>,
				  <cfif pay_am_express neq "" and isnumeric(pay_am_express)>#pay_am_express#<cfelse>0</cfif>,
				  <cfif pay_discover neq "" and isnumeric(pay_discover)>#pay_discover#<cfelse>0</cfif>,
				  <cfif ship_sell_pays neq "" and isnumeric(ship_sell_pays)>#ship_sell_pays#<cfelse>0</cfif>,
				  <cfif ship_buy_pays_act neq "" and isnumeric(ship_buy_pays_act)>#ship_buy_pays_act#<cfelse>0</cfif>,
				  <cfif ship_see_desc neq "" and isnumeric(ship_see_desc)>#ship_see_desc#<cfelse>0</cfif>,
				  <cfif ship_buy_pays_fxd neq "" and isnumeric(ship_buy_pays_fxd)>#ship_buy_pays_fxd#<cfelse>0</cfif>,
				  <cfif ship_international neq "" and isnumeric(ship_international)>#ship_international#<cfelse>0</cfif>,
				  '#description#',
				  '#picture#',
				  '#sound#',
				  <cfif quantity neq "" and isnumeric(quantity)>#quantity#<cfelse>1</cfif>,
				  <cfif increment_valu neq "" and isnumeric(increment_valu)>#increment_valu#<cfelse>0.01</cfif>,
				  <cfif dynamic neq "" and isnumeric(dynamic)>#dynamic#<cfelse>0</cfif>,
				  <cfif dynamic_valu neq "" and isnumeric(dynamic_valu)>#dynamic_valu#<cfelse>2</cfif>,
				  <cfif reserve_bid neq "" and isnumeric(reserve_bid)>#reserve_bid#<cfelse>0</cfif>,
				  <cfif bold_title neq "" and isnumeric(bold_title)>#bold_title#<cfelse>0</cfif>,
				  <cfif featured neq "" and isnumeric(featured)>#featured#<cfelse>0</cfif>,
				  <cfif featured_cat neq "" and isnumeric(featured_cat)>#featured_cat#<cfelse>0</cfif>,
				  <cfif private neq "" and isnumeric(private)>#private#<cfelse>0</cfif>,
				  <cfif banner neq "" and isnumeric(banner)>#banner#<cfelse>0</cfif>,
				  '#banner_line#',
				  '#date_end#',
				  <cfif buynow_price neq "" and isnumeric(buynow_price)>#buynow_price#<cfelse>0</cfif>,
				  <cfif auto_relist neq "" and isnumeric(auto_relist)>#auto_relist#<cfelse>0</cfif>
				  )

     </cfquery>     
</cfoutput>      




<cfif fileexists("#directory#items.txt")>
  <cffile action="delete"	file="#directory#items.txt">
</cfif>



<!--- get user infos --->
<cfquery username="#db_username#" password="#db_password#" name="get_user_infos" datasource="#DATASOURCE#">
    SELECT *
    FROM users
	WHERE user_id = #session.user_id#
</cfquery>


<!--- get all items from items2 --->
<cfquery username="#db_username#" password="#db_password#" name="get_items2" datasource="#DATASOURCE#">
    SELECT *
    FROM items2
</cfquery>

<cfloop query="get_items2">

	<!--- Check to see if the EPOCH value has been used before ---> 
<!--- Set the Condition of the loop to true --->
<cfset #loop_again# = "1">
<cfloop condition="loop_again IS 1">
	<cfif isdefined("epoch_plus")>
 		<cfset epoch = epoch_plus>
	</cfif>
  <cfquery username="#db_username#" password="#db_password#" name="EPOCH_check" DATASOURCE="#DATASOURCE#">
       SELECT itemnum
         FROM items
        WHERE itemnum = #EPOCH#
  </cfquery>
  <cfif EPOCH_check.recordcount GT 0>
    <cfset #EPOCH#=#EPOCH# + 1>
  <cfelse>
    <cfset #loop_again#=0>
	<cfset epoch_plus=#EPOCH# + 1>
  </cfif>
</cfloop>

<!--- Fill in vars for the old item, but with a new item # --->
  <cfset #itemnum# = "#EPOCH#">
  <!--- set date end with timenow minute --->
  <cfset date_end = dateformat(date_end, "mm/dd/yyyy") & " " & #timeformat(timenow, "h:mm:ss tt")#>
  
  <!--- check title and banner line exceed limit --->
  <cfif len(title) gt 250>
  	<cfset title2 = left(title,250)>
  	<cfmail from="customer_service@#domain#" to="#get_user_infos.email#" subject="Truncated title" type="HTML">
		The item's title was truncated by system<br><br>
		
		Item: <a href="http://#site_address##varoot#/listings/details/index.cfm?itemnum=#itemnum#">#itemnum#</a> (#title2#)<br><br>
				
		Thank you for using our services,<br>
  		#COMPANY_NAME#
	</cfmail>
  <cfelse>
  	<cfset title2 = title>
  </cfif>
  <cfif len(banner_line) gt 90>
  	<cfset banner_line2 = left(banner_line,90)>
  	<cfmail from="customer_service@#domain#" to="#get_user_infos.email#" subject="Truncated banner line" type="HTML">
		The item's banner line was truncated by system<br><br>
		
		Item: <a href="http://#site_address##varoot#/listings/details/index.cfm?itemnum=#itemnum#">#itemnum#</a> (#title#)<br>
		Banner line: (#banner_line2#)<br><br>
				
		Thank you for using our services,<br>
  		#COMPANY_NAME#
	</cfmail>
  <cfelse>
  	<cfset banner_line2 = banner_line>
  </cfif>
  <!--- end of checking --->
  
	<!--- get all items from items2 --->
	<cfquery username="#db_username#" password="#db_password#" name="insert_items" datasource="#DATASOURCE#">
    INSERT INTO items
           (itemnum,
		    status,
            user_id,
            category1,
            category2,
            title,
            location,
            country,
			pay_morder_ccheck,
            pay_cod,
            pay_see_desc,
            pay_pcheck,
            pay_ol_escrow,
            pay_other,
            pay_visa_mc,
            pay_am_express,
            pay_discover,
			ship_sell_pays,
            ship_buy_pays_act,
            ship_see_desc,
            ship_buy_pays_fxd,
            ship_international,
            description,
            desc_languages,
			picture,
			picture1,
            sound,
            quantity,
            minimum_bid,
			maximum_bid,
            increment,
            increment_valu,
            dynamic,
            dynamic_valu,
            reserve_bid,
            bold_title,
            featured,
            featured_cat,
            private,
            <!--- inspector, --->
            banner,
            banner_line,
            studio,
            featured_studio,
            picture_studio,
            sound_studio,
            date_start,
            date_end,
            billmeth,
            remote_ip,
            auction_type,
			auction_mode,
			hide,
			auto_relist,
			buynow,
			buynow_price,
			org_quantity)
     VALUES (#epoch#,
	 		 1,
             #session.user_id#,
             #category1#,
             #category2#,
             '#variables.title2#',
             '#location#',
             '#country#',
			 #pay_morder_ccheck#,
             #pay_cod#,
             #pay_see_desc#,
             #pay_pcheck#,
             #pay_ol_escrow#,
             #pay_other#,
             #pay_visa_mc#,
             #pay_am_express#,
             #pay_discover#,
			 #ship_sell_pays#,
             #ship_buy_pays_act#,
             #ship_see_desc#,
             #ship_buy_pays_fxd#,
             #ship_international#,
             <cfif #description# neq "">'#description#'<cfelse>'No description availble'</cfif>,
             'en',
			 '#picture#',
			 '',
             '#sound#',
             #quantity#,
             #minimum_bid#,
			 #maximum_bid#,
             1,
             #increment_valu#,
             #dynamic#,
             #dynamic_valu#,
             #reserve_bid#,
             #bold_title#,
             #featured#,
             #featured_cat#,
             #private#,
             <!--- '#inspector#', --->
             #banner#,
             '#variables.banner_line2#',
             0,
             0,
             'http://',
             'http://',
             #createODBCDateTime (timenow)#,
             #createODBCDateTime (variables.date_end)#,
             'BM',
             '#cgi.remote_addr#',
             '#auction_type#',
			 #auction_mode#,
			 0,
			 #auto_relist#,
			 <cfif buynow_price gt 0 and buynow_price gt minimum_bid>1<cfelse>0</cfif>,
			 #buynow_price#,
			 #quantity#)
	</cfquery>
	<cfset items_list = #listappend(items_list,epoch)#>
</cfloop>



<cfif items_list neq "">
<cfquery username="#db_username#" password="#db_password#" name="get_uploaded_items" datasource="#DATASOURCE#">
    SELECT itemnum, title
    FROM items
	WHERE itemnum in (#items_list#)
</cfquery>

<cfmail from="customer_service@#domain#" to="#get_user_infos.email#" subject="Upload items information" type="HTML">
<html>
<head>
	<title>SupremeBids Bulkloader</title>
</head>

<body>
<table>
	<tr><td colspan="2">A list of items has been added to our item database.</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr>
		<th>Itemnum</th>
		<td align="left"><b>Title</b></td>
	</tr>
	<cfloop query="get_uploaded_items">
	<tr>
		<td width="100"><a href="http://#site_address##varoot#/listings/details/index.cfm?itemnum=#itemnum#">#itemnum#</a></td>
		<td width="400">#title#</td>
	</tr>
	</cfloop>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr>
		<td align="left" colspan="2">
		Thank you for using our services,<br>
  		#COMPANY_NAME#
		</td>
    </tr>
</table>

</body>
</html>
</cfmail>
</cfif>

<!--- delete all items from items2 after it is done--->
<cfquery username="#db_username#" password="#db_password#" name="del_items2" datasource="#DATASOURCE#">
    DELETE
    FROM items2
</cfquery>
<!---
<cfif fileexists("#directory#items.txt")>
  <cffile action="delete"	file="#directory#items.txt">
</cfif>

--->
<!--- <cfloop from="1" to="100000" index="I">
	<cfset I = incrementvalue(I)>
	</cfloop> --->
<cfquery username="#db_username#" password="#db_password#" name="upd_upload_status1" datasource="#DATASOURCE#">
UPDATE upload_status
SET status = 0,
	date_uploaded = #createODBCDateTime (timenow)#
WHERE id = 1
</cfquery>

<!--- log account import text file into database --->
<cfif items_list neq "">
   <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="import text file into database by #session.nickname#"
      details="USER: #session.user_id#">
<cfset message = "<font color=""0000ff"">You have uploaded a file successffully ""#File.Serverfile#"".</font>">
<cfelse>
<cfset message = "<font color=""ff0000"">There has been a problem uploading your file ""#File.Serverfile#"".  Please try again A.</font>">
</cfif>
<!--- <cfoutput><cflocation url="import.cfm?message=#message#" addtoken="No"></cfoutput> --->
<cfelseif isdefined("submit_file") and chck_upload_status.status eq 1>
<cfset message = "<font color=""ff0000"">There has been a problem uploading your file ""#File.Serverfile#"".  Please try again B.</font>">
</cfif>
</cfif>
<cfsetting enablecfoutputonly="no">
<html>
<head>
	<title>Bulk Upload (tab delimited *.txt)</title>
	<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
</head>

<cfoutput>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<center>
<table border=2 cellspacing=2 cellpadding=2 width=640>
<form action="import.cfm" enctype="multipart/form-data" method="post">
    <!--- <tr><td><center><IMG SRC="#VAROOT#/images/logohere.gif"> &nbsp; &nbsp; &nbsp; <FONT SIZE=2><cfinclude template="../includes/menu_bar.cfm"></FONT></center></td></tr> --->
    <tr><td><font size=4><b>Post bulk Auctions Page</b></font></td></tr>

    <tr><td><hr size=2 noshade></td></tr>
    <tr>
     <td>
      <font size=2>
      <b>This page allows you to upload a text file into the database. (3000 items max.)</b><br>
	   <OL>
	   <li>Step 1. Click here to get the <a href="xls_template/items_template.xls" target="_blank">preformatted excel file</a>. 
           <li>Step 2. Click here to get the <a href="data_info.cfm" target="_blank">Data type and category information</a>
	   <li>Change new auction info on the example record (if you have more than one auction, copy the previous record and paste as a new record and change the auction info).
	   <li>Save as a text file(tab delimited required).
	   <li>Use the browse button below to select the file.
	   <li>Use the upload button below to upload the file.
	   </OL>
      </font>
	  </td>
	 </tr>
	 <tr>
	 	<td nowrap><cfif chck_upload_status.status eq 0><font color="Green"><b>The system is available to upload file.  Please click the refresh button below to get current status.</b></font><cfelse><font color="red"><b>The system is not available to upload file.  Please refresh this page to get current status.</b></font></cfif></td>
	 </tr>
	 <cfif isdefined("message") and message neq "">
	 <tr>
	 	<td><font color="0000ff"><b>#message#</b></font></td>
	 </tr>
	 </cfif>
	 <cfif chck_upload_status.status eq 0>
	 <tr>
	 	<td><font color="0000ff">Select file:<input type="file" name="textfile" size="40" maxlength="100"></font></td>
	 </tr>
	 <tr>
	 	<td><input type="Submit" name="submit_file" value="Upload"><br><br><font color="red" size="1">Note: System allows *.txt tab delimited file only and 3000 records maximum for each upload.</font></td>
	 </tr>
	 </cfif>
	 </form>
	 <tr><td><hr size=1 noshade></td></tr>
	 <tr>
	 	<td>
		<table>
		<tr>
		<td>
		<form action="../personal/main_page.cfm" method="post">
         <input type="submit" name="done" value="Done" width=75>
        </form>
		</td>
		<td>
		<form action="import.cfm" method="post">
         <input type="submit" name="refresh" value="Refresh" width=75>
        </form>
		</td>
		</tr>
		</table>
		</td>
	 </tr>
</table>
</center>
</cfoutput>
</body>
</html>