--1
START TRANSACTION;

INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;


--2
START TRANSACTION;

IF (SELECT quantity FROM Books WHERE book_id = 3) >= 10 THEN
    INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
    VALUES (2, 3, 102, CURRENT_DATE, 10);

    UPDATE Books
    SET quantity = quantity - 10
    WHERE book_id = 3;

    COMMIT;
ELSE
    ROLLBACK;
END IF;


--3
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

UPDATE Books
SET price = 45.00
WHERE book_id = 1;


SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

SELECT price FROM Books WHERE book_id = 1;

COMMIT;

SELECT price FROM Books WHERE book_id = 1;


--4
START TRANSACTION;

UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;

SELECT * FROM Customers WHERE customer_id = 101;
