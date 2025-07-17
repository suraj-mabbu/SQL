-- Step 1: Create database
CREATE DATABASE m;
USE m;

-- Step 2: Create DRIVER table with constraints
CREATE TABLE driver (
    did INT PRIMARY KEY,                           -- unique driver ID
    dname VARCHAR(30) NOT NULL,                    -- name required
    phone VARCHAR(10) UNIQUE,                      -- unique phone number
    age INT CHECK (age >= 21),                     -- must be at least 21
    salary DECIMAL(8,2) DEFAULT 20000.00           -- default salary
);

-- Step 3: Create CUSTOMER table with constraints
CREATE TABLE customer (
    cid INT PRIMARY KEY,                           -- unique customer ID
    cname VARCHAR(30) NOT NULL,                    -- name required
    phone VARCHAR(10) UNIQUE,                      -- unique phone number
    city VARCHAR(20) DEFAULT 'Mumbai'              -- default city
);

-- Step 4: Insert drivers (including duplicates for group by)
INSERT INTO driver (did, dname, phone, age, salary) VALUES
(1, 'Raj', '9876543210', 30, 25000),
(2, 'Ravi', '9876543211', 28, 24000),
(3, 'Amit', '9876543212', 33, 27000),
(4, 'Karthik', '9876543213', 29, 23000),
(5, 'Raj', '9876543214', 35, 26000);  -- duplicate name for group by

-- Step 5: Insert customers (with duplicate names for group by)
INSERT INTO customer (cid, cname, phone, city) VALUES
(0, 'Jay', '9000000001', 'Pune'),
(2, 'Arya', '9000000002', 'Delhi'),
(3, 'Kartik', '9000000003', 'Mumbai'),
(4, 'Suraj', '9000000004', 'Mumbai'),
(5, 'Arya', '9000000005', 'Mumbai');  -- duplicate name for group by

-- Step 6: Update name
UPDATE customer SET cname = 'Kartik' WHERE cid = 3;

-- Step 7: Aggregate functions
SELECT COUNT(cid) FROM customer;
SELECT AVG(cid) FROM customer;
SELECT SUM(cid) FROM customer;
SELECT MIN(cid) FROM customer;
SELECT MAX(cid) FROM customer;

-- Step 8: String functions
SELECT cname, UPPER(cname) AS Uppercase FROM customer;
SELECT cname, LOWER(cname) AS Lowercase FROM customer;
SELECT cname, REVERSE(cname) AS Reverse FROM customer;
SELECT dname, CHAR_LENGTH(dname) FROM driver;

-- Step 9: Pattern matching
SELECT dname FROM driver WHERE dname LIKE 'K%';       -- starts with K
SELECT dname FROM driver WHERE dname NOT LIKE 'K__';  -- not K followed by 2 letters

-- Step 10: Replace and Concat
SELECT REPLACE(dname, 'Amit', 'Naimish') AS updated_dname FROM driver;
SELECT CONCAT(cname, cid) AS combined_info FROM customer;

-- Step 11: Views
-- View from single table without condition
CREATE VIEW view_all_customers AS
SELECT * FROM customer;

-- View from single table with condition
CREATE VIEW view_customers_cid_above_2 AS
SELECT * FROM customer
WHERE cid > 2;

-- View from multiple tables without condition
CREATE VIEW view_driver_customer AS
SELECT driver.did, driver.dname, customer.cid, customer.cname
FROM driver
JOIN customer ON driver.did = customer.cid;

-- View from multiple tables with condition
CREATE VIEW view_driver_customer_kname AS
SELECT driver.did, driver.dname, customer.cid, customer.cname
FROM driver
JOIN customer ON driver.did = customer.cid
WHERE driver.dname LIKE 'K%';  -- Karthik

-- Drop and recreate view with extra field
DROP VIEW IF EXISTS view_all_customers;

CREATE VIEW view_all_customers AS
SELECT *, CHAR_LENGTH(cname) AS name_length
FROM customer;

-- Insert into view 
CREATE VIEW simple_customer_view AS
SELECT cid, cname, phone
FROM customer;

INSERT INTO simple_customer_view (cid, cname, phone)
VALUES (7, 'Riya', '9000000106');


-- Step 12: GROUP BY 

-- Group customers by name and count how many times each name appears
SELECT cname, COUNT(*) AS name_count
FROM customer
GROUP BY cname;

-- Group customers by name and get average of their cid
SELECT cname, AVG(cid) AS avg_id
FROM customer
GROUP BY cname;

-- Group customers by name and show only duplicates
SELECT cname, COUNT(*) AS name_count
FROM customer
GROUP BY cname
HAVING COUNT(*) > 1;

-- Step 13: ORDER BY

-- Ascending by name
SELECT * FROM customer
ORDER BY cname ASC;

-- Descending by name length
SELECT dname, CHAR_LENGTH(dname) AS name_length
FROM driver
ORDER BY name_length DESC;

-- Ascending cid and Descending cname
SELECT * FROM customer
ORDER BY cid ASC, cname DESC;
