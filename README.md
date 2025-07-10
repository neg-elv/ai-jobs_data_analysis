# AI Jobs Salary Analysis 📊💼

A comprehensive data analysis project exploring AI-related job postings. This notebook uses Python and Pandas to uncover salary trends, job structures, and the impact of education and experience. It demonstrates real-world data analysis techniques suitable for job applications and portfolios.

---

## 🎯 Analysis Goals

- Understand salary distribution across job titles, experience levels, and employment types
- Investigate how education and experience influence salary
- Apply advanced pandas techniques like `groupby`, `transform`, `pivot_table`, and `pct_change`
- Visualize insights to support data-driven decisions

---

## 🔍 Key Analysis Performed

### 🧩 Data Exploration
- `describe()` for summary statistics
- `isnull()` for missing value analysis
- `value_counts()` for distributions of `employment_type` and `experience_level`

### 🧠 Grouping & Aggregation
- Grouped **employment type by job title**, created pivot table
- Grouped **experience level by job title**, created pivot table
- Grouped **experience level by company location**, built pivot for regional insights
- Grouped **salary by job title** to see highest/lowest paying roles
- Grouped **salary by experience level** to assess pay progression

### 🎯 Focused Filtering
- Filtered `Entry-level` jobs → grouped salaries to find entry trends
- Filtered `Senior-level` jobs → analyzed salary variation across roles

### ⚙️ Transformations & Rankings
- Created `salary_pct` column using `transform()` to show salary as % of group total (grouped by experience level)
- Used `shift()` to analyze salary change over job sequences
- Applied `pct_change()` to get percentage salary growth
- Used `rank()` to find salary position of each job within its group

### 🎯 Categorizing Salaries Using `qcut`
📌 This divides the dataset into 4 equal-sized groups and assigns labels based on the salary range each row falls into.


### 📊 Visualization
- Bar plots of salary by:
  - Job title
  - Experience level
  - Education required
- Plotted salary distributions and comparisons
- Detected **outliers** in salaries visually and statistically

---

## 📝 Dataset

- `ai_jobs.csv`: Contains job titles, company info, salary (USD), employment type, experience level, education required, job description length, and more.

---

## 💡 Sample Insights

- Entry-level roles vary widely in salary depending on job title and industry
- Senior roles in startups sometimes pay more than large companies
- Higher education (e.g. PhD) doesn't guarantee higher salary
- `salary_pct` helps to compare salaries *within* experience groups
- Percentage change (`pct_change`) highlights salary growth patterns

---

---

📂 **SQL Analysis**  
For full SQL-based exploration of this dataset, see:  
👉 [`ai_jobs_sql_analysis.md`](ai_jobs_sql_analysis.md)



