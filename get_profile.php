<?php
session_start();
include("conn.php");
header('Content-Type: application/json');
 
// Check if session username exists
if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    echo json_encode(['success' => false, 'error' => 'User not logged in']);
    $conn->close();
    exit();
}
 
$username = $_SESSION['username'];
 
// Prepare and execute query
$stmt = $conn->prepare("SELECT firstname, lastname, email, contacts FROM accounts WHERE username = ?");
 
if (!$stmt) {
    echo json_encode(['success' => false, 'error' => 'Database error: ' . $conn->error]);
    $conn->close();
    exit();
}
 
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();
 
if ($row) {
    echo json_encode(['success' => true, 'data' => $row]);
} else {
    echo json_encode(['success' => false, 'error' => 'User not found']);
}
 
$stmt->close();
$conn->close();
?>