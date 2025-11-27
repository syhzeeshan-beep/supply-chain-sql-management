-- Supply Chain Management - Basic Queries
-- Fundamental SQL queries for daily operations

-- 1. View all products with their suppliers
SELECT p.product_name, p.category, p.unit_price, s.supplier_name
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id;

-- 2. Check inventory levels across all warehouses
SELECT p.product_name, w.warehouse_name, w.location, i.quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
ORDER BY p.product_name, w.warehouse_name;

-- 3. View all customers and their orders
SELECT c.customer_name, o.order_id, o.order_date, o.status, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

-- 4. Find products by category
SELECT product_name, description, unit_price
FROM products
WHERE category = 'Electronics';

-- 5. Check warehouse capacity utilization
SELECT warehouse_name, location, capacity_sqft
FROM warehouses
ORDER BY capacity_sqft DESC;
