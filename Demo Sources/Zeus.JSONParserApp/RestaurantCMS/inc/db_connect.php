<?php
abstract class DBConnect {
	//Edit the following to connect to your database
	public static $host = "localhost";
	public static $user = "hyokos";
	public static $pw = "jcmlives";
	public static $con;
	
	public static function connect() {
		self::$con = mysql_connect(self::$host, self::$user, self::$pw);

		if (!self::$con) {
			die('Could not connect: ' . mysql_error());
		}
		
		//Edit the following for your database name
		$dbname = "iOS_JSONParser_DB";
		mysql_select_db($dbname, self::$con);
	}
	
	public static function disconnect() {
		mysql_close(self::$con);
	}
}
?>