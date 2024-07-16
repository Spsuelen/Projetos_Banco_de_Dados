-- drop database instituicao;

create database instituicao;
use instituicao;

create table local (
id_local int auto_increment not null primary key,
cnpj char(14)
);

create table bairro(
codigo_bairro int auto_increment not null primary key,
nome_bairro char(50)
);



create table auditorio(
id_auditorio int auto_increment not null primary key,
nome_auditorio char (50),
id_local int,
constraint fk1_id_local
foreign key (id_local)
references local (id_local)
);


create table sala (
id_sala int auto_increment not null primary key,
nome_sala char(50),
numero_sala int,
qtde_lugar int,
id_local int,
id_auditorio int,
constraint fk2_id_local
foreign key (id_local)
references local (id_local),
constraint fk1_id_auditorio
foreign key (id_auditorio)
references auditorio (id_auditorio)
);


create table patrocinador (
codigo_patrocinador int auto_increment not null primary key,
nome_patrocinador char(100)
);


create table tipo_patrocinio(
codigo_patrocinio int auto_increment not null primary key,
descricao longtext,
codigo_patrocinador int,
constraint fk1_codigo_patrocinador
foreign key (codigo_patrocinador)
references patrocinador (codigo_patrocinador)
);

create table palestra (
codigo_palestra int auto_increment not null primary key,
nome_palestra char(50),
dia_hora_inicio datetime,
dia_hora_fim datetime,
tema char(100),
titulo char(100),
valor decimal (10,2) not null default 10.00,
id_auditorio int,
id_sala int,
codigo_patrocinador int,
codigo_patrocinio int,
constraint fk1_id_sala
foreign key (id_sala)
references sala (id_sala),
constraint fk2_id_auditorio
foreign key (id_auditorio)
references auditorio (id_auditorio),
constraint fk2_codigo_patrocinador
foreign key (codigo_patrocinador)
references patrocinador (codigo_patrocinador),
constraint fk1_codigo_patrocinio
foreign key (codigo_patrocinio)
references tipo_patrocinio (codigo_patrocinio)
);


create table palestrante (
codigo_palestrante int auto_increment not null primary key,
nome_palestrante char(100),
cpf char(11),
fone char(11),
email char(50),
rua char(100),
cep char (50),
codigo_palestra int,
id_sala int,
id_auditorio int,
codigo_bairro int,
constraint fk1_codigo_bairro
foreign key (codigo_bairro)
references bairro (codigo_bairro),
constraint fk2_id_sala
foreign key (id_sala)
references sala (id_sala),
constraint fk3_id_auditorio
foreign key (id_auditorio)
references auditorio (id_auditorio),
constraint fk1_codigo_palestra
foreign key (codigo_palestra)
references palestra (codigo_palestra)
);

 create table participante (
codigo_participante int auto_increment not null primary key,
nome_participante char(100),
cpf char(11),
fone char(11),
email char(50),
rua char(100),
cep char (50),
codigo_palestra int,
id_sala int,
id_auditorio int,
codigo_bairro int,
constraint fk2_codigo_bairro
foreign key (codigo_bairro)
references bairro (codigo_bairro),
constraint fk3_id_sala
foreign key (id_sala)
references sala (id_sala),
constraint fk4_id_auditorio
foreign key (id_auditorio)
references auditorio (id_auditorio),
constraint fk2_codigo_palestra
foreign key (codigo_palestra)
references palestra (codigo_palestra)
 );


create table inscricao(
codigo_inscricao int not null auto_increment primary key,
data_inscricao date not null,
codigo_palestra int,
codigo_participante int,
constraint fk2_codigo_participante
foreign key (codigo_participante)
references participante (codigo_participante),
constraint fk3_codigo_palestra
foreign key (codigo_palestra)
references palestra (codigo_palestra)
);


create table palestra_patrocinio(
codigo_palestraPatrocinio int not null auto_increment primary key,
codigo_palestra int,
codigo_patrocinador int,
codigo_patrocinio int,
constraint fk4_codigo_patrocinador
foreign key (codigo_patrocinador)
references patrocinador (codigo_patrocinador),
constraint fk4_codigo_palestra
foreign key (codigo_palestra)
references palestra (codigo_palestra),
constraint fk4_codigo_patrocinio
foreign key (codigo_patrocinio)
references tipo_patrocinio (codigo_patrocinio)
);

-- CREATE PROCEDURE LOCAL

delimiter $$
create procedure sp_cad_local(cnpj char (14))
begin
insert into local (cnpj) values (cnpj);
end $$
delimiter ;

call sp_cad_local('019632577123');
select * from local;


 -- CRIAÇÃO DA PROCEDURE BAIRRO
 
delimiter $$
create procedure sp_cad_bairro(nome varchar (50))
begin
insert into bairro (nome_bairro) values (nome);
end $$
delimiter ;

call sp_cad_bairro('Tarumã');
call sp_cad_bairro('compensa');
call sp_cad_bairro('cachoeirinha');

select * from bairro;


-- CRIAÇÃO DA PROCEDURE AUDITORIO

delimiter $$
create procedure sp_cad_auditorio(nome char (100),id_local int)
begin
insert into auditorio (nome_auditorio,id_local) values (nome,id_local);
end $$
delimiter ;

call sp_cad_auditorio('auditorio 1',1);
call sp_cad_auditorio('auditorio 2',1);

select * from auditorio;

-- CRIAÇÃO DA PROCEDURE SALA

delimiter $$
create procedure sp_cad_sala(nome_sala char(50),numero int,qtde int,id_local int ,id_auditorio int)
begin
insert into sala (nome_sala,numero_sala,qtde_lugar,id_local,id_auditorio) values (nome_sala,numero,qtde,id_local,id_auditorio);
end $$
delimiter ;

call sp_cad_sala('lab informatica',17,30,1,1);
call sp_cad_sala('lab design',18,30,1,2);
call sp_cad_sala('lab  comunicacao',19,30,1,1);


select * from sala;


-- CRIAÇÃO DA PROCEDURE PATROCINADOR

delimiter $$
create procedure sp_cad_patrocinador(nome char(50))
begin
insert into patrocinador (nome_patrocinador) values (nome);
end $$
delimiter ;



call sp_cad_patrocinador('afonso gabriel lopes');
call sp_cad_patrocinador('victor gabriel madureira');
call sp_cad_patrocinador('pedro gabriel mourim');


select * from patrocinador;


-- CRIAÇÃO DA PROCEDURE TIPO PATROCINIO

delimiter $$
create procedure sp_cad_tipo_patrocinio(descricao longtext,cod int)
begin
insert into tipo_patrocinio (descricao,codigo_patrocinador) values (descricao,cod);
end $$
delimiter ;



call sp_cad_tipo_patrocinio('aguas minerais patrocinando o ensino a informática',1);
call sp_cad_tipo_patrocinio('aguas minerais patrocinando o ensino a comunicacao',2);
call sp_cad_tipo_patrocinio('aguas minerais patrocinando o ensino de artes visuais',3);

select * from patrocinador;

-- CRIAÇÃO DA PROCEDURE PALESTRA

delimiter $$
create procedure sp_cad_palestra(nome char(50),dia_hora_inicio datetime,dia_hora_fim datetime,tema char(100),titulo char(100),valor dec (10,2),id_auditorio int, id_sala int, codigo_patrocinador int, codigo_patrocinio int)
begin
insert into palestra (nome_palestra,dia_hora_inicio,dia_hora_fim ,tema,titulo,valor,id_auditorio, id_sala, codigo_patrocinador, codigo_patrocinio) values (nome,dia_hora_inicio,dia_hora_fim ,tema,titulo,valor,id_auditorio, id_sala, codigo_patrocinador, codigo_patrocinio);
end $$
delimiter ;



call sp_cad_palestra('a era digital','2023-04-14 15:00:00','2023-04-14 16:00:00','A historia do começo',15.00,1,1,1,1,1);
call sp_cad_palestra('internet das coisas','2023-04-14 17:00:00','2023-04-14 18:00:00','Como será o futuro?',15.00,1,1,1,1,1);

select * from palestra;


-- CRIAÇÃO DA PROCEDURE PALESTRANTE --

delimiter $$
create procedure sp_cad_palestrante(nome char (100),cpf char(11),fone char(11),email char(50),rua char(100),cep char(50),cod int,id int,id_aud int,codigo_bairro int)
begin
insert into palestrante (nome_palestrante,cpf,fone,email,rua,cep,codigo_palestra,id_sala,id_auditorio,codigo_bairro) values (nome,cpf,fone,email ,rua,cep,cod,id,id_aud,codigo_bairro);
end $$
delimiter ;

call sp_cad_palestrante('luis guilerme amado','023962588','92981428033','guiluiz@gmail.com','rua dos amores','69070100',1,1,1,3);
call sp_cad_palestrante('amanda carla ferreira','8963258963','92981426322','carlotinha@gmail.com','rua dos amigos','69070150',1,1,1,2);
call sp_cad_palestrante('ana alice ferreira','8963257412','92981426099','aliceanaa@gmail.com','rua dos sorrisos','69070170',1,1,1,1);


select * from palestrante;

select * from palestra;
select * from sala;
select * from auditorio;
select * from bairro;
select * from participante;



--  CRIAÇÃO DA PROCEDURE PARTICIPANTE

delimiter $$
create procedure sp_cad_participante(nome char (100),cpf char(11),fone char(11),email char(50),rua char(100),cep char(50),cod int,id int,id_aud int,codigo_bairro int)
begin
insert into participante (nome_participante,cpf,fone,email,rua,cep,codigo_palestra,id_sala,id_auditorio,codigo_bairro) values (nome,cpf,fone,email ,rua,cep,cod,id ,id_aud,codigo_bairro);
end $$
delimiter ;


call sp_cad_participante('josias bentes lima','02368521455','9298106769','josiaslima@gmail.com','rua amarildo gomes','69070180',2,1,1,1);
call sp_cad_participante('lasla dandara','02368525066','9298108099','laslalima@gmail.com','rua amarildo gomes','69070180',2,1,1,1);


select * from participante;


--  CRIAÇÃO DA PROCEDURE INSCRICAO

delimiter $$
create procedure sp_cad_inscricao(data_i datetime,cod int,cod_p int)
begin
insert into inscricao (data_inscricao, codigo_palestra,codigo_participante) values (data_i, cod,cod_p);
end $$
delimiter ;

drop procedure sp_cad_inscricao;
call sp_cad_inscricao ('2023-04-14 15:00:00',2,1);

select * from inscricao;


--  CRIAÇÃO DA PROCEDURE PALESTRA PATROCINIO

delimiter $$
create procedure sp_cad_patrocinio_palestra(cod_pa int,cod int,cod_p int)
begin
insert into palestra_patrocinio (codigo_palestra,codigo_patrocinador,codigo_patrocinio) values (cod_pa,cod ,cod_p);
end $$
delimiter ;


call sp_cad_patrocinio_palestra(2,1,1);
call sp_cad_patrocinio_palestra(1,2,2);

select * from palestra_patrocinio;
select * from palestra;






