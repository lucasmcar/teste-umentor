
<div class="container">
    <h2>{{ $title }}</h2>

    <button type="button" class="btn btn-primary add-btn" id="add-btn" data-bs-toggle="modal" data-bs-target="#addUserModal">
        Adicionar Usuário
    </button>

    <hr>
    <table class="table table-striped mt-3" id="userTable">
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
<div class="modal fade" id="addColaboradorModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addColaboradorModalLabel">Adicionar Usuário</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addColaborForm" method="POST">
                    <div class="form-group mb-3">
                        <label for="txtNome">Nome</label>
                        <input type="text" class="form-control" id="txtNome" name="nome" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="txtEmail">Email</label>
                        <input type="text" class="form-control" id="txtEmail" name="email" >
                    </div>
                    <input type="hidden" name="cadastrado" value="<?php echo date('Y-m-d H:i:s'); ?>">
                    <div class="form-group mb-3">
                        <label for="slcSituacao">Situação</label>
                        <select class="form-select" name="situacao" aria-label="Default select example" id="slcSituacao">
                            <option selected value="">Situação</option>
                            <option value="T">Em Teste</option>
                            <option value="C">Contratado</option>
                            <option value="D">Demitido</option>
                        </select>
                    </div>
                    <div class="form-group mb-3">
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
                        <input type="text" class="form-control" id="txtNomeedt" name="nome" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="txtEmail">Email</label>
                        <input type="text" class="form-control" id="txtEmailEdt" name="email" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="slcSituacao">Situação</label>
                        <select class="form-select" name="situacao" aria-label="Default select example" id="slcSituacaoEdt">
                            <option selected value="">Situação</option>
                            <option value="T">Em Teste</option>
                            <option value="C">Contratado</option>
                            <option value="D">Demitido</option>
                        </select>
                    </div>
                    <div class="form-group mb-3">
                        <label for="txtAdmissao">Data de Admissão</label>
                        <input type="text" class="form-control" id="txtAdmissao" name="admissao" >
                    </div>
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


$(document).on('click', '.add-btn', function() {
    var addColaboradorModal = new bootstrap.Modal(document.getElementById('addColaboradorModal'));
    addColaboradorModal.show();
});

$(document).on('click', '.edit-btn', function() {
    var editColaboradorModal = new bootstrap.Modal(document.getElementById('editColaboradorModal'));
    editColaboradorModal.show();
});


$(document).ready(function() {

    $('#add-btn').on('click', function(){
        $('#addColaboradorModal').modal('show');
    })
    
    // Exemplo de abrir o modal ao clicar em um botão
    $('#edit-btn').on('click', function() {
        $('#addColaboradorModal').modal('show');
    });

    var paginaAtual = 1;
    var limite = 10;
    // Função para carregar os dados dos usuários na tabela
    function carregaColaborador(pagina = 1) {
        $.ajax({
            url: '/list', // URL do script PHP que retorna os dados dos usuários
            data: {
                pagina: pagina,
                limite: limite
            },
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log($('#total_results'));
                var userTable = $('#userTable tbody');
                userTable.empty(); // Limpa a tabela
                $.each(response['dados'], function(index, colaborador) {
                    
                    if(colaborador.situacao == 'T'){
                        colaborador.situacao = 'Em teste';
                    } else if(colaborador.situacao == 'D'){
                        colaborador.situacao = 'Demitido';
                    } else {
                        colaborador.situacao = 'Contratado';
                    }
                    
                    userTable.append('<tr><td>' + colaborador.id + 
                        '</td><td>' + colaborador.nome + 
                        '</td><td>' + colaborador.email + 
                        '</td><td>' + colaborador.situacao + 
                        '</td><td>' + colaborador.admissao + 
                        '</td><td>' + colaborador.cadastro +
                        '</td><td>' + colaborador.atualizacao +
                        '</td><td><a href="/editar/colaborador/'+colaborador.id+'" id="edit-btn" class="edit-btn"><span class="material-symbols-outlined" style="color: yellow;">edit</span></a>'+
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
        var paginacao = $('#pagination');
        paginacao.empty();

        if (totalPaginas > 1) {
            for (var i = 1; i <= totalPaginas; i++) {
                paginacao.append(
                    '<li class="page-item ' + (i === pagina ? 'active' : '') + '">' +
                        '<a class="page-link" href="#" data-page="' + i + '">' + i + '</a>' +
                    '</li>'
                );
            }
        }
    }

    // Chama a função para carregar os dados dos usuários quando a página é carregada
    

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
                $('#addUserModal').modal('hide');
               
                Swal.fire({
                    icon: 'success',
                    title: 'Sucesso',
                    text: 'Usuário adicionado com sucesso.'
                });
                carregaColaborador(paginaAtual);
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
            var userId = $(this).data('id');
            var userName = $(this).data('name');
            $('#editName').val(userName);
            $('#editUserId').val(userId);
            var editUserModal = new bootstrap.Modal(document.getElementById('editUserModal'));
            editUserModal.show();
        });

        $('#editColaboradorForm').on('submit', function(e) {
            e.preventDefault();
            $.ajax({
                url: '/editar/colaborador',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#editUserModal').modal('hide');
                    loadUsers(currentPage);
                    alert('Usuário editado com sucesso.');
                }
            });
        });




    $(document).on('click', '.delete-btn', function(e) {
        e.preventDefault();
        var href = $(this).attr('href');
        var row = $(this).closest('tr');
        console.log(href);
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
carregaColaborador();
});

  
</script>