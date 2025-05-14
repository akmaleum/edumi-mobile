<?php
error_reporting(E_ALL & ~E_DEPRECATED);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

ob_start();

include 'config.php';

if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(["error" => "User ID is required"]);
    exit();
}

$user_id = mysqli_real_escape_string($conn, $_GET['id']);

$sql = "SELECT id, username, first_name, last_name, email, date_joined 
        FROM auth_user 
        WHERE id = '$user_id' AND is_active = 1";

$result = mysqli_query($conn, $sql);

if ($result && mysqli_num_rows($result) > 0) {
    $user = mysqli_fetch_assoc($result);
    ob_end_clean();
    echo json_encode($user);
} else {
    http_response_code(404);
    ob_end_clean();
    echo json_encode(["error" => "User not found"]);
}

mysqli_close($conn);
