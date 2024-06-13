-- ����� ����������� https://i0.wp.com/improveandrepeat.com/wp-content/uploads/2018/12/AdvWorksOLTPSchemaVisio.png?ssl=1 - � �������, ��� � ���� ����� ���������� ������ ���������� �� ����� ���� ������ AdventureWorks
-- 2 - ProductID(���������), SizeUnitMeasureCode(������� � ������� UnitMeasure), WeightUnitMeasureCode(������� � ������� UnitMeasure), ProductSubcategoryID(������� � ������� ProductSubcategory), ProductModelID(������� � ������� ProductModel)

-- 3(a) ����� ����� �� ������� Person.Person (������� ������ �� ����� � 1 �������:
--������ ��� � �������), � ������� �����, ��� 1 ������� (�������������� �����
--�������, ������� ������ �������� ����� � ��������� � ���).

select CONCAT(FirstName, ' ', LastName) Name
from Person.Person as PP
left join Person.PersonPhone as PPP
on PP.BusinessEntityID = PPP.BusinessEntityID
group by CONCAT(FirstName, ' ', LastName)
having count(distinct(PhoneNumber)) > 1

-- 3(b) ����� �������� (������� ��������), � ������� ������ (������ ������� ���������
--�� ����� Purchasing) �������� ������� ���� �� �������� ������ 10. ����� � �����
--������� ������ �������������� ����� � ��� ����� �������� ������� ������
--���������� �� �.

select PP.name ProductName
from Production.Product as PP
left join Purchasing.ProductVendor as PPV
on PP.ProductID = PPV.ProductID
left join Purchasing.Vendor as PV
on PPV.BusinessEntityID = PV.BusinessEntityID
where (PV.Name like '%a%' or PV.AccountNumber like 'A%') and PPV.StandardPrice > 10

-- 3(c) ����� ����� ���� ��������, ��������� ������� �� ����������� ������� (���
--������� � ������� Purchasing.ProductVendor). 

select PV.Name
from Purchasing.Vendor as PV
left join Purchasing.ProductVendor as PPV
on PPV.BusinessEntityID = PV.BusinessEntityID
where PPV.BusinessEntityID is NULL

--4(a) ������� ����� ���� ����������� � ������������, � ������� ��� ��������

select EM.emp_name, DP.dep_name
from employees as EM
left join departments as DP
on EM.dep_id = DP.dep_id

--4(b) ������� ������������ � ���-�� �����������, ���������� � ���

select DP.dep_id, COUNT(EM.dep_id) amount
from departments as DP
left join employees as EM
on DP.dep_id = EM.dep_id
group by DP.dep_id

-- 4(c) ������� �� ����� ���������� �����, ����� �� �Maryia Paulava� ���������� �maryia_paulava@gmail.com�

select lower(concat(REPLACE(emp_name, ' ', '_'), '@gmail.com')) email 
from employees

-- 4(d)  ����� ����������� � ����� ������� ��������, ������� ��� � ��������� ������� ������
--1�� (�������) ������������. NULL � ����������� �����������, ��� ����������� ���������!
--���� ����� � �������� �� �N.D.� 

select coalesce(SUM(revenue), 0) Revenue, coalesce(dep_name, 'N.D.') Department
from departments as DP
full join employees as EM
on DP.dep_id = EM.dep_id
full join revenue as RV
on EM.emp_id = RV.emp_id
group by dep_name

-- 5(a) ������� ������ �� ��������� 10 ���. (��������� DATEDIFF � CURRENT_TIMESTAMP)

select *
from Purchasing.ProductVendor
where DATEDIFF(year, LastReceiptDate, CURRENT_TIMESTAMP) <= 10

-- 5(b) ������� ������ � ��������, ������� ��������� � ����� �� ����� ��� �������.

select *
from Purchasing.ProductVendor
where month(lastreceiptdate) = month(CURRENT_TIMESTAMP)

-- 5(c) ������� ��� ������ (�������) � ���������� ������� � ���. (��������� � �������� 7 ����� �� ������ ���� ������). 

select datename(weekday, lastreceiptdate) Day_Name, count(*) Cnt
from Purchasing.ProductVendor
group by datename(weekday, lastreceiptdate)

-- 5(d) ������� � ��������� �������: ����, �����, ��� � ������������� 3 �������:
--������� ������� ���� � ����� �����, � ����� �����, � ����� ���

select 
	day(lastreceiptdate) DayNum, 
	MONTH(lastreceiptdate) MonthNum, 
	YEAR(lastreceiptdate) YearNum,
	(select count(*) from Purchasing.ProductVendor PPV2 where day(PPV2.lastreceiptdate) = day(PPV1.lastreceiptdate)) as DayEventsAmount,
	(select count(*) from Purchasing.ProductVendor PPV2 where month(PPV2.lastreceiptdate) = month(PPV1.lastreceiptdate)) as MonthEventsAmount,
	(select count(*) from Purchasing.ProductVendor PPV2 where year(PPV2.lastreceiptdate) = year(PPV1.lastreceiptdate)) as YearEventsAmount
from Purchasing.ProductVendor as PPV1