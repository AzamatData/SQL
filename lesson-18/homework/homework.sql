
--homework 18
--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue
CREATE TABLE #MonthlySales (
	ProductID int
	,TotalQuantity int
	,TotalRevenue int
);
--2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold
CREATE VIEW vw_ProductSalesSummary AS(
SELECT Pro.ProductID, Pro.ProductName, Pro.Category, Sal.TotalQuantitySold FROM
(SELECT ProductID, SUM(Quantity) AS TotalQuantitySold FROM
Sales
GROUP BY ProductID) AS Sal INNER JOIN Products AS Pro ON Sal.ProductID=Pro.ProductID)
--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID

CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
returns INT AS
begin
declare @TotalSale INT
declare @Price INT
declare @revenue INT
SELECT 
	@TotalSale=SUM(Sales.Quantity)
	,@Price=Products.Price FROM Sales
INNER JOIN Products ON Sales.ProductID=Products.ProductID
WHERE Products.ProductID=@ProductID
GROUP BY Products.Price

SET @revenue=@TotalSale*@Price
return @revenue

END

select dbo.fn_GetTotalRevenueForProduct(2);
--4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
returns TABLE as 
return
(
	SELECT Products.ProductName
		, SUM(Sales.Quantity) AS TotalQuantity
		, SUM(Sales.Quantity*Products.Price) AS TotalRevenue
	FROM Sales
INNER JOIN Products ON Sales.ProductID=Products.ProductID
WHERE Products.Category=@Category
GROUP BY Products.ProductName
);
select * from fn_GetSalesByCategory('Groceries');
--Now we will move on with 2 Lateral-thinking puzzles (5 and 6th puzzles). Lateral-thinking puzzles are the ones that can’t be solved by straightforward logic — you have to think outside the box. 🔍🧠
--5. You have to create a function that get one argument as input from user and the function should return 'Yes' if the
--input number is a prime number and 'No' otherwise. You can start it like this:
--Create function dbo.fn_IsPrime (@Number INT)
--Returns ...
--This is for those who has no idea about prime numbers: A prime number is a number greater than 1 that has only two divisors: 
--1 and itself(2, 3, 5, 7 and so on).
Create function dbo.fn_IsPrime (@Number INT)
	returns Varchar (30)
	AS
	begin
	--declare @Numbeer int=25
	declare @i int=2
	declare @check int=1
	declare @Soz varchar(30)=''
	while @Number>@i
	begin
		if @Number%@i=0
		begin
		set @check=0
		break
		end
		else
		begin
		set @i=@i+1
		end
	end
if @check=0
begin
set @Soz='No'
--return 'No'
end
else
begin
set @Soz='Yes'
end
return @Soz;
end;
SELECT dbo.fn_IsPrime(7)
--6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
--@Start INT
--@End INT
--The function should return a table with a single column:

--| Number |
--|--------|
--| @Start |
--...
--...
--...
--|   @end |
--It should include all integer values from @Start to @End, inclusive.
CREATE FUNCTION fn_GetNumbersBetween(@start int, @end int)
RETURNS @Numbers TABLE (san int)
AS 
BEGIN
declare @i int =@start
WHILE @i<=@end
	begin
		INSERT INTO @Numbers Values (@i)
		SET @i=@i+1

	end
return
end;

select * from dbo.fn_GetNumbersBetween(7, 18);
--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
--Example 1:
--Input.Employee table:

--| id | salary |
--+----+--------+
--| 1  | 100    |
--| 2  | 200    |
--| 3  | 300    |
--n = 2
--Output:

--| getNthHighestSalary(2) |
--|    HighestNSalary      |
--|------------------------|
--| 200                    |
--Example 2:
--Input.Employee table:

--| id | salary |
--|----|--------|
--| 1  | 100    |
--n = 2
--Output:

--| getNthHighestSalary(2) |
--|    HighestNSalary      |
--|        null            |
--You can also solve this in Leetcode: https://leetcode.com/problems/nth-highest-salary/description/
--create table Employee (id int, Salary int)
--insert into Employee (id, Salary) values 
--(1, 100)
--,(2, 200)
--,(3, 300)

CREATE FUNCTION getNthHighestSalary(@n int)
returns int
as 
begin
	declare @results int
	
	  SELECT @results= salary FROM (
		SELECT DISTINCT Salary , ROW_NUMBER() OVER (ORDER BY salary DESC) AS r
	  FROM Employee
	) AS ranked
	WHERE r = @n
	return @results
end;

SELECT DBO.getNthHighestSalary(3)
--8. Write a SQL query to find the person who has the most friends.
--Return: Their id, The total number of friends they have

--Friendship is mutual. For example, if user A sends a request to user B and it's accepted, both A and B are considered friends with each other. 
--The test case is guaranteed to have only one user with the most friends.
--Input.RequestAccepted table:

--| requester_id | accepter_id | accept_date |
--+--------------+-------------+-------------+
--| 1            | 2           | 2016/06/03  |
--| 1            | 3           | 2016/06/08  |
--| 2            | 3           | 2016/06/08  |
--| 3            | 4           | 2016/06/09  |
--Output:

--| id | num |
--+----+-----+
--| 3  | 3   |
--Explanation: The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.

--You can also solve this in Leetcode: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/?envType=study-plan-v2&envId=top-sql-50

WITH UniqueFriends AS (
    SELECT 
        CASE 
            WHEN requester_id < accepter_id THEN requester_id
            ELSE accepter_id
        END AS person1,
        CASE 
            WHEN requester_id < accepter_id THEN accepter_id
            ELSE requester_id
        END AS person2
    FROM RequestAccepted
    GROUP BY 
        CASE WHEN requester_id < accepter_id THEN requester_id ELSE accepter_id END,
        CASE WHEN requester_id < accepter_id THEN accepter_id ELSE requester_id END
),
AllPeople AS (
    SELECT person1 AS id FROM UniqueFriends
    UNION ALL
    SELECT person2 AS id FROM UniqueFriends
)
SELECT TOP 1 id, COUNT(*) AS num
FROM AllPeople
GROUP BY id
ORDER BY num DESC;
--9. Create a View for Customer Order Summary.

--Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:

--Column Name | Description
--customer_id | Unique identifier of the customer
--name | Full name of the customer
--total_orders | Total number of orders placed by the customer
--total_amount | Cumulative amount spent across all orders
--last_order_date | Date of the most recent order placed by the customer
create view vw_CustomerOrderSummary 
AS
	(select customers.name, ord.customer_id, ord.SumAmount, ord.RecentDate
	from (
	select customer_id, sum(amount) as SumAmount, Max(order_Date) as RecentDate from orders
	group by customer_id
	) as ord inner join customers on ord.customer_id=customers.customer_id);
--10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
--| RowNumber | Workflow |
--|----------------------|
--| 1         | Alpha    |
--| 2         |          |
--| 3         |          |
--| 4         |          |
--| 5         | Bravo    |
--| 6         |          |
--| 7         |          |
--| 8         |          |
--| 9         |          |
--| 10        | Charlie  |
--| 11        |          |
--| 12        |          |
--Here is the expected output.

--| RowNumber | Workflow |
--|----------------------|
--| 1         | Alpha    |
--| 2         | Alpha    |
--| 3         | Alpha    |
--| 4         | Alpha    |
--| 5         | Bravo    |
--| 6         | Bravo    |
--| 7         | Bravo    |
--| 8         | Bravo    |
--| 9         | Bravo    |
--| 10        | Charlie  |
--| 11        | Charlie  |
--| 12        | Charlie  |

select notNull.[RowNumber], ISNULL(pre.TestCase, notNull.TestCase) from gaps as notNull
OUTER APPLY
(
select top (1) prvTbl.TestCase from gaps as prvTbl 
where prvTbl.TestCase is not null and prvTbl.[RowNumber]<=notNull.[RowNumber]
order by prvTbl.[RowNumber] desc) as pre

