-- схему использовал https://i0.wp.com/improveandrepeat.com/wp-content/uploads/2018/12/AdvWorksOLTPSchemaVisio.png?ssl=1 - я заметил, что в этой схеме наполнение таблиц отличается от нашей базы данных AdventureWorks
-- 2 - ProductID(первичный), SizeUnitMeasureCode(внешний к таблице UnitMeasure), WeightUnitMeasureCode(внешний к таблице UnitMeasure), ProductSubcategoryID(внешний к таблице ProductSubcategory), ProductModelID(внешний к таблице ProductModel)

-- 3(a) Найти людей из таблицы Person.Person (вывести только их имена в 1 колонку:
--вместе Имя и Фамилию), у которых более, чем 1 телефон (самостоятельно найти
--таблицу, которая хранит телефоны людей и связаться с ней).

select CONCAT(FirstName, ' ', LastName) Name
from Person.Person as PP
left join Person.PersonPhone as PPP
on PP.BusinessEntityID = PPP.BusinessEntityID
group by CONCAT(FirstName, ' ', LastName)
having count(distinct(PhoneNumber)) > 1

-- 3(b) Найти продукты (вывести названия), у которых Вендор (нужная таблица находится
--на схеме Purchasing) выставил среднюю цену по продукту больше 10. Также в имени
--вендора должна присутствовать буква А или номер аккаунта вендора должен
--начинаться на А.

select PP.name ProductName
from Production.Product as PP
left join Purchasing.ProductVendor as PPV
on PP.ProductID = PPV.ProductID
left join Purchasing.Vendor as PV
on PPV.BusinessEntityID = PV.BusinessEntityID
where (PV.Name like '%a%' or PV.AccountNumber like 'A%') and PPV.StandardPrice > 10

-- 3(c) Найти имена всех вендоров, продукция которых не продавалась никогда (нет
--записей в таблице Purchasing.ProductVendor). 

select PV.Name
from Purchasing.Vendor as PV
left join Purchasing.ProductVendor as PPV
on PPV.BusinessEntityID = PV.BusinessEntityID
where PPV.BusinessEntityID is NULL

--4(a) Вывести имена всех сотрудников и департаменты, в которых они работают

select EM.emp_name, DP.dep_name
from employees as EM
left join departments as DP
on EM.dep_id = DP.dep_id

--4(b) Вывести департаменты и кол-во сотрудников, работающих в них

select DP.dep_id, COUNT(EM.dep_id) amount
from departments as DP
left join employees as EM
on DP.dep_id = EM.dep_id
group by DP.dep_id

-- 4(c) Сделать из имени сотрудника емейл, чтобы из «Maryia Paulava» получилось «maryia_paulava@gmail.com»

select lower(concat(REPLACE(emp_name, ' ', '_'), '@gmail.com')) email 
from employees

-- 4(d)  Найти департамент с самой большой прибылью, вывести имя и суммарную прибыль только
--1го (лучшего) департамента. NULL – неизвестный департамент, его ОБЯЗАТЕЛЬНО учитываем!
--Если нужно – заменяем на «N.D.» 

select coalesce(SUM(revenue), 0) Revenue, coalesce(dep_name, 'N.D.') Department
from departments as DP
full join employees as EM
on DP.dep_id = EM.dep_id
full join revenue as RV
on EM.emp_id = RV.emp_id
group by dep_name

-- 5(a) Вывести данные за последние 10 лет. (используй DATEDIFF и CURRENT_TIMESTAMP)

select *
from Purchasing.ProductVendor
where DATEDIFF(year, LastReceiptDate, CURRENT_TIMESTAMP) <= 10

-- 5(b) Вывести данные о событиях, которые произошли в такой же месяц как сегодня.

select *
from Purchasing.ProductVendor
where month(lastreceiptdate) = month(CURRENT_TIMESTAMP)

-- 5(c) Вывести дни недели (словами) и количество событий в них. (Результат – максимум 7 строк на каждый день недели). 

select datename(weekday, lastreceiptdate) Day_Name, count(*) Cnt
from Purchasing.ProductVendor
group by datename(weekday, lastreceiptdate)

-- 5(d) Вывести в отдельные колонки: день, месяц, год и дополнительно 3 колонки:
--сколько событий было в такое число, в такой месяц, в такой год

select 
	day(lastreceiptdate) DayNum, 
	MONTH(lastreceiptdate) MonthNum, 
	YEAR(lastreceiptdate) YearNum,
	(select count(*) from Purchasing.ProductVendor PPV2 where day(PPV2.lastreceiptdate) = day(PPV1.lastreceiptdate)) as DayEventsAmount,
	(select count(*) from Purchasing.ProductVendor PPV2 where month(PPV2.lastreceiptdate) = month(PPV1.lastreceiptdate)) as MonthEventsAmount,
	(select count(*) from Purchasing.ProductVendor PPV2 where year(PPV2.lastreceiptdate) = year(PPV1.lastreceiptdate)) as YearEventsAmount
from Purchasing.ProductVendor as PPV1