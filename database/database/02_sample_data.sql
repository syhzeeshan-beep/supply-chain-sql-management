-- Supply Chain Management Sample Data
-- Populates all tables with realistic data

-- Insert sample suppliers
INSERT INTO suppliers (supplier_name, contact_person, phone, email, address) 
VALUES 
('Global Electronics Inc', 'John Smith', '+1-555-0101', 'john@globalelectronics.com', '123 Tech Park, Silicon Valley, CA'),
('Premium Raw Materials Co', 'Sarah Johnson', '+1-555-0102', 'sarah@premiummaterials.com', '456 Industrial Zone, Houston, TX'),
('Fast Components Ltd', 'Mike Chen', '+1-555-0103', 'mike@fastcomponents.com', '789 Manufacturing District, Detroit, MI');

-- Insert sample products
INSERT INTO products (product_name, description, category, unit_price, supplier_id) 
VALUES 
('Laptop Pro', 'High-performance business laptop', 'Electronics', 1200.00, 1),
('Smartphone X', 'Latest smartphone model', 'Electronics', 800.00, 1),
('Aluminum Chassis', 'Premium aluminum body for devices', 'Raw Materials', 150.00, 2),
('Battery Pack', 'High-capacity lithium battery', 'Components', 90.00, 3);

-- Insert sample warehouses
INSERT INTO warehouses (warehouse_name, location, capacity_sqft) 
VALUES 
('West Coast Hub', 'Los Angeles, CA', 100000),
('Central Distribution', 'Dallas, TX', 150000),
('East Coast Storage', 'New York, NY', 120000);

-- Insert sample inventory
INSERT INTO inventory (product_id, warehouse_id, quantity) 
VALUES 
(1, 1, 50),   -- Laptop Pro in West Coast Hub
(1, 2, 30),   -- Laptop Pro in Central Distribution
(2, 1, 100),  -- Smartphone X in West Coast Hub
(2, 3, 80),   -- Smartphone X in East Coast Storage
(3, 2, 200),  -- Aluminum Chassis in Central Distribution
(4, 3, 150);  -- Battery Pack in East Coast Storage

-- Insert sample customers
INSERT INTO customers (customer_name, contact_person, phone, email, address, credit_limit) 
VALUES 
('Tech World Retail', 'David Wilson', '+1-555-0201', 'david@techworld.com', '789 Market St, Seattle, WA', 50000.00),
('Corporate Solutions Inc', 'Lisa Garcia', '+1-555-0202', 'lisa@corporate-solutions.com', '456 Business Ave, Chicago, IL', 100000.00),
('Global Office Supplies', 'Robert Brown', '+1-555-0203', 'robert@globaloffice.com', '123 Commerce Rd, Boston, MA', 75000.00);

-- Insert sample orders
INSERT INTO orders (customer_id, order_date, required_date, status, total_amount) 
VALUES 
(1, '2024-01-15', '2024-01-25', 'Shipped', 2400.00),
(2, '2024-01-16', '2024-01-26', 'Processing', 1600.00),
(3, '2024-01-17', '2024-01-27', 'Pending', 450.00);

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) 
VALUES 
(1, 1, 2, 1200.00),  -- 2 Laptop Pros
(1, 2, 1, 800.00),   -- 1 Smartphone X
(2, 1, 1, 1200.00),  -- 1 Laptop Pro
(2, 4, 4, 90.00),    -- 4 Battery Packs
(3, 3, 3, 150.00);   -- 3 Aluminum Chassis

-- Verification queries (can be run to check data)
SELECT 'Suppliers count: ' AS info, COUNT(*) AS count FROM suppliers
UNION ALL
SELECT 'Products count: ', COUNT(*) FROM products
UNION ALL
SELECT 'Warehouses count: ', COUNT(*) FROM warehouses
UNION ALL
SELECT 'Inventory records: ', COUNT(*) FROM inventory
UNION ALL
SELECT 'Customers count: ', COUNT(*) FROM customers
UNION ALL
SELECT 'Orders count: ', COUNT(*) FROM orders
UNION ALL
SELECT 'Order items count: ', COUNT(*) FROM order_items;
