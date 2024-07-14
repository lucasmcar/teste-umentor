<?php

namespace App\Model;

use App\Model\Model;
use PDO;

class User extends Model
{
    public function getUser()
    {
        $user = $this->db->query('SELECT * FROM user');
        return $user->fetch(PDO::FETCH_ASSOC);
    }
}