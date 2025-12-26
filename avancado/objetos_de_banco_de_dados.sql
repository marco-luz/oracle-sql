--
-- Schema Objects
--
-- · Schema Objects é uma coleção de estruturas lógicas de objetos
-- · Um Usuário de banco de dados Oracle possui um e somente um schema com o mesmo nome do seu username
-- · Existem muito Schema Objects, mas vamos focar somente naqueles que serão abordados no curso


-- Tipo de Objeto
-- 
-- · Tabela
--   Unidade base do banco de dados para armazenar dados, composta por linhas e colunas.
-- 
-- · Sinônimo
--   Um nome alternativo para um objeto do banco de dados.
-- 
-- · View
--   Uma consulta SQL armazenada o dicionário de dados referenciando tabelas ou outras views.
-- 
-- · Materialized View
--   Possui uma tabela real preenchida com o resultado de uma consulta SQL como nas views normais. 
--   Existe uma tabela real que é esvaziada (truncated) e repreenchida com uma frequencia especificada.
-- 
-- · Constraint
--   São regras de restrição para validação de entrada de dados em tabelas.
--
-- · Database Links
--   São conexões entre dois bancos de dados físicos.
--
-- · Índices
--   São utilizados para melhora a performance da recuperação de dados de uma tabela.
--
-- · Procedure e Função
--   Procedures são unidades de programa codificadas em PL/SQL compiladas e salvas no banco de dados Oracle.
--   Você pode realizar chamadas a procedures e funções de qualquer ambiente que se conecte ao Oracle. 
--   Funções retornam um valor, procedures não retornam valor.
--
-- · Package
--   São schema objects codificadas em PL/SQL compiladas e salvas no banco de dados Oracle.
--   Uma package (pacote) pode conter: procedures, funções, cursores, exceções, variáveis e constantes.
--
-- · Triggers
--   São unidades de programa compiladas e armazenadas no banco de dados e executadas automaticamente para um evento específico do banco de dados.
--
-- · Sequence
--   São objetos do banco de dados utilizados para geração de números sequenciais únicos.
--   Sequences são geralmente utilizadas para geração de números para valores de Primary Keys.



-- Nonschema Objects
--
-- · Outros tipos de objetos do banco de dados são chamados de Nonschema Objects
-- · Estes objetos não pertencem a um Schema, são objetos de administração do banco de dados
-- · Exemplos de Nonchema Objects: directories, roles, tablespaces, users, etc



-- Conectar como usuário HR

DESC user_objects

SELECT object_name, object_type, status
  FROM user_objects
 ORDER BY object_type;

-- Conectar como usuário SYS (DBA)

DESC DBA_OBJECTS

SELECT owner, object_name, object_type, status
  FROM dba_objects
 WHERE owner = 'HR'
 ORDER BY object_type;

-- Exemplos de consultas a Nonschema Objects pelo Dicionario de Dados Oracle

SELECT *
  FROM dba_tablespaces;

SELECT *
  FROM dba_users;






-- Referenciando Objetos de outro Schema (Usuário)

-- Requisitos:
-- · Possuir os privilégios de objeto necessários para o comando a ser realizado
-- · Prefixar (qualificar) o nome do objeto com o nome do schema a qual ele pertence ou utilizar um sinônimo público para o objeto e referenciar sinônimo público

-- Conectar como usuário hr

-- Consultando a Tabela employees do schema do usuário HR

SELECT *
FROM   employees;

SELECT *
FROM   hr.employees;

-- Conectar como usuário sys (DBA)

-- Criar o usuário ALUNO

create user aluno
identified by aluno
default tablespace users
temporary tablespace temp
quota unlimited on users;

grant create session to aluno;


-- Criar uma conexão no SQL Developer para o usuário ALUNO para o banco XEPDB1


-- Conectar como usuário aluno

-- Consultando a Tabela employees do schema do usuário HR

SELECT *
  FROM hr.employees;

-- Erro ORA-00942: a tabela ou view não existe

-- Conectar como usuário hr ou como usuário sys (DBA)

-- Passar o privilégo SELECT no objeto hr.employees para o usuário aluno

GRANT SELECT on hr.employees to aluno;

-- Conectar como usuário aluno

SELECT *
  FROM hr.employees;


-- Conectar como usuário sys (DBA)

-- criar um sinonimo público employees para hr.employees

drop public synonym employees;

create public synonym employees for hr.employees;

-- Conectar como usuário aluno

SELECT *
  FROM employees;


