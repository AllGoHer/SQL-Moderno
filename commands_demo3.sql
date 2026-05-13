SELECT * FROM ecommerce.products;

--null, Coalesce, and NULLIF
SELECT product_name
FROM ecommerce.products
WHERE category_id IS NULL;

SELECT product_name, COALESCE(category_id, 0) AS cat_id
FROM ecommerce.products;

SELECT product_name, 100/NULLIF(price, 0) AS test
FROM ecommerce.products;

-- Conditional Logic

UPDATE ecommerce.products
SET category_id = CASE
    WHEN category = 'Electronics' THEN 1
    WHEN category = 'Home & Kitchen' THEN 2
    ELSE 0
END
WHERE category IN ('Electronics', 'Home & Kitchen');

--String, Numeric & Date Functions​

SELECT * FROM ecommerce.customers;

SELECT LOWER(first_name)
FROM customers;

SELECT CONCAT(first_name,' ',last_name)
FROM customers;

SELECT SUBSTRING(last_name FROM 2 FOR 3)
FROM customers;

SELECT LENGTH(first_name)
FROM customers;

SELECT REPLACE(city, 'Angeles', 'Sanatas')
FROM customers;

--Numeric Functions

SELECT ROUND(2.4563,2);

SELECT CEIL(2.4563);

SELECT FLOOR(2.4563);

SELECT ABS(45-75);

SELECT POWER(3,2);

SELECT RANDOM();

--Date & Time Functions

SELECT CURRENT_DATE;

SELECT AGE(CURRENT_DATE, '2025-11-1');

SELECT EXTRACT(YEAR FROM CURRENT_DATE);

SELECT now();

SELECT DATE_TRUNC('day', CURRENT_DATE);
