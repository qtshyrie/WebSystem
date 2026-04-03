<?php
include("conn.php");
header('Content-Type: application/json');

$id       = (int)$_POST['id'];
$title    = $_POST['title'];
$author   = $_POST['author'];
$status   = $_POST['status'];
$rating   = $_POST['rating'];
$category = $_POST['category'];

$stmt = $conn->prepare("UPDATE books SET title=?, author=?, status=?, rating=?, category=? WHERE id=?");
$stmt->bind_param("sssdsi", $title, $author, $status, $rating, $category, $id);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => $conn->error]);
}

$stmt->close();
$conn->close();
?>