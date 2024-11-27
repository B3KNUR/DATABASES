--1
CREATE OR REPLACE PROCEDURE increase_value(IN input_value INTEGER, OUT result INTEGER)
LANGUAGE plpgsql AS $$
BEGIN
    result := input_value + 10;
END;
$$;

--2
CREATE OR REPLACE PROCEDURE compare_numbers(
    num1 INTEGER,
    num2 INTEGER,
    OUT result TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    IF num1 > num2 THEN
        result := 'Greater';
    ELSIF num1 = num2 THEN
        result := 'Equal';
    ELSE
        result := 'Lesser';
    END IF;
END;
$$;

--3
CREATE OR REPLACE PROCEDURE number_series(
    n INTEGER,
    OUT result TEXT
)
LANGUAGE plpgsql AS $$
DECLARE i INTEGER;
BEGIN
    result := '';
    FOR i IN 1..n LOOP
        result := result || i || ' ';
    END LOOP;
END;
$$;

--4
CREATE OR REPLACE PROCEDURE find_employee(
    emp_name TEXT,
    OUT emp_details TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT CONCAT('ID: ', id, ', Name: ', name, ', Position: ', position, ', Salary: ', salary)
    INTO emp_details
    FROM employees
    WHERE name = emp_name;

    IF NOT FOUND THEN
        emp_details := 'No employee found with given name';
    END IF;
END;
$$;

--5
CREATE OR REPLACE PROCEDURE list_products(
    category_name TEXT,
    OUT product_cursor REFCURSOR
)
LANGUAGE plpgsql AS $$
BEGIN
    OPEN product_cursor FOR
    SELECT id, name, category, price, stock
    FROM products
    WHERE category = category_name;
END;
$$;

--6
CREATE OR REPLACE PROCEDURE calculate_bonus(
    emp_id INT,
    bonus_percentage NUMERIC,
    OUT bonus_amount NUMERIC
)
LANGUAGE plpgsql AS $$
DECLARE
    emp_salary NUMERIC;
BEGIN
    SELECT salary INTO emp_salary
    FROM employees
    WHERE id = emp_id;

    bonus_amount := emp_salary * (bonus_percentage / 100);
END;
$$;

CREATE OR REPLACE PROCEDURE update_salary(
    emp_id INT,
    bonus_percentage NUMERIC
)
LANGUAGE plpgsql AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    CALL calculate_bonus(emp_id, bonus_percentage, bonus);

    UPDATE employees
    SET salary = salary + bonus
    WHERE id = emp_id;

    RAISE NOTICE 'Salary updated for Employee ID %: Bonus = %', emp_id, bonus;
END;
$$;

CREATE OR REPLACE PROCEDURE complex_calculation(
    num1 INT,
    num2 INT,
    str1 VARCHAR,
    OUT final_result TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    sum_result INT;
    str_result TEXT;
BEGIN
    <<main_block>>
    BEGIN
        <<numeric_block>>
        BEGIN
            sum_result := num1 + num2;
            RAISE NOTICE 'Sum of numbers: %', sum_result;
        END numeric_block;

        <<string_block>>
        BEGIN
            str_result := upper(str1);
            RAISE NOTICE 'Uppercase string: %', str_result;
        END string_block;

        final_result := 'sum: ' || sum_result || ', uppercase: ' || str_result;
    END main_block;
END;
$$;
