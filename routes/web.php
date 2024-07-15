<?php

/**
 * Rotas
 */
$router->get('/', 'IndexController', 'index');
$router->get('/list', 'IndexController', 'list');
$router->post('/novo/colaborador', 'IndexController', 'new');
$router->put('/editar/colaborador/{id}', 'IndexController', 'edit');
$router->delete('/delete/colaborador/{id}', 'IndexController', 'delete');