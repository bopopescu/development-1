<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfset current_page="sellers">
<cfmodule template="../functions/timenow.cfm">
<!-- chk IEscrow enabled/disabled -->
<cfmodule template="../functions/iescrow.cfm"
  sOpt="ChkStatus">
<cfoutput>
<html>
 <head>
  <title>Seller Information</title>
  <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
 </head>

<!--- Include the body tag --->
<cfinclude template="../includes/bodytag.html">
<cfinclude template="../includes/menu_bar.cfm">
 


  <div align="center">

      <!--- The main table --->
      <table border=0 cellspacing=0 cellpadding=2 width=800>
    <tr><td><font size=4><b>Seller Information</b></font>
&nbsp; If you would like to sell on this site please <A HREF="/registration/index.cfm">Click Here</A> to register.
</td></tr>
    <tr><td><hr width=800 size=1 color="#heading_color#" noshade></td></tr>
    
    <tr>
     <td>
     
      
Selling an item (or items) online in an auction format can be very effective.  We encourage you to post as many items as you like and watch as your product is sold to the highest bidder.  Here is some information which will help get you started.

       <br><br>
	   </td></tr></table></div>
	   <div align="center">

<table border=1 cellspacing=0 cellpadding=5 width=800>
<tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#">
<b>What You Should Know</b></td></tr>
<tr>
<td>
Before placing your items for sale, you must first register. Just follow the <b>registered user</b> link below. Payment for our fees may either be via check or credit card <!--- <cfif hIEscrow.bEnabled>or using <A HREF="#VAROOT#/help/faqIEscrow.cfm">eNetSettle services</A></cfif> --->.  By becoming a registered user you will have the ability to sell items on this site. Our fees are described on our <A HREF="#VAROOT#/help/fee_schedule.cfm">Fee&nbsp;Schedule</A> page.
<br><br>
</td>
</tr>


<tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#">
<b>User Agreement</b></td></tr>
<tr>
<td>
Please read our <A HREF="#VAROOT#/registration/user_agreement.cfm">User Agreement</A> which outlines the site policies and terms of use.
<br><br>
</td>
</tr>

<tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#">
<b>Selling Items</b></td></tr>
<tr>
<td>
In order to sell your items in this auction you must be a <A HREF="#VAROOT#/registration/index.cfm">registered user</A>. After you have registered just follow these simple steps.
<OL>
<LI>Click on the <A HREF="../listings/categories/index.cfm">category</A> of your choice.
<LI>Click on the link that says: <IMG SRC="../images/icon_post.gif" align=absmiddle> Post Here!.
<LI>Fill out Post Auction form completely and click the <B>Add Item</B> button to finish.
</OL>
<BR>
</td>
</tr>

<tr bgcolor="#heading_color#"><td style="color:#heading_fcolor#; font-family:#heading_font#">
<b>Personal Information</b></td></tr>
<tr>
<td>
You can check your <A HREF="#VAROOT#/personal/index.cfm">Personal Page</A> which allows you to do the following:
<UL>
<LI>View and edit your personal info.
<LI>View your selling history.
<LI>View your buying history.
<LI>See your user feedback.
<LI>Use the <B>Future Watch</B> feature.
<LI>Relist your expired auctions.
<LI>Edit your current Auction Items.
</UL>
<br>
</td>
</tr>

</table>
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
      </table>
</div>
</body>
</html>
</cfoutput>
