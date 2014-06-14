<CFHTTP URL="http://#site_address##varoot#/registration/useragreement_format.cfm" METHOD="get">
</CFHTTP>

<cffile action="WRITE" file=#expandPath ("..\registration\user_agreement.html")# output="#CFHTTP.FileContent#">
