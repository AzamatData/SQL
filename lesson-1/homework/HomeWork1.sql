--This file is home task #1 for SQL class:
/*
Task 1:
Define the following terms: data, database, relational database, and table.

	Data is collection of unprocessed facts or numbers. Data is a lack of context and needs processing and interpretation.
	Data requires processing to be useful for people.
	Database is a collection of related data that is stored and organized in a structured manner to enable information to be stored, retrieved, manipulated and 
	managed efficiently.

	A database is an organized collection of data or a type of data stored based on the use of database management systems. A database provides reliability, 
	consistency and keeps data structured.
	Relational database is a collection of related tables. The data in relational database is stored in tables that contain columns and rows.
	Table
	A table is a basic element of relational database. It is a collection of related data organized in table format, consisting rows and columns.

Task 2:
List five key features of SQL Server.

	* Backup and restore;
	* User connectivity configuration (granting access to some users with specific privileges, max numbers of users allowed simultaneously…);
	* Schedule database task (SQL Server agent, job agent);
	* Database schema, Relational database;
	* SQL server management studio helps to work with server;

Task 3:
What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
	* Windows Authentication;
	* SQL Server Authentication;

Task 4:
Create a new database in SSMS named SchoolDB.
*/
	CREATE DATABASE SchoolDB;
/*
Task 5:
Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
*/
	USE SchoolDB;

	CREATE TABLE Students(
	StudentID INT PRIMARY KEY
	,Name VARCHAR(50)
	,Age INT
	)

	SELECT * FROM Students;
/*
Task 6:
Describe the differences between SQL Server, SSMS, and SQL.
	SQL server is a relational database management system that supports a variety of transaction processing, business intelligence (BI) and 
	data analytics applications in corporate IT environments. SSMS (SQL server management studio) is used to access to sql server, configure, manage and 
	develop all components of sql server. SQL is a programming language to write queries to sql databases.
	
Task 7:
Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

	SQL is divided sub-languages such as:
		* DQL: Doctrine query language is used for performing queries on the data within scheme objects. The most common definition of DQL is to get 
		data from database. It is “SELECT” statement. It doesn’t change database, it just extracts data from database.
		for example: SELECT * FROM tblMaaBStudents
		* DML: Data Manipulation Language allows a database user to access and alter in a database that has been organized using proper data models. It makes 
		changes to database using (INSERT, UPDATE, DELETE…). These commands are used to make changes inside a database.
		* DDL: Data Definition Language is used to create and modify database/database objects. CREATE, ALTER, DROP, TRUNCATE commands are used.
		* DCL: Data Control Language is used to work with security and access to database data. Commands are GRANT, REVOKE.
		* TCL: Transaction Control Language is a relational database transaction control language. COMMIT, ROLLBAC, SAVEPOINT commands are used.
Task 8:
Write a query to insert three records into the Students table.
*/
INSERT INTO Students (StudentID, Name, Age) VALUES
(1, 'TOM', 38)
,(2, 'JIM', 25)
,(3, 'JESSICA', 22)

/*
Task 9:
Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from 
this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
	1) I Created database with the name AdventureWorksDW2022.bak 
	2) Downloaded database backup from the source mentioned in the task and saved in 
	path: "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup" (I think the path is not so important)
	3) From "Task" selected database source and destination. In "Options" ticked "WITH REPLACE" option.
	it is restored. 
*/
