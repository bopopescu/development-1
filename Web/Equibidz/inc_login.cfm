<style type="text/css"> 
/////////////////////////////////////////////////////////////////////////////////
#container h3 {clear:both; margin-top:4em;}
/* Set Flat Header Width Below */
.flat {background: transparent; width:315px; margin:0 auto;}
.flat h1, .flat p {margin:0 10px;}
.flat h1 {font-size:20px; color:#000000; letter-spacing:1px; font-family:arial}
.flat p {padding-bottom:0.5em;}
.flat .top, .flat .bottom {display:block; background:transparent; font-size:1px;}
.flat .z1, .flat .z2, .flat .z3, .flat .z4, .flat .z1z, .flat .z2z, .flat .z3z, .flat .z4z {display:block; overflow:hidden;}
.flat .z1, .flat .z2, .flat .z3, .flat .z1z, .flat .z2z, .flat .z3z {height:1px;}
.flat .z2 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4 {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z4z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z3z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z2z {background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
.flat .z1 {margin:0 5px; background:#000000;}
.flat .z2, .flat .z2z {margin:0 3px; border-width:0 2px;}
.flat .z3, .flat .z3z {margin:0 2px;}
.flat .z4, .flat .z4z {height:2px; margin:0 1px;}
.flat .z1z {margin:0 5px; background:#000000;}
.flat .boxcontent2 {display:block;  background:<cfoutput>#heading_color#</cfoutput>; border-left:1px solid #000000; border-right:1px solid #000000;}
/////////////////////////////////////////////////////////////////////////////////
</style>

			<cfoutput>

 	
			<table cellpadding=2 border=0 width="100%"> 
<TR>  
<cfif isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">


<td style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>

<div id="container">
<div class="flat">
<b class="top"><b class="z1"></b><b class="z2"></b><b class="z3"></b><b class="z4"></b></b>
<div class="boxcontent2">
<b><a href="#VAROOT#/login.cfm?logout=1"  >Logout</a></b>
</div>
<b class="bottom"><b class="z4z"></b><b class="z3z"></b><b class="z2z"></b>
<b class="z1z"></b></b>
</div>

</td>    

<cfelse>

<td style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;" align=center >

<div id="container">
<div class="flat">
<b class="top"><b class="z1"></b><b class="z2"></b><b class="z3"></b><b class="z4"></b></b>
<div class="boxcontent2">
<b>Login</b>
</div>
<b class="bottom"><b class="z4z"></b><b class="z3z"></b><b class="z2z"></b>
<b class="z1z"></b></b>
</div>


</td>    

</cfif>
</tr>


</cfoutput>





                 <tr>
                    <td>





<cfif  isdefined("session.user_id") and session.user_id neq "" and isdefined("session.password") and session.password neq "">
             
<cfquery name="get_user" datasource="#datasource#">

select nickname from users where user_id=#session.user_id#

</cfquery>

      <table border=0 cellspacing=0 cellpadding=4 align=center>		
<tr>
<td>


<cfoutput>

<font color=red>Welcome back <font color=blue size=2><b><i>#get_user.nickname#</i></b></font>. <br>

You are logged in.</font>

</cfoutput>

</td>
</tr>

</table>
<cfelse>



      <table border=0 cellspacing=0 cellpadding=4 align=center>				    

		 <form name="loginform" action="login.cfm" method="post">
		 <input type=hidden name="login" value="1">
	   <cfif isdefined("prev_http_referer") >
	   	<input type="Hidden" name="prev_http_referer" value="#prev_http_referer#">
	   </cfif>







         <tr><td><b>Username:</b></td><td><input type="text" name="user_id" value="" size=12 maxlength=20>

</td></tr>







         <tr><td><b>Password:</b></td><td><input type="password" name="password" value="" size=12 maxlength=12>

</td>
</tr>

<tr>
<td>
   <a href="registration/findpassword.cfm"><font size="1">Forgotten your password?</font></a>
			<br>
<center>
        <input type="submit" name="submit" value="Log In" width="75" >

</center>

</td>
</tr>                
        
      </table> 
        
		

       </form>




</td></tr>

</cfif>	
			</table>

