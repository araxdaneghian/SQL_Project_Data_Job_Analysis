-- COMBINE JAN FEB JOBS IN A NEW TABLE

CREATE TABLE jan_feb_jobs AS (

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs
)


--  UNION ALL DOES NOT REMOVE DUPLICATES, KEEPS ALL
SELECT *
FROM jan_feb_jobs


SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs


-- practice problem 

-- get the skill and skill type for each job posting in q1
-- include those without any skills too
-- look at skills and type for each job in q1 salary > 70,000$


-- not sure if below is fully done

WITH q1_jobs AS (
    SELECT *
    FROM 
    january_jobs

    UNION ALL

    SELECT *
    FROM 
        february_jobs

    UNION ALL

    SELECT *
    FROM 
        march_jobs )


SELECT 
    skills_job_dim.job_id,
    q1_jobs.job_title_short,
    skills_job_dim.skill_id,
    skills_dim.skills AS skill_name,
    skills_dim.type AS skill_type,
    q1_jobs.salary_year_avg
FROM
    skills_job_dim
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LEFT JOIN q1_jobs ON skills_job_dim.job_id = q1_jobs.job_id
WHERE
    ( EXTRACT(MONTH FROM q1_jobs.job_posted_date) <= 3 
    AND q1_jobs.salary_year_avg IS NOT NULL 
    AND q1_jobs.salary_year_avg > 70000)



-- practice problem

-- find job postings from q1 with salary >70K



SELECT 
q1_job_postings.job_title_short,
q1_job_postings.job_location,
q1_job_postings.job_via,
q1_job_postings.job_posted_date,
q1_job_postings.salary_year_avg

FROM (
    SELECT *
    FROM 
    january_jobs
    UNION ALL
    SELECT *
    FROM 
        february_jobs
    UNION ALL
    SELECT *
    FROM 
        march_jobs ) AS q1_job_postings
WHERE 
    (q1_job_postings.salary_year_avg > 70000
    AND q1_job_postings.salary_year_avg IS NOT NULL)