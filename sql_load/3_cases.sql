CREATE TABLE january_jobs AS
    SELECT *
    FROM 
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT * 
    FROM 
        job_postings_fact 
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT * 
    FROM 
        job_postings_fact 
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT 
    job_posted_date
FROM
    march_jobs
    LIMIT 10;

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location ='Anywhere' THEN 'Remote'
        WHEN job_location = 'New York' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
    LIMIT 30;

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location ='Anywhere' THEN 'Remote'
        WHEN job_location = 'New York' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

SELECT *
FROM
    job_postings_fact
LIMIT 2;

SELECT *
FROM
    (SELECT *
    FROM 
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

WITH
    january_jobs AS(
        SELECT *
        FROM 
            job_postings_fact
        WHERE
            EXTRACT(MONTH FROM job_posted_date) = 1
    )
SELECT *
FROM
    january_jobs;
