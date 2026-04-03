<?php
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $username = $_POST['username'];
    $birthday = $_POST['birthday'];
    $contacts = $_POST['contact'];

    // Check BEFORE hashing
    if ($_POST['password'] !== $_POST['confirm']) {
        die("Passwords do not match!");
    }

    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    $conn = new mysqli('localhost', 'root', '', 'websystem');
    if($conn->connect_error){
        die('Connection Failed : ' . $conn->connect_error);
    } else {
        // ✅ Changed "registration" to "accounts", and "contact" to "contacts"
        $stmt = $conn->prepare("INSERT INTO accounts(firstname, lastname, email, username, password, birthday, contacts)
        VALUES(?, ?, ?, ?, ?, ?, ?)");
        
        $stmt->bind_param("sssssss", $firstname, $lastname, $email, $username, $password, $birthday, $contacts);
        $stmt->execute();
        echo "Registration successful!";
        $stmt->close();
        $conn->close();
    }
?>