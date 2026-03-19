<?php

namespace App\Core;

class Router
{
    private array $routes = [];

    public function get(string $path, callable $handler): void
    {
        $this->routes['GET'][$path] = $handler;
    }

    public function post(string $path, callable $handler): void
    {
        $this->routes['POST'][$path] = $handler;
    }

    public function dispatch(string $method, string $uri): void
    {
        $path = parse_url($uri, PHP_URL_PATH);

        if (isset($this->routes[$method][$path])) {
            call_user_func($this->routes[$method][$path]);
            return;
        }

        http_response_code(404);
        header('Content-Type: application/json');
        echo json_encode([
            'error' => 'Route not found'
        ]);
    }
}
