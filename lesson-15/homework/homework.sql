--Task 1. Find Employees with Minimum Salary.
--Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);
--solution:
SELECT * FROM Employees
WHERE salary=(SELECT Min(salary) FROM Employees)

--2. Find Products Above Average Price
--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

--solution:
SELECT * FROM products
WHERE price>(SELECT AVG(price) FROM products)

--Level 2: Nested Subqueries with Conditions
--3. Find Employees in Sales Department 
--Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

create TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);
--solution
SELECT * FROM employees 
WHERE department_id IN (SELECT id FROM departments WHERE department_name like 'Sales')

--4. Find Customers with No Orders
--Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), 
--orders (columns: order_id, customer_id)

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);
--solution:
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

--Level 3: Aggregation and Grouping in Subqueries
--5. Find Products with Max Price in Each Category
--Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);
--solution:
SELECT * FROM products as A
WHERE price=(SELECT MAX(price) FROM products as B WHERE A.category_id=B.category_id);
--6. Find Employees in Department with Highest Average Salary
--Task: Retrieve employees working in the department with the highest average salary. Tables: 
--employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);
--solution:
select *, (SELECT department_name FROM departments WHERE departments.id=E1.id) as Department_Name from employees as E1
WHERE salary>(SELECT AVG(salary) FROM employees as E2 WHERE E1.department_id=E2.department_id);

--Level 4: Correlated Subqueries
--7. Find Employees Earning Above Department Average
--Task: Retrieve employees earning more than the average salary in their department. Tables: employees 
--(columns: id, name, salary, department_id)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);
--solution:
SELECT * FROM employees as E1
WHERE salary>(SELECT AVG(salary) FROM employees as E2 WHERE E1.department_id=E2.department_id)

--8. Find Students with Highest Grade per Course
--Task: Retrieve students who received the highest grade in each course. Tables: 
--students (columns: student_id, name), grades (columns: student_id, course_id, grade)

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);
--solution: 
SELECT (SELECT name FROM students WHERE students.student_id=G1.student_id) as Student_Name, * FROM grades as G1
WHERE grade=(SELECT MAX(grade) FROM grades AS G2 WHERE G1.course_id=G2.course_id)

--Level 5: Subqueries with Ranking and Complex Conditions
--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);
--Solution:
SELECT * FROM products AS P1
WHERE 3=(SELECT COUNT(DISTINCT price) FROM products AS P2 WHERE P1.price<=P2.price AND P1.category_id=P2.category_id);
--10. Find Employees whose Salary Between Company Average and Department Max Salary
--Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: 
--employees (columns: id, name, salary, department_id)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);
--Solution:
SELECT * FROM employees AS E1
WHERE salary>(SELECT AVG(salary) FROM employees) AND salary<(SELECT MAX(salary) FROM employees AS E2 WHERE E1.department_id=E2.department_id)
