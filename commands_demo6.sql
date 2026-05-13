--View
--Create a view that shows each customer’s total amount spent.

CREATE VIEW ecommerce.vw_customer_spending AS
SELECT 
    c.customer_id,
    c.first_name,
    SUM(p.price * o.quantity) AS total_spent
FROM ecommerce.customers c
JOIN ecommerce.orders o ON c.customer_id = o.customer_id
JOIN ecommerce.products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name;

SELECT * FROM ecommerce.vw_customer_spending;

--Materialized View
--Create a materialized view that stores the same spending data for faster reads.

CREATE MATERIALIZED VIEW ecommerce.mv_customer_spending AS
SELECT 
    c.customer_id,
    c.first_name,
    SUM(p.price * o.quantity) AS total_spent
FROM ecommerce.customers c
JOIN ecommerce.orders o ON c.customer_id = o.customer_id
JOIN ecommerce.products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name;

SELECT * FROM ecommerce.mv_customer_spending;

INSERT INTO ecommerce.orders (customer_id, product_id, quantity)
VALUES
(2, 2, 1);

REFRESH MATERIALIZED VIEW ecommerce.mv_customer_spending;

--Functions​

--Create a function that takes product_id and quantity as input, calculates the total price, and returns it.

CREATE OR REPLACE FUNCTION ecommerce.fn_calculate_total(
    IN p_product_id INT,
    IN p_quantity INT,
    OUT total_price NUMERIC
)
AS $$
BEGIN
    SELECT price * p_quantity
    INTO total_price
    FROM ecommerce.products
    WHERE product_id = p_product_id;
END;
$$ LANGUAGE plpgsql;

SELECT ecommerce.fn_calculate_total(1, 3);

--Create a function that takes price and discount_percent as input, calculates the final price, and returns it.

CREATE OR REPLACE FUNCTION ecommerce.fn_apply_discount(
    INOUT price NUMERIC,
    IN discount_percent NUMERIC
)
AS $$
BEGIN
    price := price - (price * discount_percent / 100);
END;
$$ LANGUAGE plpgsql;

SELECT ecommerce.fn_apply_discount(100, 10);

--STORED PROCEDURE

--Create a procedure that increases all product prices in a given category by a given percentage.

CREATE OR REPLACE PROCEDURE ecommerce.sp_update_price_by_category(
    IN p_category VARCHAR,
    IN p_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ecommerce.products
    SET price = price + (price * p_percent / 100)
    WHERE category = p_category;

    RAISE NOTICE 'Prices updated for category: %', p_category;
END;
$$;

CALL ecommerce.sp_update_price_by_category('Electronics', 10);

--Exception Handling​

CREATE OR REPLACE FUNCTION ecommerce.fn_apply_discount(
    INOUT price NUMERIC,
    IN partition_by NUMERIC
)
AS $$
BEGIN
    price := price / partition_by;

EXCEPTION
    WHEN division_by_zero THEN
        RAISE NOTICE 'Division by zero occurred. Returning original price.';
END;
$$ LANGUAGE plpgsql;

SELECT ecommerce.fn_apply_discount(6, 0);

