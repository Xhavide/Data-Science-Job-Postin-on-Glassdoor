/*

Cleaning Data in SQL Queries

*/

-- =========================================
-- 1. CREATE WORKING TABLE
-- =========================================

SELECT *
INTO dbo.ds_jobs_cleaned
FROM dbo.[Data Science Job Postin on Glassdoor];


-- =========================================
-- 2. REMOVE DUPLICATES
-- =========================================

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY [Job Title], [Company Name], Location
               ORDER BY [Job Title]
           ) AS rn
    FROM dbo.ds_jobs_cleaned
)
DELETE FROM CTE
WHERE rn > 1;


-- =========================================
-- 3. CLEAN SALARY COLUMN
-- =========================================
-- Add new columns

ALTER TABLE dbo.ds_jobs_cleaned
ADD Salary_Min INT,
    Salary_Max INT,
    Salary_Avg INT;

-- Extract salary range (remove text like "(Glassdoor est.)")

UPDATE dbo.ds_jobs_cleaned
SET [Salary Estimate] = SUBSTRING([Salary Estimate], 1, CHARINDEX('(', [Salary Estimate]) - 1)
WHERE [Salary Estimate] LIKE '%(%';


-- Remove $ and K

UPDATE dbo.ds_jobs_cleaned
SET [Salary Estimate] = REPLACE(REPLACE([Salary Estimate], '$', ''), 'K', '');


-- Split into min and max salary

UPDATE dbo.ds_jobs_cleaned
SET Salary_Min = TRY_CAST(PARSENAME(REPLACE([Salary Estimate], '-', '.'), 2) AS INT),
    Salary_Max = TRY_CAST(PARSENAME(REPLACE([Salary Estimate], '-', '.'), 1) AS INT);


-- Average salary

UPDATE dbo.ds_jobs_cleaned
SET Salary_Avg = (Salary_Min + Salary_Max) / 2;


-- =========================================
-- 4. CLEAN COMPANY NAME
-- =========================================
-- Remove ratings from company name (e.g., "CompanyName 3.8")

UPDATE dbo.ds_jobs_cleaned
SET [Company Name] = TRIM(
    LEFT([Company Name], PATINDEX('%[0-9]%', [Company Name] + '0') - 1)
);

-- =========================================
-- 5. SPLIT LOCATION INTO CITY & STATE
-- =========================================

ALTER TABLE dbo.ds_jobs_cleaned
ADD City NVARCHAR(50),
    State NVARCHAR(50);

UPDATE dbo.ds_jobs_cleaned
SET City = PARSENAME(REPLACE(Location, ',', '.'), 2),
    State = PARSENAME(REPLACE(Location, ',', '.'), 1);


-- =========================================
-- 6. HANDLE MISSING VALUES (-1 → NULL)
-- =========================================

UPDATE dbo.ds_jobs_cleaned
SET Competitors = NULL
WHERE Competitors = '-1';

UPDATE dbo.ds_jobs_cleaned
SET Revenue = NULL
WHERE Revenue = '-1';

UPDATE dbo.ds_jobs_cleaned
SET Industry = NULL
WHERE Industry = '-1';

UPDATE dbo.ds_jobs_cleaned
SET Sector = NULL
WHERE Sector = '-1';


-- =========================================
-- 7. STANDARDIZE RATING
-- =========================================

UPDATE dbo.ds_jobs_cleaned
SET Rating = NULL
WHERE Rating = -1;


-- =========================================
-- 8. DATA QUALITY CHECK
-- =========================================

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT [Company Name]) AS unique_companies,
    COUNT(DISTINCT Location) AS unique_locations,
    COUNT(DISTINCT [Job Title]) AS unique_roles
FROM dbo.ds_jobs_cleaned;


-- =========================================
-- 9. FINAL CLEAN VIEW
-- =========================================

SELECT 
    [Job Title],
    [Company Name],
    City,
    State,
    Salary_Min,
    Salary_Max,
    Salary_Avg,
    Rating,
    Industry,
    Sector,
    Revenue
FROM dbo.ds_jobs_cleaned;
