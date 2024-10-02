-- subquerieas

-- can be used in SELECT, FROM, WHERE or HAVING clauses


--subquery
SELECT *
FROM (-- subquery starts here)
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS January_jobs;   --subquery ends here

--CTE
WITH january_jobs AS ( -- CTE definition starts here
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) --CTE definition ends here

SELECT *
FROM january_jobs;

-- e.g. Get list of companies offering jobs with no degree requirements

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
        )

--e.g. CTE
-- FInd companies with most job openings
-- get total # of job postings per company id
-- return total # of jobs with comp name

WITH company_job_count AS (
    SELECT company_id,
            count(company_id) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT 
    company_dim.company_id,
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;

--problem

-- identify top 5 skills most frequently mentioned in job postings.
-- use subquery to find skill Ids with highest counts table
-- get skill name (join results)


SELECT skills
FROM skills_dim
WHERE skill_id in (
    SELECT 
    skill_id
    FROM 
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY count(skill_id) DESC
    LIMIT 5
    );


-- problem 2

--  determine size category (small, medium, large) for each company by:
--1. identify # of job postings  - usew subquery
-- small: <10 , medium <=50, large > 50
-- subquery>> aggregate job counts per company before classifying based on size

WITH job_categ AS(
SELECT 
    company_id AS id,
    count(company_id) AS job_post_count,
    CASE 
        WHEN count(company_id) < 10 THEN 'small'
        WHEN count(company_id) BETWEEN 10 AND 50 THEN 'medium'
        ELSE 'large'
    END AS company_category
FROM 
    job_postings_fact
GROUP BY
    company_id
)

SELECT
    company_id,
    name AS company_name,
    job_categ.company_category
 FROM 
    company_dim
 LEFT JOIN job_categ ON company_dim.company_id = job_categ.id;



--  Practice Problem

-- Find count of the number of remote job postings per skill
-- Display top 5 skills by their demand in remote jobs
-- include skill ID, name, and count of postings requiring the skill




WITH remote_job_skills AS (
    SELECT 
        skill_id,
        count(skill_id) as skill_count
    FROM skills_job_dim
    WHERE job_id IN (
        SELECT
            job_id AS id
        FROM
            job_postings_fact
        WHERE
            job_work_from_home = True
        )
    GROUP BY 
    skill_id
)

SELECT
    skills_dim.skill_id,
    skills,
    remote_job_skills.skill_count
FROM
    skills_dim
INNER JOIN remote_job_skills ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY 
    remote_job_skills.skill_count DESC
LIMIT 5


-- now do the same filter for data analyst jobs

WITH remote_job_skills AS (
    SELECT 
        skill_id,
        count(skill_id) as skill_count
    FROM skills_job_dim
    WHERE job_id IN (
        SELECT
            job_id AS id
        FROM
            job_postings_fact
        WHERE
            job_work_from_home = True AND job_title_short = 'Data Analyst'
        )
    GROUP BY 
    skill_id
)

SELECT
    skills_dim.skill_id,
    skills,
    remote_job_skills.skill_count
FROM
    skills_dim
INNER JOIN remote_job_skills ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY 
    remote_job_skills.skill_count DESC
LIMIT 5
