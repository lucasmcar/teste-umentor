<?php

namespace App\Model;

class Colaborador
{
    private $id;
    private $nome;
    private $email;
    private $situacao;
    private $dtAtualizacao;
    private $dtCadastro;
    private $dtAdmissao;

    public function __construct()
    {
        
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getId()
    {
        return $this->id;
    }

    public function setNome($nome)
    {
        $this->nome = $nome;
    }

    public function getNome()
    {
        return $this->nome;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setSituacao($situacao)
    {
        $this->situacao = $situacao;    
    }

    public function getSituacao()
    {
        return $this->situacao;
    }

    public function setDtCadastro($dtCadastro)
    {
        $this->dtCadastro = $dtCadastro;
    }

    public function getDtCadastro()
    {
        return $this->dtCadastro;
    }

    public function setDtAdmissao($dtAdmissao)
    {
        $this->dtAdmissao = $dtAdmissao;
    }

    public function getDtAdmissao()
    {
        return $this->dtAdmissao;
    }

    public function setDtAtualizacao($dtAtualizacao)
    {
        $this->dtAtualizacao = $dtAtualizacao;
    }

    public function getDtAtualizacao()
    {
        return $this->dtAtualizacao;
    }
}