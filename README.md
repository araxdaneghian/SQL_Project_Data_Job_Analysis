# Introduction
 :bar_chart:  Dive into the data job market

  :bulb: sql queries? check them out here: [project_sql folder](/project_sql/)

# Baclkground

## Questions to Answer
1. Top paying jobs for 'Data Analyst'
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role? 
5. what are the most optimal skills to learn?


:bar_chart:

# Tools I Used
- **SQL:**
- **postgresSQL:**
- **Visual Studio Code:**
- **Git & GitHub**

# The Analysis
Each query for this project aimed at 
invesgtigating specific aspects of the 
data analysts job market.
Here is how I approached this

Query I used:

```sql
SELECT
job_id,
job_title,
job_location,
company_dim.name
job_schedule_type,
salary_year_avg,
job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10 
```

# What I learned

# Conclusions 

### Insights
### Closing Thoughts 

- to include images, create folder and insert images in
- copy relative path
- put path in ()

-- ![image] () --> to include images, create folder and insert images in
- copy relative path
- put path in ()

![image](project_sql/assets/sample-plot-matplot.png)

use chat gpt to get table format