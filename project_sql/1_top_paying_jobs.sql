SELECT 
    company_dim.name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere'
ORDER BY 
    salary_year_avg DESC
LIMIT 10;