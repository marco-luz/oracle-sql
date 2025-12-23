-- 1. UNION
--    Combina os resultados de duas ou mais consultas SELECT, eliminando linhas duplicadas no resultado final.

SELECT employee_id, job_id, hire_date, salary
  FROM employees
 WHERE department_id IN (60, 90, 100)
 
 UNION
 
SELECT employee_id, job_id, hire_date, salary
  FROM employees
 WHERE job_id = 'IT_PROG'
 ORDER BY employee_id;


-- 2. UNION ALL
--    Combina os resultados de duas ou mais consultas SELECT, mantendo todas as linhas, inclusive duplicadas.

SELECT employee_id, job_id, hire_date, salary
  FROM employees
 WHERE job_id = 'IT_PROG'
 
 UNION ALL

SELECT employee_id, job_id, hire_date, salary
  FROM employees
 WHERE department_id = 60
 ORDER BY employee_id;


-- 3. INTERSECT
--    Retorna apenas as linhas que existem simultaneamente nos resultados de todas as consultas.

SELECT employee_id, job_id
  FROM employees
 WHERE job_id = 'IT_PROG'

INTERSECT

SELECT employee_id, job_id
  FROM employees
 WHERE department_id IN (60, 90, 100)
 ORDER BY employee_id;


-- 4. MINUS
--    Retorna as linhas da primeira consulta que não existem na segunda.

SELECT employee_id, job_id
  FROM employees
 WHERE department_id IN (60, 90, 100)
 
 MINUS

SELECT employee_id, job_id
  FROM employees
 WHERE job_id = 'IT_PROG'
 ORDER BY employee_id;


-------------------------------------------------------------
-- Comparativo Resumido

-- Operador	    Remove Duplicados	Finalidade Principal
-- --------     -----------------   --------------------
-- UNION	    Sim	                União sem repetição
-- UNION ALL	Não	                União completa
-- INTERSECT	Sim	                Registros comuns
-- MINUS	    Sim	                Diferença entre conjuntos
-------------------------------------------------------------


-- Utilizando mais de um operador SET

SELECT employee_id, job_id, hire_date, salary
  FROM   employees
 WHERE  department_id IN (60, 90, 100)
 
 UNION
 
(SELECT employee_id, job_id, hire_date, salary
   FROM   employees
  WHERE  job_id = 'IT_PROG'
  
 INTERSECT
 
 SELECT employee_id, job_id, hire_date, salary
   FROM   employees
  WHERE  salary > 10000
)
ORDER BY employee_id;