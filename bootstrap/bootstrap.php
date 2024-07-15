<?php

require __DIR__.'/../vendor/autoload.php';

date_default_timezone_set('America/Sao_Paulo');

use App\Router\Route;
use App\Router\Router;

$routeFactory = new Route();
$router = new Router($routeFactory);

