-- short version
SELECT 
    skills_job_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS salary_avg,
    COUNT(skills_job_dim.*) AS times_skill_mentioned
    FROM 
        skills_job_dim
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = TRUE
GROUP BY 
    skills_job_dim.skill_id,
    skills
HAVING
    COUNT(skills_job_dim.*) > 10
ORDER BY 
    salary_avg DESC,
    times_skill_mentioned DESC
LIMIT 25;




-- long version

WITH top_salary_skills AS (
    SELECT 
        skills_job_dim.skill_id,
        skills,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS salary_avg
    FROM 
        skills_job_dim
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id,
        skills
), top_demand_skills AS (
    SELECT 
        skills_job_dim.skill_id,
        skills,
        COUNT(*) AS times_skill_mentioned
    FROM 
        skills_job_dim
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id,
        skills
)

SELECT 
    top_demand_skills.skill_id,
    top_demand_skills.skills,
    times_skill_mentioned,
    salary_avg
FROM top_demand_skills
LEFT JOIN top_salary_skills ON top_salary_skills.skill_id = top_demand_skills.skill_id
WHERE
    times_skill_mentioned > 10
ORDER BY 
    salary_avg DESC,
    times_skill_mentioned DESC
LIMIT 25;
