CREATE DATABASE ecommerce_db;

CREATE SCHEMA ecommerce;

--Create Tables
CREATE TABLE ecommerce.customers (
    customer_id SERIAL PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    email       VARCHAR(100) UNIQUE,
    phone       VARCHAR(20),
    city        VARCHAR(50),
    state       VARCHAR(50),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ecommerce.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10,2) CHECK (price >= 0),
    in_stock BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ecommerce.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES ecommerce.customers(customer_id) ON DELETE CASCADE,
    product_id INT REFERENCES ecommerce.products(product_id),
    quantity INT CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ecommerce.categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

--Insert Data

INSERT INTO ecommerce.customers (first_name, last_name, email, phone, city, state)
VALUES
('John', 'Miller', 'john.miller@example.com', '555-1234', 'New York', 'NY'),
('Kate', 'Thompson', 'ava.t@example.com', '555-5678', 'Los Angeles', 'CA'),
('Raj', 'Patel', 'raj.patel@example.com', '555-8765', 'Chicago', 'IL'),
('Liam', 'Johnson', 'liam.j@example.com', '555-9012', 'Chicago', 'IL'),
('Sophia', 'Davis', 'sophia.d@example.com', '555-3456', 'Houston', 'TX'),
('Noah', 'Wilson', 'noah.w@example.com', '555-7890', 'Miami', 'FL');


INSERT INTO ecommerce.products (product_name, category, price, in_stock)
VALUES
('Wireless Mouse', 'Electronics', 25.99, TRUE),
('Bluetooth Headphones', 'Electronics', 79.50, TRUE),
('Coffee Mug', 'Home & Kitchen', 12.99, TRUE),
('Desk Lamp', 'Home & Kitchen', 0, FALSE);

INSERT INTO ecommerce.orders (customer_id, product_id, quantity)
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 4),
(2, 3, 3),
(4, 3, 4),
(5, 3, 1);

INSERT INTO ecommerce.categories (category_name) 
VALUES 
('Electronics'),
('Home & Kitchen');