
# 📊 Data Warehouse Project in SQL  

This project demonstrates the **end-to-end process of building a Data Warehouse** using **SQL Server** and **Azure Data Studio**. It covers **data ingestion, transformation, modeling, schema design, and BI reporting**.  

The implementation follows the **Bronze-Silver-Gold data architecture** to ensure data quality, consistency, and usability for business intelligence.  

---

## 🎯 Learning Outcomes  

Through this project, you will learn:  

- Data Analysis using SQL  
- SQL Basics & Advanced Queries (Week 1 & 2)  
- Data Extraction & Ingestion Processes  
- Data Architecture Design (Bronze, Silver, Gold layers)  
- Transformation & Data Cleaning  
- Facts & Dimensions in Data Modeling  
- Star & Snowflake Schemas  
- Load Processes for Data Warehouse  
- Building BI Reports & Dashboards  

---

## 🛠 Tools & Technologies  

- 🗄️ **SQL Server** ![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?logo=microsoftsqlserver&logoColor=white)  
- 🖥️ **Azure Data Studio** ![Azure Data Studio](https://img.shields.io/badge/Azure%20Data%20Studio-0078D4?logo=microsoftazure&logoColor=white)  
- 🧩 **SQL** ![SQL](https://img.shields.io/badge/SQL-003B57?logo=postgresql&logoColor=white)  
- 📂 **Flat Files (CSV Datasets)** ![CSV](https://img.shields.io/badge/CSV-217346?logo=files&logoColor=white)  


---

## 📂 Data Architecture  

### 🔹 Bronze Layer – Data Ingestion  
- Raw data ingestion from flat files.  
- Loading using **Full Load, Batch Processing, and Truncate & Insert** methods.  

### 🔹 Silver Layer – Cleansing & Transformation  
- Adding metadata column `dwh_create_date`.  
- Data Cleansing: remove nulls, duplicates, string spaces.  
- Data Standardization & Normalization.  
- Derived Columns and Data Enrichment.  
- Example Tables:  
  - `Silver.crm_cust_info`  
  - `Silver.crm_prd_info`  
  - `Silver.crm_sales_details`  
  - `Silver.erp_cust_az12`  
  - `Silver.erp_loc_a101`  
  - `Silver.erp_px_cat_g1v2`  

### 🔹 Gold Layer – Data Integration & Star Schema  
- Creating **Dimension Views**:  
  - `dim_customers`  
  - `dim_products`  
- Creating **Fact View**:  
  - `fact_sales`  
- Star Schema Design for reporting.  

---
## 🟨 Gold Layer – Data Integration & Star Schema  

| Dimension / Fact | Description | ERD / Screenshot |
|------------------|-------------|------------------|
| `dim_customers`  | Dimension view containing customer details | ![Customers](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/customer_table.png) |
| `dim_products`   | Dimension view containing product details | ![Products](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/products_table.png) |
| `fact_sales`     | Fact view containing sales transactions | ![Sales](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/fact_sales.png) |

## 🔄 ETL Process  

1. **Extraction** – Load flat files (CSV) into staging (Bronze).  
2. **Transformation** – Clean, standardize, and enrich data (Silver).  
3. **Load** – Build integrated star schema tables for BI (Gold).  

---
## 🖼️ Data Model  

![Data Model](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/Data_Model.png)  


---
## 📊 BI Reporting  




## 📊 BI Report Pages  

| Page | Charts & Visuals | Purpose | Screenshot |
|------|------------------|---------|------------|
| **Page 1** | Slicers, Heat Map, Stacked Line Chart (Sales & Profit by Year), Horizontal Bar Chart (Country Sales), Pie Chart (Sales by Sub-Categories), KPI Cards | Overview of global sales & performance | ![Page1](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/BI_1st.png) |
| **Page 2** | Slicers (Country), Stacked Line Chart (Quarterly Sales & Profit), Bar Chart (Country Sales), Pie Chart (Sub-Category Sales), KPI Cards, Table (Sales by Categories), Top 10 Sales Chart | Country & category-level insights | ![Page2](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/BI_2nd.png) |
| **Page 3** | Slicers (Country, Category, Sub-Category, Product), Stacked Line Chart (Sales by Year/Quarter/Month), Bar Chart (Top Sales), Pie Chart (Gender Sales), KPI Cards, Customer Details Table | Customer & product deep-dive | ![Page3](https://raw.githubusercontent.com/MTalhaofc/Data_Report_Sales/refs/heads/main/BI_3rd.png) |


### 📍 First Page  
- **Slicers** – Filters (Country, Category, Product, etc.)  
- **Heat Map** – Sales by Region  
- **Stacked Line Chart** – Sales & Profit by Year  
- **Bar Chart** – Country-wise Sales  
- **Pie Chart** – Sales by Sub-Categories  
- **Cards** – KPIs (Orders, Sales, Profit, etc.)  

**DAX Measures Used:**  
```sql
Total Orders = COUNT([Order Num])  
Profit = SUM(Sales Amount) - SUM(Manufacturing Price)  
````


### 📍 Second Page

* **Slicers** – Country filter
* **Stacked Line Chart** – Sales & Profit by Quarter
* **Bar Chart** – Country Sales
* **Pie Chart** – Sub-Category Sales
* **Cards** – KPIs
* **Table** – Sales across Categories & Sub-Categories
* **Bar Chart** – Top 10 Sales

---

### 📍 Third Page

* **Slicers** – Country, Category, Sub-Category, Product
* **Stacked Line Chart** – Sales & Profit by Year, Quarter, Month
* **Bar Chart** – Top Sales
* **Pie Chart** – Gender-wise Sales
* **Cards** – KPIs (Sales, Profit, Orders, etc.)
* **Table** – Customer Details

---

## 📌 Project Flow

1. **Ingest raw CSV files → Bronze**
2. **Clean & Transform → Silver**
3. **Integrate & Model → Gold (Star Schema)**
4. **Build BI Reports → Power BI Dashboards**

---

## 👨🏻‍💻 Created By

**Muhammad Talha**
📧 [talha0750@gmail.com](mailto:talha0750@gmail.com)
🔗 [GitHub](https://github.com/MTalhaofc) • [LinkedIn](https://linkedin.com/in/mtalhaofc)

---

## 🌟 Support the Project

If you found this project useful:

<p align="center">
  <a href="https://github.com/MTalhaofc?tab=followers">
    <img src="https://img.shields.io/github/followers/MTalhaofc?label=Follow&logo=github&style=for-the-badge" />
  </a>
  <a href="https://github.com/MTalhaofc/AI_Text_Summarizer">
    <img src="https://img.shields.io/github/stars/MTalhaofc/AI_Text_Summarizer?label=Star&logo=github&style=for-the-badge" />
  </a>
</p>

```

