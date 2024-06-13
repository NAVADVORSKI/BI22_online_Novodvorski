-- 1 ������ �� ���� ������ AdventureWorks2017 ��������� ������.
--������� ������ ��� � ���� ���������� �����������, ����������� �� ��������� ��� ��� ��������:
--a) StandardCost ����� 0 ��� �� ��������� � �Not for sale�
--b) StandardCost ������ 0, �� ������ 100 -�<$100�
--c) StandardCost ������ 100 (���), �� ������ 500 -�<$500
--d) StandardCost ������ 500 (���) -�>=$500

select StandardCost, 
case
	when StandardCost = 0 or StandardCost is NULL then 'Not for sale'
	when StandardCost < 100 then '<$100'
	when StandardCost < 500 then '<$500'
	else '>=$500'
	end as CostType
from Production.Product;

-- 2 ����������� �������� ������� ���� � �������������� IIF

select StandardCost,
	IIF(standardcost = 0, 'Not for sale', 
		IIF(standardcost < 100, '<$100', 
			IIF(standardcost < 500, '<$500', '>=$500'))) as CostType
from Production.Product

------------------------------------------------� ���� �������� �������� ���������------------------------------

-- 3 
--������� Purchasing.ProductVendor, ���� LastReceiptDate ��� ������ � �����. ������� 4
--������ (����, �����, ����, �����) � ��������� ������� (LastReceiptCost). ���� �����
--������ 2000 � ������� �Do not include�. � ��������� ��������� ������ ���, � ����
--AverageLeadTime ������ 15.

--select * from Purchasing.ProductVendor
--
--select month(lastreceiptdate) Lastreceiptdate,
--	Case
--		when MONTH(lastreceiptdate) in (1,2,12) then 'Winter'
--		when MONTH(lastreceiptdate) in (3,4,5) then 'Spring'
--		when MONTH(lastreceiptdate) in (6,7,8) then 'Summer'
--		else 'Autumn'
--	end as Season
--	over (partition by Season)
--	--SUM(lastreceiptcost) as SUMM
--from Purchasing.ProductVendor
--where AverageLeadTime > 15
--group by Season

-------------------------------------------------------------------------------------------------------------


-- 4 
--������� Purchasing.ProductVendor. ������� ��� ������ ��� AverageLeadTime = 15.
--���������� ��� ������ ������ ��������� ������� �� BusinessEntityID � ������������
--������� �� ���������� UnitMeasureCode. ������� � ������� LastReceiptCost.

select 
	sum(lastreceiptcost) over(partition by businessentityID) Sum_BE,
	max(lastreceiptcost) over(partition by UnitMeasureCode) Max_UMC,
	*	
from Purchasing.ProductVendor
where AverageLeadTime = 15
