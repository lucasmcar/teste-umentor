<?php

namespace App\Controller;

use App\Core\View\View;
use App\Helper\InputFilterHelper;
use App\Model\Colaborador;
use App\Service\ColaboradorService;
use App\Repository\ColaboradorRepository;

class IndexController
{
    public function index()
    {
        $colaboradorRepository = new ColaboradorRepository();
        $colaboradorService = new ColaboradorService($colaboradorRepository);
        $data = [
            'total' => $colaboradorRepository->total(),
            'title' => 'Teste umentor',
            'dados' => $colaboradorService->getAll()
        ];
        return new View('index',$data);
    }

    public function list($pagina = 1, $limite = 10)
    {

        $limite = isset($_GET['limite']) ? intval($_GET['limite']) : 10;
        $pagina = isset($_GET['pagina']) ? intval($_GET['pagina']) : 1;
        $offset = ($pagina - 1) * $limite;

        $colaboradorRepository = new ColaboradorRepository();
        $colaboradorService = new ColaboradorService($colaboradorRepository);

        $colaboradores = $colaboradorService->pagination($limite, $offset);
        $data = [
            'dados' => $colaboradores,
            'total' => $colaboradorService->total(),
            'limite' => $limite,
            'pagina' => $pagina
        ];
        
        echo json_encode($data);
    }

    public function new()
    {
        $colaborador = InputFilterHelper::filterInputs(INPUT_POST, 
        [
            'nome',
            'email',
            'situacao',
            'cadastro',
        ]);

        $colaboradorObj = new Colaborador();
        $colaboradorObj->setNome($colaborador['nome']);
        $colaboradorObj->setEmail($colaborador['email']);
        $colaboradorObj->setSituacao($colaborador['situacao']);
        $colaboradorObj->setDtCadastro($colaborador['cadastro']);
        
        $colaboradorRepository = new ColaboradorRepository();
        $colaboradorService = new ColaboradorService($colaboradorRepository);
        $colaboradorService->create($colaboradorObj);
        
    }

    public function edit($id)
    {
        $colaboradorRepository = new ColaboradorRepository();
        $colaboradorService = new ColaboradorService($colaboradorRepository);

        $colaborador = InputFilterHelper::filterInputs(INPUT_POST, 
        [
            'nome',
            'email',
            'situacao',
            'cadastro',
            'admissao'
        ]);

        $colaboradorObj = new Colaborador();
        $colaboradorObj->setId($id);
        $colaboradorObj->setNome($colaborador['nome']);
        $colaboradorObj->setEmail($colaborador['email']);
        $colaboradorObj->setSituacao($colaborador['situacao']);
        $colaboradorObj->setDtAdmissao(\DateTime::createFromFormat('d/m/Y H:i:s', $colaborador['admissao'])->format("Y-m-d H:i:s"));

        $colaboradorService->save($colaboradorObj);
    }

    public function delete($id)
    {
        $colaboradorRepository = new ColaboradorRepository();
        $colaboradorService = new ColaboradorService($colaboradorRepository);

        $colaboradorService->delete($id);
    }
}

