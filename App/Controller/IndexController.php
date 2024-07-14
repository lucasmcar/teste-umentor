<?php

namespace App\Controller;

use App\Core\View\View;

class IndexController
{
    public function index()
    {
        $data = []
        return new View('index', $data);
    }
}