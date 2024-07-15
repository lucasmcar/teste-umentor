
<div class="container">
    <h2>{{ $title }}</h2>

    <div class="row">
        <div class="col-s6">
            <button type="button" class="btn btn-primary add-btn" id="add-btn" data-bs-toggle="modal" data-bs-target="#addColaboradorModal">
                Adicionar Colaborador
            </button>
        </div>
    </div>

    <hr>
    <div class="container mt-3 mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="Buscar...">
    </div>
    <h2>Lista de colaboradores</h2>
    <table class="table table-striped mt-3" id="colaboradorTable">
    <caption>*T = Em Teste, D = Demitido, C = Contratado</caption>
        <thead>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Situação</th>
            <th>Data de Admissão</th>
            <th>Data de Cadastro</th>
            <th>Úlitma Atualização</th>
            <th>Ações</th>
        <thead>
        <tbody>
        
        </tbody>
    </table>
    <div class="row">
        <nav aria-label="Paginação">
            <ul class="pagination">
                
            </ul>
        </nav>
    </div>
</div>


<!-- Modal de Adição -->
<div class="modal fade" id="addColaboradorModal" tabindex="-1" aria-labelledby="addColaboradorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addColaboradorModalLabel">Adicionar Colaborador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addColaboradorForm" method="POST">
                    <div class="form-group mb-3">
                        <label for="txtNome">Nome</label>
                        <input type="text" class="form-control" id="txtNome" name="nome" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="txtEmail">Email</label>
                        <input type="text" class="form-control" id="txtEmail" name="email" >
                    </div>
                    <input type="hidden" name="cadastro" value="<?php echo date('Y-m-d H:i:s'); ?>">
                    <div class="form-group mb-3">
                        <label for="slcSituacao">Situação</label>
                        <select class="form-select" name="situacao" aria-label="Default select example" id="slcSituacao">
                            <option selected value="">Situação</option>
                            <option value="T">Em Teste</option>
                            <option value="C">Contratado</option>
                            <option value="D">Demitido</option>
                        </select>
                    </div>
                    <div class="form-group mb-3" id="campoAdmissao" style="display: none;">
                        <label for="txtAdmissao">Data de Admissão</label>
                        <input type="text" class="form-control" id="txtAdmissao" name="admissao" >
                    </div>
                    <button type="submit" class="btn btn-primary">Adicionar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Edição -->
<div class="modal fade" id="editColaboradorModal" tabindex="-1" aria-labelledby="editColaboradorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editColaboradorModalLabel">Editar Usuário</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editColaboradorForm">
                    <div class="form-group mb-3">
                        <label for="txtNome">Nome</label>
                        <input type="text" class="form-control" id="txtNomeEdt" name="nome" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="txtEmail">Email</label>
                        <input type="text" class="form-control" id="txtEmailEdt" name="email" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="slcSituacao">Situação</label>
                        <select class="form-select" name="situacao" aria-label="Default select example" id="slcSituacaoEdt">
                            <option value="">Situação</option>
                            <option value="T">Em Teste</option>
                            <option value="C">Contratado</option>
                            <option value="D">Demitido</option>
                        </select>
                    </div>
                    <div class="form-group mb-3" id="campoAdmissaoEdit" style="display: none;">
                        <label for="txtAdmissaoEdt">Data de Admissão</label>
                        <input type="text" class="form-control" id="txtAdmissaoEdt" name="admissao" >
                    </div>
                    <input type="hidden" id="txtColaboradorId" name="id">
                    <button type="submit" class="btn btn-primary">Adicionar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.7/dist/sweetalert2.all.min.js"></script>

<script>




$(document).on('click', '.edit-btn', function() {
    var editColaboradorModal = new bootstrap.Modal(document.getElementById('editColaboradorModal'));
    editColaboradorModal.show();
});


$(document).ready(function() {

    $('#add-btn').on('click', function(){
        $('#addColaboradorModal').modal('show');
    })
    
    $('#edit-btn').on('click', function() {
        $('#editColaboradorModal').modal('show');
    });

    var paginaAtual = 1;
    var limite = 10;
    
    function carregaColaborador(pagina = 1) {
        $.ajax({
            url: '/list', 
            data: {
                pagina: pagina,
                limite: limite
            },
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                var colaboradorTable = $('#colaboradorTable tbody');
                colaboradorTable.empty(); // Limpa a tabela
                $.each(response['dados'], function(index, colaborador) {
                    
                    colaboradorTable.append(
                        '<tr><td>' + colaborador.id + 
                        '</td><td>' + colaborador.nome + 
                        '</td><td>' + colaborador.email + 
                        '</td><td>' + colaborador.situacao + 
                        '</td><td>' + colaborador.admissao + 
                        '</td><td>' + colaborador.cadastro +
                        '</td><td>' + colaborador.atualizacao +
                        '</td><td><a href="/editar/colaborador/'+colaborador.id+'" id="edit-btn" class="edit-btn"  data-id="' + colaborador.id + '" ' +
                                        'data-nome="' + colaborador.nome + '" ' +
                                        'data-id="' +colaborador.id + '" '+
                                        'data-email="' + colaborador.email + '" ' +
                                        'data-situacao="' + colaborador.situacao + '" '+ 
                                        'data-admissao="' + colaborador.admissao + '"><span class="material-symbols-outlined" style="color: yellow;">edit</span></a>'+
                        '|<a href="/delete/colaborador/'+colaborador.id+'" class="delete-btn"><span class="material-symbols-outlined" style="color: red;">delete</span></a>'+
                        '</td></tr>'
                    );
                });
                var totalPaginas = Math.ceil(response['total'] / response['limite']);
                atualizaPaginacao(pagina, totalPaginas);
            }
        });
    }

    function atualizaPaginacao(pagina, totalPaginas) {
        var paginacao = $('ul.pagination');
        paginacao.empty();

        // Botão "Anterior"
        if (pagina > 1) {
            paginacao.append(
                '<li class="page-item">' +
                    '<a class="page-link" href="#" data-page="' + (pagina - 1) + '"> < </a>' +
                '</li>'
            );
        } else {
            paginacao.append(
                '<li class="page-item disabled">' +
                    '<a class="page-link" href="#"> < </a>' +
                '</li>'
            );
        }
        

        
        for (var i = 1; i <= totalPaginas; i++) {
            paginacao.append(
                '<li class="page-item ' + (i === pagina ? 'active' : '') + '">' +
                    '<a class="page-link" href="#" data-page="' + i + '">' + i + '</a>' +
                '</li>'
            );
        }
        

        if (pagina < totalPaginas) {
            paginacao.append(
                '<li class="page-item">' +
                    '<a class="page-link" href="#" data-page="' + (pagina + 1) + '"> > </a>' +
                '</li>'
            );
        } else {
            paginacao.append(
                '<li class="page-item disabled">' +
                    '<a class="page-link" href="#"> > </a>' +
                '</li>'
            );
        }
    }

    
    function toggleAdmissionDate(selectElement, dateDivId) {
        if ($(selectElement).val() === 'C') {
            $(dateDivId).show();
        } else {
            $(dateDivId).hide();
        }
    }

    $('#slcSituacao').on('change', function() {
        toggleAdmissionDate(this, '#campoAdmissao');
    });

    $('#slcSituacaoEdt').on('change', function() {
        toggleAdmissionDate(this, '#campoAdmissaoEdit');
    });

    $(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        var pagina = $(this).data('page');
        if (pagina !== paginaAtual) {
            paginaAtual = pagina;
            carregaColaborador(paginaAtual);
        }
    });



    $('#addColaboradorForm').on('submit', function(e) {
        e.preventDefault();

        // Validação dos campos
        var name = $('#txtNome').val();
        var email = $('#txtEmail').val();
        var status = $('#slcSituacao').val();

        if (!name || !email || !status) {
            Swal.fire({
                icon: 'error',
                title: 'Erro',
                text: 'Por favor, preencha todos os campos.'
            });
            return;
        }

        $.ajax({
            url: '/novo/colaborador',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                $('#addColaboradorModal').modal('hide');
                carregaColaborador(paginaAtual);
                Swal.fire({
                    icon: 'success',
                    title: 'Sucesso',
                    text: 'Usuário adicionado com sucesso.'
                });
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Erro',
                    text: 'Ocorreu um erro ao adicionar o usuário.'
                });
            }
        });
    });

    $(document).on('click', '.edit-btn', function(e) {
            e.preventDefault();

            var id = $(this).data('id');
            var nome = $(this).data('nome');
            var email = $(this).data('email');
            var situacao = $(this).data('situacao');
            var admissao = $(this).data('admissao');

            if(situacao === 'C'){
                $('#campoAdmissaoEdit').show();
            }

            $('#txtColaboradorId').val(id);
            $('#txtNomeEdt').val(nome);
            $('#txtEmailEdt').val(email);
            $('#slcSituacaoEdt').val(situacao);
            $('#txtAdmissaoEdt').val(admissao);

           
        });

        $('#editColaboradorForm').on('submit', function(e) {
            e.preventDefault();
            var id = $('#txtColaboradorId').val();
            $.ajax({
                url: '/editar/colaborador/'+id,
                type: 'POST',
                data: $(this).serialize(),
                
                success: function(response) {
                    $('#editColaboradorModal').modal('hide');
                    carregaColaborador(paginaAtual);
                    Swal.fire({
                        icon: 'success',
                        title: 'Sucesso',
                        text: 'Colaborador atualizado com sucesso.'
                    });
                },
                error : function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Erro',
                        text: 'Ocorreu um erro ao atualizar.'
                    });
                }
            });
        });




    $(document).on('click', '.delete-btn', function(e) {
        e.preventDefault();
        var href = $(this).attr('href');
        var row = $(this).closest('tr');
        Swal.fire({
            title: 'Tem certeza?',
            text: "Você não poderá reverter isso!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim, excluir!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: href,
                    type: 'DELETE',
                    data: href,
                    success: function(response) {
                        
                        row.remove();
                        Swal.fire(
                            'Excluído!',
                            'Usuário excluído com sucesso.',
                            'success'
                        );
                        carregaColaborador(paginaAtual)
                        row.remove();
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Erro',
                            text: 'Ocorreu um erro ao excluir o usuário.'
                        });
                    }
                });
            }
        });
});

$('#searchInput').on('keyup', function() {
    var value = $(this).val().toLowerCase();
    $("#colaboradorTable tbody tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

    $(document).on('hidden.bs.modal', '#addUserModal, #editUserModal', function () {
        $('.modal-backdrop').remove();
    });

carregaColaborador();
});

  
</script>