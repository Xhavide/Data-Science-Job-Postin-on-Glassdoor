/*

Cleaning Data in SQL Queries

*/
-----------------------------------------------------------------------------------------------------------------------------------


--View dataset

SELECT *
FROM dbo.[Data Science Job Postin on Glassdoor];

--Removing text part from the 'Salary Estimate' column


SELECT [Salary Estimate]
FROM dbo.[Data Science Job Postin on Glassdoor];

SELECT 
SUBSTRING ([Salary Estimate], 1, CHARINDEX('(', [Salary Estimate])-1) AS Salary1
,SUBSTRING ([Salary Estimate] , CHARINDEX('(', [Salary Estimate])+1, LEN([Salary Estimate])) AS Salary1
FROM dbo.[Data Science Job Postin on Glassdoor];


ALTER TABLE dbo.[Data Science Job Postin on Glassdoor]
ADD Salary nvarchar(25)

UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET Salary = SUBSTRING ([Salary Estimate], 1, CHARINDEX('(', [Salary Estimate])-1)


ALTER TABLE dbo.[Data Science Job Postin on Glassdoor]
ADD Salary2 nvarchar(25)

UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET Salary2 = SUBSTRING ([Salary Estimate] , CHARINDEX('(', [Salary Estimate])+1, LEN([Salary Estimate]))


SELECT *
FROM dbo.[Data Science Job Postin on Glassdoor];



--Now we are going to remove the $ sign and K letter from Salary column


SELECT *,REPLACE(REPLACE(Salary,'$', ''),'K', '') 
FROM dbo.[Data Science Job Postin on Glassdoor]

ALTER TABLE dbo.[Data Science Job Postin on Glassdoor]
ADD Converted_Salary nvarchar(20)

UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET Converted_Salary = REPLACE(REPLACE(Salary,'$', ''),'K', '') 


---------------------------------------------------------------------------------------------------------------------------------


-- Split Location into City and State

SELECT 
     PARSENAME(REPLACE(Location, ',', '.'), 2) AS City,
     PARSENAME(REPLACE(Location, ',', '.'), 1) AS State
FROM dbo.[Data Science Job Postin on Glassdoor];

UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET City = PARSENAME(REPLACE(Location, ',' , '.'), 2)

UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET State = PARSENAME(REPLACE(Location, ',' , '.'), 1)

SELECT *
FROM dbo.[Data Science Job Postin on Glassdoor]

--------------------------------------------------------------------------------------------------------------------------------

-- Remove duplicates
	
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(
	PARTITION BY 
	         [Job Title], 
	         [Location],
	         [Company Name] 
	ORDER BY [Job Title]) AS rn
    FROM dbo.[Data Science Job Postin on Glassdoor]
)
DELETE FROM CTE
WHERE rn > 1;


--------------------------------------------------------------------------------------------------------------------------------

--Check Null values across columns


SELECT COUNT(*) [Job Title]  
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Job Title] IS NULL;

SELECT COUNT(*) [Salary Estimate]  
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Salary Estimate]  IS NULL;

SELECT COUNT(*) [Job Description]  
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE  [Job Description]   IS NULL;


SELECT COUNT(*) [Rating] 
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Rating] IS NULL;

SELECT COUNT(*)[Company Name] 
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Company Name] IS NULL;

SELECT COUNT(*) [Location]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Location] IS NULL;


SELECT COUNT(*) [Headquarters]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Headquarters] IS NULL;


SELECT COUNT(*) [Size]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Size] IS NULL;

SELECT COUNT(*) [Founded]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Founded] IS NULL;

SELECT COUNT(*) [Type of ownership]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Type of ownership] IS NULL;

SELECT COUNT(*) [Industry]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Industry] IS NULL;

SELECT COUNT(*) [Sector]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Job Title] IS NULL;

SELECT COUNT(*) [Revenue]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Job Title] IS NULL;

SELECT COUNT(*) [Competitors]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [Competitors] IS NULL;


--There are 169 Null values in Competitors column

SELECT COUNT(*) [Salary]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE[Salary] IS NULL;

SELECT COUNT(*) [City]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [City] IS NULL;


--There are 22 Nulls in City column


SELECT COUNT(*) [State]
FROM dbo.[Data Science Job Postin on Glassdoor]
WHERE [State] IS NULL;



--We are going to populate the City column using the State  column


UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET [City] = COALESCE( City, State) 

SELECT *
FROM dbo.[Data Science Job Postin on Glassdoor];


-------------------------------------------------------------------------------------------------------------------------------

-- Remove numbers from Company Name
	
UPDATE dbo.[Data Science Job Postin on Glassdoor]
SET [Company_Name] = TRIM(
    TRANSLATE([Company_Name], '0123456789', '          ')
);

SELECT *
FROM dbo.[Data Science Job Postin on Glassdoor];

-------------------------------------------------------------------


--Delete unused columns

ALTER TABLE dbo.[Data Science Job Postin on Glassdoor]
DROP COLUMN [index], Salary, Int_Salary, Salary1, Salary2, Int_Salary1, Salary_Int, Salary_Estimate, Salary_Integer,
            Salary_Integers, Salary_Est, Int_Converted_Salary, Company, Converted_Salary_Int,
			Converted_S, Converted_Salary1, Converted_Salary_Varchar, Converted_Salary_N, 
			Converted_Salary_NU, Company_Name1, Company_Name2, Company_Number

ALTER TABLE  dbo.[Data Science Job Postin on Glassdoor]
DROP COLUMN [Salary Estimate], [Company Name], [Location]
----------------------

-- Data Quality Summary
	
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT [Company_Name]) AS unique_companies,
    COUNT(DISTINCT [City_State]) AS unique_locations
FROM dbo.[Data Science Job Postin on Glassdoor];



