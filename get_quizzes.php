<?php
include("conn.php");
header('Content-Type: application/json');

$result = $conn->query("SELECT * FROM quizzes ORDER BY created_at DESC");
$quizzes = [];
while ($row = $result->fetch_assoc()) {
    $quizzes[] = $row;
}

$total = count($quizzes);
$available = $conn->query("SELECT COUNT(*) as count FROM quizzes WHERE status='Available'")->fetch_assoc()['count'];
$Not = $conn->query("SELECT COUNT(*) as count FROM quizzes WHERE status='Not Available'")->fetch_assoc()['count'];

echo json_encode([
    'quizzes' => $quizzes,
    'qztotal' => $total,
    'qzavailable' => $available,
    'qznot' => $Not
]);

$conn->close();
?>