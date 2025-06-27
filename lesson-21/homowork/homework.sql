--homework21

--1.	Write a query to assign a row number to each sale based on the SaleDate.
select *, ROW_NUMBER() Over (Order by SaleDate) as rn from ProductSales;
--2.	Write a query to rank products based on the total quantity sold. give the same rank for the same amounts 
--without skipping numbers.

select *, DENSE_RANK() OVER (PARTITION BY ProductName ORDER BY Quantity) rnProducts from ProductSales
--3.	Write a query to identify the top sale for each customer based on the SaleAmount.

with cte as(
select *,DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) as TopSale  from ProductSales
)
select * from cte where TopSale=1
--4.	Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.

select *, LEAD(SaleAmount) OVER(ORDER BY SaleDate) as NextSale from ProductSales;
--5.	Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.

select *, LAG(SaleAmount) OVER(ORDER BY SaleDate) as PrvSale from ProductSales;
--6.	Write a query to identify sales amounts that are greater than the previous sale's amount
with cte as (
select *, LAG(SaleAmount) OVER(ORDER BY SaleDate) as PrvSale from ProductSales
) 
select * from cte
where SaleAmount>PrvSale;
--7.	Write a query to calculate the difference in sale amount from the previous sale for every product

with cte as (
select *, LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) as PrvSale from ProductSales
) 
select *, SaleAmount-PrvSale from cte;
--8.	Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
select *, LEAD(SaleAmount,1,0) OVER(ORDER BY SaleDate) as NextSale
, case when LEAD(SaleAmount) OVER(ORDER BY SaleDate) Is Not null and SaleAmount<>0 then
	concat(cast(LEAD(SaleAmount,1,0) OVER(ORDER BY SaleDate)-SaleAmount*100/SaleAmount as decimal(10,2)),'%')
	end as [Percent]
from ProductSales;
--9.	Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
select *, LAG(SaleAmount, 1, 0) OVER(PARTITION BY ProductName ORDER BY SaleDate) as PrvSale,
CAST(COALESCE(SaleAmount/NULLIF(LAG(SaleAmount, 1, 0) OVER(PARTITION BY ProductName ORDER BY SaleDate),0), 0) as decimal(10,2)) as RatioCurPrv
from ProductSales;
--10.	Write a query to calculate the difference in sale amount from the very first sale of that product.
select *, FIRST_VALUE(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) as FirstValue
, SaleAmount-FIRST_VALUE(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) as DiffToFirstValue
from ProductSales
--11.	Write a query to find sales that have been increasing continuously for a product 
--(i.e., each sale amount is greater than the previous sale amount for that product).
;with cte as (
select *, 
LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) as PrvAmount,
case when SaleAmount>LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) then 1
	else 0
	end as selectCase
from ProductSales)
select * from cte
where selectCase=1;
--12.	Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total  of previous sales.

select *, 
	sum(SaleAmount) OVER(ORDER BY SaleDate) as runningTotal
from ProductSales
--13.	Write a query to calculate the moving average of sales amounts over the last 3 sales.

select *
	,avg(SaleAmount) OVER(ORDER BY SaleDate rows between 2 preceding and current row) as AvgOverLast3
from ProductSales
--14.	Write a query to show the difference between each sale amount and the average sale amount.
select * 
,AVG(SaleAmount) OVER(Partition by ProductName) as AvgSale
,cast(SaleAmount-AVG(SaleAmount) OVER(Partition by ProductName) as decimal(10, 2)) as Differ
from ProductSales;

--15.	Find Employees Who Have the Same Salary Rank

select Emp1.Name, Emp1.Salary, Emp2.RNK
from
(
select *
, DENSE_RANK() OVER(ORDER BY Salary) AS RNK
from Employees1) as Emp1 inner join (
select *
, DENSE_RANK() OVER(ORDER BY Salary) AS RNK
from Employees1) as Emp2 on Emp1.EmployeeID<>Emp2.EmployeeID and Emp1.RNK=Emp2.RNK;
--16.	Identify the Top 2 Highest Salaries in Each Department

;with cte as (select *,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary Desc) as RNK
from Employees1)
select * from cte where RNK IN(1, 2);

--17.	Find the Lowest-Paid Employee in Each Department

;with cte as (select *,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary) as RNK
from Employees1)
select * from cte where RNK=1;

--18.	Calculate the Running Total of Salaries in Each Department
select *,
SUM(Salary) OVER(PARTITION BY Department ORDER BY Salary) as SumSalary
from Employees1
--19.	Find the Total Salary of Each Department Without GROUP BY
select DISTINCT Department, 
SUM(Salary) OVER(PARTITION BY Department) as SumSalary
from Employees1
--20.	Calculate the Average Salary in Each Department Without GROUP BY

select DISTINCT Department, 
CAST(AVG(Salary) OVER(PARTITION BY Department) as decimal(10,2)) as AvgSalary
from Employees1
--21.	Find the Difference Between an Employee’s Salary and Their Department’s Average
select *
,CAST(AVG(Salary) OVER(PARTITION BY Department) as decimal(10,2)) as AvgSalary
,Salary-CAST(AVG(Salary) OVER(PARTITION BY Department) as decimal(10,2)) as DiffAvgSal
from Employees1;

--22.	Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select *,
SUM(Salary) OVER(ORDER BY HireDate rows between 1 preceding and 1 following) as MovSalaryTotal3
from Employees1
--23.	Find the Sum of Salaries for the Last 3 Hired Employees
;with cte as(
select *
--,sum(Salary) over(order by HireDate desc) sumSal
, RANK() OVER(ORDER BY HireDate desc) as rnk
From Employees1
) select SUM(Salary) as SumLast3Salary from cte
where rnk<=3

