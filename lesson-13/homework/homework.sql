--HomeWork13
--Easy Tasks
--Task: 1. You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name 
in that format using employees table.
SELECT CONCAT(CAST(EMPLOYEE_ID AS VARCHAR),'-',FIRST_NAME,' ',LAST_NAME) AS AllDetails FROM Employees
--Task: 2. Update the portion of the phone_number in the employees table, within the phone number 
the substring '124' will be replaced by '999'
UPDATE Employees SET Employees.PHONE_NUMBER=REPLACE(PHONE_NUMBER,'124','999');
--Task: 3. That displays the first name and the length of the first name for all employees whose name starts 
with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees'' 
first names.(Employees)
SELECT Employees.FIRST_NAME as Name, LEN(Employees.FIRST_NAME) AS LenFirstName FROM Employees
WHERE Employees.FIRST_NAME LIKE 'A%' OR Employees.FIRST_NAME LIKE 'J%' OR Employees.FIRST_NAME LIKE 'M%';
--Task: 4. Write an SQL query to find the total salary for each manager ID.(Employees table)
SELECT MANAGER_ID, SUM(SALARY) AS TotalManagerIDSalary FROM Employees
GROUP BY MANAGER_ID;
--Task: 5. Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
SELECT *, CASE
	WHEN Max1<Max2 and max2<Max3 then Max3
	WHEN Max1<Max3 and Max3<Max2 then Max2
	WHEN Max2<Max3 and Max2<Max1 then Max1
	end as MaxAll
FROM TestMax;
--Task: 6. Find me odd numbered movies and description is not boring.(cinema)
SELECT * FROM cinema
WHERE ID%2<>0 AND description NOT LIKE 'boring';
--Task: 7. You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you 
do that with a single order by column.(SingleOrder)
SELECT *
FROM SingleOrder
ORDER BY CASE 
	WHEN ID=0 THEN 1
	else 0
	end;
--Task: 8. Write an SQL query to select the first non-null value from a set of columns. If the first column is null, 
move to the next, and so on. If all columns are null, return null.(person)
SELECT *, COALESCE(NULL, ssn, passportid, itin) as FirstNotNull FROM person;
--Medium Tasks
--Task: 1. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT SUBSTRING(FullName,0,CHARINDEX(' ', FullName)) AS FirstName, 
SUBSTRING(FullName,CHARINDEX(' ', FullName)+1,CHARINDEX(' ', FullName, CHARINDEX(' ', FullName)+1)-CHARINDEX(' ', FullName)-1) AS MiddleName,
SUBSTRING(FullName,CHARINDEX(' ', FullName, CHARINDEX(' ', FullName)+1)+1, LEN(FullName)-CHARINDEX(' ', FullName, CHARINDEX(' ', FullName)+1)) AS LastName
FROM Students;
--Task: 2. For every customer that had a delivery to California, provide a result set of the customer orders that were 
delivered to Texas. (Orders Table)
SELECT * FROM Orders AS CusCA
INNER JOIN Orders AS CusTX ON CusCA.CustomerID=CusTX.CustomerID
WHERE CusCA.DeliveryState='CA' AND CusTX.DeliveryState='TX';
--Task: 3. Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT STRING_AGG(String, ' ') FROM DMLTable
--Task: 4. Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS NAME FROM Employees
WHERE LEN(CONCAT(FIRST_NAME,' ',LAST_NAME))-LEN(REPLACE(CONCAT(FIRST_NAME,' ',LAST_NAME),'a',''))>=3
--Task: 5. The total number of employees in each department and the percentage of those employees who have been with the company 
for more than 3 years(Employees)
SELECT AllEmployee.DEPARTMENT_ID AS AllDepartments, AllEmployee.NumOfEmployees,More3Years.NumOfEmployees, 
(AllEmployee.NumOfEmployees / More3Years.NumOfEmployees * 100) AS [%MoreThan3Years] FROM 
(SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS NumOfEmployees FROM Employees
GROUP BY DEPARTMENT_ID) AS AllEmployee 
LEFT JOIN 
(SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS NumOfEmployees FROM Employees
WHERE DATEDIFF(YEAR,HIRE_DATE, GETDATE())>3
GROUP BY DEPARTMENT_ID) AS More3Years ON AllEmployee.Department_ID=More3Years.Department_ID;
--Task: 6. Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
WITH
NewTempTable AS (
SELECT JobDescription, MAX(MissionCount) as MaxMissionCount, MIN(MissionCount) as MinMissionCount FROM Personal
GROUP BY JobDescription)
SELECT A.JobDescription, B.SpacemanID as MostExperienced, C.SpacemanID as LeastExperienced
FROM NewTempTable as A INNER JOIN Personal as B ON A.JobDescription=B.JobDescription AND A.MaxMissionCount=B.MissionCount
INNER JOIN Personal AS C ON A.JobDescription=C.JobDescription AND A.MinMissionCount=C.MissionCount;
--Difficult Tasks
--Task: 1. Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given 
string 'tf56sd#%OqH' into separate columns.
declare @BasHarip Varchar(50)=''
declare @KishiHarip Varchar(50)=''
declare @belgiler Varchar(50)=''
--declare @Sanlar int=0
declare @Sanlar Varchar(50)=''
declare @i int=1

while @i<=LEN('tf56sd#%OqH')
	begin
	--bas harip ushin
	IF ASCII(SUBSTRING('tf56sd#%OqH', @i,1)) BETWEEN 65 AND 90 
	set @BasHarip=@BasHarip+SUBSTRING('tf56sd#%OqH', @i,1)
	--kishi harip ushin
	else if ASCII(SUBSTRING('tf56sd#%OqH', @i,1)) BETWEEN 97 AND 122 
	set @KishiHarip=@KishiHarip+SUBSTRING('tf56sd#%OqH', @i,1)
	--sanlar ushin
	else if SUBSTRING('tf56sd#%OqH', @i,1) like '%[0-9]%'
	set @Sanlar=@Sanlar+SUBSTRING('tf56sd#%OqH', @i,1)
	--belgiler
	else if SUBSTRING('tf56sd#%OqH', @i,1) like '%[^0-9a-z]%' 
	set @belgiler=@belgiler+SUBSTRING('tf56sd#%OqH', @i,1)
	set @i=@i+1
	print @i
	end
select @BasHarip as BasHarip, @KishiHarip as KishiHarip, @Sanlar as Sanlar, @belgiler as Belgiler
--Task: 2. Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)

SELECT * FROM Students
;with cte as (
select StudentID
	,FullName
	,cast(Grade as decimal(10,2)) as PrvTotal
from Students
where StudentID=(select MIN(StudentID) from Students)
union all
select Stu2.StudentID
	,Stu2.FullName
	,cast(Stu1.PrvTotal+cast(Stu2.Grade as decimal(10,2)) as decimal(10,2))as PrvTotal
from Students as Stu2
inner join cte as Stu1 on Stu2.StudentID=Stu1.StudentID+1
)
select * from cte
--Task: 3. You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
DECLARE @tempVarchar VARCHAR(100) = '25+5-3';
DECLARE @i INT = 1;
DECLARE @san VARCHAR(30) = '';
DECLARE @totalNum INT = 0;
DECLARE @operator CHAR(1) = '+'; 

WHILE @i <= LEN(@tempVarchar)
BEGIN
    DECLARE @ch CHAR(1) = SUBSTRING(@tempVarchar, @i, 1);

    IF @ch LIKE '[0-9]'
        SET @san = @san + @ch;
		ELSE IF @ch IN ('+', '-')
		BEGIN

			IF @san <> ''
			BEGIN
				IF @operator = '+'
					SET @totalNum = @totalNum + CAST(@san AS INT);
				ELSE IF @operator = '-'
					SET @totalNum = @totalNum - CAST(@san AS INT);
			END


			SET @operator = @ch;
        SET @san = '';
		END

    SET @i += 1;
END


IF @san <> ''
BEGIN
    IF @operator = '+'
        SET @totalNum = @totalNum + CAST(@san AS INT);
    ELSE IF @operator = '-'
        SET @totalNum = @totalNum - CAST(@san AS INT);
END

SELECT @totalNum AS Sum;


--Task: 4. Given the following dataset, find the students that share the same birthday.(Student Table)
SELECT * FROM Student as a1
inner join Student as b1 ON a1.Birthday=b1.Birthday and a1.StudentName<>b1.StudentName
--Task: 5. You have a table with two players (Player A and Player B) and their scores. 
--If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players.
--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
	case when PlayerA<PlayerB then PlayerA
		when PlayerA>PlayerB then PlayerB
	end as PlayerA,
	case when PlayerA<PlayerB then PlayerB
		when PlayerA>PlayerB then PlayerA
	end as PlayerB, sum(Score) as SumScore
FROM PlayerScores
group by 	case when PlayerA<PlayerB then PlayerA
		when PlayerA>PlayerB then PlayerB
	end ,
	case when PlayerA<PlayerB then PlayerB
		when PlayerA>PlayerB then PlayerA
	end
