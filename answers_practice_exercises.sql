--E-commerce SQL Practice — 10 Exercises

--Retrieve all customer names and their cities.

SELECT first_name, last_name, city, state
FROM ecommerce.customers;

--Show product names and prices for products that are available (in_stock = TRUE).

SELECT product_name, price
FROM ecommerce.products
WHERE in_stock = TRUE;

--Display all customers sorted by their last name.

SELECT first_name, last_name, city
FROM ecommerce.customers
ORDER BY last_name ASC;

--How many total orders are there in the orders table?

SELECT COUNT(*) AS total_orders
FROM ecommerce.orders;

--Show each customer’s ID and total quantity of products they’ve ordered.

SELECT customer_id, SUM(quantity) AS total_items_ordered
FROM ecommerce.orders
GROUP BY customer_id;

--Show each order’s ID, customer name, and quantity.

SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.quantity
FROM ecommerce.orders o
JOIN ecommerce.customers c 
    ON o.customer_id = c.customer_id;

--For each customer, calculate the total value of their orders (price × quantity).

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.price * o.quantity) AS total_spent
FROM ecommerce.orders o
JOIN ecommerce.products p 
    ON o.product_id = p.product_id
JOIN ecommerce.customers c 
    ON o.customer_id = c.customer_id
GROUP BY customer_name;

--List all customers who have purchased products in the Home & Kitchen category.

SELECT DISTINCT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM ecommerce.orders o
JOIN ecommerce.products p ON o.product_id = p.product_id
JOIN ecommerce.customers c ON o.customer_id = c.customer_id
WHERE p.category = 'Home & Kitchen';

--Which product has the highest total quantity ordered?

SELECT 
    p.product_name,
    SUM(o.quantity) AS total_ordered
FROM ecommerce.orders o
JOIN ecommerce.products p 
    ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_ordered DESC
LIMIT 1;

--Show customers who spent more than the average total spending across all customers.

SELECT 
    customer_id,
    total_spent
FROM (
    SELECT 
        o.customer_id,
        SUM(p.price * o.quantity) AS total_spent
    FROM ecommerce.orders o
    JOIN ecommerce.products p ON o.product_id = p.product_id
    GROUP BY o.customer_id
) AS sub
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT 
            o.customer_id,
            SUM(p.price * o.quantity) AS total_spent
        FROM ecommerce.orders o
        JOIN ecommerce.products p ON o.product_id = p.product_id
        GROUP BY o.customer_id
    ) AS inner_sub
);
