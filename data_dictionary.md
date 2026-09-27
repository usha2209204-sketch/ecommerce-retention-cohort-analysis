# Data Dictionary - E-commerce Retention Analysis

## Overview
This document describes the tables used in the synthetic e-commerce dataset.

## Customers
| Column | Type | Description |
|---|---|---|
| customer_id | INT | Unique customer ID |
| customer_name | VARCHAR | Customer name |
| email | VARCHAR | Customer email |
| country | VARCHAR | Country of residence |
| signup_date | DATE | Date customer joined |
| acquisition_channel | VARCHAR | Organic, Paid, Referral, Social |
| segment | VARCHAR | Customer segment |

## Products
| Column | Type | Description |
|---|---|---|
| product_id | INT | Unique product ID |
| product_name | VARCHAR | Product name |
| category | VARCHAR | Product category |
| subcategory | VARCHAR | Product subcategory |
| unit_price | DECIMAL | Product price |

## Orders
| Column | Type | Description |
|---|---|---|
| order_id | INT | Unique order ID |
| customer_id | INT | Customer who placed the order |
| order_date | DATE | Order date |
| total_amount | DECIMAL | Final order value |
| order_status | VARCHAR | Completed, Returned, Cancelled |
| payment_method | VARCHAR | Payment method |

## Order Items
| Column | Type | Description |
|---|---|---|
| order_item_id | INT | Unique line item ID |
| order_id | INT | Associated order |
| product_id | INT | Item product |
| quantity | INT | Units purchased |
| unit_price | DECIMAL | Unit price |
| discount_amount | DECIMAL | Discount applied |
| line_total | DECIMAL | Final value for line item |

## Derived metrics
- repeat_purchase_rate = customers with more than one order / all customers
- avg_order_value = total revenue / total orders
- customer_lifetime_value = total revenue per customer
- cohort_month = month of first purchase
- retention_rate = retained customers / initial cohort size
