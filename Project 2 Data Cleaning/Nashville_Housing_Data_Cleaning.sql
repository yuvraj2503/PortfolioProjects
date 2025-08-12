SELECT name 
FROM sys.tables 
WHERE name LIKE '%Nashville%';
EXEC sp_rename 'NashvilleHousing', 'Nashville_Housing';


Select * 
from Nashville_Housing

--- Standardize Date Format

Select SaleDateConverted,Convert(Date,SaleDate)
from Nashville_Housing

Update Nashville_Housing
Set SaleDate = Convert(Date,SaleDate)

Alter Table NashvilleHousing 
Add SaleDateConverted Date ;

Update Nashville_Housing
Set SaleDateConverted = Convert(Date,SaleDate)


 ALTER TABLE Nashville_Housing
DROP COLUMN SaleDate;
EXEC sp_rename 'Nashville_Housing.SaleDateConverted', 'SaleDate', 'COLUMN';

Select *from
Nashville_Housing
order by ParcelId


Select a.ParcelId,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.propertyAddress,b.PropertyAddress)
from Nashville_Housing a
Join Nashville_Housing b
 on a.ParcelId =b.ParcelId
 and a.[UniqueID ] <>b.[UniqueID ]
where a.PropertyAddress is null


Update a
set PropertyAddress = ISNULL(a.propertyAddress,b.PropertyAddress)
from Nashville_Housing a
Join Nashville_Housing b
 on a.ParcelId =b.ParcelId
 and a.[UniqueID ] <>b.[UniqueID ]


 select
 Substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) As Address,
 SUbstring (PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(propertyAddress)) as Address 


 from Nashville_Housing

 Alter Table Nashville_Housing 
Add PropertyAddress_Locality nvarchar(260) ;

Update Nashville_Housing
Set PropertyAddress_Locality  = Substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

Alter Table Nashville_Housing 
Add PropertyAddress_City nvarchar(150) ;

Update Nashville_Housing
Set PropertyAddress_City = SUbstring (PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(propertyAddress))

Select * 
from Nashville_housing




Select OwnerAddress
from Nashville_housing

--Parse name using For Separating locality,city,state in Owner address

Select 
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
from nashville_housing





Alter Table Nashville_Housing 
Add OwnerAddress_Locality nvarchar(150) ;

Update Nashville_Housing
Set OwnerAddress_Locality = PARSENAME(Replace(OwnerAddress,',','.'),3)


Alter Table Nashville_Housing 
Add OwnerAddress_City nvarchar(150) ;

Update Nashville_Housing
Set OwnerAddress_City = PARSENAME(Replace(OwnerAddress,',','.'),2)

Alter Table Nashville_Housing 
Add OwnerAddress_State nvarchar(150) ;

Update Nashville_Housing
Set OwnerAddress_State = PARSENAME(Replace(OwnerAddress,',','.'),1)



Select Distinct(SoldAsVacant),Count(SoldAsVacant)
from Nashville_Housing
Group by SoldAsVacant
order by 2



Update Nashville_Housing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' then 'yes'
						 When SoldAsVacant = 'N' then 'No'
						 Else SoldAsVacant
						 End

---Removing Duplicates
with RowNumCTE as (
Select *,
	ROW_NUMBER()over(
	partition by ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by UniqueID
				 )row_num
From Nashville_Housing
)
Select *
--Delete
from RowNumCTE
where row_num > 1


---Deleting Unsused Columns



Alter table Nashville_Housing
drop Column OwnerAddress,taxDistrict,PropertyAddress
