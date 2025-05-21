--homework8
--1. Using Products table, find the total number of products available in each category.
SELECT Category, SUM(StockQuantity) as TotalNumberOfProducts FROM Products
GROUP BY Category;
--2. Using Products table, get the average price of products in the 'Electronics' category.
SELECT ProductName, AVG(Price) as AvgPrice FROM Products
WHERE Category like 'Electronics'
GROUP BY ProductName;
--3. Using Customers table, list all customers from cities that start with 'L'.
SELECT * FROM Customers
WHERE City like 'L%';
--4. Using Products table, get all product names that end with 'er'.
SELECT ProductName FROM Products
WHERE ProductName LIKE '%er';
--5. Using Customers table, list all customers from countries ending in 'A'.
SELECT * FROM Customers
WHERE Country like '%a';
--6. Using Products table, show the highest price among all products.
SELECT MAX(Price) as HighesPrice FROM Products;
--7. Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
SELECT *, CASE 
		WHEN StockQuantity<30 then 'Low Stock'
		else 'Sufficient'
		end as StockLevel
FROM Products;
--8. Using Customers table, find the total number of customers in each country.
SELECT Country, COUNT(CustomerID) as TotalCustomerNum FROM Customers
GROUP BY Country;
--9. Using Orders table, find the minimum and maximum quantity ordered.
SELECT MIN(Quantity) as MinQuantity, MAX(Quantity) as MaxQuantity FROM Orders;
--10. Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.
SELECT CustomerID FROM Orders
WHERE year(OrderDate)=2023 AND MONTH(OrderDate)=1
EXCEPT
SELECT CustomerID FROM Invoices;
--11. Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
SELECT ProductName FROM Products 
UNION ALL
SELECT ProductName FROM Products_Discounted
--12. Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
SELECT ProductName FROM Products 
UNION
SELECT ProductName FROM Products_Discounted
--13. Using Orders table, find the average order amount by year.
SELECT year(OrderDate) as OrderYear, AVG(TotalAmount) as AvgTotalAmount FROM Orders
GROUP BY year(OrderDate);
--14. Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
SELECT ProductName, 
	CASE 
		WHEN Price<100 then 'Low'
		WHEN Price>=100 AND Price<=500 then 'Mid'
		WHEN Price>500 then 'High'
	end as PriceGroup
FROM Products
--15. Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
SELECT district_id, district_name, [2012], [2013] INTO Population_Each_Year FROM City_Population
PIVOT(
SUM(population) FOR year IN ([2012], [2013])
) as pivotPopulation_Each_Year;
--16. Using Sales table, find total sales per product Id.
SELECT ProductID, SUM(SaleAmount) as TotalSale FROM Sales
GROUP BY ProductID
--17. Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT productname FROM Products
where ProductName like '%oo%';
--18. Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
SELECT district_id, year, Bektemir, Chilonzor, Yakkasaroy into Population_Each_City FROM City_Population 
PIVOT(
SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
)
as NewPivot 
--19. Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT CustomerID, SUM(TotalAmount) as TotalSpent FROM Invoices
where totalAmount in (SELECT DISTINCT TOP 3 SUM(TotalAmount) as TotalSpent  FROM Invoices
GROUP BY CustomerID  
ORDER BY SUM(TotalAmount) desc)
GROUP BY CustomerID
order by TotalSpent desc
--20. Transform Population_Each_Year table to its original format (City_Population).
SELECT district_id, district_name, population, year FROM 
(SELECT district_id, district_name, [2012], [2013] FROM Population_Each_Year) AS t1
UNPIVOT(
year FOR population in ([2012],[2013])) as city_population_unpivot
--21. Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT t1.ProductName, COUNT(T2.SaleID) as soldTimes FROM 
(SELECT ProductID, ProductName FROM Products) as T1 INNER JOIN 
(SELECT SaleID, ProductID FROM Sales) as T2 on t1.ProductID=t2.ProductID
GROUP BY t1.ProductName;
--22. Transform Population_Each_City table to its original format (City_Population).
SELECT district_id, district_name, population, year FROM (
SELECT district_id, year, Bektemir, Chilonzor, Yakkasaroy FROM Population_Each_City) AS T1 
UNPIVOT(
population FOR district_name in(Bektemir, Chilonzor, Yakkasaroy)
) as city_populationUnpivot
