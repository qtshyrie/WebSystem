<?php
session_start();
include("conn.php");

if (!isset($_SESSION['username'])) {
    echo json_encode(['success' => false, 'error' => 'Not logged in']);
    exit();
}

$firstName = $_POST['firstName'];
$lastName  = $_POST['lastName'];
$email     = $_POST['email'];
$contact   = $_POST['contact'];
$username  = $_SESSION['username'];

$stmt = $conn->prepare(
  "UPDATE accounts SET firstname=?, lastname=?, email=?, contacts=? WHERE username=?"
);
$stmt->bind_param("sssss", $firstName, $lastName, $email, $contact, $username);
$stmt->execute();

// Update session too
$_SESSION['firstName'] = $firstName;
$_SESSION['lastName']  = $lastName;
$_SESSION['email']     = $email;
$_SESSION['contact']   = $contact;

echo json_encode(['success' => true]);
$stmt->close();
$conn->close();
?>