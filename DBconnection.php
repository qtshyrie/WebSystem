<?php
include("conn.php");

$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$email = $_POST['email'];
$username = $_POST['username'];
$birthday = $_POST['birthday'];
$contacts = $_POST['contact'];

if ($_POST['password'] !== $_POST['confirm']) {
    die("<script>alert('Passwords do not match!'); window.history.back();</script>");
}

$password = password_hash($_POST['password'], PASSWORD_DEFAULT);

$stmt = $conn->prepare("INSERT INTO accounts(firstname, lastname, email, username, password, birthday, contacts) VALUES(?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("sssssss", $firstname, $lastname, $email, $username, $password, $birthday, $contacts);

if ($stmt->execute()) {
    echo "<script>
        alert('Registration successful!');
        window.location.href = 'login.html';
    </script>";
} else {
    echo "<script>
        alert('Registration failed. Try again!');
        window.history.back();
    </script>";
}

$stmt->close();
$conn->close();
exit();
?>
