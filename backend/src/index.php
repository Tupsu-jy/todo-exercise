<?php
// Add CORS headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// $pdo = new PDO("pgsql:host=db;dbname=tododb", "todo_user", "todo_password");
$pdo = new PDO("pgsql:host=localhost;port=5432;dbname=tododb", "todo_user", "todo_password");

// Get the request path and ID
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$pathParts = explode('/', trim($path, '/'));
$id = $pathParts[1] ?? null; // Get ID from URL if present

// Get JSON request body for PUT/PATCH/POST requests
$jsonData = json_decode(file_get_contents('php://input'), true);

switch ($_SERVER['REQUEST_METHOD']) {
    case "GET":
        $stmt = $pdo->query("SELECT * FROM todos");
        echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
        break;

    case "POST":
        $description = $jsonData['description'];
        $stmt = $pdo->prepare("INSERT INTO todos (description) VALUES (?)");
        $stmt->execute([$description]);
        http_response_code(201); // Created
        echo json_encode(['status' => 'success']);
        break;

    case "DELETE":
        if (!$id) {
            http_response_code(400);
            echo json_encode(['error' => 'ID is required']);
            break;
        }
        $stmt = $pdo->prepare("DELETE FROM todos WHERE id = ?");
        $stmt->execute([$id]);
        echo json_encode(['status' => 'success']);
        break;

    case "PUT":
        if (!$id) {
            http_response_code(400);
            echo json_encode(['error' => 'ID is required']);
            break;
        }
        $description = $jsonData['description'];
        $stmt = $pdo->prepare("UPDATE todos SET description = ? WHERE id = ?");
        $stmt->execute([$description, $id]);
        echo json_encode(['status' => 'success']);
        break;

    case "PATCH":
        if (!$id) {
            http_response_code(400);
            echo json_encode(['error' => 'ID is required']);
            break;
        }

        // Strict validation of input
        if (!isset($jsonData['is_completed'])) {
            http_response_code(400);
            echo json_encode(['error' => 'is_completed field is required']);
            break;
        }

        // Type checking 
        if (!is_bool($jsonData['is_completed'])) {
            http_response_code(400);
            echo json_encode(['error' => 'is_completed must be a boolean value']);
            break;
        }

        $is_completed = $jsonData['is_completed'];
        
        $stmt = $pdo->prepare("UPDATE todos SET is_completed = ? WHERE id = ?");
        $stmt->bindValue(1, $is_completed, PDO::PARAM_BOOL);
        $stmt->bindValue(2, $id);
        $stmt->execute();
        echo json_encode(['status' => 'success']);
        break;

    default:
        http_response_code(405);
        echo json_encode(['error' => 'Method not allowed']);
        break;
}
?>
