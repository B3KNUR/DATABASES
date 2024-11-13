--1
CREATE INDEX countries_name
ON countries(name);

SELECT * FROM countries WHERE name = ‘string’;

--2
CREATE INDEX employees_name_surname
ON employees(name, surname);

SELECT * FROM employees WHERE name = ‘string’
AND surname = ‘string’;

--3
CREATE UNIQUE INDEX unique_employees_salary
ON employees(salary);

SELECT * FROM employees WHERE salary < value1
AND salary > value2;

--4
CREATE INDEX idx_employees_name_substring
ON employees (name);

SELECT * FROM employees
WHERE substring(name from 1 for 4) = 'abcd';

--5
CREATE INDEX departments_department_id_budget ON departments(department_id, budget);

CREATE INDEX employees_department_id_salary ON employees(department_id, salary);

SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id WHERE
d.budget > value2 AND e.salary < value2;