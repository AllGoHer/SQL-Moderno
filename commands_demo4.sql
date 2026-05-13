SELECT * FROM ecommerce.products;

--Inline

SELECT product_id, 
	product_name, 
	(SELECT COUNT(product_id) FROM ecommerce.products) AS total_products
FROM ecommerce.products;

--Correlated

SELECT * FROM ecommerce.categories;

SELECT category_name, category_id
FROM ecommerce.categories c
WHERE EXISTS (
	SELECT 1
	FROM ecommerce.products p 
	WHERE c.category_id = p.category_id 
	AND p.price > 20
	);

--Derived Table

SELECT *
FROM (
	SELECT category,
	SUM(price) AS total
	FROM ecommerce.products 
	GROUP BY category
	) AS t
WHERE total > 20;

--Joins

SELECT * FROM ecommerce.customers;

SELECT 
    o.order_id,
    c.first_name AS customer_name,
    o.quantity
FROM ecommerce.orders o
INNER JOIN ecommerce.customers c 
    ON o.customer_id = c.customer_id;

SELECT 
    o.order_id,
    c.first_name AS customer_name,
    o.quantity
FROM ecommerce.orders o
RIGHT JOIN ecommerce.customers c 
    ON o.customer_id = c.customer_id;

SELECT 
    o.order_id,
    c.first_name AS customer_name,
    o.quantity
FROM ecommerce.orders o
FULL JOIN ecommerce.customers c 
    ON o.customer_id = c.customer_id;

SELECT 
    o.order_id,
    c.first_name AS customer_name,
    o.quantity
FROM ecommerce.orders o
CROSS JOIN ecommerce.customers c;

--Show all unique customer IDs that appear either in orders or in customers.

SELECT customer_id FROM ecommerce.orders
UNION
SELECT customer_id FROM ecommerce.customers;

--Same as above, but keep duplicates

SELECT customer_id FROM ecommerce.orders
UNION ALL
SELECT customer_id FROM ecommerce.customers;

--Find customers who have placed at least one order

SELECT customer_id FROM ecommerce.orders
INTERSECT
SELECT customer_id FROM ecommerce.customers;

--Find customers who registered but never placed an order.

SELECT customer_id FROM ecommerce.customers
EXCEPT
SELECT customer_id FROM ecommerce.orders;

