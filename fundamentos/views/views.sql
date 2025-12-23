-- Criando uma Visão Simples

CREATE OR REPLACE VIEW vemployeesdept60
AS
SELECT employee_id, first_name, last_name, department_id, salary, commission_pct
  FROM employees
 WHERE department_id = 60;

DESC vemployeesdept60;


-- Criando uma Visão Complexa 

-- 1ª Forma com os alias no Create
CREATE OR REPLACE VIEW vdepartments_total (department_id, department_name, minsal, maxsal, avgsal)
AS
SELECT e.department_id,
       d.department_name,
       MIN(e.salary),
       MAX(e.salary),
       AVG(e.salary)
  FROM employees e 
  JOIN departments d ON (e.department_id = d.department_id)
 GROUP BY e.department_id, department_name;

-- 2ª Forma com as alias nas próprias colunas
CREATE OR REPLACE VIEW vdepartments_total
AS 
SELECT e.department_id department_id,
       d.department_name department_name,
       MIN(e.salary) minsal,
       MAX(e.salary) maxsal,
       AVG(e.salary) avgsal
  FROM employees e 
  JOIN departments d ON (e.department_id = d.department_id)
 GROUP BY e.department_id, department_name;

SELECT * 
FROM   vdepartments_total;


-- Utilizando a Cláusula CHECK OPTION
--   (para garantir a expressão da cláusula WHERE da view) * Fiz sem a clausula e depois com, teste e não deu diferença

CREATE OR REPLACE VIEW vemployeesdept100
AS
SELECT employee_id, first_name, last_name, department_id, salary
  FROM employees
 WHERE department_id = 100
  WITH CHECK OPTION CONSTRAINT vemployeesdept100_ck;


-- Utilizando a Cláusula READ ONLY
--   (para garantir a view não permita oparações DML)

CREATE OR REPLACE VIEW vemployeesdept20
AS
SELECT employee_id, first_name, last_name, department_id, salary
  FROM employees
 WHERE department_id = 20
  WITH READ ONLY;

UPDATE vemployeesdept20 SET salary = 7000 WHERE employee_id = 202;
-- Erro de SQL: ORA-42399: não é possível efetuar uma operação de DML em uma view somente para leitura


-- Removendo uma Visão

DROP VIEW vemployeesdept20;
