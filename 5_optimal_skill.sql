/*
Question: What are the most optimal skills to learn (its high demand and high paying skill).
-Identify skills in high-demand and associate with high average salary for data analyst positions
-Concentrate on remote positions with specified salaries.
-Why? Target skills that offers job security( high demand) and financial benefit (high compensation),
offering strategic insight for career development in Data Analysis.
*/

WITH skills_demand AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim_2.job_id) AS demand_count
FROM 
    job_postings_fact
    JOIN skills_job_dim_2 ON job_postings_fact.job_id = skills_job_dim_2.job_id
    JOIN skills_dim ON skills_job_dim_2.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = 'True'
GROUP BY
    skills_dim.skill_id
), average_salary AS (
SELECT 
    skills_job_dim_2.skill_id,
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
    JOIN skills_job_dim_2 ON job_postings_fact.job_id = skills_job_dim_2.job_id
    JOIN skills_dim ON skills_job_dim_2.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = 'True'
GROUP BY
    skills_job_dim_2.skill_id,
    skills_dim.skills
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
    JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 20;



SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim_2.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
    JOIN skills_job_dim_2 ON job_postings_fact.job_id = skills_job_dim_2.job_id
    JOIN skills_dim ON skills_job_dim_2.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = 'True'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim_2.job_id) > 20
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 20;