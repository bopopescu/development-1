<!---
  listinglinks.cfm
  
  displays links to different listing types...
  Current + New Today + Ending Today + Completed + Going Soon + Studio
  
  <cfmodule template="listinglinks.cfm"
    listingtype=""
    category=""
    VAROOT="[global var VAROOT]">
    
    listingtype = current,new,ending,completed,going,studio
    category = category id number, used in links

--->
<cfsetting enablecfoutputonly="Yes">

<!--- def vals --->
<cfparam name="Attributes.VAROOT" default="">

<!--- required params --->
<cfloop index="l" list="listingtype,category">
  <cfif not IsDefined("Attributes." & l)>
    <cfoutput>
      <b>ERROR:</b> #Evaluate("Attributes." & l)# attribute of "listinglinks" not defined.<br><br>
      <cfabort>
    </cfoutput>
  </cfif>
</cfloop>

<!--- output current --->
<cfif Attributes.listingtype IS "current">
  <cfset head = "<b>">
  <cfset tail = "</b>">
<cfelse>
  <cfset head = '<a href="#Attributes.VAROOT#/listings/categories/index7.cfm?category=#Attributes.category#">'>
  <cfset tail = '</a>'>
</cfif>

<cfoutput>[#head#Current#tail#] </cfoutput>

<!--- output new --->
<cfif Attributes.listingtype IS "new">
  <cfset head = "<b>">
  <cfset tail = "</b>">
<cfelse>
  <cfset head = '<a href="#Attributes.VAROOT#/listings/categories/index7.cfm?category=#Attributes.category#&listing=new">'>
  <cfset tail = '</a>'>
</cfif>

<cfoutput>[#head#New&nbsp;Today#tail#] </cfoutput>

<!--- output ending --->
<cfif Attributes.listingtype IS "ending">
  <cfset head = "<b>">
  <cfset tail = "</b>">
<cfelse>
  <cfset head = '<a href="#Attributes.VAROOT#/listings/categories/index7.cfm?category=#Attributes.category#&listing=ending">'>
  <cfset tail = '</a>'>
</cfif>

<cfoutput>[#head#Ending&nbsp;Today#tail#] </cfoutput>

<!--- output completed --->
<cfif Attributes.listingtype IS "completed">
  <cfset head = "<b>">
  <cfset tail = "</b>">
<cfelse>
  <cfset head = '<a href="#Attributes.VAROOT#/listings/categories/index7.cfm?category=#Attributes.category#&listing=completed">'>
  <cfset tail = '</a>'>
</cfif>

<cfoutput>[#head#Completed#tail#] </cfoutput>

<!--- output going --->
<cfif Attributes.listingtype IS "going">
  <cfset head = "<b>">
  <cfset tail = "</b>">
<cfelse>
  <cfset head = '<a href="#Attributes.VAROOT#/listings/categories/index7.cfm?category=#Attributes.category#&listing=going">'>
  <cfset tail = '</a>'>
</cfif>

<cfoutput>[#head#Going&nbsp;Soon#tail#]<!---  +  ---></cfoutput>

<!--- 
<!--- output studio --->
<cfif Attributes.listingtype IS "studio">
  <cfset head = "<b>">
  <cfset tail = "</b>">
<cfelse>
  <!--- <cfset head = '<a href="#Attributes.VAROOT#/studio/' & Attributes.category & '/index.html">'> --->
  <cfset head = '<a href="#Attributes.VAROOT#/studio/index.html">'>
  <cfset tail = '</a>'>
</cfif>

<cfoutput>#head#Studio#tail#</cfoutput>
 --->

<cfsetting enablecfoutputonly="No">