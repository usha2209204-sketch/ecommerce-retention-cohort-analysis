# E-commerce Customer Retention and Cohort Analysis

## Overview
This project analyzes customer retention, repeat-purchase behavior, and cohort performance for an e-commerce business.

## Business objective
- Which customer segments generate repeat revenue?
- Which customer cohorts are at risk of low retention?
- What is the customer lifetime value by segment?
- Which products drive repeat purchases?

## Project structure
```text
ecommerce-retention-analysis/
├── README.md
├── data_dictionary.md
├── requirements.txt
├── data/
│   ├── generate_sample_data.py
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_items.csv
│   └── products.csv
├── sql/
│   ├── 01_customer_metrics.sql
│   ├── 02_cohort_analysis.sql
│   ├── 03_rfm_segmentation.sql
│   ├── 04_repeat_purchase_analysis.sql
│   └── 05_product_analysis.sql
├── notebooks/
│   └── exploratory_analysis.ipynb
├── powerbi/
│   └── retention_dashboard.pbix
├── images/
│   └── README.md
└── .gitignore
```

## Analyses included
- Monthly revenue and order trends
- New versus returning customers
- Repeat purchase rate
- Average order value
- Customer lifetime value
- Cohort retention matrix
- Top products by repeat-purchase rate
- RFM segmentation

## SQL skills demonstrated
- Joins
- CTEs
- Window functions
- Date functions
- Aggregation
- Conditional logic

## Quick start
1. Install dependencies:
```bash
pip install -r requirements.txt
```
2. Generate the sample dataset:
```bash
python data/generate_sample_data.py
```
3. Load data into PostgreSQL/MySQL/SQLite.
4. Run SQL scripts from `/sql`.
5. Open the notebook in Jupyter.

## Resume-ready summary
- Analyzed e-commerce transaction data using SQL to calculate repeat-purchase rate, lifetime value, RFM segments, and retention.
- Built cohort-based retention analysis using CTEs, date functions, and window functions.
- Developed a dashboard concept for revenue, AOV, retention, and customer segments.
- Identified the most valuable customer segments and product categories for targeted retention campaigns.
