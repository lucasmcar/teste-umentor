<?php

namespace App\Router\Interfaces;

interface IRouter
{
    public function get(string $path, mixed $controller, string $action = '');
    public function post(string $path, mixed $controller, string $action);
    public function put(string $path, mixed $controller, string $action);
    public function delete(string $path, mixed $controller, string $action);
    public function route($method, $path);
    public function notFound($callback);
} 