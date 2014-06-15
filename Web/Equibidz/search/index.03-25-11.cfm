<cfsetting enablecfoutputonly="yes">
<!---
	Search Page:



--->


<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">



<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<!--- Check for passed-in params --->
<cfif #isDefined ("search_text")# is 0>
  <cfset #search_text# = "">
</cfif>
<cfif #isDefined ("search_span")# is 0>
  <cfset #search_span# = "title">
</cfif>
<cfif #isDefined ("search_limit")# is 0>
  <cfset #search_limit# = "active">
</cfif>
<cfif #isDefined ("order_by")# is 0>
  <cfset #order_by# = "title">
</cfif>
<cfif #isDefined ("sort_order")# is 0>
  <cfset #sort_order# = "ASC">
</cfif>
<cfif #isDefined ("country")# is 0>
  <cfset #country# = "">
</cfif>
<cfif #isDefined ("country_type")# is 0>
  <cfset #country_type# = "in">
</cfif>
<cfif #isDefined ("search_type")# is 0>
  <cfset #search_type# = "title_search">
</cfif>
<cfif #isDefined ("category")# is 0>
  <cfset #category# = "">
</cfif>
<cfif #isDefined ("radius")# is 0>
  <cfset #radius# = "5">
</cfif>
<cfif #isDefined ("measure_type")# is 0>
  <cfset #measure_type# = "MI">
</cfif>

<!--- Get their info if they're logged in --->
<cfif #isDefined ("session.nickname")#>
  <cfquery username="#db_username#" password="#db_password#" name="get_user_info" datasource="#DATASOURCE#">
      SELECT user_id,
             nickname,
             name,
             password,
             email
        FROM users
       WHERE nickname = '#session.nickname#'
  </cfquery>
  
  <cfset temp_var = find (" ", get_user_info.name) - 1>
  <cfif temp_var lt 0>
    <cfset not_less_than_one = 1>
  <cfelse>
    <cfset not_less_than_one = temp_var>
  </cfif>
  
  <cfset user_fname = left (get_user_info.name, not_less_than_one)>
<cfelse>
  <cfset #user_fname# = "">
</cfif>

<cfoutput>
<html>
  <head>
    <title>Main Search Page</title>
    <link rel=stylesheet href="#VAROOT#/includes/stylesheet.css" type="text/css">
  </head>
  
  <cfinclude template="../includes/bodytag.html">
    <cfinclude template="../includes/menu_bar.cfm">
    <!--- The main table --->
   <div align="center">
   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td>
            <font size=4>
              <b>Main Search Page</b>
            </font>
          </td>
        </tr>
        <tr>
          <td>         <hr size=1 color=#heading_color# width=100%></td>
        </tr>
        <tr>
          <td>
            <font size=2>
              This page will enable you to search for the items you want in an easy,
              flexible manner.  Each box below contains a different search method; choose
              the one that best suits your needs.  If one method doesn't yield the results
              you are looking for, try other searches until you get useful results.<br>
              <br>
              <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0>
                <tr>
                  <td>
                    <form name="search" action="search_results.cfm" method="get">
                      <input type="hidden" name="search_type" value="title_search">
                      <input type="hidden" name="search_name" value="tds">
                      <table border=0 cellspacing=0 cellpadding=4 width=800>
                        <tr bgcolor="#heading_color#">
                          <td colspan=4>
                            <table border=0 cellspacing=0 cellpadding=0 width=100%>
                              <tr>
                                <td style="color:#heading_fcolor#; font-family:#heading_font#">
                                    <b>Item Title and Description Search</b>
                                </td>
                                <td align="right">
                                  <font size=2 color="eeeeee">
                                    <i>(Searches item titles &amp; descriptions for keywords)</i>
                                  </font>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td colspan=4>&nbsp;</td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>Search for:</b></td>
                          <td>
                            <input type="text" name="search_text" size=45 maxlength=80<cfif #search_type# is "title_search"> value="#search_text#"</cfif>>
                          </td>
                          <td width=95>
                            <input type="submit" id="submit" value="Search" width=75>
                          </td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>Match:</b></td>
                          <td colspan=2>
                            <input name="phrase_match" type=radio value="any" checked> Any Word &nbsp;
                            <input name="phrase_match" type=radio value="all"> All Words &nbsp;
                            <input name="phrase_match" type=radio value="exact"> Exact Phrase &nbsp;
                          </td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>In category:</b></td>
                          <td colspan=2>
                            </cfoutput>
                            <cfmodule template="..\functions\cf_category_tree.cfm"
                              datasource="#DATASOURCE#"
                              parent="0"
                              type="SELECT"
                              selectname="category"
                              selected="#category#"
                              active_only="1"
                              show_none="< Any Category >">
                            <cfoutput>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>Search in:</b></td>
                          <td colspan=2>
                            <table border=0 cellspacing=0 cellpadding=0>
                              <tr>
                                <td>
                                  <input type="radio" name="search_span" value="title"<cfif #search_span# is "title"> checked</cfif>>
                                </td>
                                <td>&nbsp;Titles</td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <input type="radio" name="search_span" value="description"<cfif #search_span# is "description"> checked</cfif>>
                                </td>
                                <td>&nbsp;Descriptions</td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>Limit to:</b></td>
                          <td colspan=2>
                            <table border=0 cellspacing=0 cellpadding=0>
                              <tr>
                                <td>
                                  <input type="radio" name="search_limit" value="active"<cfif #search_limit# is "active"> checked</cfif>>
                                </td>
                                <td>&nbsp;Active</td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <input type="radio" name="search_limit" value="inactive"<cfif #search_limit# is "inactive"> checked</cfif>>
                                </td>
                                <td>&nbsp;Inactive</td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <input type="radio" name="search_limit" value="all"<cfif #search_limit# is "all"> checked</cfif>>
                                </td>
                                <td>&nbsp;All Items</td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>Country:</b></td>
                          <td colspan=2>
                            <table border=0 cellspacing=0 cellpadding=0>
                              <tr>
                                <td>
                                  <input type="radio" name="country_type" value="in"<cfif #country_type# is "in"> checked</cfif>>Located in
                                </td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <input type="radio" name="country_type" value="available"<cfif #country_type# is "available"> checked</cfif>>Available in
                                </td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <CFMODULE TEMPLATE="..\functions\cf_countries.cfm" SELECTNAME="country" SELECTED="#country#" MULTIPLE="0" SIZE="1" ANY="1">
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td><b>Order by:</b></td>
                          <td colspan=2>
                            <table border=0 cellspacing=0 cellpadding=0>
                              <tr>
                                <td>
                                  <select name="order_by">
                                    <option value="title"<cfif #order_by# is "title"> selected</cfif>>Item title</option>
                                    <option value="date_start"<cfif #order_by# is "date_start"> selected</cfif>>Starting date</option>
                                    <option value="date_end"<cfif #order_by# is "date_end"> selected</cfif>>Ending date</option>
<!---                                     <option value="">Bid price</option> --->
                                  </select>
                                </td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <input type="radio" name="sort_order" value="ASC"<cfif #sort_order# is "ASC"> checked</cfif>>Ascending (A-Z)
                                </td>
                                <td width=15>&nbsp;</td>
                                <td>
                                  <input type="radio" name="sort_order" value="DESC"<cfif #sort_order# is "DESC"> checked</cfif>>Descending (Z-A)
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
                        </tr>
                        <tr>
                          <td width=10>&nbsp;</td>
                          <td colspan=3>
                            Click <a href="#VAROOT#/help/searching.cfm##titlesearch">here</a> for more search tips.
                          </td>
                        </tr>
                      </table>
                    </form>
                  </td>
                </tr>
              </table>
            </font>
          </td>
        </tr>
        
        <!--- Item ID search --->
        <tr>
          <td>
            <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0>
              <tr>
                <td>
                  <form name="search" action="search_results.cfm" method="get">
                    <input type="hidden" name="search_type" value="item_search">
                    <input type="hidden" name="search_name" value="Item Search">
                    <table border=0 cellspacing=0 cellpadding=4 width=800>
                      <tr bgcolor="#heading_color#">
                        <td colspan=4>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td style="color:#heading_fcolor#; font-family:#heading_font#">
                                  <b>Item Search</b>
                              </td>
                              <td align="right">
                                <font size=2 color="eeeeee">
                                  <i>(Searches for items by item ID code)</i>
                                </font>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Item ID(s):</b></td>
                        <td>
                          <input type="text" name="search_text" size=45 maxlength=80<cfif #search_type# is "item_search"> value="#search_text#"</cfif>>
                        </td>
                        <td width=95>
                          <input type="submit" id="submit" value="Search" width=75>
                        </td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Order by:</b></td>
                        <td colspan=2>
                          <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td>
                                <select name="order_by">
                                  <option value="title"<cfif #order_by# is "title"> selected</cfif>>Item title</option>
                                  <option value="date_start"<cfif #order_by# is "date_start"> selected</cfif>>Starting date</option>
                                  <option value="date_end"<cfif #order_by# is "date_end"> selected</cfif>>Ending date</option>
                                </select>
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="ASC"<cfif #sort_order# is "ASC"> checked</cfif>>Ascending (A-Z)
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="DESC"<cfif #sort_order# is "DESC"> checked</cfif>>Descending (Z-A)
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td colspan=3>
                          <i>Enter a single item ID code or multiple ID codes (separated by commas) you want to search for.</i><br>
                          <br>
                          Click <a href="#VAROOT#/help/searching.cfm##itemsearch">here</a> for more search tips.
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </form>
              </tr>
            </table>
          </td>
        </tr>
        </font>
        
        <!--- Search-by-seller --->
        <tr>
          <td>
            <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0>
              <tr>
                <td>
                  <form name="search" action="search_results.cfm" method="get">
                    <input type="hidden" name="search_type" value="seller_search">
                    <input type="hidden" name="search_name" value="Search by Seller">
                    <table border=0 cellspacing=0 cellpadding=4 width=800>
                      <tr bgcolor="#heading_color#">
                        <td colspan=4>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td style="color:#heading_fcolor#; font-family:#heading_font#">
                                  <b>Search by Seller</b>
                              </td>
                              <td align="right">
                                <font size=2 color="eeeeee">
                                  <i>(Searches for items by seller's nickname or ID code)</i>
                                </font>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Seller:</b></td>
                        <td>
                          <input type="text" name="search_text" size=45 maxlength=80<cfif #search_type# is "seller_search"> value="#search_text#"</cfif>>
                        </td>
                        <td width=95>
                          <input type="submit" id="submit" value="Search" width=75>
                        </td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Order by:</b></td>
                        <td colspan=2>
                          <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td>
                                <select name="order_by">
                                  <option value="title"<cfif #order_by# is "title"> selected</cfif>>Item title</option>
                                  <option value="date_start"<cfif #order_by# is "date_start"> selected</cfif>>Starting date</option>
                                  <option value="date_end"<cfif #order_by# is "date_end"> selected</cfif>>Ending date</option>
                                </select>
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="ASC"<cfif #sort_order# is "ASC"> checked</cfif>>Ascending (A-Z)
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="DESC"<cfif #sort_order# is "DESC"> checked</cfif>>Descending (Z-A)
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td colspan=3>
                          <i>Enter the seller's nickname or user ID code whose items you want to search for.</i><br>
                          <br>
                          Click <a href="#VAROOT#/help/searching.cfm##sellersearch">here</a> for more search tips.
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </font>
	




        <!--- Search-by-Bidder --->
        <tr>
          <td>
            <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0>
              <tr>
                <td>
                  <form name="search" action="search_results.cfm" method="get">
                    <input type="hidden" name="search_type" value="bidder_search">
                    <input type="hidden" name="search_name" value="Search by Bidder">
                    <table border=0 cellspacing=0 cellpadding=4 width=800>
                      <tr bgcolor="#heading_color#">
                        <td colspan=4>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td style="color:#heading_fcolor#; font-family:#heading_font#">
                                  <b>Search by Bidder</b>
                              </td>
                              <td align="right">
                                <font size=2 color="eeeeee">
                                  <i>(Searches for items by bidder's nickname or ID code)</i>
                                </font>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Bidder:</b></td>
                        <td>
                          <input type="text" name="search_text" size=45 maxlength=80<cfif #search_type# is "seller_search"> value="#search_text#"</cfif>>
                        </td>
                        <td width=95>
                          <input type="submit" id="submit" value="Search" width=75>
                        </td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Order by:</b></td>
                        <td colspan=2>
                          <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td>
                                <select name="order_by">
                                  <option value="title"<cfif #order_by# is "title"> selected</cfif>>Item title</option>
                                  <option value="date_start"<cfif #order_by# is "date_start"> selected</cfif>>Starting date</option>
                                  <option value="date_end"<cfif #order_by# is "date_end"> selected</cfif>>Ending date</option>
                                </select>
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="ASC"<cfif #sort_order# is "ASC"> checked</cfif>>Ascending (A-Z)
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="DESC"<cfif #sort_order# is "DESC"> checked</cfif>>Descending (Z-A)
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>         <hr size=1 color=#heading_color# width=100%></td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td colspan=3>
                          <i>Enter the bidder's nickname or user ID code whose items you want to search for.</i><br>
                          <br>
                          Click <a href="#VAROOT#/help/searching.cfm##buyersearch">here</a> for more search tips.
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </font>
	


	<!--- ***************************************** --->
		<!--- Search-by-store --->
 <tr>
          <td>
<!--- Get rid of SEARCH BY STORE table
             <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0>
              <tr>
                <td>
                  <form name="search" action="search_stores.cfm" method="get">
                    <input type="hidden" name="search_type" value="store_search">
                    <input type="hidden" name="search_name" value="Search by Stores"><table border=0 cellspacing=0 cellpadding=4 width=800>
                      <tr bgcolor="#heading_color#">
                        <td colspan=4>
                          <table border=0 cellspacing=0 cellpadding=0 width=100%>
                            <tr>
                              <td style="color:#heading_fcolor#; font-family:#heading_font#">
                                  <b>Search by Stores</b>
                           
                                
                                  <i>(Searches for items by store name)</i>
                               
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Store:</b></td>
                        
                    <td> <input type="text" name="search_text" size=45 maxlength=80<cfif #search_type# is "store_search"> value="#search_text#"</cfif>></td>
                        <td width=95>
                          <input type="submit" id="submit" value="Search" width=75>
                        </td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Order by:</b></td>
                        <td colspan=2>
                          <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td>
                                <select name="order_by">
                                  <option value="title"<cfif #order_by# is "title"> selected</cfif>>Item title</option>
                                  <option value="date_start"<cfif #order_by# is "date_start"> selected</cfif>>Starting date</option>
                                  <option value="date_end"<cfif #order_by# is "date_end"> selected</cfif>>Ending date</option>
                                </select>
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="ASC"<cfif #sort_order# is "ASC"> checked</cfif>>Ascending (A-Z)
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="DESC"<cfif #sort_order# is "DESC"> checked</cfif>>Descending (Z-A)
                              </td>
                            </tr>
                          </table>
--->

                        </td>
                      </tr>
                      <tr>
                        <td colspan=4><img src=#varoot#/images/spacer.gif height=8></td>
                      </tr>
                      
                     
                    </table>
                  </form>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </font>
		<!--- Search-by-zipcode --->
        <tr>
          <td>
                          <table border=1 bordercolor=000000 cellspacing=0 cellpadding=0>
                <tr>
                  <td>

                  <form name="search" action="search_zipcode.cfm" method="post">
                    <input type="hidden" name="search_type" value="zipcode_search">
                    <input type="hidden" name="search_name" value="Search by zipcode">
                    <table border=0 cellspacing=0 cellpadding=4 width=800>
                                             <tr bgcolor="#heading_color#">

                        <td colspan=4>
                                                     <table border=0 cellspacing=0 cellpadding=0 width=100%>
                              <tr>
                                <td style="color:#heading_fcolor#; font-family:#heading_font#">

                                  <b>Search by Zipcode</b>
</td>
                                                       <td align="right">
                                  <font size=2 color="eeeeee">
                                      
                                  <i>(Searches for items by zipcode)</i>
                               
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4>&nbsp;</td>
                      </tr>
					  <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Your Zipcode:</b></td>
                        <td>
                          <input type="text" name="from_zipcode" size=20 <cfif #search_type# is "zipcode_search"> value="#from_zipcode#"</cfif>>
                        </td>
                        <td width=95>
                          <input type="submit" id="submit" value="Search" width=75>
                        </td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Keyword:</b></td>
                        <td colspan="2">
                          <input type="text" name="search_text" size=45 maxlength=80<cfif #search_type# is "zipcode_search"> value="#search_text#"</cfif>>
                        </td>
                      </tr>
					  <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Select Range:</b></td>
                        <td colspan=2>
                          <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td>
                                <select name="radius">
                                  <option value="5"<cfif #radius# is "5"> selected</cfif>>5</option>
                                  <option value="10"<cfif #radius# is "10"> selected</cfif>>10</option>
                                  <option value="20"<cfif #radius# is "20"> selected</cfif>>20</option>
								  <option value="50"<cfif #radius# is "50"> selected</cfif>>50</option>
                                  <option value="75"<cfif #radius# is "75"> selected</cfif>>75</option>
                                  <option value="100"<cfif #radius# is "100"> selected</cfif>>100</option>
								  <option value="200"<cfif #radius# is "200"> selected</cfif>>200</option>
                                </select>
                              </td>
							  <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="measure_type" value="MI"<cfif #measure_type# is "MI"> checked</cfif>>Miles
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="measure_type" value="KM"<cfif #measure_type# is "KM"> checked</cfif>>Kilometers
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td><b>Order by:</b></td>
                        <td colspan=2>
                          <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td>
                                <select name="order_by">
                                  <option value="title"<cfif #order_by# is "title"> selected</cfif>>Item title</option>
                                  <option value="date_start"<cfif #order_by# is "date_start"> selected</cfif>>Starting date</option>
                                  <option value="date_end"<cfif #order_by# is "date_end"> selected</cfif>>Ending date</option>
                                </select>
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="ASC"<cfif #sort_order# is "ASC"> checked</cfif>>Ascending (A-Z)
                              </td>
                              <td width=15>&nbsp;</td>
                              <td>
                                <input type="radio" name="sort_order" value="DESC"<cfif #sort_order# is "DESC"> checked</cfif>>Descending (Z-A)
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td colspan=4><img src=#varoot#/images/spacer.gif height=8></td>
                      </tr>
                      <tr>
                        <td width=10>&nbsp;</td>
                        <td colspan=3>
                          <i>Enter the keyword and zipcode where you want to search from.</i><br>
                          <br>
                          Click <a href="#VAROOT#/help/searching.cfm##sellersearch">here</a> for more search tips.
                        </td>
                      </tr>
<tr>
                        <td colspan=4>&nbsp;</td>




                      </tr> 
                    </table>
                  </form>
                </td>
              </tr>
            </table>
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
      </table></cfoutput></div>
  </body>
</html>

<cfsetting enablecfoutputonly="no">
