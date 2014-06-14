
        <table border=0 cellspacing=0 cellpadding=0 noshade width=800>
          <tr>
            <td>
<cfif isdefined("itemnum")>
              <p>Sorry... item not found.

<cfelse>
              <p>Sorry... you must supply an item number on which to place your bid.

</cfif>

<cfif isdefined("CGI.HTTP_REFERER") and len(CGI.HTTP_REFERER) GT 0>
              <p>You may <a href="<cfoutput>#CGI.HTTP_REFERER#</cfoutput>">go back</a> to the page that brought you here, or

</cfif>

              <p>Please <a href="../listings/categories/">browse</a> items and place your bids on the item's details page.

            </td>
          </tr>
        </table>
