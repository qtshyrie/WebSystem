<?php
include("conn.php");

$username = $_POST['Username'];
$password = $_POST['Password'];

$stmt = $conn->prepare("SELECT * FROM accounts WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    if (password_verify($password, $row['password'])) {
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
exit();
?>