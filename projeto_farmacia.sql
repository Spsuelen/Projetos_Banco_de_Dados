-- drop database farmacia;
-- CRIANDO O BANCO DE DADOS FARMACIA
create database farmacia
default character set utf8mb4
default collate utf8mb4_general_ci;
use farmacia;
-- CRIANDO A TABELA ENDEREÇO
create table endereco(
cod_endereco int not null auto_increment primary key,
rua varchar (30),
numero int,
cep int,
cidade varchar(20),
bairro varchar(20),
uf varchar (20)
);
-- criando um procedimento para inserir as informações na tabela endereço
delimiter $$
create procedure sp_cadastro_endereco(rua varchar (30),numero int,cep
int,cidade varchar(20),bairro varchar(20),uf varchar (20))
begin

insert into endereco (rua,numero,cep,cidade,bairro,uf) values

(rua,numero,cep,cidade,bairro,uf);
end $$
delimiter ;
call sp_cadastro_endereco ('rua das ostras',170,69070100,'manaus','eldorado','AM');
select * from endereco;
-- CRIANDO A TABELA FARMACIA
create table farmacia(
id_farmacia int not null auto_increment primary key,
nome_farmacia varchar(30),
cnpj varchar (14)
);
-- criando um procedimento para inserir informações na tabela farmácia
delimiter $$
create procedure sp_cadastro_farmacia(nome_farmacia varchar(30), cnpj
varchar (14))
begin

insert into farmacia (nome_farmacia, cnpj) values

(nome_farmacia, cnpj);
end $$
delimiter ;
call sp_cadastro_farmacia ();
select * from farmacia;
-- CRIANDO A TABELA PESSOA
create table pessoa(

cpf_cnpj varchar(14) not null primary key,
tipo_pessoa enum ('CPF','CNPJ'),
nome_pessoa varchar (20),
sobrenome_pessoa varchar(40),
telefone_pessoa varchar(11),
telefone_whatsapp varchar(11),
cod_endereco int,
constraint fk1_cod_endereco
foreign key (cod_endereco)
references endereco (cod_endereco)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela pessoa
delimiter $$
create procedure sp_cadastro_pessoa(cpf_cnpj varchar(14),tipo_pessoa enum
('CPF','CNPJ'),nome_pessoa varchar (20),sobrenome_pessoa varchar(40),
telefone_pessoa varchar(11),telefone_whatsapp varchar(11),cod_endereco
int)
begin

insert into pessoa

(cpf_cnpj,tipo_pessoa,nome_pessoa,sobrenome_pessoa,
telefone_pessoa,telefone_whatsapp,cod_endereco) values
(cpf_cnpj,tipo_pessoa,nome_pessoa,sobrenome_pessoa,
telefone_pessoa,telefone_whatsapp,cod_endereco);
end $$
delimiter ;
SET foreign_key_checks = 0;
call sp_cadastro_pessoa ();
select * from pessoa;
-- CRIANDO A TABELA FORNECEDOR
create table fornecedor(
cod_fornecedor int not null auto_increment primary key,
inscricao_estadual varchar(9),
tipo_pessoa enum ('CPF','CNPJ'),
cpf_cnpj varchar(14),
cod_endereco int,
constraint fk2_cod_endereco
foreign key (cod_endereco)
references endereco (cod_endereco)
on delete cascade on update cascade,
constraint fk1_cpf_cnpj
foreign key (cpf_cnpj)
references pessoa (cpf_cnpj)
);
-- criando um procedimento para inserir as informações na tabela
fornecedor
delimiter $$
create procedure sp_cadastro_fornecedor(inscricao_estadual
varchar(9),tipo_pessoa enum ('CPF','CNPJ'),cpf_cnpj
varchar(14),cod_endereco int)

begin

insert into fornecedor

(inscricao_estadual,tipo_pessoa,cpf_cnpj,cod_endereco) values
(inscricao_estadual,tipo_pessoa,cpf_cnpj,cod_endereco);
end $$
delimiter ;
call sp_cadastro_fornecedor ();
select * from fornecedor;

-- CRIANDO A TABELA FUNCIONARIO
create table funcionario(
matricula_func int not null auto_increment primary key,
rg varchar(8),
tipo_pessoa enum ('CPF','CNPJ'),
cpf_cnpj varchar(14),
cod_endereco int,
constraint fk3_cod_endereco
foreign key (cod_endereco)
references endereco (cod_endereco)
on delete cascade on update cascade,
constraint fk2_cpf_cnpj
foreign key (cpf_cnpj)
references pessoa (cpf_cnpj)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela
funcionario
delimiter $$
create procedure sp_cadastro_funcionario(rg varchar(8),tipo_pessoa enum
('CPF','CNPJ'),cpf_cnpj varchar(14),cod_endereco int)
begin

insert into funcionario (rg,tipo_pessoa,cpf_cnpj,cod_endereco)

values (rg,tipo_pessoa,cpf_cnpj,cod_endereco);
end $$
delimiter ;
call sp_cadastro_funcionario ();
select * from funcionario;

-- CRIANDO A TABELA CLIENTE
create table cliente(
cod_cliente int not null auto_increment primary key,
dt_nascimento date,
tipo_pessoa enum ('CPF','CNPJ'),
cpf_cnpj varchar(14),
cod_endereco int,
constraint fk4_cod_endereco
foreign key (cod_endereco)
references endereco (cod_endereco)
on delete cascade on update cascade,
constraint fk3_cpf_cnpj

foreign key (cpf_cnpj)
references pessoa (cpf_cnpj)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela cliente
delimiter $$
create procedure sp_cadastro_cliente(dt_nascimento date,tipo_pessoa enum
('CPF','CNPJ'),cpf_cnpj varchar(14),cod_endereco int)
begin

insert into cliente

(dt_nascimento,tipo_pessoa,cpf_cnpj,cod_endereco) values
(dt_nascimento,tipo_pessoa,cpf_cnpj,cod_endereco);
end $$
delimiter ;
call sp_cadastro_cliente ();
select * from cliente;
-- CRIANDO A TABELA HISTÓRICO
create table historico(
cod_historico int not null auto_increment primary key,
dt_vencimento date,
valor decimal(6,2),
total_desconto decimal(6,2),
cod_cliente int,
constraint fk1_cod_cliente
foreign key (cod_cliente)
references cliente (cod_cliente)
on delete cascade on update cascade
);
-- CRIANDO UMA TRIGGER DE DESCONTO
create trigger desconto before insert
on historico
for each row
set new.total_desconto = (new.valor * 0.90);
-- criando um procedimento para inserir as informações na tabela
histórico
delimiter $$
create procedure sp_cadastro_historico(dt_vencimento date,valor
decimal(6,2),cod_cliente int)
begin

insert into historico (dt_vencimento,valor,cod_cliente) values

(dt_vencimento,valor,cod_cliente);
end $$
delimiter ;
call sp_cadastro_historico ();
select * from historico;

-- CRIANDO A TABELA MEDICAMENTO
create table medicamento (
cod_medicamento int not null auto_increment primary key,
dt_vencimento date,
ds_medicamento mediumtext,
categoria enum ('COMUM','CONTROLADO'),
cod_categoria enum ('001','002'),
cod_fornecedor int,
constraint fk1_cod_fornecedor
foreign key (cod_fornecedor)
references fornecedor (cod_fornecedor)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela
medicamento
delimiter $$
create procedure sp_cadastro_medicamento(dt_vencimento
date,ds_medicamento mediumtext,categoria enum ('COMUM','CONTROLADO'),
cod_categoria enum ('001','002'),cod_fornecedor int)
begin

insert into medicamento

(dt_vencimento,ds_medicamento,categoria,cod_categoria,cod_fornecedor)
values
(dt_vencimento,ds_medicamento,categoria,cod_categoria,cod_fornecedor);
end $$
delimiter ;
call sp_cadastro_medicamento ();
select * from medicamento;
-- CRIANDO A TABELA NOTA FISCAL DE ENTRADA
create table nota_fiscal_entrada(
nr_nf_entrada int not null auto_increment primary key,
valor_unitario decimal (6,2),
qtde_medicamento int,
tipo varchar (10),
matricula_func int,
cod_fornecedor int,
constraint fk2_cod_fornecedor
foreign key (cod_fornecedor)
references fornecedor (cod_fornecedor)
on delete cascade on update cascade,
constraint fk1_matricula_func
foreign key (matricula_func)
references funcionario (matricula_func)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela nota
fiscal de entrada
delimiter $$

create procedure sp_cadastro_nf_entrada(valor_unitario decimal
(6,2),qtde_medicamento int,tipo varchar (10),matricula_func
int,cod_fornecedor int)
begin

insert into nota_fiscal_entrada

(valor_unitario,qtde_medicamento,tipo,matricula_func,cod_fornecedor)
values
(valor_unitario,qtde_medicamento,tipo,matricula_func,cod_fornecedor);
end $$
delimiter ;
call sp_cadastro_nf_entrada ();
select * from nota_fiscal_entrada;
-- CRIANDO A TABELA ESTOQUE
create table estoque (
cod_estoque int not null auto_increment primary key,
cod_medicamento int,
valor_unitario decimal (6,2),
constraint fk1_cod_medicamento
foreign key (cod_medicamento)
references medicamento (cod_medicamento)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela estoque
delimiter $$
create procedure sp_cadastro_estoque(cod_medicamento int,valor_unitario
decimal (6,2))
begin

insert into estoque (cod_medicamento,valor_unitario) values

(cod_medicamento,valor_unitario);
end $$
delimiter ;
call sp_cadastro_estoque();
select * from estoque;
-- CRIANDO A TABELA PAGAMENTO
create table pagamento(
cod_pagamento int not null auto_increment primary key,
ds_pagamento mediumtext,
valor decimal (6,2),
nr_parcela int,
cod_cliente int,
constraint fk2_cod_cliente
foreign key (cod_cliente)
references cliente (cod_cliente)
on delete cascade on update cascade
);

-- criando um procedimento para inserir as informações na tabela
pagamento
delimiter $$
create procedure sp_cadastro_pagamento(ds_pagamento mediumtext,valor
decimal (6,2),nr_parcela int,cod_cliente int)
begin

insert into pagamento

(ds_pagamento,valor,nr_parcela,cod_cliente) values
(ds_pagamento,valor,nr_parcela,cod_cliente);
end $$
delimiter ;
call sp_cadastro_pagamento();
select * from pagamento;
-- CRIANDO A TABELA NOTA FISCAL DE SAÍDA
create table nota_fiscal_saida(
nr_nf_saida int not null auto_increment primary key,
qtde_medicamento int,
tipo varchar (10),
cod_cliente int,
tipo_pessoa enum ('CPF','CNPJ'),
cpf_cnpj varchar(14),
nome_pessoa varchar (20),
cod_pagamento int,
valor decimal (6,2),
valor_total decimal (6,2),
dt_venda date,
id_farmacia int,
nome_farmacia varchar(30),
cnpj varchar (14),
constraint fk3_cod_pagamento
foreign key (cod_pagamento)
references pagamento (cod_pagamento)
on delete cascade on update cascade,
constraint fk3_cod_cliente
foreign key (cod_cliente)
references cliente (cod_cliente)
on delete cascade on update cascade,
constraint fk1_id_farmacia
foreign key (id_farmacia)
references farmacia (id_farmacia)
on delete cascade on update cascade
);
-- CRIANDO UMA TRIGGER PARA O DESCONTO NA NOTA FISCAL DE SAIDA
create trigger desconto_nf_saida before insert
on nota_fiscal_saida
for each row
set new.valor_total = (new.valor * 0.90);
-- criando um procedimento para inserir as informações na tabela
nota_fiscal_saida

delimiter $$
create procedure sp_cadastro_nf_saida(qtde_medicamento int,tipo varchar
(10),cod_cliente int,tipo_pessoa enum ('CPF','CNPJ'),cpf_cnpj
varchar(14),nome_pessoa varchar (20),cod_pagamento int,
valor decimal (6,2),dt_venda date,id_farmacia int,nome_farmacia
varchar(30),cnpj varchar (14))
begin

insert into nota_fiscal_saida

(qtde_medicamento,tipo,cod_cliente,tipo_pessoa,cpf_cnpj,nome_pessoa,cod_p
agamento,
valor,dt_venda,id_farmacia,nome_farmacia,cnpj) values
(qtde_medicamento,tipo,cod_cliente,tipo_pessoa,cpf_cnpj,nome_pessoa,cod_p
agamento,
valor,dt_venda,id_farmacia,nome_farmacia,cnpj);
end $$
delimiter ;
call sp_cadastro_nf_saida();
select * from nota_fiscal_saida;
-- CRIANDO A TABELA DE COMPRAS ENTRE A NOTA FISCAL DE ENTRADA E SEUS
MEDICAMENTOS
create table compra_nf_entrada_e_medicamento(
valor_total decimal (10,2),
dt_compra date,
nr_nf_entrada int,
cod_medicamento int,
constraint fk2_cod_medicamento
foreign key (cod_medicamento)
references medicamento (cod_medicamento)
on delete cascade on update cascade,
constraint fk1_nr_nf_entrada
foreign key (nr_nf_entrada)
references nota_fiscal_entrada (nr_nf_entrada)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela de
compras entre nota fiscal de entrada e seus medicamentos
delimiter $$
create procedure sp_cadastro_compra_nf_entrada_e_medicamento(valor_total
decimal (10,2),dt_compra date,nr_nf_entrada int,cod_medicamento int)
begin

insert into compra_nf_entrada_e_medicamento
(valor_total,dt_compra,nr_nf_entrada,cod_medicamento) values
(valor_total,dt_compra,nr_nf_entrada,cod_medicamento);
end $$
delimiter ;
call sp_cadastro_compra_nf_entrada_e_medicamento();
select * from compra_nf_entrada_e_medicamento;
-- CRIANDO A TABELA QUE EXIBE NA NOTA FISCAL DE SAIDA SEUS MEDICAMENTOS

create table nf_saida_exibe_na_venda__medicamento(
valor_total decimal (10,2),
dt_compra date,
nr_nf_saida int,
cod_medicamento int,
constraint fk3_cod_medicamento
foreign key (cod_medicamento)
references medicamento (cod_medicamento)
on delete cascade on update cascade,
constraint fk1_nr_nf_saida
foreign key (nr_nf_saida)
references nota_fiscal_saida (nr_nf_saida)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela de
compras entre nota fiscal de saida e seus medicamentos
delimiter $$
create procedure
sp_cadastro_nf_saida_exibe_na_venda_medicamento(valor_total decimal
(10,2),dt_compra date,nr_nf_saida int,cod_medicamento int)
begin

insert into nf_saida_exibe_na_venda__medicamento
(valor_total,dt_compra,nr_nf_saida,cod_medicamento) values
(valor_total,dt_compra,nr_nf_saida,cod_medicamento);
end $$
delimiter ;
call sp_cadastro_nf_saida_exibe_na_venda__medicamento;
select * from nf_saida_exibe_na_venda__medicamento;
-- CRIANDO A TABELA QUE EXIBE A MOVIMENTAÇÃO DE COMPRA ENTRE A NOTA
FISCAL DE ENTRADA E SEU ESTOQUE
create table movimentacao_compra_nf_entrada_e_estoque(
dt_movimentacao date,
nr_nf_entrada int,
cod_estoque int,
constraint fk2_cod_estoque
foreign key (cod_estoque)
references estoque (cod_estoque)
on delete cascade on update cascade,
constraint fk3_nr_nf_entrada
foreign key (nr_nf_entrada)
references nota_fiscal_entrada (nr_nf_entrada)
on delete cascade on update cascade
);
-- criando um procedimento para inserir as informações na tabela de
compras entre nota fiscal de entrada e seu estoque
delimiter $$
create procedure movimentacao_compra_nf_entrada_e_estoque(dt_movimentacao
date,nr_nf_entrada int,cod_estoque int)
begin

insert into movimentacao_compra_nf_entrada_e_estoque

(dt_movimentacao,nr_nf_entrada,cod_estoque) values
(dt_movimentacao,nr_nf_entrada,cod_estoque);
end $$
delimiter ;
call sp_cadastro_movimentacao_compra_nf_entrada_e_estoque;
select * from movimentacao_compra_nf_entrada_e_estoque;

-- CRIANDO USUÁRIOS DE ACESSO.

-- vizualizando os usuários existentes no sistema
select user,host from mysql.user;
-- criando o usuário farmADM
create user 'farmADM'@'%' identified by '123';
-- usuário farmADM com permissão DBA
grant all privileges on *.* to 'farmADM'@'%' with grant option;
grant delete on farmacia.estoque to 'farmADM'@'%';
FLUSH PRIVILEGES;

-- criando o usuário farmBD
create user 'farmBD'@'%' identified by '456';
-- usuário com permissão total da base de dados
grant all privileges on *.* to 'farmBD'@'%';
grant delete on farmacia.estoque to 'farmBD'@'%';
FLUSH PRIVILEGES;

-- criando o usuário farmREL
create user 'farmREL'@'%' identified by '789';
-- usuário com permissão de select em todas as tabelas da base de dados
grant select on *.* to 'farmREL'@'%';
grant delete on farmacia.estoque to 'farmREL'@'%';
FLUSH PRIVILEGES;
-- vizualizar os privilégios dos usuários
show grants for farmADM;show grants for farmBD;show grants for
farmREL;
-- Lista de permissões que os usuários possuem
select * from mysql.user where user ='farmADM';
select * from mysql.user where user ='farmBD';
select * from mysql.user where user ='farmREL';
-- removendo permissão de deletar nos usuários
revoke delete on estoque from 'farmADM'@'%','farmBD'@'%','farmREL'@'%';
-- vizualizar os privilégios dos usuários
show grants for farmADM;show grants for farmBD;show grants for
farmREL;