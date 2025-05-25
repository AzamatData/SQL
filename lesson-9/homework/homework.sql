--1. Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT Products.ProductName, Suppliers.SupplierName  FROM Products
CROSS JOIN Suppliers;
--2. Using Departments, Employees table Get all combinations of departments and employees.
SELECT Departments.DepartmentName, Employees.Name FROM Departments CROSS JOIN Employees;
--3. Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
SELECT Suppliers.SupplierName, Products.ProductName FROM Products
CROSS JOIN Suppliers 
WHERE Products.SupplierID=Suppliers.SupplierID
--4. Using Orders, Customers table List customer names and their orders ID.
SELECT Customers.FirstName, Customers.LastName, Orders.OrderID FROM Orders 
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
--5. Using Courses, Students table Get all combinations of students and courses.
SELECT Students.Name, Courses.CourseName FROM Courses
CROSS JOIN Students;
--6. Using Products, Orders table Get product names and orders where product IDs match.
SELECT Products.ProductName, Orders.OrderID FROM Products
CROSS JOIN Orders 
WHERE Products.ProductID=Orders.ProductID;
--7. Using Departments, Employees table List employees whose DepartmentID matches the department.
SELECT Employees.Name FROM Employees 
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID;
--8. Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT Students.Name, Enrollments.CourseID FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID;
--9. Using Payments, Orders table List all orders that have matching payments.
SELECT Orders.* FROM Payments
INNER JOIN Orders ON Payments.OrderID=Orders.OrderID;
--10. Using Orders, Products table Show orders where product price is more than 100.
SELECT Orders.OrderID, Orders.CustomerID, Products.ProductName, Orders.OrderDate, Orders.Quantity, Orders.TotalAmount, Products.Price 
 FROM Orders
INNER JOIN Products ON Orders.ProductID=Products.ProductID
WHERE Products.Price>100;
--11. Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
SELECT Employees.Name, Departments.DepartmentName FROM Employees 
CROSS JOIN Departments 
WHERE Employees.DepartmentID<>Departments.DepartmentID;
--12. Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
SELECT Orders.OrderID, Orders.CustomerID, Products.ProductName, Orders.OrderDate, Orders.Quantity, Orders.TotalAmount, Products.Price 
 FROM Orders
INNER JOIN Products ON Orders.ProductID=Products.ProductID
WHERE Orders.Quantity>Products.StockQuantity;
--13. Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
SELECT Customers.FirstName, Customers.LastName, Sales.ProductID FROM Customers
INNER JOIN Sales ON Customers.CustomerID=Sales.CustomerID
WHERE Sales.SaleAmount>=500;
--14. Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
SELECT Students.Name, Courses.CourseName FROM Enrollments
INNER JOIN Students ON Students.StudentID=Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID=Courses.CourseID;
--15. Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
SELECT Products.ProductName, Suppliers.SupplierName FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE Suppliers.SupplierName like '%Tech%';
--16. Using Orders, Payments table Show orders where payment amount is less than total amount.
SELECT Ord.OrderID, ord.TotalAmount, Pay.Amount FROM Orders as Ord
INNER JOIN Payments as Pay ON Ord.OrderID=Pay.OrderID
WHERE Pay.Amount<Ord.TotalAmount;
--17. Using Employees and Departments tables, get the Department Name for each employee.
SELECT Emp.EmployeeID, Emp.Name, Dep.DepartmentName FROM Employees as Emp
INNER JOIN Departments as Dep ON Emp.DepartmentID=Dep.DepartmentID;
--18. Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
SELECT Pro.ProductID, Pro.ProductName, Cat.CategoryName FROM Products as Pro
INNER JOIN Categories as Cat ON Pro.Category=Cat.CategoryID
WHERE Cat.CategoryName Like 'Electronics' or Cat.CategoryName Like 'Furniture';
--19. Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT Sal.SaleID, Cus.FirstName, Cus.LastName, Sal.ProductID, Sal.SaleDate, Sal.SaleAmount FROM Sales as Sal
INNER JOIN Customers as Cus ON Sal.CustomerID=Cus.CustomerID
WHERE Cus.Country Like 'USA';
--20. Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
SELECT Ord.OrderID, Cus.FirstName, Cus.LastName, Ord.ProductID, Ord.OrderDate, Ord.Quantity, Ord.TotalAmount, Cus.Country FROM Orders as Ord
INNER JOIN Customers as Cus ON Ord.CustomerID=Cus.CustomerID
WHERE Cus.Country Like 'Germany';
--21. Using Employees table List all pairs of employees from different departments.
SELECT Emp1.EmployeeID as Emp1_EmpID, Emp1.Name as Emp1_Name, Emp1.DepartmentID as Emp1_Department,
Emp2.Id as Emp2_EmpID, Emp2.Name as Emp2_Name, Emp2.DepartmentId as Emp2_Department
FROM Employees AS Emp1
INNER JOIN Employee AS Emp2 ON Emp1.DepartmentID<>Emp2.DepartmentId
--22. Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT Pay.PaymentID, Pay.OrderID, Pay.PaymentDate, Pay.PaymentMethod, Pay.Amount, Ord.Quantity, Pro.Price FROM Payments AS Pay
INNER JOIN Orders AS Ord ON Pay.OrderID=Ord.OrderID
INNER JOIN Products AS Pro ON Ord.ProductID=Pro.ProductID
WHERE Pay.Amount<>(Ord.Quantity*Pro.Price);
--23. Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT Stu.* FROM Students AS Stu 
LEFT JOIN Enrollments AS Enr ON Stu.StudentID=Enr.StudentID
LEFT JOIN Courses as Cour ON Enr.CourseID=Cour.CourseID
WHERE Cour.CourseID IS NULL;
--24. Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
SELECT Man.EmployeeID AS ManagerID_, Man.Name AS ManagerName, Man.Salary AS ManagerSalary, Emp.EmployeeID, Emp.ManagerID, Emp.Name, Emp.Salary FROM Employees AS Emp
INNER JOIN Employees AS Man ON Emp.ManagerID=Man.EmployeeID
WHERE Man.Salary<=Emp.Salary;
--25. Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
SELECT Ord.OrderID, Cus.FirstName, Cus.LastName FROM Orders AS Ord
INNER JOIN Customers AS Cus ON Ord.CustomerID=Cus.CustomerID
LEFT JOIN Payments AS Pay ON Ord.OrderID=Pay.OrderID
WHERE Pay.PaymentID IS NULL;
