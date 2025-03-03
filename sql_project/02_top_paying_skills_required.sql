/*
Question:What are the skills required for these top-paying jobs?
-Use the Top 10 huighest-paying data analayst jobs from the first query.
-Add the specific skills required for those roles.
-Why? It provides a detailed look at which high-paying jobs demand certain skills,
 helping job seekers to understand which skills to develop that align with top salaries.
*/
WITH top_paying_jobs AS (
    SELECT
        jpc.job_id,
        jpc.job_title,
        company.name AS company_name,
        jpc.salary_year_avg
    FROM
        job_postings_fact AS jpc
    LEFT JOIN company_dim AS company
        ON company.company_id=jpc.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;