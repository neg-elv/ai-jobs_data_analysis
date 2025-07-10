# 🧠 AI Jobs SQL Analysis (MySQL)

This document contains all SQL queries used to analyze the `ai_job` dataset.  
Each query includes a brief explanation to describe the insight it provides.

---

## 1. 🔢 Count total rows in the table

```sql
SELECT COUNT(*) FROM ai_job;
```

---

## 2. 💵 Average salary and job count per job title

```sql
SELECT job_title, 
       TRUNCATE(AVG(salary_usd), 2) AS avg_salary, 
       COUNT(job_title) AS job_count
FROM ai_job
GROUP BY job_title
ORDER BY avg_salary DESC;
```

---

## 3. 🏢 Number of employees by company size and experience level

```sql
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
```

---

## 4. 🌍 Employees by company location and residence

```sql
SELECT 
    company_location,
    employee_residence,
    COUNT(*) AS count_jobs
FROM ai_jobs_db.ai_job
GROUP BY 
    company_location,
    employee_residence
ORDER BY count_jobs DESC;
```

---

## 5. 💼 Average salary by experience level

```sql
SELECT 
    FORMAT(AVG(salary_usd), 0) AS avg_salary,
    experience_level
FROM ai_job
GROUP BY experience_level
ORDER BY avg_salary;
```

---

## 6. 💼 Average salary and count per employment type

```sql
SELECT 
    FORMAT(AVG(salary_usd), 0) AS avg_salary,
    employment_type,
    COUNT(*) AS count
FROM ai_job
GROUP BY employment_type
ORDER BY count;
```

---

## 7. 📍 Jobs where salary is above average for that job title

```sql
WITH avg_salary AS (
    SELECT job_title, AVG(salary_usd) AS avg_salary
    FROM ai_job
    GROUP BY job_title
)
SELECT 
    aj.job_title,
    FORMAT(aj.salary_usd, 0) AS salary_usd,
    FORMAT(a.avg_salary, 0),
    aj.company_location
FROM ai_job aj
JOIN avg_salary a ON aj.job_title = a.job_title
WHERE aj.salary_usd > a.avg_salary;
```

---

## 8. 📊 Average salary and job count by experience level and employment type

```sql
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
GROUP BY 
    ai.job_title, ai.employment_type, 
    ex.avg_salary, ex.experience_level
ORDER BY ex.avg_salary DESC;
```

---

## 9. 🎓 Average years of experience by job title and level

```sql
SELECT 
    job_title,
    experience_level,
    FORMAT(AVG(years_experience), 1) AS avg_experience
FROM ai_job
GROUP BY job_title, experience_level
ORDER BY AVG(years_experience) DESC;
```

---

## 10. 💰 Average salary by experience level and company size

```sql
SELECT 
    experience_level,
    FORMAT(AVG(salary_usd), 0) AS avg_salary,
    company_size
FROM ai_job
GROUP BY experience_level, company_size
ORDER BY AVG(salary_usd) DESC;
```

---

## 11. 🏅 Top 3 salaries per job title using RANK()

```sql
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
```

---

## 12. 💸 Avg salary for each experience level using window function

```sql
SELECT 
    job_title,
    experience_level,
    salary_usd,
    AVG(salary_usd) OVER(PARTITION BY experience_level) AS avg_salary_by_experience
FROM ai_job;
```

---

## 13. 🏆 Ranking salaries within each experience level

```sql
SELECT 
    job_title,
    salary_usd,
    RANK() OVER(PARTITION BY experience_level) 
FROM ai_job;
```

---

## 14. 🧭 Rank salaries by experience level (descending order)

```sql
SELECT 
    job_title,
    experience_level,
    salary_usd,
    RANK() OVER(PARTITION BY experience_level ORDER BY salary_usd DESC) AS salary_rank
FROM ai_job;
```