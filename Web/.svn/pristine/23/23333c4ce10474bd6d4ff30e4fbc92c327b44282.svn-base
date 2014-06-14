<!--- /help/fee_schedule.cfm ---><cfset current_page="help">
<!--- TD: make fully multi-language --->

<cfset current_page = "fee_schedule">


<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfparam name="lang_mode" default="0">

<!--- Run a query to find the fee scale --->
<cfquery username="#db_username#" password="#db_password#" name="get_fee_scale" datasource="#DATASOURCE#">
 SELECT pair as scale_fee
   FROM defaults
  WHERE name = 'scale_segment'
  ORDER BY pair
</cfquery>
<cfif get_fee_scale.recordcount eq 0><cfset scale_fee = 0></cfif>
<!--- Run queries to find cat_fee enable --->
  <cfquery username="#db_username#" password="#db_password#" name="get_enable_cat_fee" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='enable_cat_fee'
  </cfquery>
  <cfset #enable_cat_fee# = #get_enable_cat_fee.pair#>
<!--- Run queries to find fee settings --->
<cfquery username="#db_username#" password="#db_password#" name="get_fee_listing" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_listing'
</cfquery>
<cfset #fee_listing# = #get_fee_listing.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_bold" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_bold'
</cfquery>
<cfset #fee_bold# = #get_fee_bold.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_featured" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_featured'
</cfquery>
<cfset #fee_featured# = #get_fee_featured.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_cat" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_feat_cat'
</cfquery>
<cfset #fee_feat_cat# = #get_fee_feat_cat.pair#>

<cfquery username="#db_username#" password="#db_password#" name="get_fee_banner" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_banner'
</cfquery>
<cfset #fee_banner# = #get_fee_banner.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_second_cat" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_second_cat'
</cfquery>
<cfset #fee_second_cat# = #get_fee_second_cat.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_studio" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_studio'
</cfquery>
<cfset #Variables.fee_studio# = #get_fee_studio.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_feat_studio" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_feat_studio'
</cfquery>
<cfset #Variables.fee_feat_studio# = #get_fee_feat_studio.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture1" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture1'
  </cfquery>
  <cfset #Variables.fee_picture1# = #get_fee_picture1.pair#>
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture2" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture2'
  </cfquery>
  <cfset #Variables.fee_picture2# = #get_fee_picture2.pair#>
  
<cfquery username="#db_username#" password="#db_password#" name="get_fee_picture3" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture3'
  </cfquery>
  <cfset #Variables.fee_picture3# = #get_fee_picture3.pair#>
  
  <cfquery username="#db_username#" password="#db_password#" name="get_fee_picture4" datasource="#DATASOURCE#">
   SELECT pair
     FROM defaults
    WHERE name='fee_picture4'
  </cfquery>
  <cfset #Variables.fee_picture4# = #get_fee_picture4.pair#>
  
<cfquery username="#db_username#" password="#db_password#" name="get_fee_reserve_bid" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_reserve_bid'
</cfquery>
<cfset #Variables.fee_reserve_bid# = #get_fee_reserve_bid.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_fee_late_charge" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='fee_late_charge'
</cfquery>
<cfset #fee_late_charge# = #get_fee_late_charge.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_enable_ssl" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='enable_ssl'
</cfquery>
<cfset #enable_ssl# = #get_enable_ssl.pair#>
<cfquery username="#db_username#" password="#db_password#" name="get_enable_iescrow" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='enable_iescrow'
</cfquery>
<cfset #enable_iescrow# = #get_enable_iescrow.pair#>

<cfquery username="#db_username#" password="#db_password#" name="get_enable_thumbs" datasource="#DATASOURCE#">
 SELECT pair
   FROM defaults
  WHERE name='enable_thumbs'
</cfquery>



<cfquery username="#db_username#" password="#db_password#" name="get_siteCurrency" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'site_currency'
</cfquery>
<cfset siteCurrency = Trim(get_siteCurrency.pair)>
  
<html>
  <head>
    <title>Fee Schedule</title>

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>

 <cfoutput><cfinclude template="../includes/bodytag.html"><cfinclude template="../includes/menu_bar.cfm"></cfoutput>
  
  <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><b>
       Fee Schedule
     </b></font></td></tr>
    <tr><td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td></tr>
        <tr>
          <td>
            <font size=3>
              <!--- <cfif #get_fee_scale.recordcount# is 0>
                This auction is free to the public at this time.
              </cfif> --->
              <br>
              <table border=1 cellspacing=0 cellpadding=5 width=100%>
                <!--- Use this code to specify additional items of information
                <tr bgcolor="000080">
                  <td>
                    <font color="ffffff">
                      <b>Heading Here</b>
                  </td>
                </tr>
                <tr>
                  <td>
                    Information Here
                    <br>
                    <br>
                  </td>
                </tr>
                --->
 <cfoutput>     
 				<tr bgcolor="#heading_color#">
                  <td style="color:#heading_fcolor#; font-family:#heading_font#">
                      <b>
                        Auction Fees
                      </b>
                  </td>
                </tr>
</cfoutput>
                <tr>
                  <td>
                    <b>
                    <table border=1 align="center"><tr>
                    <td><font face="helvetica" size=2><b>Per item sale fee<br>sliding scale<br></b></font></td>
                    <td>
					<cfif #get_fee_scale.recordcount# is 0>
                There are no commission fees at this time.
              </cfif>
					
                    <table border=0 cellpadding="5">
<cfoutput>
                      <cfset scaleTable = ArrayNew(1)>
                      <cfloop query="get_fee_scale">
                        <cfset junk = ArrayAppend(scaleTable, get_fee_scale.scale_fee)>
                      </cfloop>
                      <cfloop from="1" to="#ArrayLen(scaleTable)#" index="scaleLine">
                       <cfset curval = listGetAt(scaleTable[scaleLine], 1)>
                       <cfset curtype = listGetAt(scaleTable[scaleLine], 2)>
                       <cfset curfee = listGetAt(scaleTable[scaleLine], 3)>
                       <cfset onLastLine = (scaleLine is ArrayLen(scaleTable))>
                       <cfif not onLastLine>
                         <cfset nextlineval = listGetAt(scaleTable[scaleLine + 1], 1)>
                       </cfif>
                       <cfset oddRow = (scaleLine mod 2 is 0)>
                       <cfif oddRow>
                         <cfset shadeBar = "bgcolor=cccccc">
                       <cfelse>
                         <cfset shadeBar = "">
                       </cfif>
                       <tr #shadeBar#>
                         <td>#numberFormat(curval,numbermask)# #siteCurrency#<cfif onLastLine>+</cfif>

                         </td>
                         <td><cfif not onLastLine> - <cfelse>&nbsp;</cfif></td>
                         <td>
                           <cfif not onLastLine>
                             #numberFormat(nextlineval - 0.01,numbermask)# #siteCurrency#
                           <cfelse>
                              &nbsp;
                           </cfif>
                         </td>
                         <td><cfif curtype is "P">#evaluate ("curfee * 100")#%<cfelse>#numberFormat(curfee,numbermask)# #siteCurrency#</cfif>
                         </td>
                       </tr>
                       <cfset last_pair = get_fee_scale.scale_fee>
                      </cfloop>
</cfoutput>
                    </table>
                    </td></tr></table>
<cfoutput>
                  <br>
                  <br>
                  <table border=1 align="center"><tr><td>
                  <table border=0>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Listing fee:</b></font></td>
				   <cfif enable_cat_fee eq 1>
				   <td align="right" colspan="2"><a href="../listings/categories/cat_fees.cfm" target="_blank">Click Here to see fee</a></td>
				   <cfelse>
                   <td align="right">#REReplace(fee_listing, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
				   </cfif>
                  </tr>
                  <tr bgcolor="cccccc">                 
                   <td><font face="helvetica" size=2><b>Bold name fee:</b></font></td>
                   <td align="right">#REReplace(fee_bold, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Banner line fee:</b></font></td>
                   <td align="right">#REReplace(fee_banner, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
				  
                  <tr bgcolor="cccccc">                 
                   <td><font face="helvetica" size=2><b>Second category fee:</b></font></td>
				   <cfif enable_cat_fee eq 1>
				   <td align="right" colspan="2"><a href="../listings/categories/cat_fees.cfm" target="_blank">Click Here to see fee</a></td>
				   <cfelse>
                   <td align="right">#REReplace(fee_second_cat, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
				   </cfif>
                  </tr>
				  
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Featured in front page fee:</b></font></td>
                   <td align="right">#REReplace(fee_featured, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
                  <tr bgcolor="cccccc">                 
                   <td><font face="helvetica" size=2><b>Featured in category fee:</b></font></td>
                   <td align="right">#REReplace(fee_feat_cat, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>			
                  <tr>                 
                   <td><font face="helvetica" size=2><b>Studio inclusion fee:</b></font></td>
                   <td align="right">#REReplace(fee_studio, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
                  <tr bgcolor="cccccc">                 
                   <td><font face="helvetica" size=2><b>Featured in studio fee:</b></font></td>
                   <td align="right">#REReplace(fee_feat_studio, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Image1 upload fee:</b></font></td>
                   <td align="right">#REReplace(fee_picture1, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
				   <tr>                 
                   <td><font face="helvetica" size=2><b>Image2 upload fee:</b></font></td>
                   <td align="right">#REReplace(fee_picture2, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
				   <tr>                 
                   <td><font face="helvetica" size=2><b>Image3 upload fee:</b></font></td>
                   <td align="right">#REReplace(fee_picture3, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
				  <tr>                 
                   <td><font face="helvetica" size=2><b>Image4 upload fee:</b></font></td>
                   <td align="right">#REReplace(fee_picture4, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
                 
                 
				  <tr bgcolor="cccccc">                 
                   <td><font face="helvetica" size=2><b>Reserve bid fee:</b></font></td>
                   <td align="right">#REReplace(fee_reserve_bid, "[^0-9.]", "", "ALL")#</td>
                   <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                  </tr>
                  <cfif fee_late_charge is not 0>
                    <tr><td colspan=3><hr width=100% size=1  noshade></td></tr>
                    <tr>                 
                     <td><font face="helvetica" size=2><b>Late payment charge:</b></font></td>
                     <td align="right">#REReplace(fee_late_charge, "[^0-9.]", "", "ALL")#</td>
                     <td align="right"><font face="helvetica" size=2><b>#siteCurrency#</b></font></td>
                    </tr>
                  </cfif>
                  </table>
                  </td></tr></table>
</cfoutput>
                    </b>
                    <br>
                    <br>
                  </td>
                </tr>
              </table>
            </font>
          </td>
        </tr></table><cfoutput>
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
