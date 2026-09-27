# Data Dictionary - E-commerce Retention Analysis

## Overview
This document describes the structure and content of all tables used in the E-commerce Retention and Cohort Analysis project.

---

## Table: `customers`

**Purpose:** Customer master data - demographics and acquisition info

| Column | Data Type | Description | Example |
|--------|-----------|-------------|----------|
| customer_id | INT | Unique customer identifier | 1001 |
| customer_name | VARCHAR | Full name of customer | John Smith |
| email | VARCHAR | Customer email address | john@example.com |
| country | VARCHAR | Customer country | United States |
| city | VARCHAR | Customer city | New York |
| signup_date | DATE | Date customer registered | 2024-01-15 |
| acquisition_channel | VARCHAR | How customer found us (Organic, Paid, Referral, Social) | Organic |
| customer_segment | VARCHAR | Initial classification (New, Premium, Standard) | Premium |
| created_at | TIMESTAMP | Record creation timestamp | 2024-01-15 10:30:00 |

**Key Insights:**
- `signup_date` is used to create monthly cohorts
- `acquisition_channel` helps identify channel-specific retention patterns
- One row per customer

---

## Table: `orders`

**Purpose:** Order-level transaction data

| Column | Data Type | Description | Example |
|--------|-----------|-------------|----------|
| order_id | INT | Unique order identifier | 5001 |
| customer_id | INT | Foreign key to customers table | 1001 |
| order_date | DATE | Date order was placed | 2024-02-10 |
| order_amount | DECIMAL(10,2) | Total order value (before tax/shipping) | 149.99 |
| shipping_cost | DECIMAL(10,2) | Shipping fee | 9.99 |
| tax_amount | DECIMAL(10,2) | Tax on order | 12.50 |
| total_amount | DECIMAL(10,2) | Final order total | 172.48 |
| order_status | VARCHAR | Order status (Completed, Cancelled, Returned) | Completed |
| payment_method | VARCHAR | Payment type (Credit Card, PayPal, Apple Pay) | Credit Card |
| created_at | TIMESTAMP | Order creation timestamp | 2024-02-10 14:25:00 |

**Key Insights:**
- `order_date` drives cohort analysis and time-series trends
- `order_amount` is used for revenue and CLV calculations
- `order_status` filters for completed orders in revenue metrics
- Multiple rows per customer (one per order)

---

## Table: `order_items`

**Purpose:** Line-item details for each order

| Column | Data Type | Description | Example |
|--------|-----------|-------------|----------|
| order_item_id | INT | Unique line item identifier | 20001 |
| order_id | INT | Foreign key to orders table | 5001 |
| product_id | INT | Foreign key to products table | 301 |
| quantity | INT | Units ordered | 2 |
| unit_price | DECIMAL(10,2) | Price per unit at time of order | 74.99 |
| discount_amount | DECIMAL(10,2) | Discount applied to line item | 15.00 |
| line_total | DECIMAL(10,2) | Quantity × unit_price - discount | 134.98 |
| created_at | TIMESTAMP | Record creation timestamp | 2024-02-10 14:25:00 |

**Key Insights:**
- Enables product-level repeat-purchase analysis
- Discount amounts reveal promotional impact
- Multiple rows per order

---

## Table: `products`

**Purpose:** Product catalog and classifications

| Column | Data Type | Description | Example |
|--------|-----------|-------------|----------|
| product_id | INT | Unique product identifier | 301 |
| product_name | VARCHAR | Product description | Wireless Headphones Pro |
| category | VARCHAR | Product category | Electronics |
| subcategory | VARCHAR | More specific classification | Audio |
| unit_price | DECIMAL(10,2) | Standard selling price | 149.99 |
| cost_price | DECIMAL(10,2) | Cost to business | 75.00 |
| supplier_id | INT | Supplier reference | 50 |
| launch_date | DATE | Date product was introduced | 2023-06-01 |
| status | VARCHAR | Product status (Active, Discontinued, New) | Active |
| created_at | TIMESTAMP | Record creation timestamp | 2023-06-01 08:00:00 |

**Key Insights:**
- `category` enables segment-specific repeat-purchase analysis
- `status` filters to active products only
- One row per product

---

## Derived Metrics (Calculated in SQL)

### Customer Metrics
| Metric | Formula | Purpose |
|--------|---------|----------|
| `total_orders` | COUNT(DISTINCT order_id) | Orders per customer |
| `total_revenue` | SUM(total_amount) | CLV calculation |
| `avg_order_value` | AVG(order_amount) | Purchase size |
| `first_purchase_date` | MIN(order_date) | Cohort assignment |
| `last_purchase_date` | MAX(order_date) | Recency (RFM) |
| `days_since_purchase` | TODAY() - last_purchase_date | Churn prediction |
| `repeat_purchaser` | CASE WHEN total_orders > 1 THEN 1 ELSE 0 END | Retention metric |

### Cohort Metrics
| Metric | Formula | Purpose |
|--------|---------|----------|
| `cohort_month` | DATE_TRUNC('month', first_purchase_date) | Cohort grouping |
| `cohort_age` | DATEDIFF(MONTH, first_purchase_date, order_date) | Months since acquisition |
| `cohort_retention` | COUNT(DISTINCT customer_id) / first_month_customers | % retained |

### RFM Metrics
| Metric | Formula | Purpose |
|--------|---------|----------|
| `recency_score` | CASE WHEN days_since_purchase <= 30 THEN 5 ... | Customer freshness |
| `frequency_score` | CASE WHEN total_orders >= 10 THEN 5 ... | Purchase frequency |
| `monetary_score` | CASE WHEN total_revenue >= 1000 THEN 5 ... | Customer value |
| `rfm_score` | (recency_score || frequency_score || monetary_score) | Combined score 0-999 |

---

## Data Quality Notes

✅ **No nulls** in primary keys (customer_id, order_id, product_id)  
✅ **Order dates** range from 2024-01-01 to 2024-12-31  
✅ **All amounts** are positive and in USD  
⚠️ **Cancelled orders** included in orders table (filter by order_status = 'Completed')  
⚠️ **Some products** marked as Discontinued (filter by status = 'Active' if needed)  

---

## Sample Data Counts

| Table | Row Count | Time Period |
|-------|-----------|-------------|
| customers | 10,000 | Jan 2024 - Dec 2024 |
| orders | 45,000 | Jan 2024 - Dec 2024 |
| order_items | 85,000 | Jan 2024 - Dec 2024 |
| products | 500 | Active & historical |

---

## Join Relationships

```
customers (1) ----< (many) orders (1) ----< (many) order_items (many) ----> (1) products
     |                                                      |
     └─ signup_date → creates cohort_month                 └─ product_id references
     └─ customer_id PK                                     └─ category for repeat analysis
```