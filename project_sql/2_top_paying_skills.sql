WITH top_10_jobs AS (
    SELECT 
        company_dim.name AS company_name,
        job_id,
        job_title,
        salary_year_avg
    FROM 
        job_postings_fact
    INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere'
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_10_jobs.*,
    skills
FROM top_10_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_10_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
