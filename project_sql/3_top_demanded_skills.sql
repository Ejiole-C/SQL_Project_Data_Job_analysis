/*
Question: What are the most in-demand skill for data analyst positions?
-Join job postngs to inner join table similar to query 2
-Identify the top 5 in-demand skills for data analyst positions
-Focua on all job postings
-Why? To retrieve the top 5 skills with the highest demand in the job market , providing insights into the 
most valubale sjills for job seekers.
*/
SELECT 
    skills,
    COUNT(skills_job_dim_2.job_id) AS demand_count
FROM 
    job_postings_fact
    JOIN skills_job_dim_2 ON job_postings_fact.job_id = skills_job_dim_2.job_id
    JOIN skills_dim ON skills_job_dim_2.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = 'True'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;