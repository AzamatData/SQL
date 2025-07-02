--homework 23

--Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month 
--if any. Please check out sample input and expected output.
--Input Table: Dates
--solution:
select *
	,case when len(DATEPART(Month, DT))=1 then CONCAT('0',DATEPART(Month, DT))
		else cast(DATEPART(Month, DT) as varchar(2))
	end as MonthPrefixedWithZero 
from Dates;

--Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. You also have to find out 
--the SUM of Max values of vals columns for each Id and RId. For more details please see the sample input and 
--expected output.
--solution:

SELECT TOP 1 
	
	SUM(COUNT(DISTINCT Id)) OVER() Distinct_Ids 
	,rid
	,SUM(MAX(Vals)) OVER() TotalOfMaxVals

FROM MyTabel
GROUP BY Id,rid;

--Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. 
--Please see the sample input and expected output.
--solution:

select * from TestFixLengths
where LEN(Vals) between 6 and 10

--Puzzle 4: In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and 
--Maximum value. Please check out sample input and expected output.
--solution:

select ID, Item, Vals 
from(
	select *
	,row_number() OVER(Partition by ID order by Vals desc) as rnk
	from TestMaximum)  as tbl1
where tbl1.rnk=1;

--Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and 
--then Sum the data using Id only. Please check out sample input and expected output.
--solution
select distinct id
	,SUM(MAX(Vals)) OVER(partition by ID) as SumOfMax
from SumOfMax
group by id, DetailedNumber;

--Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if 
--the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this 
--zero with blank.Please check the sample input and the expected output.
--Solution: 
select *
	, case when [a]-[b]<>0 then cast(a-b as varchar(30))
	else ''
	end as output
from TheZeroPuzzle;

--Task 7.	What is the total revenue generated from all sales?
--solution:
select SUM(QuantitySold*UnitPrice) as totalRevenue from sales

--Task 8.	What is the average unit price of products?
--solution: 

select AVG(UnitPrice) as AvgUnitPrice from sales

--Task 9.	How many sales transactions were recorded?
--solution: 

select COUNT(*) as SalesTransactions from sales;

--Task 10.	What is the highest number of units sold in a single transaction?
--solution:

select MAX(QuantitySold) as UnitsSold from sales

--Task 11.	How many products were sold in each category?
--solution:

select distinct Category, count(Product) OVER(PARTITION BY category) as CountProducts from sales;

--Task 12.	What is the total revenue for each region?
--solution: 

select distinct region
	, SUM(QuantitySold*UnitPrice) OVER(PARTITION BY region) as TotalRevenue
from sales;

--Task 13.	Which product generated the highest total revenue

;WITH ProductRevenue AS (
  SELECT
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
  FROM Sales
  GROUP BY Product
)

SELECT
  Product,
  TotalRevenue
FROM ProductRevenue
WHERE TotalRevenue = (SELECT MAX(TotalRevenue) FROM ProductRevenue);

--Task 14.	Compute the running total of revenue ordered by sale date.
select  *
	,SUM(QuantitySold * UnitPrice) OVER (
    ORDER BY SaleDate, SaleID
    ROWS UNBOUNDED PRECEDING
  )  AS TotalRevenue
from Sales

--Task 15.	How much does each category contribute to total sales revenue?

SELECT
  Category,
  SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
  SUM(QuantitySold * UnitPrice) * 100.0 / 
    (SELECT SUM(QuantitySold * UnitPrice) FROM Sales) AS ContributionPercent
FROM
  Sales
GROUP BY
  Category
ORDER BY
  ContributionPercent DESC;

--Task 17. Show all sales along with the corresponding customer names

select Sales.*, Customers.CustomerName from Sales
inner join Customers on Sales.CustomerID=Customers.customerID

--Task 18. List customers who have not made any purchases.

select * from customers
left join Sales on customers.customerID=Sales.CustomerID
where SaleID is null;

--Task 19. Compute total revenue generated from each customer

select distinct Customers.CustomerName, S.totalRevenue from Customers
INNER JOIN (
select *
	,SUM(quantitySold*UnitPrice) OVER(PARTITION BY CustomerID) totalRevenue
from sales) as S on customers.CustomerID=S.CustomerID;

--Task 20. Find the customer who has contributed the most revenue

;with cte as (
select distinct Customers.CustomerName, S.totalRevenue from Customers
INNER JOIN (
select *
	,SUM(quantitySold*UnitPrice) OVER(PARTITION BY CustomerID) totalRevenue
from sales) as S on customers.CustomerID=S.CustomerID
) select cte.CustomerName, cte.totalRevenue 
from cte
where totalRevenue=(select MAX(totalRevenue) from cte);

--Task 21. Calculate the total sales per customer

select Customers.CustomerID, Customers.CustomerName, S.totalSales from Customers 
inner join (
select distinct CustomerID
	,sum(quantitySold*UnitPrice) OVER(PARTITION BY CustomerID) totalSales
from sales)
as S on Customers.Customerid=S.CustomerID
select * from sales

--Task 22. List all products that have been sold at least once
select * from products
inner join Sales on products.productName=Sales.Product
where Sales.QuantitySold>0

--Task 23.Find the most expensive product in the Products table

SELECT
  ProductID,
  ProductName,
  Category,
  CostPrice,
  SellingPrice
FROM
  Products
WHERE
  SellingPrice = (SELECT MAX(SellingPrice) FROM Products);

--Task 24. Find all products where the selling price is higher than the average selling price in their category

select * from products
where products.sellingPrice>(select AVG(sellingPrice) from products as pro2 where pro2.category=products.category)
