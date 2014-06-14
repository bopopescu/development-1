<cfsetting enablecfoutputonly="Yes">
<cfset current_page="help">

<!--- include globals --->
<cfinclude template="../includes/app_globals.cfm">
  
<!--- define TIMENOW --->
<cfmodule template="../functions/timenow.cfm">

<cfsetting enablecfoutputonly="No">

<html>
  <head>
    <title>eNetSettle FAQs</title>
    
    <link rel=stylesheet href="<cfoutput>#VAROOT#</cfoutput>/includes/stylesheet.css" type="text/css">
  </head>
  
  <!--- Include the body tag --->
  <cfoutput><cfinclude template="../includes/bodytag.html"></cfoutput>
<cfinclude template="../includes/menu_bar.cfm">    
    <div align="center">

   <table border=0 cellspacing=0 cellpadding=2 width=800>
        <tr>
          <td><center><FONT SIZE=2></FONT></center><br><br></td>
        </tr>
        <tr>
          <td><font size=4><b>eNetSettle FAQs</b></font></td>
        </tr>
        <tr>
          <td><hr width=100% size=1 color="<cfoutput>#heading_color#</cfoutput>" noshade></td>
        </tr>
        <tr>
          <td>
            
            <b>What is eNetSettle?</b><br>
            For the supplier and buyer, eNetSettle provides the back-end platform where you and your 
			trading partner can complete your transaction utilizing our value-added service providers.<br>
            <br>
            
            <b>How do I register?</b><br>
            The eNetSettle platform requires buyers and suppliers to enter the following information:<br><br>
			E-mail address<br>
            Password<br>
            First and Last Name<br>
            Your Company name<br><br>

                
               
            <b>What information is required in order to begin a transaction?</b><br>
			After completing the registration process, the transaction source data screen will appear. 
			Please note that only one party (Buyer or Supplier) will be required to complete the transaction 
			source data screen. The eNetSettle system requires the buyer or supplier to enter the following 
			information:<br>
			<ul type="dot">
			<li>Source Application (Exchange Name)
			<li>Transaction ID
			<li>Supplier's e-mail address *
            <li>Buyer's e-mail address *
            <li>P.O. Number if applicable (Optional)
		    <li>Transaction Title
		    <li>Description of the Product
		    <li>Unit Price
		    <li>Unit of Measure; (Box, Case, Unit, Pallet, Truck load, Rail Load, Keg)
	        <li>Quantity
			</ul>
			* The other party will be notified by e-mail and will be provided a temporary password. <br><br>
			
			<b>What are the benefits of using eNetSettle?</b><br>
			After completing the transaction information process, you are now able to select the value-added 
			service(s) you would like to use. The services available on eNetSettle are listed below:<br>
			<ul type="dot">
			<li>Appraisal
			<li>Escrow
			<li>Finance
			<li>Inspection
			<li>Insurance
			<li>Payment
			<li>Shipping
			</ul>
			Once you selected a given service, the system will ask you who will be paying for the service, 
			the buyer or supplier. If the supplier is accepting responsibility for payment of this service, 
			the system will notify and request the buyer to enter information in the appropriate fields. 
			Upon completion by the buyer, this information will be electronically forwarded to the Supplier 
			for approval. <br><br>
			<b>As the supplier, how will I know what value added services the buyer requests?</b><br>
			The eNetSettle system will electronically inform the supplier that a buyer has decided to use one 
			or more of the added value services. Once the supplier completes the required steps, the buyer 
			will be informed by e-mail and will receive a message in eNetSettle. Now that the buyer and 
			supplier have negotiated and finalized the terms for the given service(s), payment terms must be 
			arranged. Payment for the added value service(s) varies based upon the service provider's 
			acceptable methods of payment.<br><br>
			<b>My trading exchange isn't a member of eNetSettle. How may I use this service?</b><br>
			The eNetSettle platform was developed for B2B exchanges to enhance their customers' on-line 
			transaction capability. eNetSettle has integrated with experts in the appraisal, escrow, finance, 
			inspection, insurance, electronic payment and shipping industries to create a collaborative 
			effort to fulfill your transaction seamlessly. 


            <br>
            <br>
            For more information about eNetSettle <a href="http://www.enetsettle.com">click here</a>.
            
          </td>
        </tr>
       </table><cfoutput>
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



