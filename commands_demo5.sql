--CTE
--find the total amount each customer has spent on their orders.

WITH customer_spending AS (
    SELECT 
        o.customer_id,
        SUM(p.price * o.quantity) AS total_spent
    FROM ecommerce.orders o
    JOIN ecommerce.products p 
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
)
SELECT 
    c.first_name,
    c.last_name,
    cs.total_spent
FROM customer_spending cs
JOIN ecommerce.customers c 
    ON cs.customer_id = c.customer_id
ORDER BY cs.total_spent DESC;

--first calculate total spending per customer, then find customers who spent more than $100.

WITH customer_spending AS (
    SELECT 
        o.customer_id,
        SUM(p.price * o.quantity) AS total_spent
    FROM ecommerce.orders o
    JOIN ecommerce.products p 
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
),
high_value_customers AS (
    SELECT 
        customer_id,
        total_spent
    FROM customer_spending
    WHERE total_spent > 100
)
SELECT 
    c.first_name,
    c.last_name,
    hvc.total_spent
FROM high_value_customers hvc
JOIN ecommerce.customers c 
    ON c.customer_id = hvc.customer_id
ORDER BY hvc.total_spent DESC;


--Window Functions

--Write a query to assign a unique row number to each order, sorted by order date.

SELECT 
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (ORDER BY order_date) AS row_num
FROM ecommerce.orders;

--Rank customers by their total spending, allowing gaps in ranking for ties.

SELECT 
    customer_id,
    SUM(p.price * o.quantity) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.price * o.quantity) DESC) AS rank_position
FROM ecommerce.orders o
JOIN ecommerce.products p ON o.product_id = p.product_id
GROUP BY customer_id;

--Rank customers by their total spending, but don’t skip rank numbers for ties.

SELECT 
    customer_id,
    SUM(p.price * o.quantity) AS total_spent,
    DENSE_RANK() OVER (ORDER BY SUM(p.price * o.quantity) DESC) AS dense_rank_position
FROM ecommerce.orders o
JOIN ecommerce.products p ON o.product_id = p.product_id
GROUP BY customer_id;

--Compare each order’s quantity with the previous order’s quantity by date.

SELECT 
    order_id,
    quantity,
    LAG(quantity, 1) OVER (ORDER BY order_date) AS previous_quantity
FROM ecommerce.orders;

--Compare each order’s quantity with the next order’s quantity by date.

SELECT 
    order_id,
    quantity,
    LEAD(quantity, 1) OVER (ORDER BY order_date) AS next_quantity
FROM ecommerce.orders;

--Divide customers into 3 spending tiers (1 = highest spenders).

SELECT 
    customer_id,
    SUM(p.price * o.quantity) AS total_spent,
    NTILE(2) OVER (ORDER BY SUM(p.price * o.quantity) DESC) AS spending_tier
FROM ecommerce.orders o
JOIN ecommerce.products p ON o.product_id = p.product_id
GROUP BY customer_id;

--For each order, show the total, average, and count of quantities per customer.

SELECT 
    customer_id,
    order_id,
    quantity,
    SUM(quantity)  OVER (PARTITION BY customer_id) AS total_orders_qty,
    AVG(quantity)  OVER (PARTITION BY customer_id) AS avg_order_qty,
    COUNT(order_id) OVER (PARTITION BY customer_id) AS order_count
FROM ecommerce.orders;
