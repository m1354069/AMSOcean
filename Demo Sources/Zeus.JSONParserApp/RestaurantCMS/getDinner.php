<?php
	//Includes the file that connects to the database, don't forget to edit it with your own information
	include("inc/db_connect.php");
	
	//Connect function
	DBConnect::connect();
	
	//Get all the results from the Dinner table
	$query = mysql_query("SELECT * FROM Menu_Dinner ORDER BY Title ASC");
	
	//This array will hold the results of all the rows
	$results = array();
	
	//Loop through each row and add it to the results array
	while ($row = mysql_fetch_assoc($query)) {
		$results[] = $row;
	}
	
	//Disconnect from the database because our data was already received.
	DBConnect::disconnect();
	
	//Convert the data to a JSON object, append a root object of 'items'
	$json = '{"items":'.json_encode($results).'}';
	
	//Display the JSON to the screen for the iPhone app to be able to read, sending headers as a JSON application so the app doesn't mistake the .php extension.
	header('Content-Type: application/json');
	echo $json;
?>