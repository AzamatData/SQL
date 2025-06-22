--homework19
--📄 Task 1:
--Create a stored procedure that:

--Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)
--Then, selects all data from the temp table.
--solution:
create proc usp_1
as
begin 

create table #EmployeeBonus (
FullName Varchar(50)
,Department Varchar(30)
,Salary Decimal(10, 2)
,BonusAmount Decimal(11, 8)
);

insert into #EmployeeBonus (FullName,Department,Salary,BonusAmount) 
select Concat(Employees.FirstName,' ',Employees.LastName) as FullName, Employees.Department, Employees.Salary, (Employees.Salary*DepartmentBonus.BonusPercentage)/100 as BonusAmount from Employees 
inner join DepartmentBonus on Employees.Department=DepartmentBonus.Department;
select * from #EmployeeBonus
end

exec usp_1

--📄 Task 2:
--Create a stored procedure that:

--Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage
--Returns updated employees from that department.
--solution:
create proc usp_2
@depName varchar(30),
@percent int
as
begin

select Concat(Employees.FirstName,' ',Employees.LastName) as FullName, Employees.Department, Employees.Salary, 
(Employees.Salary*@percent)/100 as BonusAmount from Employees 
where Employees.Department = @depName;
end;

--📄 Task 3:
--Perform a MERGE operation that:

--Updates ProductName and Price if ProductID matches
--Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New
--Return the final state of Products_Current after the MERGE.
--solution:
MERGE INTO Products_current as Target
USING Products_new as Source
ON Target.ProductID=Source.ProductID
WHEN MATCHED THEN
	UPDATE SET Target.ProductName=Source.ProductName, 
								Target.Price=Source.Price
WHEN NOT MATCHED BY Target THEN
INSERT (ProductID, ProductName, Price) VALUES (Source.ProductID, Source.ProductName, Source.Price)

WHEN NOT MATCHED BY Source THEN
DELETE;

--📄 Task 4:
--Tree Node

--Each node in the tree can be one of three types:

--"Leaf": if the node is a leaf node.
--"Root": if the node is the root of the tree.
--"Inner": If the node is neither a leaf node nor a root node.
--Write a solution to report the type of each node in the tree.
select *, 
case when p_id is null then 'Root'
	 when id not in(select p_id from Tree where p_id is not null) then 'Leaf'
	 else 'Inner' end as [Type]
from Tree;

--📄 Task 5:
--Confirmation Rate

--Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.
--solution:
;with cte as(
select sups.user_id as main_user_id, cons.*,
(select count(distinct action) from Confirmations where Confirmations.user_id=cons.user_id and action='timeout') as not_confirmed,
(select count(distinct action) from Confirmations where Confirmations.user_id=cons.user_id and action='confirmed') as confirmed
from Signups as sups
LEFT JOIN Confirmations as cons
on sups.user_id=cons.user_id
 )

 select distinct main_user_id,
case when action is null then confirmed
  else cast(cast(confirmed as decimal(10,1)) /(confirmed+not_confirmed) as decimal(10,1)) end as confirmation_rate
from cte

--📄 Task 6:
--Find employees with the lowest salary
--Solution:

SELECT id, name, salary
FROM Employees 
WHERE Salary=(SELECT MIN(salary) FROM Employees)

--📄 Task 7:
--Get Product Sales Summary

--Create a stored procedure called GetProductSalesSummary that:

--Accepts a @ProductID input
--Returns:
--ProductName
--Total Quantity Sold
--Total Sales Amount (Quantity × Price)
--First Sale Date
--Last Sale Date
--If the product has no sales, return NULL for quantity, total amount, first date, and last date, but still return the product name.
--Solution: 
CREATE PROC GetProductSalesSummary
@ProductID int
AS
BEGIN
SELECT Products.ProductName, SUM(Sales.Quantity) as SumQuantity, SUM(Sales.Quantity*Products.Price) as TotalPrice, 
MIN(Sales.SaleDate) as FirstSaleDate, MAX(Sales.SaleDate) as LastSaleDate
FROM Sales RIGHT JOIN Products ON Sales.ProductID=Products.ProductID
WHERE Products.ProductID=@ProductID
GROUP BY Products.ProductName

END;

exec GetProductSalesSummary 16
