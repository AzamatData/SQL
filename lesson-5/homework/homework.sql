-- Task 1.	Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT ProductID, ProductName AS Name, Price, Category, StockQuantity FROM Products;
-- Task 2.	Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT * FROM Customers AS Client;
-- Task 3.	Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
SELECT ProductName From Products
UNION
SELECT ProductName From Products_Discounted;
-- Task 4.	Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
SELECT ProductName From Products
INTERSECT
SELECT ProductName From Products_Discounted;
-- Task 5.	Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
SELECT DISTINCT FirstName, LastName FROM Customers;
-- Task 6.	Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
SELECT *, 
CASE 
	WHEN Price>1000 THEN 'High'
	WHEN Price<=1000 THEN 'Low'
	end AS Grade
From Products
-- Task 7.	Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
SELECT *, IIF(StockQuantity>100,'Yes','No') AS StockStatus
FROM Products_Discounted;
-- Task 8.	Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted tables.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
-- Task 9.	Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;
-- Task 10.	Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT *, IIF(Price>1000,'Expensive','Afforable') AS CostLevel
FROM Products;
-- Task 11.	Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
SELECT * FROM Employees
WHERE AGE<25 OR Salary>60000;
-- Task 12.	Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
UPDATE Employees SET Salary=Salary*1.1
WHERE DepartmentName like 'HR' OR EmployeeID=5;
-- Task 13.	Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
SELECT *, 
CASE 
	WHEN SaleAmount>500 THEN 'Top Tier'
	WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
	else 'Low Tier'
	end AS SalesLevel
FROM Sales
-- Task 14.	Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table.
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales;
-- Task 15.	Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%

SELECT CustomerID, Quantity, 
CASE
	WHEN Quantity=1 THEN '3%'
	WHEN Quantity BETWEEN 1 AND 3 THEN '5%'
	ELSE '7%'
end as [Discount Percentage] FROM Orders;
