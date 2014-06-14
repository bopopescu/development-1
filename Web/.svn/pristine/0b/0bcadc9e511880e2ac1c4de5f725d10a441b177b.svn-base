<!--
  bill_seller.cfm
  
  module for billing seller..
  uses def_bill.cfm
  
  changes:
    rs  - add docnum to payments and invoice inserts. Populate with billing_reference.
        - add logic to reduce 'credit' & update balance in users table when applied. 
        - fix credit error by removing NumberFormat from credit when calculating Invoice total
		- Log credit payment record when credit applied
		- populate invoice 'paid' with credit applied + credit card payments
	   
  <!---

  <cfmodule template="bill_seller.cfm"
    itemnum="[item number]"
    datasource="[system dsn]"
    timenow="[timenow]"
    fromEmail="#SERVICE_EMAIL##DOMAIN#">

  --->

-->
<cfinclude template = "../../includes/app_globals.cfm">

<!--- Include EPOCH module  --->
 <CFMODULE TEMPLATE="../../functions/epoch.cfm">
 
 <cfset payment_made = 0>

<!-- see if invoice for itemnum already exists -->
<cfquery username="#db_username#" password="#db_password#" name="getExists" datasource="#Attributes.datasource#">
    SELECT COUNT(itemnum) AS found
      FROM invoices
     WHERE itemnum = #Attributes.itemnum#
</cfquery>

<cfif not getExists.found>
  <!-- item was found...  -->
  
  <!-- get info -->
  <cfquery username="#db_username#" password="#db_password#" name="getInfo" datasource="#Attributes.datasource#">
      SELECT I.itemnum, I.title, U.user_id, U.email, U.balance, U.credit, U.nickname, U.membership, U.membership_exp
        FROM items I, users U
       WHERE I.itemnum = #Attributes.itemnum#
         AND I.user_id = U.user_id
  </cfquery>
	<cfif getInfo.membership neq "" and getInfo.membership_exp gt Attributes.timenow>
		<cfset membership_pct = listgetat(getInfo.membership,2,"_")>
		<cfset membership_pct = membership_pct / 100>
		<cfset membership_rate = membership_pct * 100>
	<cfelse>
		<cfset membership_pct = 0>
	</cfif>
	
  <!-- get currency type -->
  <cfquery username="#db_username#" password="#db_password#" name="getCurrency" datasource="#Attributes.datasource#">
      SELECT pair AS type
        FROM defaults
       WHERE name = 'site_currency'
  </cfquery>

  <!-- get billing period -->
  <cfquery username="#db_username#" password="#db_password#" name="getPeriod" datasource="#Attributes.datasource#">
      SELECT pair AS days
        FROM defaults
       WHERE name = 'billing_period'
  </cfquery>

  <!-- find if FREE trial is enabled. -->
  <cfquery username="#db_username#" password="#db_password#" name="findFreeTrial" datasource="#Attributes.datasource#">
      SELECT pair AS true_false
        FROM defaults
       WHERE name = 'free_trial'
  </cfquery>

  <cfif findFreeTrial.true_false eq 1>
	<!-- get FREE Trial period (in days) -->
	<cfquery username="#db_username#" password="#db_password#" name="getFreeTrial" datasource="#Attributes.datasource#">
	    SELECT pair AS days
	      FROM defaults
	     WHERE name = 'free_trial_days'
	</cfquery>
  </cfif>

  <!-- define values -->
  <cfset itemnum = Attributes.itemnum>
  <cfset user_id = getInfo.user_id>
  <cfset status = 0>
  <cfset dateCreated = Attributes.timenow>
  <cfset dateDue = DateAdd("d", getPeriod.days, Attributes.timenow)>
  <cfset reference = " ">
  
  <!-- def bill -->
  <cfmodule template="def_bill.cfm"
    itemnum="#Attributes.itemnum#"
    datasource="#Attributes.datasource#">

  <!-- calc invoice sub total -->
  <cfset invSubTotal = 0>
  <cfloop index="i" from="1" to="#ArrayLen(bill)#">
    <cfset invSubTotal = REReplace(invSubTotal, "[^0-9.]", "", "ALL") + REReplace(bill[i][2], "[^0-9.]", "", "ALL")>
  </cfloop>
  <cfif membership_pct eq 0>
  <cfset invSubTotal = invSubTotal>
  <cfelse>
  <cfset invSubTotal = invSubTotal - (invSubTotal * #membership_pct#)>
  </cfif>
  
<!---   <cfset invSubTotal = numberformat(invSubTotal,numbermask)> --->

  <!-- set default values -->
  <cfset creditpaid = 0.00>
  <cfset total_paidamt = 0.00>
  <cfset fees_total = 0.00>
  <cfset listing = 0.00>
  <cfset fee = 0.00>
  <cfset bold = 0.00>
  <cfset featured = 0.00>
  <cfset featured_cat = 0.00>
  <cfset banner = 0.00>
 
  <cfset studio = 0.00>
  <cfset featured_studio = 0.00>
  <cfset picture1 = 0.00>
  <cfset picture2 = 0.00>
  <cfset picture3 = 0.00>
  <cfset picture4 = 0.00>
  <cfset fee_inspector = 0.00>

  <cfset second_cat = 0.00>
  <cfset reserve_bid = 0.00>
  <cfset late_charge = 0.00>
  <cfset paid = 0.00>
  <cfset newtotal_invoice = 0.00>
  
  
  <!-- set charges -->
  <cfloop index="i" from="1" to="#ArrayLen(bill)#">
    <cfif bill[i][3] IS "listing">         <cfset listing = bill[i][2]>         </cfif>
    <cfif bill[i][3] IS "fee">             <cfset fee = bill[i][2]>             </cfif>
    <cfif bill[i][3] IS "bold">            <cfset bold = bill[i][2]>            </cfif>
    <cfif bill[i][3] IS "featured">        <cfset featured = bill[i][2]>        </cfif>
    <cfif bill[i][3] IS "featured_cat">    <cfset featured_cat = bill[i][2]>    </cfif>
    <cfif bill[i][3] IS "banner">          <cfset banner = bill[i][2]>          </cfif>
 
    <cfif bill[i][3] IS "fee_inspector">   <cfset fee_inspector = bill[i][2]>   </cfif>
    <cfif bill[i][3] IS "studio">          <cfset studio = bill[i][2]>          </cfif>
    <cfif bill[i][3] IS "featured_studio"> <cfset featured_studio = bill[i][2]> </cfif>
	<cfif bill[i][3] IS "picture1">        <cfset picture1 = bill[i][2]>        </cfif>
	<cfif bill[i][3] IS "picture2">        <cfset picture2 = bill[i][2]>        </cfif>
	<cfif bill[i][3] IS "picture3">        <cfset picture3 = bill[i][2]>        </cfif>
	<cfif bill[i][3] IS "picture4">        <cfset picture4 = bill[i][2]>        </cfif>

    <cfif bill[i][3] IS "second_cat">      <cfset second_cat = bill[i][2]>      </cfif>
	<cfif bill[i][3] IS "reserve_bid">     <cfset reserve_bid = bill[i][2]>     </cfif>
  </cfloop>
  
  <!---1.convert numbers to 2 digits after dec. pt- 9999.99       
       
   --->
	   
 <cfset listing = numberformat(listing,'#numbermask#')>
 
 
 <cfset fee = numberformat(fee,'#numbermask#')>
 	 
 
 <cfset bold = numberformat(bold,'#numbermask#')>
  

 <cfset featured = numberformat(featured,'#numbermask#')>
 
 
 <cfset featured_cat = numberformat(featured_cat,'#numbermask#')>
 

 <cfset banner = numberformat(banner,'#numbermask#')>
 
 
 <cfset fee_inspector = numberformat(fee_inspector,'#numbermask#')>

 
 <cfset studio = numberformat(studio,'#numbermask#')>
 
 
 <cfset featured_studio = numberformat(featured_studio,'#numbermask#')>
 
 
 <cfset picture1 = numberformat(picture1,'#numbermask#')>
 <cfset picture2 = numberformat(picture2,'#numbermask#')>
 <cfset picture3 = numberformat(picture3,'#numbermask#')>
 <cfset picture4 = numberformat(picture4,'#numbermask#')>
 

 <cfset second_cat = numberformat(second_cat,'#numbermask#')>
 
 
 <cfset reserve_bid = numberformat(reserve_bid,'#numbermask#')>
 
 
  <!-- define free trial period  -->
  <cfif findFreeTrial.true_false eq 1>
    
    <cfset seconds_free = (getFreeTrial.days * 86400)>
    
    <cfif (EPOCH - user_id) lt seconds_free>
      
      <!-- user gets free auction -->
      <cfset listing = 0.00>
      <cfset fee = 0.00>
      <cfset bold = 0.00>
      <cfset featured = 0.00>
      <cfset featured_cat = 0.00>
      <cfset banner = 0.00>
      <cfset second_cat = 0.00>

      <cfset fee_inspector = 0.00>
      <cfset studio = 0.00>
      <cfset featured_studio = 0.00>
	  <cfset picture1 = 0.00>
	  <cfset picture2 = 0.00>
	  <cfset picture3 = 0.00>
	  <cfset picture4 = 0.00>
	  <cfset reserve_bid = 0.00>

      <cfset invSubTotal = 0.00>
      <cfset invoice_total = 0.00>
	  <cfset fees_total = 0.00>
	  <cfset creditpaid = 0.00>
      <cfset total_paidamt = 0.00>
      
    <cfelse>
      <cfset invoice_total = listing + fee + bold + featured + featured_cat + banner + fee_inspector + studio + featured_studio + picture1 + picture2 + picture3 + picture4 + second_cat + reserve_bid>
      <cfset fees_total = listing + fee + bold + featured + featured_cat + banner + fee_inspector + studio + featured_studio + picture1 + picture2 + picture3 + picture4 + second_cat + reserve_bid>
	  <cfif membership_pct eq 0>
	  <cfset invoice_total = invoice_total - #numberformat(getInfo.credit,'#numbermask#')#>
	  <cfelse>
	  <cfset invoice_total = (invoice_total - (invoice_total * membership_pct)) - #numberformat(getInfo.credit,'#numbermask#')#>
	  <cfset fees_total = fees_total - (fees_total * membership_pct)>
	  </cfif>
	</cfif>
    
  <cfelse>
    <cfset invoice_total = listing + fee + bold + featured + featured_cat + banner + fee_inspector + studio + featured_studio + picture1 + picture2 + picture3 + picture4 + second_cat + reserve_bid>
	<cfset fees_total = listing + fee + bold + featured + featured_cat + banner + fee_inspector + studio + featured_studio + picture1 + picture2 + picture3 + picture4 + second_cat + reserve_bid>
	<cfif membership_pct eq 0>
	<cfset invoice_total = invoice_total - #numberformat(getInfo.credit,'#numbermask#')#>
	<cfelse>
	<cfset invoice_total = (invoice_total - (invoice_total * membership_pct)) - #numberformat(getInfo.credit,'#numbermask#')#>
	<cfset fees_total = fees_total - (fees_total * membership_pct)>
	</cfif>
  </cfif>
 
 
  
  <!-- if invoice_total LT 0, then set it to 0 -->
  <cfif invoice_total LT 0>
    <!-- invoice_total was set to 0 -->
    <cfset invoice_total = 0.00>
  <cfelseif invoice_total GT 0>

	<cfif isdefined("authorize_net_aim") and authorize_net_aim eq "yes">
		<!-- RUN AUTOMATED MODULES (AUTHORIZE.NET), UPDATE PAID VALUE,STATUS -->
		
		<cfmodule template="auth_net_automated_billing.cfm"
    	user_id="#getInfo.user_id#"
		itemnum="#itemnum#"
		title="#getInfo.title#"
		invoice_total="#invoice_total#">
		
	<cfelse>
	<!-- RUN AUTOMATED MODULES (CYBERCASH, ETC.), UPDATE PAID VALUE,STATUS -->
	<cfmodule template="automated_billing.cfm"
    		itemnum="#itemnum#"
		invoice_total="#invoice_total#">
	</cfif>

	<!-- check to see if billing was ok. -->
	<cfif billing_status NEQ "ok">
		<!-- automated billing was not ok... email someone... -->
		<cfparam name="CYBERCASH_ERROR_EMAIL" default="joe@beyondsolutions.com">
		<cfmail to="#CYBERCASH_ERROR_EMAIL#" 
			from="automated_billing@#domain#" 
			subject="Error: executing automated billing for ###itemnum#.">
		There was an error while processing the automated billing module (automated_billing.cfm) for item number: ###itemnum#.

		Billing Status: '#billing_status#'.
		The error reported was: '#billing_reference#'.

		...
		</cfmail>

		  
	<cfelse>
		<!--	automated billing was ok... 
			pass variables to be entered into database... -->

		<cfset reference = billing_reference>
		<cfset paid = billing_paid>
		<!--- if billing status is ok, and paid GT 0,
		    add payment record to "payments" --->
    
		  <cfif billing_status IS "ok"
		    AND paid GT 0>
    
		    <!--- def vals --->
		    <cfset sPaymentRef = "Payment (#reference#)">
    
		    <!--- add payment record --->
		    <cfquery username="#db_username#" password="#db_password#" datasource="#DATASOURCE#">
		        INSERT INTO payments
		          (
		           itemnum,
		           date_posted,
		           user_id,
		           amount,
		           reference,
				   docnum	
		          )
		        VALUES
		          (
		           #itemnum#,
		           #dateCreated#,
		           #user_id#,
		           #paid#,
		           '#Variables.sPaymentRef#',
				   '#billing_reference#'				   
				   
		          )
		    </cfquery>
            
			<cfset payment_made = 1>
			
		    <!--- log payment --->
		    <cfmodule template="../../functions/addTransaction.cfm"
		      datasource="#DATASOURCE#"
		      description="Payment (#reference#)"
		      itemnum="#itemnum#"
		      amount="#paid#"
		      user_id="#user_id#">
		  </cfif>
	</cfif>

	<!--	debugging output:						-->
	<!--	billing_reference = <cfoutput>#billing_reference#</cfoutput>	-->
	<!--	billing_paid = <cfoutput>#billing_paid#</cfoutput>		-->

  </cfif>
  
  <!--- If credit applied, determine how much paid --->
 
 <cfif getInfo.credit GT 0> 
   <cfif getInfo.credit LT #fees_total#>
	  <cfset creditpaid = getInfo.credit>
   <cfelseif getInfo.credit GT #fees_total#>
	  <cfset creditpaid = #fees_total#>
   <cfelseif getInfo.credit EQ #fees_total#>
	  <cfset creditpaid = #fees_total#>	  
   </cfif>
  </cfif>
   
  <!--- credits applied + credit card payment --->
  <cfset total_paidamt = #creditpaid# + #paid#>
  
  
  <!--- create a Transaction record if a credit was applied  --->
  <cfif #creditpaid# GT 0>
     <cfmodule template="../../functions/addTransaction.cfm"
        datasource="#Attributes.datasource#"
        description="Credit Applied to Invoiced sent "
        itemnum="#itemnum#"
        amount="#creditpaid#"
        user_id="#user_id#">     
  </cfif>
  
  <!-- add invoice to db -->
  
  <cfif payment_made neq 1>
    <cfquery username="#db_username#" password="#db_password#" name="insInvoice" datasource="#Attributes.datasource#">
      INSERT INTO invoices
        (itemnum, user_id, status, date_created, date_due, listing, fee, bold, featured, featured_cat, banner, fee_inspector, studio, featured_studio, picture1, picture2, picture3, picture4,  second_cat, reserve_bid, late_charge, invoice_total, paid, reference, discount_note)
      VALUES
	    <!--- Change invoice_total to be just the total of the fees and paid to include all payments-credits and card payments --->
        <!---(#itemnum#, #user_id#, #status#, #dateCreated#, #dateDue#, #listing#, #fee#, #bold#, #featured#, #featured_cat#, #banner#, #fee_inspector#, #studio#, #featured_studio#, #second_cat#, #late_charge#, #invoice_total#, #paid#, '#reference#' )--->
        (#itemnum#, #user_id#, #status#, #dateCreated#, #dateDue#, #listing#, #fee#, #bold#, #featured#, #featured_cat#, #banner#, #fee_inspector#, #studio#, #featured_studio#, #picture1#, #picture2#, #picture3#, #picture4#, #second_cat#, #reserve_bid#, #late_charge#, #fees_total#, #total_paidamt#, '#reference#',<cfif membership_pct eq 0>''<cfelse>'#membership_rate#% membership discount applied'</cfif>)
    
	</cfquery>
  <cfelse>
  <!--- for payments made, create an invoice record with docnum populated --->
   <cfquery username="#db_username#" password="#db_password#" name="insInvoice" datasource="#Attributes.datasource#">
      INSERT INTO invoices
        (itemnum, user_id, status, date_created, date_due, listing, fee, bold, featured, featured_cat, banner, fee_inspector, studio, featured_studio, picture1, picture2, picture3, picture4, second_cat, reserve_bid, late_charge, invoice_total, paid, reference, docnum, discount_note)
      VALUES
	    <!--- Change invoice_total to be just the total of the fees and paid to include all payments-credits and card payments --->
        <!---(#itemnum#, #user_id#, #status#, #dateCreated#, #dateDue#, #listing#, #fee#, #bold#, #featured#, #featured_cat#, #banner#, #fee_inspector#, #studio#, #featured_studio#, #second_cat#, #late_charge#, #invoice_total#, #paid#, '#reference#', '#reference#' )--->
        (#itemnum#, #user_id#, #status#, #dateCreated#, #dateDue#, #listing#, #fee#, #bold#, #featured#, #featured_cat#, #banner#, #fee_inspector#, #studio#, #featured_studio#, #picture1#, #picture2#, #picture3#, #picture4#, #second_cat#, #reserve_bid#, #late_charge#, #fees_total#, #total_paidamt#, '#reference#', '#reference#',<cfif membership_pct eq 0>''<cfelse>'#membership_rate#% membership discount applied'</cfif>)

    </cfquery>
 </cfif>
  
  <!--- log invoice --->
  <!---<cfmodule template="../../functions/addTransaction.cfm"
    datasource="#Attributes.datasource#"
    description="Auction Invoiced"
    itemnum="#itemnum#"
    amount="#invoice_total#"
    user_id="#user_id#">--->
  
<cfmodule template="../../functions/addTransaction.cfm"
    datasource="#Attributes.datasource#"
    description="Auction Invoiced"
    itemnum="#itemnum#"
	amount="#fees_total#"
    user_id="#user_id#">
  
  <!--- comment out code because balance & credit were not getting updated when 
        the credits were > than fees on the invoice --->
		
  <!---
  <cfif invoice_total NEQ paid>
    <!-- update user's account balance & credit -->
    <cfquery username="#db_username#" password="#db_password#" name="updBalance" datasource="#Attributes.datasource#">
        UPDATE users
           SET balance = balance + #invoice_total#,
       <cfif getInfo.credit GT invoice_total>
               credit = credit - #invoice_total#
       <cfelse>
               credit = 0
       </cfif>
         WHERE user_id = #user_id#
    </cfquery>
	
   </cfif>--->
  
<!---1.convert numbers to 2 digits after dec. pt- 9999.99       
       
   --->
  
 <cfset fees_total = numberformat(fees_total,'#numbermask#')>
 
 
 <cfset newtotal_invoice = fees_total - total_paidamt>
 <cfset newtotal_invoice = numberformat(newtotal_invoice,'#numbermask#')>
 
 
  <!-- update user's account balance & credit -->
   <cfif getInfo.credit GT 0 OR invoice_total NEQ paid >
	<cfquery username="#db_username#" password="#db_password#" name="updBalance" datasource="#Attributes.datasource#">
       UPDATE users
           <!---SET balance = balance + #invoice_total# - #paid#,--->
           SET balance = balance + #newtotal_invoice#,
	   <cfif getInfo.credit GT fees_total >
               credit = credit - #fees_total#
       <cfelse>
               credit = 0
       </cfif>
         WHERE user_id = #user_id#
    </cfquery>
  </cfif>

 
 
 
  <!-- calc new account balance -->
  <!---<cfset newBalance = getInfo.balance + invoice_total - paid>--->
  <cfset newBalance = getInfo.balance + fees_total - total_paidamt>
  
  

  <!-- setup email message -->
  <cfset nl = "<br>"><!---Chr(13) & Chr(10)--->
  <cfset message = "">
  <cfset message = message & "User Nickname: " & Trim(getInfo.nickname) & nl>
  <cfset message = message & "Item Number: " & getInfo.itemnum & nl>
  <cfset message = message & "Item Title: " & Trim(getInfo.title) & nl>
  <cfset message = message & "Date of Invoice: " & DateFormat(Attributes.timenow, "mm/dd/yyyy") & nl>
  <cfset message = message & "Date Invoice Due: " & DateFormat(Variables.dateDue, "mm/dd/yyyy") & nl & nl>
  <cfloop index="i" from="1" to="#ArrayLen(bill)#">
    <cfset message = message & bill[i][1] & ": " & REReplace(bill[i][2], "[^0-9.]", "", "ALL") & " " & Trim(getCurrency.type) & nl>
  </cfloop>
  <cfif getInfo.membership neq "" and getInfo.membership_exp gt Attributes.timenow and membership_pct neq 0>
  <cfset message = message & nl & "Sub Total: " & numberformat(invSubTotal,numbermask) & " " & Trim(getCurrency.type) & " (a #membership_rate#% Membership discount applied) " & nl>
  <cfelse>
  <cfset message = message & nl & "Sub Total: " & numberformat(invSubTotal,numbermask) & " " & Trim(getCurrency.type) & nl>
  </cfif>
  <cfset message = message & "Account Credit: " & numberformat(getInfo.credit,numbermask) & " " & Trim(getCurrency.type) & nl>
  <!---<cfset message = message & nl & "Total with credits applied: " & numberformat(invoice_total,numbermask) & " " & Trim(getCurrency.type) & nl & nl>--->
  <cfset message = message & nl & "Total with credits applied: " & numberformat(newtotal_invoice,numbermask) & " " & Trim(getCurrency.type) & nl & nl>
  <cfset message = message & "Prior Account Balance: " & numberformat(getInfo.balance,numbermask) & " " & Trim(getCurrency.type) & nl>
  <cfset message = message & "Total Credit Card Payment Received: " & numberformat(paid,numbermask) & " " & Trim(getCurrency.type) & nl>
  <cfset message = message & "New Account Balance: " & numberformat(newBalance,numbermask) & " " & Trim(getCurrency.type)>

  <!-- send email -->
  <cfmodule template="eml_invoice.cfm"
    to="#Trim(getInfo.email)#"
    from="#Attributes.fromEmail#"
    subject="Invoice: (Item ###getInfo.itemnum#) #Trim(getInfo.title)#"
    message="#Variables.message#"
    itemnum="#getInfo.itemnum#"
	title="#getInfo.title#"
	invSubTotal="#invSubTotal#"
	user_id="#user_id#"
	paid="#paid#">

<cfelse>
  <!-- item alerady has an invoice associated with it...  exiting. -->
</cfif>

<!-- set item inactive -->
<cfquery username="#db_username#" password="#db_password#" name="updInactive" datasource="#Attributes.datasource#">
 UPDATE items
    SET status = 0
  WHERE itemnum = #Attributes.itemnum#
</cfquery>



<!--- log auction expired --->
<cfmodule template="../../functions/addTransaction.cfm"
  datasource="#Attributes.datasource#"
  description="Auction Expired"
  itemnum="#Attributes.itemnum#"
  user_id="#user_id#">

