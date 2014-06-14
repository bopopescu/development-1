<!--- Code to get current images and sections from database --->
<!--- change statis info to CF variables in setcols() function below --->

<script>

/*
LEGEND (Stored by number in database Layout table under colsec):

None=0
Auctions-By-State=1
Categories=2
Tell A Friend=3
Thumbnails Gallery=4
Featured Auctions=5
Hot Auctions=6
Login=7
Promotions=8
Welcome New Users=9
IMAGE=10

*/


/*  */
function gettheSelected() {
var Dropdown1 = document.getElementById('col1sec1').selectedIndex;
var Dropdown2 = document.getElementById('col1sec2').selectedIndex;
var Dropdown3 = document.getElementById('col1sec3').selectedIndex;
var Dropdown4 = document.getElementById('col2sec1').selectedIndex;
var Dropdown5 = document.getElementById('col2sec2').selectedIndex;
var Dropdown6 = document.getElementById('col2sec3').selectedIndex;
var Dropdown7 = document.getElementById('col3sec1').selectedIndex;
var Dropdown8 = document.getElementById('col3sec2').selectedIndex;
var Dropdown9 = document.getElementById('col3sec3').selectedIndex;
alert("Col1 Sec1: "+Dropdown1+", Col1 Sec2: "+Dropdown2+", Col1 Sec3: "+Dropdown3+", Col2 Sec1:"+Dropdown4+", Col2 Sec2: "+Dropdown5+", Col2 Sec3: "+Dropdown6+", Col3 Sec1:"+Dropdown7+", Col3 Sec2: "+Dropdown8+", Col3 Sec3: "+Dropdown9);
}


function uploadimage(sectionid) {
window.open ('addimage.cfm?whichsection='+sectionid, 'newWin', 'scrollbars=Yes,status=no,width=500,height=400')
}

function setCols() {
// Define Columns
var resetDropdown1 = document.getElementById('col1sec1');
var resetDropdown2 = document.getElementById('col1sec2');
var resetDropdown3 = document.getElementById('col1sec3');
var resetDropdown4 = document.getElementById('col2sec1');
var resetDropdown5 = document.getElementById('col2sec2');
var resetDropdown6 = document.getElementById('col2sec3');
var resetDropdown7 = document.getElementById('col3sec1');
var resetDropdown8 = document.getElementById('col3sec2');
var resetDropdown9 = document.getElementById('col3sec3');
//Set Images
document.getElementById('showorhide').style.visibility = "visible";	
document.picture1.src = "layoutimages/map_section.gif";	
document.picture2.src = "layoutimages/categories_section.gif";	
document.picture3.src = "layoutimages/tellafriend_section.gif";	
document.picture4.src = "layoutimages/featured_section.gif";	
document.picture5.src = "layoutimages/hot_section.gif";	
document.picture6.src = "layoutimages/gallery_section.gif";	
document.picture7.src = "layoutimages/login_section.gif";	
document.picture8.src = "layoutimages/promotions_section.gif";	
document.picture9.src = "layoutimages/newusers_section.gif";	
//Set Column sections (see legend above)
resetDropdown1.selectedIndex = 1;	
resetDropdown2.selectedIndex = 2;	
resetDropdown3.selectedIndex = 3;	
resetDropdown4.selectedIndex = 5;	
resetDropdown5.selectedIndex = 6;	
resetDropdown6.selectedIndex = 4;	
resetDropdown7.selectedIndex = 7;	
resetDropdown8.selectedIndex = 8;	
resetDropdown9.selectedIndex = 9;	
}


function setsection(sectionID,pictureID) {
var mySetSelection = document.getElementById('layouttype');
var thisSection = document.getElementById(sectionID);
var picPosition = document.getElementById(pictureID);

	if(thisSection.value == "none") {
picPosition.src = "layoutimages/no_section.gif";	
	}
	if(thisSection.value == "categories") {
picPosition.src = "layoutimages/categories_section.gif";	
	}
	if(thisSection.value == "map") {
picPosition.src = "layoutimages/map_section.gif";	
	}
	if(thisSection.value == "tellafriend") {
picPosition.src = "layoutimages/tellafriend_section.gif";	
	}
	if(thisSection.value == "gallery") {
picPosition.src = "layoutimages/gallery_section.gif";	
	}
	if(thisSection.value == "featured") {
picPosition.src = "layoutimages/featured_section.gif";	
	}
	if(thisSection.value == "hot") {
picPosition.src = "layoutimages/hot_section.gif";
	}	
	if(thisSection.value == "loginsection") {
picPosition.src = "layoutimages/login_section.gif";	
	}
	if(thisSection.value == "promotions") {
picPosition.src = "layoutimages/promotions_section.gif";	
	}
	if(thisSection.value == "newusers") {
picPosition.src = "layoutimages/newusers_section.gif";	
	}
	if(thisSection.value == "imageonly") {
picPosition.src = "layoutimages/imageonly.gif";
window.open ('addimage.cfm?whichsection='+sectionID, 'newWin', 'scrollbars=no,status=no,width=500,height=200');
	}
}

</script>

<body bgcolor="BAC1CF">

<form>

<table border=0>
<tr>

<td align=center width=250>
<font size=2 face="arial"><b>How To Set Main Page Layout</b></font><br>
<fieldset style="width:200;height:200px;border: 1px solid #68878d;padding:5px;">
<div style="text-align: left;">
<font size=1 face="arial">
<ul>
<li>Use drop-down boxes below to select desired sections for each column.
<li>Selections will show up in the layout box on right.
<li>Select "none" if you want to remove a section.
<li>Select "-IMAGE-" if you want to replace a section with an image.
<li>Images should be limited to 300 pixels in width.
<ul>
</div><br>
</fieldset>
</td>

<td colspan=2 align=center>
<font size=2 face="arial"><b>Page Layout</b></font>
<font size=1 face=arial>(<a href="javascript:gettheSelected()">Currently Selected</a>)</font><br>
<fieldset style="width:460px;height:220px;border: 1px solid #68878d;padding:5px;">
<br>

<img src="layoutimages/map_section.gif" name="picture1" id="picture1">&nbsp&nbsp&nbsp<img src="layoutimages/featured_section.gif" name="picture4" id="picture4">&nbsp&nbsp&nbsp<img src="layoutimages/login_section.gif" name="picture7" id="picture7"><br>

<img src="layoutimages/categories_section.gif" name="picture2" id="picture2">&nbsp&nbsp&nbsp<img src="layoutimages/hot_section.gif" name="picture5" id="picture5">&nbsp&nbsp&nbsp<img src="layoutimages/promotions_section.gif" name="picture8" id="picture8"><br>

<img src="layoutimages/tellafriend_section.gif" name="picture3" id="picture3">&nbsp&nbsp&nbsp<img src="layoutimages/gallery_section.gif" name="picture6" id="picture6">&nbsp&nbsp&nbsp<img src="layoutimages/newusers_section.gif" name="picture9" id="picture9"><br>

</fieldset>
</td>

</tr>

<tr>

<td align=center width=250><br>
<font size=2 face="arial"><b>Column 1</b></font><br>
<fieldset style="width:200;height:185px;border: 1px solid #68878d;padding:5px;">
Section 1
<SELECT NAME="col1sec1" ID="col1sec1" onchange="setsection('col1sec1','picture1')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map" SELECTED>Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT><br><br>
Section 2
<SELECT NAME="col1sec2" ID="col1sec2" onchange="setsection('col1sec2','picture2')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories" SELECTED>Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT><br><br>
Section 3
<SELECT NAME="col1sec3" ID="col1sec3" onchange="setsection('col1sec3','picture3')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend" SELECTED>Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT>
</fieldset>
</td>
<! --- ******************************************************** --->

<td align=center width=250><br>
<font size=2 face="arial"><b>Column 2</b></font><br>
<fieldset style="width:200;height:185px;border: 1px solid #68878d;padding:5px;">
Section 1
<SELECT NAME="col2sec1" ID="col2sec1" onchange="setsection('col2sec1','picture4')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured" SELECTED>Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT><br><br>
Section 2
<SELECT NAME="col2sec2" ID="col2sec2" onchange="setsection('col2sec2','picture5')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot" SELECTED>Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT><br><br>
Section 3
<SELECT NAME="col2sec3" ID="col2sec3" onchange="setsection('col2sec3','picture6')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery" SELECTED>Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT>
</fieldset>
</td>
<! --- ******************************************************** --->

<td align=center width=250><br>
<div id="showorhide" style="visibility:show;">
<font size=2 face="arial"><b>Column 3</b></font><br>
<fieldset style="width:200;height:185px;border: 1px solid #68878d;padding:5px;">
Section 1
<SELECT NAME="col3sec1" ID="col3sec1" onchange="setsection('col3sec1','picture7')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection" SELECTED>Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT><br><br>
Section 2
<SELECT NAME="col3sec2" ID="col3sec2" onchange="setsection('col3sec2','picture8')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions" SELECTED>Promotions</option>
<OPTION VALUE="newusers">Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT><br><br>
Section 3
<SELECT NAME="col3sec3" ID="col3sec3" onchange="setsection('col3sec3','picture9')">
<OPTION VALUE="none">None</option>
<OPTION VALUE="map">Auctions-By-State</option>
<OPTION VALUE="categories">Categories</option>
<OPTION VALUE="tellafriend">Tell A friend</option>
<OPTION VALUE="gallery">Thumbnails Gallery</option>
<OPTION VALUE="featured">Featured Auctions</option>
<OPTION VALUE="hot">Hot Auctions</option>
<OPTION VALUE="loginsection">Login</option>
<OPTION VALUE="promotions">Promotions</option>
<OPTION VALUE="newusers" SELECTED>Welcome New Users</option>
<OPTION VALUE="imageonly">-IMAGE-</option>
</SELECT>
</fieldset>
</div>
</td>
<! --- ******************************************************** --->



</tr>
</table>

</form>             

<script>setCols()</script>

</body>

