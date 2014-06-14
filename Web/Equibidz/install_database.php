<?php
// Name of the file
$filename = 'test.sql';
// MySQL host
$mysql_host = 'localhost';
// MySQL username
$mysql_username = 'root';
// MySQL password
$mysql_password = '';
// Database name
$mysql_database = 'test';

//////////////////////////////////////////////////////////////////////////////////////////////

$con = mysql_connect("localhost","root","");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }if (mysql_query("CREATE DATABASE " . $mysql_database,$con))
  {
  echo "Creating database ... ";
  }
else
  {
  echo "Error creating database: " . mysql_error();
  }mysql_close($con);

echo "Installing database ... ";

// Connect to MySQL server
mysql_connect($mysql_host, $mysql_username, $mysql_password) or die('Error connecting to MySQL server: ' . mysql_error());
// Select database
mysql_select_db($mysql_database) or die('Error selecting MySQL database: ' . mysql_error());

// Temporary variable, used to store current query
$templine = '';
// Read in entire file
$lines = file($filename);
// Loop through each line
foreach ($lines as $line_num => $line) {
// Only continue if it's not a comment
if (substr($line, 0, 2) != '--' && $line != '') {
// Add this line to the current segment
$templine .= $line;
// If it has a semicolon at the end, it's the end of the query
if (substr(trim($line), -1, 1) == ';') {
// Perform the query
mysql_query($templine) or print('Error performing query \'<b>' . $templine . '</b>\': ' . mysql_error() . '<br /><br />');
// Reset temp variable to empty
$templine = '';
}
}
}

echo "Operation Complete!";

?>
