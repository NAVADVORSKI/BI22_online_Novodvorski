-- 1 -- ������� ������� ROW_NUMBER(), RANK(), � DENSE_RANK() ���������� ���������� ���������, ����� � ������� ��� ����������.

-- 2 (a)


insert into Production.UnitMeasure
values ('TT1', 'Test1', '2020-09-09');

select *
from Production.UnitMeasure
where UnitMeasureCode like 'T%'

-- 2 (b)

select *
into Production.UnitMeasureTest
from Production.UnitMeasure
where UnitMeasureCode = 'CAN'

select *
from Production.UnitMeasureTest

-- 2 (c)

update Production.UnitMeasureTest
set UnitMeasureCode = 'TTT'

select *
from Production.UnitMeasureTest

-- 2 (d)

delete
from Production.UnitMeasureTest

-- 2 (e)

select SalesOrderID,
	min(LineTotal) over (partition by SalesOrderID) as min_tot, max(LineTotal) over (partition by SalesOrderID) as max_tot, avg(LineTotal) over (partition by SalesOrderID) as avg_tot
from Sales.SalesOrderDetail
where SalesOrderID in (43659, 43664)

-- 2 (f)

select CONCAT(UPPER(SUBSTRING(LastName, 1, 3)), 'login', TerritoryGroup) as Name, SalesYTD, SalesLastYear,
		Rank() over (order by SalesYTD desc) as Rank_CY,
		Rank() over (order by SalesLastYear desc) as Rank_LY
from Sales.vSalesPerson

-- MITloginNorth America ����������� ������ � ������� ���� (Rank_CY), VARloginEurope ���������� ������ � ������� ���� (Rank_LY).
-- ������ ������: ��� � ������ ������ ��������� �������� �� Null � Select?