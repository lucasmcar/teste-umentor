<?php 

namespace App\Connection;

use PDO;
use PDOException;

class Connection
{

    private static $pdo;

    public static function getConnection()
    {
        try{
            self::$pdo = new PDO('mysql:host=localhost;dbname=teste_umentor_db', 'root', 'root');
            self::$pdo->setAttribute(PDO::ERRMODE_EXCEPTION, PDO::ATTR_ERRMODE);
            return self::$pdo;
        }catch(PDOException $ex){
            $ex->getMessage();
        }
        
    }
}