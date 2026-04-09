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


## Example SQL Step – Removing Duplicate Rows

A CTE with the `ROW_NUMBER()` window function was used to identify and remove duplicate records.


```sql
WITH row_numCTE AS(
     SELECT *,
        ROW_NUMBER() OVER ( 
	        PARTITION BY [Salary Estimate], 
                            [Company Name], 
	                     [Location]
	          ORDER BY [Job Title]) AS row_num
      FROM dbo.[Data Science Job Postin on Glassdoor]
)
DELETE
FROM  row_numCTE 
WHERE row_num > 1;
```

----------

## 🛠 Tools Used

- SQL Server

- SQL (CTE, Window Functions, Data Transformation)

  ------------

## 🧠 Skills Demonstrated

- Data cleaning and preprocessing

- Handling missing data

- Removing duplicates

- Data transformation using SQL

- Window functions and CTE usage


----------


## 👩‍💻 Author

**Xhavide Zymberi Ebibi**

Data Analyst Enthusiast | SQL & Business Intelligence | Tableau | Marketing Professional

[GitHub]()

[LinkedIn](https://www.linkedin.com/in/xhavide-zymberi/) 






