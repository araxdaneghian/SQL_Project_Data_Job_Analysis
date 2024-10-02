-- Create Tables from other tables

-- Create 3 tables: Jan 2023 jobs, Feb 2023 jobs, Mar 2023 jobs


--January
CREATE TABLE January_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE (EXTRACT(MONTH FROM job_posted_date) = 1 AND EXTRACT(YEAR FROM job_posted_date)=2023)


--February
CREATE TABLE February_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

--March
CREATE TABLE March_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

