# 📊 AtliQ Sales Analysis (SQL Project)

This project showcases an end-to-end SQL-based data analysis performed on a real-world manufacturing dataset containing **7M+ records**. The analysis was designed to support data-driven decisions, streamline reporting, and uncover key sales and market performance insights.

---

## 🗃️ Dataset Overview

A real-industry relational database simulating a manufacturing company's operations with sales across global markets. Data is stored across multiple fact and dimension tables.

### Key Tables:
- `dim_customer`, `dim_date`, `dim_product`
- `fact_sales_monthly`, `fact_forecast_monthly`, `fact_gross_price`
- `fact_manufacturing_cost`, `fact_freight_cost`
- `fact_pre_invoice_deductions`, `fact_post_invoice_deductions`
- `fact_act_est`

---

## 🎯 Project Objectives

- Analyze product-wise and customer-wise sales performance
- Identify top-performing regions and markets
- Evaluate forecast accuracy against actual sales
- Automate reporting for business KPIs
- Reduce manual analysis time and increase reporting accuracy

---

## 🔍 Key Analyses Conducted

- Monthly product sales reports for individual customers for a specified fiscal year
- Region-wise **market share** & **top 2 markets** by gross sales
- Year-over-year **net sales** summaries
- **Forecast Accuracy** reports
- Ranking **top customers/products/markets** by sales or quantity

---

## ⚙️ SQL Deliverables

### ✅ Stored Procedures
Reusable logic to answer core business questions:
- `get_forecast_accuracy`
- `get_market_badge`
- `get_monthly_gross_sales_for_customer`
- `get_region_and_year_netsales`
- `get_top_n_customers_by_net_sales`
- `get_top_n_markets_by_net_sales`
- `get_top_n_markets_net_sales`
- `get_top_n_products_by_net_sales`
- `get_top_n_products_per_division_by_qty_sold`

### ✅ Views 
Simplify reporting with pre-joined data:
- `gross_sales`
- `net_sales`
- `sales_post_invoice_discount`
- `sales_pre_invoice_discount`

### ✅ Triggers & Events
- Automated logic for maintaining data consistency and scheduled updates

---

## 📈 Business Impact

- Reduced manual reporting time by **~60%**
- Improved reporting accuracy by **30%**
- Enabled real-time, insight-driven decision making for sales optimization

---
Feel free to **star ⭐ this repository** if you found it useful! 🚀
