<?php
include("conn.php");
header('Content-Type: application/json');

$period = isset($_GET['period']) ? (int)$_GET['period'] : 30;
$date_limit = date('Y-m-d', strtotime("-$period days"));

// KPI Data
$total = $conn->query("SELECT COUNT(*) as count FROM books")->fetch_assoc()['count'];
$available = $conn->query("SELECT COUNT(*) as count FROM books WHERE status='Available'")->fetch_assoc()['count'];
$issued = $conn->query("SELECT COUNT(*) as count FROM books WHERE status='Issued'")->fetch_assoc()['count'];
$rating = $conn->query("SELECT ROUND(AVG(rating),1) as avg FROM books")->fetch_assoc()['avg'] ?? 0;

// KPI previous period for trend
$prev_limit = date('Y-m-d', strtotime("-" . ($period * 2) . " days"));
$prev_total = $conn->query("SELECT COUNT(*) as count FROM books WHERE created_at >= '$prev_limit' AND created_at < '$date_limit'")->fetch_assoc()['count'];
$curr_total = $conn->query("SELECT COUNT(*) as count FROM books WHERE created_at >= '$date_limit'")->fetch_assoc()['count'];
$trend = $prev_total > 0 ? round((($curr_total - $prev_total) / $prev_total) * 100) : 0;

// Categories for charts
$categories = ['Science', 'History', 'Math', 'Literature', 'Tech', 'Arts'];
$usage = [];
foreach ($categories as $cat) {
    $count = $conn->query("SELECT COUNT(*) as count FROM books WHERE category='$cat'")->fetch_assoc()['count'];
    $usage[] = (int)$count;
}

// Status chart
$status_data = [
    (int)$available,
    (int)$issued,
    0 // pending placeholder
];

// Top categories pie chart
$cat_result = $conn->query("SELECT category, COUNT(*) as count FROM books GROUP BY category ORDER BY count DESC LIMIT 4");
$cat_labels = [];
$cat_data = [];
while ($row = $cat_result->fetch_assoc()) {
    $cat_labels[] = $row['category'];
    $cat_data[] = (int)$row['count'];
}

// Recent books
$books_result = $conn->query("SELECT * FROM books ORDER BY created_at DESC LIMIT 10");
$books = [];
while ($row = $books_result->fetch_assoc()) {
    $books[] = $row;
}

// Activity log
$activity_result = $conn->query("SELECT * FROM activity_log ORDER BY created_at DESC LIMIT 5");
$activities = [];
while ($row = $activity_result->fetch_assoc()) {
    $activities[] = $row;
}

echo json_encode([
    'kpi' => [
        'total' => $total,
        'available' => $available,
        'issued' => $issued,
        'rating' => $rating,
        'trend' => ($trend >= 0 ? '+' : '') . $trend . '%'
    ],
    'usage' => $usage,
    'status' => $status_data,
    'categories' => ['labels' => $cat_labels, 'data' => $cat_data],
    'books' => $books,
    'activities' => $activities
]);

$conn->close();
?>