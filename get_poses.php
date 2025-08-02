<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

$conn = new mysqli("localhost", "root", "", "robot_arm");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$result = $conn->query("SELECT * FROM poses ORDER BY id DESC");

$data = array();
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

print_r($data); // مؤقتًا بدل echo json
$conn->close();
?>