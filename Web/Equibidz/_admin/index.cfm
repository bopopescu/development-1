<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<cfoutput>
  <cfset curPath = GetBaseTemplatePath()>
  <cfset directory = GetDirectoryFromPath(curPath)>
  <cfset directory = Replace(GetDirectoryFromPath("#curPath#"),"sell","fullsize_thumbs/")>
  <cfset picture1 = "photo1.JPG">
==} #directory# : #picture1#
<!--- This example shows how to resize an image to fit a 100x100-pixel square while maintaining the aspect ratio. ---> 
<!--- Create a ColdFusion image from an existing JPEG file. ---> 
<cfimage source="#directory##picture1#" name="myImage" action="read">
<cfdump var="#myImage#">
<!--- Turn on antialiasing to improve image quality. ---> 
<cfset ImageSetAntialiasing(myImage,"on")> 
<cfset ImageScaleToFit(myImage,300, "")> 
<!--- Display the modified image in a browser. ---> 
<table bgcolor="##0B0000" width="800" border="1" cellspacing="5" cellpadding="5">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><cfimage source="#myImage#" action="writeToBrowser"></td>
    <td>&nbsp;</td>
  </tr>
</table>
</cfoutput>
</body>
</html>
