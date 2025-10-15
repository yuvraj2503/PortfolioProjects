Select * from USHouseholdIncome

Select * From USHouseholdIncome_Statistics


Select count(id)
from USHouseholdIncome

select Count(id)
from USHouseholdIncome_Statistics

Select id, Count(id)
from USHouseholdIncome
group by id 
having count(id)>1

Delete from USHouseholdIncome
where row_id IN(
	Select row_id
	From(
		Select row_id,
		id,
		ROW_NUMBER()over (Partition by id order by id) row_num
		from USHouseholdIncome)duplicates
	 Where row_num>1)
;

Select Distinct state_name
from USHouseholdIncome
order by 1


update USHouseholdIncome
Set State_Name = 'Georgia'
where State_Name ='georia'

update USHouseholdIncome
Set State_Name ='Alabama'
Where State_name = 'alabama'


Select * from 
USHouseholdIncome
where place is NUll
order by 1

update USHouseholdIncome
set Place = 'Autaugaville'
Where place is null


Select Type , count (type)
From USHouseholdIncome
Group by Type


Update USHouseholdIncome
Set Type = 'Borough'
where type = 'Boroughs'

SELECT ALand, AWater
FROM USHouseholdIncome
WHERE( TRY_CAST(AWater AS BIGINT) IS NULL 
      OR TRY_CAST(AWater AS BIGINT) =0 
	  or
	  Try_cast(Awater as bigint) = '')

And( ALand =0 or Aland ='' or ALand is null)



Select *
from USHouseholdIncome

Select * 
From USHouseholdIncome_Statistics

Select State_Name,Sum(Try_cast (Aland as bigint)) TotalLand_In_State,Sum(Try_Cast(AWater as Bigint)) Total_WaterA_In_State
from USHouseholdIncome
Group By State_Name
Order By 2 Desc


Select Top 10 u.State_Name,Round(Avg(Mean),1) avg_mean_income,Round(Avg(Median) ,1) avg_median_income
From USHouseholdIncome u
Inner join USHouseholdIncome_Statistics u_s
on u.id = u_s.id
where Mean <> 0
group by u.State_Name
order by 2 desc


Select Top 10 u.State_Name,Round(Avg(Mean),1) avg_mean_income,Round(Avg(Median) ,1) avg_median_income
From USHouseholdIncome u
Inner join USHouseholdIncome_Statistics u_s
on u.id = u_s.id
where Mean <> 0
group by u.State_Name
order by 3 desc


Select Top 10 u.State_Name,Round(Avg(Mean),1) avg_mean_income,Round(Avg(Median) ,1) avg_median_income
From USHouseholdIncome u
Inner join USHouseholdIncome_Statistics u_s
on u.id = u_s.id
where Mean <> 0
group by u.State_Name
order by 2 


Select Top 10 u.State_Name,Round(Avg(Mean),1) avg_mean_income,Round(Avg(Median) ,1) avg_median_income
From USHouseholdIncome u
Inner join USHouseholdIncome_Statistics u_s
on u.id = u_s.id
where Mean <> 0
group by u.State_Name
order by 3


Select Top 20 u.Type,Count(Type) Count_Type,Round(Avg(Mean),1) avg_mean_income,Round(Avg(Median) ,1) avg_median_income
From USHouseholdIncome u
Inner join USHouseholdIncome_Statistics u_s
on u.id = u_s.id
where Mean <> 0
group by Type
Having Count(Type) > 50
order by 4 desc


Select Top 30 u.State_Name,City,Round(Avg(Mean),1) avg_mean_income,
Round(Avg(Median),1) avg_median_income
From USHouseholdIncome u
Inner join USHouseholdIncome_Statistics u_s
on u.id = u_s.id
where Mean <> 0
group by City, u.State_Name
order by Round(Avg(Mean),1) desc

