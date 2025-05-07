--Home task: Lesson 2: DDL and DML Commands

--Task 1: Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
use class_2

CREATE TABLE Employees (
EmpID INT
, Name VARCHAR(50)
, Salary DECIMAL(10,2)
);

--Task 2: Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
INSERT INTO Employees(EmpID, Name, Salary) VALUES
	(1, 'Tom', 5000)

GO
INSERT INTO Employees(EmpID, Name, Salary) VALUES
	(2, 'Jerry', 10000)
	,(3, 'Jessica',8000)

--select * from Employees;

--Task 3: Update the Salary of an employee to 7000 where EmpID = 1.

UPDATE Employees SET Salary=7000
WHERE EmpID=1;

--Task 4: Delete a record from the Employees table where EmpID = 2.
DELETE Employees
WHERE EmpID=2;

--Task 5: Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
 --DELETE: DELETE is DML command. You can delete using DELETE single row using WHERE clause or multiple rows. After DELETE it is possible rollback.
 --TRUNCATE: TRUNCATE removes all rows and faster than DELETE command. No rollback if TRUNCATE is used.
 --DROP: DROP is DDL command. DROP is used to delete database, table, index, or view. DELETE and TRUNCATE delete records in table without making change to the table structure, when DROP is used to delete the table it deletes the table itself.

--Task 6: Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees
ALTER COLUMN Name Varchar(100);

--Task 7: Add a new column Department (VARCHAR(50)) to the Employees table.

ALTER TABLE Employees
ADD Department VARCHAR(50);

--Task 8: Change the data type of the Salary column to FLOAT.

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

--Task 9: Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).

CREATE TABLE Departments(DepartmentID INT PRIMARY KEY 
, DepartmentName VARCHAR(50)
);

--Task 10: Remove all records from the Employees table without deleting its structure.

DELETE Employees;
--SELECT * FROM Employees;
--Task 11: Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
INSERT INTO Departments(DepartmentID, DepartmentName) 
SELECT 1, 'DATA'
UNION ALL
SELECT 2, 'HR'
UNION ALL
SELECT 3, 'Logistics'
UNION ALL
SELECT 4, 'Medical'
UNION ALL
SELECT 5, 'Supply';

   --SELECT * FROM Departments;

--Task 12: Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees SET Department='Management'
WHERE Salary>5000;  --this will not affect any row as we deleted all data in task 10.

--Task 13: Write a query that removes all employees but keeps the table structure intact.
TRUNCATE TABLE Employees;

--Task 14: Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department

--SELECT * FROM Employees;
--Task 15: Rename the Employees table to StaffMembers using SQL commands.

EXEC sp_rename 'Employees', 'StaffMembers';

--Task 16: Write a query to completely remove the Departments table from the database.
DROP Departments;

--Task 17: Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products(ProductID INT Primary Key
, ProductName VARCHAR(30)
, Category VARCHAR(30)
, Price DECIMAL
, Quantity INT
, ExpiryDate Date
, StockIn Date
, StockOut Date
, Weight INT
, CURRENCY VARCHAR(20)
, RecievedBy VARCHAR(20)
)

--Task 18: Add a CHECK constraint to ensure Price is always greater than 0.

ALTER TABLE Products
ADD CONSTRAINT Price CHECK (Price>0);
--Task 19: Modify the table to add a StockQuantity column with a DEFAULT value of 50.

ALTER TABLE Products
ADD StockQuantity int CONSTRAINT StockQuantityConstr DEFAULT (50);

--SELECT * FROM Products
--Task 20: Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory';
--Task 21: Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products(ProductID,ProductName,ProductCategory,Price,Quantity,ExpiryDate,StockIn,StockOut,Weight,CURRENCY,RecievedBy,StockQuantity) Values
(1,'Pen','OfficeUtility',1000,100,'5/5/2030','1/1/2025','3/5/2025',1,'Sum','Maral',50)
,(2,'Angle Grinder','Instrument',23,7,'1/5/2028','1/1/2025','3/5/2025',1,'USD','Talgat',3)
,(3,'Screw Driver','Instrument',60,40,'3/3/2029','1/1/2025','3/5/2025',3,'Sum','Talgat',25)
,(4,'Table','Furniture',500,3,'1/5/2028','1/1/2025','3/5/2025',25,'USD','Sergey',2)
,(5,'LAN switch','Networking',100,6,'1/5/2028','1/1/2025','3/5/2025',2,'USD','Sergey',3)

--Task 22: Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT * INTO Products_Backup FROM Products;

--Task 23: Rename the Products table to Inventory.
EXEC sp_rename Products, Inventory;
--Task 24: Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

ALTER TABLE Inventory
ALTER COLUMN Price decimal(10,2)

ALTER TABLE Inventory
add newTemp Float

update Inventory set newTemp=Price;

ALTER TABLE Inventory
DROP constraint Price

ALTER TABLE Inventory
DROP column Price

EXEC sp_rename 'Inventory.newTemp','Price';
select * from Inventory;

--Task 25: Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
ALTER TABLE Inventory
ADD ProductCode INT NOT NULL IDENTITY(1000,5);
