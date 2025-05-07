<?php
error_reporting(E_ALL & ~E_DEPRECATED);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

ob_start();

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['id'])) {
    http_response_code(400);
    echo json_encode(["error" => "User ID is required"]);
    exit();
}

$user_id = mysqli_real_escape_string($conn, $data['id']);
$first_name = mysqli_real_escape_string($conn, $data['first_name'] ?? '');
$last_name = mysqli_real_escape_string($conn, $data['last_name'] ?? '');
$phone_number = mysqli_real_escape_string($conn, $data['phone_number'] ?? '');

$sql = "UPDATE auth_user 
        SET first_name = '$first_name',
            last_name = '$last_name',
            phone_number = '$phone_number'
        WHERE id = '$user_id' AND is_active = 1";

if (mysqli_query($conn, $sql)) {
    ob_end_clean();
    echo json_encode(["message" => "User details updated successfully"]);
} else {
    http_response_code(500);
    ob_end_clean();
    echo json_encode(["error" => "Failed to update user details"]);
}

mysqli_close($conn);
