<?php

namespace App\Service;

use App\Model\Colaborador;
use App\Repository\ColaboradorRepository;

class ColaboradorService
{

    private $repository;
   
    public function __construct(ColaboradorRepository $repository)
    {
        $this->repository = $repository; 
    }

    public function create(Colaborador $colaborador)
    {
        return $this->repository->create($colaborador);
    }

    public function getAll()
    {
        return $this->repository->getAll();
    }

    public function pagination($limite, $offeset)
    {
        return $this->repository->pagination($limite, $offeset);
    }

    public function total()
    {
        return $this->repository->total();
    }

    public function delete($id)
    {
        return $this->repository->delete($id);
    }

    public function save(Colaborador $colaborador)
    {
        return $this->repository->save($colaborador);
    }
}