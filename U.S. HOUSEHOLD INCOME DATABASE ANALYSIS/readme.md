# 🏠 U.S. Household Income — Data Cleaning & SQL Analysis

## 📘 Project Overview
This SQL project focuses on **data cleaning, validation, and exploratory data analysis (EDA)** for two datasets:

- `USHouseholdIncome`
- `USHouseholdIncome_Statistics`

The goal is to ensure data quality, remove duplicates, fix inconsistent values, and extract insights about **income distribution, land/water area, and household income** across U.S. states and cities.

---

## ⚙️ Steps & Methodology

### 1️⃣ Data Inspection
```sql
SELECT * FROM USHouseholdIncome;
SELECT * FROM USHouseholdIncome_Statistics;
SELECT COUNT(id) FROM USHouseholdIncome;
SELECT COUNT(id) FROM USHouseholdIncome_Statistics;
```
✔️ Verified dataset structure and record counts for both tables.

2️⃣ Duplicate Removal
```sql
SELECT id, COUNT(id)
FROM USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1;

DELETE FROM USHouseholdIncome
WHERE row_id IN (
  SELECT row_id
  FROM (
    SELECT row_id, id,
           ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
    FROM USHouseholdIncome
  ) duplicates
  WHERE row_num > 1
);
```

🧹 Removed duplicate records using the ROW_NUMBER() window function.

3️⃣ Data Standardization
```sql
UPDATE USHouseholdIncome
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE USHouseholdIncome
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';
```

🔤 Fixed inconsistent spellings and standardized text values.

4️⃣ Handling Missing Values
```sql
SELECT * 
FROM USHouseholdIncome
WHERE Place IS NULL
ORDER BY 1;

UPDATE USHouseholdIncome
SET Place = 'Autaugaville'
WHERE Place IS NULL;
```

💾 Filled missing Place entries to ensure data completeness.

5️⃣ Data Validation
```sql
SELECT ALand, AWater
FROM USHouseholdIncome
WHERE (TRY_CAST(AWater AS BIGINT) IS NULL OR TRY_CAST(AWater AS BIGINT) = 0)
  AND (ALand IS NULL OR TRY_CAST(ALand AS BIGINT) = 0);
```

🧪 Validated numeric integrity of ALand and AWater fields.

6️⃣ Aggregation & Insights
🔹 Total Land and Water Area by State
```sql
SELECT State_Name,
       SUM(TRY_CAST(ALand AS BIGINT)) AS TotalLand_In_State,
       SUM(TRY_CAST(AWater AS BIGINT)) AS Total_WaterA_In_State
FROM USHouseholdIncome
GROUP BY State_Name
ORDER BY 2 DESC;
```
🔹 Top 10 States by Average Income
```sql
SELECT TOP 10 u.State_Name,
       ROUND(AVG(Mean),1) AS avg_mean_income,
       ROUND(AVG(Median),1) AS avg_median_income
FROM USHouseholdIncome u
JOIN USHouseholdIncome_Statistics u_s
ON u.id = u_s.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC;
```

🔹 Income by Type & City
```sql
SELECT TOP 30 u.State_Name, City,
       ROUND(AVG(Mean),1) AS avg_mean_income,
       ROUND(AVG(Median),1) AS avg_median_income
FROM USHouseholdIncome u
JOIN USHouseholdIncome_Statistics u_s
ON u.id = u_s.id
WHERE Mean <> 0
GROUP BY City, u.State_Name
ORDER BY avg_mean_income DESC;
```

📊 Derived insights on income variations across states, city types, and regions.

🗂️ Dataset Summary

| Table                        | Description                                                                                      |
| ---------------------------- | ------------------------------------------------------------------------------------------------ |
| USHouseholdIncome            | Contains demographic and geographic information (state, city, land area, water area, type, etc.) |
| USHouseholdIncome_Statistics | Includes household income metrics (mean and median income per area ID)                           |


💡 Key Takeaways
🧹 Data Cleaning Achievements

Removed duplicates using ROW_NUMBER() window function.

Fixed inconsistent State_Name and Type entries.

Standardized null and invalid values.

🔍 Quality Checks

Ensured numeric integrity of land and water fields.

Removed/flagged invalid or non-numeric data.

💰 Analytical Insights

Identified top-performing states by mean and median income.

Aggregated land and water area by state.

Highlighted cities and region types with highest household incomes.

🧠 Skills Demonstrated

SQL data cleaning & preprocessing

Window functions (ROW_NUMBER())

Joins, Aggregations, and HAVING clauses

Data validation using TRY_CAST()

Analytical reporting

🧩 Tools Used

Microsoft SQL Server / Azure Data Studio

T-SQL for querying and transformation

GitHub for project versioning and documentation

🏁 Outcome

This project successfully cleaned and analyzed the U.S. Household Income dataset, producing meaningful insights on income distribution by state and city.
The cleaned dataset is now ready for visualization (Power BI / Tableau) or machine learning analysis.

### 🏷️ Tags & Topics
[SQL](https://github.com/topics/sql)  
[DataCleaning](https://github.com/topics/data-cleaning)  
[EDA](https://github.com/topics/eda)  
[DataAnalytics](https://github.com/topics/data-analytics)  
[TSQL](https://github.com/topics/tsql)  
[DataPreprocessing](https://github.com/topics/data-preprocessing)  
[DataQuality](https://github.com/topics/data-quality)  
[DatabaseProject](https://github.com/topics/database-project)  
[DataWrangling](https://github.com/topics/data-wrangling)  
[SQLQueries](https://github.com/topics/sql-queries)  
[SQLServer](https://github.com/topics/sql-server)  
[Analytics](https://github.com/topics/analytics)  
[IncomeAnalysis](https://github.com/topics/income-analysis)  
[USData](https://github.com/topics/us-data)  
[DataAnalysisProject](https://github.com/topics/data-analysis-project)

