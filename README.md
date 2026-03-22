<h1>Data Science Job Postin on Glassdoor </h1>


<h2>Data cleaning using SQL Queries</h2>

--------

## 📌Project Description

Data cleaning is a critical step in the data analysis process, ensuring that datasets are accurate, consistent, and reliable before analysis or modeling.

In this project, SQL Server was used to clean a dataset downloaded from Kaggle. The primary objective was to practice and demonstrate core data cleaning techniques using SQL queries.

--------

## 🧹Data Cleaning Steps

The following steps were performed to prepare the dataset for analysis:

- Removed unnecessary characters and separated combined data into individual columns

- Identified and removed duplicate rows using a CTE with the ROW_NUMBER() window function

- Used the TRIM() function to remove unwanted spaces from text fields

- Handled missing values using SQL functions such as IS NULL and COALESCE

- Removed unused columns to simplify the dataset structure

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






