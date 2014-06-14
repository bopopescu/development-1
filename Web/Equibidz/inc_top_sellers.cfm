




			<cfoutput>
			<table cellpadding=2 border=0 width="100%"> 
			 	<TR bgcolor=#heading_color#> 
               <td WIDTH=220 style="color:#heading_fcolor#; font-family:#heading_font#;font-size:#heading_font_size#px;" align=center><b>.:Top sellers:.</b></td>    
				</TR>

</cfoutput>
                  <tr>
                    <td>
				    
					<font color = #heading_color#><B>
<cfif  #get_sellers.recordcount# >

                            <cfloop query="get_Sellers">
         
<cfquery name="getstatus" datasource="#datasource#">

select * from users where user_id = #user_id#
</cfquery>

                     <cfoutput>
<center>                               
      <a href="#VAROOT#/search/search_results.cfm?search_type=seller_search&search_name=Search+by+Seller&search_text=#Trim(getstatus.nickname)#&order_by=title&sort_order=ASC ">#Trim(getstatus.nickname)#</a><br> 

</center>
                              </cfoutput> 
                            </cfloop>

<cfelse>
<center>
No top seller found
</center>
</cfif>


					</font>
					</td>
                  </tr>				
			</table>
