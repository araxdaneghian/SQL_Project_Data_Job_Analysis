-- A way to apply conditional logic within your SQL queries


-- SELECT  - 
--     CASE - begins the expre4ssion
--         WHEN - specifies the conditions to look at
--         THEN - what to do if condition is ture
--         ELSE - output if conditions not met
--     END - concludes Case expression --

-- e.g. reclassify where job is located
/* 
Label new column as:
- 'Anywhere' jobs as 'Remote'
- NEW York, NY' as 'Local'
- Otherwise 'Onsite'

*/


SELECT 
   count(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE  'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category


-- problem
-- categorize salaries from each job postings
-- put salary in different bucket range
-- define high, standard, low
-- only look at Data Analyst jobs
-- order highest to lowest

SELECT
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg IS NULL THEN NULL
        WHEN salary_year_avg BETWEEN 1 AND 100000 THEN 'low'
        WHEN salary_year_avg BETWEEN 100001 AND 200000 THEN 'medium'
        ELSE 'high'
    END AS salary_category
FROM
    job_postings_fact;



SELECT
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg IS NULL THEN NULL
        WHEN salary_year_avg BETWEEN 1 AND 100000 THEN 'low'
        WHEN salary_year_avg BETWEEN 100001 AND 200000 THEN 'medium'
        ELSE 'high'
    END AS salary_category
FROM
    job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC