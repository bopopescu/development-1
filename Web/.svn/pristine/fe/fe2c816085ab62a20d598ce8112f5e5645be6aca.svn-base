

 <!--- Always check for valid username/password --->
 <cfinclude template="validate_include.cfm">
  <cfmodule template="../functions/timenow.cfm">

 <cfparam name="error_message" default="">
 
 <cfsetting EnableCFOutputOnly="YES">

  <cfset #logo# = "">
  <cfset #studio_logo# = "">
  <cfset #promotion_logo# = "">


<!--- ********************************************************************** --->
<!--- Update Page Layout --->
<cfif isdefined("ChangePageLayout")>
<cfquery name="updatepagelayout" datasource="#datasource#">
update layout  <cfif #pagelayout# eq 1>set page_layout= 1<cfelseif #pagelayout# eq 2>set page_layout=2<cfelseif #pagelayout# eq 3> set page_layout=3<cfelse>set page_layout = 1</cfif>
</cfquery>
</cfif>
<!--- Update Menu Header Layout --->
<cfif isdefined("ChangeMenuHeaderLayout")>
<cfquery name="updatemenuheaderlayout" datasource="#datasource#">
update layout  <cfif #menuheaderlayout# eq 1>set menu_header_layout= 1<cfelseif #menuheaderlayout# eq 2>set menu_header_layout=2<cfelseif #menuheaderlayout# eq 3> set menu_header_layout=3<cfelse>set menu_header_layout = 1</cfif>
</cfquery>
</cfif>


<!--- Update Heading Style --->
<cfif isdefined("ChangeHeadingStyle")>
<cfquery name="updateheadingstyle" datasource="#datasource#">
update layout  <cfif #headingstyle# eq 1>set heading_style= 1<cfelseif #headingstyle# eq 2>set heading_style=2<cfelseif #headingstyle# eq 3> set heading_style=3<cfelse>set heading_style = 1</cfif>
</cfquery>
</cfif>
<!--- Update Button Attributes --->
<cfif isdefined("ChangeButton")>
<cfquery name="updatebutton1" datasource="#datasource#">
update layout set button_style = '#form.buttonnumber#', button_font='#form.ffamily#',button_size='#form.fsize#',button_color='#form.fcolor#',button_hover='#form.fmouseover#'
</cfquery>
<!---
<cfquery name="updatebutton2" datasource="#datasource#">
update layout set button_color = #form.buttoncolor#
</cfquery>
<cfquery name="updatebutton3" datasource="#datasource#">
update layout set button_size = #form.fsize#
</cfquery>
<cfquery name="updatebutton4" datasource="#datasource#">
update layout set button_color = #form.fcolor#
</cfquery>
<cfquery name="updatebutton5" datasource="#datasource#">
update layout set button_hover = #form.fmouseover#
</cfquery>
--->
</cfif>


<cfquery name="layout"  datasource="#datasource#">
select * from layout
</cfquery>


  <!--- Check to see what we need to do --->
  <cfif #isDefined ("submit")#>
    
    <cfif #trim (submit)# is "Apply">
      
      <!--- Check for custom colors --->
      <cfif #link_color# is "custom">
	  	<cfif custom_link_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for link.  </font>">
		</cfif>
        <cfset #link_color# = "#custom_link_color#">
      </cfif>
      <cfif #vlink_color# is "custom">
	  	<cfif custom_vlink_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for visited link.  </font>">
		</cfif>
        <cfset #vlink_color# = "#custom_vlink_color#">
      </cfif>
      <cfif #alink_color# is "custom">
	  	<cfif custom_alink_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for active link.  </font>">
		</cfif>
        <cfset #alink_color# = "#custom_alink_color#">
      </cfif>
      <cfif #text_color# is "custom">
	  	<cfif custom_text_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for page text.  </font>">
		</cfif>
        <cfset #text_color# = "#custom_text_color#">
      </cfif>
      <cfif #bg_color# is "custom">
	  	<cfif custom_bg_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for background.  </font>">
		</cfif>
        <cfset #bg_color# = "#custom_bg_color#">
      </cfif>
      <cfif #hrsending_color# is "custom">
	  	<cfif custom_hrsending_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for ending auction.  </font>">
		</cfif>
        <cfset #hrsending_color# = "#custom_hrsending_color#">
      </cfif>
      <cfif #listing_bgcolor# is "custom">
	  	<cfif custom_listing_bgcolor eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for listing background.  </font>">
		</cfif>
        <cfset #listing_bgcolor# = "#custom_listing_bgcolor#">
      </cfif>
	  <cfif #set_heading_color# is "custom">
	  	<cfif custom_set_heading_color eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for heading.  </font>">
		</cfif>
        <cfset #set_heading_color# = "#custom_set_heading_color#">
      </cfif>
	  <cfif #set_heading_fcolor# is "custom">
	  	<cfif custom_set_heading_fcolor eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter custom color code for heading font color.  </font>">
		</cfif>
        <cfset #set_heading_fcolor# = "#custom_set_heading_fcolor#">
      </cfif>
	  
	  	<cfif set_heading_font eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter font for heading.  </font>">
		</cfif>
    
    	  	<cfif set_heading_font_size eq "">
			<cfset error_message = error_message & "<font color='Red'>Please enter font size  for heading.  </font>">
		</cfif>
      
	  <cfif error_message eq "">
      <!--- Update the database --->
      <cfquery username="#db_username#" password="#db_password#" name="update_link_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#link_color#'
           WHERE name = 'link_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_alink_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#alink_color#'
           WHERE name = 'alink_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_vlink_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#vlink_color#'
           WHERE name = 'vlink_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_text_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#text_color#'
           WHERE name = 'text_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_bg_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#bg_color#'
           WHERE name = 'bg_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_hrsending_color" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#hrsending_color#'
           WHERE name = 'hrsending_color'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_listing_bgcolor" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#listing_bgcolor#'
           WHERE name = 'listing_bgcolor'
      </cfquery>
	  <cfquery username="#db_username#" password="#db_password#" name="update_headingcolor" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#set_heading_color#'
           WHERE name = 'heading_color'
      </cfquery>
	  <cfquery username="#db_username#" password="#db_password#" name="update_heading_fcolor" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#set_heading_fcolor#'
           WHERE name = 'heading_fcolor'
      </cfquery>
      <cfquery username="#db_username#" password="#db_password#" name="update_heading_font" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#set_heading_font#'
           WHERE name = 'heading_font'
      </cfquery>

      <cfquery username="#db_username#" password="#db_password#" name="update_heading_font_size" datasource="#DATASOURCE#">
          UPDATE defaults
             SET pair = '#set_heading_font_size#'
           WHERE name = 'heading_fsize'
      </cfquery>







      <!--- Write a new body tag include file --->
      <cffile action="write" file=#expandPath ("..\includes\bodytag.html")# output="<body bgcolor='#bg_color#' text='#text_color#' link='#link_color#' alink='#alink_color#' vlink='#vlink_color#'>">


<!---*********************************************************************************************************
    
      <!--- Write a new style sheet --->
      <cffile action="write" file=#expandPath ("../includes/stylesheet.css")# output="#trim (css_code)#">
<!---      
<cffile action="write" file=#expandPath ("../includes/banner.cfm")# output="#trim (banner_code)#">

--->
<cffile action="write" file=#expandPath ("../includes/menu_bar.cfm")# output="#trim (menu_bar)#">

**************************************************************************************************************--->

      <!--- log update of site info --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Site Information Updated">



	<!--- Refresh cashed pages --->
<!---
<cfinclude template="../event5/count_auctions/index.cfm">

--->
		
        </cfif>



   

    </cfif>



  </cfif>








<cfif isdefined("update_promotion_section")>



<cffile action="write" file=#expandPath ("../inc_promotion.cfm")# output="#trim (tkpromotion)#">
      <!--- log update of site info --->
      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Promotion Section Updated">

<cfset #error_message# = "<font color='ff0000'>Promotion Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>





<cfif isdefined("update_welcome_section")>

<cffile action="write" file=#expandPath ("../inc_welcome.cfm")# output="#trim (tkwelcome)#">


      <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Welcome Section Updated">

<cfset #error_message# = "<font color='ff0000'>Welcome Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>

<cfif isdefined("update_email_section")>
<cffile action="write" file=#expandPath ("../inc_email.cfm")# output="#trim (tkemail)#">


   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Tell A Friend Section Updated">

<cfset #error_message# = "<font color='ff0000'>Tell A Friend Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>

<cfif isdefined("update_categories_section")>
<cffile action="write" file=#expandPath ("../inc_categories.cfm")# output="#trim (tkcategories)#">



   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Categories Section Updated">

<cfset #error_message# = "<font color='ff0000'>Categories Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>


<cfif isdefined("update_topseller_section")>
<cffile action="write" file=#expandPath ("../inc_top_sellers.cfm")# output="#trim (tktopseller)#">



   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Top Sellers Section Updated">

<cfset #error_message# = "<font color='ff0000'>Top Sellers Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>





<cfif isdefined("update_hotauctions_section")>
<cffile action="write" file=#expandPath ("../inc_hot_auc.cfm")# output="#trim (tkhotauctions)#">



   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Hot Auctions Section Updated">

<cfset #error_message# = "<font color='ff0000'>Hot Auctions Section Updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>



<!--- ***************************************** Site Layout Templates ****************************************** --->

<cfif isdefined("switchtemplate")>
<cfquery name="updatetemplate" datasource="#datasource#">
update layout  <cfif #template# eq 1>set template= 1<cfelseif #template# eq 2>set template=2<cfelseif #template# eq 3> set template=3<cfelseif #template# eq 4>set template =4<cfelse>set template = 1</cfif>
</cfquery>

<cfif #template# eq 2>
<cfquery name="updateheading" datasource="#datasource#">
update defaults set pair='43A3F1' where name='heading_color'
</cfquery>
</cfif>

   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Site Template Switched">

<cfset #error_message# = "<font color='ff0000'>Site Template Switched. </font>">

<cfinclude template="../clearcache/clearcache.cfm">

<cfinclude template="../admin/gen_all_cats.cfm">
<cflocation url="options.cfm">

</cfif>





<cfif isdefined("update_featured_section")>
<cffile action="write" file=#expandPath ("../inc_featured_auc.cfm")# output="#trim (tkfeatured)#">


   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Featured Auctions Section Updated">

<cfset #error_message# = "<font color='ff0000'>Featured Auctions Section updated. </font>">

			
<cfinclude template="../delete_tmps.cfm">			        </cfif>


<cfif isdefined("update_links_section")>
<cffile action="write" file=#expandPath ("../inc_links.cfm")#

output="#trim (tklinks)#">


   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Links Section Updated">

<cfset #error_message# = "<font color='ff0000'>Links Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">						
        </cfif>

<cfif isdefined("update_studiographic_section")>
<cffile action="write" file=#expandPath ("../inc_studio_graphic.cfm")# output="#trim (tkstudiographic)#">


   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Thumbnail Gallery Section Updated">

<cfset #error_message# = "<font color='ff0000'>Thumbnail Gallery Section updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>

<cfif isdefined("update_news_section")>
<cffile action="write" file=#expandPath ("../inc_news.cfm")# output="#trim (tknews)#">


   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="What's News Section Updated">

<cfset #error_message# = "<font color='ff0000'>What's NewsSection updated. </font>">
<cfinclude template="../delete_tmps.cfm">			
			
        </cfif>

<cfif isdefined("update_statistic_section")>
<cffile action="write" file=#expandPath ("../inc_statistic.cfm")# output="#trim (tkstatistic)#">


   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Site Statistics Section Updated">

<cfset #error_message# = "<font color='ff0000'>Site Statistics Section updated. </font>">
<cfinclude template="../delete_tmps.cfm">			
			
        </cfif>

<cfif isdefined("update_promotion_section")>
<cffile action="write" file=#expandPath ("../inc_promotion.cfm")# output="#trim (tkpromotion)#">



   <cfmodule template="../functions/addTransaction.cfm"
        datasource="#DATASOURCE#"


        description="Promotion Section Updated">

<cfset #error_message# = "<font color='ff0000'>PromotionSection updated. </font>">

<cfinclude template="../delete_tmps.cfm">			
        </cfif>



 <cfif isdefined("insert_news")>
<cfif #trim(form.title)# is not "" and #trim(form.news_code)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_news" datasource="#DATASOURCE#">
          insert into news(news,date_posted,title) 
values ('#trim(news_code)#',#timenow#,'#trim(title)#')


      </cfquery>

  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Add news"
      details="ADD NEWS OPTION">

<cfset #error_message# = "<font color='ff0000'>News added. </font>">
  <cfelse>
<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: To add news, You must enter the news, its title to proceed. </font>">
  </cfif>

</cfif>







<cfif isdefined("upload_logo")>


<cfif isdefined("form.logo") and form.logo is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","logos")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.logo"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.logo"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>

<!---  <!--- Rename full size image with item number --->
      <cfif fileExists("#directory##logo#")>
        <cffile action="delete"
          file = "#directory##logo#">

      </cfif>




  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#">

--->
  <cfset logo = #File.Serverfile#>

<!---
  <cfif Img_height GT 110 or Img_width GT 150>
    <cfif Img_height/Img_width*100 GT 88>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##logo#" y="110"> 
     <cfelse>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##logo#" x="150"> 
    </cfif>
  </cfif>
--->

<cfelse>

<cfset logo =#layout.logo#>

</cfif>  





      <cfquery username="#db_username#" password="#db_password#" name="update_logo" datasource="#DATASOURCE#">
          UPDATE layout
             SET logo = '#logo#'
           WHERE id=1
      </cfquery>

</cfif>



<cfif isdefined("upload_studiologo")>


<cfif isdefined("form.studio_logo") and form.studio_logo is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","logos")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.studio_logo"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.studio_logo"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>
   <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#">
  <cfset studio_logo = #File.Serverfile#>
  <cfif Img_height GT 197 or Img_width GT 277>
    <cfif Img_height/Img_width*100 GT 88>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##studio_logo#" y="197"> 
     <cfelse>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##studio_logo#" x="277"> 
    </cfif>
  </cfif>


<cfelse>

<cfset studiologo =#layout.studiologo#>
</cfif>  

      <cfquery username="#db_username#" password="#db_password#" name="update_studiologo" datasource="#DATASOURCE#">
          UPDATE layout
             SET studio_logo = '#studio_logo#'
           WHERE id=1
      </cfquery>

</cfif>




<cfif isdefined("upload_promotionlogo")>


<cfif isdefined("form.promotion_logo") and form.promotion_logo is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","logos")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.promotion_logo"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.promotion_logo"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>

  <CFX_GIFGD ACTION="READ" FILE="#directory##File.ServerFile#">
  <cfset promotion_logo = #File.Serverfile#>
  <cfif Img_height GT 60 or Img_width GT 230>
    <cfif Img_height/Img_width*100 GT 88>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##promotion_logo#" y="60"> 
     <cfelse>
      <CFX_GIFGD ACTION="RESIZE" FILE="#directory##File.ServerFile#" OUTPUT="#directory##promotion_logo#" x="230"> 
    </cfif>
  </cfif>

<cfelse>

<cfset promotionlogo =#layout.promotionlogo#>
</cfif>  

      <cfquery username="#db_username#" password="#db_password#" name="update_promotionlogo" datasource="#DATASOURCE#">
          UPDATE layout
             SET promotion_logo = '#promotion_logo#'
           WHERE id=1
      </cfquery>

</cfif>

















<cfif isdefined("upload_legends")>


<cfif isdefined("form.legend1") and form.legend1 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend1 = #File.Serverfile#>
<cfelse>
<cfset legend1 =#layout.legend1#>
</cfif>  






<cfif isdefined("form.legend2") and form.legend2 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend2"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend2 = #File.Serverfile#>
<cfelse>
<cfset legend2 =#layout.legend2#>
</cfif>  








<cfif isdefined("form.membershipicon") and form.membershipicon is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.membershipicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.membershipicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset membershipicon = #File.Serverfile#>
<cfelse>
<cfset membershipicon =#layout.membershipicon#>
</cfif>  




<cfif isdefined("form.legend3") and form.legend3 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend3"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend3 = #File.Serverfile#>

<cfelse>
<cfset legend3 =#layout.legend3#>
</cfif>  



<cfif isdefined("form.legend4") and form.legend4 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend4"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend4 = #File.Serverfile#>
<cfelse>
<cfset legend4 =#layout.legend4#>
</cfif>  



<cfif isdefined("form.legend5") and form.legend5 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend1"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend5"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend5 = #File.Serverfile#>

<cfelse>
<cfset legend5 =#layout.legend5#>
</cfif>  



<cfif isdefined("form.legend6") and form.legend6 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend6"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend6"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend6 = #File.Serverfile#>

<cfelse>
<cfset legend6 =#layout.legend6#>
</cfif>  



<cfif isdefined("form.legend7") and form.legend7 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend7"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend7"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend7 = #File.Serverfile#>

<cfelse>
<cfset legend7 =#layout.legend7#>
</cfif>  





<cfif isdefined("form.legend8") and form.legend8 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend8"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend8"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend8 = #File.Serverfile#>

<cfelse>
<cfset legend8 =#layout.legend8#>
</cfif>  



<cfif isdefined("form.legend9") and form.legend9 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend9"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend9"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend9 = #File.Serverfile#>

<cfelse>
<cfset legend9 =#layout.legend9#>
</cfif>  



<cfif isdefined("form.legend10") and form.legend10 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend10"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend10"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend10 = #File.Serverfile#>

<cfelse>
<cfset legend10 =#layout.legend10#>
</cfif>  


<cfif isdefined("form.legend11") and form.legend11 is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.legend11"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.legend11"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset legend11 = #File.Serverfile#>
<cfelse>
<cfset legend11 =#layout.legend11#>
</cfif>  






<cfif isdefined("form.aboutmeicon") and form.aboutmeicon is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.aboutmeicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.aboutmeicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset aboutmeicon = #File.Serverfile#>

<cfelse>
<cfset aboutmeicon =#layout.aboutmeicon#>
</cfif>  




<cfif isdefined("form.bidicon") and form.bidicon is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.bidicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.bidicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset bidicon = #File.Serverfile#>

<cfelse>
<cfset bidicon =#layout.bidicon#>
</cfif>  



<cfif isdefined("form.descriptionicon") and form.descriptionicon is not "">
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>
  <cfset #directory# = Replace(GetDirectoryFromPath("#curPath#"),"admin","legends")>
  <cfif findNoCase("msie",#cgi.http_user_agent#) is 0>
    <cffile action="upload"
      filefield="form.descriptionicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/jpg, image/jpeg, image/pjpg, image/gif'>
  <cfelse>
    <cffile action="upload"
      filefield="form.descriptionicon"
      DESTINATION="#directory#"
      nameconflict="overwrite" 
      accept='image/*'>
  </cfif>


  <cfset descriptionicon = #File.Serverfile#>

<cfelse>
<cfset descriptionicon =#layout.descriptionicon#>
</cfif>  


      <cfquery username="#db_username#" password="#db_password#" name="update_legends" datasource="#DATASOURCE#">
          UPDATE layout
             SET legend1 = '#legend1#',
legend2 = '#legend2#',
legend3 = '#legend3#',
legend4 = '#legend4#',
legend5 = '#legend5#',
legend6 = '#legend6#',
legend7 = '#legend7#',
legend8 = '#legend8#',
legend9 = '#legend9#',
legend10 = '#legend10#',
legend11 = '#legend11#',
descriptionicon = '#descriptionicon#',
aboutmeicon = '#aboutmeicon#',
membershipicon = '#membershipicon#',
bidicon = '#bidicon#'

           WHERE id=1
      </cfquery>

</cfif>



 <cfif isDefined("del_NEWS")>
  <cfif selected_NEWS neq "-1">
  <cfquery username="#db_username#" password="#db_password#" name="del_NEWS" datasource="#DATASOURCE#">
    DELETE NEWS from NEWS
     WHERE TITLE=  '#selected_NEWS#'
  </cfquery>
  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Delete news option"
      details="DELETE NEWS OPTION: #selected_NEWS#">

<cfset #error_message# = "<font color='ff0000'>News deleted. </font>">

  <cfelse>
  	<cfset #error_message# = "<font color='ff0000'>INCOMPLETE: To Edit/Delete news, You must select the news to proceed. </font>">
  </cfif>
 </cfif>






 <cfif isDefined("update_contactus")>
  <cfif #trim(form.contact_us)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_contact" datasource="#DATASOURCE#">
          update layout
set contact_us='#trim(contact_us)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update contact"
      details="contact updated">

<cfset #error_message# = "<font color='ff0000'>Contact info updated </font>">

  <cfelse>

  </cfif>
 </cfif>




 <cfif isDefined("update_aboutus")>
  <cfif #trim(form.about_us)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_contact" datasource="#DATASOURCE#">
          update layout
set about_us='#trim(about_us)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update about us"
      details="About us updated">

<cfset #error_message# = "<font color='ff0000'>About us info updated </font>">

  <cfelse>

  </cfif>
 </cfif>







 <cfif isDefined("update_terms")>
  <cfif #trim(form.terms)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_terms" datasource="#DATASOURCE#">
          update layout
set terms='#trim(terms)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update Term and conditions"
      details="Term and conditions updated">

<cfset #error_message# = "<font color='ff0000'>Terms and Conditions updated </font>">


<cfinclude template="gen_user_agreement.cfm">
  <cfelse>

  </cfif>
 </cfif>






 <cfif isDefined("update_privacy")>
  <cfif #trim(form.privacy)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_privacy" datasource="#DATASOURCE#">
          update layout
set privacy='#trim(privacy)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update Privacy information"
      details="Privacy information updated">

<cfset #error_message# = "<font color='ff0000'>Privacy information updated </font>">

  <cfelse>

  </cfif>
 </cfif>





 <cfif isDefined("update_keywords")>
  <cfif #trim(form.keywords)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_keywords" datasource="#DATASOURCE#">
          update layout
set keywords='#trim(keywords)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update meta keywords information"
      details="Meta keywords information updated">

<cfset #error_message# = "<font color='ff0000'>Meta keywords information updated </font>">

  <cfelse>

  </cfif>
 </cfif>





 <cfif isDefined("update_descriptions")>
  <cfif #trim(form.descriptions)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_descriptions" datasource="#DATASOURCE#">
          update layout
set descriptions='#trim(descriptions)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Update meta description information"
      details="Meta description information updated">

<cfset #error_message# = "<font color='ff0000'>Meta description information updated </font>">

  <cfelse>

  </cfif>
 </cfif>








 <cfif #isDefined ("form.featured")# is 1>
  <cfset #featured# = "1">
 <cfelse>
 <cfset #featured# = "0">
  </cfif>



 <cfif #isDefined ("form.gallery")# is 1>
  <cfset #gallery# = "1">
 <cfelse>
 <cfset #gallery# = "0">
  </cfif>

 <cfif #isDefined ("form.news")# is 1>
  <cfset #news# = "1">
 <cfelse>
 <cfset #news# = "0">
  </cfif>
 <cfif #isDefined ("form.promotion")# is 1>
  <cfset #promotion# = "1">
 <cfelse>
 <cfset #promotion# = "0">
  </cfif>
 <cfif #isDefined ("form.statistic")# is 1>
  <cfset #statistic# = "1">
 <cfelse>
 <cfset #statistic# = "0">
  </cfif>

 <cfif #isDefined ("form.tellafriend")# is 1>
  <cfset #tellafriend# = "1">
 <cfelse>
 <cfset #tellafriend# = "0">
  </cfif>


 <cfif #isDefined ("form.welcome")# is 1>
  <cfset #welcome# = "1">
 <cfelse>
 <cfset #welcome# = "0">
  </cfif>
 <cfif #isDefined ("form.topseller")# is 1>
  <cfset #topseller# = "1">
 <cfelse>
 <cfset #topseller# = "0">
  </cfif>

 <cfif #isDefined ("form.hotauctions")# is 1>
  <cfset #hotauctions# = "1">
 <cfelse>
 <cfset #hotauctions# = "0">
  </cfif>

 <cfif #isDefined ("form.login")# is 1>
  <cfset #login# = "1">
 <cfelse>
 <cfset #login# = "0">
  </cfif>
 <cfif #isDefined ("form.hits")# is 1>
  <cfset #hits# = "1">
 <cfelse>
 <cfset #hits# = "0">
  </cfif>




 <cfif #isDefined ("form.visitors")# is 1>
  <cfset #visitors# = "1">
 <cfelse>
 <cfset #visitors# = "0">
  </cfif>

 <cfif #isDefined ("form.useronline")# is 1>
  <cfset #useronline# = "1">
 <cfelse>
 <cfset #useronline# = "0">
  </cfif>



 <cfif #isDefined ("form.search_cache")# is 1>
  <cfset #search_cache# = "1">
 <cfelse>
 <cfset #search_cache# = "0">
  </cfif>


 <cfif #isDefined ("form.homepage_cache")# is 1>
  <cfset #homepage_cache# = "1">
 <cfelse>
 <cfset #homepage_cache# = "0">
  </cfif>
 <cfif #isDefined ("form.all_cache")# is 1>
  <cfset #all_cache# = "1">
 <cfelse>
 <cfset #all_cache# = "0">
  </cfif>

 <cfif #isDefined ("form.listings_cache")# is 1>
  <cfset #listings_cache# = "1">
 <cfelse>
 <cfset #listings_cache# = "0">
  </cfif>









 <cfif isDefined("update_caching")>

      <cfquery username="#db_username#" password="#db_password#" name="update_homepage" datasource="#DATASOURCE#">
          update layout
set all_cache = #all_cache#,
listings_cache = #listings_cache#,
search_cache = #search_cache#,
homepage_cache = #homepage_cache#
      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="site caching updated"
      details="site caching updated">

<cfset #error_message# = "<font color='ff0000'>site caching udpated</font>">

  <cfelse>

<cfset all_cache = #layout.all_cache#>

<cfif #layout.all_cache# eq 1>
<cfset listings_cache = #layout.listings_cache#>
<cfset  search_cache = #layout.search_cache#>
<cfset homepage_cache = #layout.homepage_cache#>

<cfelse>

<cfset listings_cache = 0>
<cfset  search_cache = 0>
<cfset homepage_cache = 0>

</cfif>  </cfif>








 <cfif isDefined("update_homepage")>

      <cfquery username="#db_username#" password="#db_password#" name="update_homepage" datasource="#DATASOURCE#">
          update layout
set featured=#featured#,
gallery=#gallery#,
promotion=#promotion#,
tellafriend=#tellafriend#,
news=#news#,
statistic=#statistic#,
welcome=#welcome#,
topseller=#topseller#,
hotauctions=#hotauctions#,
hits=#hits#,
visitors = #visitors#,
login = #login#,
useronline = #useronline#
      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Home page updated"
      details="Home page updated">

<cfset #error_message# = "<font color='ff0000'>Home page updated </font>">

  <cfelse>
<cfset #visitors#=#layout.visitors#>
<cfset #hits#=#layout.hits#>
<cfset #topseller#=#layout.topseller#>
<cfset #hotauctions#=#layout.hotauctions#>
<cfset #welcome#=#layout.welcome#>
<cfset #promotion#=#layout.promotion#>
<cfset #statistic#=#layout.statistic#>
<cfset #news#=#layout.news#>
<cfset #featured#=#layout.featured#>
<cfset #gallery#=#layout.gallery#>
<cfset #login#=#layout.login#>
<cfset #tellafriend#=#layout.tellafriend#>
<cfset #useronline#=#layout.useronline#>

  </cfif>










 <cfif isDefined("update_companyname")>
  <cfif #trim(form.company_name)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_companyname" datasource="#DATASOURCE#">
          update layout
set company_name='#trim(form.company_name)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Company Name updated"
      details="Company Name updated">

<cfset #error_message# = "<font color='ff0000'>Company name updated </font>">

  <cfelse>

  </cfif>
 </cfif>






 <cfif isDefined("update_email")>
  <cfif #trim(form.question_email)# is not "" and #trim(form.service_email)# is not "" and #trim(form.problem_email)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_email" datasource="#DATASOURCE#">
          update layout
set question_email='#trim(form.question_email)#',
problem_email='#trim(form.problem_email)#',
service_email='#trim(form.service_email)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Email addresses updated"
      details="Email addresses updated">

<cfset #error_message# = "<font color='ff0000'>Email addresses name updated </font>">

  <cfelse>

  </cfif>
 </cfif>








 <cfif isDefined("update_linkpoint")>
  <cfif #trim(form.Linkpoint_enable)# is not "" and #trim(form.LP_REQSTORENAME)# is not "" and #trim(form.LP_REQKEYFILE)# is not "" and #trim(form.LP_REQHOSTADDR)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_linkpoint" datasource="#DATASOURCE#">
          update layout
set linkpoint_enable='#trim(form.linkpoint_enable)#',


LP_REQHOSTADDR = '#trim(form.LP_REQHOSTADDR)#',
LP_REQKEYFILE = '#trim(form.LP_REQKEYFILE)#',
LP_REQSTORENAME = '#trim(form.LP_REQSTORENAME)#'
      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Linkpoint updated"
      details="Linkpoint updated">

<cfset #error_message# = "<font color='ff0000'>Linkpoint Information updated </font>">

  <cfelse>

<cfset #error_message# = "<font color='ff0000'>Linkpoint Information fields can't be empty</font>">
  </cfif>
 </cfif>








 <cfif isDefined("update_authorize")>
  <cfif #trim(form.authorize_password)# is not "" and #trim(form.authorize_enable)# is not "" and #trim(form.authorize_login)# is not "" >
      <cfquery username="#db_username#" password="#db_password#" name="update_authorize" datasource="#DATASOURCE#">
          update layout
set 


authorize_enable = '#trim(form.authorize_enable)#',
authorize_login = '#trim(form.authorize_login)#',
authorize_password = '#trim(form.authorize_password)#'
      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Authorize.net updated"
      details="Authorize.net updated">

<cfset #error_message# = "<font color='ff0000'>Authorize.net Information updated </font>">

  <cfelse>

<cfset #error_message# = "<font color='ff0000'>Authorize.net Information fields can't be empty</font>">
  </cfif>
 </cfif>









 <cfif isDefined("update_paypal")>
  <cfif #trim(form.paypal_enable)# is not "" and #trim(form.paypal_email)# is not "" >
      <cfquery username="#db_username#" password="#db_password#" name="update_paypal" datasource="#DATASOURCE#">
          update layout
set paypal_enable='#trim(form.paypal_enable)#',
paypal_email='#trim(form.paypal_email)#'



      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="PayPal updated"
      details="PayPal updated">

<cfset #error_message# = "<font color='ff0000'>PayPal Information updated </font>">

  <cfelse>

<cfset #error_message# = "<font color='ff0000'>PayPal Information fields can't be empty</font>">
  </cfif>
 </cfif>












 <cfif isDefined("update_time")>
  <cfif #trim(form.timechange)# is not "">


     <cfif IsNumeric(form.timechange)> 
      <cfquery username="#db_username#" password="#db_password#" name="update_time" datasource="#DATASOURCE#">


          update layout
set timechange =#trim(form.timechange)#
<!---

set timechange = #numberformat(trim(form.timechange),'+_')#
--->

      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Time  updated"
      details="Time  updated">

<cfset #error_message# = "<font color='ff0000'>Time  updated </font>">

  <cfelse>
<cfset #error_message# = "<font color='ff0000'>Only numbers are allowed </font>">
  </cfif> 
 </cfif>
</cfif>




 <cfif isDefined("update_timezone")>
  <cfif #trim(form.timezone)# is not "">
      <cfquery username="#db_username#" password="#db_password#" name="update_timezone" datasource="#DATASOURCE#">
          update layout
set timezone='#trim(form.timezone)#'


      </cfquery>


  <cfmodule template="../functions/addTransaction.cfm"
      datasource="#DATASOURCE#"
      description="Time zone updated"
      details="Time zone updated">

<cfset #error_message# = "<font color='ff0000'>Time zone updated </font>">

  <cfelse>

  </cfif>
 </cfif>














 <!--- Pull default colors from the database --->
 <cfquery username="#db_username#" password="#db_password#" name="get_link_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'link_color'
 </cfquery>
 <cfset #link_color# = #get_link_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_alink_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'alink_color'
 </cfquery>
 <cfset #alink_color# = #get_alink_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_vlink_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'vlink_color'
 </cfquery>
 <cfset #vlink_color# = #get_vlink_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_text_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'text_color'
 </cfquery>
 <cfset #text_color# = #get_text_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_bg_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'bg_color'
 </cfquery>
 <cfset #bg_color# = #get_bg_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_hrsending_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'hrsending_color'
 </cfquery>
 <cfset #hrsending_color# = #get_hrsending_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_listing_bgcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'listing_bgcolor'
 </cfquery>
 <cfset #listing_bgcolor# = #get_listing_bgcolor.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_heading_color" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'heading_color'
 </cfquery>
 <cfset #set_heading_color# = #get_heading_color.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_heading_fcolor" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'heading_fcolor'
 </cfquery>
 <cfset #set_heading_fcolor# = #get_heading_fcolor.pair#>
 <cfquery username="#db_username#" password="#db_password#" name="get_heading_font" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'heading_font'
 </cfquery>


 <cfset #set_heading_font# = #get_heading_font.pair#>




 <cfquery username="#db_username#" password="#db_password#" name="get_heading_font_size" datasource="#DATASOURCE#">
  SELECT pair
    FROM defaults
   WHERE name = 'heading_fsize'
 </cfquery>


 <cfset #set_heading_font_size# = #get_heading_font_size.pair#>


 <cftry>
  <cffile action="read" file=#expandPath ("../inc_news.cfm")# variable="tknews">
  <cfcatch type="any"></cfcatch>
 </cftry>
    

 <cftry>
  <cffile action="read" file=#expandPath ("../inc_promotion.cfm")# variable="tkpromotion">
  <cfcatch type="any"></cfcatch>
 </cftry>

 <cftry>
  <cffile action="read" file=#expandPath ("../inc_email.cfm")# variable="tkemail">
  <cfcatch type="any"></cfcatch>
 </cftry>




 <cftry>
  <cffile action="read" file=#expandPath ("../inc_statistic.cfm")# variable="tkstatistic">
  <cfcatch type="any"></cfcatch>
 </cftry>

 <cftry>
  <cffile action="read" file=#expandPath ("../inc_links.cfm")# variable="tklinks">
  <cfcatch type="any"></cfcatch>
 </cftry>

 <cftry>
  <cffile action="read" file=#expandPath ("../inc_categories.cfm")# variable="tkcategories">
  <cfcatch type="any"></cfcatch>
 </cftry>

 <cftry>
  <cffile action="read" file=#expandPath ("../inc_studio_graphic.cfm")# variable="tkstudiographic">
  <cfcatch type="any"></cfcatch>

 </cftry>

 <cftry>
  <cffile action="read" file=#expandPath ("../inc_featured_auc.cfm")# variable="tkfeatured">
  <cfcatch type="any"></cfcatch>
 </cftry>





<cftry>
  <cffile action="read" file=#expandPath ("../inc_welcome.cfm")# variable="tkwelcome">
  <cfcatch type="any"></cfcatch>
 </cftry>



 <cftry>
  <cffile action="read" file=#expandPath ("../inc_top_sellers.cfm")# variable="tktopseller">
  <cfcatch type="any"></cfcatch>
 </cftry>


 <cftry>
  <cffile action="read" file=#expandPath ("../inc_hot_auc.cfm")# variable="tkhotauctions">
  <cfcatch type="any"></cfcatch>
 </cftry>


      <cfquery username="#db_username#" password="#db_password#" name="get_aboutus" datasource="#DATASOURCE#">
          select * from layout

order by date_posted ASC
      </cfquery>


<cfquery name="layoutbutton"  datasource="#datasource#">
select button_style, button_font, button_size, button_color, button_hover from layout
</cfquery>




 <cfsetting EnableCFOutputOnly="NO">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <title>Visual Auction Administrator [Options Module]</title> 
<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
<link rel="stylesheet" href="accordian.css" type="text/css" />

<style>
a:hover {background:#ffffff; text-decoration:none;} 
a.quicknote span {display:none; padding:2px 3px; margin-left:8px; width:200px;} 
a.quicknote:hover span{display:block; position:absolute; ; background:#e9f478; border:1px solid .font #cccccc; color:#6c6c6c; font-family:cursive; font-size:11px;}
</style>

<script type="text/javascript" src="accordian.js"></script>

<script type="text/Javascript">
//'null' included so "0" is not used (skipped) in the array
var curButton = new Array('null','buttons/button square ltblue.gif','buttons/button square dkblue.gif','buttons/button square ltred.gif','buttons/button square dkred.gif','buttons/button square ltgreen.gif','buttons/button square dkgreen.gif','buttons/button square ltyellow.gif','buttons/button square dkyellow.gif','buttons/button square ltbrown.gif','buttons/button square dkbrown.gif','buttons/button square gray.gif','buttons/button round ltblue.gif','buttons/button round dkblue.gif','buttons/button round ltred.gif','buttons/button round dkred.gif','buttons/button round ltgreen.gif','buttons/button round dkgreen.gif','buttons/button round ltyellow.gif','buttons/button round dkyellow.gif','buttons/button round ltbrown.gif','buttons/button round dkbrown.gif','buttons/button round gray.gif','buttons/button bar ltblue.gif','buttons/button bar dkblue.gif','buttons/button bar ltred.gif','buttons/button bar dkred.gif','buttons/button bar ltgreen.gif','buttons/button bar dkgreen.gif','buttons/button bar ltyellow.gif','buttons/button bar dkyellow.gif','buttons/button bar ltbrown.gif','buttons/button bar dkbrown.gif','buttons/button bar gray.gif','buttons/TextLink.gif')

var thisButton = <cfoutput>#val(layoutbutton.button_style)#</cfoutput>


function previousButton() {
    if (document.images && thisButton > 1) {
        thisButton--
        document.ButtonImage.src=curButton[thisButton]
	document.getElementById("buttonnumber").value = thisButton;
    }
}

function nextButton() {
    if (document.images && thisButton < 34) {
        thisButton++
        document.ButtonImage.src=curButton[thisButton]
	document.getElementById("buttonnumber").value = thisButton;
    }
}


var tpcursive = "-117px"
var tparial = "-115px"

//alert(navigator.userAgent);

if (navigator.userAgent.indexOf("Firefox/3") != -1) {
var tpcursive = "-129px"
var tparial = "-127px"
}if (navigator.userAgent.indexOf("Safari") != -1) {
var tpcursive = "-128px"
var tparial = "-126px"
}

function ShowText() {
document.getElementById("ButtonText").style.fontFamily = document.getElementById("ffamily").value;
document.getElementById("ButtonText").style.color = document.getElementById("fcolor").value;
document.getElementById("ButtonText").style.fontSize = document.getElementById("fsize").value;
//alert(document.getElementById("ButtonText").style.top);
if (document.getElementById("ButtonText").style.fontFamily == "cursive" || document.getElementById("ButtonText").style.fontFamily == "arial black") {
document.getElementById("ButtonText").style.top = tpcursive;
}
else {document.getElementById("ButtonText").style.top = tparial;}


}
function ColorOver(){
document.getElementById("ButtonText").style.color = document.getElementById("fmouseover").value;
}
function ColorOut(){
document.getElementById("ButtonText").style.color = document.getElementById("fcolor").value;
}

function initialize() {
slider.init('slider',1);
        if (document.images && thisButton > 1) {
        document.ButtonImage.src=curButton[thisButton]
}

}

function ShowPopup(id)
{
   document.getElementById(id).style.visibility = "visible";
}
function HidePopup(id)
{
   document.getElementById(id).style.visibility = "hidden";
}

</script>


 </head>


<body bgcolor=465775 onload="initialize(); ShowText();">
<center>

 
 <!--- ******************************************************************** --->
     <!--- The main table encapsulating everything on the page --->
     <table border=0 cellspacing=0 cellpadding=0 width=900><!---TABLE:MAIN--->
      <tr bgcolor=0c546c>
<td colspan=3><img src="./images/top_banner.gif"></td>

<td><a href="http://www.visualauction.com/help/online/"><img border=0 src="./images/help.gif" alt="View Help"></a><a href="login.cfm"><img border=0 src="./images/logout.gif" alt="Logout"></a></font></td>
       <td align=right bgcolor=0c546c>&nbsp;</td>
      </tr>
<!--- ******************************************************************** --->
      <!--- Include the menubar --->
      <cfset #page# = "siteinfo">
      <cfinclude template="menu_include.cfm">

      <tr>
       <td colspan=5 bgcolor=bac1cf><!---MAIN TD--->

       <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0 width=900><!---TABLE:OUTER BORDER--->	    
         <tr>
          <td>

           
<table border=0 cellspacing=0 cellpadding=5 width=900><!---TABLE:DESCRIPTION--->
            <tr>
             <td colspan=2>
              <font face="helvetica" size=2 color=000000>
               Use this page to administer the color settings of your <i>Auction Server</i> software.  If you do not<br>
               know how to use this administration tool, please <!---consult your user manual or --->
               click the help button in the upper right corner<br>
               of this window.
                           <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=900>
<cfif error_message neq "">
<table border=0 cellspacing=0 cellpadding=3 width=900><!---TABLE:MESSAGE--->
<tr>
<td valign="top"><font face="helvetica" size=2><b>Status Messages: </b></font></td>
<td valign="top"><font face="helvetica" size=2><cfoutput>#error_message#</cfoutput></font></td>
</tr>
</table><!---TABLE:MESSAGE--->
</cfif>
              </font>
             </td>
            </tr>
</table><!---TABLE:DESCRIPTION--->

             <!--- begin form --->
             <form name="colorsForm" action="options.cfm" method="post" enctype="multipart/form-data">

            <tr>

             <td valign="top" align="left"><br><!---OUTER BORDER TD--->

<center>             
<table border=1 bordercolor=000080 cellspacing=0 cellpadding=2 width=900><!---TABLE:INNER BORDER--->
<tr><td><!---INNER BORDER TD--->

<div id="slider"><!---Start Container Div--->

<!---START DESIGN SECTION ************************************************************************************ --->

<div class="header" id="design-header">Site Design</div>
  <div class="content" id="design-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---PASTE CODE HERE--->
<tr bgcolor=bac1cf>
                <td>

                 <font face="helvetica" size=2>
                  <table border=0 cellspacing=0 cellpadding=5 width=98%>
                   <tr bgcolor=687997>
  <td align=left><font face="helvetica" size=2 color=white><b>Color Types</b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a class="quicknote" href="#"><img src="images/clipnote.gif" border=0 align=middle><span>
<img src="images/QuickNote.gif"><br>
Here you can choose the colors that will be used for the entire site for various elements.
</span></a>
</td> 
                    <td><font face="helvetica" size=2><b>Select Color</b></font></td>
                    <td><font face="helvetica" size=2><b>Custom Color Code</b></font></td>
                    <td align="right"><font face="helvetica" size=2><b>Sample</b></font>&nbsp;</td>
                   </tr>

                   <!--- Link color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Link:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="link_color" selected="#link_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#link_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>

                   <!--- VLink color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Visited link:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="vlink_color" selected="#vlink_color#">
                    <td  align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#vlink_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>
   
                   <!--- ALink color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Active link:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="alink_color" selected="#alink_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#alink_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>

                   <!--- Text color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Page text:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="text_color" selected="#text_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#text_color#"><u>Current</u></font></cfoutput>
                    </td>
                   </tr>
   
                   <!--- Background color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
<b>Background:</b>
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="bg_color" selected="#bg_color#">
                    <cfoutput>
                     <td align="right">
                      <table border=0 bordercolor=000000 cellspacing=0 cellpadding=2>
                       <tr>
                        <td bgcolor="#bg_color#"><font face="helvetica" size=2>Current</font></td>
                       </tr>
                      </table> 

                     
                     </td>
                    </cfoutput>
                   </tr>
				   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                   </tr>
				   
				   <!--- Heading color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Heading Background Color:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="set_heading_color" selected="#set_heading_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#set_heading_color#">Current</font></cfoutput>
                    </td>
                   </tr>
				   
				   <!--- Heading font color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Heading Font Color:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="set_heading_fcolor" selected="#set_heading_fcolor#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#set_heading_fcolor#">Current</font></cfoutput>
                    </td>
                   </tr>
				   
				   <!--- Heading font --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Heading Font Color:</b>&nbsp;
                     </font>
                    </td>
					<td align="left" colspan="2"><cfoutput><input type="Text" name="set_heading_font" value="#set_heading_font#" size="16"></cfoutput></td>


                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Heading Font Size:</b>&nbsp;
                     </font>
                    </td>
					<td align="left" colspan="2"><cfoutput><input type="Text" name="set_heading_font_size" value="#set_heading_font_size#" size="4"></cfoutput></td>

                    <!--- <cfmodule template="../functions/cf_colorsel.cfm" selectname="set_heading_fcolor" selected="#set_heading_fcolor#"> --->
                    <td align="right" width=70>
                     <cfoutput><font face="#set_heading_font#" size=2>Current</font></cfoutput>
                    </td>
                   </tr>
				   
                   <tr>
                    <td colspan=4>             </td>
                   </tr>


<tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                   </tr>


                   <!--- Ending auction color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Ending auction:</b>&nbsp;
                     </font>


                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="hrsending_color" selected="#hrsending_color#">
                    <td align="right" width=70>
                     <cfoutput><font face="helvetica" size=2 color="#hrsending_color#">Current</font></cfoutput>
                    </td>
                   </tr>

                   <!--- Listing background color --->
                   <tr>
                    <td>
                     <font face="helvetica" size=2>
                      &nbsp;<b>Listing background:</b>&nbsp;
                     </font>
                    </td>
                    <cfmodule template="../functions/cf_colorsel.cfm" selectname="listing_bgcolor" selected="#listing_bgcolor#">
                    <cfoutput>
                     <td align="right">
                      <table border=0 bordercolor=000000 cellspacing=0 cellpadding=2>
                       <tr>
                        <td bgcolor="#listing_bgcolor#">&nbsp;<font face="helvetica" size=2>Current</font>&nbsp;</b><font>
</td>
                       </tr>
                      </table>                      
                     </td>
                   </cfoutput> 
                   </tr>
</table>


<table border=0 width=98% cellpadding=5><!--- New Layout Table --->
<tr><td>&nbsp;</td></tr>
<tr bgcolor=687997><td valign=center><font face="arial" size=2 color=white><b>Page Layout</b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a class="quicknote" href="#"><img src="images/clipnote.gif" border=0 align=middle><span>
<img src="images/QuickNote.gif"><br>
You can choose from three different page layouts.  The page layout determines how your images, categories, etc. are aligned on the page.  
</span></a>
</td>
</tr>
<tr><td>
<br>
<font size=2 face="arial">
<img src="PageLayout1.gif" align=middle>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="PageLayout2.gif" align=middle>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="PageLayout3.gif" align=middle>&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=1 name="pagelayout" <cfif #layout.page_layout# eq 1> checked</cfif>>Page Layout 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=2 name="pagelayout" <cfif #layout.page_layout# eq 2> checked</cfif>>Page Layout 2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=3 name="pagelayout" <cfif #layout.page_layout# eq 3> checked</cfif>>Page Layout 3
</font>
<!--- Submit Button not needed (Apply below is used)
<br>
<br><input type="submit" name="ChangePageLayout" value="Change Page Layout" width=64><br>
<br>
--->
</td></tr>

<!--- FOR FUTURE UPGRADE
<tr bgcolor=687997><td><font face="arial" size=2 color=white><b>Heading Style</b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a class="quicknote" href="#"><img src="images/clipnote.gif" border=0 align=middle><span>
<img src="images/QuickNote.gif"><br>
Headings are used to provide titles for the content on your page and can be one of three styles.  The <b>Standalone</b> style separates the heading completely from the content.  The <b>Panel</b> style encloses the heading and the content within a panel.  The <b>Outline</b> style shows the heading at the top and encloses the content within an outline.  These can be in any color you choose.
</span></a>
</td></tr>
<tr><td><br>
<img src="heading1.jpg" align=middle>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="heading2.jpg" align=middle>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="heading3.jpg" align=middle>&nbsp;&nbsp;&nbsp;&nbsp;<br>
<font size=2 face="arial">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=1 name="menuheaderlayout" <cfif #layout.menu_header_layout# eq 1> checked</cfif>>Standalone
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=2 name="menuheaderlayout" <cfif #layout.menu_header_layout# eq 2> checked</cfif>>Panel
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=3 name="menuheaderlayout" <cfif #layout.menu_header_layout# eq 3> checked</cfif>>Outline
</font><br>
<br><input type="submit" name="ChangeMenuHeaderLayout" value="Change Menu Header Layout" width=64><br>
<br>
</td></tr>

<tr bgcolor=687997><td><font face="helvetica" size=2 color=white><b>Menu Header Layout</b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a class="quicknote" href="#"><img src="images/clipnote.gif" border=0 align=middle><span>
<img src="images/QuickNote.gif"><br>
Each page on your site will have a menu header at the top.  This header includes the menu, your logo and any graphics related to your site.  Typically the logo is combined with additional graphics in one image.  The menu is then "superimposed" on that image.  The "Search bar" is also included in this header so that users can search from any page on the site.  When you move your mouse over the menu headers below you can see an example of how it might look if that menu header layout were used.
</span></a>
</td></tr>
<tr><td>
<br>
<table border=0>

<tr><td colspan=3 align=center><font size=2 face="arial">Move mouse over <b>Layout</b> to see a <b>Sample</b> menu header.</font></td></tr>
<tr>
<td>
<div id="samplemenuheader1" style="visibility:hidden;">
<img src="Sample Menu Header 1.gif">&nbsp;&nbsp;
</div>
<a href="javascript:void(0);" onMouseover="ShowPopup('samplemenuheader1');" onMouseout="HidePopup('samplemenuheader1');">
<img src="MenuHeader1.gif" border=0"></a>&nbsp;&nbsp;
</td>

<td>
<div id="samplemenuheader2" style="visibility:hidden;">
<img src="Sample Menu Header 2.gif">&nbsp;&nbsp;
</div>
<a href="javascript:void(0);" onMouseover="ShowPopup('samplemenuheader2');" onMouseout="HidePopup('samplemenuheader2');">
<img src="MenuHeader2.gif" border=0></a>&nbsp;&nbsp;
</td>

<td>
<div id="samplemenuheader3" style="visibility:hidden;">
<img src="Sample Menu Header 3.gif">
</div>
<a href="javascript:void(0);" onMouseover="ShowPopup('samplemenuheader3');" onMouseout="HidePopup('samplemenuheader3');">
<img src="MenuHeader3.gif" border=0></a>
</td>
</tr>
</table>

<font size=2 face="arial">
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=1 name="headingstyle" <cfif #layout.heading_style# eq 1> checked</cfif>>Menu Header 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=2 name="headingstyle" <cfif #layout.heading_style# eq 2> checked</cfif>>Menu Header 2
&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=radio value=3 name="headingstyle" <cfif #layout.heading_style# eq 3> checked</cfif>>Menu Header 3
</font>
<br>
<br><input type="submit" name="ChangeHeadingStyle" value="Change Heading Style" width=64><br>
<br>
</td></tr>
 FOR FUTURE UPGRADE --->


<tr bgcolor=687997><td><font face="helvetica" size=2 color=white><b>Menu Buttons</b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a class="quicknote" href="#"><img src="images/clipnote.gif" border=0 align=middle><span>
<img src="images/QuickNote.gif"><br>
You have your choice of 34 menu buttons in various colors and styles.  Choose the button you like by  using the arrow keys below the button.  You can also change the font type, size, color of the font and the color change when a mouse moves over the button.
</span></a>
</td></tr>
<tr><td>
<!--- Buttons Start --->
<table border=0 cellpadding=5>
<tr>
<td align=center width=250>
<font size=2 face="arial"><b>Button Style</b></font><br>
<fieldset style="width:200;height:125px;border: 1px solid #68878d;padding:5px;">

<img name="ButtonImage" src="buttons/button square ltblue.gif"><br>
<input type="button" onclick="previousButton()" Value=" < ">
&nbsp;&nbsp;&nbsp;&nbsp;<input type=text name="buttonnumber" size=2 value=<cfoutput>#layoutbutton.button_style#</cfoutput> style="background:transparent;border:0px;">
<input type="button" onclick="nextButton()" Value=" > ">
<br><br>
<font size=1 face="arial">(Select one of 34 buttons above.<br>Button 34 is Text Only.)</font>
</fieldset>
<div id="ButtonText" style="color:white; font-family:arial;font-size:12;font-weight:bold;position:relative; left:0px; cursor:default;" onmouseover="ColorOver()" onmouseout="ColorOut()">
Sample
</div>
</td>
<td align=center width=450 valign=top>
<font size=2 face="arial"><b>&nbsp;&nbsp;&nbsp;&nbsp;Font
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Size
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Main Color
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mouseover Color
</b></font><br>

<fieldset style="width:445;height:125px;border: 1px solid #68878d;padding:5px;">
<select id="ffamily" name="ffamily" onChange="ShowText()"><option value="arial"<cfif layoutbutton.button_font eq "arial"> selected</cfif>>Arial</option><option value="times"<cfif layoutbutton.button_font eq "times"> selected</cfif>>Times Roman</option><option value="cursive"<cfif layoutbutton.button_font eq "cursive"> selected</cfif>>Cursive</option><option value="verdana"<cfif layoutbutton.button_font eq "verdana"> selected</cfif>>Verdana</option><option value="arial black"<cfif layoutbutton.button_font eq "arial black"> selected</cfif>>Arial Black</option></select>
<select id="fsize" name="fsize" onChange="ShowText()"><option value="11"<cfif layoutbutton.button_size eq "11"> selected</cfif>>11</option><option value="12"<cfif layoutbutton.button_size eq "12"> selected</cfif>>12</option><option value="13"<cfif layoutbutton.button_size eq "13"> selected</cfif>>13</option><option value="14"<cfif layoutbutton.button_size eq "14"> selected</cfif>>14</option></select>

<select id="fcolor" name="fcolor" onChange="ShowText()"><option value="000000"<cfif layoutbutton.button_color eq "000000"> selected</cfif>>00 - Black</option>
<option value="000080"<cfif layoutbutton.button_color eq "000080"> selected</cfif>>01 - Dark Blue</option>
<option value="008000"<cfif layoutbutton.button_color eq "008000"> selected</cfif>>02 - Dark Green</option>
<option value="800000"<cfif layoutbutton.button_color eq "800000"> selected</cfif>>03 - Dark Red</option>
<option value="008080"<cfif layoutbutton.button_color eq "008080"> selected</cfif>>04 - Dark Cyan</option>
<option value="800080"<cfif layoutbutton.button_color eq "800080"> selected</cfif>>05 - Dark Violet</option>
<option value="808000"<cfif layoutbutton.button_color eq "808000"> selected</cfif>>06 - Dark Yellow</option>
<option value="772c1b"<cfif layoutbutton.button_color eq "772c1b"> selected</cfif>>07 - Dark Brown</option>
<option value="aaaaaa"<cfif layoutbutton.button_color eq "aaaaaa"> selected</cfif>>08 - Gray</option>
<option value="0000bb"<cfif layoutbutton.button_color eq "0000bb"> selected</cfif>>09 - Blue</option>
<option value="00bb00"<cfif layoutbutton.button_color eq "00bb00"> selected</cfif>>10 - Green</option>
<option value="bb0000"<cfif layoutbutton.button_color eq "ff0000"> selected</cfif>>11 - Red</option>
<option value="00bbbb"<cfif layoutbutton.button_color eq "00bbbb"> selected</cfif>>12 - Cyan</option>
<option value="bb00bb"<cfif layoutbutton.button_color eq "bb00bb"> selected</cfif>>13 - Violet</option>
<option value="bbbb00"<cfif layoutbutton.button_color eq "bbbb00"> selected</cfif>>14 - Yellow</option>
<option value="ff8000"<cfif layoutbutton.button_color eq "ff8000"> selected</cfif>>15 - Orange</option>
<option value="4040ff"<cfif layoutbutton.button_color eq "4040ff"> selected</cfif>>16 - Light Blue</option>
<option value="40ff40"<cfif layoutbutton.button_color eq "40ff40"> selected</cfif>>17 - Light Green</option>
<option value="ff0000"<cfif layoutbutton.button_color eq "ff0000"> selected</cfif>>18 - Light Red</option>
<option value="00ffff"<cfif layoutbutton.button_color eq "00ffff"> selected</cfif>>19 - Light Cyan</option>
<option value="ff00ff"<cfif layoutbutton.button_color eq "ff00ff"> selected</cfif>>20 - Light Violet</option>
<option value="ffff00"<cfif layoutbutton.button_color eq "ffff00"> selected</cfif>>21 - Light Yellow</option>
<option value="b5715a"<cfif layoutbutton.button_color eq "b5715a"> selected</cfif>>22 - Light Brown</option>
<option value="ffffff" <cfif layoutbutton.button_color eq "ffffff"> selected</cfif>>23 - White</option></option></select>

<select id="fmouseover" name="fmouseover" onChange="ShowText()"><option value="000000"<cfif layoutbutton.button_hover eq "000000"> selected</cfif>>00 - Black</option>
<option value="000080"<cfif layoutbutton.button_hover eq "000080"> selected</cfif>>01 - Dark Blue</option>
<option value="008000"<cfif layoutbutton.button_hover eq "008000"> selected</cfif>>02 - Dark Green</option>
<option value="800000"<cfif layoutbutton.button_hover eq "800000"> selected</cfif>>03 - Dark Red</option>
<option value="008080"<cfif layoutbutton.button_hover eq "008080"> selected</cfif>>04 - Dark Cyan</option>
<option value="800080"<cfif layoutbutton.button_hover eq "800080"> selected</cfif>>05 - Dark Violet</option>
<option value="808000"<cfif layoutbutton.button_hover eq "808000"> selected</cfif>>06 - Dark Yellow</option>
<option value="772c1b"<cfif layoutbutton.button_hover eq "772c1b"> selected</cfif>>07 - Dark Brown</option>
<option value="aaaaaa"<cfif layoutbutton.button_hover eq "aaaaaa"> selected</cfif>>08 - Gray</option>
<option value="0000bb"<cfif layoutbutton.button_hover eq "0000bb"> selected</cfif>>09 - Blue</option>
<option value="00bb00"<cfif layoutbutton.button_hover eq "00bb00"> selected</cfif>>10 - Green</option>
<option value="bb0000"<cfif layoutbutton.button_hover eq "ff0000"> selected</cfif>>11 - Red</option>
<option value="00bbbb"<cfif layoutbutton.button_hover eq "00bbbb"> selected</cfif>>12 - Cyan</option>
<option value="bb00bb"<cfif layoutbutton.button_hover eq "bb00bb"> selected</cfif>>13 - Violet</option>
<option value="bbbb00"<cfif layoutbutton.button_hover eq "bbbb00"> selected</cfif>>14 - Yellow</option>
<option value="ff8000"<cfif layoutbutton.button_hover eq "ff8000"> selected</cfif>>15 - Orange</option>
<option value="4040ff"<cfif layoutbutton.button_hover eq "4040ff"> selected</cfif>>16 - Light Blue</option>
<option value="40ff40"<cfif layoutbutton.button_hover eq "40ff40"> selected</cfif>>17 - Light Green</option>
<option value="ff0000"<cfif layoutbutton.button_hover eq "ff0000"> selected</cfif>>18 - Light Red</option>
<option value="00ffff"<cfif layoutbutton.button_hover eq "00ffff"> selected</cfif>>19 - Light Cyan</option>
<option value="ff00ff"<cfif layoutbutton.button_hover eq "ff00ff"> selected</cfif>>20 - Light Violet</option>
<option value="ffff00"<cfif layoutbutton.button_hover eq "ffff00"> selected</cfif>>21 - Light Yellow</option>
<option value="b5715a"<cfif layoutbutton.button_hover eq "b5715a"> selected</cfif>>22 - Light Brown</option>
<option value="ffffff" <cfif layoutbutton.button_hover eq "ffffff"> selected</cfif>>23 - White</option></option>
</select>
<br><br><br><font size=1 face="arial">(Move mouse over button sample to test.<br>
Text will auto-center on button when menu is generated.)
</font>
</fieldset>
</td>
</tr>
</table>
<!--- Submit Button not needed (Apply below is used)--->
<br><input type="submit" name="ChangeButton" value="Change Button" width=64><!--- <font face="helvetica" size=1><b> (Refresh browser to view changes)</font> ---><br>

<script>document.getElementById("ButtonText").style.top = tparial;</script>
<!--- Buttons End --->

</td></tr>


<!---<td colspan=3><hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>--->

<tr><td>
<br>
<!---<input type="submit" name="submit" value=" Apply "> <font face="helvetica" size=1><b>(Save Your changes)</font>--->
</td></tr>
</table>

</table>
</div></div>


<!--- END DESIGN SECTION ***************************************************************************************--->

<!---START COMPANY SECTION ************************************************************************************ --->
<div class="header" id="company-header">Company Info</div>
  <div class="content" id="company-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
<!---SECTION--->

                   <tr>
                    <td colspan=2><hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>


                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Company Name:</b>&nbsp;
                     </font><font size=1>(Enter  your company's name here)</font>
                    </td>

 <td>

<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.company_name)#</cfoutput><br></cfif>
             <input type="text" name="company_name" size=60 value="">



&nbsp;<br><input type="submit" name="update_companyname" value="Update Company Name" width=64>
                    </td>


                   </tr>

  <tr>
                    <td colspan=2><hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

 

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Emails:</b>&nbsp;
                     </font><font size=1>(Enter  your email addresses here. DO NOT ENTER ANYTHING AFTER THE @ SYMBOL. Default is site domain name.)<br>Enter your email addresses, and click on "Update Email".</font>
                    </td>

 <td>


<br>
             <input type="text" name="problem_email" size=20 maxlength=255  value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.problem_email)#</cfoutput></cfif>">
<br>

             <input type="text" name="service_email" size=20 maxlength=255  value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.service_email)#</cfoutput></cfif>">

<br>
             <input type="text" name="question_email" size=20 maxlength=255  value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.question_email)#</cfoutput></cfif>">

&nbsp;<br><input type="submit" name="update_email" value="Update Email " width=64>
                    </td>


                   </tr>

</table>
</div></div>
<!--- END COMPANY SECTION ***************************************************************************************--->

<!---START Time SECTION ************************************************************************************ --->
<div class="header" id="time-header">Time Zone</div>
  <div class="content" id="time-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
 <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b> Time:</b>&nbsp;
                     </font><font size=1>(Enter  the time here, numbers only, i.e, +2 for Eastern time, +8 for GMT time (if the server time zone is Pacific time and yours is Central time; likewise, enter -2 if the server time zone is Central time and yours is Pacific time). After changing the time, you need to change the time zone by enter the appropriate time zone in the field listed below (CST, EST, PST,....)).</font><font color=red size=1><b>Be careful when changing the time because it could render your site to not function properly. It's best to change the time when your site is online the first time.</b></font>
                    </td>

 <td colspan=3>

<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.timechange)#</cfoutput><br></cfif>
             <input type="text" name="timechange" size=2 value="">



&nbsp;<br><input type="submit" name="update_time" value="Update Time">&nbsp;&nbsp;&nbsp;
                    </td>
                   </tr>


                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b> Time Zone:</b>&nbsp;
                     </font><font size=1>(Enter the appropriate time zone (CST, EST, PST,....) and click on Update  Time Zone)</font>
                    </td>

 <td colspan=3 >

<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.timezone)#</cfoutput><br></cfif>
             <input type="text" name="timezone" size=5 value="">



&nbsp;<br><input type="submit" name="update_timezone" value="Update Time Zone">&nbsp;&nbsp;&nbsp;
                    </td>


                   </tr>

<tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>


</table>
</div></div>
<!--- END Time SECTION ***************************************************************************************--->
<!---START Payment SECTION ************************************************************************************ --->
<div class="header" id="payment-header">Payment Options</div>
  <div class="content" id="payment-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b> LinkPoint Information:</b>&nbsp;
                     </font><font size=1>(Enter the appropriate LinkPoint info and click update.)</font><font size=1 color=red>. Remember to send the  certificate (save it as yourstore.pem) to your ISP before you enable Linkpoint on your site.<b> Don't try to run both Linkpoint and Authorize at the same time</b></font>
                    </td>

<td colspan=3>
<font size=1>

Enter Yes to enable Linkpoint for your site, No to turn it off:<br></font>

<input type="text" name="linkpoint_enable" size=3 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.linkpoint_enable)#</cfoutput></cfif>">
<br>

<font size=1>

Enter your store id here, usually 6 numbers:<br></font>

             <input type="text" name="LP_REQSTORENAME" size=6 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.LP_REQSTORENAME)#</cfoutput></cfif>">
<br>
<font size=1>
Enter the Linkpoint gatway (the default is secure.linkpoint.net):<br>
</font>


             <input type="text" name="LP_REQHOSTADDR" size=20 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.LP_REQHOSTADDR)#</cfoutput></cfif>">
<br>

<font size=1>
Enter the path to your Linkpoint certificate (the default is c:\\winnt\\system32\\; however, it might be changed for security reason. If this is the case, please ask your ISP for this path):<br>
</font>
<br>
             <input type="text" name="LP_REQKEYFILE" size=30 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.LP_REQKEYFILE)#</cfoutput></cfif>">

&nbsp;<br><input type="submit" name="update_linkpoint" value="Update LinkPoint Information" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b> Authorize.net Information:</b>&nbsp;
                     </font><font size=1>(Enter the appropriate Authorize.net info and click update.)</font>
                    </td>

 <td colspan=3>

<font size=1>

Enter Yes to enable Authorize.net for your site, No to turn it off:<br></font>

             <input type="text" name="authorize_enable" size=3 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.authorize_enable)#</cfoutput></cfif>">
<br>

<font size=1>
Enter your Authorize.net's login: 
</font>

<br>

             <input type="text" name="authorize_login" size=20 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.authorize_login)#</cfoutput></cfif>">
<br>

<font size=1>
Enter  your Authorize.net's password: 
</font>
<br>
             <input type="text" name="authorize_password" size=20 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.authorize_password)#</cfoutput></cfif>">

&nbsp;<br><input type="submit" name="update_authorize" value="Update Authorize.net Information" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b> PayPal Information:</b>&nbsp;
                     </font><font size=1>(Enter the appropriate PayPal info and click update.)</font>
                    </td>


 <td colspan=3>


<font size=1>

Enter Yes to enable PayPal for your site, No to turn it off:<br></font>

             <input type="text" name="paypal_enable" size=3 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.paypal_enable)#</cfoutput></cfif>">
<br>


<font size=1>

Enter your paypal account here:<br></font>

             <input type="text" name="paypal_email" size=20 value="<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.paypal_email)#</cfoutput></cfif>">
<br>

&nbsp;<br><input type="submit" name="update_paypal" value="Update Paypal Information" width=64>
                    </td>


                   </tr>

</table>
</div></div>
<!--- END Payment SECTION ***************************************************************************************--->
<!---START Meta SECTION ************************************************************************************ --->
<div class="header" id="meta-header">Meta Tags</div>
  <div class="content" id="meta-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
 <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Meta Keywords:</b>&nbsp;
                     </font><font size=1>(Enter your meta keywords here if you want the search engines to crawl your site.)</font>
                    </td>

 <td colspan=3>

             <textarea name="Keywords" cols=70 rows=6>
<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.keywords)#</cfoutput></cfif> </textarea>

&nbsp;<br><input type="submit" name="update_keywords" value="Update Meta Keywords Information" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Meta Description:</b>&nbsp;
                     </font><font size=1>(Enter your meta description here if you want the search engines to crawl your site.)</font>
                    </td>

 <td colspan=3>


             <textarea name="descriptions" cols=70 rows=6>
<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.descriptions)#</cfoutput></cfif> </textarea>

&nbsp;<br><input type="submit" name="update_descriptions" value="Update Meta Descriptions Information" width=64>
                    </td>

                   </tr>

</table>
</div></div>
<!--- END Meta SECTION ***************************************************************************************--->
<!---START Legal SECTION ************************************************************************************ --->
<div class="header" id="legal-header">Legal Agreements</div>
  <div class="content" id="legal-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
 <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Privacy:</b>&nbsp;
                     </font><font size=1>(Enter  information about  privacy here)</font>
                    </td>

 <td colspan=3>
             <textarea name="privacy" cols=70 rows=6>
<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.privacy)#</cfoutput></cfif> </textarea>

&nbsp;<br><input type="submit" name="update_privacy" value="Update Privacy Information" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Terms and Conditions:</b>&nbsp;
                     </font><font size=1>(Enter  your terms and conditions here)</font>
                    </td>

 <td colspan=3>

             <textarea name="terms" cols=70 rows=6>
<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.terms)#</cfoutput></cfif> </textarea>

&nbsp;<br><input type="submit" name="update_terms" value="Update Terms and Conditions" width=64>
                    </td>

                   </tr>
</table>
</div></div>
<!--- END Legal SECTION ***************************************************************************************--->
<!---START Pages SECTION ************************************************************************************ --->
<div class="header" id="pages-header">Customize Pages</div>
  <div class="content" id="pages-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>About Us Info:</b>&nbsp;
                     </font><font size=1>(Enter  your company's profile here)</font>
                    </td>

 <td colspan=3>
             <textarea name="about_us" cols=70 rows=6>
<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.about_us)#</cfoutput></cfif> </textarea>

&nbsp;<br><input type="submit" name="update_aboutus" value="Update About Us Info" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Contact Us Info:</b>&nbsp;
                     </font><font size=1>(Enter  your contact info here)</font>
                    </td>

 <td colspan=3>

             <textarea name="contact_us" cols=70 rows=6>
<cfif #get_aboutus.recordcount#>
<cfoutput>#trim(get_aboutus.contact_us)#</cfoutput></cfif> </textarea>


&nbsp;<br><input type="submit" name="update_contactus" value="Update Contact Us Info" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%></td>
                   </tr>

<tr>

                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>News and Announcements Title :</b>&nbsp;<font size=1>(this will be the title of your news)</font>
                     </font>
                    </td>
<td><input type="title" name="title" value="" size=68 maxlength=255></td>
<td>&nbsp;</td>
</tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>News and Announcements:</b>&nbsp;
                     </font><font size=1>(Enter the news and announcements here)</font>
                    </td>

 <td colspan=3>

             <textarea name="news_code" cols=70 rows=6>
<!---<cfif #get_news.recordcount#>
<cfoutput>#trim(get_news.news)#</cfoutput></cfif> ---></textarea>

&nbsp;<br><input type="submit" name="insert_news" value="Add News" width=64>
                    </td>

                   </tr>

<cfquery name="get_news" datasource="#datasource#">
select * from news
</cfquery>
					 <tr>
                    <td valign="bottom"><font face="helvetica" size=2><b>Delete News:</b></font></td>
                   	 <td colspan="3">News<br><select name="selected_news" size=1 width=20><option value="-1"><cfloop query="get_news"><cfoutput><option value="#title#">#left((get_news.title),60)#</cfoutput></option></cfloop></select>
					 <cfif #get_news.recordcount# GT 0>&nbsp;<input type="submit" name="del_news" value="Delete" width=64><cfelse>&nbsp;</cfif>
					 </td>
                     </tr>

</table>
</div></div>
<!--- END Pages SECTION ***************************************************************************************--->
<!---START Logo SECTION ************************************************************************************ --->
<div class="header" id="logo-header">Logo and Images</div>
  <div class="content" id="logo-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
<tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

<cfoutput>
<tr><td>&nbsp;</td><td><cfif #layout.logo# neq ""><img src="../logos/#layout.logo#" ><cfelse>&nbsp;</cfif></td></tr>
				  <tr><td><b>Your site's<br>logo</b></td><td><input name="logo" type="file" size=43 maxlength=250><br><font size="2">Do not put a space in image name.</font><br><input type="submit" name="upload_logo" value="Upload Logo" width=64></td></tr>


<tr><td>&nbsp;</td><td><cfif #layout.promotion_logo# neq ""><img src="../logos/#layout.promotion_logo#" ><cfelse>&nbsp;</cfif></td></tr>
				  <tr><td><b>Your site's<br>promotion<br>banner</b><font size=1> (Your uploaded image will be resized to 230x60, if its width is greater than 230 pixels)</font></td><td><input name="promotion_logo" type="file" size=43 maxlength=250><br><font size="2">Do not put a space in image name.</font><br><input type="submit" name="upload_promotionlogo" value="Upload Promotions banner" width=64></td></tr>
<tr><td>&nbsp;</td>	<td><cfif #layout.studio_logo# neq ""><img src="../logos/#layout.studio_logo#" ><cfelse>&nbsp;</cfif></td></tr>
				  <tr><td><b>Your site's<br>Thumbnails gallery</b><font size=1> (Your uploaded image will be resized to 277x197, if its width is greater than 277 pixels)</font></td><td><input name="studio_logo" type="file" size=43 maxlength=250><br><font size="2">Do not put a space in image name.</font><br><input type="submit" name="upload_studiologo" value="Upload Thumbnail Gallery Image" width=64></td></tr>

</cfoutput>                   

<!--- THIS SECTION NO LONGER USED FOR VERSION 10
******************************* Start Site Layout Template Section *************************************** --->
                   
                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Auction Site Template:</b>&nbsp;
                     </font><font size=1>(Select a template you want to use and click on "Switch Site Template" button)</font>
                    </td>

 <td colspan=3>

<font color=red size=1><b>Note: Only default template is easily customizable</b></font><br>

<input type=radio name="template" value=1 <cfif #layout.template# eq 1> checked</cfif>><a href="<cfoutput>#varoot#</cfoutput>/images/template1.jpg" target=_blank">Default template</a> <br>
<input type=radio name="template" value=3 <cfif #layout.template# eq 3> checked</cfif>> <a href="<cfoutput>#varoot#</cfoutput>/images/template3.jpg" target=_blank">Second template</a> <br>
<input type=radio name="template" value=2  <cfif #layout.template# eq 2> checked</cfif> ><a href="<cfoutput>#varoot#</cfoutput>/images/template2.jpg" target=_blank">Third template</a> <br>

<!--- <input type=radio name="template" value=4  <cfif #layout.template# eq 4> checked</cfif> ><a href="<cfoutput>#varoot#</cfoutput>/images/template4.gif" target=_blank">Fourth template</a> <br> --->

&nbsp;<br><input type="submit" name="SwitchTemplate" value="Switch Site Template" width=64>
                    </td>

                   </tr>

                   <tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>
<!--- *************************** End Site Layout Template Section ************************************* --->
THIS SECTION NO LONGER USED FOR VERSION 10 --->


</table>
</div></div>
<!--- END Logo SECTION ***************************************************************************************--->
<!---START Icons SECTION ************************************************************************************ --->
<div class="header" id="icons-header">Site Icons</div>
  <div class="content" id="icons-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
<cfoutput>

<tr><td><b>Rating Legends</b> (<font size=1>Feedback Ratings</font>. Optimum icon size is 22x22.);</td></tr>
<tr><td>&nbsp;</td><td><cfif #layout.legend1# neq ""><img src="../legends/#layout.legend1#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 0</b></td><td><input name="legend1" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend2# neq ""><img src="../legends/#layout.legend2#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 1</b></td><td><input name="legend2" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend2# neq ""><img src="../legends/#layout.legend2#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 2</b></td><td><input name="legend2" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend3# neq ""><img src="../legends/#layout.legend3#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 3</b></td><td><input name="legend3" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend4# neq ""><img src="../legends/#layout.legend3#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 4</b></td><td><input name="legend4" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend5# neq ""><img src="../legends/#layout.legend5#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 5</b></td><td><input name="legend5" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend6# neq ""><img src="../legends/#layout.legend6#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 6</b></td><td><input name="legend6" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend7# neq ""><img src="../legends/#layout.legend7#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 7</b></td><td><input name="legend7" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend8# neq ""><img src="../legends/#layout.legend8#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 8</b></td><td><input name="legend8" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend9# neq ""><img src="../legends/#layout.legend9#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 9</b></td><td><input name="legend9" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend10# neq ""><img src="../legends/#layout.legend10#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 10</b></td><td><input name="legend10" type="file" size=43 maxlength=250></td></tr>

<tr><td>&nbsp;</td><td><cfif #layout.legend11# neq ""><img src="../legends/#layout.legend11#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Legend 11</b></td><td><input name="legend11" type="file" size=43 maxlength=250>

<tr><td>&nbsp;</td><td><cfif #layout.aboutmeicon# neq ""><img src="../legends/#layout.aboutmeicon#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>About Me Legend</b></td><td><input name="aboutmeicon" type="file" size=43 maxlength=250>

<tr><td>&nbsp;</td><td><cfif #layout.membershipicon# neq ""><img src="../legends/#layout.membershipicon#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Membership Legend</b></td><td><input name="membershipicon" type="file" size=43 maxlength=250>

<tr><td>&nbsp;</td><td><cfif #layout.bidicon# neq ""><img src="../legends/#layout.bidicon#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Bid Icon</b></td><td><input name="bidicon" type="file" size=43 maxlength=250>

<tr><td>&nbsp;</td><td><cfif #layout.descriptionicon# neq ""><img src="../legends/#layout.descriptionicon#" ><cfelse>&nbsp;</cfif></td></tr>

<tr><td><b>Item Description Icon</b></td><td><input name="descriptionicon" type="file" size=43 maxlength=250>
				<br><input type="submit" name="upload_legends" value="Upload Rating Legend Icons" width=64></td></tr>

</cfoutput> 

</table>
</div></div>
<!--- END Icons SECTION ***************************************************************************************--->
<!---START Caching SECTION ************************************************************************************ --->
<div class="header" id="caching-header">Page Caching</div>
  <div class="content" id="caching-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
<tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>
                   <tr>
                    <td valign="top">&nbsp;<font face="helvetica" size=2><b>Enable/Disable caching. Caching makes your site load faster:</b></font>
<font size=1>
(uncheck the box to disable caching for the whole site or for a certain page(s), click on "update home caching", and click <a href="<cfoutput>#varoot#</cfoutput>/event5/event.cfm" target=_blank> here</a> to refresh the site.)</font></td>
                    <td colspan=3>

<input name="all_cache" type="checkbox" value="1"<cfif #all_cache# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Whole site caching.

<input name="homepage_cache" type="checkbox" value="1"<cfif #homepage_cache# is "1" and #all_cache# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Home page caching.

<input name="listings_cache" type="checkbox" value="1"<cfif #listings_cache# is "1" and #all_cache# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Listing pages caching.

<input name="search_cache" type="checkbox" value="1"<cfif #search_cache# is "1" and #all_cache# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Search pages caching.<br>

<br>
<br>
<input type="submit" name="update_caching" value="Update Site Caching" width=6>

</td>

<tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

</table>
</div></div>
<!--- END Caching SECTION ***************************************************************************************--->
<!---START Section Editing SECTION ************************************************************************************ --->
<div class="header" id="section-header">Section Editing</div>
  <div class="content" id="section-content">
    <div class="text">

<table border=0 cellspacing=0 cellpadding=3 bgcolor=bac1cf width=98%>
<!---Make all inner table widths 98%--->
<!--- PASTE CODE HERE--->
            <tr>
                    <td valign="top">&nbsp;<font face="helvetica" size=2><b>Enable/Disable the following sections on the home page :</b></font>
<font size=1>
(uncheck the box to disable section(s), click on "update home page sections", and click <a href="<cfoutput>#varoot#</cfoutput>/event5/event.cfm" target=_blank> here</a> to refresh the site.)<br>
<B>IMPORTANT NOTE: These sections are always disabled when using Fourth Template.</B>
</font></td>
                    <td colspan=3>

<input name="news" type="checkbox" value="1"<cfif #news# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;What's News.

<input name="gallery" type="checkbox" value="1"<cfif #gallery# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Thumbnails Gallery.

<input name="statistic" type="checkbox" value="1"<cfif #statistic# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Statistics.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="promotion" type="checkbox" value="1"<cfif #promotion# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Promotions.<br>


<br>
<input name="featured" type="checkbox" value="1"<cfif #featured# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Featured

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="tellafriend" type="checkbox" value="1"<cfif #tellafriend# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Tell A Friend.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="welcome" type="checkbox" value="1"<cfif #welcome# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Welcome new users.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="topseller" type="checkbox" value="1"<cfif #topseller# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Top Sellers.

<br>

<br><input name="hotauctions" type="checkbox" value="1"<cfif #hotauctions# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Hot Auctions.


<input name="login" type="checkbox" value="1"<cfif #login# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Login.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="hits" type="checkbox" value="1"<cfif #hits# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Home Page Hits.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="useronline" type="checkbox" value="1"<cfif #useronline# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Users Online.<br><input name="visitors" type="checkbox" value="1"<cfif #visitors# is "1"> checked</cfif>><font face="helvetica" size=2>&nbsp;Visitors.(<font color=red size=1> You must turn off caching  for the visitors counter to work. IMPORTANT: Enable visitors tracking and<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
home page counter may decrease site performance significantly.</font>)
<br>
<br>
<input type="submit" name="update_homepage" value="Update Homepage Sections" width=6>

</td>

<tr>
                    <td colspan=4>            <hr size=1 color=<cfoutput>#heading_color#</cfoutput> width=100%> </td>
                   </tr>

<tr>
                    <td colspan=4><b>You can modify the front page by making changes to the following sections.</b></font><font color= red size=1><b><br>Make sure you have  copies of those files first before start modifying them. You need to <a href="#varoot#/event5/event.cfm" target=_blank> refresh</a> the site to see the change(s)</b></font></td>
<td>&nbsp;</td>

                   </tr>

<tr>
<td>&nbsp;</td>

                   </tr>
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>What's New section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_news.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tknews" cols=70 rows=6>#trim (HTMLEditFormat (tknews))#</textarea></cfoutput>
<br>
<input type="submit" name="update_news_section" value="Update What's News Section" width=6>
                    </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Welcome section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_welcome.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkwelcome" cols=70 rows=6>#trim (HTMLEditFormat (tkwelcome))#</textarea></cfoutput>

<br>
<input type="submit" name="update_welcome_section" value="Update Welcome Section" width=6>
                    </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Thumbnail Gallery section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_studio_graphic.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkstudiographic" cols=70 rows=6>#trim (HTMLEditFormat (tkstudiographic))#</textarea></cfoutput>

<br>
<input type="submit" name="update_studiographic_section" value="Update Thumbnail Gallery Section" width=6>
                    </td>
                   </tr>
                   
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Top Seller section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_top_sellers.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tktopseller" cols=70 rows=6>#trim (HTMLEditFormat (tktopseller))#</textarea></cfoutput>

<br>
<input type="submit" name="update_topseller_section" value="Update Top Seller Section" width=6>
                    </td>
                   </tr>
                   
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Hot Auctions section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_hot_auc.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkhotauctions" cols=70 rows=6>#trim (HTMLEditFormat (tkhotauctions))#</textarea></cfoutput>

<br>
<input type="submit" name="update_hotauctions_section" value="Update Hot Auctions Section" width=6>
                    </td>
                   </tr>
                   
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Promotion section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_promotion.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkpromotion" cols=70 rows=6>#trim (HTMLEditFormat (tkpromotion))#</textarea></cfoutput>

<br>
<input type="submit" name="update_promotion_section" value="Update Promotion Section" width=6>
                    </td>
                   </tr>
                   
                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Links section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>The links below the Welcome New Users section. File name:inc_links.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tklinks" cols=70 rows=6>#trim (HTMLEditFormat (tklinks))#</textarea></cfoutput>

<br>
<input type="submit" name="update_links_section" value="Update Links Section" width=6>
                    </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Featured Auctions section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_featured_auc.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkfeatured" cols=70 rows=6>#trim (HTMLEditFormat (tkfeatured))#</textarea></cfoutput>

<br>
<input type="submit" name="update_featured_section" value="Update Featured Section" width=6>
                    </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Tell A Friend section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_email.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkemail" cols=70 rows=6>#trim (HTMLEditFormat (tkemail))#</textarea></cfoutput>

<br>
<input type="submit" name="update_email_section" value="Update Tell A Friend Section" width=6>
                    </td>
                   </tr>

                   <tr>
                    <td valign="top">
                     <font face="helvetica" size=2>
                      &nbsp;<b>Categories section:</b>&nbsp;
                     </font><br>(<font size=1 color=red>File name:inc_categories.cfm</font>)
                    </td>
                    <td colspan=3>
                     <cfoutput><textarea name="tkcategories" cols=70 rows=6>#trim (HTMLEditFormat (tkcategories))#</textarea></cfoutput>


<br>
<input type="submit" name="update_categories_section" value="Update Categories Section" width=6>
                    </td>

                   </tr>
</table>
</form>
</div></div>
<!--- END Section Editing SECTION ***************************************************************************************--->


</div><!---End container Div--->
</td></tr></table><!---TABLE:INNER BORDER--->
</center>
<br>
<!--- Old Submit Button was here --->
</td></tr></table><!---TABLE:OUTER BORDER--->
<br></td></tr></table><!---TABLE:MAIN--->

</body>
</html>
