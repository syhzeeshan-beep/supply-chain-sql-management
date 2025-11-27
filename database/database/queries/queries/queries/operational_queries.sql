-- Supply Chain Management - Operational Queries
-- Daily operations, updates, and maintenance queries

-- 1. Add New Product Shipment (Receive Inventory)
-- Scenario: New shipment of 50 Smartphone X arrives at West Coast Hub
UPDATE inventory 
SET quantity = quantity + 50 
WHERE product_id = 2 AND warehouse_id = 1;

-- Verify the update
SELECT p.product_name, w.warehouse_name, i.quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
WHERE p.product_id = 2;

-- 2. Process a New Order
-- Step 1: Create a new order
INSERT INTO orders (customer_id, order_date, required_date, status, total_amount)
VALUES (1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'Processing', 900.00);

-- Step 2: Add order items (assuming the new order ID is 4)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES 
(4, 3, 2, 150.00),   -- 2 Aluminum Chassis
(4, 4, 5, 90.00);    -- 5 Battery Packs

-- 3. Update Order Status
UPDATE orders 
SET status = 'Shipped' 
WHERE order_id = 4;

-- 4. Check Current Stock Levels for All Products
SELECT 
    p.product_name,
    SUM(i.quantity) as total_stock,
    GROUP_CONCAT(CONCAT(w.warehouse_name, ':', i.quantity)) as breakdown
FROM products p
LEFT JOIN inventory i ON p.product_id = i.product_id
LEFT JOIN warehouses w ON i.warehouse_id = w.warehouse_id
GROUP BY p.product_id, p.product_name
ORDER BY total_stock ASC;

-- 5. Find Orders That Need to Be Shipped Today
SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.required_date,
    o.status,
    o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.required_date = CURDATE() 
AND o.status IN ('Processing', 'Pending')
ORDER BY o.required_date;

-- 6. Update Product Price
UPDATE products
SET unit_price = 850.00
WHERE product_id = 2;  -- Smartphone X new price

-- 7. Add New Supplier
INSERT INTO suppliers (supplier_name, contact_person, phone, email, address)
VALUES ('Quality Parts Co', 'Emily Davis', '+1-555-0104', 'emily@qualityparts.com', '321 Supplier Ave, Phoenix, AZ');

-- 8. Transfer Inventory Between Warehouses
-- Move 10 Smartphone X from West Coast Hub to Central Distribution
UPDATE inventory 
SET quantity = quantity - 10 
WHERE product_id = 2 AND warehouse_id = 1;

UPDATE inventory 
SET quantity = quantity + 10 
WHERE product_id = 2 AND warehouse_id = 2;

-- 9. Delete an Order (if cancelled)
-- First delete order items, then the order
DELETE FROM order_items WHERE order_id = 4;
DELETE FROM orders WHERE order_id = 4;

-- 10. Daily Inventory Snapshot
CREATE TABLE daily_inventory_snapshot AS
SELECT 
    p.product_id,
    p.product_name,
    w.warehouse_id,
    w.warehouse_name,
    i.quantity,
    CURDATE() as snapshot_date
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id;
