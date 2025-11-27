-- Supply Chain Management - Analytical Queries
-- Advanced business intelligence and reporting queries

-- 1. Inventory Value Analysis by Warehouse
SELECT 
    w.warehouse_name,
    w.location,
    COUNT(i.product_id) as products_stored,
    SUM(i.quantity) as total_units,
    SUM(i.quantity * p.unit_price) as total_inventory_value
FROM warehouses w
LEFT JOIN inventory i ON w.warehouse_id = i.warehouse_id
LEFT JOIN products p ON i.product_id = p.product_id
GROUP BY w.warehouse_id, w.warehouse_name, w.location
ORDER BY total_inventory_value DESC;

-- 2. Customer Order Analysis (Top Customers)
SELECT 
    c.customer_name,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_spent,
    AVG(o.total_amount) as average_order_value,
    MAX(o.order_date) as last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 3. Product Performance & Revenue Analysis
SELECT 
    p.product_name,
    s.supplier_name,
    p.category,
    p.unit_price,
    SUM(oi.quantity) as total_units_sold,
    SUM(oi.quantity * oi.unit_price) as total_revenue,
    COUNT(DISTINCT o.order_id) as times_ordered
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name, s.supplier_name, p.category, p.unit_price
ORDER BY total_revenue DESC;

-- 4. Order Fulfillment Capacity Analysis
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity as ordered_quantity,
    COALESCE(SUM(i.quantity), 0) as available_inventory,
    CASE 
        WHEN COALESCE(SUM(i.quantity), 0) >= oi.quantity THEN 'CAN FULFILL'
        ELSE 'INSUFFICIENT STOCK'
    END as fulfillment_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE o.status IN ('Pending', 'Processing')
GROUP BY o.order_id, c.customer_name, p.product_name, oi.quantity
ORDER BY o.order_id;

-- 5. Supplier Performance Analysis
SELECT 
    s.supplier_name,
    COUNT(p.product_id) as products_supplied,
    SUM(p.unit_price) as total_product_value,
    AVG(p.unit_price) as average_product_price
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY products_supplied DESC;

-- 6. Monthly Sales Trend Analysis
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    COUNT(order_id) as orders_count,
    SUM(total_amount) as monthly_revenue,
    AVG(total_amount) as average_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month DESC;

-- 7. Low Stock Alert System
SELECT 
    p.product_name,
    SUM(i.quantity) as total_stock,
    CASE 
        WHEN SUM(i.quantity) < 50 THEN 'CRITICAL - REORDER NOW'
        WHEN SUM(i.quantity) < 100 THEN 'LOW STOCK - MONITOR'
        ELSE 'STOCK OK'
    END as stock_alert
FROM products p
LEFT JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_id, p.product_name
HAVING total_stock < 100 OR total_stock IS NULL
ORDER BY total_stock ASC;
