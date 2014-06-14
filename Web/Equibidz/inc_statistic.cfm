<!--- Statistics Heading --->
        	<table cellpadding=2 border=0 width="100%">
            <tr>
               <cfoutput>
			   <td bgcolor=#heading_color# style="color:#heading_fcolor#;font-family:#heading_font#;font-size:#heading_font_size#px;" align=center>
				<b>.:Statistics:.</b>
			   </td>
			   </cfoutput>
            </tr>
         	</table>
			  
         	<table border=0 cellspacing=0 cellpadding=5 noshade width="100%">
             <!--- Output Statistics --->
				<cfoutput>
                  <tr>
                    <td><font size=2><b>#get_stats.auctions#</b> auctions in <b>#get_stats.categories#</b> categories now!</font></td>
                  </tr>
                  <!--- <tr>
                    <td><font size=2><b>#get_stats.total_auctions#</b> auctions since inception!</font></td>
                  </tr> --->
                  <tr>
                    <td><font size=2><b>#get_stats.bids#</b> bids made since inception!</font></td>
                  </tr>

<cfif #get_layout.visitors# eq 1>
   <tr>
                    <td><font size=2><b>#get_stats.tracking#</b> Visitors since inception!</font></td>
                  </tr>
</cfif>
				  <tr><td><FONT SIZE=1 FACE="arial,helvetica,geneva">NOTE: Statistics update every two hours.</FONT></td></tr>

                </cfoutput>
				<!--- End Output Statistics --->
             
             </table>
