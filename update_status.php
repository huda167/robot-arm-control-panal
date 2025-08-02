<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "robot_db";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE poses SET status = 0 WHERE status = 1";
if ($conn->query($sql) === TRUE) {
  echo "Status updated successfully";
} else {
  echo "Error updating status: " . $conn->error;
}

$conn->close();
?>