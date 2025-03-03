/*
Question:What are thw top-paying data analyst jobs?
-Identify the top 10 highest-paying data analst roles that are available remotely.
-Focues on job postings with specified salaries (remove nulls).
-Why? Highlight the top-paying opportunities for data analyst, offering insights into employment opportunites.
*/

SELECT
    jpc.job_id,
    jpc.job_title,
    jpc.job_location,
    company.name AS company_name,
    jpc.job_schedule_type,
    jpc.salary_year_avg,
    jpc.job_posted_date ::DATE
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
LIMIT 10;