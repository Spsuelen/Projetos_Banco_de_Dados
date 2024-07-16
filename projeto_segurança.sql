-- drop database sistema_seguranca;

create database sistema_seguranca;
use sistema_seguranca;


-- CRIANDO A TABELA SISTEMA

create table sistema(
cod_sistema int not null auto_increment primary key,
nome_sistema varchar(50),
cnpj varchar (14)
);

-- CRIANDO O PROCEDIMENTO DE INSERÇÃO DAS INFORMAÇÕES DA TABELA SISTEMA

delimiter $$
create procedure sp_cadastro_sistema(nome varchar(80),cnpj varchar(20))
begin
	insert into sistema (nome_sistema,cnpj) values ( nome,cnpj);
end $$
delimiter ;

call sp_cadastro_sistema();
-- call sp_cadastro_sistema('SafeCampus','00394460005887');

select * from sistema;

-- CRIANDO A TABELA ADMINISTRADOR

create table administrador(
cod_adm int auto_increment not null primary key,
nome_adm varchar(50),
email_adm varchar(30),
senha_adm varchar(20),
cod_sistema int,
constraint fk1_cod_sistema
foreign key (cod_sistema)
references sistema (cod_sistema)
)auto_increment = 1001;

-- CRIANDO A PROCEDURE PARA A ADMINISTRADOR PARA INSERIR SUAS RESPECTIVAS INFORMAÇÕES 

delimiter $$
create procedure sp_cadastro_administrador(nome_adm varchar (50),email_adm varchar(30),
senha_adm varchar(20),cod_sistema int)
begin
	insert into administrador (nome_adm,email_adm,senha_adm,cod_sistema ) values
    (nome_adm,email_adm,senha_adm,cod_sistema );
end $$
delimiter ;

call sp_cadastro_administrador();
-- call sp_cadastro_administrador('ANA MARIA',"ana@gmail.com","12345h",1);
-- call sp_cadastro_administrador('JOSE GUILHERME',"jose@gmail.com","12345l",1);
-- call sp_cadastro_administrador('PEDRO HENRIQUE',"pedroh@gmail.com","11245p",1);
select * from administrador;

-- CRIANDO A TABELA DE USUÁRIOS

create table usuario (
cod_usuario int not null auto_increment primary key,
nome_usuario varchar(50),
email_usuario varchar(30),
senha_usuario varchar(20),
status_usuario varchar(15),
cod_sistema int,
constraint fk2_cod_sistema
foreign key (cod_sistema)
references sistema (cod_sistema)
) auto_increment = 954601;

create trigger verifica_status_usuario before insert
on usuario
for each row
set new.status_usuario ='ATIVO';

-- CRIANDO A PROCEDURE  CADASTRO DE USUARIO PARA INSERIR SUAS RESPECTIVAS INFORMAÇÕES

delimiter $$
create procedure sp_cadastro_usuario (nome_usuario varchar(50),email_usuario varchar(30),senha_usuario varchar(20),cod_sistema int )
begin 
	insert into usuario (nome_usuario,email_usuario,senha_usuario,cod_sistema)
    values (nome_usuario,email_usuario,senha_usuario,cod_sistema);
end $$
delimiter ;

call sp_cadastro_usuario ();
-- call sp_cadastro_usuario ("MARIA DE LOURDES","maria@gmail.com","123456", 1);
-- call sp_cadastro_usuario ("LARA","lara@gmail.com","12345G", 1);
-- call sp_cadastro_usuario ("JULIA","julia@gmail.com","78945K",1);
-- call sp_cadastro_usuario ("AFONSO","afonso@gmail.com","01478J", 1);
-- call sp_cadastro_usuario ("GABRIEL","gabriel@gmail.com","19652P",1);
-- call sp_cadastro_usuario ("ERICK","erick@gmail.com","321456",1);
-- call sp_cadastro_usuario ("PEDRO","pedro@gmail.com","123456", 1);
-- call sp_cadastro_usuario ("PEDRO GUILHERME","pedrog@gmail.com","123456", 1);
select * from usuario; 

-- CRIANDO A TABELA DE OCORRENCIAS

create table ocorrencia (
cod_ocorrencia int not null auto_increment primary key,
data date,
hora time,
descricao longtext,
categoria varchar(20),
cod_sistema int,
cod_usuario int,
nome_usuario varchar(50),
status_ocorrencia varchar(50),
constraint fk3_cod_sistema
foreign key (cod_sistema)
references sistema (cod_sistema),
constraint fk3_cod_usuario
foreign key (cod_usuario)
references usuario (cod_usuario)
);

create trigger verifica_status_ocorrencia before insert
on ocorrencia
for each row
set new.status_ocorrencia ='OCORRENCIA REGISTRADA NO SISTEMA !';

-- CRIANDO A PROCEDURE  CADASTRO DE OCORRENCIAS PARA INSERIR SUAS RESPECTIVAS INFORMAÇÕES

delimiter $$
create procedure sp_cadastro_ocorrencia (data date,hora time,descricao longtext,
categoria varchar(20),cod_sistema int,cod_usuario int,nome_usuario varchar(50))
begin 
	insert into ocorrencia (data,hora,descricao,categoria,
	cod_sistema,cod_usuario,nome_usuario)
    values (data,hora,descricao,categoria,
	cod_sistema,cod_usuario,nome_usuario);
end $$
delimiter ;

call sp_cadastro_ocorrencia ();
-- call sp_cadastro_ocorrencia ('2023-02-03','18:37:59',"roubaram meu computador",'GRAVE',1,954608,"PEDRO GUILHERME");
-- call sp_cadastro_ocorrencia ('2023-04-25','22:30:00',"fui assaltado",'GRAVE',1,954608,"PEDRO GUILHERME");
-- call sp_cadastro_ocorrencia ('2023-05-30','18:00:00',"roubaram meu carro",'GRAVE',1,954608,"PEDRO GUILHERME");
-- call sp_cadastro_ocorrencia ('2023-07-25','18:12:39',"roubaram meu carro",'GRAVE',1,954601,"MARIA DE LOURDES");
-- call sp_cadastro_ocorrencia ('2023-10-02','19:45:00',"roubaram minha moto",'GRAVE',1,954602,"LARA");

select * from ocorrencia;

-- LISTAR O NOME DOS USUARIOS EM ORDEM ALFABÉTICA 

 select nome_usuario
 from usuario
 order by nome_usuario asc;
 
 
-- VERIFICAR SE O USUARIO CADASTRADO É UM ADMINISTRADOR

 delimiter $$
create function verificar_administradores_existentes(email_adm varchar (30),senha_adm varchar(20))
returns varchar(100)
begin
declare mensagem varchar(100);
case
		    when email_adm = 'email cadastrado aqui' and senha_adm = 'senha cadastrada aqui' then
			set mensagem ='ACESSO PERMITIDO.VOCÊ POSSUI PRIVILEGIOS DE ADMINISTRADOR';
            when email_adm = 'email cadastrado aqui'  and senha_adm = 'senha cadastrada aqui' then
            set mensagem ='ACESSO PERMITIDO.VOCÊ POSSUI PRIVILEGIOS DE ADMINISTRADOR';
            else
            set mensagem ='ACESSO NEGADO. SEM PRIVILEGIOS DE ADMINISTRADOR';
            end case;
return mensagem;
end $$
delimiter ;

select verificar_administradores_existentes() as 'STATUS DA SITUAÇÃO';

-- LISTANDO OS USUARIOS QUE POSSUEM REGISTRO DE OCORRENCIA NO SISTEMA

select usuario.nome_usuario,email_usuario,data,hora,descricao
from usuario
inner join ocorrencia
on usuario.cod_usuario = ocorrencia.cod_usuario;