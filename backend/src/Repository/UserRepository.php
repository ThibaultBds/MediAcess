<?php

namespace App\Repository;

use App\Config\Database;
use PDO;

class UserRepository
{
    private PDO $pdo;

    public function __construct()
    {
        $this->pdo = Database::getConnection();
    }

    public function findByEmail(string $email): array|false
    {
        $stmt = $this->pdo->prepare("
            SELECT u.*, r.name as role
            FROM users u
            LEFT JOIN user_roles ur ON ur.user_id = u.id
            LEFT JOIN roles r ON r.id = ur.role_id
            WHERE u.email = :email
        ");
        $stmt->execute([':email' => $email]);
        return $stmt->fetch();
    }
}
