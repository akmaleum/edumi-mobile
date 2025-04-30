<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'config.php';

$search = isset($_GET['search']) ? mysqli_real_escape_string($conn, $_GET['search']) : null;

$sql = "SELECT * FROM blog_blogactivities WHERE is_published = 1";

if ($search) {
    $sql .= " AND title LIKE '%$search%'";
}

$result = mysqli_query($conn, $sql);

if ($result) {
    $posts = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $posts[] = $row;
    }
    // Use JSON_UNESCAPED_SLASHES to prevent escaping forward slashes
    $json = json_encode($posts, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($json === false) {
        http_response_code(500);
        echo json_encode(["error" => "JSON encoding failed: " . json_last_error_msg()]);
    } else {
        echo $json;
    }
} else {
    http_response_code(500);
    echo json_encode(["error" => "Failed to fetch blog posts: " . mysqli_error($conn)]);
}

mysqli_close($conn);
