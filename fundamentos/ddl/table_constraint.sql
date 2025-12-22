-- CONSTRAINT
--   Uma constraint em Oracle é um mecanismo nativo do banco de dados que assegura a integridade dos dados, 
--   fazendo cumprir regras estruturais e de negócio diretamente no SGBD.
--
--   Principais tipos de constraints no Oracle:
--
--   PRIMARY KEY
--     - Identifica de forma única cada registro da tabela.
--     - Não permite valores NULL nem duplicados.
--     - Cria automaticamente um índice único.
--   FOREIGN KEY (ou REFERENCES)
--     - Garante a integridade referencial entre tabelas.
--     - Exige que o valor exista na tabela pai ou seja NULL (se permitido).
--   UNIQUE
--     - Garante que os valores de uma coluna ou conjunto de colunas não se repitam.
--     - Permite valores NULL (com algumas particularidades no Oracle).
--   NOT NULL
--     - Impede que a coluna receba valores NULL.
--     - É uma restrição de obrigatoriedade de preenchimento.
--   CHECK
--     - Define uma condição lógica que os dados devem satisfazer.
--     - Exemplo: valores maiores que zero, faixas válidas, domínios específicos.
-----------------------------------------------------------------------------------------------------------

CREATE TABLE clientes (
    id_cliente      NUMBER,
    nome            VARCHAR2(100),
    email           VARCHAR2(150),
    data_cadastro   DATE,
    status          CHAR(1),

    CONSTRAINT pk_clientes          PRIMARY KEY (id_cliente),       -- Identifica de forma única cada registro da tabela. Cria automaticamente um índice único.
    CONSTRAINT uk_clientes_email    UNIQUE (email),                 -- Garante que os valores de uma coluna ou conjunto de colunas não se repitam.
    CONSTRAINT ck_clientes_status   CHECK (status IN ('A', 'I')),   -- Define uma condição lógica que os dados devem satisfazer.
    CONSTRAINT nn_clientes_nome     CHECK (nome IS NOT NULL),
    CONSTRAINT nn_clientes_email    CHECK (email IS NOT NULL)
);

CREATE TABLE pedidos (
    id_pedido     NUMBER,
    id_cliente    NUMBER,
    valor_total   NUMBER(10,2),
    status        VARCHAR2(20),
    data_pedido   DATE,

    CONSTRAINT pk_pedidos                   PRIMARY KEY (id_pedido),
    CONSTRAINT uk_pedidos_id_cliente_data   UNIQUE (id_cliente, data_pedido),
    CONSTRAINT fk_pedidos_cliente           FOREIGN KEY (id_cliente)           REFERENCES clientes (id_cliente),   -- Garante a integridade referencial entre tabelas.
    CONSTRAINT ck_pedidos_status            CHECK (status IN ('ABERTO', 'PAGO', 'CANCELADO'))
);

-- ** A ordem de criação é importante: CLIENTES deve ser criada antes de PEDIDOS, devido à foreign key.

-------------------------------------------------------------------------------------------------------
--  PRIMARY KEY
--    - Definida no nível de tabela, garantindo unicidade e não nulidade de id_pedido.
--  UNIQUE
--    - Garante que um mesmo cliente não tenha dois pedidos na mesma data.
--  FOREIGN KEY
--    - Assegura a integridade referencial com a tabela clientes.
--  CHECK (regra de negócio)
--    - Envolve múltiplas colunas (status e valor_total).
--  CHECK (domínio de valores)
--    - Restringe os valores permitidos para a coluna status.
-------------------------------------------------------------------------------------------------------

-- 1. Listar todas as constraints da tabela PEDIDOS
SELECT constraint_name,
       constraint_type,
       status,
       validated,
       deferrable,
       deferred
  FROM user_constraints
 WHERE table_name = 'PEDIDOS'
 ORDER BY constraint_type, constraint_name;

-- Significado dos principais campos
--   CONSTRAINT_TYPE
--   P : Primary Key
--   R : Foreign Key (Referential)
--   U : Unique
--   C : Check (inclui NOT NULL)
--
--   STATUS
--   ENABLED ou DISABLED
--
--   VALIDATED
--   VALIDATED ou NOT VALIDATED
--
--   DEFERRABLE / DEFERRED
--   Indicam se a constraint pode ser adiada para o COMMIT


-- 2. Ver as colunas envolvidas em cada constraint
SELECT c.constraint_name,
       c.constraint_type,
       col.column_name,
       col.position
  FROM user_constraints c
  JOIN user_cons_columns col ON c.constraint_name = col.constraint_name
 WHERE c.table_name = 'PEDIDOS'
 ORDER BY c.constraint_name, col.position;

-- A coluna POSITION indica a ordem da coluna dentro da constraint.
--   Para CHECK que envolvem múltiplas colunas, todas aparecerão listadas.


-- 3. Consultar a condição de uma constraint CHECK
SELECT constraint_name,
       search_condition
  FROM user_constraints
 WHERE table_name = 'PEDIDOS'
   AND constraint_type = 'C';

-- SEARCH_CONDITION contém a expressão lógica do CHECK.
--   O conteúdo pode ser longo; em ferramentas como SQL*Plus pode ser necessário: SET LONG 10000


-- 4. Identificar a tabela e coluna referenciada por uma FOREIGN KEY
SELECT fk.constraint_name       AS fk_name,
       pk.table_name            AS tabela_referenciada,
       pk.constraint_name       AS pk_ou_uk_referenciada
  FROM user_constraints fk
  JOIN user_constraints pk ON fk.r_constraint_name = pk.constraint_name
 WHERE fk.table_name = 'PEDIDOS'
   AND fk.constraint_type = 'R';


-- 5. Consultar constraints NOT NULL (detalhe importante)

-- No Oracle, NOT NULL aparece como constraint do tipo C, mas não possui SEARCH_CONDITION explícita.
SELECT c.constraint_name,
       column_name
  FROM user_constraints c
  JOIN user_cons_columns col ON c.constraint_name = col.constraint_name
 WHERE c.table_name = 'PEDIDOS'
   AND c.constraint_type = 'C'
   AND c.search_condition IS NULL;


---------------------------------------------------------------------------------------------------
-- Resumo prático

--   USER_CONSTRAINTS :  informações gerais da constraint
--   USER_CONS_COLUMNS : colunas envolvidas
--   SEARCH_CONDITION :  regra do CHECK
--   R_CONSTRAINT_NAME : vínculo com PK/UK referenciada