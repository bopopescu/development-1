<cfinclude template = "../includes/app_globals.cfm">
<!--- Include session tracking template --->
<cfinclude template="../includes/session_include.cfm">

<cfif (#isDefined ("session.user_id")# is 0) or
       (#isDefined ("session.password")# is 0)>
  <cflocation url="../personal/index.cfm">
 </cfif>

<cfquery username="#db_username#" password="#db_password#" name="get_cats" datasource="#DATASOURCE#">
    SELECT category,parent,name
    FROM categories
	WHERE (user_id = 0 or user_id = #session.user_id#)
	AND allow_sales = 1
	AND category > 0
	ORDER BY parent
</cfquery>

<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<TITLE>data_instruction</TITLE>
<link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
</HEAD>
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
<center>
<!--- <table>
<tr><td><IMG SRC="../images/logohere.gif"> &nbsp; &nbsp; &nbsp; <FONT SIZE=2><cfinclude template="../includes/menu_bar.cfm"></FONT><br><br></td></tr>
</table> --->
</center>
<Table border>
<tr><td colspan="3" align="center"><H2>Data Type Information</H2></td></tr>
<TR ALIGN="center" VALIGN="bottom">
<TD><B>Column Name</B></TD>
<TD><B>Data Type</B></TD>
<TD><B>Description</B></TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>category1</B></FONT></TD>
<TD ALIGN="left">Number</TD>
<TD ALIGN="left">Predefined nine digits (list below).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>category2</B></FONT></TD>
<TD ALIGN="left">Number</TD>
<TD ALIGN="left">Predefined nine digits (list below) (optional choice; if it is none, enter -1).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>auction_type</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">One letter: E(nglish), V(ickrey), D(utch) or Y(ankee). Please refer to our help page for more info.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>title</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Item's title: please note that the maximum length allowed is 45 digits, if longer it will be truncated.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>auction_mode</B></FONT></TD>
<TD ALIGN="left">Number</TD>
<TD ALIGN="left">0 (normal auction) or 1 (reversed auction, not available at this moment).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>minimum_bid</B></FONT></TD>
<TD ALIGN="left">Currency</TD>
<TD ALIGN="left">The starting bid for your item (please use only decimal point, if any).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>maximum_bid</B></FONT></TD>
<TD ALIGN="left">Currency</TD>
<TD ALIGN="left">Maximum bid for reverse auction (not available at this moment).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>location</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Your location.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>country</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Your Country.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>pay_morder_ccheck</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by money order or cashier check.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>pay_cod</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by COD.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT COLOR=0000FF><B>pay_see_desc</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">See item description for payment information.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>pay_pcheck</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by personal check.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>pay_ol_escrow</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by online escrow.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>pay_other</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by other/not listed here.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>pay_visa_mc</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by VISA/MasterCard.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>pay_am_express</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by American Express card.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>pay_descover</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Accept payment by Discover card.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>ship_sell_pays</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Seller pays shipping costs.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>ship_buy_pays</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Buyer pays actual shipping costs.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>ship_see_desc</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">See item description for shipping information.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>ship_buy_pays_fxd</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Buyer pays fixed shipping costs.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>ship_international</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">Allow international shipping.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>description</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Item's description (including html codes).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>picture</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Get item's picture from specific URL.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>sound</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Get item's sound from specific URL.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>quantity</B></FONT></TD>
<TD ALIGN="left">Number</TD>
<TD ALIGN="left"><FONT >Item's quantity (for Dutch auctions only).</FONT></TD>
</TR>
<!--- <TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>increment</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off increment.</TD>
</TR> --->
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>increment_valu</B></FONT></TD>
<TD ALIGN="left">Currency</TD>
<TD ALIGN="left">Predefined value (please use only decimal point, if any).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>dynamic</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off dynamic.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>dynamic_valu</B></FONT></TD>
<TD ALIGN="left">Number</TD>
<TD ALIGN="left">Once dynamic is on, you need to set minutes to extended.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>reverse_bid</B></FONT></TD>
<TD ALIGN="left">Currency</TD>
<TD ALIGN="left">Setting reserved amount for the item, 0 if not a reserve auction (please use only decimal point, if any).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>bold_title</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off bold title.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>featured</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off featured in front page.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>featured_cat</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off featured in category.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>private</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off email to user.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>banner</B></FONT></TD>
<TD ALIGN="left">Boolean</TD>
<TD ALIGN="left">On or off banner.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>banner_line</B></FONT></TD>
<TD ALIGN="left">Text</TD>
<TD ALIGN="left">Banner's content (required only if previous field is "True"): please note that the maximum length is 45 digits, if longer it will be truncated.</TD>
</TR>
<!--- <TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>date_start</B></FONT></TD>
<TD ALIGN="left"><FONT >Date/Time</FONT></TD>
<TD ALIGN="left"><FONT >Item's starting date (please use only m/dd/yy hh:mm:ss AM/PM format).</FONT></TD>
</TR> --->
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>date_end</B></FONT></TD>
<TD ALIGN="left">Date/Time</TD>
<TD ALIGN="left">Item's ending date (please use only m/dd/yy format).</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>auto_relist</B></FONT></TD>
<TD ALIGN="left">Number</TD>
<TD ALIGN="left">Number of times you want your item relisted automatically, if previously unsold.</TD>
</TR>
<!--- <TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>buynow</B></FONT></TD>
<TD ALIGN="left"><FONT >True/False</FONT></TD>
<TD ALIGN="left"><FONT >On or Off the buynow function.</FONT></TD>
</TR> --->
<TR VALIGN="bottom">
<TD ALIGN="left"><FONT  COLOR=0000FF><B>buynow_price</B></FONT></TD>
<TD ALIGN="left">currency</TD>
<TD ALIGN="left">The buynow function is on, when you set buynow_price greater than minimum_bid.</TD>
</TR>
<TR VALIGN="bottom">
<TD ALIGN="right">&nbsp;</TD>
<TD ALIGN="right">&nbsp;</TD>
<TD ALIGN="right">&nbsp;</TD>
</TR>
</Table>

<p><table border>
	<tr><td colspan="3" align="center"><h2>Categories</h2></td></tr>
	<tr>
		<th>Category Name</th>
		<th>Category ID</th>
		<th>Parent</th>
	</tr>
	<cfoutput><cfloop query="get_cats">
	<cfquery username="#db_username#" password="#db_password#" name="get_parent" datasource="#DATASOURCE#">
	SELECT name
	FROM categories
	WHERE category = #parent#
	<!--- AND parent > 0 --->
	AND category > 0
	</cfquery>
	<tr>
		<td width="300">#name#</td>
		<td width="100"><font color="0000ff">#category#</font></td>
		<cfif get_parent.recordcount gt 0><td width="200">#get_parent.name#</td><cfelse><td width="200">&nbsp;</td></cfif>
	</tr>
	</cfloop></cfoutput>
</table>
</BODY>
</HTML>
