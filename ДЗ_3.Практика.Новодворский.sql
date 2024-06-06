-- 1) done

-- 2) существуют следующие агрегатные функции:
-- APPROX_COUNT_DISTINCT
-- AVG
-- CHECKSUM_AGG
-- COUNT
-- COUNT_BIG
-- GROUPING
-- GROUPING_ID
-- MAX
-- MIN
-- STDEV
-- STRING_AGG
-- SUM
-- VAR
-- VARP

-- 3) HAVING используется в качестве фильтра в только связке с оператором GROUP BY, в то время как WHERE используется в качестве фильтра без GROUP BY

-- 4) 

--a

select min(weight) min_weight, max(size) max_size 
from Production.Product

--b

select ProductSubcategoryID, min(weight) min_weight, max(size) max_size
from Production.Product
group by ProductSubcategoryID

--c

select ProductSubcategoryID, min(weight) min_weight, max(size) max_size,Color
from Production.Product
group by ProductSubcategoryID, Color

--d

select ProductSubcategoryID, min(weight) min_weight 
from Production.Product
group by ProductSubcategoryID
having min(weight) > 50

--e

select ProductSubcategoryID
from Production.Product
where Color = 'Black' and Weight > 50
group by ProductSubcategoryID
having MIN(Weight) > 50

--f

select TaxType
from Sales.SalesTaxRate
group by TaxType
having min(taxrate) < 7
