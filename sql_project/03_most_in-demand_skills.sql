/*
Question:What are the most in_dmand skills for data analysts?
-Join job postings fact to inner job table similar to query 2.
-Identigy the top 5 in-demand skills for a data analyst.
-Focus on all the job postings.
-Why? Retrieve the top 5 skills with the highest demnd on the job market,
 providing insidghts into the most valuable skills fro job seekers.
*/

SELECT *
FROM
job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
LIMIT 5;