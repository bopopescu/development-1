<html>
 <head>
  <title>Personal Page: Item Edit Preview </title>
 </head>

 <cfsetting enablecfoutputonly="Yes">

  <!--- Set a default value for "submit2" and "submit3" if nonexistent --->
 <cfif #isDefined ("submit2")# is 0>
  <cfset #submit2# = "enter">
 <cfelse>
  <cfset #submit2# = #trim (submit2)#>
 </cfif>
 
  <!--- Include session tracking template --->
 <cfinclude template="../includes/session_include.cfm">
 
 <!--- include globals --->
 <cfinclude template="../includes/app_globals.cfm">
 <cfif isdefined('url.selected_item')>
 <cfquery username="#db_username#" password="#db_password#" NAME="getMode" DATASOURCE="#DATASOURCE#" DBTYPE="ODBC">
SELECT auction_mode FROM items
WHERE itemnum = #url.selected_item#
</CFQUERY>
</CFIF>


 <cfif #isDefined ('selected_category')#>
  <cfset #selected_category# = "0">
 </cfif>
 
 <!--- Check to see if we are done looking at the page --->
 <!---<cfif #submit# is "Continue">
  <cfoutput><cflocation url="main_page.cfm"></cfoutput>
 </cfif>
 --->
 <!--- Get a list of active users --->
 <cfquery username="#db_username#" password="#db_password#" name="get_users" datasource="#DATASOURCE#">
  SELECT user_id, name, nickname
    FROM users
   WHERE user_id = #session.user_id#
   ORDER BY nickname
 </cfquery>

 <!--- Get the last user they chose as the seller --->
 <cfquery username="#db_username#" password="#db_password#" name="get_seller" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'last_seller'
 </cfquery>
 
<cfset selected_item = #session.adnum#>

 <!--- Get item information --->
<cfquery username="#db_username#" password="#db_password#" name="get_item" dataSource="#DATASOURCE#">
   SELECT adnum,
          status,
		  title,
          user_id,
          category1,
          category2,
          ad_body,
          ask_price,
          obo,
		  picture_url,
		  date_start,
		  date_end,
		  community_ad,
		  ad_dur,
		  ad_fee,
		  remote_ip
     FROM ad_info
    WHERE adnum = #selected_item#
  </cfquery>
  <cfset #selected_category# = #get_item.category1#>

  <!--- Get the seller's email address --->
  <cfquery username="#db_username#" password="#db_password#" name="get_seller_email" datasource="#DATASOURCE#">
   SELECT email
     FROM users
    WHERE user_id = #get_item.user_id#
  </cfquery>
  <cfset #seller_email# = "#get_seller_email.email#">
  <cfset #session.seller_email# = "#get_seller_email.email#">

  <cfset #adnum# = "#get_item.adnum#">
  <cfset #session.adnum# = "#get_item.adnum#">
  <cfset #title# = "#get_item.title#">
  <cfset #session.title# = "#get_item.title#">
  <cfset #the_item# = "#get_item.adnum#">
  <cfset #session.the_item# = "#get_item.adnum#">
  <cfset #status# = "#get_item.status#">
  <cfset #user_id# = "#get_item.user_id#">
  <cfset #session.user_id# = "#get_item.user_id#">
  <cfset #category1# = "#get_item.category1#">
  <cfset #category2# = "#get_item.category2#">
  <cfset #ad_body# = "#get_item.ad_body#">
  <cfset #session.ad_body# = "#get_item.ad_body#">
  <cfset #ask_price# = "#get_item.ask_price#">
  <cfset #session.ask_price# = "#get_item.ask_price#">
  <cfset #obo# = "#get_item.obo#">
  <cfset #session.obo# = "#get_item.obo#">
  <cfset #picture_url# = "#get_item.picture_url#">
  <cfset #session.picture_url# = "#get_item.picture_url#">
  <cfset #date_start# = "#get_item.date_start#">
  <cfset #session.date_start# = "#get_item.date_start#">
  <cfset #date_end# = "#get_item.date_end#">
  <cfset #session.date_end# = "#get_item.date_end#">
  <cfset #community_ad# = "#get_item.community_ad#">
  <cfset #session.community_ad# = "#get_item.community_ad#">
  <cfset #ad_dur# = "#get_item.ad_dur#">
  <cfset #session.ad_dur# = "#get_item.ad_dur#">
  <cfset #ad_fee# = "#get_item.ad_fee#">
  <cfset #session.ad_fee# = "#get_item.ad_fee#">
  <cfset #remote_ip# = "#get_item.remote_ip#">
  <cfset #session.remote_ip# = "#get_item.remote_ip#">
  
  
   <cfset #isvalid# = "true"> 

 <cftry>
    <!--- get parents of this category --->
    <cfmodule template="../functions/parentlookup.cfm"
      CATEGORY="#session.category1#"
      DATASOURCE="#DATASOURCE#"
      RETURN="parents_array">
    
    <cfcatch>
      <cfset parents_array = ArrayNew(2)>
    </cfcatch>
  </cftry>

<!--- output information --->
<cfsetting enablecfoutputonly="No">
<!--- Test to see if we are coming back to edit another item or return to the personal page--->
<cfif #submit2# is "Edit Another">
<cflocation url="editad.cfm">
</cfif>
<cfif #submit2# is "Cancel">
<cflocation url="main_page.cfm">
</cfif>
<html>
  <head>
    <title><cfif #isdefined ("selected_item")# is 1>Item <cfoutput>#session.adnum# (#Trim(session.title)#)</cfoutput><cfelse>Item Not Found</cfif></title>

    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
    
               <cfinclude template="../includes/menu_bar.cfm">
             
     
      <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
   
        <tr>
          <td><CFOUTPUT>
           <form name="item_pre" action="editad_pre_new.cfm" method="post">
		   <Font color="RED" size="+1"> The changes that you have made to <BR> Item:</font> <Font size="+1">(#adnum#) #title# have taken effect.</font><br><br>
		   <input type="submit" name="submit2" value="Edit Another" width=75>&nbsp; <input type="submit" name="submit2" value="Cancel" width=75>
		   </form>
		  </cfoutput></td>
        </tr>
      </table>
   <div align="center">

 <cfinclude template="nav.cfm">
</div>
      
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
