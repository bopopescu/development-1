<cfsetting EnableCFOutputOnly="YES">
<!---

     cf_category_tree.cfm

     Written by Jason Johnson
     Beyond Solutions, Inc.
     February 26, 1999

     A custom tag to represent data in a relational tree format, where it exists
     in the database in a parent-child relationship where nodes each have an
     "item_id", "parent_id", and "child_count" field in them where:

        item_id     - the ID code of the item
        parent_id   - the ID code of the item's parent (or 0 if no parent)
        child_count - the number of children the node has (0 if none) as sub-
                      nodes beneath it.

     If "parent_id" is -1, the node is the top node.  All nodes with "parent_id"
     set to 0 are "top-level" nodes with the top node as their parent.


     Examples:
     (Parameters in [brackets] are optional; if omitted, defaults are used.)

     To print a select box with a given name, size, and selected items:

     <CFMODULE TEMPLATE="cf_category_tree.cfm"
       TYPE="SELECT"
       DATASOURCE="#DATASOURCE#"
       PARENT="0"
      [SELECTNAME="categories"]        (Default is "items")
      [SELECTED="Automotive"]          (Default is none)
      [SHOW_ONLY_LIST="Cars"]          (Default is none)
      [MULTIPLE="NO"]                  (Default is "NO")  
      [SIZE="1"]                       (Default is "1")
      [ACTIVE_ONLY="1"]                (Default is "0")
      [REQUIRE_LOGIN="1"]              (Default is "0")
      [ALLOW_SALES="1">]               (Default is "1")


     To print a list of items as a plain HTML list:
	
     <CFMODULE TEMPLATE="cf_category_tree.cfm"
       TYPE="LIST"
       DATASOURCE="#DATASOURCE#"
       PARENT="0"
      [SELECTED="Automotive"]          (Default is none)
      [SHOW_ONLY_LIST="Cars"]          (Default is none)
      [ACTIVE_ONLY="1"]                (Default is "0")
      [REQUIRE_LOGIN="1"]              (Default is "0")
      [ALLOW_SALES="1">]               (Default is "1")


     To print a list of items as an HTML list of hyperlinks with a given
     page to load and a given URL variable to pass to the link:
	
     <CFMODULE TEMPLATE="cf_category_tree.cfm"
       TYPE="HYPERLIST"
       DATASOURCE="#DATASOURCE#"
       PARENT="0"
       TARGET="process_form.cfm"
      [VARIABLE="item_id"]             (Default is "item")
      [SELECTED="Automotive"]          (Default is none)
      [SHOW_ONLY_LIST="Cars"]          (Default is none)
      [ACTIVE_ONLY="1"]                (Default is "0")
      [REQUIRE_LOGIN="1"]              (Default is "0")
      [ALLOW_SALES="1">]               (Default is "1")


     To print a list of items as an HTML list of hyperlinks with a given
     page to load and a given URL variable to pass to the link, and with
     a specified start/end marker applied to the selected item(s):     
	
     <CFMODULE TEMPLATE="cf_category_tree.cfm"
       TYPE="HYPERLIST"
       DATASOURCE="#DATASOURCE#"
       PARENT="0"
       TARGET="process_form.cfm"
      [HYPER_SELECTED_ONLY="NO"]       (Default is "NO")
      [VARIABLE="item_id"]             (Default is "item")
      [SELECTED="Automobiles,BMW"]     (Default is none)
      [START_TAG="<font color='red'"]  (Default is "<b>")
      [END_TAG="</font>"]              (Default is "</b>")
      [SHOW_ONLY_LIST="Cars"]          (Default is none)
      [ACTIVE_ONLY="1"]                (Default is "0")
      [REQUIRE_LOGIN="1"]              (Default is "0")
      [ALLOW_SALES="1">]               (Default is "1")


     To simply retrieve a list of items in the 'RESULT' variable:
	
     <CFMODULE TEMPLATE="cf_category_tree.cfm"
       TYPE="RETRIEVE"
       DATASOURCE="#DATASOURCE#"
       PARENT="0"
      [SELECTED="Automotive"]          (Default is none)
      [SHOW_ONLY_LIST="Cars"]          (Default is none)
      [ACTIVE_ONLY="1"]                (Default is "0")
      [REQUIRE_LOGIN="1"]              (Default is "0")
      [ALLOW_SALES="1">]               (Default is "1")

--->

<!--- Verify correct parameters --->
<CFLOOP INDEX="l" LIST="DATASOURCE,PARENT,TYPE">
 <CFIF not IsDefined("Attributes." & l)>
   Attribute not specified for cf_category_tree... Aborting...<BR>
  <CFABORT>
 </CFIF>
</CFLOOP>

<!--- Set delimiter variables --->
<cfset #int_delim# = "÷">
<cfset #ext_delim# = "²">

<!--- Check for missing parameters & set defaults --->
<cfif #isDefined ("Attributes.level")# is "0">
 <cfset #level# = "0">
<cfelse>
 <cfset #level# = "#Attributes.level#">
</cfif>
<cfif #isDefined ("Attributes.type")# is "0">
 <cfset #type# = "0">
<cfelse>
 <cfset #type# = "#Attributes.type#">
</cfif>
<cfif #isDefined ("Attributes.multiple")# is "0">
 <cfset #multiple# = "0">
<cfelse>
 <cfset #multiple# = "#Attributes.multiple#">
</cfif>
<cfif #isDefined ("Attributes.selected")# is "0">
 <cfset #selected# = "">
<cfelse>
 <cfset #selected# = "#Attributes.selected#">
</cfif>
<cfif #isDefined ("Attributes.show_only_list")# is "0">
 <cfset #show_only_list# = "">
<cfelse>
 <cfset #show_only_list# = "#Attributes.show_only_list#">
</cfif>
<cfif #isDefined ("Attributes.hyper_selected_only")# is "0">
 <cfset #hyper_selected_only# = "">
<cfelse>
 <cfset #hyper_selected_only# = "#Attributes.hyper_selected_only#">
</cfif>
<cfif #isDefined ("Attributes.selectname")# is "0">
 <cfset #selectname# = "list">
<cfelse>
 <cfset #selectname# = "#Attributes.selectname#">
</cfif>
<cfif #isDefined ("Attributes.size")# is "0">
 <cfset #size# = "1">
<cfelse>
 <cfset #size# = "#Attributes.size#">
</cfif>
<cfif #isDefined ("Attributes.link")# is "0">
 <cfset #link# = "">
<cfelse>
 <cfset #link# = "#Attributes.link#">
</cfif>
<cfif #isDefined ("Attributes.variable")# is "0">
 <cfset #variable# = "item">
<cfelse>
 <cfset #variable# = "#Attributes.variable#">
</cfif>
<cfif #isDefined ("Attributes.result")# is "0">
 <cfset #result# = "">
<cfelse>
 <cfset #result# = "#Attributes.result#">
</cfif>
<cfif #isDefined ("Attributes.start_tag")# is "0">
 <cfset #start_tag# = "<b>">
<cfelse>
 <cfset #start_tag# = "#Attributes.start_tag#">
</cfif>
<cfif #isDefined ("Attributes.end_tag")# is "0">
 <cfset #end_tag# = "</b>">
<cfelse>
 <cfset #end_tag# = "#Attributes.end_tag#">
</cfif>
<cfif #isDefined ("Attributes.show_none")# is "0">
 <cfset #show_none# = "0">
<cfelse>
 <cfif #Attributes.show_none# is "1">
  <cfset #show_none# = "< None >">
 <cfelse>
  <cfset #show_none# = "#Attributes.show_none#">
 </cfif>
</cfif>
<cfif #isDefined ("Attributes.active_only")# is "0">
 <cfset #active_only# = "0">
<cfelse>
 <cfset #active_only# = "#Attributes.active_only#">
</cfif>
<cfif #isDefined ("Attributes.require_login")# is "0">
 <cfset #require_login# = "2">
<cfelse>
 <cfset #require_login# = "#Attributes.require_login#">
</cfif>
<cfif #isDefined ("Attributes.allow_sales")# is "0">
 <cfset #allow_sales# = "2">
<cfelse>
 <cfset #allow_sales# = "#Attributes.allow_sales#">
</cfif>

<!--- If it's level 0, find top-level information --->
<cfif #level# is "0">
 <cfquery name="get_top_info" dataSource="#Attributes.DATASOURCE#">
  SELECT child_count
    FROM categories
   WHERE category = 0
   ORDER BY name
 </cfquery>
 <cfset #list# = "0#int_delim#'TOP'#int_delim#0#int_delim##get_top_info.recordCount#">
</cfif>

<!--- Get a list of current-level parents to start off with --->
<cfquery name="get_parents" dataSource="#Attributes.DATASOURCE#">
 SELECT category,
        name,
        parent,
        child_count
   FROM categories
  WHERE parent = #Attributes.parent#
  <cfif #active_only# is "1">
    AND active = 1
  </cfif>
  <cfif #require_login# is "1">
    AND require_login = 1
  <cfelseif #require_login# is "0">
    AND require_login = 0
  </cfif>
  <cfif #allow_sales# is "1">
    AND allow_sales = 1
  <cfelseif #allow_sales# is "0">
    AND allow_sales = 0
  </cfif>
  ORDER BY name
</cfquery>

<!--- Clear the list --->
<cfset #master_list# = "">

<!--- Populate the list --->
<cfloop query="get_parents">
 <cfset #master_list# = #listAppend (master_list,
        "#category##int_delim#'#name#'#int_delim##level##int_delim##child_count#", "#ext_delim#")#>
</cfloop>

<!--- Produce different results depending on the TYPE parameter --->
<cfswitch expression=#type#>

 <!--- Generate a SELECT list --->
 <cfcase value="SELECT">
  <cfif #level# is "0">
   <cfoutput><select name="#selectname#"<cfif #multiple# is "YES"> multiple</cfif><cfif #size# GT "1"> size=#size#</cfif>></cfoutput>
   <cfif #show_none# is not "0">
    <cfoutput><option value="-1">#show_none#</option></cfoutput>
   </cfif>
  </cfif>
  <cfloop index="the_item" list="#master_list#" delimiters="#ext_delim#">
   <cfset #str_item# = #listGetAt (the_item, 2, "#int_delim#")#>
   <cfset #str_item# = #mid (str_item, 2, len (str_item) - 2)#>
   <cfset #str_id# = #listGetAt (the_item, 1, "#int_delim#")#>
   <cfset #str_children# = #listGetAt (the_item, 4, "#int_delim#")#>
   <cfif #show_only_list# is "">
    <cfoutput><option value="#str_id#"<cfif (#listContains (selected, str_id)# GT 0) or (#listContains (selected, str_item)# GT 0)> selected</cfif>>#repeatString("&nbsp;&nbsp;&nbsp;", level)##str_item#<cfif #str_children# GT 0>+</cfif></option></cfoutput>
   <cfelse>
    <cfif (#listContains (show_only_list, str_id)# GT 0) or (#listContains (show_only_list, str_item)# GT 0)>
     <cfoutput><option value="#str_id#"<cfif (#listContains (selected, str_id)# GT 0) or (#listContains (selected, str_item)# GT 0)> selected</cfif>>#repeatString("&nbsp;&nbsp;&nbsp;", level)##str_item#<cfif #str_children# GT 0>+</cfif></option></cfoutput>
    </cfif>
   </cfif>

   <!--- Call the custom tree module for this child (recursively) --->
   <cfif #listGetAt (the_item, 4, "#int_delim#")# GT 0>
    <cfset #the_parent# = #listGetAt (the_item, 1, "#int_delim#")#>
    <cfmodule template="cf_category_tree.cfm"
              datasource="#Attributes.DATASOURCE#"
              list="#master_list#"
              level=#evaluate (level + 1)#
              parent=#the_parent#
              type="#type#"
              result="#result#"
              size="#size#"
              multiple="#multiple#"
              selectname="#selectname#"
              selected="#selected#"
              show_only_list="#show_only_list#"
              link="#link#"
              variable="#variable#"
              start_tag="#start_tag#"
              end_tag="#end_tag#"
              show_none="#show_none#"
              active_only="#active_only#"
              require_login="#require_login#"
              allow_sales="#allow_sales#">
   </cfif>
  </cfloop>
 </cfcase>

 <!--- Generate an HTML or HYPER list --->
 <cfcase value="LIST,HYPERLIST">
  <cfloop index="the_item" list="#master_list#" delimiters="#ext_delim#">
   <cfset #str_item# = #listGetAt (the_item, 2, "#int_delim#")#>
   <cfset #str_item# = #mid (str_item, 2, len (str_item) - 2)#>
   <cfset #str_id# = #listGetAt (the_item, 1, "#int_delim#")#>
   <cfset #str_children# = #listGetAt (the_item, 4, "#int_delim#")#>
   <cfif #type# is "LIST">
    <cfif #show_only_list# is "">
     <cfif (#listContains (selected, str_id)# GT 0) or (#listContains (selected, str_item)# GT 0)>
      <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)##start_tag##str_item##end_tag#<cfif #str_children# GT 0>+</cfif><br></cfoutput>
     <cfelse>
      <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)##str_item#<cfif #str_children# GT 0>+</cfif><br></cfoutput>
     </cfif>
    <cfelse>
     <cfif (#listContains (show_only_list, str_id)# GT 0) or (#listContains (show_only_list, str_item)# GT 0)>
      <cfif (#listContains (selected, str_id)# GT 0) or (#listContains (selected, str_item)# GT 0)>
       <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)##start_tag##str_item##end_tag#<cfif #str_children# GT 0>+</cfif><br></cfoutput>
      <cfelse>
       <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)##str_item#<cfif #str_children# GT 0>+</cfif><br></cfoutput>
      </cfif>
     </cfif>
    </cfif>
   <cfelse>
    <cfif #show_only_list# is "">
     <cfif (#listContains (selected, str_id)# GT 0) or (#listContains (selected, str_item)# GT 0)>
      <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)#<a href="#link#?#variable#=#URLEncodedFormat(str_id)#">#start_tag##str_item##end_tag#</a><cfif #str_children# GT 0>+</cfif><br></cfoutput>
     <cfelse>
      <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)#<a href="#link#?#variable#=#URLEncodedFormat(str_id)#">#str_item#</a><cfif #str_children# GT 0>+</cfif><br></cfoutput>
     </cfif>
    <cfelse>
     <cfif (#listContains (show_only_list, str_id)# GT 0) or (#listContains (show_only_list, str_item)# GT 0)>
      <cfif (#listContains (selected, str_id)# GT 0) or (#listContains (selected, str_item)# GT 0)>
       <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)#<a href="#link#?#variable#=#URLEncodedFormat(str_id)#">#start_tag##str_item##end_tag#</a><cfif #str_children# GT 0>+</cfif><br></cfoutput>
      <cfelse>
       <cfoutput>#repeatString("&nbsp;&nbsp;&nbsp;", level)#<a href="#link#?#variable#=#URLEncodedFormat(str_id)#">#str_item#</a><cfif #str_children# GT 0>+</cfif><br></cfoutput>
      </cfif>
     </cfif>
    </cfif>
   </cfif>

   <!--- Call the custom tree module for this child (recursively) --->
   <cfif #listGetAt (the_item, 4, "#int_delim#")# GT 0>
    <cfset #the_parent# = #listGetAt (the_item, 1, "#int_delim#")#>
    <cfmodule template="cf_category_tree.cfm"
              datasource="#Attributes.DATASOURCE#"
              list="#master_list#"
              level=#evaluate (level + 1)#
              parent=#the_parent#
              type="#type#"
              result="#result#"
              size="#size#"
              multiple="#multiple#"
              selectname="#selectname#"
              selected="#selected#"
              show_only_list="#show_only_list#"
              link="#link#"
              variable="#variable#"
              start_tag="#start_tag#"
              end_tag="#end_tag#"
              show_none="#show_none#"
              active_only="#active_only#"
              require_login="#require_login#"
              allow_sales="#allow_sales#">
   </cfif>
  </cfloop>
 </cfcase>

 <!--- Return a ColdFusion variable --->
 <cfcase value="RETRIEVE">
  <cfloop index="the_item" list="#master_list#" delimiters="#ext_delim#">
   <cfset #str_item# = #listGetAt (the_item, 2, "#int_delim#")#>
   <cfset #str_item# = #mid (str_item, 2, len (str_item) - 2)#>
   <cfset #str_id# = #listGetAt (the_item, 1, "#int_delim#")#>
   <cfset #str_children# = #listGetAt (the_item, 4, "#int_delim#")#>
   <cfif #show_only_list# is "">
    <cfset #result# = #listAppend (result, the_item, "#ext_delim#")#>
   <cfelse>
    <cfif (#listContains (show_only_list, str_id)# GT 0) or (#listContains (show_only_list, str_item)# GT 0)>
     <cfset #result# = #listAppend (result, the_item, "#ext_delim#")#>
    </cfif>
   </cfif>

   <!--- Call the custom tree module for this child (recursively) --->
   <cfif #listGetAt (the_item, 4, "#int_delim#")# GT 0>
    <cfset #the_parent# = #listGetAt (the_item, 1, "#int_delim#")#>
    <cfmodule template="cf_category_tree.cfm"
              datasource="#Attributes.DATASOURCE#"
              list="#master_list#"
              level=#evaluate (level + 1)#
              parent=#the_parent#
              type="#type#"
              result="#result#"
              size="#size#"
              multiple="#multiple#"
              selectname="#selectname#"
              selected="#selected#"
              show_only_list="#show_only_list#"
              link="#link#"
              variable="#variable#"
              start_tag="#start_tag#"
              end_tag="#end_tag#"
              show_none="#show_none#"
              active_only="#active_only#"
              require_login="#require_login#"
              allow_sales="#allow_sales#">
   </cfif>
  </cfloop>
 </cfcase>

 <!--- The default case --->
 <cfdefaultcase>
 </cfdefaultcase>
</cfswitch>

<!--- Output any ending tags if necessary --->
<cfif #type# is "select" and isDefined ("list")>
 <cfoutput></select></cfoutput>
</cfif>

<!--- Return result variable if necessary --->
<cfif #type# is "retrieve">
 <cfset #Caller.result# = #result#>
</cfif>
<cfsetting EnableCFOutputOnly="NO">