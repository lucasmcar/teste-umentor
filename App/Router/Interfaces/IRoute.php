<?php

namespace App\Router\Interfaces;

interface IRoute
{
    public function add(string $method, string $path, string $controller, string $action = '');
    public function match(string $method, string $path);
}