-- Sinomimo é um objeto do oracle que serve para dar um outro nome para outro objeto.

-- Uso de Sinônimos
-- Com Sinonimos, você pode:
-- · Criar uma forma fácil de referenciar uma tabela que é de propriedade de outro usuário
-- · Criar um nome reduzido para um objeto
-- · Criar outro nome lógico para um objeto

-- Os sinomimos criados são privados, apenas o DBA pode criar sinomimos publicos.

CREATE SYNONYM departamentos
   FOR departments;

CREATE SYNONYM dept
   FOR departments;

-- Utilizando Sinônimos

SELECT *
  FROM departamentos;

SELECT *
  FROM dept;

-- Removendo Sinônimos

DROP SYNONYM departamentos;

DROP SYNONYM dept;


-- Criando Sinônimos Públicos para Tabelas em outro Schema

-- Conecte-se como SYS

CREATE PUBLIC SYNONYM departamentos
   FOR hr.departments;

CREATE PUBLIC SYNONYM dept
   FOR hr.departments;

-- Conecte-se como SYS

SELECT *
  FROM departamentos;

SELECT *
  FROM dept;

-- Conecte-se como HR

SELECT *
  FROM departamentos;

SELECT *
  FROM dept;

-- Removendo Sinônimos Públicos

-- Conecte-se como SYS

DROP PUBLIC SYNONYM departamentos;

DROP PUBLIC SYNONYM dept;
