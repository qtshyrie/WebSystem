<?php
session_start();
include("conn.php");
header('Content-Type: application/json');

$username = $_SESSION['username'] ?? '';

if ($username) {
    $stmt = $conn->prepare("SELECT firstname, lastname, email, contacts FROM accounts WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $row = $stmt->get_result()->fetch_assoc();

    echo json_encode(['success' => true, 'data' => $row]);
} else {
    echo json_encode(['success' => false]);
}
$conn->close();
?>