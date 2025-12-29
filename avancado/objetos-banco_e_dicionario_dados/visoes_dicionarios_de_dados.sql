-- Quais informacoess as Visoes do Dicionario de Dados contem?

-- Informações sobre:
-- · Objetos do banco de dados, tais como: tabelas, visões, sequencias, índices, procedures, funções, etc
-- · Usuários do banco de dados
-- · Constraints
-- · Privilégios
-- · Informações sobre o banco de dados, tais como: tablespaces, datafiles, tempfiles, etc
-- · E muitas outras informações sobre o banco de dados


DESC dictionary

SELECT *
  FROM dictionary
 ORDER BY table_name;

SELECT *
  FROM dictionary
 WHERE table_name = 'USER_TABLES'
 ORDER BY table_name;

SELECT *
  FROM dict
 WHERE table_name LIKE '%TABLES%'
 ORDER BY table_name;



-- Consultando as Visoes do Dicionario de Dados

SELECT * FROM user_objects;

SELECT * FROM user_tables;

SELECT * FROM user_sequences;

SELECT * FROM user_views;



-- Conectar como usuario sys

SELECT *
  FROM dba_objects 
 WHERE owner = 'HR';

SELECT *
  FROM dba_tables
 WHERE owner = 'HR';

SELECT *
  FROM dba_sequences
 WHERE sequence_owner = 'HR';

SELECT *
  FROM dba_views
 WHERE owner = 'HR';

SELECT * FROM dba_users;

SELECT * FROM dba_tablespaces;

SELECT * FROM dba_data_files;

SELECT * FROM dba_temp_files;




-- Diferencas entre as Visoes com prefixo USER, ALL e DBA
-- 
-- · Prefixo USER: Inclui objetos do schema do usuário que está conectado.
-- · Prefixo ALL: Inclui objetos do schema do usuário que está conectado e objetos que o usuário possui privilégios de acesso.
-- · Prefixo DBA : Inclui todos os objetos do banco de dados. 
--   Somente os DBA's ou usuario para os que possuem os privilégios necessários podem acessar.

SELECT * FROM USER_OBJECTS;

SELECT * FROM ALL_OBJECTS;

-- Conectar como usuario SYS

SELECT * 
  FROM DBA_OBJECTS
 WHERE owner = 'HR';
 

-- Consultando informacoes sobre tabelas

SELECT * FROM USER_TABLES;

SELECT * FROM ALL_TABLES;

-- Conectar como usuario SYS

SELECT *
  FROM DBA_TABLES
 WHERE owner = 'HR';


-- Consultando informacoes sobre colunas de tabelas

SELECT *
  FROM USER_TAB_COLUMNS
 WHERE table_name = 'EMPLOYEES' 
 ORDER BY column_id;


SELECT *
  FROM ALL_TAB_COLUMNS
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES' 
 ORDER BY column_id;

-- Conectar como usuario SYS

SELECT *
  FROM DBA_TAB_COLUMNS
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES' 
 ORDER BY column_id;


-- Consultando informacoes sobre constraints de tabelas

SELECT *
  FROM USER_CONSTRAINTS
 WHERE table_name = 'EMPLOYEES';

SELECT *
  FROM ALL_CONSTRAINTS
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES';

-- Conectar como usuario SYS

SELECT *
  FROM DBA_CONSTRAINTS
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES';



-- Consultando informacoes sobre colunas de uma constraint

SELECT *
  FROM USER_CONS_COLUMNS
 WHERE table_name = 'EMPLOYEES' 
   AND constraint_name = 'EMP_EMP_ID_PK'
 ORDER BY position;

SELECT *
  FROM ALL_CONS_COLUMNS
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES' 
   AND constraint_name = 'EMP_EMP_ID_PK'
 ORDER BY position;

-- Conectar como usuario SYS

SELECT *
  FROM DBA_CONS_COLUMNS
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES' 
   AND constraint_name = 'EMP_EMP_ID_PK'
 ORDER BY position;
 
 

-- Consultando informacoes sobre indices de tabelas

SELECT *
  FROM USER_INDEXES
 WHERE table_name = 'EMPLOYEES';

SELECT *
  FROM ALL_INDEXES
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES';

-- Conectar como usuario SYS

SELECT *
  FROM DBA_INDEXES
 WHERE owner = 'HR' 
   AND table_name = 'EMPLOYEES';


-- Consultando informacoes sobre colunas que compoem indices de tabelas

SELECT *
  FROM USER_IND_COLUMNS
 WHERE table_name = 'EMPLOYEES'  AND
       index_name = 'EMP_EMP_ID_PK';

SELECT *
  FROM ALL_IND_COLUMNS
 WHERE index_owner = 'HR' AND 
       table_name = 'EMPLOYEES' AND
       index_name = 'EMP_EMP_ID_PK';

-- Conectar como usuario SYS

SELECT *
  FROM DBA_IND_COLUMNS
 WHERE index_owner = 'HR' AND 
       table_name = 'EMPLOYEES'  AND
       index_name = 'EMP_EMP_ID_PK';
       
       
       
-- Consultando informacoes sobre sequences

SELECT * FROM USER_SEQUENCES;

SELECT *
  FROM ALL_SEQUENCES
 WHERE sequence_owner = 'HR';

-- Conectar como usuario sys

SELECT *
  FROM dba_sequences
 WHERE sequence_owner = 'HR';



-- Consultando informacoes sobre views

-- Conectar como usuario hr

SELECT *
  FROM USER_VIEWS;

SELECT *
  FROM ALL_VIEWS
 WHERE owner = 'HR';

-- Conectar como usuario sys

SELECT *
  FROM dba_views
 WHERE owner = 'HR';



-- Consultando informacoes sobre o banco de dados

-- Conectar como usuario sys

SELECT * FROM dba_users;

SELECT * FROM dba_tablespaces;

SELECT * FROM dba_data_files;

SELECT * FROM dba_temp_files;



--------------------------------------------------------------------------------
-- Visoes Dinamicas de Performance

-- As visões de com prefixo V$ Incluem informações sobre:
-- · Performance
-- · A instância do banco de dados
-- · As estruturas de memória da Instância
-- · As estruturas de físicas do banco de dados, tais como: controlfiles, datafiles, tempfiles
-- · Somente os usuários DBA's podem acessá-las ou usuarios que possuirem os privilégios necessários

-- Conectar como usuario sys

SELECT * FROM v$tablespace;

SELECT * FROM v$datafile;

SELECT file#, name, bytes/1024/1024 MB, blocks, status
  FROM v$datafile;

SELECT * FROM v$tempfile;

SELECT file#, name, bytes/1024/1024 MB, blocks, status 
  FROM v$tempfile;

SELECT * FROM v$controlfile;

SELECT * FROM v$parameter;

SELECT * 
  FROM v$parameter
 WHERE name = 'db_block_size';