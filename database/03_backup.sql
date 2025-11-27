-- Supply Chain Management Database - Complete Backup
-- Instructions: Run this entire file to restore the complete database

-- Create and use database
DROP DATABASE IF EXISTS supply_chain_management;
CREATE DATABASE supply_chain_management;
USE supply_chain_management;

-- Include all table creations and sample data from previous files
-- This file combines 01_schema.sql and 02_sample_data.sql for easy restoration

-- Table structures
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    capacity_sqft INT
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    warehouse_id INT,
    quantity INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    credit_limit DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    required_date DATE,
    status VARCHAR(20) DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data
INSERT INTO suppliers (supplier_name, contact_person, phone, email, address) VALUES 
('Global Electronics Inc', 'John Smith', '+1-555-0101', 'john@globalelectronics.com', '123 Tech Park, Silicon Valley, CA'),
('Premium Raw Materials Co', 'Sarah Johnson', '+1-555-0102', 'sarah@premiummaterials.com', '456 Industrial Zone, Houston, TX'),
('Fast Components Ltd', 'Mike Chen', '+1-555-0103', 'mike@fastcomponents.com', '789 Manufacturing District, Detroit, MI');

INSERT INTO products (product_name, description, category, unit_price, supplier_id) VALUES 
('Laptop Pro', 'High-performance business laptop', 'Electronics', 1200.00, 1),
('Smartphone X', 'Latest smartphone model', 'Electronics', 800.00, 1),
('Aluminum Chassis', 'Premium aluminum body for devices', 'Raw Materials', 150.00, 2),
('Battery Pack', 'High-capacity lithium battery', 'Components', 90.00, 3);

INSERT INTO warehouses (warehouse_name, location, capacity_sqft) VALUES 
('West Coast Hub', 'Los Angeles, CA', 100000),
('Central Distribution', 'Dallas, TX', 150000),
('East Coast Storage', 'New York, NY', 120000);

INSERT INTO inventory (product_id, warehouse_id, quantity) VALUES 
(1, 1, 50), (1, 2, 30), (2, 1, 100), (2, 3, 80), (3, 2, 200), (4, 3, 150);

INSERT INTO customers (customer_name, contact_person, phone, email, address, credit_limit) VALUES 
('Tech World Retail', 'David Wilson', '+1-555-0201', 'david@techworld.com', '789 Market St, Seattle, WA', 50000.00),
('Corporate Solutions Inc', 'Lisa Garcia', '+1-555-0202', 'lisa@corporate-solutions.com', '456 Business Ave, Chicago, IL', 100000.00),
('Global Office Supplies', 'Robert Brown', '+1-555-0203', 'robert@globaloffice.com', '123 Commerce Rd, Boston, MA', 75000.00);

INSERT INTO orders (customer_id, order_date, required_date, status, total_amount) VALUES 
(1, '2024-01-15', '2024-01-25', 'Shipped', 2400.00),
(2, '2024-01-16', '2024-01-26', 'Processing', 1600.00),
(3, '2024-01-17', '2024-01-27', 'Pending', 450.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 2, 1200.00), (1, 2, 1, 800.00), (2, 1, 1, 1200.00), (2, 4, 4, 90.00), (3, 3, 3, 150.00);

-- Verification
SELECT 'Database restored successfully! Total tables: ' AS message;
SHOW TABLES;
