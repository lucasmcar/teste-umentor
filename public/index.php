<?php

require '../bootstrap/bootstrap.php';

use App\Router\Route;
use App\Router\Router;

$routeFactory = new Route();
$router = new Router($routeFactory);

include '../routes/web.php';

$router->run();

