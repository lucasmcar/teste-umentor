<?php 

namespace App\Router;

use App\Router\Interfaces\IRoute;

class Route implements IRoute
{
    private $method;
    private $path;
    private $controller;
    private $action;

    public function __construct($method = '', $path = '', $controller = '', $action = '')
    {
        $this->method = $method;
        $this->path = $path;
        $this->controller = $controller;
        $this->action = $action;
    }

    public function add($method, $path, $controller, $action = '')
    {
        return new self($method, $path, $controller, $action);
    }

    public function match($method, $path)
    {
        // Extrair o caminho da URL sem os parâmetros de consulta
        $parsedUrl = parse_url($path);
        $routePath = $parsedUrl['path'];

        // Gerar o padrão de rota a partir do caminho da rota
        $routePattern = preg_replace('/\{(\w+)\?\}/', '(\w+)?', str_replace('/', '\/', $this->path));
        $routePattern = preg_replace('/\{(\w+)\}/', '(\w+)', $routePattern);
        $routePattern = '/^' . $routePattern . '$/';

        // Verificar correspondência do método e do caminho
        if ($this->method === $method && preg_match($routePattern, $routePath, $matches)) {
            array_shift($matches); // Remove the first item which is the full URL
            // Adicionar parâmetros de consulta aos parâmetros correspondidos
            $queryParams = [];
            if (isset($parsedUrl['query'])) {
                parse_str($parsedUrl['query'], $queryParams);
            }
            return [
                'controller' => $this->controller,
                'action' => $this->action,
                'params' => array_merge($matches, $queryParams)
            ];
        }
        return false;
    }
}