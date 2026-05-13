SELECT * FROM products;

SELECT product_name, category
FROM products
WHERE in_stock = TRUE;

SELECT product_name, category
FROM products
WHERE price < 15;

SELECT product_name, category
FROM products
WHERE price BETWEEN 11 AND 30;

SELECT product_name, category
FROM products
WHERE product_name LIKE '%ff%';

SELECT product_name, category
FROM products
WHERE product_name IN ('Coffee Mug', 'Phone', 'Desk Lamp');

SELECT product_name, category
FROM products
WHERE price < 15 OR product_name = 'Wireless Mouse';

SELECT product_name, category
FROM products
WHERE price < 30
ORDER BY price DESC
LIMIT 2
OFFSET 1;

SELECT product_name, category
FROM products
WHERE price < 30
ORDER BY price DESC
FETCH FIRST 2 ROWS ONLY;

SELECT COUNT(product_id) FROM products;

SELECT SUM(price) FROM products;

SELECT category , SUM(price) AS total
FROM products
GROUP BY category
HAVING SUM(price) > 20;


