<?php
include("conn.php");
header('Content-Type: application/json');

$book_id = (int)$_POST['book_id'];

if (!isset($_FILES['lesson_file'])) {
    echo json_encode(['success' => false, 'error' => 'No file uploaded']);
    exit();
}

$file = $_FILES['lesson_file'];
$allowed = ['pdf', 'html', 'htm', 'docx'];
$ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

if (!in_array($ext, $allowed)) {
    echo json_encode(['success' => false, 'error' => 'Only PDF, HTML, DOCX allowed']);
    exit();
}

// Create uploads folder if it doesn't exist
$upload_dir = 'lessons/';
if (!is_dir($upload_dir)) mkdir($upload_dir, 0777, true);

$filename = 'lesson_' . $book_id . '_' . time() . '.' . $ext;
$filepath = $upload_dir . $filename;

if (move_uploaded_file($file['tmp_name'], $filepath)) {
    $stmt = $conn->prepare("UPDATE books SET file_path = ? WHERE id = ?");
    $stmt->bind_param("si", $filepath, $book_id);
    $stmt->execute();
    echo json_encode(['success' => true, 'path' => $filepath]);
} else {
    echo json_encode(['success' => false, 'error' => 'Upload failed']);
}

$conn->close();
?>
