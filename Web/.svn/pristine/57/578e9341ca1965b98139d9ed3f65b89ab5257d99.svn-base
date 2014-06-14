
  <!--- get default bid type --->
  <cftry>
  
    <!--- only REGULAR bid type accepted for Dutch or Yankee --->
	<cfif get_ItemInfo.auction_type IS "D" OR get_ItemInfo.auction_type IS "Y">
		<cfthrow>
	</cfif>
	
    <cfquery username="#db_username#" password="#db_password#" name="getDefBidType" datasource="#DATASOURCE#">
        SELECT pair AS def_bidding
          FROM defaults
         WHERE name = 'def_bidding'
    </cfquery>
    
    <cfset defBidType = getDefBidType.def_bidding>
    
    <cfif IsDefined("bidType")>
      <cfif ucase(bidType) IS "REGULAR" OR ucase(bidType) IS "PROXY">
        <cfset defBidType = ucase(bidType)>
		<cfset session.bidtype = defbidtype>
      </cfif>
    </cfif>
	
    <cfcatch>
      <cfset defBidType = "REGULAR">
	  <cfset session.bidtype = "REGULAR">
    </cfcatch>
  </cftry>

