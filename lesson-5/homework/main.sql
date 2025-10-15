-- 1. Rename ProductName column as Name
SELECT ProductName AS Name
FROM Products;

-- 2. Rename Customers table as Client
SELECT *
FROM Customers AS Client;

-- 3. UNION products and discounted products
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. INTERSECT Products and Products_Discounted
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 5. Distinct customer names with country
SELECT DISTINCT FirstName, LastName, Country
FROM Customers;

-- 6. CASE column for Price (High/Low)
SELECT ProductName, Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

-- 7. IIF StockQuantity > 100 (Yes/No)
SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS StockStatus
FROM Products_Discounted;


-- 8. UNION products and discounted products (same as #3)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 9. EXCEPT difference between Products and Discounted
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

-- 10. IIF Expensive or Affordable
SELECT ProductName, Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceTag
FROM Products;

-- 11. Employees Age < 25 OR Salary > 60000
SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000;

-- 12. Update salary +10% for HR dept or EmployeeID=5
UPDATE Employees
SET Salary = Salary * 1.1
WHERE DepartmentName = 'HR' OR EmployeeID = 5;


-- 13. CASE SaleAmount Tier classification
SELECT SaleID, CustomerID, SaleAmount,
       CASE 
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SaleCategory
FROM Sales;

-- 14. EXCEPT customers who placed orders but not in Sales
SELECT DISTINCT CustomerID
FROM Orders
EXCEPT
SELECT DISTINCT CustomerID
FROM Sales;

-- 15. CASE Discount based on Quantity
SELECT CustomerID, Quantity,
       CASE 
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;
