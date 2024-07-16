create database clinicaveterinaria; -- criando o banco

use clinicaveterinaria; -- selecionando o banco

-- criando a tabela clinica

create table clinica(
id_clinica int not null auto_increment primary key,
nome_clinica varchar (100),
cnpj varchar (11),
filial varchar (100),
estado varchar (2) default 'am'
);

-- criando a tabela veterinario

create table veterinario( 
id_veterinario int not null auto_increment primary key,
nome_veterinario varchar (100),
cpf_veterinario int,
especializacao varchar (100),
id_clinica int,
constraint fk1_id_clinica
foreign key (id_clinica)
references clinica (id_clinica)
on delete cascade
on update cascade
  );
  
  -- criando a tabela cliente
  
create table cliente (
id_cliente int not null auto_increment primary key,
nome_cliente varchar (100),
cpf_cliente int,
endereco_rua varchar (100),
endereco_numero int,
telefone varchar(11),
id_clinica int,
constraint fk2_id_clinica
foreign key (id_clinica)
references clinica (id_clinica)
on delete cascade
on update cascade
);
-- criando a tabela pet

create table pet(
id_pet int not null auto_increment primary key,
nome_pet varchar (100),
tipo_pet varchar (100),
idade int,
id_cliente int unique,
id_clinica int,
constraint fk3_id_clinica
foreign key (id_clinica)
references clinica (id_clinica)
on delete cascade
on update cascade,
constraint fk3_id_cliente
foreign key (id_cliente)
references cliente (id_cliente)
on delete cascade
on update cascade
);

-- criando a tabela agendamento

create table agendamento (
id_consulta int not null auto_increment primary key,
data_hora_inicio datetime,
data_hora_fim datetime,
id_veterinario int,
id_cliente int,
id_pet int,
id_clinica int,
constraint fk4_id_veterinario
foreign key (id_veterinario)
references veterinario(id_veterinario)
on delete cascade
on update cascade,
constraint fk4__id_pet
foreign key(id_pet)
references pet(id_pet)
on delete cascade
on update cascade,
constraint fk4_id_cliente
foreign key(id_cliente)
references cliente(id_cliente)
on delete cascade
on update cascade,
constraint fk4_id_clinica
foreign key(id_clinica)
references clinica(id_clinica)
on delete cascade
on update cascade
);

-- criando a tabela triagem_simples

create table triagem_simples(
id_triagem int not null auto_increment primary key,
avaliacao longtext,
data_triagem date,
id_veterinario int,
id_pet int,
nome_pet varchar(100),
id_cliente int,
nome_cliente varchar(100),
id_clinica int,
constraint fk5_id_veterinario
foreign key (id_veterinario)
references veterinario(id_veterinario)
on delete cascade
on update cascade,
constraint fk5_id_pet
foreign key(id_pet)
references pet(id_pet)
on delete cascade
on update cascade,
constraint fk5_id_cliente
foreign key(id_cliente)
references cliente(id_cliente)
on delete cascade
on update cascade,
constraint fk5_id_
foreign key(id_pet)
references pet(id_pet)
on delete cascade
on update cascade,
constraint fk5_id_clinica
foreign key(id_clinica)
references clinica(id_clinica)
on delete cascade
on update cascade
);
-- criando a tabela diagnostico

create table diagnostico(
id_diagnostico int not null auto_increment primary key,
descricao longtext,
id_veterinario int,
id_cliente int,
id_pet int,
id_clinica int,
constraint fk6_id_veterinario
foreign key (id_veterinario)
references veterinario (id_veterinario)
on delete cascade
on update cascade,
constraint fk6_id_cliente
foreign key (id_cliente)
references cliente (id_cliente)
on delete cascade
on update cascade,
constraint fk6_id_pet
foreign key (id_pet)
references pet (id_pet)
on delete cascade
on update cascade,
constraint fk6_id_clinica
foreign key (id_clinica)
references clinica (id_clinica)
on delete cascade
on update cascade
);

-- criando a tabela procedimento


create table procedimento (
id_procedimento int not null auto_increment primary key,
status_retorno varchar(3) CHECK( status_retorno in ('sim', 'nao') ),
descricao varchar(100),
data_procedimento date,
valor decimal (8,2),
id_diagnostico int,
id_cliente int,
nome_cliente varchar(100),
id_pet int,
id_veterinario int,
id_clinica int,
constraint fk7_id_clinica
foreign key (id_clinica)
references clinica(id_clinica)
on delete cascade
on update cascade,
constraint fk7_id_cliente
foreign key (id_cliente)
references cliente(id_cliente)
on delete cascade
on update cascade,
constraint fk7_id_pet
foreign key (id_pet)
references pet(id_pet)
on delete cascade
on update cascade,
constraint fk7_id_veterinario
foreign key (id_veterinario)
references veterinario(id_veterinario)
on delete cascade
on update cascade,
constraint fk7_id_diagnostico
foreign key (id_diagnostico)
references diagnostico(id_diagnostico)
on delete cascade
on update cascade
);


-- criando a tabela pagamento 

 create table pagamento( 
 id_pagamento int not null auto_increment primary key,
 descricao_pagamento  varchar(100),
 id_procedimento int,
 data_pagamento datetime,
 id_clinica int,
 constraint fk8_id_procedimento
 foreign key (id_procedimento)
 references procedimento (id_procedimento)
 on delete cascade
on update cascade,
 constraint fk8_id_clinicaa
 foreign key (id_clinica)
 references clinica (id_clinica)
 on delete cascade
on update cascade
 );
 
 -- criando a tabela procedimentopagamento
 
 create table procedimentopagamento (
 id_procedimentopagamento int not null auto_increment primary key,
 id_procedimento int,
 id_pagamento int,
 status_pagamento boolean,
 id_clinica int,
 constraint fk9_id_procedimento 
 foreign key (id_procedimento)
 references procedimento ( id_procedimento)
 on delete cascade
on update cascade,
  constraint fk9_id_pagamento  
 foreign key (id_pagamento )
 references pagamento ( id_pagamento)
 on delete cascade
on update cascade,
  constraint fk9_id_clinicaaa
 foreign key (id_clinica)
 references clinica (id_clinica)
 on delete cascade
on update cascade
 );

 -- renomear a tabela procedimentopagamento para o nome de statuspagamento
 rename table procedimentopagamento to statuspagamento;
 
 rename table statuspagamento to faturapagamento;
 
 -- criando a tabela historico atendimento
 
 create table historicoatendimento (
historico_atendimento int not null auto_increment primary key,
diagnostico longtext,
exame longtext,
status_exame boolean,
laudo longtext,
id_diagnostico int,
id_cliente int,
id_pet int,
id_veterinario int,
id_procedimento int,
id_pagamento int,
id_procedimentopagamento int,
id_clinica int,
constraint fk10_id_diagnostico
foreign key (id_cliente)
references diagnostico (id_cliente)
on delete cascade
on update cascade,
constraint fk10_id_cliente
foreign key (id_cliente)
references cliente (id_cliente)
on delete cascade
on update cascade,
constraint fk10_id_pet
foreign key (id_pet)
references pet (id_pet)
on delete cascade
on update cascade,
constraint fk10_id_veterinario
foreign key (id_veterinario)
references veterinario (id_veterinario)
on delete cascade
on update cascade,
constraint fk10_id_procedimento
foreign key (id_procedimento)
references procedimento (id_procedimento)
on delete cascade
on update cascade,
constraint fk10_id_pagamento
foreign key (id_pagamento)
references pagamento (id_pagamento)
on delete cascade
on update cascade,
constraint fk10_id_procedimentopagamento
foreign key (id_procedimentopagamento)
references faturapagamento (id_procedimentopagamento)
on delete cascade
on update cascade,
constraint fk10_id_clinica
foreign key (id_clinica)
references clinica (id_clinica)
on delete cascade
on update cascade
);



											-- inserindo informaçoes --
   

   
   -- inserindo informaçao em clinica
 
  insert into clinica(nome_clinica, cnpj, filial, estado)
  values ('carinha feliz','0123456789','filial zona central','RJ');
  insert into clinica(nome_clinica, cnpj, filial, estado)
  values ('sol feliz','7894561230','filial zona centro oeste ','SP');
  insert into clinica(nome_clinica, cnpj, filial, estado)
  values ('lua feliz','7894563210','filial zona leste','RS');
  insert into clinica(nome_clinica, cnpj, filial, estado)
  values ('estrela feliz','9638521470','filial zona sul','AM');
  update clinica
  set filial = 'filial zona norte'
  where id_clinica = 2;
  update clinica
  set filial = 'filial zona centro sul'
  where id_clinica = 1;
   
      -- inserindo informaçao veterinario
   
 insert into veterinario (nome_veterinario,cpf_veterinario,especializacao,id_clinica)
  values ('lasla','0123456987','atendimento basico',1);
  insert into veterinario (nome_veterinario,cpf_veterinario,especializacao,id_clinica)
  values ('josias','741852963','atendimento basico',4);
  insert into veterinario (nome_veterinario,cpf_veterinario,especializacao,id_clinica)
  values ('suelen','741852369','atendimento basico',3);
   insert into veterinario (nome_veterinario,cpf_veterinario,especializacao,id_clinica)
  values ('joao','369852147','atendimento especializado',2);

  
  -- inserindo informação em cliente
  
  insert into cliente (nome_cliente,cpf_cliente,endereco_rua,endereco_numero,telefone,id_clinica)
  values ('maria','741852369','rua dos anjos',160,'92994067089',1);
  insert into cliente (nome_cliente,cpf_cliente,endereco_rua,endereco_numero,telefone,id_clinica)
  values ('tom','963852147','rua dos andradas',10,'92993698512',3);
   insert into cliente (nome_cliente,cpf_cliente,endereco_rua,endereco_numero,telefone,id_clinica)
  values ('claudia','147852369','rua dos amores',13,'92995147896',4);
  insert into cliente (nome_cliente,cpf_cliente,endereco_rua,endereco_numero,telefone,id_clinica)
  values ('jorge','123654780','rua dos milagres',27,'92999854632',2);
  
  
    -- inserindo informação em pet;
    
    insert into pet (nome_pet,tipo_pet,idade,id_cliente,id_clinica)
    values ('pipokinha','cachorro',10,1,1);
    insert into pet (nome_pet,tipo_pet,idade,id_cliente,id_clinica)
    values ('julius','gato',1,2,3);
    insert into pet (nome_pet,tipo_pet,idade,id_cliente,id_clinica)
    values ('dom','coelho',3,4,2);
    insert into pet (nome_pet,tipo_pet,idade,id_cliente,id_clinica)
    values ('nelson','cachorro',4,3,4);
    
    -- inserindo informação em agendamento;

insert into agendamento (data_hora_inicio,data_hora_fim,id_veterinario,id_cliente,id_pet,id_clinica)
values('2023-02-04 09:00:00','23-02-04 09:30:00',1,1,1,1);
insert into agendamento (data_hora_inicio,data_hora_fim,id_veterinario,id_cliente,id_pet,id_clinica)
values('2023-02-04 10:00:00','23-02-04 13:00:00',4,4,3,2);
insert into agendamento (data_hora_inicio,data_hora_fim,id_veterinario,id_cliente,id_pet,id_clinica)
values('2023-02-10 10:00:00','23-02-10 11:50:00',3,3,4,3);
insert into agendamento (data_hora_inicio,data_hora_fim,id_veterinario,id_cliente,id_pet,id_clinica)
values('2023-02-13 09:00:00','23-02-13 18:00:00',2,3,4,4);

-- inserindo informação em triagem_simples;

insert into triagem_simples (avaliacao,data_triagem,id_veterinario,id_pet,nome_pet,id_cliente,nome_cliente,id_clinica)
values('o pet veio renovar sua dose de vacinação anual','2023-02-04',1,1,'pipokinha',1,'maria',1);
insert into triagem_simples (avaliacao,data_triagem,id_veterinario,id_pet,nome_pet,id_cliente,nome_cliente,id_clinica)
values('o pet está com um quadro leve de desidratação e seu dono relatou que tudo que ele come,coloca para fora,possivel intoxicação','2023-02-04',2,4,'nelson',3,'claudia',4 );
insert into triagem_simples (avaliacao,data_triagem,id_veterinario,id_pet,nome_pet,id_cliente,nome_cliente,id_clinica)
values('O pet está com principio de artrose, visto que os exames realizados fora da clinica, apontam para o quadro inicial, foi recomendado que ele faça o tratamento homeopatico,para aliviar suas dores','2023-02-10',4,3,'dom',4,'jorge',4);
insert into triagem_simples (avaliacao,data_triagem,id_veterinario,id_pet,nome_pet,id_cliente,nome_cliente,id_clinica)
values('O pet está saudavel e fará um procedimento de castração','2023-02-13',3,4,'nelson',3,'claudia',4);

-- inserindo informação em diagnostico;

insert into diagnostico(descricao,id_veterinario,id_cliente,id_pet,id_clinica) 
values ('o pet hoje dia  04-02-2023 realizará um simples procedimento de vacinação',1,1,1,1);
insert into diagnostico(descricao,id_veterinario,id_cliente,id_pet,id_clinica) 
values ('O pet  hoje dia 04-02-2023 terá que ser internado devido a  forte dores no abdomem',2,3,4,4);
insert into diagnostico(descricao,id_veterinario,id_cliente,id_pet,id_clinica) 
values ('O pet  hoje dia 10-02-2013 tomará um banho homeopatico para tratar de doença de artrose',4,4,3,2);
insert into diagnostico(descricao,id_veterinario,id_cliente,id_pet,id_clinica) 
values ('O pet hoje dia 13-02-2023 realizará sua castracao',3,3,4,3);
 
 -- inserindo informaçao em procedimento

 insert into procedimento ( status_retorno,descricao,data_procedimento,valor,id_diagnostico,id_cliente,nome_cliente,
id_pet,id_veterinario,id_clinica)
values ('não','vacinação','2023-02-04',50.00,1,1,'maria',1,1,1);
  insert into procedimento ( status_retorno,descricao,data_procedimento,valor,id_diagnostico,id_cliente,nome_cliente,
id_pet,id_veterinario,id_clinica)
values ('não','internação','2023-02-04',80.00,2,3,'claudia',4,2,4);
insert into procedimento ( status_retorno, descricao,data_procedimento,valor,id_diagnostico,id_cliente,nome_cliente,
id_pet,id_veterinario,id_clinica)
values ('não','banho','2023-02-10',80.00,3,4,'jorge',3,4,2);
insert into procedimento ( status_retorno, descricao,data_procedimento,valor,id_diagnostico,id_cliente,nome_cliente,
id_pet,id_veterinario,id_clinica)
values ('não','castracao','2023-02-13',150.00,4,3,'claudia',4,3,3);

-- insert into procedimento ( status_retorno, descricao,data_procedimento,valor,id_diagnostico,id_cliente,nome_cliente,
-- id_pet,id_veterinario,id_clinica)
-- values ('sim','reirada dos pontos da castração realizada no dia 13-02-2023','2023-02-17',00.00,4,3,'claudia',4,3,3);
-- delete from procedimento where id_procedimento=5;
-- update procedimento
-- set descricao ='retirada dos pontos da castração realizada no dia 13-02-2023'
-- where id_procedimento = 5;
-- inserindo informação em pagamento

 insert into pagamento (descricao_pagamento, id_procedimento,data_pagamento,id_clinica)
 values('dinheiro',1,'2023-02-04 09:40:01',1);
 insert into pagamento (descricao_pagamento, id_procedimento,data_pagamento,id_clinica)
 values('cartão de débito',3,'2023-02-04 13:00:45',2);
  insert into pagamento (descricao_pagamento, id_procedimento,data_pagamento,id_clinica)
 values('cartão credito',4,'2023-02-10 12:00:00',3);
   insert into pagamento (descricao_pagamento, id_procedimento,data_pagamento,id_clinica)
 values('pix',2,'2023-02-13 18:10:17',4);
 
 -- inserindo informação em procedimentopagamento
 
 insert into faturapagamento(id_procedimento,id_pagamento,status_pagamento,id_clinica) 
values (1, 1, true,1);
 insert into faturapagamento(id_procedimento,id_pagamento,status_pagamento,id_clinica) 
values (3, 2, true,2);
 insert into faturapagamento(id_procedimento,id_pagamento,status_pagamento,id_clinica) 
values (4, 3, true,3);
 insert into faturapagamento(id_procedimento,id_pagamento,status_pagamento,id_clinica) 
values (2, 4, true,4);

insert into historicoatendimento(diagnostico,exame,status_exame,laudo,id_diagnostico,id_cliente,id_pet,id_veterinario,
id_procedimento,id_pagamento,id_procedimentopagamento,id_clinica) 
values ('o pet está saudavel, não havendo a necessidade de exames adicionais,será realizado uma simples vacinação','nenhum será realizado',false,
'nenhuma doença aparente,somente vacinação de rotina',1,1,1,1,1,1,1,1);
insert into historicoatendimento(diagnostico,exame,status_exame,laudo,id_diagnostico,id_cliente,id_pet,id_veterinario,
id_procedimento,id_pagamento,id_procedimentopagamento,id_clinica) 
values ('o pet precisará ficar em observação(INTERNAÇÃO) na clinica pos aparenta quadro de desidratação','exame de sangue',true,
'possivelmente intoxicação, pelos sintomas apresentado',2,3,4,2,2,4,4,4);
insert into historicoatendimento(diagnostico,exame,status_exame,laudo,id_diagnostico,id_cliente,id_pet,id_veterinario,
id_procedimento,id_pagamento,id_procedimentopagamento,id_clinica) 
values ('o pet está em tratamento com banhos homeopaticos com ervas, para tratamento de artrose','nenhum exame será realizado',false,
'O dono informou que não irá realizar na clinica nenhum exame, pois fará em outro estabelecimento',3,4,3,4,3,2,2,2);
insert into historicoatendimento(diagnostico,exame,status_exame,laudo,id_diagnostico,id_cliente,id_pet,id_veterinario,
id_procedimento,id_pagamento,id_procedimentopagamento,id_clinica) 
 values ('o pet realizará um simples procedimento de castração','nenhum exame será solicitado',false,
'nenhum exame será realizado',4,3,4,3,4,3,3,3);

  
                         -- CONSULTAS --
 
 
-- selecionando todas as informaçoes de clinica e veterinaria


 select clinica.*, veterinario.*
 from clinica
 inner join veterinario
 on clinica.id_clinica = veterinario.id_veterinario;
 
 
-- consultando o nome da clinica e o estado que ela atua ;

 delimiter $$
 create procedure verclinica (in localidade varchar(100))
 begin
 select clinica.nome_clinica,clinica.estado
 from clinica
 where estado = localidade;
end $$
delimiter ; 
 
 call verclinica('AM');
 
 
-- filtrando os campo principais em ordem crescente;

 select nome_veterinario,especializacao
 from veterinario
 order by nome_veterinario asc;
 
select id_cliente,nome_cliente,cpf_cliente
from cliente
order by nome_cliente asc;

select id_veterinario,nome_veterinario,especializacao
from veterinario
order by nome_veterinario asc;
 
 -- criando o index
 
 -- criando um indice em veterinario;
 
 create index idx_nomeveterinario
 on veterinario(nome_veterinario);
 
 show index from veterinario ;
 

-- criando um indice em cliente;

create index idx_nome_cliente
on cliente (nome_cliente);

show index from cliente;

-- selecionando os campos nome da clinica,filial,estado  da tabela clinica, nome do veterinario e sua especializacao da tabela veterinario 

select nome_clinica,filial,estado,nome_veterinario,especializacao
from clinica
inner join veterinario
on clinica.id_clinica = veterinario.id_clinica;

-- selecionando o nome de cliente,cpf e o nome e tipo do pet cadastrado

select nome_cliente,cpf_cliente,nome_pet,tipo_pet
from cliente
inner join pet
on cliente.id_cliente = pet.id_pet;

-- criando uma view em clinica_cliente;
drop view clinica_cliente;
create view clinica_cliente
 as select nome_cliente,nome_clinica,filial,estado
from clinica
inner join cliente
on clinica.id_clinica = cliente.id_clinica;

select clinica_cliente.* from clinica_cliente;

-- criando uma view em cliente_pet;

create view cliente_pet
 as select nome_cliente,cpf_cliente,nome_pet,tipo_pet
from cliente
inner join pet
on cliente.id_cliente = pet.id_cliente;

select cliente_pet.* from cliente_pet;


-- criando uma view em diagnostico_cliente;
drop view diagnostico_pet;
create view diagnostico_pet
 as select pet.nome_pet,diagnostico.descricao
from pet
inner join diagnostico
on pet.id_pet = diagnostico.id_pet;


select diagnostico_pet.* from diagnostico_pet;


-- aumentando o preco dos serviços

 delimiter $$
 create function aumenta_preco(preco decimal(8,2),valor decimal(8,2))
 returns decimal (8,2)
 begin
 return preco + valor;
end $$
delimiter ;

select descricao, aumenta_preco(valor,30.00) as 'novo valor'
from procedimento
where id_procedimento = 1;

select descricao, aumenta_preco(valor,100.00) as 'novo valor'
from procedimento
where id_procedimento = 2;


 -- verificar o veterinario pelo seu nome --

delimiter $$
create procedure verveterinarios(in id int, out nome varchar(100))
begin 
     select nome_veterinario
     into nome
     from veterinario
     where id_veterinario = id;
end $$
delimiter ;

call verveterinarios(1,@nome);
call verveterinarios(4,@nome);
select @nome as 'verificar o veterinario o sistema';


-- consultar o cpf do veterinario cadastrado

delimiter $$
create function verificar_funcionarios_existentes(cpf varchar (11))
returns varchar(100)
begin
declare mensagem varchar(100);
case
		when cpf ='123456987' then
			set mensagem ='usuario já cadastrado';
            
            when cpf ='741852963' then
            set mensagem ='usuario já cadastrado';
            
            when cpf ='741852369' then
			set mensagem ='usuario já cadastrado';
            
            when cpf ='369852147' then
			set mensagem ='usuario já cadastrado';
            else
            set mensagem =' novo cpf em cadastro';
            end case;
return mensagem;
end $$
delimiter ;

select verificar_funcionarios_existentes('123456987') as 'situação do cpf informado';
select verificar_funcionarios_existentes('741852963') as 'situação do cpf informado';
select verificar_funcionarios_existentes('741852369') as 'situação do cpf informado';
select verificar_funcionarios_existentes('369852147') as 'situação do cpf informado';
select verificar_funcionarios_existentes('01586295235') as 'situação do cpf informado';


-- consultando o veterinario, sua especialização e a clinica onde atua;

delimiter $$
create procedure veterinario_especializacao(in nome varchar (100))
begin
select veterinario.nome_veterinario,veterinario.especializacao,clinica.nome_clinica,clinica.estado
from clinica
inner join veterinario
on clinica.id_clinica = veterinario.id_clinica
where veterinario.nome_veterinario = nome;
end$$
delimiter ;

call veterinario_especializacao('suelen');


-- contando quantos profissionais atuam na clinica

select nome_veterinario, count(especializacao)
from veterinario
group by nome_veterinario
having count(especializacao);


-- verificando se o cliente existe no sistema, consultando pelo cpf cadastrado
drop procedure vercliente;
delimiter $$
create procedure vercliente(in cpf varchar(11), out nome varchar(11))
begin 
     select nome_cliente
     into nome
     from cliente
     where cpf_cliente = cpf;
end $$
delimiter ;

call vercliente('741852369',@nome);
call vercliente('963852147',@nome);
select @nome as 'cliente cadastrado';



-- verificando o horario agendado

-- verificando o horario agendado
set global log_bin_trust_function_creators=1;
DELIMITER $$
CREATE FUNCTION  veragendamento()
returns  datetime
BEGIN
declare mensagem varchar(100);
    
    IF NEW.data_hora_inicio > NEW.data_hora_fim THEN
       set mensagem = 'A data de início não pode ser maior que a data de fim';
    END if;
    -- Verificar se há  agendamentos existentes 
    IF EXISTS (
        SELECT 1
        FROM agendamento
        WHERE id_consulta = NEW.id_consulta
          AND ((data_hora_inicio, data_hora_fim)And(new.data_hora_inicio,new.data_hora_fim))
    )
    THEN
        set mensagem = 'impossível agendar - existe outro compromisso';
    END IF;
RETURN mensagem;
END $$
DELIMITER ;

create trigger verhorario  before insert
on agendamento
for each row
set new.data_hora_inicio  = data_hora_inicio and new.data_hora_fim = data_hora_fim and new.id_veterinario = id_veterinario
;


delimiter $$
create trigger verhorario_updt before update 
on agendamento
for each row
begin
call veragendamento();
end$$
delimiter ;

select data_hora_inicio,data_hora_fim,id_veterinario from agendamento;

SELECT COUNT(*) FROM agendamento WHERE  data_hora_inicio ='2023-02-04 09:00:00' and data_hora_fim='2023-02-04 09:30:00';
SELECT COUNT(*) FROM agendamento WHERE  data_hora_inicio ='2023-02-04 09:00:00' and data_hora_fim='2023-02-04 09:32:00';


-- verificando o procedimento e o pagamento

select procedimento.nome_cliente,procedimento.descricao,procedimento.valor,pagamento.data_pagamento
from procedimento
inner join pagamento
on procedimento.id_procedimento = pagamento.id_pagamento
order by nome_cliente asc;

-- retornando a informação da clinica e seu estado junto ao cliente e seu pet.
select   clinica.id_clinica,nome_clinica,clinica.estado,nome_cliente,nome_pet
from clinica
inner join cliente
on cliente.id_clinica = clinica.id_clinica
inner join pet
on pet.id_pet = clinica.id_clinica;


-- retornará  a clinica,estado,cliente,pet,o seu id do historico atendimento e diagnostico.
select  distinctrow clinica.id_clinica,clinica.nome_clinica,clinica.estado,cliente.nome_cliente,pet.nome_pet,historicoatendimento.historico_atendimento,historicoatendimento.diagnostico
from clinica
inner join cliente
on cliente.id_clinica = clinica.id_clinica
inner join pet
on pet.id_clinica = clinica.id_clinica
inner join historicoatendimento
on historicoatendimento.id_clinica = clinica.id_clinica
order by nome_cliente;

-- retorna os procedimentos que são retornos

select distinct procedimento.status_retorno,procedimento.data_procedimento,procedimento.descricao,cliente.nome_cliente
from cliente
inner join procedimento
on cliente.id_cliente = procedimento.id_cliente
where status_retorno ='nao';