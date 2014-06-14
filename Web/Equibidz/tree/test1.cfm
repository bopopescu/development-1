<cfquery name="GetCategory" dataSource="eauctionserver">
    SELECT category, parent, name
    FROM categories
	WHERE parent >= 0
    GROUP BY parent, category, name
</cfquery>
<cfset catArray = arraynew(1)>
<cfloop query="GetCategory">
	<cfset catArray[CurrentRow] = "#category#|#parent#|#name#">
</cfloop>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>destroydrop &raquo; JavaScripts &raquo Tree</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="StyleSheet" href="tree.css" type="text/css">
	<script type="text/javascript" src="tree.js"></script>
	<cfoutput>
		<script type="text/javascript">
			var Tree = new Array;
			
			var a = #GetCategory.recordCount#;
			
			<cfset a = 0>
			<cfloop array=#catArray# index="name">
				Tree[#a#] = "#name#";
				<cfset a = #a# + 1>
			</cfloop>
		</script>
	</cfoutput>
</head>

<body>

<b><a href="http://www.destroydrop.com/">destroydrop</a> &raquo;
<a href="http://www.destroydrop.com/javascripts/">JavaScripts</a> &raquo
<a href="http://www.destroydrop.com/javascripts/tree/">Tree</a></b><br />

<br /><br />

<b>Example 1:</b><br /><br />

<div class="tree">
<script type="text/javascript">
<!--
	createTree(Tree);
//-->
</script>
</div>

<br /><br />

<a href="mailto:drop@destroydrop.com">drop@destroydrop.com</a>

</body>
</html>
