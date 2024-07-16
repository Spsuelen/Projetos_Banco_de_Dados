create database servico_companhia_aerea;
use servico_companhia_aerea;


-- CRIANDO A TABELA COMPANHIA

create table companhia(
cod_companhia int not null auto_increment primary key,
nome_companhia varchar(50),
cnpj varchar (14)
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA COMPANHIA

delimiter $$
create procedure sp_cadastro_companhia(nome varchar(80),cnpj varchar(20))
begin
	insert into companhia (nome_companhia,cnpj) values ( nome,cnpj);
end $$
delimiter ;

call sp_cadastro_companhia('Americanas','00394460005887');
call sp_cadastro_companhia('Azul','12344460001452');

select * from companhia;

-- CRIANDO A TABELA AVIÃO

create table aviao(
cod_aviao int auto_increment not null primary key,
numero_serie varchar(14) unique, 
modelo varchar(20),
qtde_total_assentos int,
cod_companhia int,
constraint fk1_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia)
);

-- CRIANDO A PROCEDURE PARA A INSERÇÃO DE INFORMAÇÕES NA TABELA AVIÃO

delimiter $$
create procedure sp_cadastro_aviao(numero varchar (14),modelo varchar(20),qtde int,cod int)
begin
	insert into aviao (numero_serie,modelo,qtde_total_assentos,cod_companhia ) values
    (numero,modelo,qtde,cod);
end $$
delimiter ;

call sp_cadastro_aviao('ABC-A29B5953','Airbus A350',350,1);
call sp_cadastro_aviao('DEF-B29B7374','Boeing 737 ',200,1);
call sp_cadastro_aviao('GHI-C29B5164','Airbus A320',350,2);

select * from aviao;

-- CRIANDO A TABELA DE ASSENTOS DISPONIVEIS

create table assentos_disponiveis (
cod_assento int not null auto_increment primary key,
nome_assento varchar(14),
cod_companhia int,
cod_aviao int,
constraint fk2_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia),
constraint fk1_cod_aviao
foreign key (cod_aviao)
references aviao (cod_aviao)
);

-- CRIANDO A PROCEDURE  CADASTRO DE ASSENTOS PARA INSERIR INFORMAÇÕES EM ASSENTOS DISPONIVEIS

delimiter $$
create procedure sp_cadastro_assento (assento varchar(14),cod_companhia int,cod_aviao int)
begin 
	insert into assentos_disponiveis (nome_assento,cod_companhia,cod_aviao)
    values (assento,cod_companhia,cod_aviao);
end $$
delimiter ;

call sp_cadastro_assento ('1AMEIO',1,1);call sp_cadastro_assento ('1AMEIO',1,2);call sp_cadastro_assento ('1AMEIO',2,3);
call sp_cadastro_assento ('2BMEIO',1,1);call sp_cadastro_assento ('2BMEIO',1,2);call sp_cadastro_assento ('2BMEIO',2,3);
call sp_cadastro_assento ('3CMEIO',1,1);call sp_cadastro_assento ('3CMEIO',1,2);call sp_cadastro_assento ('3CMEIO',2,3);
call sp_cadastro_assento ('4DJANELAD',1,1);call sp_cadastro_assento ('4DJANELAD',1,2);call sp_cadastro_assento ('4DJANELAD',2,3);
call sp_cadastro_assento ('5EJANELAD',1,1);call sp_cadastro_assento ('5EJANELAD',1,2);call sp_cadastro_assento ('5EJANELAD',2,3);
call sp_cadastro_assento ('6FJANELAD',1,1);call sp_cadastro_assento ('6FJANELAD',1,2);call sp_cadastro_assento ('6FJANELAD',2,3);
call sp_cadastro_assento ('7GJANELAE',1,1);call sp_cadastro_assento ('7GJANELAE',1,2);call sp_cadastro_assento ('7GJANELAE',2,3);
call sp_cadastro_assento ('8HJANELAE',1,1);call sp_cadastro_assento ('8HJANELAE',1,2);call sp_cadastro_assento ('8HJANELAE',2,3);
call sp_cadastro_assento ('9IJANELAE',1,1);call sp_cadastro_assento ('9IJANELAE',1,2);call sp_cadastro_assento ('9IJANELAE',2,3);
call sp_cadastro_assento ('10JCORREDOR',1,1);call sp_cadastro_assento ('10JCORREDOR',1,2);call sp_cadastro_assento ('10JCORREDOR',2,3);

select * from assentos_disponiveis;

-- CRIANDO A TABELA DE AEROPORTOS

create table aeroportos (
cod_aeroporto int not null auto_increment primary key,
nome_aeroporto varchar(20),
estado varchar(2),
nacionalidade varchar(2),
cod_companhia int,
cod_aviao int,
constraint fk3_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia),
constraint fk2_cod_aviao
foreign key (cod_aviao)
references aviao (cod_aviao)
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA AEROPORTOS

delimiter $$
create procedure sp_cadastro_aeroporto (nome_aeroporto varchar(14),estado varchar(2),nacionalidade varchar(2),cod_companhia int,cod_aviao int)
begin 
	declare nacionalidade varchar (2) default 'BR';
	insert into aeroportos (nome_aeroporto,estado,nacionalidade,cod_companhia,cod_aviao)
    values (nome_aeroporto,estado,nacionalidade,cod_companhia,cod_aviao);
end $$
delimiter ;



call sp_cadastro_aeroporto('EDUARDINHO III','AM',NULL,1,1);call sp_cadastro_aeroporto('EDUARDINHO III','AM',NULL,1,2);call sp_cadastro_aeroporto('EDUARDINHO III','AM',NULL,2,3);
call sp_cadastro_aeroporto('SANTOS DUMOND','RJ',NULL,1,1);call sp_cadastro_aeroporto('SANTOS DUMOND','RJ',NULL,1,2);call sp_cadastro_aeroporto('SANTOS DUMOND','RJ',NULL,2,3);
call sp_cadastro_aeroporto('CONGONHAS','SP',NULL,1,1);call sp_cadastro_aeroporto('CONGONHAS','SP',NULL,1,2);call sp_cadastro_aeroporto('CONGONHAS','SP',NULL,2,3);call sp_cadastro_aeroporto('SANTOS DUMOND','RJ',NULL,2,3);
call sp_cadastro_aeroporto('ALTAMIRA','PA',NULL,1,1);call sp_cadastro_aeroporto('ALTAMIRA','PA',NULL,1,2);call sp_cadastro_aeroporto('ALTAMIRA','PA',NULL,2,3);
call sp_cadastro_aeroporto('ILHEUS','BA',NULL,1,1);call sp_cadastro_aeroporto('ILHEUS','BA',NULL,1,2);call sp_cadastro_aeroporto('ILHEUS','BA',NULL,2,3);
call sp_cadastro_aeroporto('ARAGUACEMA','TO',NULL,1,1);call sp_cadastro_aeroporto('ARAGUACEMA','TO',NULL,1,2);call sp_cadastro_aeroporto('ARAGUACEMA','TO',NULL,2,3);
call sp_cadastro_aeroporto('GOIANANOPOLIS','GO',NULL,1,1);call sp_cadastro_aeroporto('GOIANANOPOLIS','GO',NULL,1,1);call sp_cadastro_aeroporto('GOIANANOPOLIS','GO',NULL,2,3);
call sp_cadastro_aeroporto('SOBRAL','CE',NULL,1,1);call sp_cadastro_aeroporto('SOBRAL','CE',NULL,1,2);call sp_cadastro_aeroporto('SOBRAL','CE',NULL,2,3);

SELECT * FROM aeroportos;

-- CRIANDO A TABELA DE LOCAIS DISPONIVEIS PARA VIAGEM

create table locais_disponiveis(
cod_locais int not null auto_increment primary key,
cidade varchar(20),
estado varchar (2),
cod_companhia int,
constraint fk4_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia)
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA DE LOCAIS DISPONIVEIS PARA VIAGEM

delimiter $$
create procedure sp_cadastro_locais ( cidade varchar(20),estado varchar(20),cod int)
begin
	insert into locais_disponiveis(cidade,estado,cod_companhia) values (cidade,estado,cod);
end $$
delimiter ;

call sp_cadastro_locais ('MANAUS','AM',1);call sp_cadastro_locais ('MANAUS','AM',2);
call sp_cadastro_locais ('SÃO PAULO','SP',1);call sp_cadastro_locais ('SÃO PAULO','SP',2);
call sp_cadastro_locais ('RIO DE JANEIRO','RJ',1);call sp_cadastro_locais ('RIO DE JANEIRO','RJ',2);
call sp_cadastro_locais ('BELÉM','PA',1);call sp_cadastro_locais ('BELEM','PA',2);
call sp_cadastro_locais ('BAHIA','BA',1);call sp_cadastro_locais ('BAHIA','BA',2);
call sp_cadastro_locais ('TOCANTINS','TO',1);call sp_cadastro_locais ('TOCANTIS','TO',2);
call sp_cadastro_locais ('GOIAS','GO',1);call sp_cadastro_locais ('GOIAS','GO',2);
call sp_cadastro_locais ('CEARÁ','CE',1);call sp_cadastro_locais ('CEARÁ','CE',2);

select * from locais_disponiveis;

-- CRIANDO A TABELA BAIRRO

create table bairro(
cod_bairro int not null auto_increment primary key,
nome_bairro varchar (50),
uf varchar(30),
pais varchar( 50)
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA BAIRRO

delimiter $$
create procedure sp_cadastro_bairro(nome varchar (50),uf varchar(30),pais varchar(50))
begin
	declare uf varchar (30) default 'AM';
	declare pais varchar(50) default 'BRASIL';
		insert into bairro (nome_bairro,uf,pais) values ( nome,uf,pais);
end $$
delimiter ;

call sp_cadastro_bairro('cidade nova',NULL,NULL);
call sp_cadastro_bairro('centro',NULL,NULL);
call sp_cadastro_bairro('flores',NULL,NULL);
call sp_cadastro_bairro('Tarumã',NULL,NULL);

select * from bairro;


-- CRIANDO A TABELA DEPARTAMENTO

create table departamento (
cod_departamento int not null auto_increment primary key,
nome_setor varchar (80),
cod_companhia int,
constraint fk5_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia)
on delete cascade
on update cascade
 );
 
 -- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA DEPARTAMENTO
 
 delimiter $$
 create procedure sp_cadastro_departamento ( nome varchar(80),cod int)
 begin
		insert into departamento (nome_setor,cod_companhia) value (nome,cod);
end $$
delimiter ;

call sp_cadastro_departamento ('administrativo',1);
call sp_cadastro_departamento ('financeiro',1);
call sp_cadastro_departamento ('comissários',1);
call sp_cadastro_departamento ('pilotos',1);
call sp_cadastro_departamento ('comerciais',1);
call sp_cadastro_departamento ('TI',1);

select * from departamento;

-- CRIANDO A TABELA FUNCIONARIO

create table funcionario(
cod_funcionario int not null auto_increment primary key,
nome_funcionario varchar(20),
sobrenome_funcionario varchar(40),
cpf varchar(11) unique,
telefone varchar (11),
cargo varchar (50),
salario decimal(10,2),
admissao date,
rua_funcionario varchar(80),
numero_funcionario int,
cep varchar( 8),
nome_bairro varchar(20),
cod_bairro int ,
cod_departamento int,
cod_companhia int,
constraint fk6_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia)
on delete cascade
on update cascade,
constraint fk1_cod_bairro
foreign key (cod_bairro)
references bairro (cod_bairro)
on delete cascade
on update cascade,
constraint fk1_cod_departamento
foreign key (cod_departamento)
references departamento (cod_departamento)
on delete cascade
on update cascade
);


-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA FUNCIONÁRIO

delimiter $$
create procedure sp_cadastro_funcionario(nome varchar(80),sobrenome varchar(40),cpf varchar(11),telefone varchar(11),cargo varchar(50),salario decimal(10,2),admissao date,rua varchar(80),numero int,cep varchar (8),nome_bairro varchar(20),cod_bairro int,cod int,cod_c int)
begin
		insert into funcionario(nome_funcionario,sobrenome_funcionario,cpf,telefone,cargo,salario,admissao,rua_funcionario,numero_funcionario,cep,nome_bairro,cod_bairro,cod_departamento,cod_companhia) values
        (nome,sobrenome,cpf,telefone,cargo,salario,admissao,rua,numero,cep,nome_bairro,cod_bairro,cod,cod_c);
end $$
delimiter ;


call sp_cadastro_funcionario('mario jorge','almeida','01569325877','92984067987','auxiliar administrativo',3500.00,'2015-06-20','rua acre',10,
'69070500','cidade nova',1,1,1);
call sp_cadastro_funcionario('ana lucia','carvalho','01396245688','92991426300','Analista de sistemas',5000.00,'2000-01-02','rua maceio',170,
'69070001','centro',2,6,1);
call sp_cadastro_funcionario('celia','de souzaz lopes','04789632533','92994852011','auxiliar contabil',1500.00,'2023-02-15','rua tiradentes',05,
'69070410','flores',3,2,1);
call sp_cadastro_funcionario('pedro lucas','gomes','02396287455','92998746989','comissária',8000.00,'2022-01-03','rua crespo',170,
'69070501','centro',2,3,1);
call sp_cadastro_funcionario('afonso henrique','silva sousa','05289632577','92998748985','comissário',8000.00,'2022-01-15','rua ipiranga',135,
'69070700','tarumã',4,3,2);
call sp_cadastro_funcionario('milena','tavares','05533904755','92996014879','comissária',8000.00,'2023-02-05','rua das graças',23,
'69070700','flores',3,3,1);
call sp_cadastro_funcionario('silvia regina','lima','08596325877','92999748989','piloto',10000.00,'2022-01-30','rua divino',02,
'69070999','centro',2,4,1);
call sp_cadastro_funcionario('pedro matheus','miranda correia','08877412300','92994068978','piloto',10000.00,'2023-04-12','rua azul',52,
'69070100','centro',2,4,2);
 call sp_cadastro_funcionario('talita','medeiros','08965233333','92993996688','comercial',2000.00,'2015-08-06','rua das profecias',09,
'69070922','cidade nova',1,5,1);
call sp_cadastro_funcionario('alice','matias garcia','07741230255','92993665578','comercial',2000.00,'2017-03-02','rua amaral',53,
'69070101','flores',3,5,2);

select * from funcionario;

 -- CRIANDO A TABELA PASSAGEIRO

create table passageiro (
cod_passageiro int not null auto_increment primary key,
nome_passageiro varchar(20),
sobrenome_passageiro varchar(40),
rg varchar(8) unique,
cpf varchar(11),
data_nascimento date,
telefone varchar (11),
email varchar(30),
nacionalidade varchar(20)
);


-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DE INFORMAÇÃO NA TABELA PASSAGEIRO

delimiter $$
create procedure sp_cadastro_passageiro (nome varchar (20),sobrenome varchar(40),rg varchar(8),cpf varchar (11),data_nascimento date,telefone varchar(11),email varchar(30),nacionalidade varchar(20))
begin
	declare nacionalidade varchar(20) default 'BRASIL';
	insert into passageiro (nome_passageiro,sobrenome_passageiro,rg,cpf,data_nascimento,telefone,email,nacionalidade) values
	(nome,sobrenome,rg,cpf,data_nascimento,telefone,email,nacionalidade);
end $$
delimiter ;

call sp_cadastro_passageiro('antonio carlos','de alcantara','23278086','03369985211','2000-02-09','92984035689','carlos@gmail.com',null);
call sp_cadastro_passageiro('jose','medeiros rocha','27235087','04596312544','2002-10-24','92991423366','jose01@gmail.com',null);
call sp_cadastro_passageiro('monique','de sa','25741239','03369985211','1975-04-02','92984035689','monique95@gmail.com',null);
call sp_cadastro_passageiro('manuela ','paes santos','26870005','06698788844','1994-09-27','92984038888','manu@gmail.com',null);
call sp_cadastro_passageiro('juliana ','costa marques','21256379','04152369877','2003-01-15','92991758022','juliana@gmail.com',null);
call sp_cadastro_passageiro('mauricio','coelho pereira','23669874','08596314755','2002-03-19','92996428033','mauricio01@gmail.com',null);
call sp_cadastro_passageiro('miguel junior','oliveira ramos','23877776','08574136988','1960-02-09','92996778016','juniormiguel@gmail.com',null);
call sp_cadastro_passageiro('junior','fonseca','23888888','08555555555','1980-08-20','92996778016','junior@gmail.com',null);
call sp_cadastro_passageiro('priscila maria ','goes','23297076','05566974135','1999-07-27','92982438077','mariap@gmail.com',null);

select * from passageiro;

-- CRIANDO A TABELA DE PASSAGEIROS DEPENDENTES

create table passageiro_dependente(
nome_dependente varchar (20),
sobrenome varchar(40),
rg varchar (8),
data_nascimento date,
nacionalidade varchar(20),
sexo varchar(1),
cod_passageiro int unique,
constraint fk1_cod_passageiro
foreign key (cod_passageiro)
references passageiro (cod_passageiro)
on update cascade
on delete cascade
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA DE DEPENDENTES DO PASSAGEIRO

delimiter $$ 
create procedure sp_cadastro_passageiro_dependente (nome_dependente varchar (20),sobrenome varchar(40),rg varchar (8),data_nascimento date,nacionalidade varchar(20),sexo varchar(1),cod_passageiro int)
begin
    declare nacionalidade varchar (20) default 'BRASIL';
	insert into passageiro_dependente (nome_dependente,sobrenome,rg,data_nascimento,nacionalidade,sexo,cod_passageiro)
    values (nome_dependente,sobrenome,rg,data_nascimento,nacionalidade,sexo,cod_passageiro);
end $$
delimiter ;

call sp_cadastro_passageiro_dependente();
-- CRIANDO A TABELA DE VALORES DE PASSAGEM

create table valor_passagem(
id_valor int not null auto_increment primary key,
valor_economico decimal (10,2),
valor_executivo decimal (10,2),
cod_companhia int,
constraint fk7_cod_companhia 
foreign key (cod_companhia)
references companhia (cod_companhia)
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DE INFORMAÇÃO EM VALOR_PASSAGEM
delimiter $$
create procedure sp_cadastra_valores(valor_economico decimal (10,2),valor_executivo decimal (10,2),cod_companhia int)
begin
	insert into valor_passagem (valor_economico,valor_executivo,cod_companhia) values (valor_economico,valor_executivo,cod_companhia);
end $$
delimiter ;

call sp_cadastra_valores(1500.00,3000.00,1);
call sp_cadastra_valores(1500.00,3000.00,2);

select * from valor_passagem;


-- CRIANDO A TABELA COMPRA DE PASSAGEM

create table compra_passagem (
cod_passagem int not null auto_increment primary key,
origem varchar(20),
origem_data date,
destino varchar (20),
destino_volta date,
pais varchar(30),
assento varchar (20),
quantidade_assento int ,
assento_dependente varchar (20) default '0',
status_assento varchar(15),
classe varchar(20),
pagamento varchar(10),
cod_companhia int,
cod_aviao int ,
cod_assento int unique,
tipo_compra varchar (20),
cod_passageiro int,
id_valor int,
valor decimal (10,2),
constraint fk8_cod_companhia
foreign key (cod_companhia)
references companhia (cod_companhia)
on delete cascade
on update cascade,
constraint fk3_cod_aviao
foreign key (cod_aviao)
references aviao (cod_aviao)
on delete cascade
on update cascade,
constraint fk1_cod_assento
foreign key (cod_assento)
references assentos_disponiveis (cod_assento)
on delete cascade
on update cascade,
constraint fk2_cod_passageiro
foreign key (cod_passageiro)
references passageiro (cod_passageiro)
on delete cascade
on update cascade,
constraint fk1_id_valor
foreign key (id_valor)
references valor_passagem (id_valor)
on delete cascade
on update cascade
);

-- CRIANDO UMA TRIGGER PARA VERIFICAR O STATUS OCUPADO/LIVRE DE UM ASSENTO
 
 create trigger verificar_assento before insert
on compra_passagem
for each row
set new.status_assento ='INDISPONÍVEL';


-- CRIANDO A PROCEDURE PARA INSERÇÃO DE COMPRA DE PASSAGEM

delimiter $$
create procedure sp_cadastra_compra_passagem (origem varchar(20),origem_data date,destino varchar (20),destino_volta date,pais varchar(30),assento varchar (10),quantidade_assento int ,assento_dependente varchar (20),classe varchar(20),
pagamento varchar(10),cod_companhia int,cod_aviao int,cod_assento int,tipo_compra varchar(20),cod_passageiro int,id_valor int,valor decimal (10,2))
begin
	declare pais varchar(20) default 'BRASIL';
    declare classe varchar(20) default 'ECONOMICA';
    declare tipo_compra varchar(20) default 'ONLINE';
    declare assento_dependente varchar (20) default '0';
    declare valor decimal (10,2) default 1500.00;
    insert into compra_passagem(origem ,origem_data,destino,destino_volta,pais,assento,quantidade_assento,assento_dependente,classe,
pagamento,cod_companhia,cod_aviao,cod_assento,tipo_compra,cod_passageiro,id_valor,valor) 
    values (origem ,origem_data,destino,destino_volta,pais,assento,quantidade_assento,assento_dependente,classe,
pagamento,cod_companhia,cod_aviao,cod_assento,tipo_compra,cod_passageiro,id_valor,valor);
end $$
delimiter ;

call sp_cadastra_compra_passagem ('MANAUS','2023-04-10','RIO DE JANEIRO','2023-04-30',null,'3CMEIO',1,null,null,'pix',1,2,8,null,1,1,null);
call sp_cadastra_compra_passagem ('SÃO PAULO','2023-04-15','BAHIA','2023-04-17',null,'1AMEIO',1,null,null,'pix',1,1,1,NULL,2,1,null);
call sp_cadastra_compra_passagem ('TOCANTINS','2023-04-10','GOIAS','2023-04-15',null,'7GJANELAE',1,null,null,'pix',2,3,21,NULL,3,2,null);
call sp_cadastra_compra_passagem ('RIO DE JANEIRO','2023-04-01','SÃO PAULO','2023-04-03',null,'4DJANELAD',1,null,null,'pix',1,1,10,NULL,4,1,null);
call sp_cadastra_compra_passagem ('PARÁ','2023-04-02','CEARÁ','2023-04-07',null,'9IJANELAE',1,null,null,'pix',2,3,27,NULL,5,2,null);
call sp_cadastra_compra_passagem ('SÃO PAULO','2023-04-15','MANAUS','2023-04-16',null,'6FJANELAD',1,null,null,'pix',2,3,18,NULL,6,2,null);
call sp_cadastra_compra_passagem ('CEARÁ','2023-04-01','GOIAS','2023-04-03',null,'2BMEIO',1,null,null,'c.débito',2,3,6,NULL,7,2,null);
call sp_cadastra_compra_passagem ('BAHIA','2023-04-05','TOCANTINS','2023-04-09',null,'5EJANELAD',1,null,null,'c.crédito',1,1,13,NULL,8,1,null);
call sp_cadastra_compra_passagem ('MANAUS','2023-04-09','SÃO PAULO','2023-04-13',null,'8HJANELAE',1,null,null,'c.crédito',1,2,23,NULL,9,1,null);

call sp_cadastra_compra_passagem ('TOCANTINS','2023-04-17','SÃO PAULO','2023-04-20',null,'9HJANELAE',1,null,null,'c.crédito',1,2,24,NULL,9,1,null);

select * from compra_passagem; 

-- CRIANDO A TABELA DO TRAJETO DA VIAGEM

create table trajeto_voo (
cod_trajeto_voo int not null auto_increment primary key,
cod_aviao int,
cod_aeroporto int,
numero_serie_ida varchar(14),
nome_aeroporto_ida varchar(20),
estado_ida varchar(2),
numero_serie_volta varchar(14),
nome_aeroporto_volta varchar(20),
estado_volta varchar(2),
cod_companhia int,
cod_funcionario int,
nome_funcionario varchar(20),
sobrenome_funcionario varchar(40),
cargo varchar(50),
nome_companhia varchar(50),
constraint fk10_cod_aviao
foreign key (cod_aviao)
references aviao (cod_aviao)
on update cascade
on delete cascade,
constraint fk10_cod_funcionario
foreign key (cod_funcionario)
references funcionario (cod_funcionario)
on update cascade
on delete cascade,
constraint fk10_cod_aeroporto
foreign key (cod_aeroporto)
references aeroportos(cod_aeroporto)
on update cascade
on delete cascade
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA DE TRAJETO DE VIAGEM

delimiter $$
create procedure sp_cadastro_voo(cod_aviao int,cod_aeroporto int,numero_serie_ida varchar(14),nome_aeroporto_ida varchar(20),
estado_ida varchar(2),numero_serie_volta varchar(14),nome_aeroporto_volta varchar(20),estado_volta varchar(2),cod_companhia int,
cod_funcionario int,nome_funcionario varchar(20),sobrenome_funcionario varchar(40),cargo varchar(50),nome_companhia varchar(50)
)
begin
	insert into trajeto_voo (cod_aviao,cod_aeroporto,numero_serie_ida,nome_aeroporto_ida,
estado_ida,numero_serie_volta,nome_aeroporto_volta,estado_volta,cod_companhia,
cod_funcionario,nome_funcionario,sobrenome_funcionario,cargo,nome_companhia)values
(cod_aviao,cod_aeroporto,numero_serie_ida,nome_aeroporto_ida,
estado_ida,numero_serie_volta,nome_aeroporto_volta,estado_volta,cod_companhia,
cod_funcionario,nome_funcionario,sobrenome_funcionario,cargo,nome_companhia);
end $$
delimiter ;

call sp_cadastro_voo(2,2,'IDA-123','EDUARDINHO III','AM','VOLTA-456','SANTOS DUMOND','RJ',1,7,'SILVIA REGINA','LIMA','PILOTO','AMERICANAS');
call sp_cadastro_voo(1,9,'IDA-123','CONGONHAS','SP','VOLTA-456','ILHEUS','BA',1,7,'SILVIA REGINA','LIMA','PILOTO','AMERICANAS');
call sp_cadastro_voo(3,19,'IDA-123','ARAGUACEMA','TO','VOLTA-456','GOIANANOPOLIS','GO',2,8,'PEDRO MATHEUS','MIRANDA CORREIA','PILOTO','AZUL');
call sp_cadastro_voo(1,4,'IDA-123','SANTOS DUMOND','RJ','VOLTA-456','CONGONHAS','SP',1,7,'SILVIA REGINA','LIMA','PILOTO','AMERICANAS');
call sp_cadastro_voo(3,13,'IDA-123','ALTAMIRA','PA','VOLTA-456','SOBRAL','CE',2,8,'PEDRO MATHEUS','MIRANDA CORREIA','PILOTO','AZUL');
call sp_cadastro_voo(3,9,'IDA-123','CONGONHAS','','VOLTA-456','EDUARDINHO III','AM',2,8,'PEDRO MATHEUS','MIRANDA CORREIA','PILOTO','AZUL');
call sp_cadastro_voo(3,25,'IDA-123','SOBRAL','CE','VOLTA-456','GOIANANOPOLIS','GO',2,8,'PEDRO MATHEUS','MIRANDA CORREIA','PILOTO','AZUL');
call sp_cadastro_voo(1,14,'IDA-123','ILHEUS','BA','VOLTA-456','ARAGUACEMA','TO',1,7,'SILVIA REGINA','LIMA','PILOTO','AMERICANAS');
call sp_cadastro_voo(2,2,'IDA-123','EDUARDINHO III','AM','VOLTA-456','CONGONHAS','SP',1,7,'SILVIA REGINA','LIMA','PILOTO','AMERICANAS');

select * from trajeto_voo;

-- VERIFICAR SE PODE OU NAO AGENDAR LUGAR NO VOO

delimiter $$
create function verifica_assento (assento varchar(10),cod_assento int,cod_companhia int, cod_aviao int,origem varchar(20),origem_data date,
destino varchar(20),destino_volta date,classe varchar(20))
returns varchar(100)
begin
	declare mensagem varchar (100);

    if (assento = assento) and (cod_assento = cod_assento) and ( cod_companhia = cod_companhia ) and (cod_aviao = cod_aviao) 
    and (origem = origem) and (origem_data = origem_data) and (destino = destino) and (destino_volta = destino_volta)  and 
    (classe = classe) then
    set mensagem ='lugar já está reservado';
    end if;
    return mensagem;
end $$
delimiter ;


select verifica_assento (assento,cod_assento,cod_companhia, cod_aviao,origem,origem_data,
destino,destino_volta,classe) AS 'VERIFICA SITUAÇÃO NO VOO'
from compra_passagem
where assento = '1AMEIO';



-- ALTERAR ALGUMA INFORMAÇÃO APOS FINALIZADA A COMPRA DA PASSAGEM AEREA.
-- CASO ALGUMA INFORMAÇÃO SEJA ALTERADA, SERÁ COBRADA UMA TAXA DE 15% NO VALOR ORIGINAL DA PASSAGEM AEREA.

delimiter $$
create procedure alterar_informação_da_compra_passagem( cod int, origem varchar(30), destino varchar(30), valor decimal (10,2))
begin
	if exists(select cod_passagem from compra_passagem where (cod_passagem = cod_passagem )) then
    update compra_passagem
    set origem = @origem,
    destino = @destino,
    valor = valor + ( valor * 0.15)
    where cod_passagem = cod;
	end if;
end $$
delimiter ;

set @origem ='rio de janeiro';
set @destino ='tocantins';
set @valor = 1500.00;

call alterar_informação_da_compra_passagem(10,@origem,@destino,@valor);

-- EXCLUI A COMPRA DA PASSAGEM AEREA.

delimiter $$
create procedure excluir_a_compra_da_passagem( cod int)
begin
	if exists(select cod_passagem from compra_passagem where (cod_passagem = cod_passagem )) then
    delete from compra_passagem
    where cod_passagem = cod;
	end if;
end $$
delimiter ;

set @cod= 12;
call excluir_a_compra_da_passagem(@cod)



    



select passageiro.nome_passageiro,passageiro.sobrenome_passageiro,compra_passagem.origem,compra_passagem.destino
from compra_passagem
inner join passageiro
on compra_passagem.cod_passageiro = passageiro.cod_passageiro
limit 9;


select compra_passagem.origem,compra_passagem.destino
from compra_passagem
where origem_data and destino_volta between '2023-04-01' and '2023-04-30';

select destino, count(destino) 
from compra_passagem
group by destino
having count(destino);

select origem, count(origem) 
from compra_passagem
group by origem
having count(origem);

select pagamento, count(pagamento) 
from compra_passagem
group by pagamento
having count(pagamento);

select concat(nome_funcionario,' ',funcionario.sobrenome_funcionario) AS 'PILOTOS ATIVOS NA COMPANHIA'
from funcionario
where cargo ='PILOTO';