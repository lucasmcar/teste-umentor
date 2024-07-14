<?php

namespace App\Router;


use App\Router\Interfaces\IRouter;
use App\Router\Interfaces\IRoute;

class Router  implements IRouter 
{
    private $routes = [];
    private $notFoundCallback;
    private $route;
    private $path;
    private $method;

    public function __construct(IRoute $route)
    {
        $this->route = $route;
    }

    public function get($path, $controller, $action = '' , $middleware = [])
    {
        $this->addRoute('GET', $path, $controller, $action, $middleware);
    }

    public function post($path, $controller, $action = '', $middleware = [])
    {
        $this->addRoute('POST', $path, $controller, $action, $middleware);
    }

    public function put($path, $controller, $action = '', $middleware = [])
    {
        $this->addRoute('PUT', $path, $controller, $action, $middleware);
    }

    public function delete($path, $controller, $action = '', $middleware = [])
    {
        $this->addRoute('DELETE', $path, $controller, $action, $middleware);
    }

   
    private function addRoute($method, $path, $controller, $action = '', $middleware = [])
    {
        $route = $this->route->add($method, $path, $controller, $action);
        /*$this->routes[] = $route;*/
        $this->routes[] = [
            'route' => $route,
        ];

    }

    public function route($method, $path)
    {
        $path = urldecode($path);
        foreach ($this->routes as $route) {
            $match = $route['route']->match($method, $path);
            if ($match) {
                
                $controllerClass = "App\\Controller\\" . ucfirst($match['controller']);
                $controller = new $controllerClass();
                call_user_func_array([$controller, $match['action']], $match['params']);
                
                return;
            }
        }

        if ($this->notFoundCallback) {
            call_user_func($this->notFoundCallback);
        } else {
            http_response_code(404);
        }
    }

    public function run()
    {
        $this->method = $_SERVER['REQUEST_METHOD'];
        $this->path = $_SERVER['REQUEST_URI'];
        $this->route($this->method, $this->path);
    }

    public function notFound($callback)
    {
        $this->notFoundCallback = $callback;
    }
}