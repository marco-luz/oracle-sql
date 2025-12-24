-- Como os indices sao criados?
--   Automaticamente:
--   · Um Índice Unico eh criado automaticamente quando voce define uma Constraint de PRIMARY KEY ou UNIQUE rta definicao da tabela

--   Manualmente:
--   · Usuários podem criar indices simples (uma coluna) ou compostos (mais de uma coluna) para melhorar a performance do acesso as linhas


DROP INDEX emp_name_ix;
DROP INDEX employees_last_name_idx;
DROP INDEX employees_name_idx;

SELECT *
  FROM employees
 WHERE last_name = 'Himuro';

-- Criando um Indice Simples

CREATE INDEX employees_last_name_idx
    ON employees(last_name);

-- Analize o custo do comando no plano de execução

SELECT *
  FROM employees
 WHERE last_name = 'Himuro';

-- Criando um Indice Composto

CREATE INDEX employees_last_name_first_name_idx
    ON employees(last_name, first_name);

-- Analize o custo do comando no plano de execução

SELECT *
  FROM employees
 WHERE last_name = 'Himuro' 
   AND first_name = 'Guy';

-- Reconstruindo e reorganizando um indice (conforme vai utilizando os indices, vai desorganizando)

ALTER INDEX employees_last_name_first_name_idx REBUILD;

-- Removendo um Índice

DROP INDEX employees_last_name_idx;

-- Consultando Indices

SELECT ix.index_name,
       ic.column_position,
       ic.column_name,
       ix.index_type,
       ix.uniqueness,
       ix.status
  FROM user_indexes ix
  JOIN user_ind_columns ic ON (ix.index_name = ic.index_name) AND 
                              (ix.table_name = ic.table_name)
 WHERE ix.table_name = 'EMPLOYEES'
 ORDER BY ix.index_name, ic.column_position; 

-- Removendo um indice

DROP INDEX employees_last_name_idx;

DROP INDEX employees_last_name_first_name_idx;
