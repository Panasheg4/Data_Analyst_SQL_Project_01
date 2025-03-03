/*
Question:What are the most optimal skilss to learn (aka its in high demand and a high-paying skill)?
-Identify skills in high demand and asscoiatedd with high average fro data analysts
-Concenetrate on the remote positions with specialized salaries
-Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
 offering strategic insights for carrer development in data analysis
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id, 
        COUNT(skills_job_dim.job_id) AS demand_numbers
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_numbers,
    salary_avg
FROM
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_numbers DESC,
    salary_avg DESC
LIMIT 20;
