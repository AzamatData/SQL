-- Task 1.	Write a query to select the top 5 employees from the Employees table.
USE CLASS_4
SELECT TOP 5 * FROM Employees;
-- Task 2.	Use SELECT DISTINCT to select unique Category values from the Products table.
SELECT DISTINCT Category 
FROM Products;
-- Task 3.	Write a query that filters the Products table to show products with Price > 100.
SELECT * FROM Products
WHERE Price>100;
-- Task 4.	Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
SELECT * FROM Customers
WHERE FirstName Like 'A%';
-- Task 5.	Order the results of a Products table by Price in ascending order.
SELECT * FROM Products
ORDER BY Price ASC;
-- Task 6.	Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
SELECT * FROM Employees
WHERE Salary>=60000 AND DepartmentName='HR'
-- Task 7.	Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
SELECT EmployeeID, FirstName, LastName, DepartmentName, Salary, HireDate, Age, ISNULL(Email,'noemail@example.com') AS Email, Country
FROM Employees
-- Task 8.	Write a query that shows all products with Price BETWEEN 50 AND 100.
SELECT * FROM Products
WHERE Price BETWEEN 50 AND 100;
-- Task 9.	Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName FROM Products;
-- Task 10.	After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
SELECT DISTINCT Category, ProductName FROM Products
ORDER BY ProductName DESC;
-- Task 11.	Write a query to select the top 10 products from the Products table, ordered by Price DESC.
SELECT TOP(10) * FROM Products
ORDER BY Price DESC
-- Task 12.	Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
SELECT COALESCE(NULL, FirstName,LastName) AS NonNullFirstLastName FROM Employees;
-- Task 13.	Write a query that selects distinct Category and Price from the Products table.
SELECT DISTINCT Category, Price FROM Products;
-- Task 14.	Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
SELECT * FROM Employees
WHERE Age BETWEEN 30 AND 40 OR DepartmentName like 'Marketing'
-- Task 15.	Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
SELECT * FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;
-- Task 16.	Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
SELECT * FROM Products
WHERE Price<=1000 AND Price>50
ORDER BY StockQuantity;
-- Task 17.	Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
SELECT * FROM Products
WHERE ProductName like '%e%';
-- Task 18.	Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
SELECT * FROM Employees
WHERE DepartmentName IN('HR','IT','Finance');
-- Task 19.	Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table.
SELECT * FROM Customers
ORDER BY City ASC, PostalCode DESC;
-- Task 20.	Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC.
SELECT TOP(5) * FROM Products
ORDER BY Price DESC;
-- Task 21.	Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
	--first option:
SELECT (FirstName +' '+ LastName) AS FullName FROM Employees;
	--second option:
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;
-- Task 22.	Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
SELECT DISTINCT Category, ProductName, Price FROM Products
WHERE Price>50;
-- Task 23.	Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
SELECT * FROM Products
WHERE Price<(SELECT AVG(Price) FROM Products)*0.1;
-- Task 24.	Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
SELECT * FROM Employees
WHERE Age<30 AND DepartmentName in ('HR', 'IT');
-- Task 25.	Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
SELECT * FROM Customers
WHERE Email like '%gmail.com%';
-- Task 26.	Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
SELECT * FROM Employees
WHERE Salary>ALL
(SELECT Sum(Salary) FROM Employees
WHERE DepartmentName like 'Sales')
-- Task 27.	Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)
SELECT * FROM Orders 
WHERE OrderDate BETWEEN GETDATE()-180 AND GETDATE() ; --this to extract in last 180 days based on current date
SELECT MAX(OrderDate) FROM Orders; --this to find latest date in orders table
--I didn't understand this task well enough. From now last 180 days or from last order date...
