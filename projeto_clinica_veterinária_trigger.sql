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