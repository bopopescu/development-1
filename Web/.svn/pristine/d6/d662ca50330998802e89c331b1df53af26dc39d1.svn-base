


 <cfinclude template="app_globals.cfm">

 
 <cfparam name="img_width" default="400">
<!--- usage: include <cf_banner> in your program--->
<cfquery datasource="#datasource#" name="qrylogos">
        select ID,factor from banners
</cfquery>

<cfif #qrylogos.recordcount# NEQ 0>
<cfset logoarray = arraynew(2)>
<cfset indexno=1>
<cfloop query="qrylogos">
<cfloop index="i" from="1" to="#factor#">
<cfset logoarray[#indexno#][1]=#indexno#>
<cfset logoarray[#indexno#][2]=#ID#>
<cfset indexno=indexno+1>
</cfloop>
</cfloop>
<cfset indexno=indexno-1>
<cfset inno=#randrange(1,indexno)#>
<cfset id=#logoarray[inno][2]#>
<cfquery datasource="#datasource#" name="qrylogocount">
select *
from banners 
where ID=#id# and banner_enable=1 
</cfquery>



<center>

<!--- ************************* --->
<cfset Img_width=124>
<cfset Img_height=110>
	
                    <cfif #qrylogocount.file_name# is not "">
                      <cfset #thePath# = #Replace(GetDirectoryFromPath(GetTemplatePath()),"includes\","banners\")#>
                      
<cfif fileExists("#thePath##qrylogocount.file_name#.jpg")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##qrylogocount.file_name#.jpg">--->
<cfif img_height is "" or img_width is "">

<cfelse>
	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 400>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 400>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif> 
</cfif>	 

<cfelseif fileExists("#thePath##qrylogocount.file_name#.gif")>
	  <!---<CFX_GIFGD ACTION="READ" FILE="#thePath##qrylogocount.file_name#.gif">--->

	  <cfif img_height gt img_width>
	  	<cfset width = (Img_width/Img_height) * 400>
	  	<cfset height = (Img_height/Img_width) * width>
	  <cfelse>
	  	<cfset height = (Img_height/Img_width) * 400>
	  	<cfset width = (Img_width/Img_height) * height>
	  </cfif>
     
</cfif>
    
    <cfelse>
   <!--- No Thumbnail --->
                    
    </cfif>  

	  <!--- ************************* --->
	  
<cfoutput query="qrylogocount">
<!---
<cfif (ban_hptop eq 1 AND placehp eq 1) OR (ban_am eq 1 AND placeam eq 1)>
--->
<cfif #file_name# is "">

<img src="/images/dot.gif" width="400" height="60" border="0" align="absmiddle">


<cfelse>
<cfif img_width gt 400>
<a href="#webaddress#"><img src="/banners/#file_name#" width=#witdh# height=#height# border="0" align="absmiddle"></a>
<cfelse>
<a href="#webaddress#"><img src="/banners/#file_name#" border="0" align="absmiddle"></a>
</cfif>


</cfif>

</cfoutput>
</center>

</cfif>


