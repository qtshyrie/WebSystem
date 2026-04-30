<?php
session_start(); // ← ADD THIS at the very top!
include("conn.php");

$username = $_POST['Username'];
$password = $_POST['Password'];

$stmt = $conn->prepare("SELECT * FROM accounts WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    if (password_verify($password, $row['password'])) {
    
        // ✅ PUT SESSION LINES HERE — after $row is fetched
        $_SESSION['username']  = $row['username'];
        $_SESSION['firstName'] = $row['firstname'];
        $_SESSION['lastName']  = $row['lastname'];
        $_SESSION['email']     = $row['email'];
        $_SESSION['contact']   = $row['contacts'];

        header("Location: Index.html");
        exit();
    } else {
        header("Location: login.html?error=incorrect");
        exit();
    }
} else {
    header("Location: login.html?error=incorrect");
    exit();
}

$stmt->close();
$conn->close();
?>