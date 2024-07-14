<?php 

namespace App\Model;

use App\Connection\Connection;

class Model
{
    protected $db;

    public function __construct()
    {
        $this->db = Connection::getConnection();
    }
} 