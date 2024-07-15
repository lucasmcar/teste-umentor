<?php

namespace App\Repository;

use App\Connection\Connection;
use App\Model\Colaborador;

class ColaboradorRepository
{

    private $con;

    public function __construct()
    {
        $this->con = Connection::getConnection();
    }

    public function create(Colaborador $colaborador)
    {
        $sql = "INSERT INTO colaborador(nome, email, situacao, cadastro) VALUES (:nome, :email, :situacao, NOW())";
        $stmt = $this->con->prepare($sql);
        $stmt->bindValue(':nome', $colaborador->getNome());
        $stmt->bindValue(':email', $colaborador->getEmail());
        $stmt->bindValue(':situacao', $colaborador->getSituacao());
    
        return $stmt->execute();
    }

    public function save(Colaborador $colaborador)
    {
        $sql = "UPDATE colaborador SET nome = :nome, email = :email, situacao = :situacao, admissao = :admissao, atualizacao = NOW() WHERE id = :id";
        $stmt = $this->con->prepare($sql);
        $stmt->bindValue(':id', $colaborador->getId());
        $stmt->bindValue(':nome', $colaborador->getNome());
        $stmt->bindValue(':email', $colaborador->getEmail());
        $stmt->bindValue(':situacao', $colaborador->getSituacao());
        $stmt->bindValue(':admissao', $colaborador->getDtAdmissao());
        return $stmt->execute();
    }

    

    public function getAll()
    {
        $sql = "SELECT * FROM colaborador";
        $stmt = $this->con->query($sql);
        $stmt->execute();
        $resultado = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $resultado;
    }

    public function pagination($limite, $offset)
    {
        $sql = "SELECT * FROM colaborador LIMIT :limit OFFSET :offset";
        $stmt = $this->con->prepare($sql);
        $stmt->bindParam(':limit', $limite, \PDO::PARAM_INT);
        $stmt->bindParam(':offset', $offset, \PDO::PARAM_INT);
        $stmt->execute();
        $resultado = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $resultado;
    }

    public function total()
    {
        $sql = "SELECT COUNT(*) as total FROM colaborador";
        $stmt = $this->con->query($sql);
        $stmt->execute();
        $resultado = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $resultado[0]['total'];
    }

    public function delete($id)
    {
        $sql = "DELETE FROM colaborador WHERE id = :id";
        $stmt = $this->con->prepare($sql);
        $stmt->bindValue(':id', $id);
        return $stmt->execute();
    }



}