use class_6
--Puzzle 1: Finding Distinct Values
--Question: Explain at least two ways to find distinct values based on two columns.

--Input table (InputTbl):

| col1 | col2 |
|------|------|
| a    | b    |
| a    | b    |
| b    | a    |
| c    | d    |
| c    | d    |
| m    | n    |
| n    | m    |
Result should be like this:

| col1 | col2 |
|------|------|
| a    | b    |
| c    | d    |
| m    | n    |
--answer:
--1)using IIF with DISTINCT keyword.
SELECT DISTINCT iif(col1<col2,col1, col2 )as Col1, iif(col1<col2,col2, col1 )as Col2 from InputTbl
--in this example, IIF checks all col1<col2 condation and returns the true values into the 'col1', if 'col2' is greate thatn 'col1' returns true value as colun 'col2'. Distinct removes all duplicated rows.
--2) WHERE Clause with UNION
SELECT col1, col2 FROM InputTbl
WHERE col1<col2
union
SELECT col1, col2 FROM InputTbl
WHERE col1<col2
--where clause selects all 'col1<col2' cases and UNION combines the results by ommiting duplicates.
--3) WHERE clause with DISTINCT
SELECT DISTINCT col1, col2 FROM InputTbl
WHERE col1<col2
--where clause in this example selects all 'col1<col2' cases and DISTINCT removes all duplicates.
--Puzzle 2: Removing Rows with All Zeroes
--Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
--Solution:
SELECT * FROM TestMultipleZero
WHERE A<>0 OR B<>0 OR C<>0 OR D<>0;
--Puzzle 3: Find those with odd ids
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
--Solution:
SELECT * FROM section1
WHERE id%2<>0;
--Puzzle 4: Person with the smallest id (use the table in puzzle 3)
SELECT TOP(1) * FROM section1
ORDER BY id;
--Puzzle 5: Person with the highest id (use the table in puzzle 3)
SELECT TOP(1) * FROM section1
ORDER BY id DESC;
--Puzzle 6: People whose name starts with b (use the table in puzzle 3)
SELECT * FROM section1
WHERE name like 'b%';
--Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');
--solution:
SELECT * FROM ProductCodes
WHERE Code like '%[_]%'
