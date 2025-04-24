/*
Question: What are the skills required for these top-paying data analyst jobs?
-Use the top 10 highest paying data analyst  jobs from the first query
-Add the specofic skills required for these roles
-Why? It provides a detailed look at which high paying job demands a certain dkills, 
helping job seekers understand which skill to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
        JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
JOIN skills_job_dim_2 ON top_paying_jobs.job_id = skills_job_dim_2.job_id
JOIN skills_dim ON skills_job_dim_2.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
   