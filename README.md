# E-commerce Customer Retention and Cohort Analysis

## 📊 Project Overview

This project demonstrates a comprehensive **customer retention and cohort analysis** for an e-commerce business. It identifies which customer segments generate repeat revenue, predicts retention risk, and provides actionable insights for targeted retention campaigns.

### 🎯 Business Problem
- Which customer segments generate repeat revenue?
- Which customer cohorts are at risk of low retention?
- What is the customer lifetime value by segment?
- Which products drive repeat purchases?

---

## 📈 Key Analyses Included

1. **Monthly Revenue and Order Trends** - Track revenue and order volume over time
2. **New vs. Returning Customers** - Segment customers by acquisition type
3. **Repeat Purchase Rate** - Percentage of customers making repeat purchases
4. **Average Order Value (AOV)** - Track AOV trends by customer segment
5. **Customer Lifetime Value (CLV)** - Calculate total revenue per customer
6. **Cohort Retention Matrix** - Track customer retention by acquisition cohort
7. **Top Products by Repeat-Purchase Rate** - Identify sticky products
8. **RFM Segmentation** - Recency, Frequency, Monetary analysis for targeted campaigns

---

## 🗂️ Project Structure

```
ecommerce-retention-analysis/
├── README.md                          # Project overview
├── data_dictionary.md                 # Data source documentation
├── data/
│   ├── customers.csv                 # Customer master data
│   ├── orders.csv                    # Order transactions
│   ├── order_items.csv               # Line items per order
│   └── products.csv                  # Product catalog
├── sql/
│   ├── 01_customer_metrics.sql       # Revenue, orders, AOV, CLV calculations
│   ├── 02_cohort_analysis.sql        # Cohort retention matrix
│   ├── 03_rfm_segmentation.sql       # RFM-based customer segments
│   ├── 04_repeat_purchase_analysis.sql # Repeat purchase insights
│   └── 05_product_analysis.sql       # Top products by repeat rate
├── notebooks/
│   └── exploratory_analysis.ipynb    # Python analysis & visualizations
├── powerbi/
│   └── retention_dashboard.pbix      # Interactive BI dashboard
├── images/
│   ├── dashboard_preview.png         # Dashboard screenshot
│   ├── cohort_matrix.png             # Cohort retention heatmap
│   └── rfm_segments.png              # RFM segmentation plot
├── requirements.txt                   # Python dependencies
└── .gitignore
```

---

## 🔧 SQL Skills Demonstrated

✅ **Joins** - Combining customers, orders, and order_items tables  
✅ **CTEs (Common Table Expressions)** - Multi-step data transformations  
✅ **Window Functions** - ROW_NUMBER(), RANK(), SUM() OVER(), LAG()  
✅ **Date Functions** - DATE_TRUNC(), DATE_PART(), DATEDIFF()  
✅ **Aggregation** - GROUP BY, SUM(), COUNT(), AVG()  
✅ **Conditional Logic** - CASE WHEN statements for segmentation  

---

## 📊 Key Insights Generated

### Cohort Retention Matrix
Tracks what percentage of customers acquired in Month X return in Month X+1, X+2, etc.

| Cohort  | Month 0 | Month 1 | Month 2 | Month 3 | Month 4 |
|---------|---------|---------|---------|---------|----------|
| 2024-01 | 100%    | 45%     | 28%     | 18%     | 12%      |
| 2024-02 | 100%    | 48%     | 32%     | 20%     | 14%      |
| 2024-03 | 100%    | 52%     | 35%     | 24%     | 18%      |

### RFM Segments
- **Champions** - High frequency, high monetary, recent
- **Loyal Customers** - High frequency, high monetary
- **Can't Lose Them** - High frequency, high monetary, but not recent
- **At Risk** - Low frequency, low monetary, not recent
- **New Customers** - Recent, low frequency

---

## 🚀 Quick Start

### Prerequisites
- PostgreSQL / MySQL / SQLite
- Python 3.8+
- Power BI Desktop (optional)

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/usha2209204-sketch/ecommerce-retention-cohort-analysis.git
   cd ecommerce-retention-analysis
   ```

2. **Load the sample data:**
   ```bash
   psql -U postgres -d ecommerce < data/sample_data.sql
   ```

3. **Run SQL analysis scripts:**
   ```bash
   psql -U postgres -d ecommerce -f sql/01_customer_metrics.sql
   ```

4. **Run Python analysis:**
   ```bash
   pip install -r requirements.txt
   jupyter notebook notebooks/exploratory_analysis.ipynb
   ```

5. **Open Power BI Dashboard:**
   - Open `powerbi/retention_dashboard.pbix` in Power BI Desktop
   - Refresh data connections

---

## 📈 Key Metrics Calculated

| Metric | Definition | Business Value |
|--------|-----------|----------------|
| **Repeat Purchase Rate** | % of customers making >1 purchase | Measures customer loyalty |
| **Cohort Retention** | % of cohort returning in month N | Identifies retention trends |
| **CLV** | Total revenue per customer lifetime | Predicts customer value |
| **AOV** | Average revenue per order | Tracks pricing & bundling effectiveness |
| **Churn Rate** | % of customers not returning | Early warning indicator |
| **RFM Score** | Composite score (0-999) | Segments for targeted campaigns |

---

## 📊 Sample Findings

- **45% of customers make repeat purchases** (vs. 30% industry average)
- **Month-2 retention averages 32%** across cohorts (target: 40%+)
- **Top 20% of customers (by CLV) generate 65% of revenue**
- **Products with >50% repeat rate**: Categories A, B, C
- **RFM Champions represent 8% of customer base but 38% of revenue**

---

## 💡 Business Recommendations

1. **Launch re-engagement campaign** for "Can't Lose Them" segment (high CLV, no recent activity)
2. **Increase retention focus** on Month 1-2 (where drop-off is steepest)
3. **Cross-sell high-repeat products** to improve customer lifetime value
4. **Create VIP loyalty program** for Champions and Loyal Customer segments
5. **Investigate churn drivers** for low-retention cohorts

---

## 📚 Documentation

- **[Data Dictionary](data_dictionary.md)** - Table and column definitions
- **[SQL Queries](sql/)** - Detailed query documentation
- **[Jupyter Notebook](notebooks/exploratory_analysis.ipynb)** - Python analysis & visualizations

---

## 🎓 Resume Impact

This project demonstrates:
- **Advanced SQL** (CTEs, window functions, date logic)
- **Business analytics thinking** (cohort analysis, CLV, RFM)
- **Data visualization** (Power BI dashboard)
- **Python data analysis** (pandas, matplotlib, seaborn)
- **Actionable insights** (specific recommendations from data)

---

## 📧 Contact

For questions or feedback, feel free to reach out!

---

**Last Updated:** September 2026  
**Status:** Active Development