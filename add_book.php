<?php
include("conn.php");
header('Content-Type: application/json');

$title    = $_POST['title'];
$author   = $_POST['author'];
$status   = $_POST['status'];
$rating   = $_POST['rating'];
$category = $_POST['category'];

$stmt = $conn->prepare("INSERT INTO books(title, author, status, rating, category) VALUES(?, ?, ?, ?, ?)");
$stmt->bind_param("sssds", $title, $author, $status, $rating, $category);

if ($stmt->execute()) {
    $id = $conn->insert_id;

    // Log activity
    $log = $conn->prepare("INSERT INTO activity_log(icon, description) VALUES(?, ?)");
    $desc = "📖 '$title' by $author added";
    $icon = "📖";
    $log->bind_param("ss", $icon, $desc);
    $log->execute();

    echo json_encode(['success' => true, 'id' => $id]);
} else {
    echo json_encode(['success' => false, 'error' => $conn->error]);
}

$stmt->close();
$conn->close();
?>