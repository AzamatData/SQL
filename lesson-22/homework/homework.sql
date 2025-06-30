--homework 22

--Task 1.	Compute Running Total Sales per Customer
select *
,sum(total_amount) over(partition by customer_id order by total_amount) as running_totalPerCustomer
from sales_data
--Task 2.	Count the Number of Orders per Product Category

select distinct product_category
, COUNT(product_category) OVER(PARTITION BY product_category) AS CountCategory
from sales_data
--Task 3.	Find the Maximum Total Amount per Product Category

select distinct product_category
, MAX(total_amount) OVER(PARTITION BY product_category) AS CountCategory
from sales_data;
--Task 4.	Find the Minimum Price of Products per Product Category

select distinct product_category
,MIN(unit_price) OVER(PARTITION BY product_category) as MinPrice
from sales_data
--Task 5.	Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

select *,
AVG(total_amount) OVER(ORDER BY order_date rows between 1 preceding and 1 following) as MovAvg3Days
from sales_data;
--Task 6.	Find the Total Sales per Region

select distinct region
,SUM(total_amount) OVER(PARTITION BY region) as sumRegionSale
from sales_data
--Task 7.	Compute the Rank of Customers Based on Their Total Purchase Amount

;with cte as (
	select distinct customer_id
	, Sum(total_amount) over(partition by customer_id) as totalSalary
	from sales_data
) select customer_id, totalSalary
, DENSE_RANK() OVER(ORDER BY totalSalary DESC) AS rnk
from cte
--Task 8.	Calculate the Difference Between Current and Previous Sale Amount per Customer

select *
, LAG(total_amount, 1,0) OVER(PARTITION BY customer_id ORDER BY order_date) as prvSale
, total_amount-LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) as CurrPrvdifference
from sales_data
--Task 9.	Find the Top 3 Most Expensive Products in Each Category

;with cte as (
select *
, DENSE_RANK() OVER(PARTITION BY product_category ORDER BY total_amount desc) as rn
from sales_data
) select * from cte where rn in (1,2,3)

--Task 10.	Compute the Cumulative Sum of Sales Per Region by Order Date
select *
, SUM(total_amount) OVER(PARTITION BY region ORDER BY order_date) as cumulativ_sum
from sales_data;

--Task 11.	Compute Cumulative Revenue per Product Category

select *
, SUM(total_amount) OVER(PARTITION BY product_category ORDER BY order_date) as cumulativ_sum
from sales_data;
--Task 12.	Here you need to find out the sum of previous values. Please go through the sample input and 
expected output.
--table create
create table numbers(id int)
insert into numbers values(1),(2),(3),(4),(5)
--solution
select id
, sum(id) OVER(ORDER BY id) as sumPreValues
from numbers;

--Task 13. Sum of Previous Values to Current Value
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select [Value]
, [Value]+LAG([Value],1,0) OVER(ORDER BY [Value]) as [Sum of Previous]
FROM OneColumn;

--Task 14.	Find customers who have purchased items from more than one product_category

select tbl1.customer_id, tbl2.customer_id, tbl1.product_category,tbl2.product_category from sales_data as tbl1
inner join sales_data as tbl2 on tbl1.customer_id=tbl2.customer_id and tbl1.product_category<>tbl2.product_category
--Task 15.	Find Customers with Above-Average Spending in Their Region

;with cte as(
select *
, AVG(total_amount) OVER(PARTITION BY region, customer_id) as AvgTotal
from sales_data
) select * from cte where total_amount>AvgTotal;

--Task 16.	Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, 
--they should receive the same rank.

;with cte as (
select distinct customer_id, customer_name, region
, SUM(total_amount) OVER(PARTITION BY customer_id, region) as sumTotal
from sales_data
) select *, DENSE_RANK() OVER(ORDER BY sumTotal) as rnk from cte;
--Task 17.	Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

select *
, SUM(total_amount) OVER(PARTITION BY customer_id ORDER by order_date) as runningTotal
from sales_data;
--Task 18.	Calculate the sales growth rate (growth_rate) for each month compared to the previous month.

;with cte as (
select  datepart(YEAR, order_date) as Yy,
datepart(Month, order_date) as thisMonth
,sum(total_amount) as SumThisMonthTotal
from sales_data
group by datepart(YEAR, order_date), datepart(Month, order_date)
),
prvTbl as (
	select 
		yy
		,thisMonth
		,SumThisMonthTotal
		,LAG(SumThisMonthTotal) OVER(ORDER BY thisMonth) as PrvMonthSale
	from cte
)
select *
,CASE 
    WHEN PrvMonthSale = 0 THEN NULL
    ELSE (SumThisMonthTotal - PrvMonthSale) / NULLIF(PrvMonthSale, 0)
  END AS growth_rate
from prvTbl;

--Task 19.	Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)

;WITH cte AS (
  SELECT
    customer_id,
    sale_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
      PARTITION BY customer_id
      ORDER BY order_date
    ) AS prev_total_amount
  FROM sales_data
)
SELECT *
FROM cte
WHERE total_amount > prev_total_amount;

--Task 20. Identify Products that prices are above the average product price

select * 
from
	(select *, AVG(unit_price) OVER() as AvgPrice from sales_data
	) as tbl1
where unit_price>tbl1.AvgPrice;
--Task 20. In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.

select *
,CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id)=1 THEN SUM(Val1+Val2) OVER(PARTITION BY Grp)
	ELSE NULL
	END AS Tot
from MyData;
--Task 22. Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then 
--we have to add those values.Please go through the sample input and expected output for details.

;WITH cte AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY ID, Quantity ORDER BY (SELECT NULL)) AS rn
  FROM TheSumPuzzle
)
SELECT
  ID,
  SUM(Cost) AS sumCost,
  SUM(CASE WHEN rn = 1 THEN Quantity ELSE 0 END) AS quantSum
FROM cte
GROUP BY ID;

--Task 23. From following set of integers, write an SQL statement to determine the expected outputs

;with cte as (
select SeatNumber
,SeatNumber-ROW_NUMBER() over(order by SeatNumber) rn
--,Min(SeatNumber) as MinS,Max(SeatNumber) as MaxS
--,LAG(SeatNumber) OVER(order by seatNumber)
from Seats 
), MinMax as ( select rn
,MIN(SeatNumber)-1 as MinS
,MAX(SeatNumber)+1 as MaxS
from cte
group by rn
)select 
lag(MaxS, 1, 1) over(Order by MinS) as [Gap Start]
,MaxS as [Gap End]
from MinMax
