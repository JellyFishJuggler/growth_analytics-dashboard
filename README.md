# 📊 Growth Analytics Dashboard

An end-to-end Business Intelligence (BI) project focused on building a complete data pipeline using **Python**, **Pandas**, and **MySQL**. The project covers data profiling, preprocessing, database design, and automated ETL before creating interactive dashboards in Apache Superset.

> 🚧 **Project Status:** In Progress

---

## 🚀 Current Progress

- ✅ Data Profiling
- ✅ Data Preprocessing
- ✅ MySQL Database Design
- ✅ Relational Schema Creation
- ✅ Python ETL Pipeline
- ✅ Data Loading into MySQL
- ⏳ SQL Analytics
- ⏳ Apache Superset Dashboard

---

## 🛠️ Tech Stack

- Python
- Pandas
- NumPy
- MySQL
- mysql-connector-python
- Jupyter Notebook

---

## 📂 Project Structure

```text
growth-analytics-dashboard/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── 01_data_profiling.ipynb
│   └── 02_data_preprocessing.ipynb
│
├── scripts/
│   ├── db_connector.py
│   ├── load_data.py
│   └── verify_data.py
│
├── sql/
│   └── 01_database_setup.sql
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## 📌 Completed Workflow

```text
Raw Excel Files
        │
        ▼
Data Profiling
        │
        ▼
Data Preprocessing
        │
        ▼
Processed CSV Files
        │
        ▼
Python ETL
        │
        ▼
MySQL Database
```

---

## 📊 Data Profiling

The profiling notebook includes:

- Dataset overview
- Missing value analysis
- Duplicate detection
- Data type validation
- Referential integrity checks
- Basic data quality assessment

---

## 🧹 Data Preprocessing

The preprocessing pipeline performs:

- Standardized column names
- Text cleaning
- Date formatting
- Data validation
- Clean dataset generation

---

## 🗄️ Database Schema

The project currently contains three relational tables:

- **orders**
- **order_details**
- **sales_target**

Primary and Foreign Key relationships have been implemented to maintain data integrity.

---

## ⚙️ ETL Pipeline

The ETL script automates:

- Reading processed CSV files
- Connecting to MySQL
- Clearing existing records
- Bulk inserting data using `executemany()`
- Loading all datasets into the database

---

## 🚧 Upcoming

- SQL Analytics Views
- Business Queries
- Apache Superset Dashboard
- Dashboard Screenshots
- Project Documentation Improvements
<!-- 
---

## License

MIT License -->