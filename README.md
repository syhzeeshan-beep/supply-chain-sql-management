# Supply Chain Management SQL Database 🏭📦

A complete SQL database solution for managing supply chain operations including suppliers, products, inventory, warehouses, customers, and orders.

## 📊 Project Overview

This project demonstrates a full-featured supply chain management system built with MySQL. It tracks the entire product lifecycle from suppliers to customers.

## 🗄️ Database Schema

**7 Normalized Tables:**
- `suppliers` - Vendor management
- `products` - Product catalog  
- `warehouses` - Storage locations
- `inventory` - Stock level tracking
- `customers` - Client database
- `orders` - Sales orders
- `order_items` - Order details

## 🚀 Features

- **Inventory Management** - Track stock across multiple warehouses
- **Order Processing** - Complete order fulfillment workflow
- **Supplier Management** - Vendor relationship tracking
- **Customer Analytics** - Buying patterns and spending analysis
- **Business Intelligence** - Advanced reporting and insights

## 📁 Project Structure
supply-chain-sql-management/
├── database/
│ ├── 01_schema.sql # Table creation scripts
│ ├── 02_sample_data.sql # Sample data population
│ └── 03_backup.sql # Complete database backup
├── queries/
│ ├── basic_queries.sql # Fundamental SELECT queries
│ ├── analytical_queries.sql # Business intelligence queries
│ └── operational_queries.sql # Daily operations
├── docs/
│ ├── ERD.diagram # Database diagram code
│ └── business_case.md # Project rationale
└── images/ # Screenshots and diagrams
