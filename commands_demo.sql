SELECT * FROM ecommerce.categories;

TRUNCATE TABLE ecommerce.categories;

DROP TABLE ecommerce.categories;

ALTER TABLE ecommerce.products
ADD COLUMN category_id INT REFERENCES ecommerce.categories(category_id);

SELECT * FROM ecommerce.products;

UPDATE ecommerce.products
SET category_id = 1
WHERE category = 'Electronics';

SELECT * FROM ecommerce.customers;

SELECT * FROM ecommerce.orders;

DELETE
FROM ecommerce.customers WHERE customer_id = 1

BEGIN;

UPDATE products 
SET price = price * 1.1;

SAVEPOINT before_discount;

UPDATE products 
SET price = price * 0.5
WHERE category = 'clearance';

ROLLBACK TO SAVEPOINT before_discount;

COMMIT;
