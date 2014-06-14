<cfoutput>

<cfmodule template="../includes/app_globals.cfm">

<cfset directory="Null">

<cfif isdefined("form.uploadtheimage")>

<!--- Set Default Path --->
  <cfset #curPath# = GetTemplatePath()>
  <cfset directory = #GetDirectoryFromPath(curPath)#>

<cfset subfolder="layoutimages">

<cfif trim(form.pageimage) NEQ "">
<cffile action="upload" 
filefield="pageimage" 
DESTINATION="#directory##subfolder#"
nameconflict="overwrite" 
accept='image/*'> 
</cfif>  


<cfquery username="#db_username#" password="#db_password#" name="update_image" 	datasource="#DATASOURCE#">
	          UPDATE layout
<cfif #form.sectionname# eq "col1sec1">SET PageImage1 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col1sec2">SET PageImage2 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col1sec3">SET PageImage3 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col2sec1">SET PageImage4 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col2sec2">SET PageImage5 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col2sec3">SET PageImage6 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col3sec1">SET PageImage7 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col3sec2">SET PageImage8 = '#subfolder#/#cffile.serverfile#'</cfif>
<cfif #form.sectionname# eq "col3sec3">SET PageImage9 = '#subfolder#/#cffile.serverfile#'</cfif>
		</cfquery>


<br>You have successfully uploaded your image to section: #form.sectionname#
</cfif>  

</cfoutput>

<cfif #isDefined ("url.whichsection")#>
<cfelse>
<cfset url.whichsection="3">
</cfif>


<body bgcolor="BAC1CF">
<br><br>
<font size=2 face=arial>
<b>By selecting -IMAGE- this entire section will be replaced (not just header)<br>
by an image of your choosing. The recommended width is 300 pixels.</b>
</font>

<form action="AddImage.cfm" name="imageupload" id="imageupload" method="post" enctype="multipart/form-data">
Browse for image <input type=file name="pageimage" id="pageimage"><input type="submit" value="Upload Image" name="uploadtheimage">
<input type="hidden" <cfoutput>value=#url.whichsection#</cfoutput> name="sectionname">
</form>

</body>  