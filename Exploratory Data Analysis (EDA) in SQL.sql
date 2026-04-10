
 -- Exploratory Data Analysis (EDA) in SQL --


-- =========================================
-- 1. DATASET OVERVIEW 
-- =========================================

SELECT 
    COUNT(*) AS total_jobs,
    COUNT(DISTINCT [Job Title]) AS unique_roles,
    COUNT(DISTINCT [Company Name]) AS companies,
    COUNT(DISTINCT State) AS states
FROM dbo.ds_jobs_cleaned;



-- =========================================
--2. SALARY ANALYSIS
-- =========================================
-- Average salary by job title

SELECT 
    [Job Title],
    ROUND(AVG(Salary_Avg), 0) AS avg_salary
FROM dbo.ds_jobs_cleaned
WHERE Salary_Avg IS NOT NULL
GROUP BY [Job Title]
ORDER BY avg_salary DESC;


-- Top paying roles

SELECT TOP 10
    [Job Title],
    ROUND(AVG(Salary_Avg), 0) AS avg_salary
FROM dbo.ds_jobs_cleaned
GROUP BY [Job Title]
ORDER BY avg_salary DESC;


-- =========================================
-- 3. LOCATION ANALYSIS
-- =========================================

-- Top paying states

SELECT 
    State,
    ROUND(AVG(Salary_Avg), 0) AS avg_salary
FROM dbo.ds_jobs_cleaned
GROUP BY State
ORDER BY avg_salary DESC;


--Job distribution by state

SELECT 
    State,
    COUNT(*) AS job_count
FROM dbo.ds_jobs_cleaned
GROUP BY State
ORDER BY job_count DESC;


-- =========================================
-- 4. COMPANY ANALYSIS
-- =========================================
--Top companies by job postings


SELECT TOP 10
    [Company Name],
    COUNT(*) AS job_postings
FROM dbo.ds_jobs_cleaned
GROUP BY [Company Name]
ORDER BY job_postings DESC;


-- =========================================
-- 5. RATING VS SALARY
-- =========================================

SELECT 
    Rating,
    ROUND(AVG(Salary_Avg), 0) AS avg_salary
FROM dbo.ds_jobs_cleaned
WHERE Rating IS NOT NULL
GROUP BY Rating
ORDER BY Rating DESC;


-- =========================================
-- 6. IDUSTRY ANALYSIS
-- =========================================

SELECT TOP 10
    Industry,
    ROUND(AVG(Salary_Avg), 0) AS avg_salary
FROM dbo.ds_jobs_cleaned
WHERE Industry IS NOT NULL
GROUP BY Industry
ORDER BY avg_salary DESC;


-- =========================================
-- 7. SALARY DISTRIBUTION 
-- =========================================

SELECT 
    CASE 
        WHEN Salary_Avg < 50000 THEN 'Low'
        WHEN Salary_Avg BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_range,
    COUNT(*) AS job_count
FROM dbo.ds_jobs_cleaned
GROUP BY 
    CASE 
        WHEN Salary_Avg < 50000 THEN 'Low'
        WHEN Salary_Avg BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END;














