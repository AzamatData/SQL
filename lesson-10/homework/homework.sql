--Task: 1. Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName
SELECT Employees.Name, Employees.Salary, Departments.DepartmentName FROM Employees 
INNER JOIN Departments  ON Employees.DepartmentID=Departments.DepartmentID
WHERE Employees.Salary>50000;
--Task: 2. Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--🔁 Expected Columns: FirstName, LastName, OrderDate
SELECT Customers.FirstName, Customers.LastName, Orders.OrderDate FROM Customers
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
WHERE YEAR(Orders.OrderDate)=2023
--Task: 3. Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
--🔁 Expected Columns: EmployeeName, DepartmentName
SELECT Employees.Name, Departments.DepartmentName FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
--Task: 4. Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--🔁 Expected Columns: SupplierName, ProductName
SELECT Suppliers.SupplierName, Products.ProductName FROM Suppliers 
LEFT JOIN Products ON Products.SupplierID=Suppliers.SupplierID
--Task: 5. Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
SELECT Orders.OrderID, Orders.OrderDate, Payments.PaymentDate, Payments.Amount FROM Orders 
LEFT JOIN Payments ON Orders.OrderID=Payments.OrderID;
--Task: 6. Using the Employees table, write a query to show each employee's name along with the name of their manager.
--🔁 Expected Columns: EmployeeName, ManagerName
SELECT Emp.Name, Man.Name FROM Employees AS Emp
INNER JOIN Employees AS Man ON Emp.ManagerID=Man.EmployeeID;
--Task: 7. Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Columns: StudentName, CourseName
SELECT Students.Name, Courses.CourseName FROM Enrollments
LEFT JOIN Courses ON Enrollments.CourseID=Courses.CourseID
LEFT JOIN Students ON Students.StudentID=Enrollments.StudentID
WHERE Courses.CourseName Like 'Math 101';
--Task: 8. Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
--🔁 Expected Columns: FirstName, LastName, Quantity
SELECT Customers.FirstName, Customers.LastName, Orders.Quantity FROM Customers 
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.FirstName, Customers.LastName, Orders.Quantity
HAVING(COUNT(Orders.OrderID))>3
--Task: 9. Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Columns: EmployeeName, DepartmentName
SELECT Employees.Name, Departments.DepartmentName  FROM Employees 
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName LIKE 'Human Resources';
--Task: 10. Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
--🔁 Expected Columns: DepartmentName, EmployeeCount
SELECT Departments.DepartmentName, COUNT(Departments.DepartmentName) AS EmployeeCount  FROM Employees 
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
GROUP BY Departments.DepartmentName
HAVING(COUNT(Departments.DepartmentName))>5;
--Task: 11. Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Columns: ProductID, ProductName
SELECT Products.ProductID, Products.ProductName FROM Products 
LEFT JOIN Sales ON Products.ProductID=Sales.ProductID
WHERE Sales.ProductID IS NULL
--Task: 12. Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Columns: FirstName, LastName, TotalOrders
SELECT Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS TotalOrders FROM Customers
LEFT JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
HAVING(COUNT(Orders.OrderID))>0;
--Task: 13. Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Columns: EmployeeName, DepartmentName
SELECT Employees.Name, Departments.DepartmentName FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentID IS NOT NULL;
--Task: 14. Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Columns: Employee1, Employee2, ManagerID
SELECT Employee1.Name, Employee2.Name, Employee1.ManagerID FROM Employees AS Employee1
INNER JOIN Employees AS Employee2 ON Employee1.ManagerID=Employee2.ManagerID AND Employee1.EmployeeID<Employee2.EmployeeID
--Task: 15. Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName FROM Orders
INNER JOIN Customers ON Customers.CustomerID=Orders.CustomerID
WHERE YEAR(Orders.OrderDate)=2022;
--Task: 16. Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName
SELECT Employees.Name, Employees.Salary, Departments.DepartmentName FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName LIKE 'Sales' AND Employees.Salary>60000;
--Task: 17. Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
SELECT Orders.OrderID, Orders.OrderDate, Payments.PaymentDate, Payments.Amount FROM Orders 
INNER JOIN Payments ON Orders.OrderID=Payments.OrderID;
--Task: 18. Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Columns: ProductID, ProductName
SELECT Products.ProductID, Products.ProductName FROM Products
LEFT JOIN Orders ON Products.ProductID=Orders.ProductID
WHERE Orders.OrderID IS NULL;
--Task: 19. Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
--🔁 Expected Columns: EmployeeName, Salary
SELECT Employees.Name, Employees.Salary FROM Employees 
INNER JOIN
(SELECT Employees.DepartmentID, AVG(Employees.Salary) as AvgSalary  FROM Employees
GROUP BY Employees.DepartmentID) AS AvgDep ON Employees.DepartmentID=AvgDep.DepartmentID AND Employees.Salary>AvgDep.AvgSalary;
--Task: 20. Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate
SELECT Orders.OrderID, Orders.OrderDate FROM Orders
LEFT JOIN Payments ON Orders.OrderID=Payments.OrderID
WHERE YEAR(Orders.OrderDate)<2020 AND Payments.PaymentID IS NULL;
--Task: 21. Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Columns: ProductID, ProductName
SELECT Products.ProductID, Products.ProductName FROM Products
LEFT JOIN Categories ON Products.Category=Categories.CategoryID
WHERE Categories.CategoryID IS NULL;
--Task: 22. Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary
SELECT Employee1.Name, Employee2.Name, Employee1.ManagerID, Employee1.Salary as Employee1Salary, Employee2.Salary as Employee1Salary FROM Employees AS Employee1
INNER JOIN Employees AS Employee2 ON Employee1.ManagerID=Employee2.ManagerID AND Employee1.EmployeeID<Employee2.EmployeeID
WHERE Employee1.Salary>60000 AND Employee2.Salary>60000;
--Task: 23. Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
--🔁 Expected Columns: EmployeeName, DepartmentName
SELECT Employees.Name, Departments.DepartmentName  FROM Employees 
INNER JOIN
Departments ON Employees.DepartmentID=Departments.DepartmentID
WHERE Departments.DepartmentName LIKE 'M%';
--Task: 24. Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Columns: SaleID, ProductName, SaleAmount
SELECT Sales.SaleID, Products.ProductName, Sales.SaleAmount FROM Products
INNER JOIN Sales ON Products.ProductID=Sales.ProductID
WHERE Sales.SaleAmount>500;
--Task: 25. Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Columns: StudentID, StudentName
SELECT Students.StudentID, Students.Name FROM Students 
LEFT JOIN
(SELECT Students.StudentID FROM Enrollments
LEFT JOIN Students ON Enrollments.StudentID=Students.StudentID
LEFT JOIN Courses ON Enrollments.CourseID=Courses.CourseID
WHERE Courses.CourseName LIKE 'Math 101') AS T2
ON Students.StudentID=T2.StudentID
WHERE T2.StudentID IS NULL
--Task: 26. Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Columns: OrderID, OrderDate, PaymentID
SELECT Orders.OrderID, Orders.OrderDate, Payments.PaymentID FROM Orders
LEFT JOIN Payments ON Orders.OrderID=Payments.OrderID
WHERE Payments.PaymentID IS NULL;
--Task: 27. Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Columns: ProductID, ProductName, CategoryName
SELECT Products.ProductID, Products.ProductName, Categories.CategoryName FROM Products
INNER JOIN Categories ON Products.Category=Categories.CategoryID
WHERE Categories.CategoryName like 'Electronics' OR Categories.CategoryName like 'Furniture';
