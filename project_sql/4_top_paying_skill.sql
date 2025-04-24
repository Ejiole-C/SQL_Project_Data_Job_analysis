/*
Question: What are the top paying skills based on salary?
-Look at the average salary associated with each skill for Data Analyst positions 
-Focus on roles with specified salaries regardless of location
-Why? it reveals how different skills can impact salary levels for Data Analysts and 
help identify the most financially rewarding skills to develop or acquire.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
    JOIN skills_job_dim_2 ON job_postings_fact.job_id = skills_job_dim_2.job_id
    JOIN skills_dim ON skills_job_dim_2.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    --job_work_from_home = 'True'
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;