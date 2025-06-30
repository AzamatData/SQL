--homework 20

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');
--1. Find customers who purchased at least one item in March 2024 using EXISTS
select * from #Sales 
where Exists
(select * from #Sales as SalDate
where DatePart(yyyy,SaleDate)=2024 and DatePart(MONTH,SaleDate)=3 and Quantity>=1 and SalDate.CustomerName=#Sales.CustomerName);
--2. Find the product with the highest total sales revenue using a subquery.
select s1.[Product], s1.revenue as MaxRev from 
(select [Product], SUM(Quantity*Price) as revenue from #Sales
group by [Product]) as s1
where s1.revenue=(select MAX(TotalSal)--Max(s1.revenue) 
		from
		(SELECT [Product], SUM(Quantity*Price) as TotalSal from #Sales
		group by [Product]) as s2 );
--3. Find the second highest sale amount using a subquery
select SaleID, Price From #Sales
where Price=(select Max(Price) From 
				 #Sales
				 where Price<(select Max(Price) From 
				 #Sales))
--4. Find the total quantity of products sold per month using a subquery
select distinct datepart(MONTH,SaleDate) as Months, 
(select SUM(quantity) as SumQuantity from #Sales as S2 where datepart(MONTH,#Sales.SaleDate)=datepart(MONTH,S2.SaleDate)) 
as QuantitySum 
from #Sales;
--5. Find customers who bought same products as another customer using EXISTS
select s1.customername, s1.[product] from
#Sales as s1 where exists (
select customername from #Sales as s2
where s1.customername<>s2.customername and s1.[product]=s2.[product]);
--6. Return how many fruits does each person have in individual fruit level
select Name, Apple, Orange, Banana From Fruits
PIVOT 
(
COUNT(Fruit) FOR Fruit IN (Apple, Orange, Banana) 
) as NewTable

--7. Return older people in the family with younger ones

	--1 Oldest person in the family --grandfather 2 Father 3 Son 4 Grandson
select * from Family
select ParentId, b.childid from Family as a
cross join
(select childid from Family) as b
where a.parentid<b.childid
order by a.parentid

--8. Write an SQL statement given the following requirements. For every customer that had a delivery to California, 
--provide a result set of the customer orders that were delivered to Texas
select Ord1.CustomerID, Ord1.DeliveryState, Ord2.DeliveryState, Ord2.OrderID, Ord2.Amount from
(select * from #Orders) as Ord1
inner join #Orders as Ord2 On Ord1.CustomerID=Ord2.CustomerID
where Ord1.DeliveryState='CA' and Ord2.DeliveryState='TX';

--9. Insert the names of residents if they are missing
update #residents set address=case when address not like '%name%' then STUFF(address, CHARINDEX('age',address),0,' name='+fullname+' ')
	else address
	end;

--10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and 
--the most expensive routes
;WITH RouteCTE AS (
    -- Anchor member: start from Tashkent
    SELECT 
        RouteID,
        DepartureCity,
        ArrivalCity,
        Cost,
        CAST(DepartureCity + ' -> ' + ArrivalCity AS VARCHAR(MAX)) AS Path,
        1 AS Step
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Recursive member: join to the next route
    SELECT 
        r.RouteID,
        r.DepartureCity,
        r.ArrivalCity,
        c.Cost+r.Cost as Cost,
        CAST(c.Path + ' -> ' + r.ArrivalCity AS VARCHAR(MAX)) AS Path,
        Step + 1
    FROM #Routes r
    inner JOIN RouteCTE c ON r.DepartureCity = c.ArrivalCity
    WHERE c.ArrivalCity != 'Khorezm'  -- stop expanding if we already reached destination
          AND CHARINDEX(r.ArrivalCity, c.Path) = 0 -- avoid cycles
),
AllRoute as (
SELECT
    Path,
	--Cost AS TotalCost
    Cost AS TotalCost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm')

select Path, TotalCost from allRoute
where TotalCost=(Select Min(TotalCost) as Cost from allRoute) or
TotalCost=(Select Max(TotalCost) as Cost from allRoute);

11. Rank products based on their order of insertion.


CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')
--solution:
declare @maxid int=(select max([ID]) from #RankingPuzzle)
;with cte as (
select [ID], Vals, 1 as rn from #RankingPuzzle
where [id]=1
union all
select newOrd.[id], newOrd.vals, cte.rn+1 as rn from #RankingPuzzle as newOrd
JOIN cte
  ON newOrd.ID = cte.ID + 1
where newOrd.[id]<=@maxid
)select * from cte
