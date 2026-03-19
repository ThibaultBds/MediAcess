<?php

namespace App\Service;

use App\Repository\UserRepository;
use Firebase\JWT\JWT;

class AuthService
{
    private UserRepository $userRepository;

    public function __construct()
    {
        $this->userRepository = new UserRepository();
    }

    public function login(string $email, string $password): string
    {
        $user = $this->userRepository->findByEmail($email);

        if (!$user || !password_verify($password, $user['password'])) {
            throw new \Exception('Email ou mot de passe incorrect', 401);
        }

        $payload = [
            'user_id' => $user['id'],
            'role'    => $user['role'],
            'exp'     => time() + 3600
        ];

        return JWT::encode($payload, $_ENV['JWT_SECRET'] ?? 'change_me_in_production', 'HS256');
    }
}
