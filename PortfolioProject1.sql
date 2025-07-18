Select *
from CovidDeaths
where continent is not null
order by 3,4

--Select * 
--from CovidVaccinations$
--order by 3,4
--- select Data that we are going To be using 

Select Location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths
order by 1,2

-- Looking at Total cases vs Total deaths 

Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Death_Percentage
from CovidDeaths
Where location like '%Ind%'
order by 1,2

---looking at he total case vs population 

Select Location,date,Population,total_cases,(total_cases/population)*100 as cases_percentage_totalPopulation
from CovidDeaths
--Where location like '%Ind%'
order by 1,2

--- Looking at countries with highest infection rate Vs Population

Select Location,Population,Max(total_cases) HighestInfectionCount,Max((total_cases/population))*100 as Percent_population_infected
from CovidDeaths
--Where location like '%Ind%'
group by Location, Population
order by Percent_population_infected desc

--- Showing Countries with HIghest death Count

Select Location, Max(cast(total_deaths as int)) As TotalDeathCount
from CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc


--- showing countries with Highest Mortality rate 

Select location, Max(cast(total_deaths as int)) As TotalDeathCount,Max(total_cases) HighestInfectionCount,Max((cast(total_deaths as int)/total_cases))*100 as MortalityRate
from CovidDeaths
where continent is not   null

group by location
order by TotalDeathCount desc


--Showing Continent with Highest death Count 

Select continent ,Max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is not null
group by continent 
order by TotalDeathCount Desc

--  GLOBAL NUMBERS
Select sum(new_cases) total_new_cases,
sum(cast(new_deaths as int)) total_new_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_Percentage
from CovidDeaths
Where continent is not null
order by 1,2

-- looking at total population vs  Vaccination 
Select deaths.continent,deaths.location,deaths.date,
deaths.population,vaccine.new_vaccinations ,
sum(cast(vaccine.new_vaccinations as int))over(partition by deaths.location order by deaths.location,deaths.date) as RollingPeoplevaccinated
from CovidDeaths deaths
join  CovidVaccinations$  vaccine
	on deaths.location =vaccine.location
	and deaths.date =vaccine.date
where  deaths.continent is not null and deaths.new_vaccinations is not null
order by 2,3


-- use CTE
with PopvsVac(continent,location,Date,Population,new_vaccinations,RollingPeoplevaccinated)
as
(
Select deaths.continent,deaths.location,deaths.date,
deaths.population,vaccine.new_vaccinations ,
sum(cast(vaccine.new_vaccinations as int))over(partition by deaths.location order by deaths.location,deaths.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from CovidDeaths deaths
join  CovidVaccinations$  vaccine
	on deaths.location =vaccine.location
	and deaths.date =vaccine.date
where  deaths.continent is not null and deaths.new_vaccinations is not null
--order by 2,3
)

select *,(RollingPeopleVaccinated/population)*100 VaccinationPercentage
from  PopvsVac
order by VaccinationPercentage desc




--Temp Table
Drop table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
continent nvarchar(200),
location nvarchar (300),
date datetime,
Population int,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select deaths.continent,deaths.location,deaths.date,
deaths.population,vaccine.new_vaccinations ,
sum(cast(vaccine.new_vaccinations as int))over(partition by deaths.location order by deaths.location,deaths.date) as RollingPeoplevaccinated
--, (RollingPeopleVaccinated/population)*100
from CovidDeaths deaths
join  CovidVaccinations$  vaccine
	on deaths.location =vaccine.location
	and deaths.date =vaccine.date
where  deaths.continent is not null and deaths.new_vaccinations is not null
--order by 2,3


select *,(RollingPeopleVaccinated/population)*100 VaccinationPercentage
from  #PercentPopulationVaccinated
order by VaccinationPercentage desc


        ----- Creating Views For Visualization ------

DROP VIEW IF EXISTS PercentPopulationVaccinated;
GO

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
    deaths.continent,
    deaths.location,
    deaths.date,
    deaths.population,
    vaccine.new_vaccinations,
    SUM(CAST(vaccine.new_vaccinations AS INT))
        OVER (
            PARTITION BY deaths.location 
            ORDER BY deaths.location, deaths.date
        ) AS RollingPeopleVaccinated
FROM CovidDeaths AS deaths
JOIN CovidVaccinations$ AS vaccine
    ON deaths.location = vaccine.location
    AND deaths.date = vaccine.date
WHERE deaths.continent IS NOT NULL 
 


Select *
From PercentPopulationvaccinated
 ---Global Numbers 

go 
CREATE VIEW
GlobalNumbers
as
Select sum(new_cases) total_new_cases,
sum(cast(new_deaths as int)) total_new_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_Percentage
from CovidDeaths
Where continent is not null
--order by 1,2
select * 
From GlobalNumbers

--Showing Continent with Highest death Count 
Go 
CREATE VIEW
DeathOnContinent
As

Select continent ,Max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is not null
group by continent 

select *
from DeathOnContinent
order by TotalDeathCount Desc


--- showing countries with Highest Mortality rate 
Go
Create View
MortalityRate
as
Select location, Max(cast(total_deaths as int)) As TotalDeathCount,Max(total_cases) HighestInfectionCount,Max((cast(total_deaths as int)/total_cases))*100 as MortalityRate
from CovidDeaths
where continent is not   null

group by location


select* 
from MortalityRate
order by TotalDeathCount desc



--- Looking at countries with highest infection rate Vs Population
go 
Create View
InfectionRate
as
Select Location,Population,Max(total_cases) HighestInfectionCount,Max((total_cases/population))*100 as Percent_population_infected
from CovidDeaths
--Where location like '%Ind%'
group by Location, Population


Select*
from InfectionRate
order by Percent_population_infected desc