### Data Science Job Postin on Glassdoor - Data cleaning in SQL Queries.sql


Data cleaning is a crucial process in any data analysis project to ensure that the data used for analysis or modeling is accurate, consistent, and reliable. 
This includes identifying and correcting or removing inaccuracies, inconsistencies, and errors in the data. 
In this project I used SQL Server to clean data. This dataset was dowloaded from Kaggle. The purpose of this dataset is to test my data cleaning skills.




The following steps were necessery for cleaning data:




- Removing unnecessary characters, and separating data into individual columns;
- Removing duplicate rows by creating a CTE with the window
  function ROW_NUMBER;
- Using the ‘TRIM’ function to remove all unwanted spaces from all text columns;
- Handling missing values using SQL functions like IS NULL and COALESCE, and then populating them with other values;
- Deleting unused columns.

