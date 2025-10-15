-------------------------------------------
-- LESSON 8 PRACTICE SOLUTIONS (SQL SERVER)
-------------------------------------------

-- 1. Total number of products available in each category
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- 2. Average price of products in the 'Electronics' category
SELECT AVG(Price) AS AvgElectronicsPrice
FROM Products
WHERE Category = 'Electronics';

-- 3. List all customers from cities that start with 'L'
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Get all product names that end with 'er'
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. List all customers from countries ending in 'A'
SELECT *
FROM Customers
WHERE Country LIKE '%A';

-- 6. Show the highest price among all products
SELECT MAX(Price) AS HighestPrice
FROM Products;

-- 7. Label stock as 'Low Stock' if quantity < 30, else 'Sufficient'
SELECT ProductName,
       StockQuantity,
       CASE
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Find the total number of customers in each country
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

-- 9. Find the minimum and maximum quantity ordered
SELECT MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders;


-----------------------------
-- MEDIUM-LEVEL TASKS
-----------------------------

-- 10. Customer IDs who placed orders in Jan 2023 but did not have invoices
SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
      AND o.CustomerID NOT IN (
          SELECT CustomerID FROM Invoices WHERE YEAR(InvoiceDate) = 2023 AND MONTH(InvoiceDate) = 1
      );

-- 11. Combine all product names from Products and Products_Discounted including duplicates
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 12. Combine all product names from Products and Products_Discounted without duplicates
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 13. Find average order amount by year
SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;

-- 14. Group products based on price
SELECT ProductName,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 15. Pivot City_Population to show [2012], [2013] columns and copy results
SELECT * INTO Population_Each_Year
FROM (
    SELECT City, Year, Population FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population) FOR Year IN ([2012], [2013])
) AS PivotTable;

-- 16. Find total sales per product Id
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

-- 17. Find products that contain 'oo' in the name
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

-- 18. Pivot City_Population by city
SELECT * INTO Population_Each_City
FROM (
    SELECT City, Year, Population FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population) FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;


-----------------------------
-- HARD-LEVEL TASKS
-----------------------------

-- 19. Top 3 customers with highest total invoice amount
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 20. Transform Population_Each_Year back to City_Population
SELECT City, '2012' AS Year, [2012] AS Population FROM Population_Each_Year
UNION ALL
SELECT City, '2013', [2013] FROM Population_Each_Year;

-- 21. List product names and number of times each has been sold
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TimesSold DESC;

-- 22. Transform Population_Each_City back to City_Population
SELECT 'Bektemir' AS City, Year, [Bektemir] AS Population FROM Population_Each_City
UNION ALL
SELECT 'Chilonzor', Year, [Chilonzor] FROM Population_Each_City
UNION ALL
SELECT 'Yakkasaroy', Year, [Yakkasaroy] FROM Population_Each_City;
