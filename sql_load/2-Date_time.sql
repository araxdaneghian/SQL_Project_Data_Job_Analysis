/*

:: converts
::DATE converts to a date format by removing the time portion
AT TIME ZONE converts a timestamp to a specified time zone
EXTRACT gets specific date parts (e.g., year, month, day)

*/

SELECT 
    '2023-02-19':: DATE,
    '123':: INTEGER,
    'true':: BOOLEAN,
    '3.14':: REAL;


SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date:: DATE as DATE,
    job_posted_date,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM 
    job_postings_fact
    LIMIT 5;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year,
    EXTRACT(HOUR FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')) AS TIME
FROM
    job_postings_fact
LIMIT 25;


SELECT 
    job_id,
    EXTRACT(MONTH FROM job_posted_date) AS month 
FROM job_postings_fact
LIMIT 5;

-- count jobs by month
SELECT 
    count(job_id) AS count_jobs,
    EXTRACT(MONTH FROM job_posted_date) AS month 
FROM job_postings_fact
GROUP BY
    month
ORDER BY month;

-- count Data Analyst roles by month
SELECT 
    count(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month 
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY job_posted_count DESC;

-- problem 1
-- find average salary both yearly and hourly for job postings after June 2023, Group by job_schedule_type

SELECT
    EXTRACT(MONTH FROM job_posted_date) AS month,
--    EXTRACT(HOUR FROM job_posted_date) AS time,
    --  job_schedule_type,
     AVG(salary_year_avg) AS avg_salary
FROM
    job_postings_fact
WHERE (salary_year_avg IS NOT NULL AND EXTRACT(MONTH FROM job_posted_date)>=6 AND EXTRACT(YEAR FROM job_posted_date)=2023)
GROUP BY
    month

-- problem 2
-- count number of job postings for each month in 2023, adjust time zone to in American/New_York' before extracting the month
-- assume job posted date is in UTC. Group by and order by the month

SELECT
DISTINCT(EXTRACT(YEAR FROM job_posted_date)) AS year
FROM job_postings_fact

SELECT
EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EDT')) AS month,
COUNT(job_id) AS job_posted_count
FROM
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date)>=2023
GROUP BY
    month
ORDER BY
    month


-- problem 3
-- find companies (name) that have posted jobs offering with health insurance, where these postings were made in Q2, 2023.
-- Use data extraction to filter by Quarter

SELECT
    EXTRACT(YEAR FROM job_posted_date) AS year,
    EXTRACT(QUARTER FROM job_posted_date) AS quarter,
    job_health_insurance,
    companies.name
FROM 
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE (EXTRACT(YEAR FROM job_posted_date) =2023 AND EXTRACT(QUARTER FROM job_posted_date) =2 AND job_health_insurance)



