--Homework11
--Task: 1.	Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the customers who placed them.
--Tables Used: Orders, Customers
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.OrderDate FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
WHERE YEAR(Orders.OrderDate)>2022;
--Task: 2.	Return: EmployeeName, DepartmentName
--Task: Display the names of employees who work in either the Sales or Marketing department.
--Tables Used: Employees, Departments
SELECT Employees.Name, Departments.DepartmentName FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName IN('Sales', 'Marketing');
--Task: 3.	Return: DepartmentName, MaxSalary
--Task: Show the highest salary for each department.
--Tables Used: Departments, Employees
SELECT Departments.DepartmentName, MAX(Employees.Salary) AS MaxSalary FROM Departments 
INNER JOIN Employees ON Departments.DepartmentID=Employees.DepartmentID
GROUP BY Departments.DepartmentName;
--Task: 4.	Return: CustomerName, OrderID, OrderDate
--Task: List all customers from the USA who placed orders in the year 2023.
--Tables Used: Customers, Orders
SELECT Customers.FirstName+' '+ Customers.LastName AS CustomerName, Orders.OrderID, Orders.OrderDate FROM Customers
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
WHERE Customers.Country LIKE 'USA' AND YEAR(Orders.OrderDate)=2023;
--Task: 5.	Return: CustomerName, TotalOrders
--Task: Show how many orders each customer has placed.
--Tables Used: Orders , Customers
SELECT Customers.FirstName+' '+ Customers.LastName AS CustomerName, COUNT(Orders.OrderID) as TotalOrders FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
GROUP BY Customers.FirstName+' '+ Customers.LastName;
--Task: 6.	Return: ProductName, SupplierName
--Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--Tables Used: Products, Suppliers
SELECT Products.ProductName, Suppliers.SupplierName FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE Suppliers.SupplierName IN('Gadget Supplies', 'Clothing Mart');
--Task: 7.	Return: CustomerName, MostRecentOrderDate
--Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
--Tables Used: Customers, Orders;
SELECT Customers.FirstName+' '+ Customers.LastName AS CustomerName, MAX(Orders.OrderDate) AS MostRecentOrderDate FROM Customers
LEFT JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.FirstName+' '+ Customers.LastName;
--Task: 8.	Return: CustomerName, OrderTotal
--Task: Show the customers who have placed an order where the total amount is greater than 500.
--Tables Used: Orders, Customers
SELECT Customers.FirstName+' '+ Customers.LastName AS CustomerName, SUM(Orders.TotalAmount) AS OrderTotal FROM Customers
LEFT JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.FirstName+' '+ Customers.LastName
HAVING(SUM(Orders.TotalAmount))>500;
--Task: 9.	Return: ProductName, SaleDate, SaleAmount
--Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
--Tables Used: Products, Sales
SELECT Products.ProductName, Sales.SaleDate, Sales.SaleAmount FROM Products
INNER JOIN Sales ON Products.ProductID=Sales.ProductID
WHERE YEAR(Sales.SaleDate)=2022 OR Sales.SaleAmount>400;
--Task: 10.	Return: ProductName, TotalSalesAmount
--Task: Display each product along with the total amount it has been sold for.
--Tables Used: Sales, Products
SELECT Products.ProductName, SUM(Sales.SaleAmount) AS TotalSalesAmount FROM Sales
INNER JOIN Products ON Sales.ProductID=Products.ProductID
GROUP BY Products.ProductName
--Task: 11.	Return: EmployeeName, DepartmentName, Salary
--Task: Show the employees who work in the HR department and earn a salary greater than 60000.
--Tables Used: Employees, Departments
SELECT Employees.Name, Departments.DepartmentName, Employees.Salary FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Employees.Salary>60000;
--Task: 12.	Return: ProductName, SaleDate, StockQuantity
--Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
--Tables Used: Products, Sales
SELECT Products.ProductName, Sales.SaleDate, Products.StockQuantity FROM Products
INNER JOIN Sales ON Products.ProductID=Sales.ProductID
WHERE YEAR(Sales.SaleDate)=2023 AND Products.StockQuantity>100
--Task: 13.	Return: EmployeeName, DepartmentName, HireDate
--Task: Show employees who either work in the Sales department or were hired after 2020.
--Tables Used: Employees, Departments
SELECT Employees.Name, Departments.DepartmentName, Employees.HireDate FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName='Sales' OR YEAR(Employees.HireDate)>2020;
--Task: 14.	Return: CustomerName, OrderID, Address, OrderDate
--Task: List all orders made by customers in the USA whose address starts with 4 digits.
--Tables Used: Customers, Orders
SELECT Customers.FirstName+' '+Customers.LastName AS CustomerName, Orders.OrderID, Customers.Address, Orders.OrderDate FROM Customers
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
WHERE Customers.Country='USA' AND Customers.Address LIKE '[0-9][0-9][0-9][0-9]%'
--Task: 15.	Return: ProductName, Category, SaleAmount
--Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
--Tables Used: Products, Sales
SELECT Products.ProductName, Products.Category, Sales.SaleAmount FROM Products
INNER JOIN Sales ON Products.ProductID=Sales.ProductID
WHERE Products.Category=1 AND Sales.SaleAmount>350
--Task: 16.	Return: CategoryName, ProductCount
--Task: Show the number of products available in each category.
--Tables Used: Products, Categories
SELECT Categories.CategoryName, COUNT(Products.ProductID) AS ProductCount FROM Products
INNER JOIN Categories ON Products.Category=Categories.CategoryID
GROUP BY Categories.CategoryName
--Task: 17.	Return: CustomerName, City, OrderID, Amount
--Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
--Tables Used: Customers, Orders
SELECT Customers.FirstName+' '+Customers.LastName AS CustomerName, Customers.City, Orders.OrderID, Orders.TotalAmount FROM Customers
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
WHERE Customers.City LIKE 'Los Angeles' AND Orders.TotalAmount>300;
--Task: 18.	Return: EmployeeName, DepartmentName
--Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
--Tables Used: Employees, Departments
SELECT Employees.Name, Departments.DepartmentName FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName IN('Human Resources', 'Finance') OR Employees.Name LIKE '[aeiouAEIOU][aeiouAEIOU][aeiouAEIOU][aeiouAEIOU]%'
--Task: 19.	Return: EmployeeName, DepartmentName, Salary
--Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
--Tables Used: Employees, Departments
SELECT Employees.Name, Departments.DepartmentName, Employees.Salary FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName IN('Sales', 'Marketing') AND Employees.Salary>60000;
