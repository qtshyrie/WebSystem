<?php
$db_url = "localhost";
$db_user = "root";
$db_password = "";
$db_name = "websystem";

$conn = mysqli_connect($db_url, $db_user, $db_password, $db_name);

if (!$conn) {
    die("<script>alert('Could not connect to database!');</script>");
}
?>