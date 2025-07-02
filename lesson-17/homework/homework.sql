--homework 17

--Task 1. You must provide a report of all distributors and their sales by region. If a distributor did not have 
--any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region

;with reg as (
select distinct Region from #RegionSales
), dist as (
	select distinct distributor from #RegionSales
), CombAll as(
	select reg.Region
			,dist.distributor
			from reg
			cross join dist
)
select combAll.Region, CombAll.Distributor, coalesce(s.sales, 0) as SumSale from CombAll
left join
#RegionSales as s
on CombAll.Region=s.Region and CombAll.Distributor=s.Distributor
order by CombAll.Distributor, combAll.Region;

--Task 2. Find managers with at least five direct reports

select name from Employee inner join (
	select managerId,  COUNT(managerId) as ManId
	from Employee
	group by managerId
	having(COUNT(managerId)>=5)) as t2 on Employee.id=t2.managerId;

--Task 3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and 
their amount.

select Products.product_name, TblSale.Unit from Products
INNER JOIN 
	(select 
		product_id
		,DATEPART(YEAR,order_date) as YearS
		,DATEPART(Month,order_date) as MonthS
		,SUM(unit) as Unit
	from Orders
	group by product_id, DATEPART(YEAR,order_date), DATEPART(Month,order_date) 
	) as TblSale ON Products.product_id=TblSale.product_id
	where TblSale.YearS=2020 and TblSale.MonthS=2 and Unit>=100;

--Task 4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
;with cte as(
select *, (select SUM([count]) as ordSum from Orders as ord1 
	where ord1.CustomerID=Orders.CustomerID and ord1.Vendor=Orders.Vendor) as SumOrd from Orders 
) select distinct CustomerID, Vendor from cte
	where SumOrd=(select MAX(SumOrd) from cte as cte2 where cte2.CustomerID=cte.CustomerID);

--Task 5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 91;
-- Your WHILE-based SQL logic here
declare @inc int =2;
declare @checker int =1;
while @Check_Prime>@inc
begin
	if @Check_Prime%@inc=0
	begin
	set @checker=0;
	break
	end
	else
	begin
	set @inc=@inc+1
	end

end
if @checker=0
begin
 print 'This number is not prime'
end
else 
print 'This number is prime'

--Task 6. Write an SQL query to return the number of locations,in which location most signals sent, and 
--total number of signal for each device from the given table.

;with cte as(
select *, (
	select COUNT(Locations) from Device as dev1 where dev1.Device_id=Device.Device_id and dev1.Locations=Device.Locations
)  as CountLoc from Device 
) select distinct cte.Device_id, otheLoc.no_of_signals, cte.Locations as max_signal_location, otheLoc.no_of_location from cte
inner join 
(select Device_id, COUNT(locations) as no_of_location, COUNT(DISTINCT Locations) as no_of_signals  from Device
group by Device_id) as otheLoc on cte.Device_id=otheLoc.Device_id

where CountLoc=(select MAX(CountLoc) from cte as cte2 where cte.Device_id=cte2.Device_id);

--Task 7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
--Return EmpID, EmpName,Salary in your output

select EmpID, EmpName, Salary
from Employee
where Salary>=(select avg(salary) from Employee as Emp2 where Emp2.DeptID=Employee.DeptID);

--Task 8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with 
--a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. 
--If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.

;with cte as (
select TicketID, COUNT(ValidNumbers.Number) as CountWin
from Tickets
left join ValidNumbers on Tickets.Number=ValidNumbers.Number
 group by ticketID
 )select 
	sum(case when CountWin=0 then 0
			when CountWin=3 then 100
			else 10
		end) as TotalWin

 from cte;
-- Task 9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping 
website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both 
mobile and desktop together for each date.

WITH UserDaily AS (
  SELECT
    User_id,
    Spend_date,
    SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS Mobile_Amount,
    SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS Desktop_Amount
  FROM Spending
  GROUP BY User_id, Spend_date
),
UserType AS (
  SELECT
    User_id,
    Spend_date,
    Mobile_Amount,
    Desktop_Amount,
    CASE
      WHEN Mobile_Amount > 0 AND Desktop_Amount = 0 THEN 'Mobile'
      WHEN Desktop_Amount > 0 AND Mobile_Amount = 0 THEN 'Desktop'
      WHEN Mobile_Amount > 0 AND Desktop_Amount > 0 THEN 'Both'
    END AS Platform
  FROM UserDaily
)
SELECT
  Spend_date,
  Platform,
  SUM(
    CASE 
      WHEN Platform = 'Mobile' THEN Mobile_Amount 
      WHEN Platform = 'Desktop' THEN Desktop_Amount 
      ELSE Mobile_Amount + Desktop_Amount 
    END
  ) AS Total_Amount,
  COUNT(DISTINCT User_id) AS Total_Users
FROM UserType
GROUP BY Spend_date, Platform

UNION ALL

SELECT
  d.Spend_date,
  p.Platform,
  0 AS Total_Amount,
  0 AS Total_Users
FROM
  (SELECT DISTINCT Spend_date FROM Spending) d
  CROSS JOIN (VALUES ('Mobile'), ('Desktop'), ('Both')) p(Platform)
WHERE NOT EXISTS (
  SELECT 1
  FROM UserType u
  WHERE u.Spend_date = d.Spend_date
    AND u.Platform = p.Platform
)

--Task 10. Write an SQL Statement to de-group the following data.

declare @MaxInt int =(SELECT MAX(Quantity) FROM Grouped);

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n + 1 <= @MaxInt
)
SELECT
    p.Product,
    1 AS Quantity
FROM
    Grouped p
JOIN
    Numbers n
    ON n.n <= p.Quantity
ORDER BY
    p.Product
--OPTION (MAXRECURSION 32767); 
