-- 4. What are the top skills based on salary for my role? 
-- look at average salary with each skill for Data analysts


SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS skill_avg_salary
FROM   
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
        job_title_short = 'Data Analyst' AND
      --  job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    skill_avg_salary DESC
LIMIT 25


-- ROUND(col, # of digits) 