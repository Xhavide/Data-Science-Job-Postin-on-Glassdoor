<h1>📊 Job Market Analysis – End-to-End Project </h1>



--------

## 📌Project Description

This project analyzes data science job postings using a complete data workflow:

1. Data Cleaning in SQL  
2. Exploratory Data Analysis (EDA)  
3. Data Visualization in Tableau  

The goal is to transform raw data into actionable insights about salaries, job demand, and market trends.

--------

## 🔗 Project Sections

🧹 Data Cleaning → /data-cleaning-sql  
📊 SQL Analysis → /eda-sql  
📈 Tableau Dashboard → /tableau-dashboard  

-----------

 # 1) 🧹 Data Cleaning in SQL – Job Market Dataset

## 📌 Project Overview

This project focuses on cleaning and transforming a real-world dataset of data science job postings to ensure data quality, consistency, and usability for analysis.

Using SQL Server, raw data was processed into a structured, analysis-ready format by handling inconsistencies, missing values, and formatting issues.

-----------

## 🗂 Dataset

The dataset contains job market data, including:

- Job Title
- Company Name
- Location
- Salary Estimate
- Rating
- Industry, Sector, Revenue
- Competitors

  ---------------

  
## ⚙️ Data Cleaning Process

The dataset required multiple transformation steps:

- Removed duplicate records using ROW_NUMBER()
- Cleaned and standardized the Salary Estimate column
- Extracted Salary Min, Max, and Average values
- Split Location into City and State
- Removed company rating values from Company Name
- Replaced placeholder values (e.g., -1) with NULL
- Standardized numerical fields (e.g., Rating)
- Dropped redundant and intermediate columns

--------

## 💻 Example SQL Step – Removing Duplicate Rows

```
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY [Job Title], Location, [Company Name]
               ORDER BY [Job Title]
           ) AS rn
    FROM dbo.[Data Science Job Postin on Glassdoor]
)
DELETE FROM CTE
WHERE rn > 1;
```



## Example SQL Step – Extract and clean salary range
```
UPDATE dbo.ds_jobs_cleaned
SET [Salary Estimate] = SUBSTRING([Salary Estimate], 1, CHARINDEX('(', [Salary Estimate]) - 1)
WHERE [Salary Estimate] LIKE '%(%';

UPDATE dbo.ds_jobs_cleaned
SET Salary_Min = TRY_CAST(PARSENAME(REPLACE([Salary Estimate], '-', '.'), 2) AS INT),
    Salary_Max = TRY_CAST(PARSENAME(REPLACE([Salary Estimate], '-', '.'), 1) AS INT);
```

----------
## 🧠 Key Takeaways

- Real-world datasets often contain inconsistent formats and placeholder values
- Cleaning salary data requires string manipulation and type conversion
- Proper handling of missing values improves data reliability
- Structuring location and company data enhances usability for analysis

------------

## 🛠 Tools Used

- SQL Server
- SQL (Data Cleaning, Transformations, Window Functions)

  ------------
  
## 📊 Data Quality Summary

- Duplicate records removed
- Missing values standardized
- Salary data transformed into numeric format
- Dataset structured for downstream analysis

------------

## 💼 Business Relevance

Clean and reliable data is essential for accurate insights.
This project demonstrates how raw job market data can be transformed into a structured dataset that supports:

- Salary analysis
- Market trends evaluation
- Industry benchmarking

----------


## 📂 Repository Structure

```
data-cleaning-sql
│
├── sql
│   └── data_cleaning_queries.sql
├── README.md
```
-----------












----------


## 👩‍💻 Author

**Xhavide Zymberi Ebibi**

Data Analyst Enthusiast | SQL & Business Intelligence | Tableau | Marketing Professional

[GitHub]()

[LinkedIn](https://www.linkedin.com/in/xhavide-zymberi/) 






