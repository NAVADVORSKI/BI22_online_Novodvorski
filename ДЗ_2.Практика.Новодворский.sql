--select  * from HumanResources.Employee
--where Gender = 'F' and BirthDate > '1969-01-29';

--select distinct PersonType from Person.Person
--where (LastName like 'M%' or LastName like 'N%')
--and MiddleName is not NULL;

--select * from Sales.SpecialOffer
--where StartDate between '2013-01-01' and '2014-01-01'
--order by DiscountPct desc;

--select ProductID from Production.Product
--where ProductNumber like '_B%[0-9]'
--order by ProductID desc;

--select * from Production.Product
--where Color in ('Red', 'Silver', 'Black') and Size is not NULL;

--select * from HumanResources.Employee
--where (SickLeaveHours <= 15 or VacationHours <= 20) and JobTitle not like 'Vice President%' and JobTitle not like '%Vice President' and JobTitle not like 'Manager%' and JobTitle not like '%Manager';

--SELECT LastName, FirstName
--FROM Person.Person
--WHERE LastName LIKE 'R%'
--ORDER BY FirstName ASC, LastName DESC  --  Вывести столбцы LastName и FirstName из таблицы Person.Person где значение в столбце LastName начинаются с "R", также отсортировать в порядке возрастания значений в столбце FirstName и при совпадении в порядке убывания значений в столбце LastName
