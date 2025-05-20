-- Task 1.	Write a query to find the minimum (MIN) price of a product in the Products table.
SELECT MIN(Price) as MinPrice FROM Products;
-- Task 2.	Write a query to find the maximum (MAX) Salary from the Employees table.
SELECT MAX(Salary) as MaxSalary FROM employees;
-- Task 3.	Write a query to count the number of rows in the Customers table.
SELECT COUNT(CustomerID) as NumRows FROM customers;
-- Task 4.	Write a query to count the number of unique product categories from the Products table.
SELECT COUNT(DISTINCT Category) as UniqueCategory FROM Products;
-- Task 5.	Write a query to find the total sales amount for the product with id 7 in the Sales table.
SELECT SUM(SaleAmount) as TotalSalesFor7 FROM Sales
WHERE productid=7;
-- Task 6.	Write a query to calculate the average age of employees in the Employees table.
SELECT AVG(Age) as AvgAge FROM Employees;
-- Task 7.	Write a query to count the number of employees in each department.
SELECT DepartmentName, COUNT(EmployeeID) as TotalEmployee FROM Employees
GROUP BY DepartmentName;
-- Task 8.	Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
SELECT Category, MIN(Price) as MinPrice, Max(Price) as MaxPrice FROM Products
GROUP BY Category;
-- Task 9.	Write a query to calculate the total sales per Customer in the Sales table.
SELECT CustomerID, SUM(SaleAmount) as TotalSales FROM Sales
GROUP BY CustomerID;
-- Task 10.	Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, Count(EmployeeID) as NumOfEmp FROM Employees
GROUP BY DepartmentName
HAVING(COUNT(EmployeeID)>5);
-- Task 11.	Write a query to calculate the total sales and average sales for each product category from the Sales table.
SELECT ProductID, SUM(SaleAmount) as TotalSales, AVG(SaleAmount) as AvgSales FROM Sales
GROUP BY ProductID;
-- Task 12.	Write a query to count the number of employees from the Department HR.
SELECT DepartmentName, COUNT(EmployeeID) as NumOfEmployee FROM Employees
WHERE DepartmentName LIKE 'HR'
GROUP BY DepartmentName;
-- Task 13.	Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, MAX(Salary) as MaxSalary, MIN(Salary) as MinSalary FROM Employees
GROUP BY DepartmentName;
-- Task 14.	Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, AVG(Salary) as AvgSalary FROM Employees
GROUP BY DepartmentName;
-- Task 15.	Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, AVG(Salary) as AvgSalary, COUNT(EmployeeID) as NumOfEmployee FROM Employees
GROUP BY DepartmentName;
-- Task 16.	Write a query to filter product categories with an average price greater than 400.
SELECT Category, AVG(Price) as AvgPrice FROM Products
GROUP BY Category
HAVING(AVG(Price)>400);
-- Task 17.	Write a query that calculates the total sales for each year in the Sales table.
SELECT DATEPART(yyyy, SaleDate) as SaleYear, SUM(SaleAmount) as TotalSales FROM Sales
GROUP BY DATEPART(yyyy, SaleDate)
-- Task 18.	Write a query to show the list of customers who placed at least 3 orders.
SELECT CustomerID, COUNT(OrderID) as NumOfOrder FROM Orders
GROUP BY CustomerID
HAVING(COUNT(OrderID))>=3;
-- Task 19.	Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, AVG(Salary) as SalaryAmount FROM Employees
GROUP BY DepartmentName
HAVING(AVG(Salary))>60000;
-- Task 20.	Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.
SELECT Category, AVG(Price) as AvgPrice FROM Products
GROUP BY Category
HAVING(AVG(Price))>150;
-- Task 21.	Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
SELECT CustomerID, SUM(SaleAmount) as TotalSales FROM Sales
GROUP BY CustomerID
HAVING(SUM(SaleAmount))>1500
-- Task 22.	Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
SELECT DepartmentName EmployeeID, SUM(Salary) as SalarySum, AVG(Salary) as SalaryAmount FROM Employees
GROUP BY DepartmentName
HAVING(AVG(Salary))>65000;
-- Task 23.	Write a query to find total sales amount for the orders which costs more than $50 for each customer along with their least purchases.(least amount might be lower than $50).
SELECT T1.CustomerID, T1.[TotalSale>50], T2.MinSale FROM
(SELECT  CustomerID, SUM(TotalAmount) as [TotalSale>50] FROM Orders
GROUP BY CustomerID
HAVING(SUM(TotalAmount))>50) AS T1
LEFT JOIN
(SELECT  CustomerID, MIN(TotalAmount) as MinSale FROM Orders
GROUP BY CustomerID) AS T2 ON T1.CustomerID=T2.CustomerID
-- Task 24.	Write a query that calculates the total sales and counts unique products sold in each month of each year, and 
--then filter the months with at least 2 products sold.(Orders)
SELECT DATEPART(yyyy, OrderDate) as OrderYear, DATEPART(MONTH, OrderDate) as OrderMonths, SUM(TotalAmount) as TotalSales, COUNT(DISTINCT ProductID) as UniqueProducts FROM Orders
GROUP BY DATEPART(yyyy, OrderDate), DATEPART(MONTH, OrderDate)
HAVING(COUNT(DISTINCT ProductID)>=2)
-- Task 25.	Write a query to find the MIN and MAX order quantity per Year. From orders table. Necessary tables:
SELECT DATEPART(yyyy, OrderDate) as OrderYear,MIN(Quantity) as MinSales, MAX(Quantity) as MaxSales  FROM Orders
GROUP BY DATEPART(yyyy, OrderDate)
