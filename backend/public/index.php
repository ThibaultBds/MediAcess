<?php

require_once __DIR__ . '/../vendor/autoload.php';


use App\Core\Router;
use App\Config\Database;

header('Content-Type: application/json');

$router = new Router();

$router->get('/health', function () {
    echo json_encode([
        'status' => 'ok',
        'message' => 'MediAccess API running'
    ]);
});

$router->get('/db-test', function () {
    $pdo = Database::getConnection();

    $stmt = $pdo->query('SELECT 1 as test');
    $result = $stmt->fetch();

    echo json_encode([
        'status' => 'ok',
        'database' => 'connected',
        'result' => $result
    ]);
});

$router->dispatch($_SERVER['REQUEST_METHOD'], $_SERVER['REQUEST_URI']);
