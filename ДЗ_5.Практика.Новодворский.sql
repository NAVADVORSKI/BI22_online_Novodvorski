-- 1 Решите на базе данных AdventureWorks2017 следующую задачу.
--Вывести список цен в виде текстового комментария, основанного на диапазоне цен для продукта:
--a) StandardCost равен 0 или не обозначен – ‘Not for sale’
--b) StandardCost больше 0, но меньше 100 -‘<$100’
--c) StandardCost больше 100 (вкл), но меньше 500 -‘<$500
--d) StandardCost больше 500 (вкл) -‘>=$500

select StandardCost, 
case
	when StandardCost = 0 or StandardCost is NULL then 'Not for sale'
	when StandardCost < 100 then '<$100'
	when StandardCost < 500 then '<$500'
	else '>=$500'
	end as CostType
from Production.Product;

-- 2 Попробовать написать задание выше с использованием IIF

select StandardCost,
	IIF(standardcost = 0, 'Not for sale', 
		IIF(standardcost < 100, '<$100', 
			IIF(standardcost < 500, '<$500', '>=$500'))) as CostType
from Production.Product

------------------------------------------------С ЭТИМ ЗАДАНИЕМ ВОЗНИКЛИ ТРУДНОСТИ------------------------------

-- 3 
--Таблица Purchasing.ProductVendor, поле LastReceiptDate для работы с датой. Вывести 4
--сезона (лето, осень, зима, весна) и суммарную прибыль (LastReceiptCost). Если сумма
--меньше 2000 – вывести «Do not include». В подсчетах учитывать только тех, у кого
--AverageLeadTime больше 15.

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
--Таблица Purchasing.ProductVendor. Вывести все записи для AverageLeadTime = 15.
--Просчитать для каждой строки суммарную прибыль по BusinessEntityID и максимальную
--прибыль по категориям UnitMeasureCode. Прибыль – колонка LastReceiptCost.

select 
	sum(lastreceiptcost) over(partition by businessentityID) Sum_BE,
	max(lastreceiptcost) over(partition by UnitMeasureCode) Max_UMC,
	*	
from Purchasing.ProductVendor
where AverageLeadTime = 15
