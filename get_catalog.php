<?php
include("conn.php");
header('Content-Type: application/json');

$result = $conn->query("SELECT * FROM books ORDER BY created_at DESC");
$books = [];
while ($row = $result->fetch_assoc()) {
    $books[] = $row;
}

$total = count($books);
$available = $conn->query("SELECT COUNT(*) as count FROM books WHERE status='Available'")->fetch_assoc()['count'];
$issued = $conn->query("SELECT COUNT(*) as count FROM books WHERE status='Issued'")->fetch_assoc()['count'];

echo json_encode([
    'books' => $books,
    'total' => $total,
    'available' => $available,
    'issued' => $issued
]);

$conn->close();
?>