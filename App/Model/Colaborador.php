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
        
        $date = str_replace('/', '-', $dtCadastro);
        $this->dtCadastro = date('Y-m-d H:i:s', strtotime($date));
    }

    public function getDtCadastro()
    {
        return $this->dtCadastro;
    }

    public function setDtAdmissao($dtAdmissao)
    {
        $date = str_replace('/', '-', $dtAdmissao);
        $this->dtAdmissao = date('Y-m-d H:i:s', strtotime($date));
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