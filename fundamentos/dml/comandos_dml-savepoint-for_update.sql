-- INSERT

-- Insert utilizando data e hora especificas

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
     VALUES (208, 'Vito', 'Corleone', 'VCORL', '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 20000, NULL, 103, 60);
               
COMMIT;


-- Utilizando variaveis de Substituicao

INSERT INTO departments(department_id, department_name, location_id)
     VALUES (&department_id, '&department_name',&location);

COMMIT;


-- Inserindo linhas a partir de uma Sub-consulta

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
  FROM employees
 WHERE job_id = 'SA_REP';

COMMIT;



-- UPDATE

-- Utilizando o comando UPDATE com Sub-consultas

UPDATE employees
SET job_id = (SELECT job_id
              FROM employees
              WHERE employee_id = 141),
    salary = (SELECT salary
              FROM employees
              WHERE employee_id = 141)
WHERE employee_id = 140;

COMMIT;



-- DELETE

DELETE FROM countries
WHERE  country_name = 'Nigeria';

ROLLBACK;



-- SAVEPOINT
-- A cláusula SAVEPOINT é utilizada para marcar um ponto intermediário dentro de uma transação, 
-- permitindo desfazer apenas parte das operações realizadas, sem a necessidade de executar um ROLLBACK completo.

BEGIN
  INSERT INTO clientes VALUES (1, 'João');

  SAVEPOINT sp_clientes;

  INSERT INTO pedidos VALUES (100, 1);

  -- Algo deu errado aqui
  ROLLBACK TO sp_clientes;

  -- commita apenas o INSERT depois do SAVEPONINT
  COMMIT;
END;


INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
     VALUES (207, 'Rock', 'Balboa', 'DROCK', '525.342.237', SYSDATE, 'IT_PROG', 7000, NULL, 103, 60);
SAVEPOINT A;

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
     VALUES (208, 'Vito', 'Corleone', 'VCORL', '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 20000, NULL, 103, 60);
               
ROLLBACK TO SAVEPOINT  A;

COMMIT; 



-- Clausula FOR UPDATE no comando SELECT 
--   A cláusula FOR UPDATE em SQL é usada em conjunto com SELECT para bloquear as linhas selecionadas (linhas de uma tabela ou visualização) 
--   até o final da transação atual (COMMIT ou ROLLBACK), impedindo que outras transações as modifiquem ou as bloqueiem, 
--   garantindo assim a integridade e consistência dos dados em cenários concorrentes,

SELECT employee_id, salary, commission_pct, job_id
  FROM employees
 WHERE job_id = 'SA_REP'
   FOR UPDATE
 ORDER BY employee_id;

COMMIT;



SELECT e.employee_id, e.salary, e.commission_pct
  FROM employees e 
  JOIN departments d
 USING (department_id)
 WHERE job_id = 'ST_CLERK'AND location_id = 1500
   FOR UPDATE of e.salary
 ORDER BY e.employee_id;

COMMIT;