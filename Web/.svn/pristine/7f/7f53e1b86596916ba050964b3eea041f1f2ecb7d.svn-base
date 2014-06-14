<CFHTTP URL="http://#site_address##varoot#/listings/categories/cats.cfm" METHOD="get">
</CFHTTP>

<cffile action="WRITE" file=#expandPath ("..\listings\categories\all_cats.html")# output="#CFHTTP.FileContent#">
