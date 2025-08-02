<?php
header("Access-Control-Allow-Origin: *"); // يسمح للاتصال من Flutter

$conn = new mysqli("localhost", "root", "", "robot_arm");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$m1 = $_POST['m1'];
$m2 = $_POST['m2'];
$m3 = $_POST['m3'];
$m4 = $_POST['m4'];

$sql = "INSERT INTO poses (m1, m2, m3, m4) VALUES ('$m1', '$m2', '$m3', '$m4')";
$conn->query($sql);
$conn->close();
?>