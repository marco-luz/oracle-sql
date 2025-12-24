-- Sequence é um tipo de objeto utilizado para geração automática de números Sequenceis.
--   Um dos principais usos de uma Sequence é gerar valores numéricos Sequenceis únicos 
--   que poderão ser utilizados como valores para Chaves Primarias de Tabelas,


-- Criando uma Sequence

SELECT MAX(employee_id)
  FROM employees;

DROP SEQUENCE employees_seq;


CREATE SEQUENCE employees_seq
START WITH 210                  -- valor do primeiro número
INCREMENT BY 1                  -- valor do incremento, de 1 em 1 por exemplo
NOMAXVALUE                      -- MAXVALUE (valor máximo que a sequence pode atingir) - NOMAXVALUE (não tem valor máximo)  
--NOMINVALUE                    -- MINVALUE (valor mínimo que a sequence por atingir em caso de INCREMEN BY -1) - NOMINVALUE (não tem valor mínimo)
NOCACHE                         -- CACHE (se determinar um número, ao atingir o número, o Oracle entrega em cache de memória (fica mais rápido)) 
                                -- NOCACHE (não usa o cache de memória, pega um número de cada vez.
NOCYCLE;                        -- CYCLE (se for MAXVALUE, ao atingir o valor máximo, a sequence volta ao início) - NOCYCLE (se for MAXVALUE, ao atingir o valor máximo ocorre um erro)


-- Consultando Sequences do pelo Dicionario de Dados

SELECT *
  FROM user_sequences;



-- Recuperando proximo valor da Sequence

-- · NEXTVAL: Retorna o próximo valor da Sequence, retorna um valor unico cada vez que é referenciado,
--   mesmo quando referenciado por usuários diferentes
-- · CURRVAL: Retorna o valor corrente da Sequence
--
-- Obs: Na sessão é necessário ser realizado uma referencia a pseudocoluna NEXTVAL antes de referenciar a pseudocoluna CURRVAL.

-- * Importante: só refencie o NEXTVAL se for utilziar o número, senão vai ficar um buraco na numeração

SELECT employees_seq.NEXTVAL
  FROM dual;

-- Recuperando o valor corrente da Sequence

SELECT employees_seq.CURRVAL
  FROM dual;

-- Removendo uma Sequence 

DROP SEQUENCE employees_seq;


-- Recriando uma Sequence

SELECT MAX(employee_id)
FROM   employees;

CREATE SEQUENCE employees_seq
START WITH 210
INCREMENT BY 1
NOMAXVALUE 
NOCACHE
NOCYCLE;


-- Utilizando uma Sequence 
-- ** Importante: na prática a sequence soh deve ser utilizada no INSERT

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
       VALUES (employees_seq.nextval, 'Paul', 'Simon', 'PSIMO@psimo2', '525.342.237', TO_DATE('12/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 15000, NULL, 103, 60);
       
       
-- ** Importante: se der erro, deve ser feito o DROP SEQUENCE pois o NEXTVAL, mesmo com o erro e mesmo com ROLLBACK, gera a sequence e deixa buracos.
--
-- Buracos na numeraçao gerada pela Sequencia podem ocorrer quando:
-- · Ocorre um rollback 
-- · A Sequencia foi definida com Cache de memória e ocorre um crash no sistema (banco de dados)
-- · A Sequencia é utilizada em outra tabela

SELECT *
  FROM employees
 ORDER BY employee_id DESC;



-- Modificando uma Sequence

ALTER SEQUENCE seq_pedido
INCREMENT BY 10
MAXVALUE 999999
  CYCLE;
  
  
--Alterar cache para melhorar performance

ALTER SEQUENCE seq_pedido
CACHE 50;


ALTER SEQUENCE employees_seq
MAXVALUE 999999
CACHE 20;