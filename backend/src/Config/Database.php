<?php

namespace App\Config;

use PDO;
use PDOException;

class Database
{
    private static ?PDO $connection = null;

    public static function getConnection(): PDO
    {
        if (self::$connection === null) {
            $host = 'mysql';
            $dbname = 'mediaccess';
            $username = 'root';
            $password = 'root';

            $dsn = "mysql:host={$host};dbname={$dbname};charset=utf8mb4";

            try {
                self::$connection = new PDO($dsn, $username, $password, [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                ]);
            } catch (PDOException $e) {
                die(json_encode([
                    'error' => 'Database connection failed',
                    'message' => $e->getMessage()
                ]));
            }
        }

        return self::$connection;
    }
}
