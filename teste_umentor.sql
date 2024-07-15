create database teste_umentor_db;

create table colaborador(
	id int not null primary key auto_increment,
    nome varchar(150) not null,
    email varchar(150) not null,
    situacao enum('T', 'C', 'D'),
    admissao datetime,
    cadastro datetime,
    atualizacao datetime
);