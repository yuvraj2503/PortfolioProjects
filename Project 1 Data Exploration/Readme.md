📘 README: COVID-19 Data Analysis and Vaccination Tracking
🧩 Project Overview

This SQL project performs data cleaning, aggregation, and analysis on COVID-19 case, death, and vaccination datasets (CovidDeaths and CovidVaccinations$).
The goal is to analyse infection trends, mortality rates, vaccination progress, and generate actionable insights by country and continent.

⚙️ Steps & Methodology
1. Data Inspection
   ```sql
   SELECT * FROM CovidDeaths WHERE continent IS NOT NULL;

Previewed raw COVID-19 cases and death data.

Checked the completeness and integrity of key columns.

2. Data Cleaning & Preparation

Filtered null values in the continent and vaccination columns.

Standardized numeric columns (total_cases, total_deaths, new_vaccinations) using CAST/TRY_CAST.

Created temporary tables and CTEs for cumulative vaccination calculations.

3. Key Analytical Queries

Death Percentage by Country
```sql
SELECT location, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage
FROM CovidDeaths;

```
Case Percentage vs Population
```sql
SELECT location, total_cases, population, (total_cases/population)*100 AS cases_percentage_totalPopulation
FROM CovidDeaths;

```
Top Countries by Infection Rate & Mortality

Aggregated infection and death counts to identify countries with the highest rates.

Calculated mortality rates for comparative analysis.

Vaccination Tracking
```sql
WITH PopvsVac AS (
  SELECT deaths.continent, deaths.location, deaths.date, deaths.population,
         vaccine.new_vaccinations,
         SUM(CAST(vaccine.new_vaccinations AS INT)) OVER (PARTITION BY deaths. location ORDER BY deaths.date) AS RollingPeopleVaccinated
  FROM CovidDeaths deaths
  JOIN CovidVaccinations$ vaccine ON deaths.location = vaccine.location AND deaths.date = vaccine.date
)
SELECT *, (RollingPeopleVaccinated/population)*100 AS VaccinationPercentage
FROM PopvsVac;

```
Global Aggregates and Views

GlobalNumbers: Total new cases, deaths, global death percentage.

DeathOnContinent: Highest death counts per continent.

MortalityRate: Mortality rates by country.

InfectionRate: Infection percentage relative to population.

PercentPopulationVaccinated: Vaccination progress by country.

🗂️ Dataset Summary
| Table                  | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| **CovidDeaths**        | Daily COVID-19 cases, deaths, population, and location data. |
| **CovidVaccinations$** | Daily vaccination counts per country.                        |

🧠 Key Takeaways

Data Cleaning & Validation

Filtered null values, standardised numeric columns, and resolved inconsistencies for accurate analysis.

Used CTEs, temporary tables, and window functions to calculate cumulative vaccinations.

Analytical Insights

Identified countries with the highest infection rates relative to population.

Determined mortality rates by country and death counts by continent.

Tracked vaccination progress and calculated the percentage of the population vaccinated per country.

Skill Demonstrated

SQL querying for data cleaning, aggregation, and advanced analytics.

Use of CTEs, window functions, and views for complex reporting.

Prepared datasets for visualisation and actionable public health insights.

🧩 Tools Used

SQL Server / Azure Data Studio

T-SQL: Joins, Aggregates, CTEs, Window Functions, Views, Type Casting

🏁 Outcome

Created clean, structured, and analysis-ready datasets for COVID-19 cases, deaths, and vaccinations, enabling identification of high-risk regions and vaccination progress tracking globally.
