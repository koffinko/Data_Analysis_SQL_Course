SELECT 
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS salary_avg
FROM 
    skills_job_dim
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL 
    -- AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    salary_avg DESC
LIMIT 25;