--homework 16
--Easy Tasks
--Task 1. Create a numbers table using a recursive query from 1 to 1000.
;with cte AS(
SELECT 1 AS Num
UNION ALL
SELECT Num+1 AS Num FROM cte WHERE Num<1000)
SELECT Num FROM cte
OPTION(MAXRECURSION 1000)

--Task 2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT * FROM Employees AS E
INNER JOIN 
(SELECT EmployeeID, SUM(SalesAmount) AS TotalSales From Sales
GROUP BY EmployeeID) AS S ON E.EmployeeID=S.EmployeeID
--Task 3.	Create a CTE to find the average salary of employees.(Employees)
;WITH CTE AS (
SELECT EmployeeID, AVG(Salary) AS AvgSalary FROM Employees
GROUP BY EmployeeID
)
SELECT * FROM CTE
--Task 4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT Products.ProductName, SumSale.ProductID, SumSale.HighSale FROM Products
INNER JOIN
(SELECT ProductID, Max(SalesAmount) as HighSale  FROM sales
GROUP BY ProductID) AS SumSale
ON products.ProductID=SumSale.ProductID
--Task 5. Beginning at 1, write a statement to double the number for each record, the max value you get 
--should be less than 1000000.
;WITH CTE AS (
SELECT 1 AS Num
UNION ALL
SELECT Num*2 AS Num FROM CTE
WHERE Num*2<=1000000)
select * FROM CTE
--Task 6.	Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
;WITH CTE AS (
SELECT EmployeeID, COUNT(SalesID) as SalCount FROM sales
GROUP BY EmployeeID
)
SELECT Employees.FirstName, Employees.LastName, CTE.SalCount FROM  CTE inner join Employees ON Employees.EmployeeID=CTE.EmployeeID
WHERE CTE.SalCount>5
--Task 7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
;WITH CTE AS(
SELECT ProductID, SUM(SalesAmount) as SalSum FROM Sales
GROUP BY ProductID
)
SELECT products.ProductID, products.ProductName, cte.SalSum FROM products
INNER JOIN CTE ON Products.ProductID=CTE.ProductID
WHERE cte.SalSum>500
--Task 8.	Create a CTE to find employees with salaries above the average salary.(Employees)
;WITH CTE AS (
SELECT AVG(Salary) AS AvgSalary FROM Employees)
SELECT Employees.EmployeeID, Employees.Salary FROM Employees
WHERE Employees.Salary>(SELECT AvgSalary FROM CTE)
--Medium Tasks
--Task 1.	Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
SELECT TOP(5) * FROM Employees INNER JOIN
(
SELECT Sales.EmployeeID, COUNT(Sales.salesID) as CountOrder FROM
Sales
GROUP BY Sales.EmployeeID
) AS Sal2 ON Employees.EmployeeID=Sal2.EmployeeID
ORDER BY Sal2.CountOrder DESC;
--Task 2.	Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT Pro.CategoryID, Sum(Sale.SalesAmount) as SumSale  FROM  Products as Pro 
INNER JOIN
(SELECT * FROM Products) as Pro2 ON Pro.CategoryID=Pro2.CategoryID
INNER JOIN
(
SELECT Products.CategoryID, Sales.ProductID,  Sales.SalesAmount FROM Sales
INNER JOIN Products ON Sales.ProductID=Products.ProductID 
) as Sale ON Pro2.ProductID=Sale.ProductID
GROUP BY Pro.CategoryID;
--Task 3.	Write a script to return the factorial of each value next to it.(Numbers1)
;WITH CTE AS (
select Number, 1 as n, 1 as F From Numbers1
union all
select Number, n+1 , F*(n+1)  from CTE
where n<Number
)
select Number, n, F from CTE
where n=Number
--Task 4.	This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
select * from Example
;WITH CTE AS (
SELECT [String], 1 as nRow, SUBSTRING([String], 1, 1) as nSubs FROM Example
UNION ALL
SELECT [String], nRow+1 as nRow, SUBSTRING([String], nRow+1, 1) as nSubs FROM CTE
WHERE nRow<=LEN([String])
)
SELECT * FROM CTE
WHERE nRow<=Len([String])
ORDER BY [String] DESC;
--Task 5.	Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
;WITH CurrMonth AS (
SELECT DATEPART(YYYY, SaleDate) AS Yyear,DATEPART(MONTH,SaleDate) AS Mmonth, SUM(SalesAmount) as TotalSale from sales
GROUP BY DATEPART(YYYY, SaleDate),DATEPART(MONTH,SaleDate)
)
,PrvMonth AS (
SELECT DATEPART(YYYY, SaleDate) AS Yyear,DATEPART(MONTH,SaleDate) AS Mmonth, SUM(SalesAmount) as TotalSale from sales
GROUP BY DATEPART(YYYY, SaleDate),DATEPART(MONTH,SaleDate)
)
select CurrMonth.Mmonth, CurrMonth.TotalSale as CurrentMonthTotalSale, PrvMonth.TotalSale as PrvMonthTotalSale, ISNULL(0, CurrMonth.TotalSale-PrvMonth.TotalSale)  as TotalDiffCurrentPrevious from CurrMonth
left Join PrvMonth on CurrMonth.Mmonth=(PrvMonth.Mmonth+1) and (CurrMonth.Yyear=PrvMonth.Yyear);
--Task 6.	Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName FROM 
(SELECT EmployeeID, DATEPART(QUARTER, SaleDate) as Quarter, SUM(SalesAmount) as TotalSale FROM Sales
GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
HAVING(SUM(SalesAmount))>45000) AS tbl1 
INNER JOIN Employees ON Employees.EmployeeID=tbl1.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING(COUNT(DISTINCT tbl1.Quarter))=4;
--Difficult Tasks
--Task 1.	This script uses recursion to calculate Fibonacci numbers
declare @selectNum as INT;
SET @selectNum=20; --we can set any number here
WITH CTE AS (
SELECT 0 AS Num1, 1 AS Num2, 1 as i
UNION ALL
SELECT Num2 as Num1, Num1+Num2 as Num2, i+1 FROM CTE
WHERE i<@selectNum
)
SELECT * FROM CTE;
--Task 2.	Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT Vals  FROM FindSameCharacters
WHERE LEN(Vals)>1 AND LEN(REPLACE(Vals,SUBSTRING(Vals,1,1),''))=0
--Task 3.	Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in 
--the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
declare @SelectNumber as INT
SET @SelectNumber=5;
WITH CTE AS (
	SELECT 1 as N, 1 as i
	UNION ALL
	SELECT CAST(CONCAT(1, N+1) AS int), i+1 FROM CTE
	WHERE i<@SelectNumber
)
SELECT * FROM CTE;
--Task 4. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT Employees.EmployeeID, tblSum.TotalSale
FROM 
	(SELECT EmployeeID, SUM(SalesAmount) as TotalSale FROM Sales
		WHERE SaleDate>=DATEADD(MONTH, -6, GETDATE()) 
		GROUP BY EmployeeID) AS tblSum 
		INNER JOIN Employees ON Employees.EmployeeID=tblSum.EmployeeID
		WHERE tblSum.TotalSale=(
			SELECT MAX(TotalSales) FROM
				(SELECT EmployeeID, SUM(SalesAmount) as TotalSales FROM Sales
					WHERE SaleDate>=DATEADD(MONTH, -6, GETDATE()) 
					GROUP BY EmployeeID
				) as MaxQ
			);
--Task 5. Write a T-SQL query to remove the duplicate integer values present in the string column. 
--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
;WITH SingleDigits(Number) AS
(
    SELECT Number
    FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8),
    (9), (0)) AS X(Number)
)
,Series AS
(
    SELECT (d1.Number+1) + (10*d2.Number) + (100*d3.Number) Number
    from
    SingleDigits as d1,
    SingleDigits as d2,
    SingleDigits as d3   
)
SELECT DISTINCT PawanName , CASE WHEN cnt = dcnt AND cnt >= 1 THEN chrs else Pawan_slug_name END Pawan_slug_name  FROM
(
    SELECT * , COUNT(SUBSTRING(Ints,Number,1)) OVER (PARTITION BY PawanName) cnt , COUNT(SUBSTRING(Ints,Number,1)) OVER (PARTITION BY PawanName,SUBSTRING(Ints,Number,1)) dcnt FROM
    (
        SELECT * , SUBSTRING(Pawan_slug_name,0,CHARINDEX('-',Pawan_slug_name,0)) chrs
        , SUBSTRING(Pawan_slug_name,CHARINDEX('-',Pawan_slug_name,0)+1,DATALENGTH(Pawan_slug_name)) Ints  FROM RemoveDuplicateIntsFromNames
    )k
    CROSS APPLY
    ( 
        SELECT DISTINCT number FROM
        Series WHERE number > 0 AND number <= DATALENGTH(k.Ints) 
    )x
)m
ORDER BY PawanName 
