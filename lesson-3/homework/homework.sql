-- Task 1.	Define and explain the purpose of BULK INSERT in SQL Server.
BULK INSERT in SQL is used to import data from a file into a database table or view. The main purpose is if we have data file to with certain format we can import it into the database using BULK INSERT.


-- Task 2.	List four file formats that can be imported into SQL Server.
	1) .csv
	2) .txt
	3) .xml
	4) .xlsx
-- Task 3.	Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE DATABASE HW3 --This is created as in our Class3DB database has already table 'Products'
GO
USE HW3
CREATE TABLE Products(ProductID INT PRIMARY KEY
, ProductName VARCHAR(50)
, Price DECIMAL(10,2))
-- Task 4.	Insert three records into the Products table using INSERT INTO.
INSERT INTO Products(ProductID, ProductName, Price) VALUES
(1, 'Butter',135.21)
,(2, 'Cake',155.85)
,(3, 'Bread',35.24)

SELECT * FROM Products
-- Task 5.	Explain the difference between NULL and NOT NULL.
NULL is empty means not data. NOT NULL is not empty. If they are used as Constraints NULL can accept empty value while NOT NULL can not.

-- Task 6.	Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD CONSTRAINT ProductNameConstraint UNIQUE(ProductName)


-- Task 7.	Write a comment in a SQL query explaining its purpose.
SELECT * FROM Products
WHERE Price>35
/*
This query slects all data from Products table with Price lower than 35.
*/

-- Task 8.	Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE Categories(CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE
)


-- Task 9.	Explain the purpose of the IDENTITY column in SQL Server.
The purpose of using IDENTITY for column is to generate value automatically in a sequence for each row in a table.

-- Task 10.	Use BULK INSERT to import data from a text file into the Products table.
TRUNCATE TABLE Products --this is used as we had some data was inserted already
BULK INSERT [HW3].[dbo].Products
FROM 'D:\Learning\DataAnalytics\SQL\Class3\Products_table2.csv'
WITH(
FIRSTROW=2,
FIELDTERMINATOR=',',
ROWTERMINATOR='\n'
)

-- Task 11.	Create a FOREIGN KEY in the Products table that references the Categories table.
SELECT * FROM Products;
SELECT * FROM Categories;

ALTER TABLE Products
ADD CatID int FOREIGN KEY REFERENCES Categories (CategoryID)

-- Task 12.	Explain the differences between PRIMARY KEY and UNIQUE KEY.
There will be only one PRIMARY KEY column in a table while UNIQUE KEY is more than one. PRIMARY KEY column does not store null values, but unique key does. 
-- Task 13.	Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Products
ADD CHECK(Price>0)

-- Task 14.	Modify the Products table to add a column Stock (INT, NOT NULL).

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0
-- Task 15.	Use the ISNULL function to replace NULL values in Price column with a 0.
SELECT ISNULL(Price,0) FROM Products

-- Task 16.	Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
FOREIGN KEY is a field that links one to another table. In relational database one of normalization rule for database is to reduce or eliminate data redundancy. Also, if data is repeated in many time we can create it in separate table and we can link it to through foreign key.

-- Task 17.	Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.

CREATE TABLE Customers(Age INT CHECK(Age>=18))

-- Task 18.	Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE ForIdentity(ID int IDENTITY(100, 10))

-- Task 19.	Write a query to create a composite PRIMARY KEY in a new table OrderDetails.

CREATE TABLE OrderDetails(ProductId int
, ProductName Varchar(30)
, OrderDate Date
, PRIMARY KEY(ProductId, ProductName))
-- Task 20.	Explain the use of COALESCE and ISNULL functions for handling NULL values.
they are both used almost the same purpose. COALESCE follows the CASE expression rules to return the data type of value with the highest precedence. Also,
expression can be evualated multiple times in COALESCE, but in ISNULL it only once.

-- Task 21.	Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees(
EmpID int
,Email varchar(50) UNIQUE 
,PRIMARY KEY (EmpID, Email))


-- Task 22.	Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.

CREATE TABLE tblStaffs
( staffId INT PRIMARY KEY,
  staffName VARCHAR(50) NOT NULL,
  Department VARCHAR(25)
);

CREATE TABLE tblSupervisors
( Sup_id INT PRIMARY KEY,
  staff_id INT NOT NULL,
  NumOfStaff INT,
  CONSTRAINT staff_super
    FOREIGN KEY (staff_id)
    REFERENCES tblStaffs(staffid)
    ON DELETE CASCADE
);

--for cascade update
ALTER TABLE tblSupervisors WITH CHECK 
ADD CONSTRAINT staff_super_updt FOREIGN KEY (staff_id) REFERENCES tblStaffs(staffid)
ON UPDATE CASCADE
