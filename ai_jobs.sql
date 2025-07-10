CREATE DATABASE ai_jobs_db;

-- showing rows number in our table
SELECT  COUNT(*)FROM ai_job;

-- showing avg_salary for every job title with the count of that job
SELECT job_title, TRUNCATE(AVG(salary_usd), 2) AS avg_salary, COUNT(job_title) AS job_count
FROM ai_job
GROUP BY job_title
ORDER BY avg_salary DESC;

-- Showing how many employees of each experience level exist within each company size.
SELECT
  company_size,
  experience_level,
  COUNT(*) AS job_count
FROM ai_job
GROUP BY
  company_size,
  experience_level
ORDER BY
  company_size,
  experience_level;
  
  -- Showing how many employees each company location has and where they are from.
  SELECT
  company_location,
  employee_residence,
  COUNT(*) AS count_jobs
FROM
  ai_jobs_db.ai_job
GROUP BY
  company_location,
  employee_residence
ORDER BY
  count_jobs DESC;
  
-- Showing the avg_salary for each experience level
  SELECT
	FORMAT(AVG(salary_usd),0) AS avg_salary,
    experience_level
FROM ai_job
GROUP BY experience_level
ORDER BY avg_salary;

-- Showing the avg_salary and the count for each employment_type
SELECT 
	FORMAT(AVG(salary_usd), 0) AS avg_salary, 
    employment_type, 
    COUNT(*) AS count
FROM ai_job
GROUP BY employment_type
ORDER BY count;

-- Showing job titles and their locations where the salary is higher than the average salary for that job

WITH avg_salary AS (
  SELECT job_title, AVG(salary_usd) AS avg_salary
  FROM ai_job
  GROUP BY job_title
)
SELECT 
	aj.job_title, 
    FORMAT(aj.salary_usd,0) AS salary_usd,
	FORMAT(a.avg_salary,0),	
    aj.company_location
FROM ai_job aj
JOIN avg_salary a ON aj.job_title = a.job_title
WHERE aj.salary_usd > a.avg_salary;


-- Showing average salary and job count for each job title, based on type of contract (employment_type) and experience level.

WITH experience_salary AS (
	SELECT 
		experience_level,
		AVG(salary_usd) AS avg_salary
	FROM ai_job
    GROUP BY experience_level
)
SELECT 
	ai.job_title,
    ex.experience_level,
	ai.employment_type, 
    COUNT(*) AS total_jobs,
    FORMAT(ex.avg_salary, 0) AS avg_salary
FROM ai_job ai
JOIN experience_salary ex
USING(experience_level)
GROUP BY ai.job_title, ai.employment_type, 
    ex.avg_salary, ex.experience_level
ORDER BY ex.avg_salary DESC;



-- Showing average years of experience required for each job title based on the experience level category (e.g., EN, MI, SE, EX)
SELECT 
	job_title,
    experience_level,
    FORMAT(AVG(years_experience),1) AS avg_experience
FROM ai_job
GROUP BY job_title, experience_level
ORDER BY AVG(years_experience) DESC;




--  Showing average salary based on experience level and company size

SELECT 
	experience_level,
	FORMAT(AVG(salary_usd),0) AS avg_salary,
    company_size
FROM ai_job
GROUP BY experience_level, company_size
ORDER BY AVG(salary_usd) DESC ;
    

-- This query uses the RANK() window function with PARTITION BY job_title to rank salaries within each job title group in descending order.

SELECT *
FROM (
	SELECT 
    job_title,
    company_location,
    salary_usd,
    RANK() OVER (PARTITION BY job_title ORDER BY salary_usd DESC) AS salary_rank
FROM ai_job
) AS ranked_jobs
WHERE salary_rank <= 3;


-- showing avg of salary for eazh experience level

SELECT 
  job_title,
  experience_level,
  salary_usd,
  AVG(salary_usd) OVER(PARTITION BY experience_level) AS avg_salary_by_experience
FROM ai_job;




SELECT job_title, salary_usd, RANK() OVER(PARTITION BY experience_level)
FROM ai_job;
 
 -- showing rank for salaries based on experience level
 
SELECT 
  job_title,
  experience_level,
  salary_usd,
  RANK() OVER(PARTITION BY experience_level ORDER BY salary_usd DESC) AS salary_rank
FROM ai_job;







    
    


    


