<!---
countauctions.cfm

counts number of auctions in a category based on criteria

<cfmodule template="countauctions.cfm"
  category="[category number]"
  listings="[current|new|ending|completed|going|featured]"
  datasource="[dsn]"
  timenow="[TIMENOW]"
  return="[return variable name]">
  
--->
<cfsetting enablecfoutputonly="NO">

<cfif isdefined("db_password") is not true>
	<cfinclude template="../includes/app_globals.cfm">
</cfif>

<!--- chk attributes exist --->
<cfloop index="l" list="category,listings,datasource,timenow,return">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</b> #l# attribute of countauctions.cfm not defined.<br>
      <br>
    </cfoutput>
    <cfabort>
  </cfif>
</cfloop>

<!--- setup the type of listing to be generated --->
<cfswitch expression="#Attributes.listings#">
  <cfcase value="current">
      
      <!--- count number of auctions in this category --->
      <cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#Attributes.DATASOURCE#">
          SELECT COUNT(status) AS total
            FROM items
            
           WHERE category1 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_end > #Attributes.timenow#
             
              OR category2 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_end > #Attributes.timenow#
      </cfquery>
  </cfcase>
  
  <cfcase value="new">
      
      <!--- count number of auctions in this category --->
      <cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#Attributes.DATASOURCE#">
          SELECT COUNT(status) AS total
            FROM items
            
           WHERE category1 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_start >= #DateAdd("d", -1, Attributes.timenow)#
             AND date_end > #Attributes.timenow#
             
              OR category2 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_start >= #DateAdd("d", -1, Attributes.timenow)#
             AND date_end > #Attributes.timenow#
      </cfquery>
  </cfcase>
  
  <cfcase value="ending">
      
      <!--- count number of auctions in this category --->
      <cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#Attributes.DATASOURCE#">
          SELECT COUNT(status) AS total
            FROM items
            
           WHERE category1 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_end > #Attributes.timenow#
             AND date_end <= #DateAdd("d", 1, Attributes.timenow)#
             
              OR category2 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_end > #Attributes.timenow#
             AND date_end <= #DateAdd("d", 1, Attributes.timenow)#
      </cfquery>
  </cfcase>
  
  <cfcase value="completed">
      
      <!--- count number of auctions in this category --->
      <cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#Attributes.DATASOURCE#">
          SELECT COUNT(status) AS total
            FROM items
            
           WHERE category1 = #Attributes.category#
             AND status = 0
             AND date_end < #Attributes.timenow#
             AND date_end >= #DateAdd("d", -30, Attributes.timenow)#
             
              OR category2 = #Attributes.category#
             AND status = 0
             AND date_end < #Attributes.timenow#
             AND date_end >= #DateAdd("d", -30, Attributes.timenow)#
      </cfquery>
  </cfcase>
  
  <cfcase value="going">
      
      <!--- get number of hours auction considered going --->
      <cfquery username="#db_username#" password="#db_password#" name="HoursGoing" datasource="#Attributes.DATASOURCE#">
          SELECT pair AS hours
            FROM defaults
           WHERE name = 'hrsending'
      </cfquery>
      
      <!--- count number of auctions in this category --->
      <cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#Attributes.DATASOURCE#">
          SELECT COUNT(status) AS total
            FROM items
            
           WHERE category1 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_end > #Attributes.timenow#
             AND date_end <= #DateAdd("h", HoursGoing.hours, Attributes.timenow)#
             
              OR category2 = #Attributes.category#
             AND status = 1
             AND date_start < #Attributes.timenow#
             AND date_end > #Attributes.timenow#
             AND date_end <= #DateAdd("h", HoursGoing.hours, Attributes.timenow)#
      </cfquery>
  </cfcase>
  
  <cfcase value="featured">
    
    <!--- get categories that require login --->
    <cfquery username="#db_username#" password="#db_password#" name="get_Categories" datasource="#Attributes.DATASOURCE#">
        SELECT category
          FROM categories
         WHERE active = 1
           AND require_login = 1
           AND category <> 0
    </cfquery>
    
    <!--- count number of auctions in featured --->
    <cfquery username="#db_username#" password="#db_password#" name="cnt_Auctions" datasource="#Attributes.DATASOURCE#">
        SELECT COUNT(status) AS total
          FROM items
         WHERE featured = 1
           AND status = 1
           AND date_start < #Attributes.timenow#
           AND date_end > #Attributes.timenow#
      <cfloop query="get_Categories">
           AND category1 <> #get_Categories.category#
           AND category2 <> #get_Categories.category#
      </cfloop>
    </cfquery>
  </cfcase>
</cfswitch>

<!--- return value --->
<cfset temp = "Caller.#Trim(Attributes.return)#">
<cfset "#temp#" = cnt_Auctions.total>

<cfsetting enablecfoutputonly="NO">
